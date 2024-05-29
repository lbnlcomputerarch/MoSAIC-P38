SECTIONS {
. = 0x60000;
.text : { *(.text) }
. = 0x60140;
.data : { *(.data) }
_ftext = 0x60200;
}
