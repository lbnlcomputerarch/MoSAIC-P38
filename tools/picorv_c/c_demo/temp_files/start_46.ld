SECTIONS {
. = 0xb8000;
.text : { *(.text) }
. = 0xb8140;
.data : { *(.data) }
_ftext = 0xb8200;
}
