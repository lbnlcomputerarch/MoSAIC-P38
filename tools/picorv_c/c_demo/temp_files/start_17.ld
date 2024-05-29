SECTIONS {
. = 0x44000;
.text : { *(.text) }
. = 0x44140;
.data : { *(.data) }
_ftext = 0x44200;
}
