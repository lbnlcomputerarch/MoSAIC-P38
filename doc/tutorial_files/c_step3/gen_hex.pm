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

package gen_hex;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(gen_code);
use POSIX;
use Cwd;
use strict;


##################################
#- Global variables: Modify maybe
##################################

our $addr_range = 16384;
our $temp_dir = "temp_files";
our $end = 8;

###############################
#- Subroutines: Do not modify
###############################

sub gen_code{
   my $param_p = $_[0];

   $param_p=check_params($param_p);

   my %param = %{$param_p};

   #- Generate code
   #- 8 in the loop is set by the three bit coordinate in mosaic_4k
   for (my $i=0; $i<$end; $i=$i+1){
      if ($i<$param{'r'}){
         for (my $j=0; $j<$end; $j=$j+1){
            if ($j<$param{'c'}){
              my $id = $i + $j*8;
               print "INFO: tile $id\n";
               gen_mem_map(\%param,$id);
               gen_start(\%param,$id);
               `make clean`;
               `make SRC_FNAME=$param{'c_code'}`;
               `mv $param{'c_code'}32.hex $param{'c_code'}32_$id.hex`;
               if ($param{'keep'}){
                `mv $param{'c_code'}.dissasembled $temp_dir/$param{'c_code'}_$id.dissasembled`;
                `mv $param{'c_code'}.readelf $temp_dir/$param{'c_code'}_$id.readelf`;
                `mv start.dissasembled $temp_dir/start_$id.dissasembled`;
                `mv start.readelf $temp_dir/start_$id.readelf`;
               }
               my $addr_hex = sprintf("%08x", ($id * $addr_range)/4);
               my @addr_hex_a = split('',$addr_hex);
               $addr_hex = join('',@addr_hex_a[0..4]);
               `sed -i s\/\@$addr_hex\/\@00000\/ $param{'c_code'}32_$id.hex`
            }
         }
      }
   }

   #- Cleaning 
   print "INFO: Cleaning up\n";
   clean($param_p,1);
}

sub check_params{
   my %param = %{$_[0]};

  ######################################
  # Go through each parameter one by one
  ######################################

  if (exists $param{'clean'}){
  }else{
     $param{'clean'} = 1;
  }

   if ($param{'clean'}){
      print "INFO: Cleaning up\n";
      clean(\%param,0);
   }

   if (exists $param{'keep'}){
   }else{
     $param{'keep'} = 0;
   }

   if ($param{'keep'}){
      if (-e "./$temp_dir"){
         print "INFO: Directory $temp_dir exists\n";
      }else{
         print "INFO: Creating $temp_dir directory\n";
         mkdir "./$temp_dir" or die "Couldn't create directory $temp_dir\n";
      }
   }

   if (exists $param{'c_code'}){
   }else{
      die 'Please provide a c file using \$param{\'c_code\'} = \'hello.c\'\n';
   }

   if (exists $param{'r'}){
   }else{
      print "INFO: Set the tile array size to default 4x4\n";
      $param{'r'} = 4;
   };

   if (exists $param{'c'}){
   }else{
      print "INFO: Set the tile array size to default 4x4\n";
      $param{'c'} = $param{'r'};
   };
   
   return \%param;

}

sub clean{
   my %param = %{$_[0]};
   my $f = $_[1];
   if ($f==0){
      `rm -rf $param{'c_code'}*.hex`;
      `rm -rf ./$temp_dir`;
   }else{
      if ($param{'keep'} == 1){
      }else{
         print "INFO: Removing $temp_dir\n";
         `rm -rf ./$temp_dir`;
      }
      `rm $param{'c_code'}.o`;
      `rm $param{'c_code'}.elf`;
      `rm start*`;
      `rm $param{'c_code'}.tmp`;
      `rm $param{'c_code'}.hex`;
   }
}


sub gen_mem_map{
   my %param = %{$_[0]};
   my $tile_id   = $_[1];
   my $file_name = "mem_layout.ld";
   #- Create file
   open (my $FH, '>', $file_name) or die "Couldn't open $file_name $!\n";
   print $FH "MEMORY\n";
   print $FH "{\n";
   print $FH "\tSPAD (rw)    : ORIGIN = 0x00068000, LENGTH = 0x004000\n";   
   print $FH "\tACC1 (rw)    : ORIGIN = 0x00040000, LENGTH = 0x004000\n";   
   my $addr_hex = sprintf("0x%X", $tile_id * $addr_range + 512);
   print $FH "\tLOCAL (xrw)  : ORIGIN = $addr_hex, LENGTH = 0x004000\n";
   print $FH "}\n";
   close ($FH);
   #- keep it
   if ($param{'keep'}){
      my $new_file = $file_name;
      $new_file =~ s/\.ld//;
      $new_file = "${new_file}_${tile_id}.ld";
      `cp $file_name $temp_dir/$new_file`
   }
}

