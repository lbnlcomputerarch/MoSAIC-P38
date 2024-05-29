SECTIONS {
. = 0x84000;
.text : { *(.text) }
. = 0x84140;
.data : { *(.data) }
_ftext = 0x84200;
}
