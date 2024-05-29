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

