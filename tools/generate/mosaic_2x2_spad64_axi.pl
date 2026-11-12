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

#- BW=64 scratchpad AXI control-plane test. Tile 01 is a spad preloaded
#- entirely through the 32-bit AXI interface; all other tiles are passive
#- loops. Each pair of 32-bit writes in spad64_axi32.hex must merge into
#- one 64-bit RAM word, preserving the other byte lanes.

#- 2x2 Tile array
$param{'r'} = 2;
$param{'noc_bw'} = 64;
$param{'c'} = 2;

@tile_array = (['loop', 'spad'],
               ['loop', 'loop']);

@pico_program  = ('', 'spad64_axi32.hex', '', '');
$path = `pwd`;
chomp($path);
$param{'firmware_path'} = "$path/../../src/Tile.HDL/picorv64_tile/firmware";
$param{'init_mem_tile_axi'} = 1;

#- Simulation Time
$param{'sim_loop'}     = 260;

#- Checkers
@checkers = ('check_spad64_axi.sh');

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
