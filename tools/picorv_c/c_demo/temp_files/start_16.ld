SECTIONS {
. = 0x40000;
.text : { *(.text) }
. = 0x40140;
.data : { *(.data) }
_ftext = 0x40200;
}
