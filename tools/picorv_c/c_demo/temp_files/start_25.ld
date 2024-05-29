SECTIONS {
. = 0x64000;
.text : { *(.text) }
. = 0x64140;
.data : { *(.data) }
_ftext = 0x64200;
}
