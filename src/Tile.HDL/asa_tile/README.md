
# ASA accelerator

This directory contains the mosaic glue to integrate the ASA 
accelerator. It does not contain the ASA accelerator. 

testcase: tools/generate/mosaic_asa.pl
c code  : tools/picorv_c/c_asa/send_msg.c
src code: src/Tile.HDL/asa_tile/

Don't forget to set `$param{'vivado_project'}` set to 1 (line 80) to generate the vivado project.


