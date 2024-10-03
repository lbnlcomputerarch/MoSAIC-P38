# Modified from CVA6 Chipyard Wrapper: https://github.com/ucb-bar/cva6-wrapper/blob/a2584610225ab296c4fb77a66f70eec64908efd0/src/main/resources/cva6/vsrc/Makefile
#########################################################################################
# pre-process MoSAIC into a single blackbox file
#########################################################################################
base_dir=$(abspath ../../../../../..)
vsrc_dir=$(abspath .)
mosaic_dir=$(base_dir)/src
mosaic_build_dir=$(base_dir)/build
mosaic_tb_dir=$(mosaic_dir)/Testbench
models_dir=$(base_dir)/models
perl_script_dir=$(base_dir)/tools/generate

# name of output pre-processed verilog file
PREPROC_VERILOG = $(vsrc_dir)/mosaic.preprocessed.sv
MOSAIC_PERL_INCUDE=-I$(perl_script_dir)

.PHONY: default build $(PREPROC_VERILOG)
default: build $(PREPROC_VERILOG)

#########################################################################################
# includes and vsrcs
#########################################################################################
MODEL_VSRCS = \
	$(models_dir)/xpm_cdc_array_single.v \
	$(models_dir)/xpm_memory_spram.sv \
	$(models_dir)/xpm_fifo_async.sv \
	$(models_dir)/xpm_fifo_sync.sv

MOSAIC_TBS = \
	$(mosaic_tb_dir)/tb_mosaic.sv \
	$(mosaic_tb_dir)/TB_System_Stim.v

MOSAIC_VHS = \
	$(mosaic_build_dir)/include/axi_ux_addr_var.vh \
	$(mosaic_build_dir)/include/axi_ux_resp_var.vh \
	$(mosaic_build_dir)/include/global_defines.sv \
	$(mosaic_build_dir)/include/tiles.vh

MOSAIC_VSRCS = \
	$(mosaic_dir)/Tile.HDL/4x1_local.sv \
	$(mosaic_dir)/Tile.HDL/tile_noc.sv \
	$(mosaic_dir)/Dispatcher.HDL/Dispatcher.sv \
	$(mosaic_dir)/Gatherer.HDL/Gatherer.sv \
	$(mosaic_dir)/S_PROTOCOL_ADAPTERs.HDL/S_PROTOCOL_ADAPTER_INGRESS.sv \
	$(mosaic_dir)/S_PROTOCOL_ADAPTERs.HDL/S_PROTOCOL_ADAPTER_EGRESS.v \
	$(mosaic_dir)/S_CONTROLLERs.HDL/S_CONTROLLER_USS.sv \
	$(mosaic_dir)/S_CONTROLLERs.HDL/axi_ux_addr.sv \
	$(mosaic_dir)/S_CONTROLLERs.HDL/axi_ux_resp.sv \
	$(mosaic_dir)/SOP.HDL/SOP.v \
	$(mosaic_dir)/Common.HDL/Register.v \
	$(mosaic_dir)/Common.HDL/DPRAM.sv \
	$(mosaic_dir)/S_RESETTER.HDL/S_RESETTER_control.v \
	$(mosaic_dir)/S_RESETTER.HDL/S_RESETTER_line.v \
	$(mosaic_dir)/Tile.HDL/fifo_generator_0.sv \
	$(mosaic_dir)/Tile.HDL/RV_AXIInD.v \
	$(mosaic_dir)/Tile.HDL/axi_control.sv \
	$(mosaic_dir)/Tile.HDL/TileRegBlock.v \
	$(mosaic_dir)/Tile.HDL/noc_decoder.sv \
	$(mosaic_dir)/Tile.HDL/noc_buffer_out.sv \
	$(mosaic_dir)/Tile.HDL/noc_buffer_in.sv \
	$(mosaic_dir)/Tile.HDL/picorv32_tile/noc_out_arbiter.sv \
	$(mosaic_dir)/Tile.HDL/picorv32_tile/qISAExtension.sv \
	$(mosaic_dir)/Tile.HDL/picorv32_tile/qISAExtension_pcpi.sv \
	$(mosaic_dir)/Tile.HDL/picorv32_tile/mem_spy.sv \
	$(mosaic_dir)/Tile.HDL/picorv32_tile/picorv32.v \
	$(mosaic_dir)/Tile.HDL/picorv32_tile/acc_picorv32.sv \
	$(mosaic_dir)/Tile.HDL/picorv32_tile/Tile_picorv32.sv \
	$(mosaic_dir)/Tile.HDL/scratchpad_tile/acc_scratchpad.sv \
	$(mosaic_dir)/Tile.HDL/scratchpad_tile/Tile_scratchpad.sv \
	$(mosaic_dir)/Tile.HDL/loop_tile/acc_loop.sv \
	$(mosaic_dir)/Tile.HDL/loop_tile/Tile_loop.sv

MOSAIC_WRAPPER = \
	$(mosaic_dir)/mosaic.sv

ALL_VSRCS = $(MOSAIC_VSRCS) $(MOSAIC_WRAPPER)

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
	sed -i '/l15.tmp.h/d' combined.sv
	sed -i '/define.tmp.h/d' combined.sv
	$(PREPROC_SCRIPT) combined.sv $@ $(mosaic_build_dir)
	rm -rf combined.sv def.v undef.v

clean:
	rm -rf $(PREPROC_VERILOG)
	cd $(perl_script_dir) && ./clean_up.sh
