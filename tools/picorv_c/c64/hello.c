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

// ////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : November 3 2026
// Description : C bring-up firmware for pico64 tiles (Phase 4)
// File        : hello.c
// Notes       :
// - C twin of pico64_hello.hex (Phase 3 Task 5): builds
//   0xCAFEBABEDEADBEEF and stores it with a single 64-bit sd, then spins.
// - Store target byte 0x800 (word64 index 256): .text+.data of the C
//   image start well above byte 64, so the Phase 3 store address would
//   collide with the program. The checker greps the whole dump.
// ////////////////////////////////////////////////////////////////

#include <stdint.h>

int main(void)
{
   *(volatile uint64_t *)0x800 = 0xCAFEBABEDEADBEEFull;
   for (;;)
      ;
}
