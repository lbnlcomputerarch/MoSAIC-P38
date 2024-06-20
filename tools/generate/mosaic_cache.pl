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

###########################################
#- Do not modify
###########################################

use lib "$ENV{PWD}";
use lib "$ENV{PWD}/../picorv_c/c_cache";
#use lib "$ENV{PWD}/../picorv_c/c_fp";
use gen_mosaic;
use gen_hex;
use POSIX;

#- Set hash for parameters
%param;

###########################################
#- Test case: Modify
###########################################

#-- Grab current path
$path = `pwd`;
chomp($path);
print "INFO: Current directory: $path\n";
#-- Firmware path
$fw_path = "$path/../picorv_c/c_cache";
#$fw_path = "$path/../picorv_c/c_fp";
$param{'firmware_path'} = $fw_path;
#-- C code for the PICORV32
$c_file = 'send_msg';
#$c_file = 'fbench_ansi';

$param{'r'} = 4;
$param{'c'} = 4;
$param{'c_file'} = $c_file;
$param{'instruction_mem'} = 1;

#-- Generate tile array
($ta, $pp) = generic_tile_array(\%param);
@tile_array = @{$ta};
@pico_program = @{$pp};
$tile_array[0][1] = 'spad';
$pico_program[1]  = 'nop.hex'; # spad
print_tile_array(\%param, \@tile_array, \@pico_program);

#-- Simulation Time
$param{'sim_loop'} = 800;

#-- Generate hex code
print "INFO: changing to $fw_path\n";
chdir $fw_path  or die "Couldn't go to $fw_path $!\n";

$array_sz = $param{'r'}*$param{'c'};
open (my $FH, '>', 'input_defines.h') or die "Couldn't open input_defines.h $!\n";
print $FH "\#ifndef TILE_N\n";
print $FH "\t\#define TILE_N $array_sz\n";
print $FH "\#endif\n";
close($FH);

my %param_h;
$param_h{'c_code'} = $c_file;
$param_h{'tile_array'} = \@tile_array;
print "INFO: Generating hex files from $param_h{'c_code'}\n";
$param_h{'r'}      = $param{'r'}; 
$param_h{'c'}      = $param{'c'};  
$param_h{'keep'}   = 1;                
$param_h{'clean'}  = 1;
$param_h{'instruction_mem'} = 1;
gen_code(\%param_h);

system("cp *.hex $path/../../src/Tile.HDL/picorv32_tile/firmware/"); 
chdir $path or die "Couldn't get back to $path $!\n";

#-- ddr4 parameters
$param{'ddr4_flag'}       = 1;   #- Yes, Tile memory manager
$param{'ddr_cache_lines'} = 8;
$param{'ddr_init_file'} = 'send_msg_0_inst.hex';
#$param{'ddr_init_file'} = 'fbench_ansi_0_inst.hex';

#-- Running with Vivado
$param{'vivado'}         = 1;  
$param{'board'}          = 'u250';
$param{'vivado_ip_dram'} = 1;   #- Yes, DDR4 memory controller
$param{'vivado_project'} = 0;
$param{'run_sim'}        = 0;

###########################################
#- Generate: Do not modify  
###########################################

$param{'testcase'}     = $0;
$param{'tile_array'}   = \@tile_array;
$param{'pico_program'} = \@pico_program; 

gen_all(\%param);
