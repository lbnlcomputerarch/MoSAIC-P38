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
#include <stdint.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "pcimem.h"
#include "wrapper_sv.h"
#include "mosaic_setup.h"

int main() {

   uint32_t packetRxCount[nRows][nCols];
   uint32_t packetRxCount_mem;
   uint32_t data;

   pcimem_device_open();
   printf ("\n");

   //- Read pico -//
   int j=0;
   int i=0;
   printf("NOW READING Data from pico r%d, c%d\n", j,i); 
   for (int k=0; k<4096; k=k+1) {
     data = indirect_read(tileAddresses[j][i],k);
     printf("Data that came back from the memory: %08x\n", data);
   }

   //- Read pico -//
   printf ("Data break\n\n");
   j=7;
   i=7;
   printf("NOW READING Data from pico r%d, c%d\n", j,i); 
   for (int k=0; k<4096; k=k+1) {
     data = indirect_read(tileAddresses[j][i],k);
     printf("Data that came back from the memory: %08x\n", data);
   }

   //- Read Scratchpad -//
   printf ("Data break\n\n");
   j=0;
   i=1;
   printf("NOW READING Data from spad r%d, c%d\n", j,i); 
   for (int k=0; k<4096; k=k+1) {
     data = indirect_read(tileAddresses[j][i],k);
     printf("Data that came back from the memory: %08x\n", data);
   }
  
   printf ("Data break\n\n");
   j=2;
   i=2;
   printf("NOW READING Data from spad r%d, c%d\n", j,i); 
   for (int k=0; k<4096; k=k+1) {
     data = indirect_read(tileAddresses[j][i],k);
     printf("Data that came back from the memory: %08x\n", data);
   } 

   ////////////////////////////////
   //- 4) Read the packet counters
   ////////////////////////////////
  
   printf ("PACKET COUNTERS \n");

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         packetRxCount[j][i] = pcimem_device_read(tileBase+tileAddresses[j][i]+packetRxCountRegister, &data);
      }
      printf("\n");
   }


   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         printf("\t\t%d", packetRxCount[j][i]);
      }
      printf("\n");
   }


   pcimem_device_close();
   printf("\n");

   return 0;

}

/*
   126: 00020000  1152 288 OBJECT  GLOBAL DEFAULT   15 test_mem_spad
    65: 00020480    72 9   OBJECT  GLOBAL DEFAULT   15 gl_cyc_add_h_i
    59: 000204c8    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_add_l_i
   114: 00020510    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_mul_h_i
    84: 00020558    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_mul_l_i
    90: 000205a0    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_div_h_i
    80: 000205e8    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_div_l_i
    88: 00020630    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_sqr_h_i
    94: 000206c0    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_add_h_f
    62: 00020678    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_sqr_l_i
   124: 00020708    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_add_l_f
    64: 00020750    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_mul_h_f
    79: 000207e0    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_div_h_f
    55: 00020798    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_mul_l_f
    63: 00020828    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_div_l_f
    69: 00020870    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_sqr_h_f
   127: 000208b8    72 OBJECT  GLOBAL DEFAULT   15 gl_cyc_sqr_l_f

   130: 00002248     4 OBJECT  GLOBAL DEFAULT    8 op2_i
   131: 0000224c     4 OBJECT  GLOBAL DEFAULT    8 op1_i
    87: 00002238     8 OBJECT  GLOBAL DEFAULT    8 op1
    66: 00002230     8 OBJECT  GLOBAL DEFAULT    8 op2
   109: 00002240     8 OBJECT  GLOBAL DEFAULT    8 op3
    53: 000021f0    64 OBJECT  GLOBAL DEFAULT    8 test_mem_local
    76: 000021c8     4 OBJECT  GLOBAL DEFAULT    7 spad_address

*/
