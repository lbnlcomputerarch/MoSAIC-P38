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


#ifndef SRC_MAIN_C_MQ_H
#define SRC_MAIN_C_MQ_H

#include "xcustom.h"

#define mq_DO_QPUT 3
#define mq_DO_QPOLL 0
#define mq_DO_QGET 2
#define mq_DO_QWAIT 1
#define mq_DO_MGET 5
#define mq_DO_MPUT 4
#define mq_DO_MLOAD 6
#define mq_DO_MSTORE 7

#define mq_DO_NO   0
#define mq_DO_H 1
#define mq_DO_D 2
#define mq_DO_DMA  3

#define XCUSTOM_MQ 1

#define qPut(destination_qid, source_data) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, destination_qid, source_data, mq_DO_QPUT, mq_DO_NO);

#define qPoll(destination_qid, cr_pcpi) \
  PCPI_INSTRUCTION_R_R_0(XCUSTOM_MQ, cr_pcpi, destination_qid, mq_DO_QPOLL, mq_DO_NO);

#define qGet(destination_qid, sr_pcpi) \
  PCPI_INSTRUCTION_R_R_0(XCUSTOM_MQ, sr_pcpi, destination_qid, mq_DO_QGET, mq_DO_NO);

#define qWait(destination_qid, dr_pcpi) \
  PCPI_INSTRUCTION_R_R_0(XCUSTOM_MQ, dr_pcpi, destination_qid, mq_DO_QWAIT, mq_DO_NO);

#define mGet(remote_dest, local_dest) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, remote_dest, local_dest, mq_DO_MGET, mq_DO_NO);

#define mPut(source, addr) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, addr, source, mq_DO_MPUT, mq_DO_NO);

#define mLoad(dr, addr) \
  PCPI_INSTRUCTION_R_R_0(XCUSTOM_MQ, dr, addr, mq_DO_MLOAD, mq_DO_NO);

#define mStore(mem_addr, data) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, mem_addr, data, mq_DO_MSTORE, mq_DO_NO);
#endif

#define qPutH(destination_qid, pktSizeCode) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, destination_qid, pktSizeCode, mq_DO_QPUT, mq_DO_H);

#define qPutD(source_data1, source_data2) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, source_data1, source_data2, mq_DO_QPUT, mq_DO_D);

#define mPutH(source, pktSizeCode) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, source, pktSizeCode, mq_DO_MPUT, mq_DO_H);

#define mPutD(addr1, addr2) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, addr1, addr2, mq_DO_MPUT, mq_DO_D);

#define mGetH(remote_dest, pktSizeCode) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, remote_dest, pktSizeCode, mq_DO_MGET, mq_DO_H);

#define mGetD(source_data1, source_data2) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, source_data1, source_data2, mq_DO_MGET, mq_DO_D);

#define mGetDMA(remote_dest, pktSizeCode) \
  PCPI_INSTRUCTION_0_R_R(XCUSTOM_MQ, remote_dest, pktSizeCode, mq_DO_MGET, mq_DO_DMA);

