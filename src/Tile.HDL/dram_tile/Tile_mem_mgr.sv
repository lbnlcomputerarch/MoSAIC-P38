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

///////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : April 19 2023
// Description : Memory manager
// File        : Tile_mem_mgr.sv
// Notes       :
//    - Modified to resemble the new structure for
//      the 4x4 mosaic
////////////////////////////////////////////////////

`timescale 1 ps / 1 ps
`include "global_defines.sv"
module Tile_mem_mgr#(
   parameter COL          = 4,
   parameter S_AXI_ID_SZ  = 11,
   parameter S_AXI_ADR_SZ = 34, // ADDRESS
   parameter S_AXI_LEN_SZ = 8,  // LENGTH
   parameter S_AXI_SZE_SZ = 3,  // SIZE
   parameter S_AXI_BRT_SZ = 2,  // BURST
   parameter S_AXI_DAT_SZ = 512,// DATA
   parameter S_AXI_STB_SZ = 64, // STROBE
   parameter S_AXI_RSP_SZ = 2,  // RESPONSE
   parameter S_AXI_CAC_SZ = 4,  // RESPONSE
   parameter S_AXI_PRT_SZ = 3,  // RESPONSE
   parameter S_AXI_QOS_SZ = 4,  // RESPONSE  
   parameter BW           = 32,
   parameter BWB          = BW/8,
   parameter BW_AXI       = 32,
   parameter BWB_AXI      = BW_AXI/8,
   parameter AXI_ADDR     = 8
) (
   input  logic       clk_line,     //- 250 MHz
   input  logic       clk_line_rst_high,
   input  logic       clk_line_rst_low,   
   input  logic       clk_control,  //- 125 MHz
   input  logic       clk_control_rst_low,
   input  logic       clk_control_rst_high,
   input  logic       clk_memory,    //- 300 MHz ?
   input  logic       clk_memory_rst_low, 
   input  logic       clk_memory_rst_high, 
   (*mark_debug = "true" *) input  logic     [COL-1:0] stream_in_TVALID,
   (*mark_debug = "true" *) input  logic  [COL*BW-1:0] stream_in_TDATA,
   (*mark_debug = "true" *) input  logic [COL*BWB-1:0] stream_in_TKEEP,
   (*mark_debug = "true" *) input  logic     [COL-1:0] stream_in_TLAST,
   (*mark_debug = "true" *) output logic     [COL-1:0] stream_in_TREADY,
   (*mark_debug = "true" *) input  logic     [COL-1:0] stream_out_TREADY,
   (*mark_debug = "true" *) output logic     [COL-1:0] stream_out_TVALID,
   (*mark_debug = "true" *) output logic  [COL*BW-1:0] stream_out_TDATA,
   (*mark_debug = "true" *) output logic [COL*BWB-1:0] stream_out_TKEEP,
   (*mark_debug = "true" *) output logic     [COL-1:0] stream_out_TLAST,
   //- AXI BUS
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
   (* dont_touch = "true" *) output logic                control_S_AXI_RVALID, 
  //- MEMORY CONTROLLER
  //- ADDRESS WRITE
  input  logic                    s_axi_awready,
  output logic                    s_axi_awvalid,
  output logic [S_AXI_ID_SZ-1:0]  s_axi_awid,
  output logic [S_AXI_ADR_SZ-1:0] s_axi_awaddr,
  output logic [S_AXI_LEN_SZ-1:0] s_axi_awlen,
  output logic [S_AXI_SZE_SZ-1:0] s_axi_awsize,
  output logic [S_AXI_BRT_SZ-1:0] s_axi_awburst,
  output logic                    s_axi_awlock,
  output logic [S_AXI_CAC_SZ-1:0] s_axi_awcache,
  output logic [S_AXI_PRT_SZ-1:0] s_axi_awprot,
  output logic [S_AXI_QOS_SZ-1:0] s_axi_awqos,
  //- DATA WRITE
  input  logic                    s_axi_wready,
  output logic                    s_axi_wvalid,
  output logic                    s_axi_wlast,
  output logic [S_AXI_DAT_SZ-1:0] s_axi_wdata,
  output logic [S_AXI_STB_SZ-1:0] s_axi_wstrb,
  //- VALID WRITE
  output  logic                  s_axi_bready,
  input logic                    s_axi_bvalid,
  input logic [S_AXI_ID_SZ-1:0]  s_axi_bid,
  input logic [S_AXI_RSP_SZ-1:0] s_axi_bresp,
  //- ADDRESS READ
  input  logic                    s_axi_arready,
  output logic                    s_axi_arvalid,
  output logic [S_AXI_ID_SZ-1:0]  s_axi_arid,
  output logic [S_AXI_ADR_SZ-1:0] s_axi_araddr,
  output logic [S_AXI_LEN_SZ-1:0] s_axi_arlen,
  output logic [S_AXI_SZE_SZ-1:0] s_axi_arsize,
  output logic [S_AXI_BRT_SZ-1:0] s_axi_arburst,
  output logic                    s_axi_arlock,
  output logic [S_AXI_CAC_SZ-1:0] s_axi_arcache,
  output logic [S_AXI_PRT_SZ-1:0] s_axi_arprot,
  output logic [S_AXI_QOS_SZ-1:0] s_axi_arqos,
  //- RESPONSE READ
  output logic                    s_axi_rready,
  input  logic                    s_axi_rvalid,
  input  logic                    s_axi_rlast,
  input  logic [S_AXI_DAT_SZ-1:0] s_axi_rdata,
  input  logic [S_AXI_ID_SZ-1:0]  s_axi_rid,
  input  logic [S_AXI_RSP_SZ-1:0] s_axi_rresp
);

