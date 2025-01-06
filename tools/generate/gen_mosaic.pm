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
#!/usr/local/bin/perl
##################################################
# Notes: 
#  FIXME: The MosaicGlobal directory contains
#         the xilinx memory model and the Vivado 
#         boards repository downloaded through 
#         open-nic-shell
###################################################
package gen_mosaic;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(gen_all generic_tile_array print_tile_array);
use POSIX;
use Cwd;
use strict;

##################################
#- Global variables: Modify maybe
##################################

our $MosaicGlobal = "/home/lg4er/MosaicGlobal"; #FIXME: delete
our $vivado_version = "2022.2";                 #FIXME: delete

#- Set by open nic shell. Can be modified
our $axi_addr_range      = 4096;
our $axi_tile_addr_bits  = 8;
our $axi_tile_addr_range = 256;
our $axi_ux_addr         = 4;

our %tile_type = ( 'pico' => [0, 'Tile_picorv32'],
                   'spad' => [1, 'Tile_scratchpad'], #- Scratchpad
                   'loop' => [2, 'Tile_loop']
                 );

my %u280 = ('part'       => 'xcu280-fsvh2892-2L-e',
            'board_part' => 'xilinx.com:au280:part0:1.1');

my %u250 = ('part'       => 'xcu250-figd2104-2l-e',
            'board_part' => 'xilinx.com:au250:part0:1.3');

our %board_info = ( 'u280' => \%u280,
                    'u250' => \%u250
                  );

###############################
#- Subroutines: Do not modify
###############################

our $t  = 0;   #- Tile
our $t1 = 0;   #- Tiles + DRAM manager
our $bits_tile_type = 2;

sub gen_all {
  my %param = %{$_[0]};

  %param = %{check_params(\%param)};

  #############################
  #- Setting global variables
  #############################
  my $r = $param{'r'};  #- Rows
  my $c = $param{'c'};  #- Columns

  $t = $r*$c; #- Tiles
  $t1 = $t;   #- Tiles + DRAM manager

  #########################
  #- sub routines
  #########################

  set_axi_parameters(\%param);
  gen_is_array(\%param);
  gen_global_defines(\%param);
  gen_axi_ux_addr();
  gen_axi_ux_resp(\%param);
  gen_axi_coord_init(\%param);
  gen_pico_testcase(\%param);
  gen_checker(\%param);
  gen_fpga_test(\%param);
  run_sim(\%param);
  print "INFO: Finish without errors\n";

}

sub gen_is_array{
   my %param = %{$_[0]};
   my $r = $param{'r'}; #- Rows
   my $c = $param{'c'}; #- Columns

   my $mem_sz = $param{'mem_sz'}/4;
   my $high_sz = $r*$mem_sz; 

   open(my $FH, '>', "$param{'build_path'}/is_array.vh") or die "Couldn't open file $!\n";

   #- For acc_picorv32.sv
   print $FH "\nassign is_array = ";
   for (my $i=0; $i<$c; $i=$i+1){
      my $low = ($i*8)*$mem_sz;
      my $high =  $low + $high_sz;
      my $low_hex = sprintf("\'h%08X", $low);
      my $high_hex = sprintf("\'h%08X", $high);
      my $line = "(mem_addr_b_32 >= $low_hex & mem_addr_b_32 < $high_hex)";
      if ($i>0) {$line = "\t\t\t\t\t\t".$line;};
      if ($i==$c-1){ $line = $line.";\n"}
      else{ $line = $line." |\n"}
      print $FH "$line";
   }

   #- For the NoC decoder
   print $FH "\nassign is_array_dec = ";
   for (my $i=0; $i<$c; $i=$i+1){
      my $low = ($i*8)*$mem_sz;
      my $high =  $low + $high_sz;
      my $low_hex = sprintf("\'h%08X", $low);
      my $high_hex = sprintf("\'h%08X", $high);
      my $line = "(stream_in_TDATA >= $low_hex & stream_in_TDATA < $high_hex)";
      if ($i>0) {$line = "\t\t\t\t\t\t\t ".$line;};
      if ($i==$c-1){ $line = $line.";\n"}
      else{ $line = $line." |\n"}
      print $FH "$line";
   }

   #print $FH "\nassign is_not_array = ";
   #for (my $i=0; $i<$c; $i=$i+1){
   #   my $low = (($i*8)*$mem_sz) + $high_sz;
   #   my $high = ((($i+1)*8)*$mem_sz);
   #   my $low_hex = sprintf("\'h%08X", $low);
   #   my $high_hex = sprintf("\'h%08X", $high);
   #   my $line = "(stream_in_TDATA >= $low_hex & stream_in_TDATA < $high_hex)";
   #   if ($i>0) {$line = "\t\t\t\t\t\t\t ".$line}
   #   $line = $line." |\n";
   #   print $FH "$line";
   #}
   #my $high = 8*8*$mem_sz;
   #my $high_hex = sprintf("\'h%08X", $high);
   #my $line = "stream_in_TDATA >= $high_hex;\n";
   #$line = "\t\t\t\t\t\t\t ".$line;
   #print $FH "$line";

   close($FH);
}

