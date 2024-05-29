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

   //- Read Scratchpad -//

   int j=1;
   int i=1;
   printf("NOW READING Data from scratchpad\n"); 
   for (int k=0; k<200; k=k+1) {
     data = indirect_read(tileAddresses[j][i],k);
     printf("Data that came back from the memory: %08x\n", data);
   }
   printf ("\n");

   //- Read  pico memory-//
   /*
   j=0;
   i=0;
   printf("NOW READING Data from Pico\n"); 
   for (int k=0; k<300; k=k+1) {
     data = indirect_read(tileAddresses[j][i],k);
     printf("Data that came back from the memory: %08x\n", data);
   }
   printf ("\n");
   */

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

   packetRxCount_mem = pcimem_device_read(tileBase+tileAddress_mem+packetRxCountRegister, &data);

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         printf("\t\t%d", packetRxCount[j][i]);
      }
      printf("\n");
   }

   printf("\t\t%d", packetRxCount_mem);
   printf("\n");

   printf("\n");
   pcimem_device_close();
   printf("\n");

   return 0;

}
    

