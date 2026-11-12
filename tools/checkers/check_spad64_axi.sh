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
# *************************************************************************

#- Checker: BW=64 scratchpad AXI control-plane preload
#- (mosaic_2x2_spad64_axi.pl).
#- The host AXI bus is 32 bits; two sequential word32 offsets must merge
#- into one 64-bit RAM word without clearing the untouched half.
#- Expected final memory (data line N = word64 index N-1, '//' headers
#- skipped):
#-   0: aabbccdd11223344  (offsets 0/1)
#-   1: 55667788ffeeddcc  (offsets 2/3)
#-   4: cafef00ddeadcafe  (offsets 8/9)
#-   5: 000000000badf00d  (offset 10 only; upper half remains zero)

thepath=$1
errors=0
mem_file="$thepath/tile_01.dat"

check_word64 ()
{
   idx=$1
   expected=$2
   line=$((idx+1))
   got=$(awk -v n=$line '!/^\/\// {k++; if (k==n) print tolower($1)}' $mem_file)
   if [ "$got" = "$expected" ]
   then
     echo "SUCCESS: spad word64 $idx = $expected\n"
   else
     echo "FAIL: spad word64 $idx = '$got', expected $expected\n"
     errors=$((errors+1))
   fi
}

check_word64 0 aabbccdd11223344
check_word64 1 55667788ffeeddcc
check_word64 4 cafef00ddeadcafe
check_word64 5 000000000badf00d

if [ $errors -gt 0 ]
then
  echo "INFO: check_spad64_axi found $errors error(s)\n"
fi