sub gen_fpga_test{
   my %param = %{$_[0]}; 

   my $file = $param{'shell_path'}."/mosaic_setup.h"; 
   open (my $FH, '>', $file) or die "couldn't open file $file $!\n";

   if ($param{'ddr4_flag'}) {
      print $FH "\n\#define DDR4\n\n";
   }else {
      print $FH "\n\#ifdef DDR4\n";
      print $FH "\t\#undef DDR4\n";
      print $FH "\#endif\n\n";
   }

   print $FH "int nRows = $param{'r'};\n";
   print $FH "int nCols = $param{'c'};\n\n";
   print $FH "uint32_t packetRxCountRegister = 0x14;\n";
   print $FH "uint32_t coordinatesRegister   = 0x10;\n\n";


   for (my $i=0; $i<$param{'r'}; $i=$i+1){
      if ($i==0){
         print $FH "uint32_t tileAddresses [$param{'r'}][$param{'c'}] = {{";
      }
      for (my $j=0; $j<$param{'c'}; $j=$j+1){
         my $id = $i*$param{'c'} + $j;
         my $dec = $id*$axi_tile_addr_range;
         if ($j==0 & $i!=0){print $FH "\t\t\t\t\t\t\t\t\t\t\t{"}
         my $hex = sprintf ("0x%04X", $dec);
         print $FH "$hex";
         if ($j < $param{'c'}-1) {print $FH ", "};
      }
      if ($i<($param{'r'}-1)){print $FH "},\n"}
      else{print $FH "}};\n\n"}
   }

   if ($param{'ddr4_flag'}) {
      my $id = $param{'c'}*$param{'r'};
      my $dec = $id*$axi_tile_addr_range;
      my $hex = sprintf ("0x%04X", $dec);
      print $FH "uint32_t tileAddress_mem = $hex;\n\n";
   }

   my @pico_program = @{$param{'pico_program'}};   #- Program to load in tile
   for (my $i=0; $i<$param{'r'}; $i=$i+1){
      if ($i==0){
         print $FH "char file_name [$param{'r'}][$param{'c'}][30] = {\n";
      }
      for (my $j=0; $j<$param{'c'}; $j=$j+1){
         my $id = $i*$param{'c'} + $j;
         my $dec = $id*$axi_tile_addr_range;
         if ($j==0){print $FH "\t\t\t\t\t\t\t\t\t\t{"}
         my $hex_file = $pico_program[$id];
         if ($hex_file ne ''){print $FH "\"$hex_file\""}
         else{print $FH "\"\""}
         if ($j < $param{'c'}-1) {print $FH ", "};
      }
      if ($i<($param{'r'}-1)){print $FH "},\n"}
      else{print $FH "}};\n\n"}
   }

   for (my $i=0; $i<$param{'r'}; $i=$i+1){
      if ($i==0){
         print $FH "uint32_t coordinates [$param{'r'}][$param{'c'}] = {{";
      }
      for (my $j=0; $j<$param{'c'}; $j=$j+1){
         my $id = $j*8+$i;
         if ($j==0 & $i!=0){print $FH "\t\t\t\t\t\t\t\t\t\t {"}
         my $hex = sprintf ("0x%04X", $id);
         print $FH "$hex";
         if ($j < $param{'c'}-1) {print $FH ", "};
      }
      if ($i<($param{'r'}-1)){print $FH "},\n"}
      else{print $FH "}};\n\n"}
   }

   if ($param{'ddr4_flag'}) {
      my $hex = sprintf ("0x%04X", $param{'r'});
      print $FH "uint32_t coordinates_mem = $hex;\n";
   }

   close($FH);

}

sub run_sim{
   my %param = %{$_[0]};
   my $tool = "Icarus";
   if ($param{'vivado'}){
      $tool = "Vivado";
      if ($param{'vivado_project'}){
         gen_vivado_script(\%param);
         launch(\%param, $tool);
      }
   }else{
      gen_file_list(\%param);
      if ($param{'run_sim'}){
         launch(\%param, $tool);
      }
   }
}

sub gen_file_list{
   my %param=%{$_[0]};

   my $file = "$param{'launch_path'}/file_list";
   
   
   my $file1 = "${file}.txt";

   open(my $FH, '>', $file1) or die "Couldn't open $file1 $!\n";

   #- Running with Icarus
   if ($param{'vivado'}==0){
      print $FH "\n\#- ADDING MODELS\n";
      #print $FH "../src/Common.HDL/DPRAM.sv\n";       #- Dual port memory
      print $FH "../models/xpm_cdc_array_single.v\n"; #- Synch registers
      print $FH "../models/xpm_memory_spram.sv\n";    #- Single port memory
      print $FH "../models/xpm_fifo_async.sv\n";      #- Asynch fifo
      print $FH "../models/xpm_fifo_sync.sv\n";       #- Synch fifo
   }

   close($FH);

   my $cmd = "cat ${file}_template.txt >> ${file}.txt";
   `$cmd`;

   open(my $FH, '>>', $file1) or die "Couldn't open $file1 $!\n";

   if ($param{'instruction_mem'} |
       $param{'ddr4_flag'}) {
      print $FH "../src/Tile.HDL/cache_ctrl/dm_cache_data.sv\n";
      print $FH "../src/Tile.HDL/cache_ctrl/dm_cache_fsm.sv\n";
      print $FH "../src/Tile.HDL/cache_ctrl/dm_cache_tag.sv\n";
   }

   if ($param{'instruction_mem'}){
      print $FH "../src/Tile.HDL/picorv32_tile/instr_mem.sv\n";
   }

   if ($param{'ddr4_flag'}){
      print $FH "\n\#- ADDING FILES FOR MEMORY MANAGER\n";
      print $FH "../src/Tile.HDL/dram_tile/Tile_mem_mgr.sv\n";
      print $FH "../src/Tile.HDL/dram_tile/acc_mem_mgr.sv\n";         
      print $FH "../src/Tile.HDL/dram_tile/mem_mgr_axi.sv\n";
      print $FH "../src/Tile.HDL/dram_tile/mem_mgr_noc_decoder.sv\n";
      print $FH "../src/Tile.HDL/dram_tile/mem_mgr_noc_encoder.sv\n";
      print $FH "../src/Testbench/tb_memory_controller.sv\n";
   }

   close($FH);
}

