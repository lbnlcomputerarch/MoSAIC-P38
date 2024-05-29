SECTIONS {
. = 0x6c000;
.text : { *(.text) }
. = 0x6c140;
.data : { *(.data) }
_ftext = 0x6c200;
}
