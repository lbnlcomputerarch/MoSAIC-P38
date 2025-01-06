////////////////////////////////////////////////
// Author      : Patricia, Kylie
// Date        : 2024
// Description : ASA accelerator
// File        : Tile_asa.sv
////////////////////////////////////////////////

`timescale 1 ps / 1 ps

module Tile_asa#(
   parameter BW                = 32,
   parameter BWB               = BW/8,
   parameter BW_AXI            = 32,
   parameter BWB_AXI           = BW_AXI/8,
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
	(* dont_touch = "true" *) input  logic   [BW_AXI-1:0] control_S_AXI_WDATA,
	(* dont_touch = "true" *) input  logic  [BWB_AXI-1:0] control_S_AXI_WSTRB,
	(* dont_touch = "true" *) input  logic                control_S_AXI_WVALID,
	(* dont_touch = "true" *) output logic                control_S_AXI_WREADY,
	(* dont_touch = "true" *) input  logic                control_S_AXI_BREADY,
	(* dont_touch = "true" *) output logic          [1:0] control_S_AXI_BRESP,
	(* dont_touch = "true" *) output logic                control_S_AXI_BVALID,
	(* dont_touch = "true" *) input  logic [AXI_ADDR-1:0] control_S_AXI_ARADDR,
	(* dont_touch = "true" *) input  logic                control_S_AXI_ARVALID,
	(* dont_touch = "true" *) output logic                control_S_AXI_ARREADY,
	(* dont_touch = "true" *) input  logic                control_S_AXI_RREADY,
	(* dont_touch = "true" *) output logic   [BW_AXI-1:0] control_S_AXI_RDATA,
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
wire [BW_AXI-1:0] mem_wdata_axi;
wire [BW_AXI-1:0] mem_rdata_axi;

//- Registers
logic        [7:0] rvControl;
logic [BW_AXI-1:0] tile_coordinates_line;
logic [BW_AXI-1:0] tile_coordinates_ctrl;
logic  [XY_SZ-1:0] myX_line;
logic  [XY_SZ-1:0] myY_line;
logic  [XY_SZ-1:0] myX_ctrl;
logic  [XY_SZ-1:0] myY_ctrl;

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
   .clk_control          (clk_control),
   .clk_line             (clk_line),
   .clk_control_rst_low  (clk_control_rst_low),
   .clk_control_rst_high (clk_control_rst_high),
   .clk_line_rst_low     (clk_line_rst_low),
   .clk_line_rst_high    (clk_line_rst_high),
   //- Output Interface: Switch reading from memory manager
	.stream_out_TREADY    (stream_in_local_in_TREADY),
	.stream_out_TVALID    (stream_in_local_in_TVALID),
	.stream_out_TLAST     (stream_in_local_in_TLAST),
  //- AXI bus
	.control_S_AXI_AWADDR 	(control_S_AXI_AWADDR),
	.control_S_AXI_AWVALID	(control_S_AXI_AWVALID),
	.control_S_AXI_AWREADY	(control_S_AXI_AWREADY),
	.control_S_AXI_WDATA  	(control_S_AXI_WDATA),
	.control_S_AXI_WSTRB 	(control_S_AXI_WSTRB),
	.control_S_AXI_WVALID	(control_S_AXI_WVALID),
	.control_S_AXI_WREADY	(control_S_AXI_WREADY),
	.control_S_AXI_BRESP 	(control_S_AXI_BRESP),
	.control_S_AXI_BVALID	(control_S_AXI_BVALID),
	.control_S_AXI_BREADY	(control_S_AXI_BREADY),
	.control_S_AXI_ARADDR	(control_S_AXI_ARADDR),
	.control_S_AXI_ARVALID	(control_S_AXI_ARVALID),
	.control_S_AXI_ARREADY	(control_S_AXI_ARREADY),
	.control_S_AXI_RDATA 	(control_S_AXI_RDATA),
	.control_S_AXI_RRESP 	(control_S_AXI_RRESP),
	.control_S_AXI_RVALID	(control_S_AXI_RVALID),
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

acc_asa#(
   .BW        (BW),
   .OFFSET_SZ (12),
   .XY_SZ     (XY_SZ),
   .NOC_BUFFER_ADDR_W (NOC_BUFFER_ADDR_W)
) acc_asa (
   //- Clock and reset
   .clk_ctrl          (clk_control),
   .clk_line          (clk_line),
   .clk_ctrl_rst_low  (clk_control_rst_low),
   .clk_ctrl_rst_high (clk_control_rst_high),
   .clk_line_rst_low  (clk_line_rst_low),
   .clk_line_rst_high (clk_line_rst_high),
   //- Tile identification
   .HsrcId            ({myY_ctrl,myX_ctrl}),
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
	.stream_out_TLAST  (stream_in_local_in_TLAST)
);


///////////////////////////////////
// Switch
///////////////////////////////////

tile_noc#(
   .BW (BW)
) tile_noc (
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
	.stream_out_local_out_TDATA  (stream_out_local_out_TDATA),
	.stream_out_local_out_TKEEP  (stream_out_local_out_TKEEP),
	.stream_out_local_out_TLAST  (stream_out_local_out_TLAST),
	.stream_in_local_in_TVALID	  (stream_in_local_in_TVALID),
	.stream_in_local_in_TREADY	  (stream_in_local_in_TREADY),
	.stream_in_local_in_TDATA	  (stream_in_local_in_TDATA),
	.stream_in_local_in_TKEEP    (stream_in_local_in_TKEEP),
	.stream_in_local_in_TLAST	  (stream_in_local_in_TLAST),
	.clk_line            	     (clk_line),
	.clk_line_rst_high   	     (clk_line_rst_high),
   .clk_line_rst_low            (clk_line_rst_low)
);

endmodule
