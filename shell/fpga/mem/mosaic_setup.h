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
int nRows = 2;
int nCols = 2;

uint32_t packetRxCountRegister = 0x14;
uint32_t coordinatesRegister   = 0x10;

uint32_t tileAddresses [4][4] = {{0x000, 0x100}, 
			                        {0x200, 0x300}};

uint32_t tileAddress_mem = 0x400;
   
char file_name [4][4][40] = {
       {"pico_scratchpad_ddr4_miss32.hex", "test_tile_nop.hex"},
       {                     "", "test_tile_nop.hex"}};

uint32_t coordinates [4][4] = {{0x00, 0x08},
                               {0x01, 0x09}};

uint32_t coordinates_mem = 0x002;

