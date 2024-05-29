SECTIONS {
. = 0x80000;
.text : { *(.text) }
. = 0x80140;
.data : { *(.data) }
_ftext = 0x80200;
}
