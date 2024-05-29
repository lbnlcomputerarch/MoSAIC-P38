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
use lib "$ENV{PWD}/../picorv_c/c_fp_acc";
use gen_mosaic;
use gen_hex;
use POSIX;


###########################################
#- Set hash for parameters: Do not modify
###########################################

%param;

###########################
# Adding new accelerators
###########################

#- Create structure to hold new types of tile (Needed)
%new_tile;

#- Pair the verilog file with an alias for each new tile (User)
$new_tile{'fp_add'} = 'Tile_fp_adder';
$new_tile{'fp_mul'} = 'Tile_fp_multiplier';
$new_tile{'fp_div'} = 'Tile_fp_divider';
$new_tile{'fp_sqr'} = 'Tile_fp_sqrt';

#- Add it to the parameters (Needed)
$param{'new_tile'} = \%new_tile;
###########################################
#- Test case: Modify
###########################################

$path = `pwd`;
chomp($path);
$fw_path = "$path/../picorv_c/c_fp_acc";
$param{'firmware_path'} = $fw_path;  
#$c_file = 'pico_spad_fp';
#$c_file = 'pico_add';
#$c_file = 'pico_add1';
$c_file = 'pico_add4';

#- 2x2 Tile array
#$param{'r'} = 2;
#$param{'c'} = 3;
#@tile_array = (['pico',    'spad',  'fp_div'],
#               ['fp_mul', 'fp_add', 'fp_sqr']);
               #00 08 16
               #01 09 17
#@pico_program  = ("${c_file}32_0.hex", '', '', '', 
#                  '', '', '', '');

$param{'r'} = 8;
$param{'c'} = 8;
$param{'c_file'} = $c_file;

#- Generate tile array
($ta, $pp) =generic_tile_array(\%param);
@tile_array = @{$ta};
@pico_program = @{$pp};

#@tile_array = ();
#@pico_program = ();
#for ($i=0; $i<$param{'r'}; $i=$i+1){
#   @row = ();
#   for ($j=0; $j<$param{'c'}; $j=$j+1){
#      $id = $j*8 + $i;
#      push(@row,   'pico');
#      push(@pico_program, "${c_file}32_$id.hex");
#   }
#   push(@tile_array,[@row]);
#}

$tile_array[0][1] = 'spad';   $pico_program[1]  = 'nop.hex'; # spad
$tile_array[1][1] = 'fp_mul'; $pico_program[$param{'c'}+1]  = '';        # mult
$tile_array[2][1] = 'fp_add'; $pico_program[2*$param{'c'}+1] = '';        # add
$tile_array[3][1] = 'fp_div'; $pico_program[3*$param{'c'}+1] = '';        # div
$tile_array[4][1] = 'fp_sqr'; $pico_program[4*$param{'c'}+1] = '';        # sqrt
$tile_array[2][2] = 'spad';   $pico_program[2*$param{'c'}+2] = 'nop.hex'; # spad
print_tile_array(\%param, \@tile_array, \@pico_program);

#For debugging
#foreach $item (@tile_array){
#   @row = @{$item};
#   foreach $item1 (@row){
#      print "$item1, ";
#   } 
#   print "\n";
#}
#print "\n";

#For debugging
#$id=0;
#for ($i=0; $i<$param{'r'}; $i=$i+1){
#   for ($j=0; $j<$param{'c'}; $j=$j+1){
#      print "$pico_program[$id], ";
#      $id = $id + 1;
#   }
#   print "\n";
#}
#print "\n";

#- Simulation Time
$param{'sim_loop'}     = 1000;
#- Checkers
@checkers = ('check_fp_adder.sh');

#- Default for this one is 8
$param{'noc_buffer_addr_w'} = 11;

#- Running with Icarus
$param{'vivado'}         = 1;  #- Generate files for Vivado
$param{'vivado_project'} = 0;  #- Create a new project (batch mode)
$param{'run_sim'}        = 0;  #- Run the simulation (batch mode)
$param{'board'}          = 'u250';

#- generate hex files
chdir $fw_path or die "$!. $fw_path\n";
#$cmd = "make SRC_FNAME=$c_file";
#`$cmd`;
%param_h;
$param_h{'c_code'} = $c_file;
$param_h{'r'} = $param{'r'}; 
$param_h{'c'} = $param{'c'};             
$param_h{'keep'} = 1; 
$param_h{'clean'} = 1;
$param_h{'tile_array'} = \@tile_array;
gen_code(\%param_h);
chdir $path or die "$!. $path\n";

#- Use AXI instead of force (Slow init)
$param{'init_mem_tile_axi'} = 1;

###########################################
#- Generate: Do not modify  
###########################################

$param{'checkers'} = \@checkers;
$param{'testcase'} = $0;
$param{'tile_array'} = \@tile_array;
$param{'pico_program'} = \@pico_program; 

gen_all(\%param);
