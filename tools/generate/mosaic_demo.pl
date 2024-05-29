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
#!/usr/bin/perl

use lib "$ENV{PWD}";
use lib "$ENV{PWD}/../picorv_c/c_trisolver";
use gen_mosaic;
use gen_hex;
use POSIX;

###########################################
#- Set hash for parameters: Do not modify
###########################################

%param;

############################
#- Test case: Modify
############################

#- Set the path for the hex code
$path = `pwd`;
chomp($path);
$fw_path = "$path/../picorv_c/c_trisolver";
$param{'firmware_path'} = $fw_path; 

#- 2x2 Tile array
#$c_file = 'pico_scratchpad_ddr4';
$c_file = 'async_trisolve';
$param{'r'} = 7;
$param{'c'} = 8;
$param{'c_file'} = $c_file;

#- Generate tile array
($ta, $pp) =generic_tile_array(\%param);
@tile_array = @{$ta};
@pico_program = @{$pp};

$tile_array[0][1] = 'spad';

#for ($i=0; $i<$param{'r'}*$param{'c'}; $i=$i+1){
#   push(@pico_program,"nop.hex");
#}

#- Simulation Time
$param{'sim_loop'}     = 1000;

#- Stimulus 
$param{'packet_file'}  = "Packet_in_cache.axi";

#- ddr4 parameters
$param{'ddr4_flag'}       = 1;   #- Yes, Tile memory manager
$param{'ddr_cache_lines'} = 8;
$param{'ddr_init_file'} = 'test_tile_nop.hex';

#- Checkers
@checkers;
push(@checkers,'check_pico_spad.sh');
push(@checkers,'check_pico_ddr4_ctrl.sh');
push(@checkers,'check_pkt_cache.sh');

#- Running with Vivado
$param{'vivado'}         = 1;  
$param{'board'}          = 'u280';
$param{'vivado_ip_dram'} = 1;   #- Yes, DDR4 memory controller
$param{'vivado_project'} = 0;
$param{'run_sim'}        = 0;

#- Generate hex code
chdir $fw_path or die "$!. $fw_path\n";
%param_h;
$param_h{'c_code'} = $c_file;
$param_h{'r'} = $param{'r'}; 
$param_h{'c'} = $param{'c'};             
$param_h{'keep'} = 1; 
$param_h{'clean'} = 1;
$param_h{'tile_array'} = \@tile_array;
gen_code(\%param_h);
chdir $path or die "$!. $path\n";

#############################
#- Generate: Do not modify  
#############################

$param{'testcase'} = $0;
$param{'checkers'} = \@checkers;
$param{'tile_array'} = \@tile_array;
$param{'pico_program'} = \@pico_program; 

gen_all(\%param);

