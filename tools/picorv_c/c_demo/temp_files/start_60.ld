SECTIONS {
. = 0xf0000;
.text : { *(.text) }
. = 0xf0140;
.data : { *(.data) }
_ftext = 0xf0200;
}
