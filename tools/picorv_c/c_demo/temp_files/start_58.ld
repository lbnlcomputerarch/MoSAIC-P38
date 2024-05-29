SECTIONS {
. = 0xe8000;
.text : { *(.text) }
. = 0xe8140;
.data : { *(.data) }
_ftext = 0xe8200;
}
