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

#- Checking cache in tile memory manager
echo 'INFO: Checking for MGET  scratchpad-ddr4'
mem_file="$thepath/tile_01.dat"
c=$(grep -c d1a $mem_file)
if [[ $c -ge 48 ]]
then
  echo "SUCCESS: There are $c >= 48 D1A words in the scratchpad at tile 01\n"
else
  echo "FAIL: there are $c <= 48 D1A words in the scratchpad at tile 01. Expecting 48\n"
  grep d1a $mem_file
fi

#- Checking transfer through axi
echo 'INFO: Checking for MGET  scratchpad-ddr4'
mem_file="$thepath/tile_01.dat"
c=$(grep -c 00000013 $mem_file)
if [[ $c -ge 5 ]]
then
  echo "SUCCESS: There are $c >= 5 NOP words in the scratchpad at tile 01\n"
else
  echo "FAIL: there are $c <= 5 NOP words in the scratchpad at tile 01. Expecting 5\n"
  grep 00000013 $mem_file
fi

echo 'INFO: Checking for MGET  scratchpad-ddr4'
mem_file="$thepath/tile_01.dat"
c=$(grep -c ff1ff06f $mem_file)
if [[ $c -ge 1 ]]
then
  echo "SUCCESS: There are $c >= 1 FF1FF06F words in the scratchpad at tile 01\n"
else
  echo "FAIL: there are $c <= 1 FF1FF06F words in the scratchpad at tile 01. Expecting 1\n"
  grep ff1ff06f $mem_file
fi


