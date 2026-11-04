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

#- Phase 4 checker: pico64 MQ verification (mosaic_2x2_pico64_mq.pl)
#-   tile_11.dat: mq64_qget.c qGet's tile 00's 64-bit qPut payload and
#-     stores payload^0x1111111111111111 at byte 0x24400 (tile 11's local
#-     window, word64 index 128). 0xCAFEBABEDEADBEEF ^ 0x1111111111111111
#-     = 0xDBEFABAFCFBCAFFE. Full 64-bit value proves the payload crossed
#-     the NoC untruncated (D14 at BW=64).
#-   tile_01.dat: mq64_qput.c mPut 0xF00DFACEFEED5678 into the spad at
#-     word32 0x100 - one full 64-bit slot (port A).
#-   tile_00.dat: the mGet response auto-writes the pattern locally at
#-     word32 0x180.

thepath=$1
errors=0

echo 'INFO: Checking pico64 qPut/qGet 64-bit message (tile 00 -> tile 11)'
c=$(grep -c dbefabafcfbcaffe $thepath/tile_11.dat)
if [ $c -ge 1 ]
then
  echo "SUCCESS: tile 11 qGet'd and stored the transformed 64-bit message ($c occurrence(s))\n"
else
  echo "FAIL: tile 11 did not store 0xDBEFABAFCFBCAFFE (qPut/qGet 64-bit payload failed)\n"
  cat $thepath/tile_11.dat
  errors=$((errors+1))
fi

echo 'INFO: Checking pico64 mPut 64-bit pattern in scratchpad (tile 01)'
c=$(grep -c f00dfacefeed5678 $thepath/tile_01.dat)
if [ $c -ge 1 ]
then
  echo "SUCCESS: spad holds the full 64-bit mPut pattern ($c occurrence(s))\n"
else
  echo "FAIL: spad (tile 01) does not hold 0xF00DFACEFEED5678 (mPut 64-bit payload failed)\n"
  cat $thepath/tile_01.dat
  errors=$((errors+1))
fi

echo 'INFO: Checking pico64 mGet response written locally (tile 00)'
c=$(grep -c f00dfacefeed5678 $thepath/tile_00.dat)
if [ $c -ge 1 ]
then
  echo "SUCCESS: tile 00 received the mGet response pattern ($c occurrence(s))\n"
else
  echo "FAIL: tile 00 has no mGet response pattern 0xF00DFACEFEED5678\n"
  cat $thepath/tile_00.dat
  errors=$((errors+1))
fi

if [ $errors -gt 0 ]
then
  echo "INFO: check_pico64_mq found $errors error(s)\n"
fi
