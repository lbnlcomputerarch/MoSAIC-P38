SECTIONS {
. = 0xc0000;
.text : { *(.text) }
. = 0xc0140;
.data : { *(.data) }
_ftext = 0xc0200;
}
