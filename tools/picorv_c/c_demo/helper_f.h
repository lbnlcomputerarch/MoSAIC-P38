
int tid_sw_to_hw (int i){
   int row = i%IN_HW_ROW;
   int col = i/IN_HW_ROW;
   int out;
   out = col << 3;
   out = out | row;
   /* 8 is the scratchpad */
   if (out>7){
      i = i + 1;
      row = i%IN_HW_ROW;
      col = i/IN_HW_ROW;
      out = col << 3;
      out = out | row;
   }
   return out;
};

/*
int tid_hw_to_sw (int i){
   int row = i%IN_HW_ROW;
   int col = i/8;
   i = col*IN_HW_COL+row;
   return i;
};
*/

/* Function that maps sparse matrix row indices to cores */
int row_to_core(int i)
{
   /* Round-robin distribution of rows to cores */
   return i % num_threads;
}

/* Function that maps local to global sparse matrix row indices */
int loc_to_glob_row(int i_loc, int tid)
{
   /* Round-robin distribution of rows to cores */
   return i_loc * num_threads + tid;
}   

/* Function that maps local to global sparse matrix row indices */
int glob_to_loc_row(int i_glob, int tid)
{
   /* Round-robin distribution of rows to cores */
   return (i_glob - tid)/num_threads;
}   
