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

$param{'c_code'} = "send_msg"; #- C code
$param{'r'}      = 2;                  #- Array 2x2
$param{'c'}      = 2;                  #- Array 2x2 
$param{'keep'}   = 1;                  #- Array 2x2 
$param{'clean'}  = 1;

##########################
# Do not modify
##########################
gen_code(\%param);
