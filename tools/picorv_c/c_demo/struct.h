
#include "define_inputs.h"

/* CSR struct */
typedef struct{
   int      *start;  /* pointer to row starts - Size=16 integers*/
   //int    *i;      /* columns indices (used in COO and CSC)*/
   int      *j;      /* row indices (used in COO and CSR) - Size= 64 integers*/
   uint32_t *data;   /* matrix values - Size=64 integers*/
   uint32_t *diag;   /* diagonal elements - Size=16 integers*/
   int n;            /* number of rows */
   int m;            /* number of columns */
   int nnz;          /* number of non-zero values */
}Matrix;

/* Matrix */
int      start_idx[IN_N+1] __attribute__ ((section(".myMatrixComp")));
int      idx[IN_NNZ]       __attribute__ ((section(".myMatrixComp")));
uint32_t data_v[IN_NNZ]      __attribute__ ((section(".myMatrixComp")));
uint32_t diag[IN_N]        __attribute__ ((section(".myMatrixComp")));
volatile Matrix   A        __attribute__ ((section(".myMatrix")));
volatile uint32_t vector_v[IN_N] __attribute__ ((section(".myMatrix"))); //- For SPMV

/* For Statistics */
volatile uint32_t gl_num_qPuts[64] __attribute__ ((section(".myspad")));
volatile uint32_t gl_num_qGets[64] __attribute__ ((section(".myspad")));
volatile uint32_t gl_n_loc[64]     __attribute__ ((section(".myspad")));
volatile uint32_t x_glob[IN_N]     __attribute__ ((section(".myspad"))); 
volatile uint32_t tid_glob[64]     __attribute__ ((section(".myspad"))); 
volatile uint32_t dest_glob[640]   __attribute__ ((section(".myspad"))); 
volatile uint32_t gl_th_i[64]      __attribute__ ((section(".myspad")));
volatile uint32_t gl_tl_i[64]      __attribute__ ((section(".myspad")));
volatile uint32_t gl_th_f[64]      __attribute__ ((section(".myspad")));
volatile uint32_t gl_tl_f[64]      __attribute__ ((section(".myspad")));

//volatile uint32_t check_point_glob[1280]        __attribute__ ((section(".myspad"))); 




