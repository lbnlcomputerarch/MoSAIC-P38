SECTIONS {
. = 0x88000;
.text : { *(.text) }
. = 0x88140;
.data : { *(.data) }
_ftext = 0x88200;
}
