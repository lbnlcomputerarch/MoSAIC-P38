# PicoRV64 Vivado testcase design

**Intent:** Add a Vivado counterpart to `mosaic_2x2_vivado.pl` using the already verified PicoRV64 scratchpad workload.

**Scope:** Create only `tools/generate/mosaic_2x2_pico64_vivado.pl`; no RTL or generator changes. Vivado is unavailable, so do not claim simulation execution.

**Approach:** Copy the existing testcase structure and combine its Vivado flags with `mosaic_2x2_pico64_spad.pl`: 64-bit NoC, pico64/spad/loop/pico tiles, `pico64_scratchpad64.hex`, and `check_pico64_spad.sh`. A standalone new file is preferable to changing the PicoRV32 testcase or factoring shared Perl code for a single consumer.

**Validation:** Perl syntax check plus static assertions for every required parameter; inspect tool availability before deciding whether generation can run without attempting simulation.
