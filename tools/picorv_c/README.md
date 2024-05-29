# PICORV32 C code for Mosaic

This directory contains files required to generate the firmware to be loaded in the PICORV scratchpad memories.

# Files

- Modified from the [PICORV](https://github.com/YosysHQ/picorv32) repository. 
  - Makefile: Use this to compile C/C++ and generate the `<program>.hex` file to be loaded in the PICORV scratchpad.             
  - start.ld: Linker script
  - riscv.ld: RISCV linker script
  - start.S
  - hex8tohex32.py : Python script used to convert from hex8 to hex32.  
- For message queues support add the following libraries to your c/c++ code. Modified from [P38-MQ-Lib](https://github.com/anabutko/P38-MQ-Lib)
  - mq.h: contains high-level functions to be used in the c/c++ source code.
  - xcustom.h: contains pseudo directives that tranlsate the high-level functions into the low-level assembler.              

# How to use

1. Install the RISCV tools as described [here](https://github.com/YosysHQ/picorv32).
3. execute `make SRC_FNAME=<code>` to compile a `<code>.c`
4. the `<code>32.hex` is the file loaded in the scratchpad for simulation. Add this to the testcase in the `tools/generate/<testcase>.pl` file.


For examples on programs for `mosaic` go to /tools/picorv_c/

For examples on programs for PICORV32 go to [PICORV32](https://github.com/YosysHQ/picorv32) repository.

## OTHERS

Using this flow, you can start with a ***.c*** file of your own that contains code to be run on the Pico-RV tiles, and have it trasnlated to a proper ***.hex*** file. 
You can either name it hello.c (default name for make) or any other filename.c of your choice. In this case you should run ***make SRC_FNAME=filename*** to create a filename32.hex

This folder includes some example .c files to help you into building your own. 
* pico\_ld\_st\_cacheline.c : This file executes a series of stores and then loads to the DDR memory. In this case the accesses stride cache lines to create many cache misses. 
* pico\_ld\_st\_mput\_mget  : This file includes both load/store and mPut/mGet commands.

To have a hex file, **hello32.hex**, the better way would be to have your own hello.c and run **make**
