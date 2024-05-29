

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

   local_tile_id_s       = local_tile_id << 12;   //- For hardware
   destination_tile_id_s = destination_tile_id << 12;   //- For hardware

	mem_location         = 1024 + (local_tile_id*180);
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
   remote_mem_address1  = mem_location+destination_tile_id_s; // Real memory location
	
	mem_location         = 1024 + (destination_tile_id*180);
   local_mem_address1   = local_mem_location1+local_tile_id_s; // Real memory location
   
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

