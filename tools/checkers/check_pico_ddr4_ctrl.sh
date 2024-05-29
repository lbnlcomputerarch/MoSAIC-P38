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
thepath=$1

#- Checking Pico-Scratchpad and ddr4
echo 'INFO: Checking for MGET  pico-scratchpad-ddr4'
mem_file="$thepath/tile_00.dat"
c=$(grep -c cafe $mem_file)
if [[ $c -ge 33 ]]
then
  echo "SUCCESS: There are $c > 33 CAFE words in the scratchpad at tile 00\n"
else
  echo "FAIL: there are $c < 33 CAFE words in the scratchpad at tile 00. Expecting 33\n"
  grep CAFE $mem_file
fi


echo 'INFO: Checking for remote LOAD  pico-scratchpad-ddr4'
c=$(grep -c f00d $mem_file)
if [[ $c -ge 33 ]]
then
  echo "SUCCESS: There are $c > 33 F00D words in the scratchpad at tile 00\n"
else
  echo "FAIL: there are $c < 33 FOOD words in the scratchpad at tile 00. Expecting 33\n"
  grep F00D $mem_file
fi


