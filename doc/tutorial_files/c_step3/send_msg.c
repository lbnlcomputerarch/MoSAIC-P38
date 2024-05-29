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

// Tile-ID (y,x)
//   pico // spad // acc1
//   loop // pico // acc2

//   000-000 6'h0 // 001-000 6'h8 // 010-000 6'h10 6'd16
//   000-001 6'h1 // 001-001 6'h9 // 010-001 6'h11 6'd17

/* these variables belong to the acc1 memory space*/
uint32_t data1_acc1 __attribute__ ((section(".myacc1")));
uint32_t data2_acc1 __attribute__ ((section(".myacc1")));

void main (int argc, char *argv[]){

  /* Get the tile id */
  int tile_id = atoi(argv[1]);

  int dest_tile;

  /* Ballon */
  uint32_t ball;
  
  int temp;

  if (tile_id == 0) {
    /* start */
    qPut(9, 1);  // qPut(dest, data)
  }
  
  /* Wait for the ball */
  qWait(0,temp);

  /* Get the ball and pass it*/
  w_qGet(0,&ball);

  /* Set the neighboor */
  if (tile_id == 0)      {dest_tile = 9;}
  else if (tile_id == 9) {dest_tile = 0;}

  /* Send it to the neighbor */
  qPut(dest_tile,ball+1);


  /* *******************************
   * Send data to the accelerator 
   * ********************************/

  dest_tile = 16; // acc1 tile_id

  /* QPUT
   * Example for a short packet */
  qPut(dest_tile, 0xcafecafe);

  /* QPUT 
   * Example for a long packet */
  qPutH(dest_tile,3); // qPutH(dest, pkt_size), 2^3=8 words in the payload
  uint32_t data1 = 0xcafecafe;
  uint32_t data2 = 0xbacabaca;
  for (int i=0; i<4; i=i+1){
    qPutD(data1, data2);
    data1 = data1 + 1;
    data2 = data2 + 1;
  }

  /* Unblocking MPUT */
  if      (tile_id == 0) {data1 = 0x0000beef;}
  else if (tile_id == 9) {data1 = 0x0000f0ca;}
  w1_mPut(data1, dest_tile, 1024); //w1_mPut(data, dest_tile_id, offset);

  /* Unblocking MPUT */
  if      (tile_id == 0) {data1 = 0xbeef0000;}
  else if (tile_id == 9) {data1 = 0xf0ca0000;}
  w2_mPut(data1,&data2_acc1);  //w2_mPut(data, address-of(destination-variable));

  /* Blocking STORE */
  if      (tile_id == 0) {data1 = 0xbeefbeef;}
  else if (tile_id == 9) {data1 = 0xf0caf0ca;}
  data1_acc1 = 0xbeefbeef;

}



