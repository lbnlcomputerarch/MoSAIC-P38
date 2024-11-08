# Modified from CVA6 Chipyard Wrapper: https://github.com/ucb-bar/cva6-wrapper/blob/a2584610225ab296c4fb77a66f70eec64908efd0/src/main/resources/cva6/vsrc/Makefile
#########################################################################################
# pre-process MoSAIC into a single blackbox file
#########################################################################################
base_dir=$(abspath ../../../../../..)
vsrc_dir=$(abspath .)
mosaic_dir=$(base_dir)/src
mosaic_build_dir=$(base_dir)/build
mosaic_icarus_dir=$(base_dir)/icarus
mosaic_tb_dir=$(mosaic_dir)/Testbench
models_dir=$(base_dir)/models
perl_script_dir=$(base_dir)/tools/generate

# name of output pre-processed verilog file
PREPROC_VERILOG = $(vsrc_dir)/mosaic.preprocessed.sv
MOSAIC_PERL_INCUDE=-I$(perl_script_dir)

.PHONY: default build $(PREPROC_VERILOG)
default: build $(PREPROC_VERILOG)

build: $(perl_script_dir)/$(MOSAIC_PERL_SCRIPT).pl
	cd $(perl_script_dir) && \
	perl ./$(MOSAIC_PERL_SCRIPT).pl

#########################################################################################
# pre-process using verilator
#########################################################################################

EXTRA_PREPROC_DEFINES ?=
PREPROC_DEFINES ?= \
	FIRESIM \
	$(EXTRA_PREPROC_DEFINES)

PREPROC_SCRIPT = $(vsrc_dir)/insert-includes.py

$(PREPROC_VERILOG): build $(ALL_VSRCS)
	mkdir -p $(dir $(PREPROC_VERILOG))
	$(foreach def,$(PREPROC_DEFINES),echo "\`define $(def)" >> def.v; )
	$(foreach def,$(PREPROC_DEFINES),echo "\`undef $(def)" >> undef.v; )
	cat def.v $(ALL_VSRCS) undef.v > combined.sv
	$(PREPROC_SCRIPT) combined.sv $@ $(mosaic_build_dir)
	rm -rf combined.sv def.v undef.v *.bak

clean:
	rm -rf $(PREPROC_VERILOG)
	rm -rf $(mosaic_icarus_dir)/file_list.txt
	-cd $(perl_script_dir) && ./clean_up.sh
