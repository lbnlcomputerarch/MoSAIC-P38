SECTIONS {
. = 0x48000;
.text : { *(.text) }
. = 0x48140;
.data : { *(.data) }
_ftext = 0x48200;
}
