#!/usr/bin/perl
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

use lib "$ENV{PWD}";
use gen_mosaic;
use POSIX;

###########################################
#- Set hash for parameters: Do not modify
###########################################

%param;

###########################################
#- Test case: Modify
###########################################

#- Phase 4 verification (plan): qPut/qGet 64-bit message between two
#- pico64 tiles, and pico64 <-> scratchpad mPut/mGet.
#-   tile 00 (pico64): qPut 0xCAFEBABEDEADBEEF to tile 11's queue,
#-     mPut 0xF00DFACEFEED5678 to the spad (word32 0x100), mGet it back
#-     to local word32 0x180.
#-   tile 11 (pico64): polls its queue, qGet's header + 64-bit payload,
#-     stores payload^0x1111111111111111 in its local window (byte
#-     0x24400 = word32 0x9100; a plain low address would be decoded as
#-     remote by acc_picorv64's local_mem rule).
#- Tile ids: tile_array[x][y] - spad = (x=0,y=1) = 8 (matches pico_
#-   scratchpad.c's remote_tile_id = 8 in piconocbw); the loop tile at
#-   (x=1,y=0) = 1 echoes every packet addressed to it (acc_loop), so
#-   addressing it by mistake shows up as fake round trips.
#- The spad data is NoC-written and NoC-read only (port A) - the F2
#- port-B/AXI preload mismatch is intentionally not exercised.
#- Firmware built by tools/picorv_c/c64 (mq64_qput.c / mq64_qget.c).

#- 2x2 Tile array
$param{'r'} = 2;
$param{'noc_bw'} = 64;
$param{'c'} = 2;

@tile_array = (['pico64', 'spad'],
               ['loop', 'pico64']);

@pico_program  = ('mq64_qput64.hex', '', '', 'mq64_qget64.hex');

#- Simulation Time
$param{'sim_loop'}     = 300;

#- Checkers
@checkers = ('check_pico64_mq.sh');

#- Running with Icarus
$param{'run_sim'} = 1;

###########################################
#- Generate: Do not modify
###########################################

$param{'checkers'} = \@checkers;
$param{'testcase'} = $0;
$param{'tile_array'} = \@tile_array;
$param{'pico_program'} = \@pico_program;

gen_all(\%param);
