SECTIONS {
. = 0xec000;
.text : { *(.text) }
. = 0xec140;
.data : { *(.data) }
_ftext = 0xec200;
}
