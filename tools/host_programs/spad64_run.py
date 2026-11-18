# *************************************************************************
#
# *** Copyright Notice ***
#
# P38 heterogeneous multi-tiled system with support for message queues
# (MoSAIC) Copyright (c) 2026, The Regents of the University of California,
# through Lawrence Berkeley National Laboratory (subject to receipt of
# any required approvals from the U.S. Dept. of Energy). All rights reserved.
#
# If you have questions about your rights to use or distribute this software,
# please contact Berkeley Lab's Intellectual Property Office at
# IPO@lbl.gov.
#
# *************************************************************************

"""
File: spad64_run.py
Author: Farzad Fatollahi-Fard -- ffard@lbl.gov --
Date: November 18 2026
Description:
  Host-side load/run/verify of a pico64 + scratchpad tile pair on the AU250
  (open-nic-shell) using RegIO v1.1 exactly as shipped (unmodified).  Loads
  pico64_scratchpad32.hex into the pico64 tile through the indirect control
  plane, verifies the program by readback, assigns tile coordinates,
  releases the core, and checks the four expected 64-bit pattern regions
  (mirrors tools/checkers/check_pico64_spad.sh and the validated C runner
  tools/host_programs/spad64_runner.c in the MoSAIC repo).

  Validated design assumptions (hardcoded for testcase
  mosaic_2x2_pico64_vivado, TILE_TYPE 8'b00100111):
  - BAR2 = 4 x 256 B control windows at 0x100000 + 0x100*k,
    k = row*2+col: tilereg0_0=pico64, tilereg0_1=spad,
    tilereg1_0=loop, tilereg1_1=pico32.  (regBlock_top_ir.yaml encodes
    the same map; verified against RTL axi_ux_addr_var.vh decode.)
  - Tile coordinates (id = (col << 3) | row): pico64=0x00, spad=0x08,
    loop=0x01, pico32=0x09.
  - Registers (regio names): readData_Status 0x0, readData_Command 0x4,
    readData_Addr 0x8, readData_Data 0xc, readData_Coordinates 0x10,
    readData_RxPacketCount 0x14.  Ops: 1 write, 2 read, 3 status,
    4 riscv.  Status reads 0xff after an accepted write/read command.
  - Expected regions (word32 addresses, 64-bit value i = low half at
    base+2i, high half at base+2i+1):
      spad  0x100 : 16 x (0xCAFECACECAFECACE + i)   (mPut writes)
      spad  0x15A : 16 x (0xF00DF00DF00DF00D + i)   (remote stores)
      pico  0x180 : 16 x (0xCAFECACECAFECACE + i)   (mGet responses)
      pico  0x1DA : 16 x (0xF00DF00DF00DF00D + i)   (remote load results)

  IMPORTANT - corrected indirect read (do not use
  custom_functions_regIO.indirect_read_cb for verified readback):
  In RV_AXIInD.v the memory-port address (addr_inst) and the read-data
  capture (dout_inst) latch on the command-write pulse one cycle AFTER
  the command register, so a SINGLE OP_READ returns the previous
  command's addressed data through the stale half-select mux.  This was
  proven on hardware 2026-11-17 (MoSAIC evidence
  evidence/03-au250-full-scratchpad/, run 07 attempt 1): word32 0x000
  read back 0xCAFECACE = last firmware word's upper half.  Every
  indirect read here therefore issues OP_READ twice: the first command
  primes the address snapshot, the second captures mem[addr].  Writes
  need no such treatment (address and data snapshot together).
  indirect_read_cb in custom_functions_regIO.py v1.1 has the single-
  command sequence (same latent flaw as open-nic-shell set_system.c);
  a fix worth contributing upstream separately.

  Fail-stop: exits nonzero on the first unexpected status or mismatched
  word; writes raw readback .hex files into the output directory.
  The final RUNNER_RESULT: line is authoritative.

  Validated on the AU250 (xcu250) 2026-11-18 with a freshly programmed
  accepted bitstream: RUNNER_RESULT PASS values=64/64 regions=4/4,
  program readback 84/84, PKTCNT tile00=0x40 tile01=0x30.  Raw readbacks
  are byte-identical to the C runner's (spad64_runner.c) archived files.
  Run record: evidence/04-au250-regio-run/; the C-runner record is
  evidence/03-au250-full-scratchpad/.  Offline validation against a
  register-level mock with the stale-read semantics:
  scripts/test_spad64_run.py in the run record (5/5).

Usage:
  sudo python3 spad64_run.py <outdir> [--hex <pico64_scratchpad32.hex>]
                                [--device <pci-addr>]
  (sudo: resource2 is root-only, mode 600; run from this directory so
  RegIO.py / custom_functions_regIO.py / regBlock_top_ir.yaml resolve.)
"""

