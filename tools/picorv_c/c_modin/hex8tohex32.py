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

import fileinput
import itertools

ptr = 0
data = []

def write_data():
    if len(data) != 0:
        print("@%08x" % (ptr >> 2))
        while len(data) % 4 != 0:
            data.append(0)
        for word_bytes in zip(*([iter(data)]*4)):
            print("".join(["%02x" % b for b in reversed(word_bytes)]))

for line in fileinput.input():
    if line.startswith("@"):
        addr = int(line[1:], 16)
        if addr > ptr+4:
            write_data()
            ptr = addr
            data = []
            while ptr % 4 != 0:
                data.append(0)
                ptr -= 1
        else:
            while ptr + len(data) < addr:
                data.append(0)
    else:
        data += [int(tok, 16) for tok in line.split()]

write_data()

