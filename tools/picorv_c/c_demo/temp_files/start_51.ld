SECTIONS {
. = 0xcc000;
.text : { *(.text) }
. = 0xcc140;
.data : { *(.data) }
_ftext = 0xcc200;
}
