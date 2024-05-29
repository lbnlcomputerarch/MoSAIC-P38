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

#define FP_END   0x00000200
#define ALL_FP_ACC //pico_spad_fp.pl

/*
#define PKT_IN_CODE 2  //-   2,  3,  4,   5,  6,  7,    8
#define PKT_IN_SZ   4  //-   4,  8, 16,  32, 64, 128, 256
*/

#define MQ_SZ             512     //- Set by MoSAIC
#define OP_PER_GROUP (MQ_SZ/2)

#define FP_N_T            1000 
#define PKT_IN_CODE 0x00000005  //- **Code that defines the packet size 
#define PKT_IN_SZ           32  //- **FP input packet size 

#define FP_N       (FP_N_T/PICO_N)
#define OP_PER_PKT (PKT_IN_SZ/4) //- Number of operations per packet 
#define PKT_OUT_SZ (PKT_IN_SZ/2) //- FP output packet size
#if (FP_N < OP_PER_GROUP) //- Not to pack the MQ buffer
   #define GROUP_N 1
   #if (FP_N < OP_PER_PKT)
   #else
      #define PKT_N FP_N/OP_PER_PKT
   #endif
#else
   #define GROUP_N (FP_N/OP_PER_GROUP)
   #define PKT_N   (OP_PER_GROUP/OP_PER_PKT)
#endif

#define IN_ARRAY_SZ 4096


volatile uint32_t fp_input[4096] __attribute__ ((section(".myspad_in"))); //- Input data

volatile uint32_t check_in_group[3840] __attribute__ ((section(".myspad_gl"))); //- Screen
volatile uint32_t gl_cyc_add_h_i[END_TILE] __attribute__ ((section(".myspad_gl")));
volatile uint32_t gl_cyc_add_l_i[END_TILE] __attribute__ ((section(".myspad_gl")));
volatile uint32_t gl_cyc_add_h_f[END_TILE] __attribute__ ((section(".myspad_gl")));
volatile uint32_t gl_cyc_add_l_f[END_TILE] __attribute__ ((section(".myspad_gl")));

volatile uint32_t fp_results[1800]; // (256*4)+2

