/////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : April 19 2022
// Description : C code to test pico-scratchpad communication 
// File        : pico_scratchpad.c
// Notes       : 
// - Modified from Ana Butko repository.
//     git@github.com:anabutko/P38-MQ-Lib.git
// - Based on code by Schuyler Eldridge. Copyright (c) Boston University
//     https://github.com/seldridge/rocket-rocc-examples/blob/master/src/main/c/rocc.h
////////////////////////////////////////////////////////////////

#include <stdint.h>

#define STR1(x) #x
#define STR(x) STR1(x)
#define EXTRACT(a, size, offset) (((~(~0 << size) << offset) & a) >> offset)

#define CAT_(A, B) A##B
#define CAT(A, B) CAT_(A, B)

#define CUSTOMX_OPCODE(x) CUSTOM_ ## x
#define CUSTOM_0 0b0001011
#define CUSTOM_1 0b0101011
#define CUSTOM_2 0b1011011
#define CUSTOM_3 0b1111011

#define PCPI_INSTRUCTION_0_R_R(x, rs1, rs2, func3)                                   \
  {                                                                                  \
    asm volatile(                                                                    \
        ".insn r " STR(CAT(CUSTOM_, x)) ", " STR(func3) ", " STR(0x0) ", x0, %0, %1" \
        :                                                                            \
        : "r"(rs1), "r"(rs2));                                                       \
  }

#define PCPI_INSTRUCTION_R_R_0(x, rd, rs1, func3)                                    \
  {                                                                                  \
    asm volatile(                                                                    \
        ".insn r " STR(CAT(CUSTOM_, x)) ", " STR(func3) ", " STR(0x0) ", %0, %1, x0" \
        : "=r"(rd)                                                                   \
        : "r"(rs1));                                                                 \
  }
