SECTIONS {
. = 0x34000;
.text : { *(.text) }
. = 0x34140;
.data : { *(.data) }
_ftext = 0x34200;
}
