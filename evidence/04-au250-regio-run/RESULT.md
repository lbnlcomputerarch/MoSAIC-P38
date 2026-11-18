# AU250 RegIO run — RESULT: PASS (64/64)

Date: 2026-11-18 (dir 08-fpga-run-regio-20261118T180216Z)

## Outcome

First FPGA run driven entirely by RegIO v1.1 (Python) on the accepted
mosaic_2x2_pico64_vivado bitstream, via spad64_run.py:

  RUNNER_RESULT: PASS values=64/64 regions=4/4   (logs/spad64_run.log, 0 FAIL lines)

- Pre-state: all four tiles all-zero (fresh JTAG reprogram just before the run)
- pico64_scratchpad32.hex loaded (84 word32) and verified by readback (84/84)
  through the corrected double-OP_READ read (RegIO's own indirect_read_cb has
  the single-command flaw proven on hardware in run 07 attempt 1; the corrected
  read lives in spad64_run.py, RegIO files untouched)
- Coordinates 0x00/0x08/0x01/0x09 written and read back; core released (0x01)
- PKTCNT tile00=0x40 tile01=0x30 — identical to the C-runner run 07

## Independent verification (host-side, from archived artifacts)

- All four region .hex files recomputed from the pattern definitions
  (0xCAFECACECAFECACE+i, 0xF00DF00DF00DF00D+i): 16/16 lines each,
  0 mismatches (address, both 32-bit halves, got=(hi<<32)|lo, PASS).
- Cross-stack bit-for-bit diff vs the C runner's archived readback
  (evidence/07-fpga-run-20261118T000500Z/readback/): all four files
  IDENTICAL.  Two independent host stacks (C hardcoded offsets vs
  Python YAML-driven RegIO), same bitstream+firmware, same raw data.

## Offline validation before the run

scripts/test_spad64_run.py: register-level mock reproducing RV_AXIInD's
one-cycle-late address/data latch; naive single OP_READ demonstrably stale,
corrected double-OP_READ correct on first call; full pipeline, planted-fault
detection (63/64, exit 1), stuck-write fail-stop.  5/5 passed before the
script ever touched hardware.

## Artifacts

- logs/spad64_run.log          full run log (sudo python3 spad64_run.py | tee)
- readback/*.hex               raw readback, 4 regions x 16 values
- scripts/spad64_run.py        as-run (sha256 cf68e765...; deployed copy in
                               mosaic_regIO/ identical)
- scripts/test_spad64_run.py   offline validation (mock semantics)
- artifacts.sha256             SHA-256 of all files in this directory
- RegIO checkout state: v1.1 tag pristine; only addition is the untracked
  spad64_run.py (zero modifications to tracked files)
