SECTIONS {
. = 0x58000;
.text : { *(.text) }
. = 0x58140;
.data : { *(.data) }
_ftext = 0x58200;
}
