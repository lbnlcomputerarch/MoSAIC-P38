SECTIONS {
. = 0x68000;
.text : { *(.text) }
. = 0x68140;
.data : { *(.data) }
_ftext = 0x68200;
}
