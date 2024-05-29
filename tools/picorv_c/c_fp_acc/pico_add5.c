// *************************************************************************
// 
// *** Copyright Notice ***
//
// P38 heterogeneous multi-tiled system with support for message queues 
// (MoSAIC) Copyright (c) 2024, The Regents of the University of California, 
// through Lawrence Berkeley National Laboratory (subject to receipt of
// any required approvals from the U.S. Dept. of Energy). All rights reserved.
// 
// If you have questions about your rights to use or distribute this software,
// please contact Berkeley Lab's Intellectual Property Office at
// IPO@lbl.gov.
//
// NOTICE.  This Software was developed under funding from the U.S. Department
// of Energy and the U.S. Government consequently retains certain rights.  As
// such, the U.S. Government has been granted for itself and others acting on
// its behalf a paid-up, nonexclusive, irrevocable, worldwide license in the
// Software to reproduce, distribute copies to the public, prepare derivative 
// works, and perform publicly and display publicly, and to permit others 
// to do so.
//
// *************************************************************************

/* ////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : Nov 27 2023
// Description : Pico writes to adder 
// File        : pico_add.c
// Notes       :
//                - The address for the acc changes with the 
//                  position on the tiles in MoSAIC. ADD, MULT,
//                  DIV, SQRT, ADD_DMA, MAC
// ///////////////////////////////////////////////////////////////*/

#include "mq.h"
#include <stdlib.h>
#include <string.h>
#include "macgyver.h"
#include "mosaic_defines.h"

#define NEW_COL     8 // 
#define NEW_ROW     8 //
#define NEW_END_TILE (NEW_COL*8 + NEW_ROW)
#define NEW_PICO_N 58

#define FP_END   0x00000200
#define ALL_FP_ACC //pico_spad_fp.pl

/*
#define PKT_IN_CODE 2  //-   2,  3,  4,   5,  6,  7,    8
#define PKT_IN_SZ   4  //-   4,  8, 16,  32, 64, 128, 256
*/

#define FP_N_T             464 
#define PKT_IN_CODE 0x00000005  //- **Code that defines the packet size 
#define PKT_IN_SZ           32  //- **FP input packet size 

#define FP_N     (FP_N_T/NEW_PICO_N)
#define OP_PER_PKT (PKT_IN_SZ/4) //- Number of operations per packet 
#define PKT_OUT_SZ (PKT_IN_SZ/2) //- FP output packet size

#define IN_ARRAY_SZ 1143 //- Max memory available
#include "fp_input_add5.h"

volatile uint32_t check_in_group[3840] __attribute__ ((section(".myspad_gl"))); //- Screen
volatile uint32_t gl_cyc_add_h_i[END_TILE] __attribute__ ((section(".myspad_gl")));
volatile uint32_t gl_cyc_add_l_i[END_TILE] __attribute__ ((section(".myspad_gl")));
volatile uint32_t gl_cyc_add_h_f[END_TILE] __attribute__ ((section(".myspad_gl")));
volatile uint32_t gl_cyc_add_l_f[END_TILE] __attribute__ ((section(".myspad_gl")));

volatile double fp_output[IN_ARRAY_SZ];

//- Helper functions
uint64_t double2hex(double d)
{
  uint64_t res;
  memcpy(&res, &d, sizeof(d));
  return res;
}

double hex2double(uint32_t d1, uint32_t d2)
{
  double res;
  uint64_t t2 = (uint64_t) d2;
  uint64_t t1 = (uint64_t) d1;
  t2 = t2 << 32;
  t1 = t1 | t2;
  memcpy(&res, &t1, sizeof(t1));
  return res;
}

void mPutD_w (double d)
{
   uint64_t op_t = double2hex(d);
   uint32_t temp1 = (uint32_t) op_t;
   uint64_t temp2 = op_t >> 32;
   uint32_t temp3 = (uint32_t) temp2;
   mPutD(temp1,temp3);
}