import argparse
import os
import sys
import time

import RegIO as regio_mod              # noqa: E402  (RegIO v1.1, unmodified)
import custom_functions_regIO as cf    # noqa: E402  (RegIO v1.1, unmodified)

# --- indirect control-plane constants (verified against RV_AXIInD.v) ---
OP_WRITE = 1
OP_READ = 2
OP_STATUS = 3
OP_RISCV = 4
STATUS_OK = 0xFF

# --- tile map: name -> (row, col, coordinate id, BAR2 window base) ---
TILES = [
    ("tile00", "pico64", 0, 0, 0x00, 0x100000),
    ("tile01", "spad",   0, 1, 0x08, 0x100100),
    ("tile10", "loop",   1, 0, 0x01, 0x100200),
    ("tile11", "pico32", 1, 1, 0x09, 0x100300),
]
TILE_BY_NAME = {t[1]: t for t in TILES}
PICO = "pico64"
SPAD = "spad"

# --- expected regions: (file name, tile, word32 base, 64-bit pattern) ---
IT = 16
REGIONS = [
    ("tile01_mput",  SPAD, 0x100, 0xCAFECACECAFECACE),
    ("tile01_store", SPAD, 0x15A, 0xF00DF00DF00DF00D),
    ("tile00_mget",  PICO, 0x180, 0xCAFECACECAFECACE),
    ("tile00_load",  PICO, 0x1DA, 0xF00DF00DF00DF00D),
]

RUN_SLEEP = 2.0  # s, as in set_system/spad64_runner


class RunError(Exception):
    """Fail-stop: any unexpected status, mismatch, or bad input."""


# ---------------------------------------------------------------- helpers

def parse_hex(path):
    """Parse a firmware hex file: optional '@<hexaddr>' headers, one
    32-bit word per line, consecutive word addresses.  Returns
    [(addr, word32), ...]."""
    words = []
    addr = 0
    with open(path, "r") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            if line.startswith("@"):
                addr = int(line[1:], 16)
                continue
            words.append((addr, int(line, 16) & 0xFFFFFFFF))
            addr += 1
    if not words:
        raise RunError("no words parsed from %s" % path)
    return words


def indirect_write32(rio, tile, waddr, data):
    """One word32 into tile memory via the indirect control plane.
    Writes are safe with a single command: address and data snapshot
    together (verified in RV_AXIInD.v / acc_picorv64.sv)."""
    row, col = tile[2], tile[3]
    rc = cf.indirect_write_cb(row, col, waddr, data, rio)
    if rc != cf.SUCCESS:
        raise RunError("indirect write word32 0x%03x %s: status 0x%08x"
                       % (waddr, tile[0], rc & 0xFFFFFFFF))


