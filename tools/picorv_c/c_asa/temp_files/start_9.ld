SECTIONS {
. = 0x24000;
.text : { *(.text) }
. = 0x24140;
.data : { *(.data) }
_ftext = 0x24200;
}
