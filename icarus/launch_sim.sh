#!/bin/bash
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
##############################################
# Author      : LPGG 
# Date        : Feb-04-2021
# Description : Some help launching a system 
#               simulation
#############################################

###- Test parameters
waves=0
waves_file='waves_aprl27_2x2.gtkw'

testbench='tb_mosaic'


###- clean a bit
rm -rf ${testbench}.vvp ${testbench}.vcd

###- Verilog simulation
iverilog -I ../build -c file_list.txt -o ${testbench}.vvp -g2012
vvp -v ${testbench}.vvp +vcd +trace +noerror

#- Waves up and running
if [ $waves = 1 ] 
then
   open /Applications/gtkwave.app ${testbench}.vcd $waves_file &
fi

