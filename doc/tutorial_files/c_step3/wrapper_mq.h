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
void w1_mPut(uint32_t data, uint32_t dest_tile, uint32_t offset){
  uint32_t dest;
  dest =  dest_tile << 12;
  dest = dest + offset;
  mPut(data, dest); 
}

void w2_mPut(uint32_t data, uint32_t addr){
  uint32_t offset, tile_id, final_dest;
  offset = addr & 0x00000FFF;
  tile_id = addr & 0xFFFFF000;
  tile_id = tile_id >> 2;
  final_dest = offset+tile_id;
  mPut(data, final_dest);
}

uint32_t w_qGet(uint32_t dest_qid, uint32_t *data){
  uint32_t header;
  uint32_t temp;
  qGet(dest_qid,header);
  qGet(dest_qid,temp);
  *data = temp;
}
