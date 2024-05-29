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
my $f_st   = "stimulus_top.txt";
my $f_sl   = "stimulus_left.txt";
my $f_sloc = "stimulus_local.txt";
my $f_ob   = "output_bottom.txt";
my $f_or   = "output_right.txt";
my $f_ot   = "output_top.txt";
my $f_ol   = "output_left.txt";
my $f_oloc = "output_local.txt";

#- Open outputs
our $ot   = open_output($f_ot);
our $or   = open_output($f_or);
our $ob   = open_output($f_ob);
our $ol   = open_output($f_ol);
our $oloc = open_output($f_oloc);

#- 
our $t_pkt   = 0;
our $l_pkt   = 0;
our $b_pkt   = 0;
our $r_pkt   = 0;
our $loc_pkt = 0;

print "Incoming packets at BOTTOM interface. Where did they go?\n";
my ($ctr_b, $err_b) = check_input($f_sb);
print"\n--------------\n";
print "Incoming packets at RIGHT interface. Where did they go?\n";
my ($ctr_r, $err_r) = check_input($f_sr);
print"\n--------------\n";
print "Incoming packets at TOP interface. Where did they go?\n";
my ($ctr_t, $err_t) = check_input($f_st);
print"\n--------------\n";
print "Incoming packets at LEFT interface. Where did they go?\n";
my ($ctr_l, $err_l) = check_input($f_sl);
print"\n--------------\n";
print "Incoming packets at LOCAL interface. Where did they go?\n";
my ($ctr_loc, $err_loc) = check_input($f_sloc);

my $total_in  = $ctr_b + $ctr_l + $ctr_t + $ctr_r + $ctr_loc; 
print "INPUT PACKETS\n";
print "Bottom input packets : $ctr_b, $err_b\n";
print "Left   input packets : $ctr_l, $err_l\n";
print "Top    input packets : $ctr_t, $err_t\n";
print "Right  input packets : $ctr_r, $err_r\n";
print "Local  input packets : $ctr_loc, $err_loc\n";
print "Total: $total_in\n";


my $total_out = $t_pkt + $l_pkt + $b_pkt +$r_pkt +$loc_pkt  ; 
print "OUTPUT PACKETS\n";
print "Top    output packets : $t_pkt\n";
print "Left   output packets : $l_pkt\n";
print "Bottom output packets : $b_pkt\n";
print "Right  output packets : $r_pkt\n";
print "Local  output packets : $loc_pkt\n";
print "Total: $total_out\n";


sub check_input{
   my $f = $_[0];

   open my $FH, '<', $f or die "Couldn't open file $f $!\n";
   
   my $pkt_count = 0;
   my $pkt_error = 0;
   my $pkt_last = 1;
   my $pkt_header;
   my $out_name = 'none';

   while(<$FH>){
      my $line = $_;
      chomp($line);

      if ($pkt_last==1){
         $pkt_last = 0;
         $pkt_header = 1;
      }

      if ($line ne "0, 0, 00000000"){
         if ($pkt_header) {
            my $status = 0;
            if (look_packet($line, $ot)){
               $status = 1;
               $out_name = 'top';
            }elsif (look_packet($line, $or)){
               $status = 1;
               $out_name = 'right';
            }elsif (look_packet($line, $ob)){
               $status = 1;
               $out_name = 'bottom';
            }elsif (look_packet($line, $ol)){
               $status = 1;
               $out_name = 'left';
            }elsif (look_packet($line, $oloc)){
               $status = 1;
               $out_name = 'local';
            }
            if ($status){
               print "New packet at output $out_name : $line ";
            }else{
               #die "Couldn't find the packet $line\n";
               print "ERROR: Couldn't find the packet $line ";
               $pkt_error = $pkt_error + 1;
            }
            $pkt_header = 0;
         }else{
            my $status = 0;
            if ($out_name eq 'top'){
               look_packet($line, $ot);
               $status = 1;
            }elsif ($out_name eq 'right'){
               look_packet($line, $or);
               $status = 1;
            }elsif ($out_name eq 'bottom'){
               look_packet($line, $ob);
               $status = 1;
            }elsif ($out_name eq 'left'){
               look_packet($line, $ol);
               $status = 1;
            }elsif ($out_name eq 'local'){
               look_packet($line, $oloc);
               $status = 1;
            }

            if ($line =~ /1, 1,/){
               if ($out_name eq 'top'){
                  $t_pkt = $t_pkt + 1;
               }elsif ($out_name eq 'right'){
                  $r_pkt = $r_pkt + 1;
               }elsif ($out_name eq 'bottom'){
                  $b_pkt = $b_pkt + 1;
               }elsif ($out_name eq 'left'){
                  $l_pkt = $l_pkt + 1;
               }elsif ($out_name eq 'local'){
                  $loc_pkt = $loc_pkt + 1;
               }

               $pkt_last = 1;
               $pkt_count = $pkt_count + 1;
               $out_name = 'none';
               if ($status) {
                  print "$line\n";
               }else{
                  print " ERROR $line\n";
               }
            }else{
               if ($status){
                  print "$line ";
               }else{
                  print " ERROR $line ";
               }
            }
         }
      }#else{
      #  print "IGNORE $line\n";
      #}
   }
   close($FH);

   print "Total packets found: $pkt_count\n";
   print "Total packets not found: $pkt_error\n";
   return $pkt_count, $pkt_error;
}

sub look_packet{
   my $line = $_[0];
   my $out = $_[1];

   if ($out =~ $line){
      return 1;
   }else{
      return 0;
   }

}

sub open_output{
   my $f = $_[0];

   my @s;
   open my $FH, '<', $f or die "Couldn't open file $f $!\n";
   chomp(@s = <$FH>);
   close $FH;
   my $line = join("\n", @s);
   return $line;
}
