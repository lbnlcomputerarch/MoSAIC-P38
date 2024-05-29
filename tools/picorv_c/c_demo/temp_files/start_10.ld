SECTIONS {
. = 0x28000;
.text : { *(.text) }
. = 0x28140;
.data : { *(.data) }
_ftext = 0x28200;
}
