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

/////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : November 3 2026
// Description : PCPI custom-instruction encodings for RV64 (pico64)
// File        : xcustom64.h
// Notes       :
// - RV64 variant of xcustom.h (Phase 4, plan D26). Modified from Ana
//   Butko repository (git@github.com:anabutko/P38-MQ-Lib.git), based on
//   code by Schuyler Eldridge (Boston University rocc.h).
// - The .insn r CUSTOM_1 (=0x2B) encoding is UNCHANGED from the 32-bit
//   flow (plan D26): the qISAExtension_pcpi decoder matches
//   pcpi_insn[14:12] (func3) and pcpi_insn[26:25] (low func7 bits).
// - PCPI operands are BW-bit wide in the pico64 tile (BW=64): results
//   of qPoll/qGet/qWait/mGet and long-packet data words are 64-bit.
//   Hold them in uint64_t (RV64 lp64: a native register).
// - Long-packet variants (plan D26 beat convention): func7 = 1 issues a
//   long-packet HEADER, func7 = 2 issues/consumes one DATA beat. The
//   4-bit packet code travels in pcpi_rs2[3:0]. See mq64.h for the
//   beat-convention documentation.
////////////////////////////////////////////////////////////////

#ifndef SRC_MAIN_C_XCUSTOM64_H
#define SRC_MAIN_C_XCUSTOM64_H

#include <stdint.h>

#define STR1(x) #x
#define STR(x) STR1(x)
#define EXTRACT(a, size, offset) (((~(~0UL << size) << offset) & a) >> offset)

#define CAT_(A, B) A##B
#define CAT(A, B) CAT_(A, B)

#define CUSTOMX_OPCODE(x) CUSTOM_ ## x
#define CUSTOM_0 0b0001011
#define CUSTOM_1 0b0101011
#define CUSTOM_2 0b1011011
#define CUSTOM_3 0b1111011

//- func7 = 0: short packet / legacy form (identical to xcustom.h)
#define PCPI_INSTRUCTION_0_R_R(x, rs1, rs2, func3)                                   \
  {                                                                                  \
    asm volatile(                                                                    \
        ".insn r " STR(CAT(CUSTOM_, x)) ", " STR(func3) ", " STR(0x0) ", x0, %0, %1" \
        :                                                                            \
        : "r"(rs1), "r"(rs2));                                                       \
  }

#define PCPI_INSTRUCTION_R_R_0(x, rd, rs1, func3)                                    \
  {                                                                                  \
    asm volatile(                                                                    \
        ".insn r " STR(CAT(CUSTOM_, x)) ", " STR(func3) ", " STR(0x0) ", %0, %1, x0" \
        : "=r"(rd)                                                                   \
        : "r"(rs1));                                                                 \
  }

//- func7 = 1: LONG-PACKET HEADER. rs2 carries the 4-bit packet code in
//- its low nibble (pcpi_rs2[3:0]); rs1 carries the header payload
//- (remote address for mPut_h/mGet_h).
#define PCPI_INSTRUCTION_0_R_R_H(x, rs1, rs2, func3)                                 \
  {                                                                                  \
    asm volatile(                                                                    \
        ".insn r " STR(CAT(CUSTOM_, x)) ", " STR(func3) ", " STR(0x1) ", x0, %0, %1" \
        :                                                                            \
        : "r"(rs1), "r"(rs2));                                                       \
  }

//- func7 = 2: LONG-PACKET DATA beat. rs1 carries the outbound data word
//- (qPut_d/mPut_d). For mGet_d the returned beat arrives in rd.
#define PCPI_INSTRUCTION_R_R_D(x, rd, rs1, func3)                                    \
  {                                                                                  \
    asm volatile(                                                                    \
        ".insn r " STR(CAT(CUSTOM_, x)) ", " STR(func3) ", " STR(0x2) ", %0, %1, x0" \
        : "=r"(rd)                                                                   \
        : "r"(rs1));                                                                 \
  }

#define PCPI_INSTRUCTION_0_R_D(x, rs1, rs2, func3)                                   \
  {                                                                                  \
    asm volatile(                                                                    \
        ".insn r " STR(CAT(CUSTOM_, x)) ", " STR(func3) ", " STR(0x2) ", x0, %0, %1" \
        :                                                                            \
        : "r"(rs1), "r"(rs2));                                                       \
  }

#endif
