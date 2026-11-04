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
# works and perform publicly and display publicly.
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

#- Phase 3 bring-up: pico64 tiles on the 64-bit NoC (plan D21)
#- Tile 00 (pico64) boots pico64_hello.hex: builds 0xCAFEBABEDEADBEEF
#- in x6, stores it with sd to byte address 64 (word64 index 8), spins.
#- Tile 11 (pico) runs the legacy nop program at 32-bit truncation (D3/D14).

#- 2x2 Tile array
$param{'r'} = 2;
$param{'noc_bw'} = 64;
$param{'c'} = 2;

@tile_array = (['pico64', 'spad'],
               ['loop', 'pico']);

@pico_program  = ('pico64_hello.hex', '', '', 'test_tile_nop.hex');

#- Simulation Time
$param{'sim_loop'}     = 260;

#- Checkers
@checkers = ('check_pico64_hello.sh');

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
