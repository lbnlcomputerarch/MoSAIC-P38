# PicoRV64 Vivado Testcase Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a PicoRV64 equivalent of the existing 2x2 Vivado scratchpad testcase.

**Architecture:** Reuse the verified PicoRV64 Icarus testcase parameters and the existing PicoRV32 testcase's Vivado flags in one new Perl generator input. Do not modify shared code.

**Tech Stack:** Perl, existing `gen_mosaic.pm` generator, Vivado invocation requested but unavailable locally.

**Spec:** `docs/superpowers/specs/2026-11-12-picorv64-vivado-testcase-design.md`

## Global Constraints

- Create only `tools/generate/mosaic_2x2_pico64_vivado.pl` as product code.
- Preserve the existing PicoRV32 testcase unchanged.
- Do not run or claim to have run Vivado on this machine.

## Review Focus

- 32-bit default regression runtime default: assert `noc_bw=64` statically in Task 1 step 4.
- Wrong firmware/tool format: assert `pico64_scratchpad64.hex` in Task 1 step 4.
- Accidental Icarus selection: assert `vivado=1` and `vivado_project=1` in Task 1 step 4.
- Incomplete tile workload: assert tile array and both firmware entries in Task 1 step 4.
- Missing validation of the final memory: assert `check_pico64_spad.sh` in Task 1 step 4.

---

### Task 1: Add the PicoRV64 Vivado generator testcase

**Files:**
- Create: `tools/generate/mosaic_2x2_pico64_vivado.pl`
- Reference: `tools/generate/mosaic_2x2_vivado.pl`
- Reference: `tools/generate/mosaic_2x2_pico64_spad.pl`

**Interfaces:**
- Consumes: existing `gen_all(\%param)` generator API and committed firmware/checker.
- Produces: a standalone Vivado 2x2 pico64/spad testcase.

- [ ] **Step 1: Write a failing static testcase check**

Check that the file exists and contains the required parameters; initially it must fail because the file is absent.

- [ ] **Step 2: Create the testcase**

Copy the copyright/Perl structure from the existing files and set the exact tile, firmware, width, checker, timing, and Vivado values from the approved design.

- [ ] **Step 3: Validate syntax and configuration**

Run `perl -c tools/generate/mosaic_2x2_pico64_vivado.pl` from `tools/generate`, and a static requirement check. Expect syntax OK and every parameter assertion to pass.

- [ ] **Step 4: Check the final diff**

Run `git diff --check` and inspect the file diff. Do not invoke `gen_all` because `run_sim=1` would require unavailable Vivado.

- [ ] **Step 5: Commit**

Commit the design, plan, and testcase after verification.