//- Helper functions
uint64_t double2hex(double d)
{
  uint64_t res;
  memcpy(&res, &d, sizeof(d));
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
   uint32_t pkt_code, pkt_sz;
   volatile double op1;

   uint32_t fp_addr; 
   uint32_t mem_addr_i = (uint32_t) &fp_input;
   mem_addr_i = mem_addr_i >> 2;
   int out_addr = 0;
   int mem_addr = mem_addr_i;
   uint32_t qpoll_flag = 0;

   //- For counters
   volatile uint32_t cyci_h;
   volatile uint32_t cyci_l;
   volatile uint32_t cyc_h;
   volatile uint32_t cyc_l;

   //- Parse Options
   tidh = atoi(argv[1]);

   uint32_t tidh_s = tidh << 8;
   uint32_t dbg_1 = 0xBEEF0000 | tidh_s; //- Start
   uint32_t dbg_2 = 0xCACA0000 | tidh_s; //- Start
   uint32_t dbg_3 = 0xC0CA0000 | tidh_s; //- Middle
   uint32_t dbg_4 = 0xBECA0000 | tidh_s; //- End

   uint32_t check_in_addr = (uint32_t) &check_in_group[tidh*64];
   check_in_addr = check_in_addr >> 2;

   /*
   int middle =  END_TILE/2;
   if (tidh < middle){
      fp_addr = FP_ADD1 | FP_END | tidh;
   }else{
      fp_addr = FP_ADD17 | FP_END | tidh;
   }
   */
#ifdef ALL_FP_ACC
   fp_addr = FP_ADD10 | FP_END | tidh;
#else
   fp_addr = FP_ADD9 | FP_END | tidh;
#endif

   info = 0x55550000 | tidh;
   mPut(info,check_in_addr);
   check_in_addr = check_in_addr + 1; //+1
   
   //- Generate the data for testcase
   
   if (tidh == 0){
      uint32_t in_addr = (uint32_t) &fp_input;
      in_addr = in_addr >> 2;
      op1 = 0.5687;
      int end;
      for (int i=0; i<IN_ARRAY_SZ; i=i+1){ //- Set this to only 5 it for faster sim
      //for (int i=0; i<5; i=i+1){ //- Set this to only 5 it for faster sim
         mPutH(in_addr,1);
         mPutD_w(op1);
         op1 = op1 + 0.0356;
         in_addr = in_addr + 2;
      }
   }
   

   //- For synchronization
   //- If I am the last PICO send 
   //  an empty message to the first PICO
   uint32_t next;
   if (ROW<4){ //- FIXME: Assume ROW=COL
      if (tidh == 17){
         qPut(0,0);
      }
   }else{
      if (tidh == END_TILE - 1){
         qPut(0,0);
      }
   }
   
   next = tidh + 1;

   //- Except that
   for (int c=0; c<COL; c=c+1){
      int id = (ROW + c*8) - 1;
      if (tidh == id){
#ifdef ALL_FP_ACC
         if (c==0) {
            if (ROW<6){
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


   //- If I am the last PICO don't send anything
   if (ROW<4){ //- FIXME: Assume ROW=COL
      if (tidh < 17){ 
         qPut(next,0); //+2
      }
   }else{
      if (tidh < END_TILE-1){ 
         qPut(next,0); 
      }
   }
   
   qGet(temp,header1);
   qGet(temp,data1);
 
   uint32_t pkt_ctr;
    
   //- Send the FP request
   fp_results[out_addr] = 0xBEEFBEEF;
   asm("rdcycleh %0; rdcycle %1;":"=r"(cyci_h), "=r"(cyci_l):);
   for (uint32_t j=0; j<GROUP_N; j=j+1){
      out_addr = j+1;
      pkt_ctr = 0;

      info = dbg_1 | j; //- Debug beef
      mPut(info,check_in_addr);
      check_in_addr = check_in_addr + 1; //+3

      fp_results[out_addr] = info;
      out_addr = out_addr + 1;

      for (int i=0; i<PKT_N; i=i+1){
         //- Send request
         mGetH(mem_addr, PKT_IN_CODE); //-+PKT_N
         mGetD(fp_addr,0);
         //- If sthg in the queue get it
         qPoll(temp, qpoll_flag);
         if (qpoll_flag != 1){
            qGet(temp, fp_results[out_addr]); //- Header1
            out_addr = out_addr + 1;
            qGet(temp, fp_results[out_addr]); //- Header2
            out_addr = out_addr + 1;
            for (int k=0; k<PKT_OUT_SZ; k=k+1){
               qGet(temp, fp_results[out_addr]); //- Data
               out_addr = out_addr + 1;
            }
            pkt_ctr = pkt_ctr + 1;
         }
         //- Increase input address;
         if (mem_addr > IN_ARRAY_SZ - PKT_IN_SZ){
            mem_addr = mem_addr_i;
         }else{
            mem_addr = mem_addr + PKT_IN_SZ;
         }
      }

      info = dbg_2 | pkt_ctr; //caca
      mPut(info,check_in_addr); //+4
      check_in_addr = check_in_addr + 1;

      while (pkt_ctr < PKT_N){
         qWait(temp,header1);
         qGet(temp, fp_results[out_addr]); //- Header1
         out_addr = out_addr + 1;
         qGet(temp, fp_results[out_addr]); //- Header2
         out_addr = out_addr + 1;
         for (int k=0; k<PKT_OUT_SZ; k=k+1){
            qGet(temp, fp_results[out_addr]); //- Data
            out_addr = out_addr + 1;
         }
         pkt_ctr = pkt_ctr + 1;
      }

      info = dbg_3 | pkt_ctr; //c0ca
      mPut(info,check_in_addr); //+5
      check_in_addr = check_in_addr + 1;
      
   }
   //- Write the clock cycles to memory
   asm("rdcycleh %0; rdcycle %1;":"=r"(cyc_h), "=r"(cyc_l):);
   gl_cyc_add_h_i[tidh] = cyci_h; //-7
   gl_cyc_add_l_i[tidh] = cyci_l; //-8
   gl_cyc_add_h_f[tidh] = cyc_h;  //-9
   gl_cyc_add_l_f[tidh] = cyc_l;  //-10
   
   //- Finish
   fp_results[out_addr] = 0xdeadbeef;
   mPut(dbg_4,check_in_addr); //+6

}

