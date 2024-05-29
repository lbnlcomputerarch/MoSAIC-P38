SECTIONS {
. = 0x8c000;
.text : { *(.text) }
. = 0x8c140;
.data : { *(.data) }
_ftext = 0x8c200;
}
