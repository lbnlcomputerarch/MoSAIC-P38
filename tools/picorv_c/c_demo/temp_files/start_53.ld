SECTIONS {
. = 0xd4000;
.text : { *(.text) }
. = 0xd4140;
.data : { *(.data) }
_ftext = 0xd4200;
}
