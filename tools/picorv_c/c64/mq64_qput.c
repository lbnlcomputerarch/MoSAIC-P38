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
// Date        : November 3 2026
// Description : pico64 (tile 00) MQ sender: qPut to pico64 tile 11,
//               mPut/mGet round trip with the scratchpad tile 8
// File        : mq64_qput.c
// Notes       :
// - Phase 4 verification (plan: qPut/qGet 64-bit message between pico64
//   tiles; pico64 <-> scratchpad mPut/mGet). Runs with mq64_qget.c on
//   tile 11; testcase mosaic_2x2_pico64_mq.pl.
// - Addressing (word32 units, D15b): remote = (y << 15) | (x << 12) |
//   offset; qPut destination queue id = tile id = (y << 3) | x.
// - The spad data is NoC-written (mPut) and NoC-read (mGet) only -
//   port A of the spad DPRAM - so the F2 port-B/AXI mismatch is not
//   exercised.
// ///////////////////////////////////////////////////////////////*/

#include <stdint.h>
#include "mq64.h"

//- Tile ids: (row << 3) | col with tile_array[x][y] - first index is x.
//- 2x2 here: 00=0 pico64, 01(x=0,y=1)=8 spad, 10(x=1,y=0)=1 loop, 11=9 pico64
#define TID_SPAD   8
#define TID_PICO64 9

//- word32 offsets inside the target windows
#define SPAD_OFF   0x100   //- mPut/mGet slot in the spad (word32)
#define LOCAL_OFF  0x180   //- mGet response landing slot (word32)

#define QPUT_MSG   0xCAFEBABEDEADBEEFull
#define MPUT_MSG   0xF00DFACEFEED5678ull

int main(void)
{
   uint32_t spad_addr  = (TID_SPAD << 12) | SPAD_OFF;

   //- 1. qPut a 64-bit message to tile 11's inbound queue
   qPut(TID_PICO64, QPUT_MSG);

   //- 2. mPut a 64-bit pattern into the scratchpad (NoC write)
   mPut(MPUT_MSG, spad_addr);

   //- 3. mGet it back; the response auto-writes local memory at
   //-    LOCAL_OFF (the checker greps tile_00.dat for MPUT_MSG)
   mGet(spad_addr, LOCAL_OFF);

   for (;;)
      ;
}
