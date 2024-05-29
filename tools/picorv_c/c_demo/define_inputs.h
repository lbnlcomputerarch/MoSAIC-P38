
#include "defines.h"

#define LAPLACE

#ifdef LAPLACE

   // Modify Software
   //#define IN_GRID_LEN          7
   #define IN_GRID_LEN          9
   #define IN_STORE_DIAG_IN_VEC 0
   #define IN_MATRIX_TYPE       MATRIX_FULL
   #define IN_STORE_TYPE        STORE_CSR
   #define IN_SOLVER_TYPE       SOLVER_ASYNC_TRISOLVE

   // Do not modify 
   #define IN_N                (IN_GRID_LEN*IN_GRID_LEN) 
   #define IN_NNZ_TEMP         (5*IN_N - 4*IN_GRID_LEN)

   #if (IN_MATRIX_TYPE == MATRIX_LOWER)
      #define IN_NNZ ((IN_NNZ_TEMP  - IN_N) / 2);
   #elif (IN_MATRIX_TYPE == MATRIX_UPPER)
      #define IN_NNZ ((IN_NNZ_TEMP  - IN_N) / 2);
   #else
      #define IN_NNZ IN_NNZ_TEMP
   #endif

#else

   #define IN_N 3
   #define IN_NNZ 6

#endif

/* Modify Hardware */

#define IN_HW_ROW 7
//#define IN_HW_COL 4
#define IN_HW_COL 8
#define IN_NUM_THREADS ((IN_HW_ROW * IN_HW_COL) -1)