//- Switch LOCAL

localparam              XY_SZ = 3;

logic           stream_out_local_out_TVALID;
logic           stream_out_local_out_TLAST;
logic [BW-1:0]  stream_out_local_out_TDATA;
logic [BWB-1:0] stream_out_local_out_TKEEP;
logic           stream_out_local_out_TREADY;

logic           stream_in_local_in_TVALID;
logic           stream_in_local_in_TLAST;
logic [BW-1:0]  stream_in_local_in_TDATA;
logic [BWB-1:0] stream_in_local_in_TKEEP;
logic           stream_in_local_in_TREADY;

//- Between AXI and memory manager
logic mem_valid_axi;
logic mem_wstrb_axi; 
logic [BW_AXI-1:0] mem_addr_axi;  
logic [BWB_AXI-1:0] mem_wdata_axi;
//logic [31:0] mem_rdata_axi;  //FIXME
logic [S_AXI_ID_SZ-1:0] mem_req_id_axi;

//- Registers
logic   [7:0] rvControl;
logic   [7:0] rvControl_memory;
logic [BW_AXI-1:0] tile_coordinates_line;
logic [BW_AXI-1:0] tile_coordinates_ctrl;
logic [BW_AXI-1:0] tile_coordinates_memory;
logic [XY_SZ-1:0] myX_line;
logic [XY_SZ-1:0] myY_line;
logic [XY_SZ-1:0] myX_memory;
logic [XY_SZ-1:0] myY_memory;

///////////////////////////////////
// AXI
///////////////////////////////////


assign myX_line = tile_coordinates_line[XY_SZ-1:0];
assign myY_line = tile_coordinates_line[(2*XY_SZ)-1:XY_SZ];
assign myX_memory = tile_coordinates_memory[XY_SZ-1:0];
assign myY_memory = tile_coordinates_memory[(2*XY_SZ)-1:XY_SZ];


/*DELETE this 6 lines before GITHUB COMMIT and check line
* 257 remove the temp sufix
logic   [7:0] rvControl_memory_temp;
assign rvControl_memory_temp = 'h1;
assign myX_line   = 'h2; 
assign myY_line   = 'h0;
assign myX_memory = 'h2;
assign myY_memory = 'h0;
*/

