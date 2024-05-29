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
#define DDR4

int nRows = 7;
int nCols = 8;

uint32_t packetRxCountRegister = 0x14;
uint32_t coordinatesRegister   = 0x10;

uint32_t tileAddresses [7][8] = {{0x0000, 0x0040, 0x0080, 0x00C0, 0x0100, 0x0140, 0x0180, 0x01C0},
											{0x0200, 0x0240, 0x0280, 0x02C0, 0x0300, 0x0340, 0x0380, 0x03C0},
											{0x0400, 0x0440, 0x0480, 0x04C0, 0x0500, 0x0540, 0x0580, 0x05C0},
											{0x0600, 0x0640, 0x0680, 0x06C0, 0x0700, 0x0740, 0x0780, 0x07C0},
											{0x0800, 0x0840, 0x0880, 0x08C0, 0x0900, 0x0940, 0x0980, 0x09C0},
											{0x0A00, 0x0A40, 0x0A80, 0x0AC0, 0x0B00, 0x0B40, 0x0B80, 0x0BC0},
											{0x0C00, 0x0C40, 0x0C80, 0x0CC0, 0x0D00, 0x0D40, 0x0D80, 0x0DC0}};

uint32_t tileAddress_mem = 0x0E00;

char file_name [7][8][30] = {
										{"async_trisolve32_0.hex", "", "async_trisolve32_16.hex", "async_trisolve32_24.hex", "async_trisolve32_32.hex", "async_trisolve32_40.hex", "async_trisolve32_48.hex", "async_trisolve32_56.hex"},
										{"async_trisolve32_1.hex", "async_trisolve32_9.hex", "async_trisolve32_17.hex", "async_trisolve32_25.hex", "async_trisolve32_33.hex", "async_trisolve32_41.hex", "async_trisolve32_49.hex", "async_trisolve32_57.hex"},
										{"async_trisolve32_2.hex", "async_trisolve32_10.hex", "async_trisolve32_18.hex", "async_trisolve32_26.hex", "async_trisolve32_34.hex", "async_trisolve32_42.hex", "async_trisolve32_50.hex", "async_trisolve32_58.hex"},
										{"async_trisolve32_3.hex", "async_trisolve32_11.hex", "async_trisolve32_19.hex", "async_trisolve32_27.hex", "async_trisolve32_35.hex", "async_trisolve32_43.hex", "async_trisolve32_51.hex", "async_trisolve32_59.hex"},
										{"async_trisolve32_4.hex", "async_trisolve32_12.hex", "async_trisolve32_20.hex", "async_trisolve32_28.hex", "async_trisolve32_36.hex", "async_trisolve32_44.hex", "async_trisolve32_52.hex", "async_trisolve32_60.hex"},
										{"async_trisolve32_5.hex", "async_trisolve32_13.hex", "async_trisolve32_21.hex", "async_trisolve32_29.hex", "async_trisolve32_37.hex", "async_trisolve32_45.hex", "async_trisolve32_53.hex", "async_trisolve32_61.hex"},
										{"async_trisolve32_6.hex", "async_trisolve32_14.hex", "async_trisolve32_22.hex", "async_trisolve32_30.hex", "async_trisolve32_38.hex", "async_trisolve32_46.hex", "async_trisolve32_54.hex", "async_trisolve32_62.hex"}};

uint32_t coordinates [7][8] = {{0x0000, 0x0008, 0x0010, 0x0018, 0x0020, 0x0028, 0x0030, 0x0038},
										 {0x0001, 0x0009, 0x0011, 0x0019, 0x0021, 0x0029, 0x0031, 0x0039},
										 {0x0002, 0x000A, 0x0012, 0x001A, 0x0022, 0x002A, 0x0032, 0x003A},
										 {0x0003, 0x000B, 0x0013, 0x001B, 0x0023, 0x002B, 0x0033, 0x003B},
										 {0x0004, 0x000C, 0x0014, 0x001C, 0x0024, 0x002C, 0x0034, 0x003C},
										 {0x0005, 0x000D, 0x0015, 0x001D, 0x0025, 0x002D, 0x0035, 0x003D},
										 {0x0006, 0x000E, 0x0016, 0x001E, 0x0026, 0x002E, 0x0036, 0x003E}};

uint32_t coordinates_mem = 0x0007;
