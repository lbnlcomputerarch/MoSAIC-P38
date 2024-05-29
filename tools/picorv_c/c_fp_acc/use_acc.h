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

#define FP_FWD   0x00000100
#define FP_END   0x00000200
#define FP_ADD_S 0x0000000a //FIXME: Add it to mosaic_defines.h
 
void use_acc(double op1, double op2, double op3, uint32_t tid){
   //- Send message to adder 
   
   mPutH(FP_ADD10,2);
   mPutD_w(op1);
   mPutD_w(op2);

   mPutH(FP_ADD10,4);
   mPutD_w(op1);
   mPutD_w(op2);
   mPutD_w(op1);
   mPutD_w(op3);
   mPutD_w(op2);
   mPutD_w(op3);
   mPutD_w(op1);
   mPutD_w(op1);
   
   send_mq(); //- Single
   send_mq(); //- Long

   //- Send message to multiplier
   mPutH(FP_MUL9,2);
   mPutD_w(op1);
   mPutD_w(op2);

   mPutH(FP_MUL9,4);
   mPutD_w(op1);
   mPutD_w(op2);
   mPutD_w(op1);
   mPutD_w(op3);
   mPutD_w(op2);
   mPutD_w(op3);
   mPutD_w(op1);
   mPutD_w(op1);

   send_mq(); //- Single
   send_mq(); //- Long

   //- Send message to Divider
   mPutH(FP_DIV11,2);
   mPutD_w(op1);
   mPutD_w(op2);

   mPutH(FP_DIV11,4);
   mPutD_w(op1);
   mPutD_w(op2);
   mPutD_w(op1);
   mPutD_w(op3);
   mPutD_w(op2);
   mPutD_w(op3);
   mPutD_w(op1);
   mPutD_w(op1);

   send_mq(); //- Single
   send_mq(); //- Long

   //- Send message to sqrt
   mPutH(FP_SQR12,1);
   mPutD_w(op1);

   /* Test this with new bitstream
   mPutH(FP_SQR12,3);
   mPutD_w(op1);
   mPutD_w(op2);
   mPutD_w(op3);
   mPutD_w(op1);
   send_mq(); //- Single
   */

   send_mq(); //- Long

   //- Move data from spad to adder
   //- Get the last four results in the fp_results buffer
   uint32_t mem_addr = (uint32_t) &fp_results[spad_address-4];
   mem_addr = mem_addr >> 2;
   uint32_t fp_addr = FP_ADD10 | FP_END | tid;
   mGetH(mem_addr,2);
   mGetD(fp_addr,0)
   send_mq(); //- Single

   //- Send message to multiplier(4 operands)
   //- then adder (2 operands)
   fp_addr = FP_MUL9 | FP_FWD | FP_ADD_S;
   mPutH(fp_addr,3);
   mPutD_w(op1);
   mPutD_w(op2);
   mPutD_w(op1);
   mPutD_w(op2);
   send_mq(); //- Single

}
