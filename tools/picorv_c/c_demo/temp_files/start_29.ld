SECTIONS {
. = 0x74000;
.text : { *(.text) }
. = 0x74140;
.data : { *(.data) }
_ftext = 0x74200;
}
