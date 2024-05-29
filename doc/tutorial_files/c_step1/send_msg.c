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

// Tile-ID (y,x)
//   pico // pico
//   pico // pico

//   000-000 6'h0 // 001-000 6'h8
//   000-001 6'h1 // 001-001 6'h9
#ifndef TILE_N
   #define TILE_N 16
#endif

void main (int argc, char *argv[]){

  /* Get the tile id */
  int tile_id = atoi(argv[1]);

  /* Destination tile id */
  int dest_tile;

  /* Ballon */
  uint32_t ball;

  /* to capture unused variables*/
  int temp;

  /* If this is tile (0,0) send the first msg */ 
  if (tile_id == 0) {
    /* start */
    qPut(1, 1);  // qPut(dest, data)
  }
  
  /* Wait for the ball */
  qWait(0,temp);

  /* Get the ball and pass it*/
  w_qGet(0,&ball);

  /* Set the neighbor */
   if (TILE_N == 4){
      if (tile_id == 0)      {dest_tile = 1;}
      else if (tile_id == 1) {dest_tile = 8;} 
      else if (tile_id == 8) {dest_tile = 0;} //- 9 is spad
   }else if (TILE_N == 16){
      if (tile_id == 0)      {dest_tile = 1;}
      else if (tile_id == 1) {dest_tile = 2;}
      else if (tile_id == 2) {dest_tile = 3;}
      else if (tile_id == 3) {dest_tile = 8;}
      else if (tile_id == 8) {dest_tile = 9;}
      else if (tile_id == 9) {dest_tile = 10;}
      else if (tile_id == 10) {dest_tile = 11;}
      else if (tile_id == 11) {dest_tile = 16;}
      else if (tile_id == 16) {dest_tile = 17;}
      else if (tile_id == 17) {dest_tile = 18;}
      else if (tile_id == 18) {dest_tile = 19;}
      else if (tile_id == 19) {dest_tile = 24;}
      else if (tile_id == 24) {dest_tile = 25;}
      else if (tile_id == 25) {dest_tile = 26;}
      else if (tile_id == 26) {dest_tile = 0;} //- 27 is spad
   }

  /* Send it to the neighbor */
  qPut(dest_tile,ball+1);

}

