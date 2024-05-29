SECTIONS {
. = 0xc8000;
.text : { *(.text) }
. = 0xc8140;
.data : { *(.data) }
_ftext = 0xc8200;
}
