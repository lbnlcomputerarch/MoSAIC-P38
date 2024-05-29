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

use strict;

my $f_sb   = "stimulus_bottom.txt";
my $f_sr   = "stimulus_right.txt";

my $f_ob   = "output_bottom.txt";
my $f_or   = "output_right.txt";


#- Open outputs
our $or   = open_output($f_or);

our $ob   = open_output($f_ob);

my ($ctr_b, $err_b) = check_input($f_sb); 
print"\n================\n";
my ($ctr_r, $err_r) = check_input($f_sr); 
print"\n================\n";

my $total_in  = $ctr_b + $err_b + $ctr_r + $err_r; 
print "INPUT PACKETS\n";
print "                     |Good|Bad|\n";
print "Bottom input packets : $ctr_b, $err_b\n";
print "Right  input packets : $ctr_r, $err_r\n";
print "Total: $total_in\n";


sub check_input{
   my $f = $_[0];

   open my $FH, '<', $f or die "Couldn't open file $f $!\n";
   
   my $pkt_count = 0;
   my $pkt_error = 0;
   my $pkt_last = 1;
   my $pkt_header;
   my $pkt_address_1;
   my $pkt_address_2;
   my $out_name = 'none';
   my $pkt_in  = '';
   my $pkt_out = '';

   while(<$FH>){
      my $line = $_;
      chomp($line);

      if ($pkt_last==1){
         $pkt_last = 0;
         $pkt_header = 1;
         $pkt_address_1 = 0;
         $pkt_address_2 = 0;
         $pkt_out = '';
         $pkt_in='';
      }

      if ($line ne "0, 0, 00000000"){
         if ($pkt_header) {
            $pkt_header = 0;
            $pkt_address_1 = 1;
            $pkt_in = $line; 
         }elsif ($pkt_address_1){
            $pkt_address_1 = 0;
            $pkt_address_2 = 1;
            $pkt_in=$pkt_in."\n".$line;
         }elsif ($pkt_address_2){
            ($pkt_out, $out_name)  = look_packet_all($line);
            if ($pkt_out == 0){
               $pkt_in="PACKET NOT FOUND\n".$pkt_in;
               $pkt_error= $pkt_error + 1;
            }else{
               $pkt_in="FOUND at $out_name:\n".$pkt_in;
               $pkt_count = $pkt_count + 1;
            }
            $pkt_address_2 = 0;
            $pkt_in=$pkt_in."\n".$line;
         }else{
            $pkt_last = 1;
            $pkt_in=$pkt_in."\n".$line;
            #$pkt_out =~ s/\n/ /g;
            print "$pkt_in\nOUTPUT\n $pkt_out\n--------------\n";
         }
      }
   }

   return $pkt_count, $pkt_error;
}
      

sub look_packet_all{
   my $line = $_[0];

   my $pkt_out = look_packet($line, $or);
   if ($pkt_out ne '0'){
      return $pkt_out, 'right';
   }

   my $pkt_out = look_packet($line, $ob);   
   if ($pkt_out ne '0'){
      return $pkt_out, 'bottom';
   }

   return '0','none';
}


sub look_packet{
   my $line = $_[0];
   my $out = $_[1];
   if ($out =~ /(1, 0, 19080400\n)($line\n)((1, 0, [A-Fa-f0-9]{8}\n){15})(1, 1, [A-F a-f 0-9]{8}\n)/){
      return "$1$2$3$5";
   }else{
      return '0';
   }

}
sub open_output{
   my $f = $_[0];

   my @s;
   open my $FH, '<', $f or print "Couldn't open file $f $!\n";
   chomp(@s = <$FH>);
   close $FH;
   my $line = join("\n", @s);
   #print "$line\n";
   return $line;
}
