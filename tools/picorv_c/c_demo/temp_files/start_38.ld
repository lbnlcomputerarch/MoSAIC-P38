SECTIONS {
. = 0x98000;
.text : { *(.text) }
. = 0x98140;
.data : { *(.data) }
_ftext = 0x98200;
}
