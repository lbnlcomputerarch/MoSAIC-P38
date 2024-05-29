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


uint32_t wr_mem (uint32_t destination_tile_id, uint32_t local_tile_id, uint32_t it, uint32_t addr_inc)
{

   //- Declare variables
   uint32_t destination_tile_id_s;
   uint32_t local_tile_id_s;

   uint32_t mem_location;
   uint32_t remote_mem_location1;
   uint32_t remote_mem_address1;

   uint32_t *testptr; //- Pointer

   uint32_t data1  = 0xCAFECAFE; 
   uint32_t data2  = 0xF00DF00D;

   local_tile_id_s = local_tile_id << 12;   //- For hardware
   destination_tile_id_s = destination_tile_id << 12;   //- For hardware

	mem_location         = 1024 + (local_tile_id*180);
   remote_mem_location1 = mem_location; //+mem_offset_remote;
   remote_mem_address1  = remote_mem_location1+destination_tile_id_s; // Real memory location
   
	for (int i=0; i<it; i++){
      //- Message based MPUT
      mPut(data1, remote_mem_address1); 
      //- STORE
      testptr = (remote_mem_address1 + 90) << 2;
      *testptr = data2;
      //- Increase address and data
      remote_mem_address1 = remote_mem_address1+addr_inc;
	   data1++;
	   data2++;
   }
   remote_mem_address1 = remote_mem_location1+destination_tile_id_s;
}

/* 
	Function used to read from a remote tile <it> times
	Reads <it> using MGET
   Reads <it> using LOAD
*/
uint32_t rd_mem (uint32_t destination_tile_id, uint32_t local_tile_id, uint32_t it, uint32_t addr_inc)
{

   //- Declare variables
   uint32_t destination_tile_id_s;
   uint32_t local_tile_id_s;

   uint32_t mem_location;
   uint32_t remote_mem_location1;
   uint32_t local_mem_location1;
   uint32_t remote_mem_address1;
   uint32_t local_mem_address1;

   uint32_t *testptr; //- Pointer
   uint32_t *testptr1; //- Pointer

   local_tile_id_s = local_tile_id << 12;   //- For hardware
   destination_tile_id_s = destination_tile_id << 12;   //- For hardware

	mem_location         = 1024 + (local_tile_id*180);
   remote_mem_location1 = mem_location; //+mem_offset_remote;
   remote_mem_address1  = remote_mem_location1+destination_tile_id_s; // Real memory location
	
	mem_location         = 1024 + (destination_tile_id*180);
   local_mem_location1  = mem_location; //+mem_offset_local;
   local_mem_address1   = local_mem_location1+local_tile_id_s;         // Real memory location
   
   for (int i=0; i<it; i++){
      //- Message based MGET
      mGet(remote_mem_address1, local_mem_address1);
		//- LOAD
      testptr =  (remote_mem_address1 + 90) << 2;
      testptr1 = (local_mem_address1 + 90) << 2;
      *testptr1 = *testptr;
      //- Increase address and data
      remote_mem_address1 = remote_mem_address1+addr_inc; //- Read the next address in memory
      local_mem_address1++; //- Read the next address in memory
   }
}