sub launch{
   my %param = %{$_[0]};
   my $tool = $_[1];
   print "INFO: About to launch $tool\n";
   chdir $param{'launch_path'} or die "Couldn't change to $param{'launch_path'} $!\n";
   my $r = system("bash ./launch_sim.sh");
   if ($r != 0){
      die "ERROR: launch_sim.sh failed $r\n";
   }else{
     run_checkers(\%param);
   }
}

sub run_checkers{

   my %param = %{$_[0]};

   my @checkers;
   if (exists $param{'checkers'}){
      @checkers = @{$param{'checkers'}};
   }else{
      print "INFO: Not running checkers\n";
      return 
   }
	
	print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
   print "INFO: Running Checkers\n";
   print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";

   my $path = "$param{'mosaic_path'}/tools/checkers";
   chdir $path or die "Couldn't change to $path directory $!\n";
   foreach my $item (@checkers){
   	print "INFO: CHECKER: $item\n";
      my $data = `bash ./$item $param{'launch_path'}`;
      print $data;
      if ($data =~ m/FAIL/ ){
			print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
   		print "ERROR: Checker: $item FAILED\n";
   		print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
      }else{
         print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
         print "INFO: Checker $item PASSED\n";
         print "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
      }
		print "\n";
   }

}

sub gen_vivado_script{
   my %param = %{$_[0]};
   my $file = "$param{'launch_path'}/launch_vivado.tcl";
   open (my $FH, '>', $file ) or die "Couldn't open file $file !$.\n";
   my %board = %{$board_info{$param{'board'}}};
   #- Create the project
   print $FH "set_param board.repoPaths \"$MosaicGlobal/open-nic-shell/board_files\"\n"; #- FIXME
   print $FH "create_project -force mosaic $param{'launch_path'}/mosaic -part $board{'part'}\n";
   #- Set the board
   print $FH "set_property board_part $board{'board_part'} [current_project]\n";
   #- Add files
   print $FH "set_property include_dirs \"$param{'build_path'}\" [current_fileset]\n";
   print $FH "add_files -scan_for_includes $param{'mosaic_path'}/src\n";
   if ($param{'vivado_ip_dram'}){
      print $FH "add_files -scan_for_includes $MosaicGlobal/xilinx_dram_model\n"; #- FIXME
      print $FH "source $param{'mosaic_path'}/tools/vivado_scripts/memory_ctrl_etc_$param{'board'}_${vivado_version}.tcl\n";
      #print $FH "source $param{'mosaic_path'}/tools/vivado_scripts/fifo_generator_v2.tcl\n"; #FIXME
   }
   #- Set the top project
   print $FH "set_property top tb_mosaic [get_filesets sim_1]\n";
   print $FH "set_property top_lib xil_defaultlib [get_filesets sim_1]\n";
   #- ? 
   print $FH "update_compile_order -fileset sources_1\n";
   print $FH "update_compile_order -fileset sim_1\n";
   #- Generate simulation scripts of the design and launch steps for the target simulator.
   print $FH "launch_simulation\n";
   if ($param{'run_sim'}){
      #- run simlation 
      print $FH "run 1s\n";
   };
   if ($param{'run_synth'}){
      print $FH "set_property top mosaic [get_filesets sim_1]\n";
      print $FH "set_property top_lib xil_defaultlib [get_filesets sim_1]\n";
      #- ? 
      print $FH "update_compile_order -fileset sources_1\n";
      print $FH "update_compile_order -fileset sim_1\n";
      print $FH "synth_design -top mosaic -part $board{'part'} -flatten_hierarchy rebuilt\n";
      #- Write design checkpoint
      print $FH "write_checkpoint\n";
      # Write report utilization and timing estimates
      print $FH "report_utilization -file utilization.txt\n";
      print $FH "report_timing > timing.txt\n";
   };

   close($FH);

}



