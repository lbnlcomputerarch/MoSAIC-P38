SECTIONS {
. = 0xf8000;
.text : { *(.text) }
. = 0xf8140;
.data : { *(.data) }
_ftext = 0xf8200;
}
