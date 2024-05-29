#!/usr/bin/perl

use strict;
use Getopt::Long;

our $cfile;

GetOptions(
    'cfile=s' => \$cfile,
);

if ($cfile) {
}else{
   die "Specify c file\n";
}

#our $cfile = "spmv";
#our $cfile = "async_trisolve";
our $elf_file = "${cfile}_0.readelf";

if (-e $elf_file){
}else{
   die "$elf_file does not exist\n";
}

get_mem_data();
get_edges();
get_output_py('data_v');
get_output_py('start_idx');
get_output_py('idx');
get_output_py('x_glob');
get_n_py();
get_output_py('gl_num_qPuts');
get_output_py('gl_num_qGets');
get_output_py('gl_n_loc');
get_output_py('gl_th_i');
get_output_py('gl_tl_i');
get_output_py('gl_th_f');
get_output_py('gl_tl_f');

sub get_output{
   my $var = $_[0];
   my ($addr, $size) = get_var_info($var);
   my $file = "mem_spad_r0c1.dat";
   my $n = $addr + $size -1;
   my $cmd = "sed -n \'$addr\,${n}p\' $file";
   my @cmd_r = `$cmd`;
   my $tid = 0;
   foreach my $i (@cmd_r){
      chomp($i);
      my $num = hex($i);
      print "$tid : $num\n";
      $tid = $tid + 1;
   }
}



sub get_n_py{
   my $file = "mem_spad_r0c1.dat";
   my $cmd="sed -n \'6p\' $file";
   my $line = `$cmd`;
   chomp($line);
   my $n = hex($line);
   open (my $FH, '>', "m_rows.py") or die "$!\n";
   print $FH "def get_m_rows():\n";
   print $FH "\treturn $n\n";
   close($FH);
   
}

sub get_output_py{
   my $var = $_[0];
   my ($addr, $size) = get_var_info($var);
   my $file = "mem_spad_r0c1.dat";
   my $n = $addr + $size -1;
   my $cmd = "sed -n \'$addr\,${n}p\' $file";
   my @cmd_r = `$cmd`;
   my $new_line = '';
   my $f = 0;
   foreach my $i (@cmd_r){
      chomp($i);
      if ($f==0){
         $new_line = $new_line."0x$i";
         $f=1;
      }else{
         $new_line = $new_line.", 0x$i";
      }
   }
   $new_line =~ s/\(\[\,/\(\[/g;
   open (my $FH, '>', "${var}.py") or die "$!\n";
   print $FH "import numpy as np\n";
   print $FH "def get_$var():\n";
   print $FH "\t$var = np.array([$new_line])\n";
   print $FH "\treturn $var\n";
   close($FH);
}

sub get_mem_data{
   my $file = "read_mem.log"; #- Log file with memory content
   open(my $FH, '<', $file) or die "Couldn't open $file $!\n";
   my $FH1;
   while(<$FH>){
      my $line = $_;
      chomp ($line);
      if ($line =~ m/NOW READING Data from (pico|spad) r(\d), c(\d)/){ #- Start new memory
         print "INFO: $line\n";
         #print "contains $1 and $2 and $3\n";
         my $file1 = "mem_${1}_r${2}c${3}.dat";
         open($FH1, '>', $file1) or die "Couldn't open $file1 $!\n";
      }elsif ($line =~ m/Data break/){ #- End that memory
         close ($FH1);
      }else{
         $line =~ s/Data that came back from the memory: //g;
         print $FH1 "$line\n";
      }
   }
   close($FH);
}

sub get_var_info{
   my $var = $_[0];
   my $offset = 32768;
   my $cmd = "grep $var $elf_file";
   my @cmd_r = `$cmd`;
   my $cmd_s = @cmd_r[0];
   my @cmd_a = split(/\s+/, $cmd_s);
   my $addr = $cmd_a[2];
   my $size = $cmd_a[3];
   my $name = $cmd_a[8];
   #print "$name, $size, $addr\n";
   $addr = hex($addr)/4 - $offset + 2;
   $size = $size/4;
   print "INFO: Variable: $name, Size: $size, Address: $addr\n";
   return $addr, $size;
}

sub get_matrix_parts{
   my $var = $_[0];
   my ($addr, $size) = get_var_info($var);
   my $file = "mem_spad_r0c1.dat";
   my $n = $addr + $size -1;
   my $file1 = "temp.dat";
   my $cmd = "sed -n \'$addr\,${n}p\' $file";
   my @cmd_r = `$cmd`;
   #print "### START: $var ###\n";
   #foreach my $i (@cmd_r){chomp($i); print "$i, ";}
   #print "\n### END: $var ###\n";
   my $new_line = '';
   my $f = 0;
   foreach my $i (@cmd_r){
      chomp($i);
      my $d;
      if ($i eq 'ffffffff'){$d=-1}
      else {$d = hex($i)}
      if ($f==0){
         $new_line = $new_line."$d";
         $f=1;
      }else{
         $new_line = $new_line.", $d";
      }
   }
   $new_line =~ s/\(\[\,/\(\[/g;
   print "$var = np.array([$new_line])\n";
}

sub get_edges{
   my ($addr, $size) = get_var_info('dest_glob');
   my $file = "mem_spad_r0c1.dat";
   my $n = $addr + $size;
   my $file1 = "temp.dat";
   my $cmd = "sed -n \'$addr\,${n}p\' $file > $file1";
   `$cmd`;
   my $rn = 7;
   my $cn = 8;
   open (my $FH, '>', 'edges.txt') or die "Couldn't open file edges.txt $!\n";  
   for (my $r=0; $r<$rn; $r = $r+1){
      for (my $c=0; $c<$cn; $c = $c+1){
         my $id = $r+($c*8);
         my $id_s =  $r+($c*$rn);
         if($id > 8) {$id_s = $id_s-1}

         my $ni = $id*10+1; 
         my $nf = $ni+10+1;
         my $cmd = "sed -n \'$ni\,${nf}p\' $file1";
         my @cmd_r = `$cmd`;
         foreach my $edge (@cmd_r){
            chomp($edge);
            if ($edge eq '00000000'){
               last;
            }else{
               my $num = hex($edge);
               $num = $num - 65536;
               print $FH "$id_s $num\n";
            }
         }
      }
   } 
   close($FH);
}