/* This block supports clk_control and clk_line, 
*  but do not have clk_memory into account 
*/
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
   .control_S_AXI_AWADDR   (control_S_AXI_AWADDR), 
   .control_S_AXI_AWVALID  (control_S_AXI_AWVALID),
   .control_S_AXI_AWREADY  (control_S_AXI_AWREADY),
   .control_S_AXI_WDATA    (control_S_AXI_WDATA),
   .control_S_AXI_WSTRB    (control_S_AXI_WSTRB),
   .control_S_AXI_WVALID   (control_S_AXI_WVALID),
   .control_S_AXI_WREADY   (control_S_AXI_WREADY),
   .control_S_AXI_BRESP    (control_S_AXI_BRESP),
   .control_S_AXI_BVALID   (control_S_AXI_BVALID),
   .control_S_AXI_BREADY   (control_S_AXI_BREADY),
   .control_S_AXI_ARADDR   (control_S_AXI_ARADDR),
   .control_S_AXI_ARVALID  (control_S_AXI_ARVALID),
   .control_S_AXI_ARREADY  (control_S_AXI_ARREADY),
   .control_S_AXI_RDATA    (control_S_AXI_RDATA),
   .control_S_AXI_RRESP    (control_S_AXI_RRESP),
   .control_S_AXI_RVALID   (control_S_AXI_RVALID),
   .control_S_AXI_RREADY   (control_S_AXI_RREADY),
  //- AXI memory interface
   .mem_valid_axi          (mem_valid_axi),
   .mem_addr_axi           (mem_addr_axi),
   .mem_wdata_axi          (mem_wdata_axi), 
   .mem_wstrb_axi          (mem_wstrb_axi), 
   //.mem_rdata_axi        (mem_rdata_axi),
   .mem_rdata_axi          (32'h0), //-FIXME the results is too fast, how to sample it.
   .rvControl              (rvControl),
   .tile_coordinates_line  (tile_coordinates_line),
   .tile_coordinates_ctrl  (tile_coordinates_ctrl));

///////////////////////////////////
// Accelerator Begin
///////////////////////////////////


xpm_cdc_array_single #(
  .WIDTH(BW_AXI),
  .SIM_ASSERT_CHK(`SIM_ASSERT_CHK)
) tile_coord_cdc (
  // Module ports
  .src_clk  (clk_control),
  .src_in   (tile_coordinates_ctrl),
  .dest_clk (clk_memory),
  .dest_out (tile_coordinates_memory));

xpm_cdc_array_single #(
  .WIDTH(8),
  .SIM_ASSERT_CHK(`SIM_ASSERT_CHK)
) rvControl_cdc (
  // Module ports
  .src_clk  (clk_control),
  .src_in   (rvControl),
  .dest_clk (clk_memory),
  .dest_out (rvControl_memory));

acc_mem_mgr#(
   .OFFSET_SZ (12),
   .XY_SZ     (XY_SZ),
   .S_AXI_ID_SZ (S_AXI_ID_SZ),
   .S_AXI_ADR_SZ (S_AXI_ADR_SZ)
) acc_mem_mgr (
   //- Clock and reset
   .clk_mem           (clk_memory),    //- Logic
   .clk_line          (clk_line),      //- NoC
   .clk_ctrl          (clk_control),   //- AXI bus
   .clk_mem_rst_low   (clk_memory_rst_low), 
   .clk_mem_rst_high  (clk_memory_rst_high), 
   .clk_line_rst_low  (clk_line_rst_low),
   .clk_line_rst_high (clk_line_rst_high),
   .clk_ctrl_rst_high (clk_control_rst_high), 
   //- Tile identification
   .HsrcId            ({myY_memory,myX_memory}),
   //.rvControl         (rvControl_memory_temp),
   .rvControl         (rvControl_memory),
  //- AXI Bus memory interface (From open-nic-shell to be clear, or less clear)
   .mem_valid_axi     (mem_valid_axi),
   .mem_addr_axi      (mem_addr_axi),
   .mem_wdata_axi     (mem_wdata_axi), 
   .mem_wstrb_axi     (mem_wstrb_axi), 
   .mem_rdata_axi     (),
   //.mem_rdata_axi     (mem_rdata_axi),
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
   //- MEMORY CONTROLLER
   //- ADDRESS WRITE
   .s_axi_awready      (s_axi_awready),
   .s_axi_awvalid      (s_axi_awvalid),
   .s_axi_awid         (s_axi_awid),
   .s_axi_awaddr       (s_axi_awaddr),
   .s_axi_awlen        (s_axi_awlen),
   .s_axi_awsize       (s_axi_awsize),
   .s_axi_awburst      (s_axi_awburst),
   .s_axi_awlock       (s_axi_awlock),
   .s_axi_awcache      (s_axi_awcache),
   .s_axi_awprot       (s_axi_awprot),
   .s_axi_awqos        (s_axi_awqos),
  //- DATA WRITE
   .s_axi_wready      (s_axi_wready),
   .s_axi_wvalid      (s_axi_wvalid),
   .s_axi_wlast       (s_axi_wlast),
   .s_axi_wdata       (s_axi_wdata),
   .s_axi_wstrb       (s_axi_wstrb),
  //- VALID WRITE
   .s_axi_bready      (s_axi_bready),
   .s_axi_bvalid      (s_axi_bvalid),
   .s_axi_bid         (s_axi_bid),
   .s_axi_bresp       (s_axi_bresp),
  //- ADDRESS READ
   .s_axi_arready     (s_axi_arready),
   .s_axi_arvalid     (s_axi_arvalid),
   .s_axi_arid        (s_axi_arid),
   .s_axi_araddr      (s_axi_araddr),
   .s_axi_arlen       (s_axi_arlen),
   .s_axi_arsize      (s_axi_arsize),
   .s_axi_arburst     (s_axi_arburst),
   .s_axi_arlock      (s_axi_arlock),
   .s_axi_arcache     (s_axi_arcache),
   .s_axi_arprot      (s_axi_arprot),
   .s_axi_arqos       (s_axi_arqos),
  //- RESPONSE READ
   .s_axi_rready      (s_axi_rready),
   .s_axi_rvalid      (s_axi_rvalid),
   .s_axi_rlast       (s_axi_rlast),
   .s_axi_rdata       (s_axi_rdata),
   .s_axi_rid         (s_axi_rid),
   .s_axi_rresp       (s_axi_rresp));


