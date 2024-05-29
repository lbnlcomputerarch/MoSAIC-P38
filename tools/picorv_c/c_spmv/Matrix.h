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

//#include "struct.h"
//#include "define_inputs.h"

/* five-point centered difference discretization of the Laplace equation */
void ConstructLaplace2D5pt(void)
{
   int  matrix_type        = IN_MATRIX_TYPE;
   int  store_type         = IN_STORE_TYPE;
   bool store_diag_in_vec  = IN_STORE_DIAG_IN_VEC;   //-FIXME
   int  grid_len           = IN_GRID_LEN;      //-FIXME, It was Vector
   
   int nx       = grid_len;      //-FIXME
   int N        = nx * nx;       //-FIXME
   int num_rows = N;             //-FIXME
   int num_cols = N;             //-FIXME, Square matrix?
   
   
   int col;


   int nnz = IN_NNZ;
   /*
   nnz = 5*nx*nx - 4*nx;
   if (matrix_type == MATRIX_LOWER){
     nnz = (nnz - nx*nx) / 2;
   }else if (matrix_type == MATRIX_UPPER){ 
     nnz = (nnz - nx*nx) / 2;
   } //- Default
   */
   
   /*
   if (store_type = STORE_COO){
      int row_idx[nnz];
      int col_idx[nnz];
   }else if (store_type = STORE_CSC){
      int row_idx[nnz];
   }else if (store_type == STORE_CSR){
      int col_idx[nnz];
   }//- Default
   */
   int row_idx[nnz];
   int col_idx[nnz];

   //int start_idx[N+1];
   //int data[nnz];
   //int idx[nnz];
   //int diag[num_rows];

   int block_end = nx-1;
   int block_start = 0;
   int k = 0;

   start_idx[0] = 0;

   for(int i = 0; i < N; i++){
      if (store_diag_in_vec){
         diag[i] = 4;
      }
      col = i - nx;
      if (col >= 0){
         bool insert_nnz = false;
         if (matrix_type == MATRIX_LOWER){
            if (col < i) insert_nnz = true;
         }
         else if (matrix_type == MATRIX_UPPER){
            if (col > i) insert_nnz = true;
         }
         else {
            insert_nnz = true;
         }

         if (insert_nnz){
            data_v[k] = -1;
            idx[k] = col;
            k++;
         }
      }
      if (i > block_start){
         col = i - 1;

         bool insert_nnz = false;
         if (matrix_type == MATRIX_LOWER){
            if (col < i) insert_nnz = true;
         }
         else if (matrix_type == MATRIX_UPPER){
            if (col > i) insert_nnz = true;
         }
         else {
            insert_nnz = true;
         }

         if (insert_nnz){
            data_v[k] = -1;
            idx[k] = col;
            k++;
         }
      }
      if (!store_diag_in_vec){
         //data_v[k] = 4;
         data_v[k] = 1;
         idx[k] = i;
         k++;
      }
      if (i < block_end){
         col = i + 1;

         bool insert_nnz = false;
         if (matrix_type == MATRIX_LOWER){
            if (col < i) insert_nnz = true;
         }
         else if (matrix_type == MATRIX_UPPER){
            if (col > i) insert_nnz = true;
         }
         else {
            insert_nnz = true;
         }

         if (insert_nnz){
            data_v[k] = -1;
            idx[k] = col;
            k++;
         }
      }
      col = i + nx;
      if (col < N){
         bool insert_nnz = false;
         if (matrix_type == MATRIX_LOWER){
            if (col < i) insert_nnz = true;
         }
         else if (matrix_type == MATRIX_UPPER){
            if (col > i) insert_nnz = true;
         }
         else {
            insert_nnz = true;
         }

         if (insert_nnz){   
            data_v[k] = -1;
            idx[k] = col;
            k++;
         }
      }
      start_idx[i+1] = k;

      if (i == block_end){
         block_end += nx;
         block_start += nx;
      }
   }

   for (int k = 0; k < nnz; k++){
      if (store_type == STORE_CSC){
         row_idx[k] = idx[k];
      }
      else {
         col_idx[k] = idx[k];
      }
   }

   if (store_type == STORE_COO){
      k = 0;
      for (int i = 0; i < num_rows; i++){
         for (int jj = start_idx[i]; jj < start_idx[i+1]; jj++){
            if (store_type == STORE_CSC){
               col_idx[k] = i;
            }
            else {
               row_idx[k] = i;
            }
            k++;
         }
      }
   };

   A.nnz   = k;
   A.n     = num_rows;
   A.m     = num_cols;
   A.data  = &data_v[0];
   A.j     = &idx[0];
   A.start = &start_idx[0];
   A.diag  = &diag[0];
}


/* CSR struct */
//typedef struct{
//   int *start; /* pointer to row starts - Size=16 integers*/
//   int *i;     /* columns indices (used in COO and CSC)*/
//   int *j;     /* row indices (used in COO and CSR) - Size= 64 integers*/
//   int *data;  /* matrix values - Size=64 integers*/
//   int *diag;  /* diagonal elements - Size=16 integers*/
//   int n;      /* number of rows */
//   int m;      /* number of columns */
//   int nnz;    /* number of non-zero values */
//}Matrix;
