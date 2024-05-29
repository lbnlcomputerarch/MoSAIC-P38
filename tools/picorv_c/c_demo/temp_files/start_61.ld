SECTIONS {
. = 0xf4000;
.text : { *(.text) }
. = 0xf4140;
.data : { *(.data) }
_ftext = 0xf4200;
}
