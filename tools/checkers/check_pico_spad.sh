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

#- Checking Pico-Scratchpad
mem_file="$thepath/tile_01.dat"
echo 'INFO: Checking for MPUT pico-scratchpad'
c=$(grep -c cafe $mem_file)
if [ $c -ge 16 ]
then
  echo "SUCCESS: There are $c>=16 CAFE words in the scratchpad at tile 01\n"
else
  echo "FAIL: there are $c CAFE words in the scratchpad at tile 01. Expecting 16\n"
  grep cafe $mem_file
fi

echo 'INFO: Checking for remote STORE  pico-scratchpad'
c=$(grep -c f00d $mem_file)
if [ $c -ge 16 ]
then
  echo "SUCCESS: There are ${c}>=16 F00D words in the scratchpad at tile 01\n"
else
  echo "FAIL: there are ${c} F00D words in the scratchpad at tile 01. Expecting 16\n"
  grep f00d $mem_file
fi


echo 'INFO: Checking for MGET  pico-scratchpad'
mem_file="$thepath/tile_00.dat"
c=$(grep -c cafe $mem_file)
if [[ $c -ge 17 ]]
then
  echo "SUCCESS: There are $c > 17 CAFE words in the scratchpad at tile 00\n"
else
  echo "FAIL: there are $c < 17 CAFE words in the scratchpad at tile 00. Expecting 17\n"
  grep CAFE $mem_file
fi


echo 'INFO: Checking for remote LOAD  pico-scratchpad'
c=$(grep -c f00d $mem_file)
if [[ $c -ge 17 ]]
then
  echo "SUCCESS: There are $c > 17 F00D words in the scratchpad at tile 00\n"
else
  echo "FAIL: there are $c < 17 FOOD words in the scratchpad at tile 00. Expecting 17\n"
  grep F00D $mem_file
fi




