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
// Description : pico64 (tile 11) MQ receiver: qGet a 64-bit message
//               from tile 00 and store a transformed copy locally
// File        : mq64_qget.c
// Notes       :
// - Phase 4 verification (plan: qPut/qGet 64-bit message between
//   pico64 tiles). Runs with mq64_qput.c on tile 00; testcase
//   mosaic_2x2_pico64_mq.pl.
// - qPoll returns 1 while the inbound queue is empty, else the header
//   (peek, no pop). Two qGet instructions pop header + 64-bit payload
//   (tb_qisa_bw64 test-3 semantics).
// - The stored value is the payload XOR 0x1111...1 so the checker can
//   distinguish a real qGet round trip from any stale program word.
// ///////////////////////////////////////////////////////////////*/

#include <stdint.h>
#include "mq64.h"

//- Store locally in tile 11's window: the word32 address must carry the
//- tile's xy in bits [17:12] (== HsrcId) or the store goes remote over the
//- NoC (acc_picorv64 local_mem rule). Byte addr = (9 << 14) + off*4;
//- 0x24400 = word32 0x9100 = tile 11 word32 offset 0x100.
#define STORE_ADDR ((volatile uint64_t *)0x24400)
#define QGET_XOR   0x1111111111111111ull

int main(void)
{
   uint64_t poll, hdr, data;

   //- Block until tile 00's qPut message reaches the inbound queue
   do {
      qPoll(0, poll);
   } while (poll == 1);

   qGet(0, hdr);    //- pop the packet header
   qGet(0, data);   //- pop the 64-bit payload

   *STORE_ADDR = data ^ QGET_XOR;

   for (;;)
      ;
}
