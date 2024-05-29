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
// Author      : Mario Vega
// Date        : Jan 2024
// Description : 
// File        : Tile_t.sv
////////////////////////////////////////////////

`timescale 1 ps / 1 ps

module Tile_t#(
   parameter TYPE              = "ADDER",
   parameter BW                = 32,
   parameter BWB               = BW/8,
   parameter AXI_ADDR          =  8,
   parameter OFFSET_SZ         = 12,
   parameter XY_SZ             =  3,
   parameter NOC_BUFFER_ADDR_W =  8
)(
   input  logic clk_control,
	input  logic clk_line,
	input  logic clk_line_rst_high,
	input  logic clk_line_rst_low,   
	input  logic clk_control_rst_low,
	input  logic clk_control_rst_high,
   input  logic       [3:0] stream_in_TVALID,
   input  logic  [4*BW-1:0] stream_in_TDATA,
   input  logic [4*BWB-1:0] stream_in_TKEEP,
   input  logic       [3:0] stream_in_TLAST,
   output logic       [3:0] stream_in_TREADY,
   input  logic       [3:0] stream_out_TREADY,
   output logic       [3:0] stream_out_TVALID,
   output logic  [4*BW-1:0] stream_out_TDATA,
   output logic [4*BWB-1:0] stream_out_TKEEP,
   output logic       [3:0] stream_out_TLAST,
	input  logic plain_start_of_processing,
	(* dont_touch = "true" *) input  logic [AXI_ADDR-1:0] control_S_AXI_AWADDR,
	(* dont_touch = "true" *) input  logic                control_S_AXI_AWVALID,
	(* dont_touch = "true" *) output logic                control_S_AXI_AWREADY,
	(* dont_touch = "true" *) input  logic       [BW-1:0] control_S_AXI_WDATA,
	(* dont_touch = "true" *) input  logic      [BWB-1:0] control_S_AXI_WSTRB,
	(* dont_touch = "true" *) input  logic                control_S_AXI_WVALID,
	(* dont_touch = "true" *) output logic                control_S_AXI_WREADY,
	(* dont_touch = "true" *) input  logic                control_S_AXI_BREADY,
	(* dont_touch = "true" *) output logic          [1:0] control_S_AXI_BRESP,
	(* dont_touch = "true" *) output logic                control_S_AXI_BVALID,
	(* dont_touch = "true" *) input  logic [AXI_ADDR-1:0] control_S_AXI_ARADDR,
	(* dont_touch = "true" *) input  logic                control_S_AXI_ARVALID,
	(* dont_touch = "true" *) output logic                control_S_AXI_ARREADY,
	(* dont_touch = "true" *) input  logic                control_S_AXI_RREADY,
	(* dont_touch = "true" *) output logic       [BW-1:0] control_S_AXI_RDATA,
	(* dont_touch = "true" *) output logic          [1:0] control_S_AXI_RRESP,
	(* dont_touch = "true" *) output logic                control_S_AXI_RVALID
);

//- Switch LOCAL
logic           stream_out_local_out_TVALID;
logic           stream_out_local_out_TLAST;
logic  [BW-1:0] stream_out_local_out_TDATA;
logic [BWB-1:0] stream_out_local_out_TKEEP;
logic           stream_out_local_out_TREADY;

logic           stream_in_local_in_TVALID;
logic           stream_in_local_in_TLAST;
logic  [BW-1:0] stream_in_local_in_TDATA;
logic [BWB-1:0] stream_in_local_in_TKEEP;
logic           stream_in_local_in_TREADY;

//- Between AXI and memory manager
wire mem_valid_axi;
wire mem_wstrb_axi; 
wire [BW-1:0] mem_addr_axi;  
wire [BW-1:0] mem_wdata_axi;
wire [BW-1:0] mem_rdata_axi; 

//- Registers
logic       [7:0] rvControl;
logic    [BW-1:0] tile_coordinates_line;
logic    [BW-1:0] tile_coordinates_ctrl;
logic [XY_SZ-1:0] myX_line;
logic [XY_SZ-1:0] myY_line;
logic [XY_SZ-1:0] myX_ctrl;
logic [XY_SZ-1:0] myY_ctrl;

///////////////////////////////////
// AXI
///////////////////////////////////

assign myX_line = tile_coordinates_line[XY_SZ-1:0];
assign myY_line = tile_coordinates_line[(2*XY_SZ)-1:XY_SZ];
assign myX_ctrl = tile_coordinates_ctrl[XY_SZ-1:0];
assign myY_ctrl = tile_coordinates_ctrl[(2*XY_SZ)-1:XY_SZ];

axi_control#(
  .AXI_ADDR (AXI_ADDR)
) axi_control_inst (
   //- Clock and reset
   .clk_control         (clk_control),
   .clk_line         (clk_line),
   .clk_control_rst_low (clk_control_rst_low), 
   .clk_control_rst_high (clk_control_rst_high), 
   .clk_line_rst_low (clk_line_rst_low),
   .clk_line_rst_high (clk_line_rst_high),
   //- Output Interface: Switch reading from memory manager
	.stream_out_TREADY (stream_in_local_in_TREADY),
	.stream_out_TVALID (stream_in_local_in_TVALID),
	.stream_out_TLAST  (stream_in_local_in_TLAST),
  //- AXI bus
	.control_S_AXI_AWADDR 	(control_S_AXI_AWADDR), 
	.control_S_AXI_AWVALID	(control_S_AXI_AWVALID),
	.control_S_AXI_AWREADY	(control_S_AXI_AWREADY),
	.control_S_AXI_WDATA  	(control_S_AXI_WDATA),
	.control_S_AXI_WSTRB 	  (control_S_AXI_WSTRB),
	.control_S_AXI_WVALID	  (control_S_AXI_WVALID),
	.control_S_AXI_WREADY	  (control_S_AXI_WREADY),
	.control_S_AXI_BRESP 	  (control_S_AXI_BRESP),
	.control_S_AXI_BVALID	  (control_S_AXI_BVALID),
	.control_S_AXI_BREADY	  (control_S_AXI_BREADY),
	.control_S_AXI_ARADDR	  (control_S_AXI_ARADDR),
	.control_S_AXI_ARVALID	(control_S_AXI_ARVALID),
	.control_S_AXI_ARREADY	(control_S_AXI_ARREADY),
	.control_S_AXI_RDATA 	  (control_S_AXI_RDATA),
	.control_S_AXI_RRESP 	  (control_S_AXI_RRESP),
	.control_S_AXI_RVALID	  (control_S_AXI_RVALID),
	.control_S_AXI_RREADY 	(control_S_AXI_RREADY),
   //- AXI memory interface
   .mem_valid_axi     (mem_valid_axi),
	.mem_addr_axi      (mem_addr_axi),
	.mem_wdata_axi     (mem_wdata_axi), 
	.mem_wstrb_axi     (mem_wstrb_axi), 
	.mem_rdata_axi     (mem_rdata_axi),
   .rvControl         (rvControl),
   .tile_coordinates_line (tile_coordinates_line),
   .tile_coordinates_ctrl (tile_coordinates_ctrl));


///////////////////////////////////
// Accelerator Begin
///////////////////////////////////

acc_tsqr#(
   .OFFSET_SZ (12),
   .XY_SZ     (XY_SZ),
   .TYPE      (TYPE),
   .NOC_BUFFER_ADDR_W (NOC_BUFFER_ADDR_W)
) acc_tsqr (
   //- Clock and reset
   .clk_ctrl          (clk_control),
   .clk_line          (clk_line),
   .clk_ctrl_rst_low  (clk_control_rst_low), 
   .clk_ctrl_rst_high (clk_control_rst_high), 
   .clk_line_rst_low  (clk_line_rst_low),
   .clk_line_rst_high (clk_line_rst_high),
   //- Tile identification
   .HsrcId            ({myY_ctrl,myX_ctrl}),
   .rvControl         (rvControl),
   //- NOC interface
   //- Input Interface: Switch writing to the memory manager 
	.stream_in_TVALID  (stream_out_local_out_TVALID),
	.stream_in_TDATA   (stream_out_local_out_TDATA),
	.stream_in_TKEEP   (stream_out_local_out_TKEEP), 
	.stream_in_TLAST   (stream_out_local_out_TLAST),
	.stream_in_TREADY  (stream_out_local_out_TREADY),  
   //- Output Interface: Switch reading from memory manager
	.stream_out_TREADY (stream_in_local_in_TREADY),
	.stream_out_TVALID (stream_in_local_in_TVALID),
	.stream_out_TDATA  (stream_in_local_in_TDATA),
	.stream_out_TKEEP  (stream_in_local_in_TKEEP),
	.stream_out_TLAST  (stream_in_local_in_TLAST),
   //- AXI memory interface
   .mem_valid_axi     (mem_valid_axi),
	.mem_addr_axi      (mem_addr_axi),
	.mem_wdata_axi     (mem_wdata_axi), 
	.mem_wstrb_axi     (mem_wstrb_axi), 
	.mem_rdata_axi     (mem_rdata_axi));


///////////////////////////////////
// Switch
///////////////////////////////////

tile_noc tile_noc (
  .HsrcId                      ({myY_line,myX_line}), 
  .stream_in_TVALID            (stream_in_TVALID),
  .stream_in_TREADY            (stream_in_TREADY),
  .stream_in_TDATA             (stream_in_TDATA),
  .stream_in_TKEEP             (stream_in_TKEEP),
  .stream_in_TLAST             (stream_in_TLAST),
  .stream_out_TVALID           (stream_out_TVALID),
  .stream_out_TREADY           (stream_out_TREADY),
  .stream_out_TDATA            (stream_out_TDATA),
  .stream_out_TKEEP            (stream_out_TKEEP),
  .stream_out_TLAST            (stream_out_TLAST),
	.stream_out_local_out_TVALID (stream_out_local_out_TVALID),
	.stream_out_local_out_TREADY (stream_out_local_out_TREADY),
	.stream_out_local_out_TDATA	 (stream_out_local_out_TDATA),
	.stream_out_local_out_TKEEP	 (stream_out_local_out_TKEEP),
	.stream_out_local_out_TLAST	 (stream_out_local_out_TLAST),
	.stream_in_local_in_TVALID	 (stream_in_local_in_TVALID),
	.stream_in_local_in_TREADY	 (stream_in_local_in_TREADY),
	.stream_in_local_in_TDATA	   (stream_in_local_in_TDATA),
	.stream_in_local_in_TKEEP  	 (stream_in_local_in_TKEEP),
	.stream_in_local_in_TLAST	   (stream_in_local_in_TLAST),
	.clk_line            	       (clk_line ),
	.clk_line_rst_high   	       (clk_line_rst_high ),
  .clk_line_rst_low            (clk_line_rst_low)
);

endmodule

