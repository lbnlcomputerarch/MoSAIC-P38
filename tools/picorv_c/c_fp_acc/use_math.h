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

void use_math(double op1, double op2, double op3, uint32_t tid){
   
   volatile uint32_t cyc_h;
   volatile uint32_t cyc_l;
   volatile uint32_t cyci_h;
   volatile uint32_t cyci_l;
   volatile double res;

#ifdef COUNTERS
   asm("rdcycleh %0; rdcycle %1;":"=r"(cyci_h), "=r"(cyci_l):);
   res = op1 + op2;
   asm("rdcycleh %0; rdcycle %1;":"=r"(cyc_h), "=r"(cyc_l):);
   gl_cyc_add_h_i[tid] = cyci_h;
   gl_cyc_add_l_i[tid] = cyci_l;
   gl_cyc_add_h_f[tid] = cyc_h;
   gl_cyc_add_l_f[tid] = cyc_l;
#else
   res = op1 + op2;
#endif
   send_double(res);
   
   res = op1+op3;
   send_double(res);

   res = op2+op3;
   send_double(res);
   
   res = op1+op1;
   send_double(res);

#ifdef COUNTERS
   asm("rdcycleh %0; rdcycle %1;":"=r"(cyci_h), "=r"(cyci_l):);
#endif
   res = op1*op2;
#ifdef COUNTERS
   asm("rdcycleh %0; rdcycle %1;":"=r"(cyc_h), "=r"(cyc_l):);
   gl_cyc_mul_h_i[tid] = cyci_h;
   gl_cyc_mul_l_i[tid] = cyci_l;
   gl_cyc_mul_h_f[tid] = cyc_h;
   gl_cyc_mul_l_f[tid] = cyc_l;
#endif
   send_double(res);
   
   res = op1*op3;
   send_double(res);

   res = op2*op3;
   send_double(res);
   
   res = op1*op1;
   send_double(res);

#ifdef COUNTERS
   asm("rdcycleh %0; rdcycle %1;":"=r"(cyci_h), "=r"(cyci_l):);
#endif
   res = op1/op2;
#ifdef COUNTERS
   asm("rdcycleh %0; rdcycle %1;":"=r"(cyc_h), "=r"(cyc_l):);
   gl_cyc_div_h_i[tid] = cyci_h;
   gl_cyc_div_l_i[tid] = cyci_l;
   gl_cyc_div_h_f[tid] = cyc_h;
   gl_cyc_div_l_f[tid] = cyc_l;
#endif
   send_double(res);
   
   res = op1/op3;
   send_double(res);

   res = op2/op3;
   send_double(res);
   
   res = op1/op1;
   send_double(res);
  
#ifdef COUNTERS
   asm("rdcycleh %0; rdcycle %1;":"=r"(cyci_h), "=r"(cyci_l):);
#endif
   res = sqrt(op1);
#ifdef COUNTERS
   asm("rdcycleh %0; rdcycle %1;":"=r"(cyc_h), "=r"(cyc_l):);
   gl_cyc_sqr_h_i[tid] = cyci_h;
   gl_cyc_sqr_l_i[tid] = cyci_l;
   gl_cyc_sqr_h_f[tid] = cyc_h;
   gl_cyc_sqr_l_f[tid] = cyc_l;
#endif

   send_double(res);
   
   res = sqrt(op2);
   send_double(res);
   
   res = sqrt(op3);
   send_double(res);
   
}

