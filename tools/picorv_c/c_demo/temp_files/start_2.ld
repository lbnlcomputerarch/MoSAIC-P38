SECTIONS {
. = 0x8000;
.text : { *(.text) }
. = 0x8140;
.data : { *(.data) }
_ftext = 0x8200;
}
