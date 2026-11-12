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

#- Checker: pico64 scratchpad test (mosaic_2x2_pico64_spad.pl)
#-   RV64 twin of check_pico_spad.sh: tile 00 (pico64, id 0) writes the
#-   scratchpad tile 01 (id 8) 16 times with mPut (MPUT) and a plain
#-   64-bit pointer store (remote STORE), then reads it back with mGet
#-   (MGET) and a plain pointer load (remote LOAD).
#-   Full 64-bit patterns: 0xCAFECACECAFECACE+i / 0xF00DF00DF00DF00D+i.
#-   The spad tile is BW-parameterized and gets BW=NOC_BW=64 from the
#-   testcase, so every beat is a full 64-bit word (no truncation).
#- Dump formats (gen_mosaic.pm):
#-   tile_01.dat: BW=64 acc_scratchpad.gen_wide_ram.dp_ram_be.mem -
#-     one 64-bit word per line. Both NoC and AXI accesses use the same
#-     mapping as the pico64 tile: word64 index = word32 offset >> 1.
#-   tile_00.dat: acc_picorv64.dp_ram_be.mem - one 64-bit word per line
#-     (data line N = word64 index N-1), possibly with '// 0xADDR'
#-     header lines, which the position checks skip.

thepath=$1
errors=0

#- Must match pico64_scratchpad.c (word32 offsets)
SPAD_OFF=256      #- 0x100: mPut/mGet slot in the spad
LOCAL_OFF=384     #- 0x180: mGet response landing slot (local)

echo 'INFO: Checking for MPUT pico64-scratchpad (tile 01)'
mem_file="$thepath/tile_01.dat"
c=$(grep -c cafecace $mem_file)
if [ $c -ge 16 ]
then
  echo "SUCCESS: There are $c>=16 CAFECACE words in the scratchpad at tile 01\n"
else
  echo "FAIL: there are $c CAFECACE words in the scratchpad at tile 01. Expecting 16\n"
  grep cafecace $mem_file
  errors=$((errors+1))
fi

echo 'INFO: Checking for remote STORE pico64-scratchpad (tile 01)'
c=$(grep -c f00df00d $mem_file)
if [ $c -ge 16 ]
then
  echo "SUCCESS: There are ${c}>=16 F00DF00D words in the scratchpad at tile 01\n"
else
  echo "FAIL: there are ${c} F00DF00D words in the scratchpad at tile 01. Expecting 16\n"
  grep f00df00d $mem_file
  errors=$((errors+1))
fi

#- Position check: the first mPut lands at spad word32 0x100 =
#- word64 index 128 (data line 129 of the 64-bit-wide spad dump).
pat_line=$(awk '!/^\/\// {n++; if (n==129) print tolower($1)}' $mem_file)
if [ "$pat_line" = "cafecacecafecace" ]
then
  echo "SUCCESS: first MPUT pattern is at spad word32 0x100 (word64 128)\n"
else
  echo "FAIL: spad word64 128 (data line 129) holds '$pat_line', not cafecacecafecace\n"
  errors=$((errors+1))
fi

#- Position check: the first remote STORE lands at spad word32 0x15A
#- (0x100+90) = word64 index 173 (data line 174).
pat_line=$(awk '!/^\/\// {n++; if (n==174) print tolower($1)}' $mem_file)
if [ "$pat_line" = "f00df00df00df00d" ]
then
  echo "SUCCESS: first remote STORE pattern is at spad word32 0x15A (word64 173)\n"
else
  echo "FAIL: spad word64 173 (data line 174) holds '$pat_line', not f00df00df00df00d\n"
  errors=$((errors+1))
fi

echo 'INFO: Checking for MGET pico64-scratchpad (tile 00)'
mem_file="$thepath/tile_00.dat"
c=$(grep -c cafecace $mem_file)
if [ $c -ge 16 ]
then
  echo "SUCCESS: There are $c>=16 CAFECACE words in the local memory at tile 00\n"
else
  echo "FAIL: there are $c CAFECACE words in the local memory at tile 00. Expecting 16\n"
  grep cafecace $mem_file
  errors=$((errors+1))
fi

echo 'INFO: Checking for remote LOAD pico64-scratchpad (tile 00)'
c=$(grep -c f00df00d $mem_file)
if [ $c -ge 16 ]
then
  echo "SUCCESS: There are $c>=16 F00DF00D words in the local memory at tile 00\n"
else
  echo "FAIL: there are $c F00DF00D words in the local memory at tile 00. Expecting 16\n"
  grep f00df00d $mem_file
  errors=$((errors+1))
fi

#- Position check (dp_ram_be dump): the first mGet response auto-writes
#- local word32 0x180 = word64 index 192 (data line 193, after the
#- header line).
pat_line=$(awk '!/^\/\// {n++; if (n==193) print tolower($1)}' $mem_file)
if [ "$pat_line" = "cafecacecafecace" ]
then
  echo "SUCCESS: first MGET response is at local word32 0x180 (word64 192)\n"
else
  echo "FAIL: local word64 192 (data line 193) holds '$pat_line', not cafecacecafecace\n"
  errors=$((errors+1))
fi

#- Position check: the first remote LOAD result lands at local word32
#- 0x1DA (0x180+90) = word64 index 237 (data line 238).
pat_line=$(awk '!/^\/\// {n++; if (n==238) print tolower($1)}' $mem_file)
if [ "$pat_line" = "f00df00df00df00d" ]
then
  echo "SUCCESS: first remote LOAD result is at local word32 0x1DA (word64 237)\n"
else
  echo "FAIL: local word64 237 (data line 238) holds '$pat_line', not f00df00df00df00d\n"
  errors=$((errors+1))
fi

if [ $errors -gt 0 ]
then
  echo "INFO: check_pico64_spad found $errors error(s)\n"
fi
