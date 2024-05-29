SECTIONS {
. = 0xb4000;
.text : { *(.text) }
. = 0xb4140;
.data : { *(.data) }
_ftext = 0xb4200;
}