sub check_params{
  my %param = %{$_[0]};

  
  if (exists $param{'r'}){
    print "INFO: Number of rows in the array: $param{'r'}\n";
  }else{
    print "WARNING: \$param\{\'r\'\} not specified, setting to default \$param\{\'r\'\}=2.\n"; 
    $param{'r'} = 2;
  }

  if (exists $param{'c'}){
    print "INFO: Number of columns in the array: $param{'c'}\n";
  }else{
    print "WARNING: Parameter c not specified, setting to default \$param\{\'c\'\}=2.\n"; 
    $param{'c'} = 2;
  }

  my $r = $param{'r'};                            #- Rows
  my $c = $param{'c'};                            #- Columns

  ######################################
  # Go through each parameter one by one
  ######################################



  if (exists $param{'vivado'}){
    print "INFO: Setting up the files for Vivado\n";
  }else{
    print "INFO: Setting up the files for Icarus\n";
    $param{'vivado'} = 0;
  }

  if (exists $param{'board'}){
    if ($param{'board'} eq 'u280' | $param{board} eq 'u250'){
    }else{
      print "WARNING: The supported boards are u280 or u250\n";
    }
  }else{
    print "INFO: Setting the board to u280 by default\n";
    $param{'board'} = 'u280';
  }

  #- Mosaic path
  if (exists $param{'mosaic_path'}){
  }else{
    my $dir = getcwd;
    $param{'mosaic_path'} = "$dir/../.."; #- FIXME
    print "INFO: Mosaic path: $param{'mosaic_path'}\n";
  }
  if (-e $param{'mosaic_path'}){
  }else{
    die "ERROR: Directory $param{'mosaic_path'} does not exist\n";
  }

  #- This shouldn't be a parameter
  if (exists $param{'load_fw_file'}){ #- List of firmware files for the picos
  }else{
    $param{'load_fw_file'} = 'fw_files.vh';
  }

  #- Firmware path
  if (exists $param{'firmware_path'}){ #- Directory where the firmware is
  }else{
    $param{'firmware_path'} = "$param{'mosaic_path'}/src/Tile.HDL/picorv32_tile/firmware";
  }
  if (-e $param{'firmware_path'}){
  }else{
    die "ERROR: Directory $param{'firmware_path'} does not exist\n";
  }

  #- Launch path
  if (exists $param{'launch_path'}){ #- Directory where the simulation is
  }else{
    if ($param{vivado}){
       $param{'launch_path'} = "$param{'mosaic_path'}/vivado";
    }else{
      $param{'launch_path'} = "$param{'mosaic_path'}/icarus";
    }
  }

  if (-e $param{'launch_path'}){
  }else{
    die "ERROR: Directory $param{'launch_path'} does not exist\n";
  }

  #- Packets path
  if (exists $param{'packet_path'}){ #- Directory where the packets are
  }else{
    $param{'packet_path'} = "$param{'mosaic_path'}/src/Testbench/packets";
  }

  if (-e $param{'launch_path'}){
  }else{
    die "ERROR: Directory $param{'packet_path'} does not exist\n";
  }

  #- Packets file
  if (exists $param{'packet_file'}){ #- Directory where the simulation is
  }else{
    $param{'packet_file'} = "Packet_in_empty.axi";
    print "INFO: Setting packet_file to default $param{'packet_file'}\n";
  }
  if (-e "$param{'packet_path'}/$param{'packet_file'}"){
  }else{
    die "ERROR: File $param{'packet_path'}/$param{'packet_file'} does not exist\n";
  }

  #- Simulation loops
  if (exists $param{'sim_loop'}){
  }else{
    $param{'sim_loop'}     = 10;
  }

  #- DDR4 (Add tile_memory manager)
  if (exists $param{'ddr4_flag'}){
    print "INFO: Adding the tile memory manager to Mosaic\n";
  }else{
    $param{'ddr4_flag'} = 0;
  }

  if (exists $param{'ddr_cache_lines'}){
  }else{
    print "INFO: Setting ddr_cache_lines to default 16\n";
    $param{'ddr_cache_lines'} = 16;
  }

  
  #- Create build directory 
  if (-e "$param{mosaic_path}/build"){
    print "DEBUG: Build directory exists\n"
  }else{
    mkdir "$param{'mosaic_path'}/build" or die "Couldn't create the build directory $!.\n";
  }
  $param{'build_path'} = "$param{'mosaic_path'}/build";

  if (exists $param{'run_sim'}){
  }else{
     $param{'run_sim'} = 0;
  }

  #- Add a new tile
  gen_tiles(\%param);

  my @tile_array;
  if (exists $param{'tile_array'}){
    @tile_array = @{$param{'tile_array'}};       #- Type of tile and location
  }else{
    print "ERROR: Specify @tile_array\n";
  }
  my $tile_sz = $#tile_array;
  if ($tile_sz == $r-1){
    print "INFO: \@tile_array rows-check passed\n";
    my $row_id = 0;
    foreach my $row (@tile_array){
      my @row_a = @{$row};
      my $row_sz = $#row_a;
      if ($row_sz != $c-1){
        print "ERROR: The tile array must have $c columns. Check row $row_id\n";
      }
      $row_id = $row_id + 1;
    }
  }else{
    print "ERROR: The tile array must have $r rows\n";
  }
  print "INFO: \@tile_array columns-check passed\n";

  my @pico_program;
  if (exists $param{'pico_program'}){
    @pico_program = @{$param{'pico_program'}};   #- Program to load in tile
  }else{
    print "ERROR: Specify @pico_program\n";
  }
  my $pico_sz = $#pico_program;
  if ($pico_sz >= $r*$c-1){
    print "INFO: \@pico_program size-check passed\n";
  }else{
    die "ERROR: Specify a program for each tile. If none used \'\' for empty\n";
    
  };

   #- Shell path
   if (exists $param{'shell_path'}){ #- Directory where the stimulus for testing with open-nic-shell are
   }else{
      $param{'shell_path'} = "$param{'mosaic_path'}/shell/fpga";
   }
   if (-e $param{'shell_path'}){
   }else{
      die "$param{'shell_path'} directory does not exist\n";
   }
  

   if (exists $param{'mem_sz'}){  #- Cache size 
   }else{
      print "INFO: setting mem_sz to 16k\n";
      $param{'mem_sz'} = 16384;
   }

   if (exists $param{'noc_buffer_addr_w'}){  #- Cache size 
      print "INFO: NoC buffer address size set to $param{'noc_buffer_addr_w'}.\n";
   }else{
      print "INFO: setting the NoC buffer address size to 8 (256 words).\n";
      $param{'noc_buffer_addr_w'} = 8;
   }

   
   if (exists $param{'noc_bw'}){  #- NOC Bus width
      print "INFO: NoC bus width is set to $param{'noc_bw'}.\n";
   }else{
      $param{'noc_bw'} = 32;
      print "INFO: NoC bus width is set to 32 by default.\n";
   }


   if (exists $param{'instruction_mem'}){  #- Cache size 
   }else{
      print "INFO: Do not separate instructions from data at pico tile\n";
      $param{'instruction_mem'} = 0;
   }

   


  return \%param;
  
  #print "$#tile_array\n";
  #print "$#pico_program\n";
}

