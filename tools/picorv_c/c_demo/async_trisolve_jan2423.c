
#include <stdint.h>
#include <stdlib.h>
#include "define_inputs.h"
#include "struct.h"
#include "macgyver.h"

int num_threads = IN_NUM_THREADS;

#include "helper_f.h"
#include "mq_wrap.h"

int main (int argc, char *argv[])
{

int solver_type = SOLVER_ASYNC_TRISOLVE;

/* Core id */
int tid_h = atoi(argv[1]);
int tid_r =  i%8;
int tid_c =  i/8;
int tid   = tid_c * IN_HW_ROW + tid_r;

/* Wait until Matrix has been generated */
uint32_t wait_header;
qWait(0,wait_header);

/* Pop unused message */
uint32_t temp;
int flag = MsgQ_Get(tid, &temp); // qGet()

/* Parameters from matrix*/
int N = A.n;
int nnz = A.nnz;

int num_qGets=0;
int num_qPuts=0;

/* How many rows per thread*/
int n_loc = tid < N % num_threads ? N / num_threads + 1 : N / num_threads;

int r_loc[n_loc];
int x_loc[n_loc];

/* Set initial approximation x (Jacobi only), right-hand side, and residual (JJacobi only) */
for (int i_loc = 0; i_loc < n_loc; i_loc++){
   int i = loc_to_glob_row(i_loc, tid);
   if (solver_type == SOLVER_ASYNC_TRISOLVE){
      r_loc[i_loc] = i;
      x_loc[i_loc] = i;
   } else {
      r_loc[i_loc] = i;
      x_loc[i_loc] = 0;
   }
}

/*
int A_start[N+1];
int A.j[A.nnz];
uint32_t A.data[A.nnz];
*/



/***********************************
 * Asynchronous Triangular Solver
 ***********************************/

if (solver_type == SOLVER_ASYNC_TRISOLVE){
   for (int i_loc = 0; i_loc < n_loc; i_loc++){ /* loop over rows */
      int i        = loc_to_glob_row(i_loc, tid);
      //if (row_to_core(i) == tid){
      int jj_start = A.start[i];
      int jj_end   = A.start[i+1];

      /* Count non-zeros in lower part */
      int jj       = jj_start;
      int row_count_i = 0;
      for (jj = jj_start; jj < jj_end; jj++){
         if (A.j[jj] >= i) break;
            row_count_i++;
         }

         /* Loop until all dependencies have been satisfied */
         jj = jj_start;
         while (row_count_i > 0){
            for (jj = jj_start; jj < jj_end; jj++){
               /* Stop if we are in upper part of matrix */
               if (A.j[jj] >= i) break;
                  /* If message has arrived, update x_loc[i_loc] */
                  uint32_t xj;
                  int src_tid = MsgQ_Get(tid, &xj); // qGet()
                  if (src_tid > -1) {  // Queue not empty
                     x_loc[i_loc] -= A.data[jj] * (int)xj;
                     row_count_i--;
                     num_qGets++;
                  }
            }
         }

         x_loc[i_loc] /= A.data[jj];
         jj++;

         /* Send x_loc[i_loc] to dependencies */
         int xi = x_loc[i_loc];
         for (; jj < jj_end; jj++){
            int dest_tid = row_to_core(A.j[jj]);
            MsgQ_Put(dest_tid, xi);
            num_qPuts++;
         }
      //}
      x_glob[i] = xi;
   }
}

gl_num_qPuts[tid] = num_qPuts;
gl_num_qGets[tid] = num_qGets;

return 0;

}
