# picorv64_tile

PicoRV64-based 64-bit tile ("pico64" tile type). Phase 3 of the MoSAIC
64-bit upgrade plan (`~/.opencode/plan/mosaic-pico64-integration.md`).

## Vendored core

- **File:** `picorv64.v`
- **Source:** PicoRV64 fork at `socks.lbl.gov/ffard/picorv64`
  (local: `/Users/ffard/Documents/git/socks/ffard/picorv64`)
- **Fork commit:** `47db0ac` ("fix: review-found coverage gaps in formal IRQ invariants")
- **Vendored on:** 2026-11-03
- **Verification:** byte-identical copy of the fork's `picorv64.v` at the
  commit above (`diff -q` clean). Do not edit in place; changes go through
  the fork and are re-vendored with an updated commit hash recorded here.

## Core configuration (plan D20)

The core parameters are set at instantiation in `acc_picorv64.sv` (not in
this file): `ENABLE_PCPI=1, ENABLE_FAST_MUL=1, ENABLE_DIV=1,
ENABLE_COUNTERS=1, BARREL_SHIFTER=1, COMPRESSED_ISA=1, ENABLE_IRQ=0,
PROGADDR_RESET=0, PROGADDR_IRQ=0x10`. The fork's `mem_la_*` look-ahead
ports are ignored (simple `mem_valid/ready` handshake).

## Memory map ruling (plan D15b)

Pico64 local memory is 2048 x 64-bit words = **16 KB** (legacy per-tile
window is 4096 32-bit words; all MoSAIC addresses are 32-bit-word units).
AXI preload uses `mem_addr_axi[0]` as half-select and
`mem_addr_axi[OFFSET_SZ:1]` = `[12:1]` as the 64-bit word index.

## Shared modules

The MQ ISA extension and NoC plumbing live in `../mq_common/`
(`qISAExtension.sv`, `qISAExtension_pcpi.sv`, `mem_spy.sv`,
`noc_out_arbiter.sv`), instantiated at `BW=64, MQ_ADDR_W=8` (D12/D17).
Tile-specific files here: `acc_picorv64.sv`, `Tile_picorv64.sv`,
`firmware/`.
