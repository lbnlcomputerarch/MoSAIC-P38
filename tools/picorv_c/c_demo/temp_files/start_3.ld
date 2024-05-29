SECTIONS {
. = 0xc000;
.text : { *(.text) }
. = 0xc140;
.data : { *(.data) }
_ftext = 0xc200;
}
