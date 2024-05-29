/////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : April 19 2022
// Description : C code to test pico-scratchpad communication 
// File        : mq.h
// Notes       : 
// - Modified from Ana Butko repository.
//    git@github.com:anabutko/P38-MQ-Lib.git
////////////////////////////////////////////////////////////////

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

#define XCUSTOM_MQ 1

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
#endif
