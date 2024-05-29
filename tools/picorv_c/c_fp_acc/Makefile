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


RISCV_TOOLS_PREFIX = /opt/riscv32im/bin/riscv32-unknown-elf-
CC = $(RISCV_TOOLS_PREFIX)gcc
OD = $(RISCV_TOOLS_PREFIX)objdump
RE = $(RISCV_TOOLS_PREFIX)readelf
OC = $(RISCV_TOOLS_PREFIX)objcopy
LDFLAGS = -Wl,--gc-sections
LDLIBS = -lstdc++

SRC_FNAME   = pico_spad_fp
START_FNAME = start
LD_FNAME    = riscv

$(SRC_FNAME).hex: $(SRC_FNAME).elf $(START_FNAME).elf
	$(OC) -O verilog $(START_FNAME).elf $(START_FNAME).tmp
	$(OC) -O verilog $(SRC_FNAME).elf $(SRC_FNAME).tmp
	cat $(START_FNAME).tmp $(SRC_FNAME).tmp > $(SRC_FNAME).hex
	python3 hex8tohex32.py $(SRC_FNAME).hex > $(SRC_FNAME)32.hex

$(SRC_FNAME).elf: $(SRC_FNAME).o
	$(CC) -O3 -c -o $^ $(SRC_FNAME).c
	$(CC) $(LDFLAGS) -ffreestanding -o $@ $^ -Tmem_layout.ld -T$(LD_FNAME).ld -lm
	chmod -x $(SRC_FNAME).elf
	$(OD) -dC $@ > $(SRC_FNAME).dissasembled
	$(RE) -a  $@ > $(SRC_FNAME).readelf

$(START_FNAME).elf: $(START_FNAME).S $(START_FNAME).ld
	$(CC) -nostdlib -o $(START_FNAME).elf $(START_FNAME).S -T $(START_FNAME).ld $(LDLIBS)
	chmod -x $(START_FNAME).elf
	$(OD) -dC $@ > $(START_FNAME).dissasembled
	$(RE) -a  $@ > $(START_FNAME).readelf



clean:
	rm -rf *.o *.d *.elf $(START_FNAME).elf *.map *.bin *.dissasembled *.readelf *.h.gch *.tmp 

clean_all: clean
	rm -rf *32.hex

.PHONY: test clean clean_all