///////////////////////////////////
// Switch
///////////////////////////////////

logic       [3:0] stream_in_TVALID_l0;
logic  [4*BW-1:0] stream_in_TDATA_l0;
logic [4*BWB-1:0] stream_in_TKEEP_l0;
logic       [3:0] stream_in_TLAST_l0;
logic       [3:0] stream_in_TREADY_l0;
logic       [3:0] stream_out_TREADY_l0;
logic       [3:0] stream_out_TVALID_l0;
logic  [4*BW-1:0] stream_out_TDATA_l0;
logic [4*BWB-1:0] stream_out_TKEEP_l0;
logic       [3:0] stream_out_TLAST_l0;

logic           stream_out_local_out_TVALID_l0;
logic           stream_out_local_out_TLAST_l0;
logic  [BW-1:0] stream_out_local_out_TDATA_l0;
logic [BWB-1:0] stream_out_local_out_TKEEP_l0;
logic           stream_out_local_out_TREADY_l0;

logic           stream_in_local_in_TVALID_l0;
logic           stream_in_local_in_TLAST_l0;
logic  [BW-1:0] stream_in_local_in_TDATA_l0;
logic [BWB-1:0] stream_in_local_in_TKEEP_l0;
logic           stream_in_local_in_TREADY_l0;

if (COL<=4) begin
   assign stream_in_TVALID_l0 = {{(4-COL){1'b0}},stream_in_TVALID};
   assign stream_in_TDATA_l0  = {{(4-COL)*BW{1'b0}},stream_in_TDATA};
   assign stream_in_TKEEP_l0  = {{(4-COL)*BWB{1'b0}},stream_in_TKEEP};
   assign stream_in_TLAST_l0  = {{(4-COL){1'b0}},stream_in_TLAST};
   assign stream_in_TREADY    = stream_in_TREADY_l0[COL-1:0];

   assign stream_out_TVALID = stream_out_TVALID_l0;
   assign stream_out_TDATA  = stream_out_TDATA_l0;
   assign stream_out_TKEEP  = stream_out_TKEEP_l0;
   assign stream_out_TLAST  = stream_out_TLAST_l0;
   assign stream_out_TREADY_l0 = {{(4-COL){1'b0}},stream_out_TREADY};

   assign stream_in_local_in_TVALID_l0 =  stream_in_local_in_TVALID;
   assign stream_in_local_in_TDATA_l0  =  stream_in_local_in_TDATA;
   assign stream_in_local_in_TKEEP_l0  =  stream_in_local_in_TKEEP;
   assign stream_in_local_in_TLAST_l0  =  stream_in_local_in_TLAST;
   assign stream_in_local_in_TREADY =  stream_in_local_in_TREADY_l0;

   assign stream_out_local_out_TVALID    =  stream_out_local_out_TVALID_l0;
   assign stream_out_local_out_TDATA     =  stream_out_local_out_TDATA_l0;
   assign stream_out_local_out_TKEEP     =  stream_out_local_out_TKEEP_l0;
   assign stream_out_local_out_TLAST     =  stream_out_local_out_TLAST_l0;
   assign stream_out_local_out_TREADY_l0 =  stream_out_local_out_TREADY;

end else begin

   logic           stream_out_local_out_TVALID_l1;
   logic           stream_out_local_out_TLAST_l1;
   logic  [BW-1:0] stream_out_local_out_TDATA_l1;
   logic [BWB-1:0] stream_out_local_out_TKEEP_l1;
   logic           stream_out_local_out_TREADY_l1;

   logic           stream_in_local_in_TVALID_l1;
   logic           stream_in_local_in_TLAST_l1;
   logic [BW-1:0]  stream_in_local_in_TDATA_l1;
   logic [BWB-1:0] stream_in_local_in_TKEEP_l1;
   logic           stream_in_local_in_TREADY_l1;

   logic       [3:0] stream_in_TVALID_l1;
   logic  [4*BW-1:0] stream_in_TDATA_l1;
   logic [4*BWB-1:0] stream_in_TKEEP_l1;
   logic       [3:0] stream_in_TLAST_l1;
   logic       [3:0] stream_in_TREADY_l1;
   logic       [3:0] stream_out_TREADY_l1;
   logic       [3:0] stream_out_TVALID_l1;
   logic  [4*BW-1:0] stream_out_TDATA_l1;
   logic [4*BWB-1:0] stream_out_TKEEP_l1;
   logic       [3:0] stream_out_TLAST_l1;
 
  //- tile_noc_0 takes the first 4 columns
  assign stream_in_TVALID_l0   = stream_in_TVALID[3:0];
  assign stream_in_TDATA_l0    = stream_in_TDATA[4*BW-1:0];
  assign stream_in_TKEEP_l0    = stream_in_TKEEP[4*BWB-1:0];
  assign stream_in_TLAST_l0    = stream_in_TLAST[3:0];
  assign stream_in_TREADY[3:0] = stream_in_TREADY_l0;

  assign stream_out_TVALID[3:0]      = stream_out_TVALID_l0;
  assign stream_out_TDATA[(4*BW)-1:0]  = stream_out_TDATA_l0;
  assign stream_out_TKEEP[(4*BWB)-1:0] = stream_out_TKEEP_l0;
  assign stream_out_TLAST[3:0]       = stream_out_TLAST_l0;
  assign stream_out_TREADY_l0        = stream_out_TREADY[3:0];

  tile_noc #(
    .BW  (BW),
    .BIG (1),
    .OFFSET(4)
  ) tile_noc_1 (
    .HsrcId                      ({myY_line,myX_line}), 
    .stream_in_TVALID            (stream_in_TVALID_l1),
    .stream_in_TREADY            (stream_in_TREADY_l1),
    .stream_in_TDATA             (stream_in_TDATA_l1),
    .stream_in_TKEEP             (stream_in_TKEEP_l1),
    .stream_in_TLAST             (stream_in_TLAST_l1),
    .stream_out_TVALID           (stream_out_TVALID_l1),
    .stream_out_TREADY           (stream_out_TREADY_l1),
    .stream_out_TDATA            (stream_out_TDATA_l1),
    .stream_out_TKEEP            (stream_out_TKEEP_l1),
    .stream_out_TLAST            (stream_out_TLAST_l1),
    .stream_out_local_out_TVALID (stream_out_local_out_TVALID_l1),
    .stream_out_local_out_TREADY (stream_out_local_out_TREADY_l1),
    .stream_out_local_out_TDATA  (stream_out_local_out_TDATA_l1),
    .stream_out_local_out_TKEEP  (stream_out_local_out_TKEEP_l1),
    .stream_out_local_out_TLAST  (stream_out_local_out_TLAST_l1),
    .stream_in_local_in_TVALID   (stream_in_local_in_TVALID_l1),
    .stream_in_local_in_TREADY   (stream_in_local_in_TREADY_l1),
    .stream_in_local_in_TDATA    (stream_in_local_in_TDATA_l1),
    .stream_in_local_in_TKEEP    (stream_in_local_in_TKEEP_l1),
    .stream_in_local_in_TLAST    (stream_in_local_in_TLAST_l1),
    .clk_line                    (clk_line ),
    .clk_line_rst_high           (clk_line_rst_high),
    .clk_line_rst_low            (clk_line_rst_low));


  if (COL<8) begin

    //- tile_noc_1 takes the remaining columns and the response from tile_noc_0
    assign stream_in_TVALID_l1 = {stream_out_local_out_TVALID_l0,{(7-COL){1'b0}},    stream_in_TVALID[COL-1:4]};
    assign stream_in_TDATA_l1  = {stream_out_local_out_TDATA_l0, {(7-COL)*BW{1'b0}}, stream_in_TDATA[(COL*BW)-1:4*BW]};
    assign stream_in_TKEEP_l1  = {stream_out_local_out_TKEEP_l0, {(7-COL)*BWB{1'b0}},stream_in_TKEEP[(COL*BWB)-1:4*BWB]};
    assign stream_in_TLAST_l1  = {stream_out_local_out_TLAST_l0, {(7-COL){1'b0}},    stream_in_TLAST[COL-1:4]};

    assign stream_in_TREADY[COL-1:4] = stream_in_TREADY_l1[COL-5:0];
    assign stream_out_local_out_TREADY_l0 = stream_in_TREADY_l1[COL-4];

    assign stream_out_TVALID[COL-1:4]    = stream_out_TVALID_l1[COL-4-1:0];
    assign stream_out_TDATA[(COL*BW)-1:4*BW]  = stream_out_TDATA_l1[((COL-4)*BW)-1:0];
    assign stream_out_TKEEP[(COL*BWB)-1:4*BWB] = stream_out_TKEEP_l1[((COL-4)*BWB)-1:0];
    assign stream_out_TLAST[COL-1:4]     = stream_out_TLAST_l1[COL-4-1:0];
  
    assign stream_in_local_in_TVALID_l0 =  stream_out_TVALID_l1[3];
    assign stream_in_local_in_TDATA_l0  =  stream_out_TDATA_l1[(4*BW)-1:3*BW];
    assign stream_in_local_in_TKEEP_l0  =  stream_out_TKEEP_l1[(4*BWB)-1:3*BWB];
    assign stream_in_local_in_TLAST_l0  =  stream_out_TLAST_l1[3];
    
    assign stream_out_TREADY_l1 = {stream_in_local_in_TREADY_l0, {(7-COL){1'b0}}, stream_out_TREADY[COL-1:4]};

    assign stream_in_local_in_TVALID_l1 =  stream_in_local_in_TVALID;
    assign stream_in_local_in_TDATA_l1  =  stream_in_local_in_TDATA;
    assign stream_in_local_in_TKEEP_l1  =  stream_in_local_in_TKEEP;
    assign stream_in_local_in_TLAST_l1  =  stream_in_local_in_TLAST;
    assign stream_in_local_in_TREADY =  stream_in_local_in_TREADY_l1;

    assign stream_out_local_out_TVALID =  stream_out_local_out_TVALID_l1;
    assign stream_out_local_out_TDATA  =  stream_out_local_out_TDATA_l1;
    assign stream_out_local_out_TKEEP  =  stream_out_local_out_TKEEP_l1;
    assign stream_out_local_out_TLAST  =  stream_out_local_out_TLAST_l1;
    assign stream_out_local_out_TREADY_l1 =  stream_out_local_out_TREADY;

  end else if (COL==8) begin

    logic           stream_out_local_out_TVALID_l2;
    logic           stream_out_local_out_TLAST_l2;
    logic [BW-1:0]  stream_out_local_out_TDATA_l2;
    logic [BWB-1:0] stream_out_local_out_TKEEP_l2;
    logic           stream_out_local_out_TREADY_l2;

    logic           stream_in_local_in_TVALID_l2;
    logic           stream_in_local_in_TLAST_l2;
    logic [BW-1:0]  stream_in_local_in_TDATA_l2;
    logic [BWB-1:0] stream_in_local_in_TKEEP_l2;
    logic           stream_in_local_in_TREADY_l2;

    logic     [3:0] stream_in_TVALID_l2;
    logic  [4*BW-1:0] stream_in_TDATA_l2;
    logic [4*BWB-1:0] stream_in_TKEEP_l2;
    logic     [3:0] stream_in_TLAST_l2;
    logic     [3:0] stream_in_TREADY_l2;
    logic     [3:0] stream_out_TREADY_l2;
    logic     [3:0] stream_out_TVALID_l2;
    logic  [4*BW-1:0] stream_out_TDATA_l2;
    logic [4*BWB-1:0] stream_out_TKEEP_l2;
    logic     [3:0] stream_out_TLAST_l2;

    //- tile_noc_1 takes the remaining columns 
    assign stream_in_TVALID_l1 = stream_in_TVALID[COL-1:4];
    assign stream_in_TDATA_l1  = stream_in_TDATA[(COL*BW)-1:4*BW];
    assign stream_in_TKEEP_l1  = stream_in_TKEEP[(COL*BWB)-1:4*BWB];
    assign stream_in_TLAST_l1  = stream_in_TLAST[COL-1:4];
    assign stream_in_TREADY[COL-1:4] = stream_in_TREADY_l1;

    assign stream_out_TVALID[COL-1:4]    = stream_out_TVALID_l1;
    assign stream_out_TDATA[(COL*BW)-1:4*BW]  = stream_out_TDATA_l1;
    assign stream_out_TKEEP[(COL*BWB)-1:4*BWB] = stream_out_TKEEP_l1;
    assign stream_out_TLAST[COL-1:4]     = stream_out_TLAST_l1;
    assign stream_out_TREADY_l1          = stream_out_TREADY[COL-1:4];

    //- tile_noc_2 takes the locals
    assign stream_in_TVALID_l2 = {2'b00,stream_out_local_out_TVALID_l1,stream_out_local_out_TVALID_l0};
    assign stream_in_TDATA_l2  = {{(2*BW){1'b0}},stream_out_local_out_TDATA_l1,stream_out_local_out_TDATA_l0};
    assign stream_in_TKEEP_l2  = {{(2*BWB){1'b0}},stream_out_local_out_TKEEP_l1,stream_out_local_out_TKEEP_l0};
    assign stream_in_TLAST_l2  = {2'b00,stream_out_local_out_TLAST_l1,stream_out_local_out_TLAST_l0};
    assign stream_out_local_out_TREADY_l0 = stream_in_TREADY_l2[0];
    assign stream_out_local_out_TREADY_l1 = stream_in_TREADY_l2[1];

    assign stream_in_local_in_TVALID_l0 =  stream_out_TVALID_l2[0];
    assign stream_in_local_in_TDATA_l0  =  stream_out_TDATA_l2[BW-1:0];
    assign stream_in_local_in_TKEEP_l0  =  stream_out_TKEEP_l2[BWB-1:0];
    assign stream_in_local_in_TLAST_l0  =  stream_out_TLAST_l2[0];
  
    assign stream_in_local_in_TVALID_l1 =  stream_out_TVALID_l2[1];
    assign stream_in_local_in_TDATA_l1  =  stream_out_TDATA_l2[(2*BW)-1:BW];
    assign stream_in_local_in_TKEEP_l1  =  stream_out_TKEEP_l2[(2*BWB)-1:BWB];
    assign stream_in_local_in_TLAST_l1  =  stream_out_TLAST_l2[1];

    assign stream_out_TREADY_l2 = {2'b00,stream_in_local_in_TREADY_l1,stream_in_local_in_TREADY_l0};

    assign stream_in_local_in_TVALID_l2 =  stream_in_local_in_TVALID;
    assign stream_in_local_in_TDATA_l2  =  stream_in_local_in_TDATA;
    assign stream_in_local_in_TKEEP_l2  =  stream_in_local_in_TKEEP;
    assign stream_in_local_in_TLAST_l2  =  stream_in_local_in_TLAST;
    assign stream_in_local_in_TREADY =  stream_in_local_in_TREADY_l2;

    assign stream_out_local_out_TVALID =  stream_out_local_out_TVALID_l2;
    assign stream_out_local_out_TDATA  =  stream_out_local_out_TDATA_l2;
    assign stream_out_local_out_TKEEP  =  stream_out_local_out_TKEEP_l2;
    assign stream_out_local_out_TLAST  =  stream_out_local_out_TLAST_l2;
    assign stream_out_local_out_TREADY_l2 =  stream_out_local_out_TREADY;

   tile_noc #(
      .BW  (BW),
      .BIG (1),
      .LEVEL (1)
   ) tile_noc_2 (
      .HsrcId                      ({myY_line,myX_line}), 
      .stream_in_TVALID            (stream_in_TVALID_l2),
      .stream_in_TREADY            (stream_in_TREADY_l2),
      .stream_in_TDATA             (stream_in_TDATA_l2),
      .stream_in_TKEEP             (stream_in_TKEEP_l2),
      .stream_in_TLAST             (stream_in_TLAST_l2),
      .stream_out_TVALID           (stream_out_TVALID_l2),
      .stream_out_TREADY           (stream_out_TREADY_l2),
      .stream_out_TDATA            (stream_out_TDATA_l2),
      .stream_out_TKEEP            (stream_out_TKEEP_l2),
      .stream_out_TLAST            (stream_out_TLAST_l2),
      .stream_out_local_out_TVALID (stream_out_local_out_TVALID_l2),
      .stream_out_local_out_TREADY (stream_out_local_out_TREADY_l2),
      .stream_out_local_out_TDATA  (stream_out_local_out_TDATA_l2),
      .stream_out_local_out_TKEEP  (stream_out_local_out_TKEEP_l2),
      .stream_out_local_out_TLAST  (stream_out_local_out_TLAST_l2),
      .stream_in_local_in_TVALID   (stream_in_local_in_TVALID_l2),
      .stream_in_local_in_TREADY   (stream_in_local_in_TREADY_l2),
      .stream_in_local_in_TDATA    (stream_in_local_in_TDATA_l2),
      .stream_in_local_in_TKEEP    (stream_in_local_in_TKEEP_l2),
      .stream_in_local_in_TLAST    (stream_in_local_in_TLAST_l2),
      .clk_line                    (clk_line),
      .clk_line_rst_high           (clk_line_rst_high),
      .clk_line_rst_low            (clk_line_rst_low));
  end
end

tile_noc#(
   .BW  (BW),
   .BIG (1)
) tile_noc_0 (
   .HsrcId                       ({myY_line,myX_line}), 
   .stream_in_TVALID             (stream_in_TVALID_l0),
   .stream_in_TREADY             (stream_in_TREADY_l0),
   .stream_in_TDATA              (stream_in_TDATA_l0),
   .stream_in_TKEEP              (stream_in_TKEEP_l0),
   .stream_in_TLAST              (stream_in_TLAST_l0),
   .stream_out_TVALID            (stream_out_TVALID_l0),
   .stream_out_TREADY            (stream_out_TREADY_l0),
   .stream_out_TDATA             (stream_out_TDATA_l0),
   .stream_out_TKEEP             (stream_out_TKEEP_l0),
   .stream_out_TLAST             (stream_out_TLAST_l0),
   .stream_out_local_out_TVALID  (stream_out_local_out_TVALID_l0),
   .stream_out_local_out_TREADY  (stream_out_local_out_TREADY_l0),
   .stream_out_local_out_TDATA   (stream_out_local_out_TDATA_l0),
   .stream_out_local_out_TKEEP   (stream_out_local_out_TKEEP_l0),
   .stream_out_local_out_TLAST   (stream_out_local_out_TLAST_l0),
   .stream_in_local_in_TVALID    (stream_in_local_in_TVALID_l0),
   .stream_in_local_in_TREADY    (stream_in_local_in_TREADY_l0),
   .stream_in_local_in_TDATA     (stream_in_local_in_TDATA_l0),
   .stream_in_local_in_TKEEP     (stream_in_local_in_TKEEP_l0),
   .stream_in_local_in_TLAST     (stream_in_local_in_TLAST_l0),
   .clk_line                     (clk_line ),
   .clk_line_rst_high            (clk_line_rst_high),
   .clk_line_rst_low             (clk_line_rst_low));


endmodule

