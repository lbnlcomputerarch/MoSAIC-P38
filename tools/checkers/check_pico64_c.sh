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

#- Phase 4 checker: C-built pico64 firmware (mosaic_2x2_pico64_c.pl)
#- Tile 00 (pico64) runs hello64.hex from tools/picorv_c/c64 (RV64
#- toolchain, single-ELF D22): hello.c stores 0xCAFEBABEDEADBEEF with sd
#- to byte 0x800 = word64 index 256, then spins. The dump is $writememh
#- of acc_picorv64.dp_ram_be.mem (one 64-bit word per line).
#- Pattern-only (unlike check_pico64_hello.sh: the C image's program
#- words are toolchain-generated, not fixed).

thepath=$1

echo 'INFO: Checking pico64 C-firmware pattern store'
mem_file="$thepath/tile_00.dat"
c=$(grep -c cafebabedeadbeef $mem_file)
if [ $c -ge 1 ]
then
  echo "SUCCESS: 0xCAFEBABEDEADBEEF stored by the C-built pico64 firmware ($c occurrence(s))\n"
else
  echo "FAIL: C-built pico64 firmware did not store 0xCAFEBABEDEADBEEF\n"
  cat $mem_file
fi
