
//#include "struct.h"
//#include "define_inputs.h"


#ifdef LAPLACE

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
   int row_idx[nnz];
   int col_idx[nnz];
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
#else
void smallExample(void)
{

   data_v[0] = 1; 
   data_v[1] = 2; 
   data_v[2] = 1; 
   data_v[3] = 3; 
   data_v[4] = 2; 
   data_v[5] = 1; 

   idx[0] = 0;
   idx[1] = 0;
   idx[2] = 1;
   idx[3] = 0;
   idx[4] = 1;
   idx[5] = 2;

   start_idx[0] = 0;
   start_idx[1] = 1;
   start_idx[2] = 3;
   start_idx[3] = 6;

   A.nnz   = 6;
   A.n     = 3;
   A.m     = 3;
   A.data  = &data_v[0];
   A.j     = &idx[0];
   A.start = &start_idx[0];
   A.diag  = &diag[0];
}

#endif

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