//- Main code
void main (int argc, char *argv[])
{
   //- Variables -//
   uint32_t tidh;
   uint32_t info;
   uint32_t temp, header1, header2, data1, data2;

   uint32_t fp_addr; 
   int out_addr = 0;
   uint32_t qpoll_flag = 0;

   int fp_n_var = FP_N;
   int in_ctr = 0;
   int pkt_ctr;

   //- For counters
   volatile uint32_t cyci_h;
   volatile uint32_t cyci_l;
   volatile uint32_t cyc_h;
   volatile uint32_t cyc_l;

   //- Parse Options
   tidh = atoi(argv[1]);

   uint32_t row_h = tidh & 0x00000007;
   uint32_t col_h = tidh & 0x00000038;

   uint32_t check_in_addr = (uint32_t) &check_in_group[tidh*64];
   check_in_addr = check_in_addr >> 2;

   uint32_t mem_addr_i = (uint32_t) &fp_input;
   mem_addr_i = mem_addr_i >> 2;
   int mem_addr = mem_addr_i;

   info = 0x55550000 | col_h | row_h;
   mPut(info,check_in_addr);
   check_in_addr = check_in_addr + 1; //+1


   col_h = col_h >> 3;

   //- For synchronization
   //- If I am the last PICO send
   //  an empty message to the first PICO  
   if (tidh == END_TILE - 1){
      qPut(0,0);
   }

   if (col_h < NEW_COL & row_h < NEW_ROW){

#ifdef ALL_FP_ACC
      fp_addr = FP_ADD10 | FP_END | tidh;
#else
      fp_addr = FP_ADD9  | FP_END | tidh;
#endif
      
      uint32_t tidh_s = tidh << 8;
      uint32_t dbg_1 = 0xBEEF0000 | tidh_s; //- Start
      uint32_t dbg_2 = 0xCACA0000 | tidh_s; //- Start
      uint32_t dbg_3 = 0xC0CA0000 | tidh_s; //- Middle
      uint32_t dbg_4 = 0xBECA0000 | tidh_s; //- End

      uint32_t next;
      next = tidh + 1;
      //- Except that
      for (int c=0; c<NEW_COL; c=c+1){
         int id = (NEW_ROW + c*8) - 1;
         if (tidh == id){
#ifdef ALL_FP_ACC
            if (c==0) {
               if (NEW_ROW<6){
                  next = 16;
               }else{
                  next = 13;
               }
            }
#else
            if (c==0) {next = 10;}
#endif
            else      {next = (c+1)*8;};
         }
      }
   
#ifdef ALL_FP_ACC
      if (tidh == 17){
         next = 19;
      }
#else
      if (tidh == 0){
         next = 2;
      } else if (tidh == 16){
         next = 18;
      }
#endif

      qWait(temp, header1);

      info = 0x55550000 | next;
      mPut(info,check_in_addr);
      check_in_addr = check_in_addr + 1; //+2

      //- If I am the last PICO don't send anything
#if (NEW_ROW<4)
      if (tidh < 17){ 
         qPut(next,0); //+2
      }
#else
      if (tidh < NEW_END_TILE-1){ 
         qPut(next,0); 
      }
#endif
   
      qGet(temp,header1);
      qGet(temp,data1);
    
      //- Send the FP request
      fp_output[out_addr] = hex2double(0xBEEFBEEF,0xBEEFBEEF); //+3
      out_addr = out_addr + 1;

      asm("rdcycleh %0; rdcycle %1;":"=r"(cyci_h), "=r"(cyci_l):);
   
      while (fp_n_var > 0){
         //- Create fp adder packet request
         mGetH(mem_addr, PKT_IN_CODE); //-+PKT_N
         mGetD(fp_addr,0);

         if (OP_PER_PKT > fp_n_var){
            fp_n_var = 0;   
         }else{
            fp_n_var = fp_n_var - OP_PER_PKT;
         }

         //- Increase input address;
         if (mem_addr > IN_ARRAY_SZ - PKT_IN_SZ){
            mem_addr = mem_addr_i;
         }else{
            mem_addr = mem_addr + PKT_IN_SZ;
         }
      
         //- Check if there is something in the queue 
         qPoll(temp, qpoll_flag);
         if (qpoll_flag != 1){
            qGet(temp, header1); //- Header1
            qGet(temp, header2); //- Header2
#ifdef NO_FAST
            fp_output[out_addr] = hex2double(header1, header2);
            out_addr = out_addr + 1;
#endif
            for (int k=0; k<(PKT_OUT_SZ/2); k=k+1){
               qGet(temp, data1); //- Data
               qGet(temp, data2); //- Data
#ifdef NO_FAST
               fp_output[out_addr] = hex2double(data2, data1);
               out_addr = out_addr + 1;
#endif
               pkt_ctr = pkt_ctr + 1;
            }
         }
      } 

      info = dbg_2 | pkt_ctr; //caca
      mPut(info,check_in_addr); //+4
      check_in_addr = check_in_addr + 1;
   
      while (pkt_ctr < FP_N ){
         qWait(temp,header1);
         qGet(temp, header1); //- Header1
         qGet(temp, header2); //- Header2
#ifdef NOFAST
         fp_output[out_addr] = hex2double(header1, header2);
         out_addr = out_addr + 1;
#endif
         for (int k=0; k<(PKT_OUT_SZ/2); k=k+1){
            qGet(temp, data1); //- Data
            qGet(temp, data2); //- Data
#ifdef NOFAST
            fp_output[out_addr] = hex2double(data2, data1);
            out_addr = out_addr + 1;
#endif
            pkt_ctr = pkt_ctr + 1;
         }
      } 

      info = dbg_3 | pkt_ctr; //c0ca
      mPut(info,check_in_addr); //+5
      check_in_addr = check_in_addr + 1;

      //- Write the clock cycles to memory
      asm("rdcycleh %0; rdcycle %1;":"=r"(cyc_h), "=r"(cyc_l):);
      gl_cyc_add_h_i[tidh] = cyci_h; //-6
      gl_cyc_add_l_i[tidh] = cyci_l; //-7
      gl_cyc_add_h_f[tidh] = cyc_h;  //-8
      gl_cyc_add_l_f[tidh] = cyc_l;  //-9
   
      //- Finish
      fp_output[out_addr] = 0xdeadbeef;
      mPut(dbg_4,check_in_addr); //+10
   }
}

