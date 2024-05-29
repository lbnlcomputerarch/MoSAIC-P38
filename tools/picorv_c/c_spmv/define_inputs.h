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

#include "defines.h"

/* MODIFY */

/* Modify Software */
#define IN_GRID_LEN          15
#define IN_STORE_DIAG_IN_VEC 0
#define IN_MATRIX_TYPE       MATRIX_FULL
#define IN_STORE_TYPE        STORE_CSR
#define IN_SOLVER_TYPE       SOLVER_ASYNC_TRISOLVE

/* Modify Hardware */
#define IN_HW_ROW 7
#define IN_HW_COL 4

#define IN_NUM_THREADS (IN_HW_ROW * IN_HW_COL)

/* END MODIFY */


/* DO NOT MODIFY */

#define IN_N                (IN_GRID_LEN*IN_GRID_LEN) 
#define IN_NNZ_TEMP         (5*IN_N - 4*IN_GRID_LEN)

#if (IN_MATRIX_TYPE == MATRIX_LOWER)
   #define IN_NNZ ((IN_NNZ_TEMP  - IN_N) / 2);
#elif (IN_MATRIX_TYPE == MATRIX_UPPER)
   #define IN_NNZ ((IN_NNZ_TEMP  - IN_N) / 2);
#else
   #define IN_NNZ IN_NNZ_TEMP
#endif



