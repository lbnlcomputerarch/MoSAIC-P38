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

   //uint32_t firmwareCheck_mem;
   uint32_t coordinatesCheck_mem;
   uint32_t packetRxCount_mem;

   uint32_t data;

   pcimem_device_open();
   printf ("\n");

   ////////////////////////////////
   //- 3) Reset the PICORV
   ////////////////////////////////
  
   printf ("FIRST RESET PICO \n");
   
   //- Pico 00
   printf("Pico 00\n");
   resetCheck[0][0] = rvSetStatus(tileAddresses[0][0], 0x00);
   printf("\n");

   //- Spad
   printf("Spad 10\n");
   resetCheck[0][1] = rvSetStatus(tileAddresses[0][1], 0x00);
   printf("\n");
   resetCheck[0][1] = rvSetStatus(tileAddresses[0][1], 0x01);
   printf("\n");

   //- Loop
   printf("Loop 01\n");
   resetCheck[1][0] = rvSetStatus(tileAddresses[1][0], 0x00);
   printf("\n");

   //- Pico
   printf("Pico 11\n");
   resetCheck[1][1] = rvSetStatus(tileAddresses[1][0], 0x00);
   printf("\n");

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         printf("\t\t%d", resetCheck[j][i]);
         resetCheck[j][i] = 0;
      }
      printf("\n");
   }

  ////////////////////////////////
  //- 1) LOAD FIRMWARE
  ////////////////////////////////

   printf("Pico 00\n");
   firmwareCheck[0][0] = rvLoadFirmware(tileAddresses[0][0], file_name[0][0]);
   data = indirect_read(tileAddresses[0][0],0);
   printf("Data that came back from the memory: %08x\n", data);

   printf("Spad 10\n");
   firmwareCheck[0][1] = rvLoadFirmware(tileAddresses[0][1], file_name[0][1]);
   data = indirect_read(tileAddresses[0][1],0);
   printf("Data that came back from the memory: %08x\n", data);

   printf("Pico 11\n");
   firmwareCheck[1][1] = rvLoadFirmware(tileAddresses[1][1], file_name[1][1]);
   data = indirect_read(tileAddresses[1][1],0);
   printf("Data that came back from the memory: %08x\n", data);

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         printf("\t\t%d", firmwareCheck[j][i]);
      }
      printf("\n");
   }


   ////////////////////////////////
   //- 2) Initialize Tile Coordinates
   ////////////////////////////////

   printf ("COORDINATES INIT \n");
  
   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         pcimem_device_write(tileBase+tileAddresses[j][i]+coordinatesRegister, coordinates[j][i]);
      }
      printf("\n");
   }

   pcimem_device_write(tileBase+tileAddress_mem+coordinatesRegister, coordinates_mem);

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         coordinatesCheck[j][i] = pcimem_device_read(tileBase+tileAddresses[j][i]+coordinatesRegister, &data);
      }
      printf("\n");
   }

   coordinatesCheck_mem = pcimem_device_read(tileBase+tileAddress_mem+coordinatesRegister, &data);

   printf ("READING COORDINATES \n");

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         printf("\t\t%d", coordinatesCheck[j][i]);
      }
      printf("\n");
   }

   printf("\t\t%d", coordinatesCheck_mem);
   printf("\n");

   ////////////////////////////////
   //- 3) Reset the PICORV
   ////////////////////////////////
  
   printf ("THEN SET PICO \n");
  
   //- Only one pico -//
   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         resetCheck[j][i] = rvSetStatus(tileAddresses[j][i], 0x01);
      }
      printf("\n");
   }

   for (int j=0; j<nRows; j++) {
      for (int i=0; i<nCols; i++) {
         printf("\t\t%d", resetCheck[j][i]);
      }
      printf("\n");
   }

   sleep(2);

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


