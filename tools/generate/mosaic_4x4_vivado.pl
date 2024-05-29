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
               ['pico', 'pico', 'pico', 'spad'],
               ['pico', 'pico', 'pico', 'pico']);

$path = `pwd`;
chomp($path);
$fw_path = "$path/../picorv_c/c_trisolver";

$param{'firmware_path'} = $fw_path;

@pico_program = ('async_trisolve32_0.hex', 'async_trisolve32_8.hex', 'async_trisolve32_16.hex',  'async_trisolve32_24.hex',
                 'async_trisolve32_1.hex', 'async_trisolve32_9.hex', 'async_trisolve32_17.hex',  'async_trisolve32_25.hex',
                 'async_trisolve32_2.hex', 'async_trisolve32_10.hex', 'async_trisolve32_18.hex', '',
                 'async_trisolve32_3.hex', 'async_trisolve32_11.hex', 'async_trisolve32_19.hex', 'data32_27.hex');


#- Simulation Time
$param{'sim_loop'} = 800;

#- Stimulus
$param{'packet_file'}  = "Packet_in_empty.axi";

#- DDR4 support
$param{'ddr4_flag'} = 1;  #- Yes, Tile memory manager
$param{'ddr4_init_file'} = 'test_tile_nop.hex';

#- Vivado
$param{'vivado'}         = 1;  
$param{'vivado_ip_dram'} = 1;
$param{'board'}          = 'u250';
$param{'vivado_project'} = 0;
$param{'run_sim'}        = 0;

@checkers;
push(@checkers,'check_pico_spad.sh');
push(@checkers,'check_pico_ddr4_ctrl.sh');
push(@checkers,'check_pkt_cache.sh');

#- generate hex code
chdir $fw_path or die "$!. $fw_path\n";
%param_h;
$param_h{'c_code'} = "async_trisolve"; #- C code
$param_h{'r'}      = $param{'r'}; 
$param_h{'c'}      = $param{'c'};
$param_h{'keep'}   = 1;         
$param_h{'clean'}  = 1;
gen_code(\%param_h);

$param_h{'c_code'} = "data"; #- C code
gen_code(\%param_h);

chdir $path or die "$!. $path\n";

#####################################
#- Generate: Do not modify
#####################################

$param{'testcase'}     = $0;
$param{'checkers'}     = \@checkers;
$param{'tile_array'}   = \@tile_array;
$param{'pico_program'} = \@pico_program; 

gen_all(\%param);
