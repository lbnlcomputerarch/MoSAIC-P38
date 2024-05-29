
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
   /*
   uint32_t temp;
   uint32_t received_data_poll;
   qPoll((uint32_t)destination_qid, received_data_poll);
   // Check if queue is empty 
   if (received_data_poll == 1){
      return -1;
   }else{
      //* Pop header from queue
      qGet((uint32_t)destination_qid, temp);
      //* Pop data from queue 
      qGet((uint32_t)destination_qid, temp);
      //* Copy poppwed data 
      *source_data = temp;
      return 1;
   } 
   */
   uint32_t temp;
   uint32_t received_data_poll;
   //* Pop header from queue
   qGet(0, temp);
   //uint32_t source_mask = 0x00FC0000;
   //uint32_t source_id = temp >> 17; 
   //* Pop data from queue 
   qGet(0, temp);
   //* Copy poppwed data 
   *source_data = temp;
   return 1;
    

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


