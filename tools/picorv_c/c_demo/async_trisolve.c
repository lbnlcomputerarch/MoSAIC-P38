
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

tid_glob[tid_h] = tid;

if (tid_h == 0){ 
#ifdef LAPLACE
   ConstructLaplace2D5pt();
#else
   smallExample();
 #endif
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
   //next_tid_glob[tid_h] = next_tid_h; //- Debug - 2
   qWait(0,header);
   qPut(next_tid_h, 0);      // - 3
}

/* Get initialization message */
qGet(0, header);
qGet(0, data);


/* Parameters from matrix*/
int N = A.n;                  //- 4
int nnz = A.nnz;              //- 5

uint32_t num_qGets=0;
uint32_t num_qPuts=0;

/* How many rows per thread*/
int n_loc = tid < N % num_threads ? (N / num_threads + 1) : (N / num_threads);
int r_loc[n_loc];
int x_loc[n_loc];

/* Counters */
uint32_t th_i, tl_i, th_f, tl_f;
uint32_t cyc_h, cyc_l;


/***********************************
 * Asynchronous Triangular Solver
 ***********************************/
asm("rdcycleh %0; rdcycle %1;":"=r"(cyc_h), "=r"(cyc_l):);
th_i = cyc_h; 
tl_i = cyc_l;

if (solver_type == SOLVER_ASYNC_TRISOLVE){
   for (int i_loc = 0; i_loc < n_loc; i_loc++){ /* loop over rows */
      int i        = loc_to_glob_row(i_loc, tid);
#ifndef LAPLACE
      // Initialize i_loc for small example
      if (i==0) x_loc[i_loc] = 1;
      else if (i==1) x_loc[i_loc] = 1;
      else if (i==2) x_loc[i_loc] = 3;
#else
      // Initialize i_loc
      x_loc[i_loc] = i;
#endif
        
      int jj_start = A.start[i];   
      int jj_end   = A.start[i+1]; 

      /* Count non-zeros in lower part */
      int jj;
      int row_count_i = 0;
      for (jj = jj_start; jj < jj_end; jj++){ 
         if (A.j[jj] >= i) break;
         row_count_i++;
      }

      jj = jj_start;
      /* Loop until all dependencies have been satisfied */
      while (row_count_i > 0){
         for (jj = jj_start; jj < jj_end; jj++){
            int Aj_jj = A.j[jj];
            /* Stop if we are in upper part of matrix */
            if (Aj_jj >= i) break;
            /* If it was calculated locally*/
            int src = row_to_core(Aj_jj);
            uint32_t xj;
            if (src == tid) {
               xj = x_loc[i_loc-1];
            }else{
               /* If message has arrived, update x_loc[i_loc] */
               qWait(0, data);
               qGet(0, header);
               qGet(0, xj);
               num_qGets++;
            }
            x_loc[i_loc] -= A.data[jj] * (int)xj;
            row_count_i--;
         }
      }

      x_loc[i_loc] /= A.data[jj];
      int xi = x_loc[i_loc];
      x_glob[i] = xi;
         
      /* Send xi, loc[i_loc] to dependencies */
      for (int ii = i + 1; ii < N; ii++){
         jj_start = A.start[ii];  
         jj_end   = A.start[ii+1];
         for (jj=jj_start; jj<jj_end; jj++){
            int Aj_jj = A.j[jj];
            if (Aj_jj > i  ) break;
            if (Aj_jj >= ii) break;
            if (Aj_jj == i ){
               int dest_tid = row_to_core(ii);
               if (dest_tid == tid){
               }else{
                  MsgQ_Put(dest_tid, xi);
                  dest_glob[tid_h*10+num_qPuts] =  0x00010000 | dest_tid;
                  num_qPuts++;
               }
            }else{
            }   
         }
      }
   }
}

asm("rdcycleh %0; rdcycle %1;":"=r"(cyc_h), "=r"(cyc_l):);
th_f = cyc_h; 
tl_f = cyc_l;

gl_th_i[tid_h] = th_i;
gl_tl_i[tid_h] = tl_i;
gl_th_f[tid_h] = th_f;
gl_tl_f[tid_h] = tl_f;
gl_num_qPuts[tid_h] = num_qPuts; //- 6
gl_num_qGets[tid_h] = num_qGets; //- 7
gl_n_loc[tid_h]     = n_loc;
return 0;

}
