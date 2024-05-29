
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include "define_inputs.h"
#include "struct.h"
#include "Matrix.h"
#include "macgyver.h"

int num_threads = IN_NUM_THREADS;

#include "helper_f.h"
#include "mq_wrap.h"

int main (int argc, char *argv[])
{

int solver_type = SOLVER_ASYNC_TRISOLVE;

uint32_t header;
uint32_t data;

/* Core id */
int tid_h = atoi(argv[1]);
int tid_r =  tid_h%8;
int tid_c =  tid_h/8;
int tid   = tid_c * IN_HW_ROW + tid_r;

if (tid_h > 8){   //- Because spad is in the middle
   tid = tid - 1;
}

tid_glob[tid_h] = tid;  //- DEBUG - 1

if (tid_h == 0){ 
   ConstructLaplace2D5pt();
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
   next_tid_glob[tid_h] = next_tid_h; //- Debug - 2
   qWait(0,header);
   qPut(next_tid_h, 0);      // - 3
}

/* Get initialization message */
qGet(0, header);
qGet(0, data);


/* Parameters from matrix*/
int N = A.n;
int nnz = A.nnz;

int num_qGets=0;
int num_qPuts=0;

/* How many rows per thread*/
int n_loc = tid < N % num_threads ? (N / num_threads + 1) : (N / num_threads);

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
         int jj_start = A.start[i];
         int jj_end   = A.start[i+1];

         /* Count non-zeros in lower part */
         int jj          = jj_start;
         int row_count_i = 0;
         for (jj = jj_start; jj < jj_end; jj++){
            if (A.j[jj] >= i) break;
            row_count_i++;
         }

         /* Loop until all dependencies have been satisfied */
         jj = jj_start;
         while (row_count_i > 0){
            for (jj = jj_start; jj < jj_end; jj++){
               int j_loc = A.j[jj];
               /* Stop if we are in upper part of matrix */
               if (j_loc >= i) break;
               int src_tid = row_to_core(j_loc); 
               if (src_tid == tid){
                  uint32_t xj;
                  xj = glob_to_loc_row(i, tid); 
                  x_loc[i_loc] -= A.data[jj] * (int)xj;
               }else{
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
         }

         x_loc[i_loc] /= A.data[jj];
         jj++;

         /* Send x_loc[i_loc] to dependencies */
         int xi = x_loc[i_loc];
         for (; jj < jj_end; jj++){
            int dest_tid = row_to_core(A.j[jj]);
            MsgQ_Put(dest_tid, xi);
            dest_glob[tid_h*10+num_qPuts] = A.j[jj];
            num_qPuts++;
         }
      x_glob[i] = xi;
   }
}

gl_num_qPuts[tid] = num_qPuts; //- 4
gl_num_qGets[tid] = num_qGets; //- 5

return 0;

}

