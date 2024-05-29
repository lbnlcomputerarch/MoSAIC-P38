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

/* ////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : April 19 2022
// Description : Pico in tile 00 writes to scratchpad in tile 01 and 
//               DDR manager  
// File        : pico_scratchpad_ddr4_4x4.c
// Notes       : Modified from the 2x2 to serve the 4x4
// ///////////////////////////////////////////////////////////////*/

#include "mq.h"
#include "remote_wr.h" 
#include <stdlib.h>
#include <string.h>

uint32_t main (int argc, char *argv[])
{
   //- Declare variables
   uint32_t local_tile_id;
   uint32_t remote_tile_id;
	uint32_t it = 16; 

   //- Parse Options
   local_tile_id = atoi(argv[1]);


	//- Keep scratchpad code for sanity
	//- Write and Read Scratchpad
	remote_tile_id = 8;
	wr_mem(remote_tile_id, local_tile_id, it, 1);
	rd_mem(remote_tile_id, local_tile_id, it, 1);

	//- Write and Read memory tile
	remote_tile_id = 4;
	wr_mem(remote_tile_id, local_tile_id, it, 1);
	rd_mem(remote_tile_id, local_tile_id, it, 1);


  return 1;
}

//  Row 0
//   000-000 'h00 'd0
//   001-000 'h08 'd8
//   010-000 'h10 'd16
//   011-000 'h18 'd24
// Row 1
//   000-001 'h01 'd1
//   001-001 'h09 'd9
//   010-001 'h11 'd17
//   011-001 'h19 'd25
// ...
// Memory manager
//   000-100 'h04  'd4  

