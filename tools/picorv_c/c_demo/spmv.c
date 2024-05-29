
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include "macgyver.h"
#include "struct.h"
#include "Matrix.h"
#include "mq.h"
#include "define_inputs.h"

int num_threads = IN_NUM_THREADS;

#include "helper_f.h"

int main (int argc, char *argv[])
{
   
   /* Core id */
   int tid_h = atoi(argv[1]);
   int tid_r =  tid_h%8;
   int tid_c =  tid_h/8;
   int tid   = tid_c * IN_HW_ROW + tid_r;

   uint32_t data;
   uint32_t header;

   uint32_t num_qGets=0;
   uint32_t num_qPuts=0;

   if (tid_h > 8){   //- Because spad is in the middle
      tid = tid - 1;
   }

   tid_glob[tid_h] = tid;

   if (tid_h == 0){ 
      ConstructLaplace2D5pt();
      for (int i=0; i<IN_N; i++){
         vector_v[i] = 1;
      }
   }

   if ((tid_r == IN_HW_ROW - 1) & (tid_c == IN_HW_COL-1)){
      qPut(0,0);
   }else{
      /* Start next tile */
      int next_tid = tid + 1;
      int next_tid_h = tid_sw_to_hw(next_tid);
      if (next_tid_h == 8){ //- If spad
         next_tid_h = 9;
      }
      qWait(0,header);
      qPut(next_tid_h, 0);      // - 3
   }

   /* Get initialization message */
   qGet(0, header);
   qGet(0, data);

   /* Parameters from matrix*/
   int N = A.n; //- Number or rows
   
   /* How many rows per thread*/
   int n_loc = tid < N % num_threads ? (N / num_threads + 1) : (N / num_threads);

   /* Counters */
   uint32_t th_i, tl_i, th_f, tl_f;
   uint32_t cyc_h, cyc_l;

   asm("rdcycleh %0; rdcycle %1;":"=r"(cyc_h), "=r"(cyc_l):);
   th_i = cyc_h; 
   tl_i = cyc_l;

   for (int i_loc=0; i_loc<n_loc; i_loc++){
      int i = tid*n_loc + i_loc;
      int jj_start = A.start[i];   //- Reading Row id (Dawson)
      int jj_end   = A.start[i+1]; //- Reading Col id (Dawson)
      int sum = 0;
      for (int jj=jj_start; jj<jj_end; jj++){
         int col_id = A.j[jj];         //- Reading Col id (Dawson)
         //sum += values[j] * x[col_idx[j]];         
         sum += vector_v[col_id] * A.data[jj];  //- Reading data (Dawson)
      }
      x_glob[i] = sum;
   }

   asm("rdcycleh %0; rdcycle %1;":"=r"(cyc_h), "=r"(cyc_l):);
   th_f = cyc_h; 
   tl_f = cyc_l;

   gl_th_i[tid_h] = th_i;
   gl_tl_i[tid_h] = tl_i;
   gl_th_f[tid_h] = th_f;
   gl_tl_f[tid_h] = tl_f;
   gl_num_qPuts[tid_h] = num_qPuts; 
   gl_num_qGets[tid_h] = num_qGets;
   gl_n_loc[tid_h]     = n_loc;

}
