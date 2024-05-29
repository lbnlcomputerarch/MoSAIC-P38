#! /bin/bash
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
echo "###########################################"
echo "# Loading bit stream in FPGA"
echo "###########################################"

#- Before programming
#-    Two different ethernet ports in the alveo card. 
#-    Each line BDF address for device funtion  
echo 1 | sudo tee /sys/bus/pci/devices/0000\:d7\:00.0/0000\:d8\:00.0/remove
echo 1 | sudo tee /sys/bus/pci/devices/0000\:d7\:00.0/0000\:d8\:00.1/remove

#- Source Vivado setup script
source /opt/source-vitis-2022.2.sh

#- Program FPGA
vivado -mode batch -source program_card.tcl  

#- After programming
echo 1 | sudo tee /sys/bus/pci/devices/0000\:d7\:00.0/rescan

#- Telling Wanda to re-scan all the devices in the PCI bus. Look for that resource, find it in the bus and enable it. 
sudo setpci -s d8:00.0 COMMAND=0x02

#- To check if we can see it
lspci -d 10ee: -v
