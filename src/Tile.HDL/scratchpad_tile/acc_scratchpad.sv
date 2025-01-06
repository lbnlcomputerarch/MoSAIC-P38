// *************************************************************************
// 
// *** Copyright Notice ***
//
// P38 heterogeneous multi-tiled system with support for message queues 
// (MoSAIC) Copyright (c) 2024, The Regents of the University of California, 
// through Lawrence Berkeley National Laboratory (subject to receipt of
// any required approvals from the U.S. Dept. of Energy). All rights reserved.
// 
// If you have questions about your rights to use or distribute this software,
// please contact Berkeley Lab's Intellectual Property Office at
// IPO@lbl.gov.
//
// NOTICE.  This Software was developed under funding from the U.S. Department
// of Energy and the U.S. Government consequently retains certain rights.  As
// such, the U.S. Government has been granted for itself and others acting on
// its behalf a paid-up, nonexclusive, irrevocable, worldwide license in the
// Software to reproduce, distribute copies to the public, prepare derivative 
// works, and perform publicly and display publicly, and to permit others 
// to do so.
//
// *************************************************************************

////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : Sept 29 2022
// Description : Accelerator with scratchpad
// File        : acc_scratchpad.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module acc_scratchpad#(
   parameter OFFSET_SZ         = 12,
   parameter XY_SZ             =  3,
   parameter BW                = 32,
   parameter BWB               = BW/8,
   parameter NOC_BUFFER_ADDR_W =  8
)(
  //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_line,
   input  logic       clk_ctrl_rst_low,
   input  logic       clk_line_rst_low,
   input  logic       clk_ctrl_rst_high,
   input  logic       clk_line_rst_high,
   input  logic [(XY_SZ*2)-1:0] HsrcId,     //- Tile identification
   
   //---NOC interface---//
   //- Input Interface
   input  logic           stream_in_TVALID,
   input  logic  [BW-1:0] stream_in_TDATA,
   input  logic [BWB-1:0] stream_in_TKEEP, 
   input  logic           stream_in_TLAST,
   output logic           stream_in_TREADY,  
   //- Output Interface
   input  logic           stream_out_TREADY,
   output logic           stream_out_TVALID,
   output logic  [BW-1:0] stream_out_TDATA,
   output logic [BWB-1:0] stream_out_TKEEP,
   output logic           stream_out_TLAST,
  //- AXI memory interface 
   input  logic        mem_valid_axi,
   input  logic [31:0] mem_addr_axi,
   input  logic [31:0] mem_wdata_axi, 
   input  logic        mem_wstrb_axi, 
   output logic [31:0] mem_rdata_axi,
   input  logic  [7:0] rvControl
);

logic           stream_in_TVALID_int;
logic  [BW-1:0] stream_in_TDATA_int;
logic [BWB-1:0] stream_in_TKEEP_int; 
logic           stream_in_TLAST_int;
logic           stream_in_TREADY_int; 


//- Memory and Memory Manager
(*mark_debug = "true" *) logic [BW-1:0] mm_mem_rdata;
(*mark_debug = "true" *) logic [BW-1:0] mm_mem_wdata;
(*mark_debug = "true" *) logic [31:0] mm_mem_addr;
(*mark_debug = "true" *) logic          mm_mem_wstrb; 
(*mark_debug = "true" *) logic          mm_mem_valid;

logic           stream_out_TVALID_int;
logic  [BW-1:0] stream_out_TDATA_int;
logic [BWB-1:0] stream_out_TKEEP_int; 
logic           stream_out_TLAST_int;
logic           stream_out_TREADY_int;

logic rvRstN;

assign rvRstN = rvControl[0]; //1'b0;

noc_buffer_in#(
   .BW (BW),
   .ADDR_W (NOC_BUFFER_ADDR_W)
) noc_buffer(
   .clk_in            (clk_line),
   .clk_in_rst_high   (clk_line_rst_high),
   .clk_in_rst_low    (clk_line_rst_low),
   .clk_out           (clk_ctrl),
   .clk_out_rst_low   (clk_ctrl_rst_low),
   .stream_in_TVALID  (stream_in_TVALID),
   .stream_in_TDATA   (stream_in_TDATA),
   .stream_in_TKEEP   (stream_in_TKEEP),
   .stream_in_TLAST   (stream_in_TLAST),
   .stream_in_TREADY  (stream_in_TREADY),
   .stream_out_TVALID (stream_in_TVALID_int),
   .stream_out_TDATA  (stream_in_TDATA_int),
   .stream_out_TKEEP  (stream_in_TKEEP_int),
   .stream_out_TLAST  (stream_in_TLAST_int),
   .stream_out_TREADY (stream_in_TREADY_int)
);

