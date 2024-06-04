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
# works, and perform publicly and display publicly, and to permit others 
# to do so.
#
# *************************************************************************

use lib "$ENV{PWD}";
use gen_mosaic;
use POSIX;

#########################################
#- Set hash parameters: Do not modify
#########################################

%param;

###########################################
#- Test case: Modify
###########################################

$param{'r'} = 4;
$param{'c'} = 4;

@tile_array = (['pico', 'pico', 'pico', 'pico'],
               ['pico', 'pico', 'pico', 'pico'],
               ['pico', 'pico', 'pico', 'pico'],
               ['pico', 'pico', 'pico', 'pico']);

$path = `pwd`;
chomp($path);
$fw_path = "$path/../picorv_c/c";

$param{'firmware_path'} = $fw_path; 

@pico_program = ('pico_scratchpad_ddr_4x432.hex', 'test_tile_nop.hex', 'test_tile_nop.hex', 'test_tile_nop.hex',
                 'test_tile_nop.hex', 'test_tile_nop.hex', 'test_tile_nop.hex', 'test_tile_nop.hex',
                 'test_tile_nop.hex', 'test_tile_nop.hex', 'test_tile_nop.hex', 'test_tile_nop.hex',
                 'test_tile_nop.hex', 'test_tile_nop.hex', 'test_tile_nop.hex', 'test_tile_nop.hex');


#- Simulation Time
$param{'sim_loop'} = 400;

#- Stimulus
$param{'packet_file'}  = "Packet_in_cache.axi";

#- DDR4 support
$param{'ddr4_flag'} = 1;  #- Yes, Tile memory manager
$param{'ddr4_init_file'} = 'test_tile_nop.hex';

@checkers;
push(@checkers,'check_pico_spad.sh');
push(@checkers,'check_pico_ddr4_ctrl.sh');
push(@checkers,'check_pkt_cache.sh');

#- Running with icarus
$param{'run_sim'}        = 1;

#- generate hex code
chdir $fw_path or die "$!. $fw_path\n";
$cmd = "make SRC_FNAME=pico_scratchpad_ddr_4x4";
`$cmd`;
$cmd = "cp $path/../../src/Tile.HDL/picorv32_tile/firmware/test_tile_nop.hex .";
`$cmd`;
chdir $path or die "$!. $path\n";

#####################################
#- Generate: Do not modify
#####################################

$param{'testcase'}     = $0;
$param{'checkers'}     = \@checkers;
$param{'tile_array'}   = \@tile_array;
$param{'pico_program'} = \@pico_program; 

gen_all(\%param);
