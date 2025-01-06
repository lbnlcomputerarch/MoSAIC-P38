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

################################################
# Author      : Patricia Gonzalez-Guerrero
# Email       : lg4er@lbl.gov
# Date        : Jan 3 2025
# Description : 
# This testcase is used to verify functionality 
# of the NoC BW and BWB parameters to change the 
# NOC bus width.
################################################


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

#- 2x2 Tile array
$param{'r'} = 2;
$param{'c'} = 2;

$case = 1;    # 0 uses 4 spads, 1 uses 1 spad and 1 loop
$noc_bw = 64; # use 32 or 64

if ($case == 0){
   @tile_array = (['spad', 'spad'],
                  ['spad', 'spad']);
}else{
   @tile_array = (['spad', 'loop'],
                  ['loop', 'loop']);
}

#- Packets
$param{'packet_file'} = "Packet_nocbw_32.axi"; 
$param{'noc_bw'}      = $noc_bw;
if ($param{'noc_bw'} == 64){
   $param{'packet_file'} = "Packet_nocbw_64.axi"; 
}else{
   $param{'packet_file'} = "Packet_nocbw_32.axi"; 
}
#- No program because there are no picos
@pico_program  = ('', '', '', '');
#- Simulation Time
$param{'sim_loop'}     = 150;

#- Checkers
#@checkers = ('check_pico_spad.sh');

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
