SECTIONS {
. = 0x90000;
.text : { *(.text) }
. = 0x90140;
.data : { *(.data) }
_ftext = 0x90200;
}
