SECTIONS {
. = 0x4c000;
.text : { *(.text) }
. = 0x4c140;
.data : { *(.data) }
_ftext = 0x4c200;
}
