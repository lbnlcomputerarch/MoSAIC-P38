SECTIONS {
. = 0x18000;
.text : { *(.text) }
. = 0x18140;
.data : { *(.data) }
_ftext = 0x18200;
}
