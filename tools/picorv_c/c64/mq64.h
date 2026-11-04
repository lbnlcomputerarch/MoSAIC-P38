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
// Author      : Farzad Fatollahi-Fard
// Date        : November 3 2026
// Description : Message-queue macros for RV64 pico64 tiles
// File        : mq64.h
// Notes       :
// - RV64 variant of mq.h (Phase 4, plan D26). Instruction encodings are
//   identical to the 32-bit flow; the differences are data width and
//   the long-packet beat convention documented below.
// - Include this header INSTEAD of mq.h in pico64 firmware.
/////////////////////////////////////////////////////////////////

#ifndef SRC_MAIN_C_MQ64_H
#define SRC_MAIN_C_MQ64_H

#include "xcustom64.h"

#define mq_DO_QPUT 3
#define mq_DO_QPOLL 0
#define mq_DO_QGET 2
#define mq_DO_QWAIT 1
#define mq_DO_MGET 5
#define mq_DO_MPUT 4
#define mq_DO_MLOAD 6
#define mq_DO_MSTORE 7

#define XCUSTOM_MQ 1

// =====================================================================
// LONG-PACKET BEAT CONVENTION (plan D26)
// =====================================================================
//
// A short packet (qPut/mPut/mGet/qGet) is one custom instruction: the
// qISAExtension_pcpi FSM emits a NoC header beat followed by one
// payload beat built from the instruction's register operands.
//
// A LONG packet moves more than one payload word. It is built from a
// header instruction (func7 = 1) followed by data-beat instructions
// (func7 = 2):
//
//   - The 4-bit packet code travels in the low nibble of the header
//     instruction's rs2 VALUE (pcpi_rs2[3:0] in the RTL).
//   - The packet code counts payload BEATS: a beat is BW bits wide,
//     i.e. 8 bytes at BW=64 (the pico64 tile) vs 4 bytes at BW=32
//     (legacy pico32 tiles).
//   - code = log2(n_beats) + 1, i.e. n_beats = 2^(code-1):
//       code 1 -> 1 beat,  code 2 -> 2 beats,  code 3 -> 4 beats, ...
//   - Each qPut_d/mPut_d data-beat instruction contributes payload
//     register words as consecutive beats on the stream; at BW=64 each
//     register word is a full 64-bit beat.
//
// MAPPING NOTE: the legacy pico32 flow used 32-bit words in the same
// code field, so identical codes move TWICE the bytes at BW=64. Firm-
// ware that must interoperate across tile widths should size packets
// in beats, not bytes (see plan D26 and the pico64_tile README).
//
// The RTL side of this convention is qISAExtension_pcpi.sv (packet
// code decode: pcpi_pkt_code, next_pkt_size_qput = 1 << (code-1);
// long-packet header pack: pcpi_header1). The Phase 4 verification
// testcase (qPut/qGet between pico64 tiles, pico64 <-> scratchpad
// mPut/mGet) exercises this end to end.
// =====================================================================

#define qPut(destination_qid, source_data) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, destination_qid, source_data, mq_DO_QPUT);

#define qPoll(destination_qid, cr_pcpi) \
  PCPI_INSTRUCTION_R_R_0(XCUSTOM_MQ, cr_pcpi, destination_qid, mq_DO_QPOLL);

#define qGet(destination_qid, sr_pcpi) \
  PCPI_INSTRUCTION_R_R_0(XCUSTOM_MQ, sr_pcpi, destination_qid, mq_DO_QGET);

#define qWait(destination_qid, dr_pcpi) \
  PCPI_INSTRUCTION_R_R_0(XCUSTOM_MQ, dr_pcpi, destination_qid, mq_DO_QWAIT);

#define mGet(remote_dest, local_dest) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, remote_dest, local_dest, mq_DO_MGET);

#define mPut(source, addr) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, addr, source, mq_DO_MPUT);

//- Long-packet variants (see beat convention above). qPut_h/mPut_h send
//- the long header: rs2's low nibble = packet code; qPut_d/mPut_d send
//- payload beats. mGet_h announces the expected inbound packet code the
//- same way; mGet_d receives one beat into local_dest.
#define qPut_h(destination_qid, pkt_code) \
  PCPI_INSTRUCTION_0_R_R_H(XCUSTOM_MQ, destination_qid, pkt_code, mq_DO_QPUT);

#define qPut_d(source_data) \
  PCPI_INSTRUCTION_0_R_D(XCUSTOM_MQ, source_data, source_data, mq_DO_QPUT);

#define mPut_h(addr, pkt_code) \
  PCPI_INSTRUCTION_0_R_R_H(XCUSTOM_MQ, addr, pkt_code, mq_DO_MPUT);

#define mPut_d(source_data) \
  PCPI_INSTRUCTION_0_R_D(XCUSTOM_MQ, source_data, source_data, mq_DO_MPUT);

#define mGet_h(remote_dest, pkt_code) \
  PCPI_INSTRUCTION_0_R_R_H(XCUSTOM_MQ, remote_dest, pkt_code, mq_DO_MGET);

#define mGet_d(local_dest) \
  PCPI_INSTRUCTION_R_R_D(XCUSTOM_MQ, local_dest, 0, mq_DO_MGET);

#endif
