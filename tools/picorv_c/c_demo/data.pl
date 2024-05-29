#!/usr/bin/perl


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

$param{'c_code'} = "data"; #- C code
$param{'r'}    = 2;                  #- Array 4x4 
$param{'keep'} = 0;                  #- Array 4x4 
$param{'clean'} = 0;

##########################
# Do not modify
##########################
gen_code(\%param);
