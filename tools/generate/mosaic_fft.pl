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
use lib "$ENV{PWD}/../picorv_c/c_fft_acc";
use gen_mosaic;
use gen_hex;
use POSIX;

#- Set hash for parameters
%param;

###########################
# Adding new accelerators
###########################

#- Create structure to hold new types of tile (Needed)
%new_tile;

#- Pair the verilog file with an alias for each new tile (User)
$new_tile{'fft'} = 'Tile_fft';

#- Add it to the parameters (Needed)
$param{'new_tile'} = \%new_tile;

###########################################
#- Test case: Modify
###########################################

#- 2x2 Tile array
$path = "$ENV{PWD}";
$fw_path = "$path/../picorv_c/c_fft_acc";
$param{'r'} = 2;
$param{'c'} = 2;
$c_file = "send_msg"; 

@tile_array = (['pico', 'loop'],
               ['loop', 'fft']);

$param{'firmware_path'} = $fw_path;

@pico_program  = ("${c_file}32_0.hex", '',
                                   '', '');

#- Simulation Time
$param{'sim_loop'} = 8000;

#- Simulation Time
$param{'run_sim'} = 1;

#- Running with Vivado
$param{'vivado'}         = 1;
$param{'vivado_project'} = 1;
$param{'board'}          = 'u250';  #- u250 vs u280
$param{'run_sim'}        = 0;

#- Generate hex code
chdir $fw_path or die "$!. $fw_path\n";
%param_h;
$param_h{'c_code'} = $c_file;
$param_h{'r'}      = $param{'r'}; 
$param_h{'c'}      = $param{'c'};             
$param_h{'keep'}   = 1; 
$param_h{'clean'}  = 1;
$param_h{'tile_array'} = \@tile_array;
gen_code(\%param_h);
chdir $path or die "$!. $path\n";

###########################################
#- Generate: Do not modify
###########################################

$param{'testcase'}     = $0;
$param{'tile_array'}   = \@tile_array;
$param{'pico_program'} = \@pico_program;

gen_all(\%param);
