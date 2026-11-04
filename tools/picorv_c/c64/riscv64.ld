OUTPUT_FORMAT("elf64-littleriscv")
OUTPUT_ARCH(riscv)
ENTRY(_start)

/* ////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : November 3 2026
// Description : Linker script for PICORV64 (pico64 tile) in MoSAIC
// File        : riscv64.ld
// Notes       :
// - Phase 4 of the 64-bit upgrade (plan D22): single-ELF flow adapted
//   from the picorv64 fork's firmware/sections.lds (socks/ffard/picorv64).
//   Replaces MoSAIC's two-ELF start.S+start.ld split used by picorv32.
// - LENGTH corrected by D15b ruling: the legacy per-tile window is 16 KB
//   (4096 32-bit words), so pico64 RAM = 0x4000, NOT the fork's 0x20000
//   (nor D22's original 0x8000 guess). The linker ASSERTs catch overflow.
// - .text.start (start.S) is kept first at 0x0, matching PROGADDR_RESET=0.
////////////////////////////////////////////////////////////// */

MEMORY {
	RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 0x00004000
}

SECTIONS {
	. = ORIGIN(RAM);
	.text : {
		KEEP(*(.text.start))
		*(.text .text.*)
		*(.rodata .rodata.*)
	} > RAM

	.data ALIGN(16) : {
		__data_start = .;
		*(.sdata .sdata.* .data .data.*)
		. = ALIGN(8);
		__data_end = .;
	} > RAM
	__data_load_start = LOADADDR(.data);
	PROVIDE(__global_pointer$ = __data_start + 0x800);

	.init_array ALIGN(16) : {
		__init_array_start = .;
		KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*)))
		KEEP(*(.init_array))
		__init_array_end = .;
	} > RAM

	.bss ALIGN(16) (NOLOAD) : {
		__bss_start = .;
		*(.sbss .sbss.* .bss .bss.* COMMON)
		. = ALIGN(8);
		__bss_end = .;
	} > RAM
	/* Optional bss ceiling for images with absolute (zero)-addressed
	 * save areas.  Links that need it pass
	 * -Wl,--defsym,__irq_bss_limit=0x800; every other image keeps the
	 * default (whole RAM) and is unconstrained. */
	__irq_bss_limit = DEFINED(__irq_bss_limit) ? __irq_bss_limit : (ORIGIN(RAM) + LENGTH(RAM));

	. = ALIGN(16);
	__heap_start = .;
	__stack_top = ORIGIN(RAM) + LENGTH(RAM);
	ASSERT(__heap_start < __stack_top, "firmware exceeds RAM")
	ASSERT(__bss_end < __irq_bss_limit, "bss exceeds __irq_bss_limit (absolute-addressed save area)")
}
