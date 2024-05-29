SECTIONS {
. = 0xa8000;
.text : { *(.text) }
. = 0xa8140;
.data : { *(.data) }
_ftext = 0xa8200;
}
