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
it=2 #- Change this to match the c code 
list="01 11 21 22 31 41"

for i in {0..7}
do
   for j in {0..7}
   do
      echo $list | grep -q -w $i$j
      if [ $? == 1 ]
      then
         tile="tile_${i}${j}.dat" 
         mem_file="$thepath/$tile"
         c=$(grep -c baca $mem_file)
         if [ $c -ge $it ]
         then
            echo "SUCCESS: There are $c>=$it BACA words in the scratchpad at $tile\n"
         else
           echo "FAIL: there are $c BACA words in the scratchpad at $tile. Expecting at least $it\n"
           grep baca $mem_file
         fi
      fi
   done
done
