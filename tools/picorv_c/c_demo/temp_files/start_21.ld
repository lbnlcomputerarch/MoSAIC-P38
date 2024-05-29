SECTIONS {
. = 0x54000;
.text : { *(.text) }
. = 0x54140;
.data : { *(.data) }
_ftext = 0x54200;
}
