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


/* these variables belong to the acc1 memory space*/
#define N 1024
#define SZ ((N*5)+2)

void main (int argc, char *argv[]){

   /* Get the tile id */
   int tile_id = atoi(argv[1]);

   // int dest_tile;

   int inp_spad_1;
   int inp_spad_2;

   int inp_offst;

   inp_offst = 0;
   inp_spad_1 = 1 << 12;
   inp_spad_2 = 2 << 12;


   qPut(8, 0x80000000);
   qPut(17,0x80000000);

   for(int j = 0; j < 512;j=j+1){
     mGetH(inp_spad_1 + inp_offst, 3);
     mGetD(8 << 12,0);
     inp_offst = inp_offst + 8;

   }
   inp_offst = 0;
   for(int j = 0; j < 512;j=j+1){
     mGetH(inp_spad_2 + inp_offst, 3);
     mGetD(8 << 12,0);
     inp_offst = inp_offst + 8;
   }

}

