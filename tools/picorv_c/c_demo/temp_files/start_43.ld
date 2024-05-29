SECTIONS {
. = 0xac000;
.text : { *(.text) }
. = 0xac140;
.data : { *(.data) }
_ftext = 0xac200;
}