sub gen_tiles{
  print "INFO: Adding new type of tiles\n";
  
  #- For new tiles
  my %param = %{$_[0]};
  
  my $new_id = 3;
  if (exists $param{'new_tile'}){
    my %new_tile = %{$param{'new_tile'}};
    foreach my $key (keys %new_tile){
      $tile_type{$key} = [$new_id, $new_tile{$key}];
      $new_id = $new_id + 1;
    } 
  }
 
  #- For all tiles
  my $file = "$param{'build_path'}/tiles.vh";
  open(my $FH, '>', $file) or die "Couldn't open $file tiles.vh $!";

  my $fflag = 0;
  my $ctr = 0;
  foreach my $key (keys %tile_type){
    $ctr = $ctr + 1;
    my @tile_info = @{$tile_type{$key}};
    my $num = $tile_info[0];
    my $mod = $tile_info[1];

    if ($fflag == 0){
      print $FH "if (TILE_TYPE[(((i*COL+j)+1)*BITS_TILE_TYPE)-1:(i*COL+j)*BITS_TILE_TYPE]== $num ) begin : $key\n";
      $fflag = 1;
    }else{
      print $FH "end else if (TILE_TYPE[(((i*COL+j)+1)*BITS_TILE_TYPE)-1:(i*COL+j)*BITS_TILE_TYPE]== $num ) begin : $key\n";
    }
    print $FH "   $mod#(
      .AXI_ADDR (AXI_OUTADR),
      .NOC_BUFFER_ADDR_W (NOC_BUFFER_ADDR_W),
      .BW                (BW)
    ) tile_inst(
      .plain_start_of_processing	 (sop_plain_start_of_processing),
      .stream_in_TVALID            (stream_in_TVALID[i*COL+j]),
      .stream_in_TREADY            (stream_in_TREADY[i*COL+j]),
      .stream_in_TDATA             (stream_in_TDATA[i*COL+j]),
      .stream_in_TKEEP             (stream_in_TKEEP[i*COL+j]),
      .stream_in_TLAST             (stream_in_TLAST[i*COL+j]),
      .stream_out_TVALID           (stream_out_TVALID[i*COL+j]),
      .stream_out_TREADY           (stream_out_TREADY[i*COL+j]),
      .stream_out_TDATA            (stream_out_TDATA[i*COL+j]),
      .stream_out_TKEEP            (stream_out_TKEEP[i*COL+j]),
      .stream_out_TLAST            (stream_out_TLAST[i*COL+j]),
      //- AXI bus
      .control_S_AXI_AWADDR 	(tile_S_AXI_AWADDR[i*COL+j]),
      .control_S_AXI_AWVALID	(tile_S_AXI_AWVALID[i*COL+j]),
      .control_S_AXI_AWREADY	(tile_S_AXI_AWREADY[i*COL+j]),
      .control_S_AXI_WDATA  	(tile_S_AXI_WDATA[i*COL+j]),
      .control_S_AXI_WSTRB 	  (tile_S_AXI_WSTRB[i*COL+j]),
      .control_S_AXI_WVALID	  (tile_S_AXI_WVALID[i*COL+j]),
      .control_S_AXI_WREADY	  (tile_S_AXI_WREADY[i*COL+j]),
      .control_S_AXI_BRESP 	  (tile_S_AXI_BRESP[i*COL+j]),
      .control_S_AXI_BVALID	  (tile_S_AXI_BVALID[i*COL+j]),
      .control_S_AXI_BREADY	  (tile_S_AXI_BREADY[i*COL+j]),
      .control_S_AXI_ARADDR	  (tile_S_AXI_ARADDR[i*COL+j]),
      .control_S_AXI_ARVALID	(tile_S_AXI_ARVALID[i*COL+j]),
      .control_S_AXI_ARREADY	(tile_S_AXI_ARREADY[i*COL+j]),
      .control_S_AXI_RDATA 	  (tile_S_AXI_RDATA[i*COL+j]),
      .control_S_AXI_RRESP 	  (tile_S_AXI_RRESP[i*COL+j]),
      .control_S_AXI_RVALID	  (tile_S_AXI_RVALID[i*COL+j]),
      .control_S_AXI_RREADY 	(tile_S_AXI_RREADY[i*COL+j]),
      //- Clock and reset
      .clk_control         	(clk_control),
      .clk_line            	(clk_line),
      .clk_line_rst_high   	(clk_line_rst_high),
      .clk_line_rst_low     (clk_line_rst_low),
      .clk_control_rst_low 	(clk_control_rst_low),
      .clk_control_rst_high (clk_control_rst_high));\n";
  }
  print $FH "end\n";
  close($FH);
  $bits_tile_type =  ceil(log2($ctr));
  print "INFO: Using $bits_tile_type bits to set the type of tile\n";
}

