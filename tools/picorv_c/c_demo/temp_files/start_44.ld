SECTIONS {
. = 0xb0000;
.text : { *(.text) }
. = 0xb0140;
.data : { *(.data) }
_ftext = 0xb0200;
}
