# Host programs

Host-side (x86) utilities for programming and verifying MoSAIC tiles on FPGA
systems.  Complementary to the on-core firmware in `tools/picorv_c/` and the
simulation checkers in `tools/checkers/`.

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
