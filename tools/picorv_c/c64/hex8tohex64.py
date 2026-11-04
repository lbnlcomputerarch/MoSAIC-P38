#!/usr/bin/env python3
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
# Description : Repack objcopy -O verilog bytes into 64-bit words
# File        : hex8tohex64.py
# Notes       :
# - 64-bit twin of hex8tohex32.py (plan D24): one 64-bit word per line,
#   little-endian byte reversal, @address in 64-bit-word units (ptr >> 3).
#   Output feeds $readmemh into acc_picorv64.dp_ram_be.mem (pico64 sim
#   loading only; FPGA flow keeps the 32-bit artifacts).
# - Mirrors hex8tohex32.py structure exactly at 8-byte granularity.

import fileinput
import itertools

ptr = 0
data = []

def write_data():
    if len(data) != 0:
        print("@%08x" % (ptr >> 3))
        while len(data) % 8 != 0:
            data.append(0)
        for word_bytes in zip(*([iter(data)]*8)):
            print("".join(["%02x" % b for b in reversed(word_bytes)]))

for line in fileinput.input():
    if line.startswith("@"):
        addr = int(line[1:], 16)
        if addr > ptr+8:
            write_data()
            ptr = addr
            data = []
            while ptr % 8 != 0:
                data.append(0)
                ptr -= 1
        else:
            while ptr + len(data) < addr:
                data.append(0)
    else:
        data += [int(tok, 16) for tok in line.split()]

write_data()
