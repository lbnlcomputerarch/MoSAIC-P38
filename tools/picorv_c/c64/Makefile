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

# ////////////////////////////////////////////////////////////////
# Author      : Farzad Fatollahi-Fard
# Date        : November 3 2026
# Description : RV64 firmware build for pico64 tiles (Phase 4)
# File        : Makefile
# Notes       :
# - Single-ELF flow (plan D22): start.S + C link against riscv64.ld.
#   Replaces picorv32's two-ELF start.elf + riscv.ld split.
# - Dual hex artifacts from one ELF (plan D24):
#     <src>32.hex  canonical (FPGA loading for ALL tiles via
#                  rvLoadFirmware, pico32 sim) — unchanged flow
#     <src>64.hex  pico64 SIM ONLY ($readmemh into 64-bit DPRAM_BE)
# - Toolchain (plan D23): riscv64-unknown-elf- prefix, falling back to
#   the homebrew riscv64-elf- prefix.
# - 'make install' copies the 64-bit hex into the directory the pico64
#   sim loader reads (gen_mosaic.pm pico64 branch).
# ////////////////////////////////////////////////////////////////

RISCV_TOOLS_PREFIX ?= $(shell command -v riscv64-unknown-elf-gcc >/dev/null 2>&1 \
                        && echo riscv64-unknown-elf- || echo riscv64-elf-)
CC = $(RISCV_TOOLS_PREFIX)gcc
OD = $(RISCV_TOOLS_PREFIX)objdump
RE = $(RISCV_TOOLS_PREFIX)readelf
OC = $(RISCV_TOOLS_PREFIX)objcopy

#- Plan D23
ARCH_FLAGS = -march=rv64imc_zicsr_zifencei_zicntr -mabi=lp64
#- -Wno-array-bounds: freestanding MMIO stores through literal-address
#- pointers trip GCC 16's object-existence analysis; the codegen is correct.
CFLAGS  = $(ARCH_FLAGS) -Wall -O2 -ffreestanding -fno-builtin -Wno-array-bounds
LDFLAGS = $(ARCH_FLAGS) -nostdlib -T riscv64.ld -Wl,--gc-sections

SRC_FNAME ?= hello

FW64_DIR = ../../../src/Tile.HDL/picorv64_tile/firmware

all: $(SRC_FNAME)32.hex $(SRC_FNAME)64.hex

$(SRC_FNAME).elf: start.o $(SRC_FNAME).o
	$(CC) $(LDFLAGS) -o $@ start.o $(SRC_FNAME).o
	$(OD) -dC $@ > $(SRC_FNAME).disassembled
	$(RE) -a  $@ > $(SRC_FNAME).readelf

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.S
	$(CC) $(ARCH_FLAGS) -c -o $@ $<

#- Canonical 32-bit artifact: objcopy verilog -> repack to 32-bit words
#- (hex8tohex32.py unchanged from the picorv32 flow, plan D24)
$(SRC_FNAME)32.hex: $(SRC_FNAME).elf
	$(OC) -O verilog $(SRC_FNAME).elf $(SRC_FNAME).tmp
	python3 ../c/hex8tohex32.py $(SRC_FNAME).tmp > $@

#- pico64 sim artifact: same byte stream repacked to 64-bit words
$(SRC_FNAME)64.hex: $(SRC_FNAME).elf
	$(OC) -O verilog $(SRC_FNAME).elf $(SRC_FNAME).tmp
	python3 hex8tohex64.py $(SRC_FNAME).tmp > $@

install: $(SRC_FNAME)64.hex
	cp $(SRC_FNAME)64.hex $(FW64_DIR)/

clean:
	rm -rf *.o *.elf *.tmp *.disassembled *.readelf *.map *.bin

clean_all: clean
	rm -rf *32.hex *64.hex

.PHONY: all install clean clean_all
