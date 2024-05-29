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
   uint32_t firmwareCheck[nRows][nCols];
   uint32_t coordinatesCheck[nRows][nCols];
   uint32_t resetCheck[nRows][nCols];

   uint32_t data;

   pcimem_device_open();
   printf ("\n");

   ////////////////////////////////////
   //- 3) Reset the PICORV and others
   ////////////////////////////////////
  
   printf ("FIRST set rvControl to zero (reset pico) \n");

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         resetCheck[j][i] = 0;
      }
   }

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         resetCheck[j][i] = rvSetStatus(tileAddresses[j][i], 0x00);
      }
      printf("\n");
   }

   //- Spad8
   int j=0;
   int i=1;
   resetCheck[j][i] = rvSetStatus(tileAddresses[j][i], 0x01);
   printf("\n");
   
   //- Spad18
   j=2;
   i=2;
   resetCheck[j][i] = rvSetStatus(tileAddresses[j][i], 0x01);
   printf("\n");

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         printf("\t\t%d", resetCheck[j][i]);
      }
      printf("\n");
   }


  ////////////////////////////////
  //- 1) LOAD FIRMWARE
  ////////////////////////////////

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         firmwareCheck[j][i] = 0;
         printf("Loading firmware for tile r%d, c%d\n", j,i);
         firmwareCheck[j][i] = rvLoadFirmware(tileAddresses[j][i], file_name[j][i]);
         data = indirect_read(tileAddresses[j][i],0);
         printf("Data that came back from the memory: %08x\n", data);
      }
      printf("\n");
   }

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         printf("\t\t%d", firmwareCheck[j][i]);
      }
      printf("\n");
   }

   ////////////////////////////////////
   //- 2) Initialize Tile Coordinates
   ////////////////////////////////////

   printf ("COORDINATES INIT \n");
  
   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         pcimem_device_write(tileBase+tileAddresses[j][i]+coordinatesRegister, coordinates[j][i]);
      }
      printf("\n");
   }

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         coordinatesCheck[j][i] = pcimem_device_read(tileBase+tileAddresses[j][i]+coordinatesRegister, &data);
      }
      printf("\n");
   }

   printf ("READING COORDINATES \n");

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         printf("\t\t%d", coordinatesCheck[j][i]);
      }
      printf("\n");
   }


   ////////////////////////////////
   //- 3) Set the PICORV
   ////////////////////////////////
  
   printf ("THEN SET PICO \n");
   
   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         resetCheck[j][i] = rvSetStatus(tileAddresses[j][i], 0x01);
         //printf("\t\t%d", resetCheck[j][i]);
      }
      printf("\n");
   }

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         printf("\t\t%d", resetCheck[j][i]);
      }
      printf("\n");
   }


   sleep(4);

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


