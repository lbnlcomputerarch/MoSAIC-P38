SECTIONS {
. = 0xe4000;
.text : { *(.text) }
. = 0xe4140;
.data : { *(.data) }
_ftext = 0xe4200;
}