sub gen_start{
   my $param = $_[0];
   my $tile_id = $_[1];
   gen_startLD($param,$tile_id);
   gen_startS($param,$tile_id);
}

sub gen_startLD{
   my %param = %{$_[0]};
   my $tile_id = $_[1];
   my $file_name = "start.ld";
   #- Create file
   open (my $FH, '>', $file_name) or die "Couldn't open $file_name $!\n";
   my $addr = $tile_id * $addr_range;
   my $addr_hex = sprintf("0x%x", $addr);
   print $FH "SECTIONS {\n";
   print $FH ". = $addr_hex;\n";
   print $FH ".text : { *(.text) }\n";
   $addr_hex = sprintf("0x%x", $addr+320);
   print $FH ". = $addr_hex;\n";
   print $FH ".data : { *(.data) }\n";
   $addr_hex = sprintf("0x%x", $addr+512);
   print $FH "_ftext = $addr_hex;\n";
   print $FH "}\n";
   close($FH);
   #- keep it
   if ($param{'keep'}){
      my $new_file = $file_name;
      $new_file =~ s/\.ld//;
      $new_file = "${new_file}_${tile_id}.ld";
      `cp $file_name $temp_dir/$new_file`
   }
}   

sub gen_startS{
   my %param = %{$_[0]};
   my $tile_id   = $_[1];
   my $file_name = "start.S";
   #- Create file
   open (my $FH, '>', $file_name) or die "Couldn't open $file_name $!\n";
   print $FH ".section .text\n";
   print $FH ".global _ftext\n";
   print $FH ".global _pvstart\n";
   print $FH "_pvstart:\n";
   my $addr = $tile_id * $addr_range;
   my $addr_hex = sprintf("0x%x", $addr + 20);
   print $FH "lui x30, %hi($addr_hex)\n";
   print $FH "addi x30, x30, %lo($addr_hex)\n";
   print $FH "jalr x30\n";
   print $FH "nop\n";
   print $FH "nop\n";
   print $FH "nop\n";
   #- Zero initialize all registers
   for (my $i=0; $i<30; $i=$i+1){
      print $FH "addi x$i, zero, 0\n";
   }
   print $FH "la x30, programName\n";
   print $FH "la x31, tileId\n";
   my $addr_h = (($tile_id +1)*$addr_range)-4; #FIXME
   #my $addr1 = (($addr_h-$addr)/2)+$addr;
   #print "$tile_id, $addr, $addr_h, $addr1\n";
   #$addr_hex = sprintf("0x%x", $addr1);
   #print $FH "lui x30, %hi($addr_hex)\n";
   #print $FH "addi x30, x30, %lo($addr_hex)\n";
   #print $FH "add x29,x29,x30\n";
   #print $FH "add x28,x28,x30\n";
   #print $FH "addi x30, zero, 0\n";
   #print $FH "addi x31, zero, 0\n"; 
   #- Set stack pointer
   $addr_hex = sprintf("0x%x", $addr_h);
   print $FH "lui sp, %hi($addr_hex)\n";
   print $FH "addi sp, sp, %lo($addr_hex)\n";
   #- push zeros on the stack for argc and argv
   #- (stack is aligned to 16 bytes in riscv calling convention)
   print $FH "addi sp,sp,-16\n";
   print $FH "sw zero,0(sp)\n";
   print $FH "sw zero,-4(sp)\n";
   print $FH "sw zero,-8(sp)\n";
   print $FH "sw zero,-12(sp)\n";
   print $FH "sw x30,4(sp)\n";
   print $FH "sw x31,8(sp)\n";
   #print $FH "addi x28, zero, 0\n";
   print $FH "addi x30, zero, 0\n";
   print $FH "addi x31, zero, 0\n";
   #- jump to libc init
   print $FH "j _ftext\n";
   print $FH ".data\n";
   print $FH "tileId: .ascii \"$tile_id\"\n";
   print $FH "programName: .ascii \"./$param{'c_code'}.c\"\n";
   close($FH);

   #- keep it
   if ($param{'keep'}){
      my $new_file = $file_name;
      $new_file =~ s/\.S//;
      $new_file = "${new_file}_${tile_id}.S";
      `cp $file_name $temp_dir/$new_file`
   }
}




print 
