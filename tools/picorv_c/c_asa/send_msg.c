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

#define N 16
#define SZ ((N*5)+2)

void main (int argc, char *argv[]){

   // Get the tile id
   int tile_id = atoi(argv[1]);

   // Send message to ASA
   int dest_tile;
   dest_tile = 9; // << 12;
   qPutH(dest_tile,2);
   qPutD(0x0,0x19);
   qPutD(0xe,0xf);

}

// Sends
// Header, Filler, inst (4bits),  key, upper data, lower data, filler

// Receives
// header, address h, address l, key h, key l, data h, data l, dummy, dummy
