////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : May 3 2023
// Description : PICORV32 Tile 
// File        : Tile_template.sv
////////////////////////////////////////////////

`timescale 1 ps / 1 ps

  parameter BW  = 32,
  parameter BWB = BW/8,
  parameter AXI_ADDR = 8
)(
	input logic clk_control,
	input logic clk_line,
	input logic clk_line_rst_high,
	input logic clk_line_rst_low,   
	input logic clk_control_rst_low,
	input logic clk_control_rst_high,
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

localparam              XY_SZ = 3;

//- Switch LOCAL
logic           stream_out_local_out_TVALID;
logic           stream_out_local_out_TLAST;
logic  [BW-1:0] stream_out_local_out_TDATA;
logic [BWB-1:0] stream_out_local_out_TKEEP;
logic           stream_out_local_out_TREADY;

(*mark_debug = "true" *) logic           stream_in_local_in_TVALID;
(*mark_debug = "true" *) logic           stream_in_local_in_TLAST;
(*mark_debug = "true" *) logic  [BW-1:0] stream_in_local_in_TDATA;
(*mark_debug = "true" *) logic [BWB-1:0] stream_in_local_in_TKEEP;
(*mark_debug = "true" *) logic           stream_in_local_in_TREADY;

//- Between AXI and memory manager
logic mem_valid_axi;
logic mem_wstrb_axi; 
logic [BW-1:0] mem_addr_axi;  
logic [BW-1:0] mem_wdata_axi;
logic [BW-1:0] mem_rdata_axi; 

//- Registers
logic   [7:0] rvControl;
logic [BW-1:0] tile_coordinates_line;
logic [BW-1:0] tile_coordinates_ctrl;
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

<INSERT ACCELERATOR HERE>

/*
* EXAMPLE OF ACCELERATOR INSTANTIATION

acc_generic acc_generic (
   /////////////////////
   //- Clocks and resets
   /////////////////////
   .clk_ctrl         (clk_control),  //Input (logic clock)
   .clk_line         (clk_line),     //Input (NoC clock, fast)
   .clk_ctrl_rst_low (clk_control_rst_low), 
   .clk_line_rst_low (clk_line_rst_low),
   /////////////////////
   //- NOC Interface
   /////////////////////
   //- Input Interface: Switch writing to the accelerator 
	.stream_in_TVALID  (stream_out_local_out_TVALID), //- Input
	.stream_in_TDATA   (stream_out_local_out_TDATA),  //- Input
	.stream_in_TKEEP   (stream_out_local_out_TKEEP),  //- Input
	.stream_in_TLAST   (stream_out_local_out_TLAST),  //- Input
	.stream_in_TREADY  (stream_out_local_out_TREADY), //- Output  
   //- Output Interface: Switch reading from the accelerator
	.stream_out_TREADY (stream_in_local_in_TREADY),   //-Input
	.stream_out_TVALID (stream_in_local_in_TVALID),   //- Output
	.stream_out_TDATA  (stream_in_local_in_TDATA),    //- Output
	.stream_out_TKEEP  (stream_in_local_in_TKEEP),    //- Output
	.stream_out_TLAST  (stream_in_local_in_TLAST),    //- Output
   /////////////////////
   //- AXI functionality
   /////////////////////
  //- AXI registers 
   .HsrcId           ({myY,myX}),                   //- Input
   .rvControl        (rvControl),                   //- Input
  //- AXI memory interface
  .mem_valid_axi     (mem_valid_axi),               
	.mem_addr_axi      (mem_addr_axi),
	.mem_wdata_axi     (mem_wdata_axi), 
	.mem_wstrb_axi     (mem_wstrb_axi), 
	.mem_rdata_axi     (mem_rdata_axi));
*/


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