sub gen_checker{ #- FIXME: how to generalize?
   my %param = %{$_[0]};
   my @tile_array = @{$param{'tile_array'}};        #- Type of tile
   open(my $FH, '>', "$param{'build_path'}/checker.vh");
   print $FH "initial begin\n";
   print $FH "\twait(sim_done);\n";
   my $i=0;
   foreach my $row (@tile_array){
      my $j=0;
      foreach my $item (@{$row}){
         if (${item} eq 'pico'){
            print $FH "\t\$writememh(\"$param{'launch_path'}/tile_$i${j}.dat\", mosaic.row[$i].col[$j].pico.tile_inst.acc_picorv32.dp_ram.mem);\n";
         }elsif (${item} eq 'spad'){
           print $FH "\t\$writememh(\"$param{'launch_path'}/tile_$i${j}.dat\", mosaic.row[$i].col[$j].spad.tile_inst.acc_scratchpad.dp_ram.mem);\n";
         }else{
           print "DEBUG: Not printing the content of tile $i$j of type $item for final checkers.\n";
         }
         $j = $j + 1;
      }
      $i = $i + 1;
   }
   print $FH "\tcheck_done = 1;\n";
   print $FH "end\n";

   close($FH);
}

sub gen_global_defines{

  my %param = %{$_[0]};

  #my $vivado_ip = $param{'vivado_ip'};             #- Add vivado ip

  my @tile_array = @{$param{'tile_array'}};        #- Type of tile

  open(my $FH, '>', "$param{'build_path'}/global_defines.sv");
  print $FH "\/\/$param{'testcase'}\n";
  print $FH "\`define ROW $param{'r'}\n";
  print $FH "\`define COL $param{'c'}\n";
  print $FH "\`define NOC_BUFFER_ADDR_W $param{'noc_buffer_addr_w'}\n";
  print $FH "\`define NOC_BW $param{'noc_bw'}\n";

  print $FH "\`define SIM_ASSERT_CHK 0\n"; #FIXME: This is a problem
  print $FH "\`define LOAD_PICO_FW \"$param{load_fw_file}\"\n";
  print $FH "\`define PACKET_FILE \"$param{'packet_path'}/$param{'packet_file'}\"\n";
  print $FH "\`define COORD_ADR \"$param{'build_path'}\/coord_addr.hex\"\n";
  print $FH "\`define COORD1_ADR \"$param{'build_path'}\/coord1_addr.hex\"\n";
  print $FH "\`define DATA_ADR \"$param{'build_path'}\/coord_data.bin\"\n";

  print $FH "`define SIM_LOOP $param{'sim_loop'}\n";

   if ($param{'ddr4_flag'}){
      print $FH "\`define DDR4_CTRL\n";
      my $bin_x = sprintf("%03b", $param{'r'});
      my $bin_y = sprintf("%03b", 0);
      print $FH "\`define X_DRAM $bin_x\n";
      print $FH "\`define Y_DRAM $bin_y\n";
      if ($param{vivado_ip_dram} & $param{vivado}){
         print $FH "\`define VIVADO_IP_DRAM\n";
      }
   }

   #- For compilation FIXME
   print $FH "\`define CACHE_LINES $param{'ddr_cache_lines'}\n";

  my $bits = $t*$bits_tile_type;
  print $FH "\`define BITS_TILE_TYPE $bits_tile_type\n";
  my @bin_a;
   foreach my $row (@tile_array){
      foreach my $item (@{$row}){
         #print "HAHA - $item - $tile_type{$item}\n";
         my @tile_info = @{$tile_type{$item}};
         my $num =  $tile_info[0];
         push(@bin_a, sprintf("%0${bits_tile_type}b", $num));
      }
   }
  my $bin = join('',reverse(@bin_a));
  print $FH "\`define TILE_TYPE $bits\'b$bin\n";

 if ($param{'vivado'}){
    print $FH "\`define BOARD_$param{'board'}\n";
  }

  print $FH "\n//////////////////\n";
  print $FH "// AXI DEFINES  //\n";
  print $FH "//////////////////\n";
  print $FH "\`define AXI_TILES $t1\n";
  print $FH "\`define AXI_UX_ADDR_TILE $axi_ux_addr\n";
  print $FH "\`define AXI_OUTADR $axi_tile_addr_bits\n";

  if ($param{'instruction_mem'}){
     print $FH "\`define INSTRUCTION_MEM\n";
  }

  #print $FH "\n/////////////////////\n";
  #print $FH "// TESTCASE DEFINES  //\n";
  #print $FH "///////////////////////\n";

  #if (exists $param{'test_defines'}){
  #    my @test_defines = @{$param{'test_defines'}};
  #    foreach my $item (@test_defines){
  #       print $FH "\`define  $item\n";
  #    }
  # } 

  
  close($FH);
}

