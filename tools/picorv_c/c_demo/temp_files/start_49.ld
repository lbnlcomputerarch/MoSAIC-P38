SECTIONS {
. = 0xc4000;
.text : { *(.text) }
. = 0xc4140;
.data : { *(.data) }
_ftext = 0xc4200;
}
