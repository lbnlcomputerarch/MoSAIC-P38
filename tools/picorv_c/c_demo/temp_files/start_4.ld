SECTIONS {
. = 0x10000;
.text : { *(.text) }
. = 0x10140;
.data : { *(.data) }
_ftext = 0x10200;
}
