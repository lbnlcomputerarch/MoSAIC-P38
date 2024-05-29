SECTIONS {
. = 0xa4000;
.text : { *(.text) }
. = 0xa4140;
.data : { *(.data) }
_ftext = 0xa4200;
}
