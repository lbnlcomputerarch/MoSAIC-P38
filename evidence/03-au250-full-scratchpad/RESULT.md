# AU250 full-scratchpad FPGA run — RESULT: PASS (64/64)

Date: 2026-11-17 (run dir 07-fpga-run-20261118T000500Z)

## Outcome

`RUNNER_RESULT: PASS values=64/64 regions=4/4` (logs/runner.attempt2.log, 0 FAIL lines).

The accepted bitstream was programmed via JTAG, pico64_scratchpad32.hex was loaded
into tile 00 through the indirect control plane and verified by readback (84/84
words), tile coordinates were assigned (pico64=0x00, spad=0x08, loop=0x01,
pico32=0x09), the pico64 core was released, and after the run all four expected
64-bit pattern regions read back correct:

| region          | tile  | word32      | expected                     |
|-----------------|-------|-------------|------------------------------|
| tile01_mput     | spad  | 0x100..0x11f| 0xCAFECACECAFECACE + i       |
| tile01_store    | spad  | 0x15a..0x179| 0xF00DF00DF00DF00D + i       |
| tile00_mget     | pico64| 0x180..0x19f| 0xCAFECACECAFECACE + i       |
| tile00_load     | pico64| 0x1da..0x1f9| 0xF00DF00DF00DF00D + i       |

NoC traffic observed: PKTCNT tile00=0x40, tile01=0x30.

## Inputs

- Bitstream: open-nic-shell-lbnl/build/au250/open_nic_shell/open_nic_shell.runs/impl_1/open_nic_shell.bit
  SHA-256 0ece41afae608912040c39a315212574cbfb3a4717b9603780fa98ffe659cc2f
- Firmware: MoSAIC-P38/tools/picorv_c/c64/pico64_scratchpad32.hex (85 lines)
  SHA-256 7ea9e76a9c8b831e4739fc6b70876c93506f2dd2bb25fadcb74afa07d3f2f0e7
- PCI: 0000:d8:00.0 (10ee:903f) under 0000:d7:00.0; BAR2 resource2 = 4 MiB, mode 600;
  onic not loaded; no driver bound. BAR2 map: 4x256 B control windows at
  0x100000+{0x000 pico64, 0x100 spad, 0x200 loop, 0x300 pico32}.

## Independent verification (host-side, from archived artifacts)

- readback/tile00_program_readback.hex diffed against the source hex: identical
  (84 words, addresses 0x000..0x053 sequential).
- All four region .hex files recomputed from the pattern definition (not the
  runner's PASS strings): 16/16 lines each, 0 mismatches (value, both 32-bit
  halves, address, and got=(hi<<32)|lo consistency).
- run-artifacts.sha256: SHA-256 of all logs and raw readback files.

## Attempt 1 (fail-stop, preserved)

logs/runner.attempt1.log, readback/attempt1/, scripts/spad64_runner.attempt1.c,
script-hashes.attempt1.txt.  The first program-readback word read 0xCAFECACE
instead of 0x00004117.  Root cause (RTL-verified, RV_AXIInD.v/TileRegBlock.v/
acc_picorv64.sv/DPRAM_BE.sv): the memory-port address and the read-data capture
both latch on the command pulse, one cycle after Command_Op; a single OP_READ
returns mem[previous command's address] through the stale half-select mux —
here the last firmware word 0x053 (cafecace) upper half.  set_system.c's
indirect_read has the same sequence but never verifies read data, so the flaw
was latent in the legacy flow.  Writes are unaffected (address/data snapshot
together).  Fix: every indirect read issues OP_READ twice (prime, then
capture); see runner-attempt1-vs-attempt2.diff.  Program memory was intact.

## Artifacts

- scripts/: program_au250_once.sh/.tcl (corrected one-off copies of the legacy
  flow), jtag_preflight.tcl (read-only), spad64_runner.c + compiled
  spad64_runner, diffs and script-hashes.txt (+ .attempt1 versions).
- logs/: jtag_preflight.log (PREFLIGHT_OK xcu250_0), program.log (End of
  startup status: HIGH), runner.attempt1.log (FAIL, preserved),
  runner.attempt2.log (PASS).
- readback/: tile00_program_readback.hex, tile01_mput.hex, tile01_store.hex,
  tile00_mget.hex, tile00_load.hex, attempt1/.
- Repository state: open-nic-shell-lbnl unchanged apart from the six
  pre-existing integration edits and untracked pico_programming/tests/.
