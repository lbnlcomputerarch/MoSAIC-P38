SECTIONS {
. = 0x94000;
.text : { *(.text) }
. = 0x94140;
.data : { *(.data) }
_ftext = 0x94200;
}