def indirect_read32(rio, tile, waddr):
    """One word32 from tile memory.  CORRECTED READ: two OP_READ
    commands per word (prime, then capture) -- see module docstring."""
    row, col = tile[2], tile[3]
    cf.write_reg_cb(row, col, "readData_Addr", waddr, rio)
    cf.write_reg_cb(row, col, "readData_Command", OP_READ, rio)   # prime
    st = cf.read_reg_cb(row, col, "readData_Status", rio)
    if st != STATUS_OK:
        raise RunError("indirect read prime word32 0x%03x %s: status 0x%08x"
                       % (waddr, tile[0], st & 0xFFFFFFFF))
    cf.write_reg_cb(row, col, "readData_Command", OP_READ, rio)   # capture
    st = cf.read_reg_cb(row, col, "readData_Status", rio)
    if st != STATUS_OK:
        raise RunError("indirect read word32 0x%03x %s: status 0x%08x"
                       % (waddr, tile[0], st & 0xFFFFFFFF))
    return cf.read_reg_cb(row, col, "readData_Data", rio) & 0xFFFFFFFF


def rv_set_status(rio, tile, value):
    """Set the tile's rv_control (0=reset, 1=run) and return the
    post-OP_STATUS status mirror (cf.rvSetStatus_cb, verified protocol)."""
    row, col = tile[2], tile[3]
    return cf.rvSetStatus_cb(row, col, value & 0xFF, rio) & 0xFFFFFFFF


# ------------------------------------------------------------------ stages

def print_pre_state(rio):
    print("== pre-state (direct reads)")
    for tile in TILES:
        row, col = tile[2], tile[3]
        vals = {}
        for reg in ("readData_Status", "readData_Command", "readData_Addr",
                    "readData_Data", "readData_Coordinates",
                    "readData_RxPacketCount"):
            vals[reg] = cf.read_reg_cb(row, col, reg, rio) & 0xFFFFFFFF
        print("  %-6s %-6s status=0x%08x cmd=0x%08x addr=0x%08x "
              "data=0x%08x coord=0x%02x pktcnt=0x%08x"
              % (tile[0], tile[1], vals["readData_Status"],
                 vals["readData_Command"], vals["readData_Addr"],
                 vals["readData_Data"], vals["readData_Coordinates"],
                 vals["readData_RxPacketCount"]))


def load_and_verify_program(rio, hex_path):
    tile = TILE_BY_NAME[PICO]
    words = parse_hex(hex_path)
    for (waddr, data) in words:
        indirect_write32(rio, tile, waddr, data)
    print("loaded %d word32 into %s" % (len(words), tile[0]))
    for (waddr, want) in words:
        got = indirect_read32(rio, tile, waddr)
        if got != want:
            raise RunError("program readback word32 0x%03x: got 0x%08x, "
                           "want 0x%08x" % (waddr, got, want))
    print("program readback verified (%d words)" % len(words))


def set_coordinates(rio):
    print("== tile coordinates")
    for tile in TILES:
        row, col = tile[2], tile[3]
        cf.write_reg_cb(row, col, "readData_Coordinates", tile[4], rio)
    for tile in TILES:
        row, col = tile[2], tile[3]
        got = cf.read_reg_cb(row, col, "readData_Coordinates", rio) & 0xFFFFFFFF
        if got != tile[4]:
            raise RunError("coordinate readback mismatch for %s: got 0x%02x, "
                           "want 0x%02x" % (tile[0], got, tile[4]))
        print("  %-6s coord=0x%02x" % (tile[0], got))