sub gen_pico_testcase{

  my %param = %{$_[0]};

  my $r = $param{'r'};                            #- Rows
  my $c = $param{'c'};                            #- Columns
  my @tile_array = @{$param{'tile_array'}};       #- Type of tile
  my @pico_program = @{$param{'pico_program'}};   #- Program to load in tile
  
  open(my $FH, '>', "../../build/$param{'load_fw_file'}") or die "Couldn't open file $param{'load_fw_file'} $!\n";

  my $init_axi=0;
  if ($param{'init_mem_tile_axi'}){
    $init_axi = 1;
  }

   for (my $i=0; $i<$r; $i=$i+1){
      my @row = @{$tile_array[$i]};
      for (my $j=0; $j<$c; $j=$j+1){
         my $type = $row[$j];
         my $id = $i*$c+$j;
         my $adr = $id*$axi_tile_addr_range;
         my $file = $pico_program[$id];
         my $full_path = $param{'firmware_path'};
         if ($file ne ''){
            my $full_path2 = $full_path."/${file}";
            if ($type eq 'pico'){
               if ($param{'instruction_mem'}){
                  $file =~ s/\.hex//; 
                  $full_path2 = $full_path."/${file}_data.hex";
               }
               if (-e $full_path2){
                  if ($init_axi){
                     print $FH "\t\$display(\"Writing tile $i,$j\");\n";
                     print $FH "\tinitialize_mem_tile_AXI(\"$full_path2\",$adr);\n\n"; #FIXME: adr
                  }else{
                     print $FH "\t\$readmemh(\"$full_path2\", mosaic.row[$i].col[$j].${type}.tile_inst.acc_picorv32.dp_ram.mem);\n\n";
                  }
               }else{
                  die "ERROR: $full_path2 file does not exist\n";
               }
            }elsif ($type eq 'spad'){
               if (-e $full_path2){
                  if ($init_axi){
                     print $FH "\t\$display(\"Writing tile $i,$j\");\n";
                     print $FH "\tinitialize_mem_tile_AXI(\"$full_path2\",$adr);\n\n"; #FIXME: adr
                  }else{
                     print $FH "\t\$readmemh(\"$full_path2\", mosaic.row[$i].col[$j].${type}.tile_inst.acc_scratchpad.dp_ram.mem);\n\n";
                  }
               }else{
                  die "ERROR: $full_path2 file does not exist\n";
               }
            }
         }
      }
   }

  if ($param{'ddr4_flag'}){
    if (exists $param{'ddr_init_file'}){
      my $file = $param{'ddr_init_file'};
      my $id = $r*$c;
      my $adr = $id*$axi_tile_addr_range;
      print $FH "\twait(c0_init_calib_complete)\n";
      print $FH "\n\t\$display(\"Writing tile memory manager\");\n";
      print $FH "\tinitialize_mem_tile_AXI(\"$param{'firmware_path'}/$file\",$adr);\n";
    }
  }
  close($FH);
}


sub set_axi_parameters{

  my %param = %{$_[0]};

  #- These axi_* are global variables
  $axi_tile_addr_bits  = floor(log2($axi_addr_range/$t1));

  if ($param{'ddr4_flag'}){
    $t1 = $t+1;
    $axi_tile_addr_bits  = floor(log2($axi_addr_range/$t1));
  }

  if ($axi_tile_addr_bits>8) {
    $axi_tile_addr_bits = 8;
    $axi_tile_addr_range = 2**$axi_tile_addr_bits;
    $axi_ux_addr = ceil(log2($t1));
  }else{
    $axi_tile_addr_range = 2**$axi_tile_addr_bits;
    $axi_ux_addr = ceil(log2($t1));
  }

  print "INFO: $axi_tile_addr_bits for AXI address bus.\n";
  print "INFO: $axi_tile_addr_range AXI registers per tile.\n";
  print "INFO: $axi_ux_addr bits for AXI mux.\n";
}

sub gen_axi_coord_init{

  my %param = %{$_[0]};

  my $r = $param{'r'};                            #- Rows
  my $c = $param{'c'};                            #- Columns

  open(my $FH, '>', "../../build/coord_addr.hex");
  open(my $FH1, '>', "../../build/coord1_addr.hex");
  for (my $i=0; $i<$t1; $i=$i+1){
    my $min1 = $i*$axi_tile_addr_range;
    my $min = $min1 + 16;
    my $hex = sprintf("%08X", $min);
    my $hex1 = sprintf("%08X", $min1);
    print $FH "$hex\n";
    print $FH1 "$hex1\n";
  }
  close($FH);
  close($FH1);
  
  my $xy_sz = 3;    #- FIXME: Move it to be  global parameter
  open(my $FH, '>', "../../build/coord_data.bin");
  for (my $i=0; $i<$r; $i=$i+1){
    my $bin_x = sprintf("%03b", $i);
    for (my $j=0; $j<$c; $j=$j+1){
      my $bin_y = sprintf("%03b", $j);
      my $bin_t = sprintf("%026b",0);
      my $bin = $bin_t.$bin_y.$bin_x;
      print $FH "$bin\n";
    }
  }

  if ($param{'ddr4_flag'}){
      my $bin_x = sprintf("%03b", $r);
      my $bin_y = sprintf("%03b", 0);
      my $bin_t = sprintf("%026b",0);
      my $bin = $bin_t.$bin_y.$bin_x;
      print $FH "$bin\n";
  }
  close($FH);
}



