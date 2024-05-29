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

$param{'r'}      = 7;
#$param{'c'}      = 4;
$param{'c'}      = 8;

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
$param{'tile_array'} = \@tile_array;

$param{'keep'}   = 1; 
$param{'clean'}  = 1;

#$param{'c_code'} = "pico_scratchpad_ddr4";
$param{'c_code'} = "async_trisolve";
#$param{'c_code'} = "spmv";
gen_code(\%param);

#$param{'c_code'} = "data";
#gen_code(\%param);

