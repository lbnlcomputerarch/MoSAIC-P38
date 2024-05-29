SECTIONS {
. = 0x30000;
.text : { *(.text) }
. = 0x30140;
.data : { *(.data) }
_ftext = 0x30200;
}
