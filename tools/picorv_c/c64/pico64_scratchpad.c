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
// *************************************************************************

/* ////////////////////////////////////////////////////////////////
// Author      : Farzad Fatollahi-Fard
// Date        : November 9 2026
// Description : pico64 scratchpad test: mPut/remote-STORE then
//               mGet/remote-LOAD with the scratchpad tile
// File        : pico64_scratchpad.c
// Notes       :
// - RV64 twin of the picorv32 pico_scratchpad.c + remote_wr.h flow
//   (testcase mosaic_2x2_pico64_spad.pl, checker check_pico64_spad.sh).
// - Runs on tile 00 (pico64, id 0); the spad is tile 01 (id 8). The
//   spad tile is BW-parameterized and gets BW=NOC_BW=64 from the
//   testcase, so mPut/remote-STORE write full 64-bit words.
// - Addressing (word32 units, D15b): remote = (tile_id << 12) | offset;
//   a plain RV64 pointer access byte-shifts by 2, which the core's
//   mem_addr_rv[31:2] undoes (acc_picorv64.sv). 64-bit data beats are
//   full BW=64 words (D13 full-word remote writes).
// - 64-bit stores/loads occupy 2 word32 slots, so consecutive
//   iterations step by 2 word32 (the 32-bit flow stepped by 1) to keep
//   every slot word64-aligned and non-overlapping.
// - Patterns (checker greps the HIGH 32-bit half, which stays constant
//   across the 16 increments): 0xCAFECACECAFECACE+i (MPUT/MGET),
//   0xF00DF00DF00DF00D+i (remote STORE/LOAD).
// - Layout (word32 offsets in the spad / local windows):
//     spad   mPut slots   : 0x100 + 2i   (word64 0x80 + i)
//     spad   STORE slots  : 0x15A + 2i   (word64 0xAD + i)
//     local  mGet landing : 0x180 + 2i   (word64 0xC0 + i)
//     local  LOAD results : 0x1DA + 2i   (word64 0xED + i)
// ///////////////////////////////////////////////////////////////*/

#include <stdint.h>
#include "mq64.h"

//- Tile ids: (row << 3) | col with tile_array[x][y] - first index is x.
//- 2x2 here: 00=0 pico64 (self), 01(x=0,y=1)=8 spad
#define TID_SELF  0
#define TID_SPAD  8

//- word32 offsets inside the target windows
#define SPAD_OFF   0x100   //- mPut/mGet slot in the spad (word32)
#define LOCAL_OFF  0x180   //- mGet response landing slot (word32)
#define STORE_DELTA 90    //- remote STORE/LOAD offset (word32, D-flow +90)

#define IT 16

#define MPUT_BASE  0xCAFECACECAFECACEull
#define STORE_BASE 0xF00DF00DF00DF00Dull

//- Write the remote scratchpad IT times:
//-   MPUT  : mPut a 64-bit CAFECACE pattern into the spad
//-   STORE : plain 64-bit pointer store of a F00DF00D pattern
void wr64_mem (void)
{
   uint32_t remote_mput  = (TID_SPAD << 12) | SPAD_OFF;
   uint32_t remote_store = (TID_SPAD << 12) | SPAD_OFF + STORE_DELTA;
   uint64_t data1 = MPUT_BASE;
   uint64_t data2 = STORE_BASE;

   for (int i = 0; i < IT; i++){
      //- Message based MPUT (full 64-bit beat)
      mPut(data1, remote_mput + 2*i);
      //- STORE (plain pointer store through the remote window)
      *(volatile uint64_t *)(uint64_t)((remote_store + 2*i) << 2) = data2;
      data1++;
      data2++;
   }
}

//- Read the remote scratchpad back IT times:
//-   MGET : mGet the spad slot; the response auto-writes local memory
//-   LOAD : plain 64-bit pointer load, stored to the local window
void rd64_mem (void)
{
   uint32_t remote_mget  = (TID_SPAD << 12) | SPAD_OFF;
   uint32_t remote_load  = (TID_SPAD << 12) | SPAD_OFF + STORE_DELTA;
   uint32_t local_mget   = (TID_SELF << 12) | LOCAL_OFF;
   uint32_t local_load   = (TID_SELF << 12) | LOCAL_OFF + STORE_DELTA;

   for (int i = 0; i < IT; i++){
      //- Message based MGET (response auto-writes local word32 slot)
      mGet(remote_mget + 2*i, local_mget + 2*i);
      //- LOAD (plain pointer load through the remote window)
      *(volatile uint64_t *)(uint64_t)((local_load + 2*i) << 2) =
         *(volatile uint64_t *)(uint64_t)((remote_load + 2*i) << 2);
   }
}

int main (void)
{
   wr64_mem();
   rd64_mem();

   for (;;)
      ;
}