sub log2 {
    my $n = shift;
    return log($n)/log(2);
}

sub gen_axi_ux_addr{

  open(my $FH, '>', "../../build/axi_ux_addr_var.vh");

  print $FH "assign addr = ";

  for (my $i=0; $i<$t1-1; $i=$i+1){
    my $min = $i*$axi_tile_addr_range;
    my $max = ($i+1)*$axi_tile_addr_range;
    if ($i>0) {print $FH "\t\t\t\t\t"};
    if ($i==$t1-2){
      my $i1 = $i+1;
      print $FH "AXI_ADDR >= $min & AXI_ADDR < $max ? $i: $i1;\n";
    }else{
      print $FH "AXI_ADDR >= $min & AXI_ADDR < $max ? $i:\n";
    }
  }

  print $FH "\nalways @(*) begin\n";

  print $FH "\ttile_AXI_AVALID = 'h0;\n";
  print $FH "\ttile_AXI_VALID = 'h0;\n";

  print $FH "\tcase (addr)\n";
  for (my $i=0; $i<$t1; $i=$i+1){
    my $high = $t1-$i-1;
    print $FH "\t\t${i}:begin\n";
    if ($i==0){
      print $FH "\t\t\ttile_AXI_AVALID = {$high\'h0,AXI_AVALID};\n";
      print $FH "\t\t\ttile_AXI_VALID  = {$high\'h0,AXI_VALID};\n";
    }elsif($i==$t1-1){
      print $FH "\t\t\ttile_AXI_AVALID = {AXI_AVALID,$i\'h0};\n";
      print $FH "\t\t\ttile_AXI_VALID  = {AXI_VALID,$i\'h0};\n";
    }else{
      print $FH "\t\t\ttile_AXI_AVALID = {$high\'h0,AXI_AVALID,$i\'h0};\n";
      print $FH "\t\t\ttile_AXI_VALID  = {$high\'h0,AXI_VALID,$i\'h0};\n";
    }
    print $FH "\t\tend\n";
  }
  print $FH "\tendcase\n";
  print $FH "end\n";

  close($FH);
  
}

sub gen_axi_ux_resp{

  my %param = %{$_[0]};
  

  open(my $FH, '>', "../../build/axi_ux_resp_var.vh");

  my $t1 = $t;
  if ($param{'ddr4_flag'}){
    $t1 = $t+1;
  }

  print $FH "\nalways @(*) begin\n";
  print $FH "\taddr = 'h0;\n";
  print $FH "\ttile_AXI_READY = 1'b0;\n";
  print $FH "\tcase (tile_AXI_VALID)\n";
  for (my $i=0; $i<=$t1; $i=$i+1){
    my $high = $t1-$i-1;
    my $c = 2**($i-1);
    my $p = $i-1;
    if ($i==0){
      print $FH "\t\t0:begin\n";
      print $FH "\t\t\taddr = 0; tile_AXI_READY = \'h0;\n";
    }else{
      my $high = $t1-$p-1;
      my $hex = sprintf("%X", $c);
      print $FH "\t\t${t1}\'h$hex:begin\n";
      if ($p==0){
        print $FH "\t\t\taddr = $p; tile_AXI_READY = {$high\'h0,AXI_READY};\n";
      }elsif($p==$t1-1){
        print $FH "\t\t\taddr = $p; tile_AXI_READY = {AXI_READY,$p\'h0};\n";
      }else{
        print $FH "\t\t\taddr = $p; tile_AXI_READY = {$high\'h0,AXI_READY,$p\'h0};\n";
      }
    }
    print $FH "\t\tend\n";
  }
  print $FH "\tendcase\n";
  print $FH "end\n";

  close($FH);

}
  
sub generic_tile_array{
   my %param = %{$_[0]};

   my $r      = $param{'r'};
   my $c      = $param{'c'};
   my $c_file = $param{'c_file'};
   my $instr_mem = $param{'instruction_mem'};

   my @tile_array = ();
   my @pico_program = ();

   for (my $i=0; $i<$r; $i=$i+1){
      my @row = ();
      for (my $j=0; $j<$c; $j=$j+1){
         my $id = $j*8 + $i;
         push(@row,   'pico');
         if ($instr_mem){
            push(@pico_program, "${c_file}_$id.hex");
         }else{
            push(@pico_program, "${c_file}32_$id.hex");
         }
      }
      push(@tile_array,[@row]);
   }
   return \@tile_array, \@pico_program;
}

sub print_tile_array{
   my %param = %{$_[0]};
   my @tile_array = @{$_[1]};
   my @pico_program = @{$_[2]};
   
   my $r      = $param{'r'};
   my $c      = $param{'c'};
   my $c_file = $param{'c_file'};
   my $instr_mem = $param{'instruction_mem'};

   print "\nTile Array\n";
   foreach my $item (@tile_array){
      my @row = @{$item};
      foreach my $item1 (@row){
         print "$item1, ";
      } 
      print "\n";
   }

   print "\nFirmware\n";
   my $id=0;
   for (my $i=0; $i<$param{'r'}; $i=$i+1){
      for (my $j=0; $j<$param{'c'}; $j=$j+1){
         print "$pico_program[$id], ";
         $id = $id + 1;
      }
      print "\n";
   }
   print "\n";

}

1;
