#!/usr/bin/perl
# *************************************************************************
#
# *** Copyright Notice ***
#
# P38 heterogeneous multi-tiled system with support for message queues
# (MoSAIC) Copyright (c) 2024, The Regents of the University of California,
# through Lawrence Berkeley National Laboratory (subject to receipt of
# any required approvals from the U.S. Dept. of Energy). All rights reserved.
#
# If you have questions about your rights to use or distribute this software,
# please contact Berkeley Lab's Intellectual Property Office at
# IPO@lbl.gov.
#
# NOTICE.  This Software was developed under funding from the U.S. Department
# of Energy and the U.S. Government consequently retains certain rights.  As
# such, the U.S. Government has been granted for itself and others acting on
# its behalf a paid-up, nonexclusive, irrevocable, worldwide license in the
# Software to reproduce, distribute copies to the public, prepare derivative
# works, and perform publicly and display publicly.
#
# *************************************************************************

use lib "$ENV{PWD}";
use gen_mosaic;
use POSIX;

###########################################
#- Set hash for parameters: Do not modify
###########################################

%param;

###########################################
#- Test case: Modify
###########################################

#- pico64 scratchpad test: RV64 twin of mosaic_2x2.pl (D-flow).
#- Tile 00 (pico64) boots pico64_scratchpad.hex: 16x mPut of a 64-bit
#- 0xCAFECACECAFECACE+i pattern into the spad tile 01 (word32 0x100+2i)
#- and 16x plain 64-bit remote pointer stores of 0xF00DF00DF00DF00D+i
#- (word32 0x15A+2i), then reads it all back with 16x mGet (responses
#- land at local word32 0x180+2i) and 16x remote pointer loads (local
#- word32 0x1DA+2i). The spad tile is BW-parameterized and gets
#- BW=NOC_BW=64, so every beat is a full 64-bit word (no truncation).

#- 2x2 Tile array
$param{'r'} = 2;
$param{'noc_bw'} = 64;
$param{'c'} = 2;

@tile_array = (['pico64', 'spad'],
               ['loop', 'pico']);

@pico_program  = ('pico64_scratchpad64.hex', '', '', 'test_tile_nop.hex');

#- Simulation Time
$param{'sim_loop'}     = 260;

#- Checkers
@checkers = ('check_pico64_spad.sh');

#- Running with Icarus
$param{'run_sim'} = 1;

###########################################
#- Generate: Do not modify
###########################################

$param{'checkers'} = \@checkers;
$param{'testcase'} = $0;
$param{'tile_array'} = \@tile_array;
$param{'pico_program'} = \@pico_program;

gen_all(\%param);
