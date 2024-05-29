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



##########################
# Do not modify
##########################
use lib "$ENV{PWD}";
use gen_hex;
use POSIX;
my %param;

##########################
# Modify
##########################

$param{'c_code'} = "pico_add5"; #- C code

$param{'keep'}   = 1;            
$param{'clean'}  = 1;

$param{'r'} = 8;
$param{'c'} = 8;
@tile_array = ();
for ($i=0; $i<$param{'r'}; $i=$i+1){
   @row = ();
   for ($j=0; $j<$param{'c'}; $j=$j+1){
      $id = $j*8 + $i;
      push(@row,   'pico');
   }
   push(@tile_array,[@row]);
}

$tile_array[0][1] = 'spad';   
$tile_array[1][1] = 'fp_mul'; 
$tile_array[2][1] = 'fp_add';
if ($param{'r'}>3){
   $tile_array[3][1] = 'fp_div'; 
   $tile_array[4][1] = 'fp_sqr';
}
$tile_array[2][2] = 'spad';   

##########################
# Do not modify
##########################
$param{'tile_array'} = \@tile_array;
gen_code(\%param);




