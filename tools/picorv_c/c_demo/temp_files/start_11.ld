SECTIONS {
. = 0x2c000;
.text : { *(.text) }
. = 0x2c140;
.data : { *(.data) }
_ftext = 0x2c200;
}
