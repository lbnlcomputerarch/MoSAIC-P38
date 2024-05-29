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

void main (){

  uint32_t dest_tile;
  dest_tile = 9;

  uint32_t data1, data2;
  data1 = 0xcafecafe;
  data2 = 0xbacabaca;

  //- Example for a short packet
  qPut(dest_tile, data1);

  uint32_t pkt_sz_code;
  //- Example for a packet with 2 words in the payload
  pkt_sz_code = 1;
  data1 = data1 + 1;
  qPutH(dest_tile,pkt_sz_code);
  qPutD(data1, data2);

  //- Example for a packet with 4 words in the payload
  pkt_sz_code = 2;
  qPutH(dest_tile,pkt_sz_code);

  data1 = data1 + 1;
  data2 = data2 + 1;
  qPutD(data1, data2);

  data1 = data1 + 1;
  data2 = data2 + 1;
  qPutD(data1, data2);

  pkt_sz_code = 3;
  qPutH(dest_tile,pkt_sz_code);
  for (int i=0; i<4; i=i+1){
    data1 = data1 + 1;
    data2 = data2 + 1;
    qPutD(data1, data2);
  }

  pkt_sz_code = 4;
  qPutH(dest_tile,pkt_sz_code);
  for (int i=0; i<8; i=i+1){
    data1 = data1 + 1;
    data2 = data2 + 1;
    qPutD(data1, data2);
  }

  pkt_sz_code = 5;
  qPutH(dest_tile,pkt_sz_code);
  for (int i=0; i<16; i=i+1){
    data1 = data1 + 1;
    data2 = data2 + 1;
    qPutD(data1, data2);
  }




}

//   000-000 0 // 001-000 8
//   000-001 1 // 001-001 9
//
//   pico      // spad
//   loop      // zhw
