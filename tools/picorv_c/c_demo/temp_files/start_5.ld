SECTIONS {
. = 0x14000;
.text : { *(.text) }
. = 0x14140;
.data : { *(.data) }
_ftext = 0x14200;
}
