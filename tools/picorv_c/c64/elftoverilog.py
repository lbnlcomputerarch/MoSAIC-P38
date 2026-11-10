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
# Date        : November 9 2026
# Description : ELF64 -> objcopy -O verilog byte stream
# File        : elftoverilog.py
# Notes       :
# - Clang/lld toolchain fallback (Makefile toolchain selection): this
#   LLVM's llvm-objcopy has no verilog output target, so emit the same
#   format directly: one byte per line (2 hex digits), '@<LMA>' lines
#   before each PT_LOAD segment's bytes.
# - Output feeds hex8tohex32.py / hex8tohex64.py unchanged.
#
# ////////////////////////////////////////////////////////////////

import struct
import sys

PT_LOAD = 1

def main(path):
    with open(path, "rb") as f:
        elf = f.read()
    assert elf[:4] == b"\x7fELF" and elf[4] == 2 and elf[5] == 1, \
        "not a little-endian ELF64 file"
    e_phoff, = struct.unpack_from("<Q", elf, 0x20)
    e_phentsize, e_phnum = struct.unpack_from("<HH", elf, 0x36)
    segs = []
    for i in range(e_phnum):
        ph = elf[e_phoff + i * e_phentsize: e_phoff + (i + 1) * e_phentsize]
        p_type, _, p_offset, _, p_paddr, p_filesz, _, _ = \
            struct.unpack("<IIQQQQQQ", ph)
        if p_type == PT_LOAD and p_filesz > 0:
            segs.append((p_paddr, elf[p_offset: p_offset + p_filesz]))
    segs.sort(key=lambda s: s[0])
    out = []
    for paddr, data in segs:
        out.append("@%x" % paddr)
        out.extend("%02x" % b for b in data)
    print("\n".join(out))

if __name__ == "__main__":
    main(sys.argv[1])
