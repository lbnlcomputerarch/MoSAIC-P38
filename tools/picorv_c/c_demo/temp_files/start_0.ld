SECTIONS {
. = 0x0;
.text : { *(.text) }
. = 0x140;
.data : { *(.data) }
_ftext = 0x200;
}
