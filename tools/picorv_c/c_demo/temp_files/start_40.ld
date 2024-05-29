SECTIONS {
. = 0xa0000;
.text : { *(.text) }
. = 0xa0140;
.data : { *(.data) }
_ftext = 0xa0200;
}