def run(rio, hex_path, out_dir):
    """Full runner sequence.  Returns 0 iff all 64 values PASS."""
    print_pre_state(rio)

    # 1) hold the pico64 core in reset
    data = rv_set_status(rio, TILE_BY_NAME[PICO], 0x00)
    print("rvSetStatus(tile00, 0x00) -> 0x%02x" % data)
    if data != 0x00:
        raise RunError("rv reset readback 0x%02x, expected 0x00" % data)

    # 2) load the firmware through the indirect control plane
    load_and_verify_program(rio, hex_path)

    # 3) assign tile coordinates (identity used by the NoC routers)
    set_coordinates(rio)

    # 4) release the pico64 core
    data = rv_set_status(rio, TILE_BY_NAME[PICO], 0x01)
    print("rvSetStatus(tile00, 0x01) -> 0x%02x" % data)
    if data != 0x01:
        raise RunError("rv release readback 0x%02x, expected 0x01" % data)

    # 5) wait for execution (as in set_system / spad64_runner)
    time.sleep(RUN_SLEEP)

    # 6) post-run packet counters
    pico = TILE_BY_NAME[PICO]
    spad = TILE_BY_NAME[SPAD]
    pc0 = cf.read_reg_cb(pico[2], pico[3], "readData_RxPacketCount", rio)
    pc1 = cf.read_reg_cb(spad[2], spad[3], "readData_RxPacketCount", rio)
    print("== post-run packet counters")
    print("PKTCNT tile00=0x%08x tile01=0x%08x"
          % (pc0 & 0xFFFFFFFF, pc1 & 0xFFFFFFFF))

    # 7) read and check the four expected regions
    values_ok = 0
    regions_ok = 0
    for (name, tile_name, base, pattern) in REGIONS:
        tile = TILE_BY_NAME[tile_name]
        region_pass = True
        path = os.path.join(out_dir, name + ".hex")
        with open(path, "w") as f:
            print("== region %s (%s %s, tile 0x%05x, word32 0x%03x..0x%03x)"
                  % (name, tile[0], tile[1], tile[5],
                     base, base + 2 * IT - 1))
            for j in range(IT):
                lo = indirect_read32(rio, tile, base + 2 * j)
                hi = indirect_read32(rio, tile, base + 2 * j + 1)
                got = ((hi << 32) | lo) & 0xFFFFFFFFFFFFFFFF
                want = (pattern + j) & 0xFFFFFFFFFFFFFFFF
                ok = (got == want)
                f.write("0x%03x 0x%08x 0x%08x 0x%016x %s\n"
                        % (base + 2 * j, lo, hi, got, "PASS" if ok else "FAIL"))
                print("  [%2d] got 0x%016x want 0x%016x %s"
                      % (j, got, want, "PASS" if ok else "FAIL"))
                if ok:
                    values_ok += 1
                else:
                    region_pass = False
        if region_pass:
            regions_ok += 1
        print("region %s: %s -> %s"
              % (name, "PASS" if region_pass else "FAIL", path))

    total = 4 * IT
    result = "PASS" if values_ok == total else "FAIL"
    print("RUNNER_RESULT: %s values=%d/%d regions=%d/4"
          % (result, values_ok, total, regions_ok))
    return 0 if values_ok == total else 1


# -------------------------------------------------------------------- main

def main(argv=None):
    parser = argparse.ArgumentParser(
        description="Load/run/verify pico64+scratchpad on AU250 via RegIO")
    parser.add_argument("outdir", help="directory for raw readback .hex files")
    parser.add_argument("--hex", default=os.path.join(
        "..", "MoSAIC-P38", "tools", "picorv_c", "c64",
        "pico64_scratchpad32.hex"),
        help="firmware hex (default: ../MoSAIC-P38/tools/picorv_c/c64/"
             "pico64_scratchpad32.hex)")
    parser.add_argument("--device", default="0000:d8:00.0",
                        help="PCI address of the Alveo function")
    args = parser.parse_args(argv)

    out_dir = os.path.abspath(args.outdir)
    hex_path = os.path.abspath(args.hex)
    if not os.path.isfile(hex_path):
        print("spad64_run: FAIL: firmware hex not found: %s" % hex_path,
              file=sys.stderr)
        return 1
    os.makedirs(out_dir, exist_ok=True)

    regmap = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                          "regBlock_top_ir.yaml")
    print("RegIO select=%s bar=2 regmap=%s" % (args.device, regmap))
    print("firmware=%s outdir=%s" % (hex_path, out_dir))
    rio = regio_mod.RegIO(select=args.device, bar=2, regmap=regmap,
                          debug=False)
    try:
        return run(rio, hex_path, out_dir)
    except RunError as e:
        print("spad64_run: FAIL: %s" % e, file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
