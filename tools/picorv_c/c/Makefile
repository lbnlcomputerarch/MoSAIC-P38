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

# From picorv32 github repository

RISCV_TOOLS_PREFIX = /opt/riscv32i/bin/riscv32-unknown-elf-
CC = $(RISCV_TOOLS_PREFIX)gcc
OD = $(RISCV_TOOLS_PREFIX)objdump
RE = $(RISCV_TOOLS_PREFIX)readelf
OC = $(RISCV_TOOLS_PREFIX)objcopy
LDFLAGS = -Wl,--gc-sections
LDLIBS = -lstdc++

SRC_FNAME = hello

$(SRC_FNAME).hex: $(SRC_FNAME).elf start.elf
	$(OC) -O verilog start.elf start.tmp
	$(OC) -O verilog $(SRC_FNAME).elf $(SRC_FNAME).tmp
	cat start.tmp $(SRC_FNAME).tmp > $(SRC_FNAME).hex
	python3 hex8tohex32.py $(SRC_FNAME).hex > $(SRC_FNAME)32.hex

$(SRC_FNAME).elf: $(SRC_FNAME).o
	$(CC) -c -o $^ $(SRC_FNAME).c
	$(CC) $(LDFLAGS) -o $@ $^ -T riscv.ld
	chmod -x $(SRC_FNAME).elf
	$(OD) -dC $@ > $(SRC_FNAME).dissasembled
	$(RE) -a  $@ > $(SRC_FNAME).readelf

start.elf: start.S start.ld
	$(CC) -nostdlib -o start.elf start.S -T start.ld $(LDLIBS)
	chmod -x start.elf

clean:
	rm -rf *.o *.d *.elf start.elf *.map *.bin *.dissasembled *.readelf *.h.gch *.tmp 

clean_all: clean
	rm -rf *32.hex

.PHONY: test clean clean_all

