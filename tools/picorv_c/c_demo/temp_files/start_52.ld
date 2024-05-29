SECTIONS {
. = 0xd0000;
.text : { *(.text) }
. = 0xd0140;
.data : { *(.data) }
_ftext = 0xd0200;
}
