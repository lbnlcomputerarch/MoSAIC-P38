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

void w_mPut(uint32_t data){
   uint32_t address = (uint32_t) &fp_results[spad_address];
   address = address >> 2;
   mPut(data, address);
   spad_address = spad_address + 1;
}

void w_mPutH(uint32_t data, uint32_t sz){
   uint32_t address = (uint32_t) &fp_results[spad_address];
   address = address >> 2;
   mPutH(address,data);
   spad_address = spad_address + sz;
}


void send_mq(){
   uint32_t temp, header1, header2, data1, data2;
   uint32_t pkt_code, pkt_sz;

   qWait(temp, header1);

   //- Get data from the queue
   qGet(temp, header1);
   qGet(temp, header2);

   //- Write data to spad
   //  Assumes only long packets
   //  Extract packet size
   pkt_code = header1 & 0x00000F00;
   pkt_code = pkt_code >> 8;

   //mPut(pkt_code, spad_address);
   //spad_address = spad_address + 1;

   w_mPut(pkt_code);

   if    (pkt_code == 1) pkt_sz =  2;
   else if (pkt_code==2) pkt_sz =  4;
   else if (pkt_code==3) pkt_sz =  8;
   else if (pkt_code==4) pkt_sz = 16;
   
   w_mPut(pkt_sz);
   //mPut(pkt_sz,spad_address);
   //spad_address = spad_address + 1;

   //mPutH(spad_address, pkt_code);
   w_mPutH(pkt_code, pkt_sz);
   for (int i=0; i<pkt_sz/2; i=i+1){
      qGet(temp, data1);
      qGet(temp, data2);
      mPutD(data1, data2);
   }

   //spad_address = spad_address + pkt_sz + 1;
}

uint64_t double2hex(double d)
{
  uint64_t res;
  memcpy(&res, &d, sizeof(d));
  return res;
}

double hex2double(uint64_t d)
{
  double res;
  memcpy(&res, &d, sizeof(d));
  return res;
}

void mPutD_w (double d)
{
   uint64_t op_t = double2hex(d);
   uint32_t temp1 = (uint32_t) op_t;
   uint64_t temp2 = op_t >> 32;
   uint32_t temp3 = (uint32_t) temp2;
   mPutD(temp1,temp3);
}

void send_double(double d){
   uint32_t address = (uint32_t) &fp_results[spad_address];
   address = address >> 2;
   mPutH(address,1);
   mPutD_w(d);
   spad_address = spad_address + 2;
}

#ifdef SANITY_CHECK
uint32_t wr_mem (uint32_t destination_tile_id, uint32_t local_tile_id, uint32_t it)
{

   uint32_t data1  = 0xCAFECAFE; 
   uint32_t data2  = 0xF00DF00D;
   
	for (int i=0; i<it; i++){
      //- Message based MPUT
      uint32_t address = (uint32_t) &test_mem_spad1[local_tile_id*IT+i];
      address = address >> 2;
      mPut(data1, address); 
      //- STORE
      test_mem_spad[local_tile_id*IT+i]=data2;
	   data1++;
	   data2++;
   }
}

/* 
	Function used to read from a remote tile <it> times
	Reads <it> using MGET
   Reads <it> using LOAD
*/
uint32_t rd_mem (uint32_t destination_tile_id, uint32_t local_tile_id, uint32_t it)
{

   for (int i=0; i<it; i++){
      //- Message based MGET
      uint32_t remote_mem_address1 = (uint32_t) &test_mem_spad1[local_tile_id*IT+i];
      remote_mem_address1 = remote_mem_address1 >> 2;
      uint32_t local_mem_address1 = (uint32_t) &test_mem_local1[i];
      local_mem_address1 = local_mem_address1 >> 2;
      mGet(remote_mem_address1, local_mem_address1);
		//- LOAD
      test_mem_local[i] = test_mem_spad[local_tile_id*IT+i];
   }
}
#endif
