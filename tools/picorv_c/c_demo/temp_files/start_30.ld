SECTIONS {
. = 0x78000;
.text : { *(.text) }
. = 0x78140;
.data : { *(.data) }
_ftext = 0x78200;
}
