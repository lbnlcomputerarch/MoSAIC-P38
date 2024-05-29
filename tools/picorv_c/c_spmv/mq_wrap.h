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

#include "mq.h"

/* qPut wrapper */
int MsgQ_Put(int destination_qid, uint32_t source_data)
{
   destination_qid = tid_sw_to_hw (destination_qid);
   qPut(destination_qid, source_data);
   return 0;
}

/* qGet wrapper */
int MsgQ_Get(int destination_qid, uint32_t *source_data)
{
   uint32_t temp;
   uint32_t received_data_poll;
   qPoll((uint32_t)destination_qid, received_data_poll);
   /* Check if queue is empty */
   if (received_data_poll == 1){
      return -1;
   }else{
      /* Pop header from queue */
      qGet((uint32_t)destination_qid, temp);
      /* Pop data from queue */
      qGet((uint32_t)destination_qid, temp);
      /* Copy poppwed data */
      *source_data = temp;
      return 1;
   } 

   /*
    ** From Jordi
   if (received_data_poll == 1){
      return -1;
   }
   else {
      ** If queue has data, get source core using a mask
      source_id = received_data_poll & source_mask;
      source_id = source_id >> 17;
      ** Pop from queue
      qGet((uint32_t)destination_qid, temp);
      ** Copy poppwed data
      *source_data = temp;
      return 1;
   }
   */
}


