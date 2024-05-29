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


#include "define_inputs.h"

/* CSR struct */
typedef struct{
   int *start;       /* pointer to row starts - Size=16 integers*/
   //int *i;         /* columns indices (used in COO and CSC)*/
   int *j;           /* row indices (used in COO and CSR) - Size= 64 integers*/
   uint32_t *data;   /* matrix values - Size=64 integers*/
   uint32_t *diag;   /* diagonal elements - Size=16 integers*/
   int n;            /* number of rows */
   int m;            /* number of columns */
   int nnz;          /* number of non-zero values */
}Matrix;


/* Matrix */

int               start_idx[IN_N+1] __attribute__ ((section(".myMatrixComp")));
int               idx[IN_NNZ]       __attribute__ ((section(".myMatrixComp")));
uint32_t          data_v[IN_NNZ]    __attribute__ ((section(".myMatrixComp")));
uint32_t          diag[IN_N]        __attribute__ ((section(".myMatrixComp")));
volatile uint32_t vector_v[IN_N]    __attribute__ ((section(".myVec"))); //- For SPMV
volatile Matrix   A                 __attribute__ ((section(".myMatrix")));
volatile uint32_t x_glob[IN_N]      __attribute__ ((section(".myspad"))); 

/* For debugging */
volatile uint32_t gl_num_qPuts[IN_NUM_THREADS] __attribute__ ((section(".myspad")));
volatile uint32_t gl_num_qGets[IN_NUM_THREADS] __attribute__ ((section(".myspad")));
volatile uint32_t tid_glob[64]                 __attribute__ ((section(".myspad"))); 
volatile uint32_t next_tid_glob[64]            __attribute__ ((section(".myspad"))); 
volatile uint32_t dest_glob[640]               __attribute__ ((section(".myspad"))); 



