SECTIONS {
. = 0xd8000;
.text : { *(.text) }
. = 0xd8140;
.data : { *(.data) }
_ftext = 0xd8200;
}
