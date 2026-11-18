# Host programs

Host-side (x86) utilities for programming and verifying MoSAIC tiles on FPGA
systems.  Complementary to the on-core firmware in `tools/picorv_c/` and the
simulation checkers in `tools/checkers/`.  Two validated runners cover the
pico64 + scratchpad bring-up flow: `spad64_runner` (C, self-contained mmap)
and `spad64_run` (Python, built on the RegIO tool).

## spad64_runner

Loads `pico64_scratchpad32.hex` into a pico64 tile through the BAR2 indirect
control plane, assigns tile coordinates, releases the core, and verifies the
four expected 64-bit pattern regions on the pico64 + scratchpad tile pair.
Mirrors the expectations of `tools/checkers/check_pico64_spad.sh` on real
hardware.

```
gcc -std=c11 -O2 -Wall -Wextra -Werror -o spad64_runner spad64_runner.c
sudo ./spad64_runner <resource2-path> <pico64_scratchpad32.hex> <outdir>
```

`<resource2-path>` is the card's BAR2 sysfs map (e.g.
`/sys/bus/pci/devices/0000:d8:00.0/resource2`); run under sudo (the map is
root-only, mode 600) and leave the NIC driver unloaded so no driver is bound
to the device.  The runner is fail-stop: it exits nonzero on the first
unexpected status or mismatched word, and writes raw readback `.hex` files
into `<outdir>`.  The final `RUNNER_RESULT:` line is authoritative.

### Assumptions (hardcoded for the AU250 2x2 pico64+spad bitstream)

- BAR2 control windows: 4 x 256 B at `0x100000+{0x000 pico64, 0x100 spad,
  0x200 loop, 0x300 pico32}` — the generated `axi_ux_addr_var.vh` decode for
  testcase `tools/generate/mosaic_2x2_pico64_vivado.pl`
  (`TILE_TYPE 8'b00100111`).  The legacy `pico_programming/set_system.c`
  tile offsets (0x400/0x500, 1 KB windows) do NOT apply to this decode.
- Tile identity comes from the software-written coordinate register 0x10,
  `id = (col << 3) | row`: pico64=0x00, spad=0x08 (`TID_SPAD`), loop=0x01,
  pico32=0x09.
- Firmware: `tools/picorv_c/c64/pico64_scratchpad32.hex` (one 32-bit word per
  line at consecutive word addresses after the `@00000000` header).
- Expected patterns (16 x 64-bit values, low half at word32 base+2i):
  `0xCAFECACECAFECACE + i` at spad 0x100 and pico 0x180 (mPut / mGet),
  `0xF00DF00DF00DF00D + i` at spad 0x15A and pico 0x1DA (remote stores /
  loads), per `tools/checkers/check_pico64_spad.sh`.

### Indirect-read handshake (important)

In `RV_AXIInD.v`, the memory-port address and the read-data capture both
latch on the command-write pulse, one cycle *after* the command register
latches.  A **single** `OP_READ` therefore returns the *previous* command's
addressed data (observed on hardware: word32 0x000 read back the last
firmware word's upper half through the stale half-select mux).  Every
indirect read must issue `OP_READ` **twice**: the first command primes the
address snapshot, the second captures `mem[addr]`.  Writes need no such
treatment (address and data snapshot together).

Note that `pico_programming/set_system.c` in the open-nic-shell tree uses
the single-command read sequence and never verifies read data, so host tools
copied from it must not be trusted for readback without this fix.

### Validation

AU250 (xcu250), bitstream built from testcase `mosaic_2x2_pico64_vivado`,
2026-11-17: `RUNNER_RESULT: PASS values=64/64 regions=4/4`, program readback
84/84 words, NoC packet counters nonzero on both tiles.  Full run record:
`evidence/03-au250-full-scratchpad/`.

Generalizing the hardcoded tile/window addresses (other tile maps, window
decodes, or BAR layouts) is future work.

## spad64_run

Same load/run/verify flow as `spad64_runner`, implemented in Python on top of
the [RegIO](https://github.com/esnet/regio)-based MoSAIC tool (checkout tagged
`v1.1`) instead of raw mmap code.  It uses RegIO exactly as shipped — the
BAR2 register map (`regBlock_top_ir.yaml`), the register accessors, the
indirect writes, and `rvSetStatus` all come from RegIO — and carries exactly
one local addition: the corrected double-`OP_READ` indirect read described in
"Indirect-read handshake" above.  RegIO v1.1's
`custom_functions_regIO.indirect_read_cb` has the single-command flaw (and
`rvLoadFirmware_cb` never verifies readback), so its read path must not be
used for verified readback without this fix; contributing it upstream is
future work.

```
sudo python3 spad64_run.py <outdir> [--hex <pico64_scratchpad32.hex>] [--device <pci-addr>]
```

Deploy the script into a `mosaic_regIO` checkout (untracked addition, tag
pristine) and run it from that directory so `RegIO.py`,
`custom_functions_regIO.py`, and `regBlock_top_ir.yaml` resolve; the default
`--hex` is `../MoSAIC-P38/tools/picorv_c/c64/pico64_scratchpad32.hex` for the
standard workspace layout.  Requires Python 3.8+ with PyYAML and numpy
(RegIO dependencies) and sudo for the root-only `resource2` map.  Same
fail-stop behavior, raw readback files, and authoritative `RUNNER_RESULT:`
line as `spad64_runner`.

### Validation

AU250 (xcu250), freshly programmed accepted bitstream, 2026-11-18:
`RUNNER_RESULT: PASS values=64/64 regions=4/4`, program readback 84/84
words, PKTCNT `tile00=0x40 tile01=0x30` — and all four raw readback files
byte-identical to `evidence/03-au250-full-scratchpad/`, i.e. two independent
host stacks (C hardcoded offsets, Python YAML-driven) reproducing the same
silicon data.  Run record: `evidence/04-au250-regio-run/` (includes the
offline mock-validation test that reproduces the stale-read semantics and
proves the corrected read, 5/5, before the script ever touched hardware).

Generalizing the hardcoded tile/window addresses in both runners (other tile
maps, window decodes, or BAR layouts) is future work.
