SECTIONS {
. = 0x38000;
.text : { *(.text) }
. = 0x38140;
.data : { *(.data) }
_ftext = 0x38200;
}
