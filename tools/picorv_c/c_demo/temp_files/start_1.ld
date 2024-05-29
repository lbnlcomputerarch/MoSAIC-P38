SECTIONS {
. = 0x4000;
.text : { *(.text) }
. = 0x4140;
.data : { *(.data) }
_ftext = 0x4200;
}