noc_decoder#(
   .BW (BW)
) noc_decoder(
   //- Clock and reset
   .clk_ctrl         (clk_ctrl),
   //.clk_ctrl_rst_low (clk_ctrl_rst_low && rvRstN), 
   .clk_ctrl_rst_low (clk_ctrl_rst_low), 
   .clk_line         (clk_line),
   .clk_line_rst_low (clk_line_rst_low), 
   //- Tile identification
   .HsrcId           (HsrcId),
   //- NOC interface
   //- Input Interface: Switch writing to the memory manager 
   .stream_in_TVALID  (stream_in_TVALID_int),
   .stream_in_TDATA   (stream_in_TDATA_int),
   .stream_in_TKEEP   (stream_in_TKEEP_int), 
   .stream_in_TLAST   (stream_in_TLAST_int),
   .stream_in_TREADY  (stream_in_TREADY_int),
   //- Output Interface: Switch reading from memory manager
   .stream_out_TREADY (stream_out_TREADY_int),
   .stream_out_TVALID (stream_out_TVALID_int),
   .stream_out_TDATA  (stream_out_TDATA_int),
   .stream_out_TKEEP  (stream_out_TKEEP_int),
   .stream_out_TLAST  (stream_out_TLAST_int),
   .unblock           (),
   .spy_idle          (1'b1),
   .pcpi_idle         (1'b1),
   .fifo_0A_en        (),
   .fifo_0A_addr      (),
   .mem_rdata_a       (mm_mem_rdata),
   .mem_addr_a        (mm_mem_addr),
   .mem_wdata_a       (mm_mem_wdata),
   .mem_wstrb_a       (mm_mem_wstrb),
   .mem_valid_a       (mm_mem_valid),
   .mem_rdata_rv      ()
);


//////////////////////////////
// Scratchpad Memory
//////////////////////////////

logic [31:0] mm_mem_addr_short;
assign mm_mem_addr_short = {20'h0,mm_mem_addr[OFFSET_SZ-1:0]};
logic [BW-32-1:0] filler;
assign filler = 'h0;
logic [BW-1:0] mem_rdata_axi_t;
assign mem_rdata_axi = mem_rdata_axi_t[31:0];
DPRAM #(
  .ADDR_W     (32),
  .DATA_W     (BW),
  .MEMSIZE_KB (16)
) dp_ram (
  .clk   ({clk_ctrl,         clk_ctrl}),
  .rst_n ({clk_ctrl_rst_low, clk_ctrl_rst_low}),
  .en    ({mem_valid_axi, mm_mem_valid }),
  .we    ({mem_wstrb_axi, mm_mem_wstrb}),
  .addr  ({mem_addr_axi,  mm_mem_addr_short}),  
  .din   ({{filler,mem_wdata_axi}, mm_mem_wdata}),
  .dout  ({mm_mem_rdata, mem_rdata_axi_t}));   //- LPGG FIXME: Does the order depend on the simulator?

//////////////////////////////
// Buffer NoC data
//////////////////////////////

noc_buffer_out#(
   .BW (BW),
   .ADDR_W (NOC_BUFFER_ADDR_W)
) noc_buffer_out(
   .clk_in            (clk_ctrl),
   .clk_in_rst_low    (clk_ctrl_rst_low),
   .clk_in_rst_high   (clk_ctrl_rst_high),
   .clk_out           (clk_line),
   .clk_out_rst_low   (clk_line_rst_low),
   .stream_in_TVALID  (stream_out_TVALID_int),
   .stream_in_TDATA   (stream_out_TDATA_int),
   .stream_in_TKEEP   (stream_out_TKEEP_int),
   .stream_in_TLAST   (stream_out_TLAST_int),
   .stream_in_TREADY  (stream_out_TREADY_int),
   .stream_out_TVALID (stream_out_TVALID),
   .stream_out_TDATA  (stream_out_TDATA),
   .stream_out_TKEEP  (stream_out_TKEEP),
   .stream_out_TLAST  (stream_out_TLAST),
   .stream_out_TREADY (stream_out_TREADY)
);


endmodule

