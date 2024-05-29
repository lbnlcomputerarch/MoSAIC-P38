SECTIONS {
. = 0xe0000;
.text : { *(.text) }
. = 0xe0140;
.data : { *(.data) }
_ftext = 0xe0200;
}
