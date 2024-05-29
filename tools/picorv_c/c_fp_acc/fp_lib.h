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

#include "mosaic_defines.h"

double fp_generic(double a, double b, uint32_t type)
{
   uint32_t temp, header1, header2, data1, data2;
   if (type == FP_SQR12){
      mPutH(type,1);
   }else{
      mPutH(type,2);
      mPutD_w(a);
   }
   mPutD_w(b);

   //- Wait for response
   qWait(temp, header1);
   //- Get data from the queue
   qGet(temp, header1);
   qGet(temp, header2);
   qGet(temp, data1);
   qGet(temp, data2);
   //- Conversion
   uint64_t i = (uint64_t) data2 << 32 | data1;
   double res = hex2double(i);
   return res;
}

double __adddf3(double a, double b)
{
   double res = fp_generic(a,b,FP_ADD10);
   return res;
}

double __muldf3(double a, double b)
{
   double res = fp_generic(a,b,FP_MUL9);
   return res;
}

double __divdf3(double a, double b)
{
   double res = fp_generic(a,b,FP_DIV11);
   return res;
}

double sqrt(double a)
{
   double res = fp_generic(0,a,FP_SQR12);
   return res;
}






