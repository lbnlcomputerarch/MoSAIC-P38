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

#include <stdlib.h>
#include "mq.h"
#include "wrapper_mq.h"
#include "input_defines.h"
#include "macgyver.h"

///////////////////////////////////// 
//    Tile-ID (y,x) example 2x2    //
//   pico || pico                  //
//   pico || pico                  // 
//   000-000 6'h0 || 001-000 6'h8  //
//   000-001 6'h1 || 001-001 6'h9  //
/////////////////////////////////////

#ifndef TILE_N
   #define TILE_N 16
#endif

/* these variables belong to the spad memory space*/
uint32_t end_exec[192] __attribute__ ((section(".myspad")));  

void main (int argc, char *argv[]){

  /* Get the tile id */
  int tile_id = atoi(argv[1]);

  /* Destination tile id */
  int dest_tile;

  /* Ballon */
  uint32_t ball;

  /* to capture unused variables*/
  int temp;

   /* If this is the last tile send the first msg */ 
   if (tile_id == 8 | tile_id == 26) {
      qPut(0, 5); // qPut(dest, data)
   }  

  /* Wait for the ball */
  qWait(0,temp);

  /* Get the ball and pass it*/
  w_qGet(0,&ball);

  /* Set the neighbor */
   if (TILE_N == 4) {
      if      (tile_id == 1)  {dest_tile = 9;}  //- 8 is spad
      else if (tile_id == 9)  {dest_tile = 0;} 
      else                    {dest_tile = tile_id + 1;}
   }else if (TILE_N == 16) {
      if      (tile_id == 3)  {dest_tile = 9;} //- 8 is spad
      else if (tile_id == 11) {dest_tile = 16;}
      else if (tile_id == 19) {dest_tile = 24;}
      else if (tile_id == 27) {dest_tile = 0;} 
      else                    {dest_tile = tile_id + 1;}
   }

   /* Send it to the neighbor */
   qPut(dest_tile,ball+1);

   uint32_t addr = (uint32_t) &end_exec[tile_id*20];
   addr = addr >> 2;
   
   temp = 0xf0ca0000 | tile_id;
   mPut(temp, addr);  
   addr = addr + 1;
   temp = 0xcafe0000 | ball;
   mPut(temp, addr);  
   addr = addr + 1;
   temp = 0xbeef0000 | dest_tile;
   for (int i=0; i<18; i++) {
      mPut(temp, addr);  
      temp = temp + 1;
      addr = addr + 1;
   }

}

