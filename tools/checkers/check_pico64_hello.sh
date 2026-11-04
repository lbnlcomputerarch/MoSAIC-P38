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

#- Phase 3 checker: pico64 hello/bring-up firmware (mosaic_2x2_pico64.pl)
#- Tile 00 (pico64) runs pico64_hello.hex: builds 0xCAFEBABEDEADBEEF in
#- x6 and stores it with sd to byte address 64 = word64 index 8.
#- The dump is $writememh of acc_picorv64.dp_ram_be.mem: one 64-bit
#- word per line, line N+1 (after the header) = word64 index N.

thepath=$1

errors=0

echo 'INFO: Checking pico64 hello pattern store'
mem_file="$thepath/tile_00.dat"
c=$(grep -c cafebabedeadbeef $mem_file)
if [ $c -ge 1 ]
then
  echo "SUCCESS: 0xCAFEBABEDEADBEEF stored by the pico64 core ($c occurrence(s))\n"
else
  echo "FAIL: pico64 core did not store 0xCAFEBABEDEADBEEF at word64 index 8\n"
  cat $mem_file
fi

#- Position check (review F7): the store must be at word64 index 8.
#- The dump can contain multiple '// 0xADDR' header lines, so count data
#- lines only: data line N (1-based) = word64 index N-1.
pat_line=$(awk '!/^\/\// {n++; if (n==9) print tolower($1)}' $mem_file)
if [ "$pat_line" = "cafebabedeadbeef" ]
then
  echo "SUCCESS: pattern is at word64 index 8 (byte 64)\n"
else
  echo "FAIL: word64 index 8 (data line 9) holds '$pat_line', not cafebabedeadbeef\n"
  errors=$((errors+1))
fi

echo 'INFO: Checking pico64 program integrity (preloaded instructions intact)'
exp[0]="eef28293deadc2b7"   # lui x5; addi x5
exp[1]="0202d29302029293"   # slli x5; srli x5 (zext)
exp[2]="abe38393cafec3b7"   # lui x7; addi x7
exp[3]="0053033302039313"   # slli x6; add x6
exp[4]="0000006f04603023"   # sd x6,64(x0); jal x0,0
for idx in 0 1 2 3 4; do
  line=$((idx+2))  # +1 header, +1 to 1-based lines
  got=$(sed -n "${line}p" $mem_file | tr 'A-F' 'a-f' | tr -d ' ')
  if [ "$got" != "${exp[$idx]}" ]
  then
    echo "FAIL: program word64 $idx: got '$got' exp '${exp[$idx]}'\n"
    errors=$((errors+1))
  fi
done
if [ $errors -eq 0 ]
then
  echo "SUCCESS: all 5 program words intact (AXI/load_fw preload path)\n"
fi
