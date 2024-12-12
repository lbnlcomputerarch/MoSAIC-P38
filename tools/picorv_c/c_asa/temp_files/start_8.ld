SECTIONS {
. = 0x20000;
.text : { *(.text) }
. = 0x20140;
.data : { *(.data) }
_ftext = 0x20200;
}
