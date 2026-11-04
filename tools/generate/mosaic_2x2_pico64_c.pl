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

#- Phase 4 bring-up: same 2x2 as mosaic_2x2_pico64.pl, but tile 00 boots
#- hello64.hex — the C firmware built by the RV64 toolchain in
#- tools/picorv_c/c64 (single-ELF, D22/D23) and repacked by hex8tohex64.py
#- (D24). hello.c builds 0xCAFEBABEDEADBEEF and stores it with sd to byte
#- address 0x800 (word64 index 256), then spins.

#- 2x2 Tile array
$param{'r'} = 2;
$param{'noc_bw'} = 64;
$param{'c'} = 2;

@tile_array = (['pico64', 'spad'],
               ['loop', 'pico']);

@pico_program  = ('hello64.hex', '', '', 'test_tile_nop.hex');

#- Simulation Time
$param{'sim_loop'}     = 260;

#- Checkers
@checkers = ('check_pico64_c.sh');

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
