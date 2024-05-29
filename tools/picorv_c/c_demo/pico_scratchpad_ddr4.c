/* ////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : Jan 18 2023
// Description : Pico 00 writes to scratchpad in tile 01.
//               Other picos write to DDR  
// File        : pico_scratchpad_ddr4.c
// Notes       : 
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
   if (local_tile_id == 0){
   	remote_tile_id = 8;
	   wr_mem(remote_tile_id, local_tile_id, it, 1);
   	rd_mem(remote_tile_id, local_tile_id, it, 1);
   };

	//- Write and Read memory tile
	remote_tile_id = 7;
	wr_mem(remote_tile_id, local_tile_id, it, 1);
	rd_mem(remote_tile_id, local_tile_id, it, 1);


  return 1;
}
//   000-000 'h0
//   001-000 'h8
//   000-001 'h1
//   001-001 'h9
//   000-010 'h2 

