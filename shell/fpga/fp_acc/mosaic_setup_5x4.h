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
uint32_t packetRxCountRegister = 0x14;
uint32_t coordinatesRegister   = 0x10;

int nRows = 5;
int nCols = 4;

uint32_t tileAddresses [5][4] = {{0x000, 0x080, 0x100, 0x180}, 
			                        {0x200, 0x280, 0x300, 0x380},
			                        {0x400, 0x480, 0x500, 0x580},
			                        {0x600, 0x680, 0x700, 0x780},
			                        {0x800, 0x880, 0x900, 0x980}
                                };
   
char file_name [5][4][30] = {
       {"pico_spad_fp32_0.hex", "nop.hex", "pico_spad_fp32_16.hex", "pico_spad_fp32_24.hex" },
       {"pico_spad_fp32_1.hex", "",        "pico_spad_fp32_17.hex", "pico_spad_fp32_25.hex" },
       {"pico_spad_fp32_2.hex", "",        "nop", "pico_spad_fp32_26.hex" },
       {"pico_spad_fp32_3.hex", "",        "pico_spad_fp32_19.hex", "pico_spad_fp32_27.hex" },
       {"pico_spad_fp32_4.hex", "",        "pico_spad_fp32_20.hex", "pico_spad_fp32_28.hex" }
};

uint32_t coordinates [5][4] = {{0x00, 0x08, 0x10, 0x18},
                               {0x01, 0x09, 0x11, 0x19},
                               {0x02, 0x0a, 0x12, 0x1a},
                               {0x03, 0x0b, 0x13, 0x1b},
                               {0x04, 0x0c, 0x14, 0x1c},
};


