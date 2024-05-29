SECTIONS {
. = 0x50000;
.text : { *(.text) }
. = 0x50140;
.data : { *(.data) }
_ftext = 0x50200;
}
