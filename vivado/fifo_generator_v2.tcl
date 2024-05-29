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

set project_path  [get_property DIRECTORY [current_project]]
set project_name  [current_project]
create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name fifo_generator_0
set_property -dict [list \
  CONFIG.Fifo_Implementation {Independent_Clocks_Builtin_FIFO} \
  CONFIG.Input_Data_Width {37} \
  CONFIG.Input_Depth {512} \
  CONFIG.Read_Clock_Frequency {125} \
  CONFIG.Write_Clock_Frequency {300} \
] [get_ips fifo_generator_0]
generate_target {instantiation_template} [get_files $project_path/$project_name.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0.xci]
generate_target all [get_files  $project_path/$project_name.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0.xci]
catch { config_ip_cache -export [get_ips -all fifo_generator_0] }
export_ip_user_files -of_objects [get_files $project_path/$project_name.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] $project_path/$project_name.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0.xci]
launch_runs fifo_generator_0_synth_1 -jobs 32
export_simulation -of_objects [get_files $project_path/$project_name.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0.xci] -directory $project_path/$project_name.ip_user_files/sim_scripts -ip_user_files_dir $project_path/$project_name.ip_user_files -ipstatic_source_dir $project_path/$project_name.ip_user_files/ipstatic -lib_map_path [list {modelsim=$project_path/$project_name.cache/compile_simlib/modelsim} {questa=$project_path/$project_name.cache/compile_simlib/questa} {xcelium=$project_path/$project_name.cache/compile_simlib/xcelium} {vcs=$project_path/$project_name.cache/compile_simlib/vcs} {riviera=$project_path/$project_name.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
update_compile_order -fileset sources_1
