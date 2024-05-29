SECTIONS {
. = 0x70000;
.text : { *(.text) }
. = 0x70140;
.data : { *(.data) }
_ftext = 0x70200;
}
