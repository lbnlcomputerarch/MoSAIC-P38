/* ////////////////////////////////////////////////////////////////
// Author      : Farzad Fatollahi-Fard
// Date        : November 3 2026
// Description : RV64 crt0 for pico64 tiles (MoSAIC)
// File        : start.S
// Notes       :
// - Phase 4 (plan D22): adapted from the picorv64 fork's
//   firmware/start.S (socks/ffard/picorv64) for the single-ELF flow.
// - Deviation from the fork: the fork stores main's return value to a
//   debug device at 0x10000000 before spinning. MoSAIC has no such
//   device — the address decodes as a remote access that would park
//   the core's memory interface — so we simply spin (main never
//   returns in MoSAIC firmware).
////////////////////////////////////////////////////////////// */

	.section .text.start,"ax",@progbits
	.globl _start
_start:
	la sp, __stack_top
	.option push
	.option norelax
	la gp, __global_pointer$
	.option pop

	la t0, __data_load_start
	la t1, __data_start
	la t2, __data_end
1:	beq t1, t2, 2f
	ld t3, 0(t0)
	sd t3, 0(t1)
	addi t0, t0, 8
	addi t1, t1, 8
	j 1b

2:	la t0, __bss_start
	la t1, __bss_end
3:	beq t0, t1, 4f
	sd zero, 0(t0)
	addi t0, t0, 8
	j 3b

4:	la s0, __init_array_start
	la s1, __init_array_end
5:	beq s0, s1, 6f
	ld t0, 0(s0)
	jalr ra, t0, 0
	addi s0, s0, 8
	j 5b

6:	call main
7:	j 7b
