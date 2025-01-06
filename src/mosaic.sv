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

/////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : April 19 2022
// Description : PICORV32 Tile 
// File        : Tile_picorv32.sv
// Notes       : 
//  - Mosaic supports an heterogeneous array of NxN tiles
//  - FIXME: Current dispatcher/gatherer only has 
//    ports for 4 tiles. Ideally it should 
//    connect to all the tiles on the 
//    left/right.
////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps
`include "global_defines.sv"

module mosaic #(
   `ifdef DDR4_CTRL
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
   `endif
   parameter BW          = `NOC_BW,
   parameter BWB         = BW/8,    //- Width of TKEEP and write strobes
   parameter BW_AXI      = 32,      //- Data width
   parameter BWB_AXI     = BW_AXI/8 //- Width of TKEEP and write strobes
)(
  //////////////////////
  // Packet interface
  //////////////////////
  //Input
   input  logic           stream_in_packet_in_TVALID,
   input  logic           stream_in_packet_in_TLAST,
   input  logic  [BW-1:0] stream_in_packet_in_TDATA,
	input  logic [BWB-1:0] stream_in_packet_in_TKEEP,
	output logic           stream_in_packet_in_TREADY,
   //Output
   output logic           stream_out_packet_out_TVALID,
	output logic           stream_out_packet_out_TLAST,
	output logic  [BW-1:0] stream_out_packet_out_TDATA,
	output logic [BWB-1:0] stream_out_packet_out_TKEEP,
	input  logic           stream_out_packet_out_TREADY,
  ////////////////////
  // AXI
  ////////////////////
  //Address Write
	input  logic    [11:0] control_S_AXI_AWADDR,
	input  logic           control_S_AXI_AWVALID,
	output logic           control_S_AXI_AWREADY,
  //Write
	input  logic  [BW_AXI-1:0] control_S_AXI_WDATA,
	input  logic [BWB_AXI-1:0] control_S_AXI_WSTRB,
	input  logic           control_S_AXI_WVALID,
	output logic           control_S_AXI_WREADY,
  //Write Response
	output logic     [1:0] control_S_AXI_BRESP,
	output logic           control_S_AXI_BVALID,
	input  logic           control_S_AXI_BREADY,
  //Address Read
	input  logic    [11:0] control_S_AXI_ARADDR,
	input  logic           control_S_AXI_ARVALID,
	output logic           control_S_AXI_ARREADY,
  //Read Response
	output logic  [BW_AXI-1:0] control_S_AXI_RDATA,
	output logic     [1:0] control_S_AXI_RRESP,
	output logic           control_S_AXI_RVALID,
	input  logic           control_S_AXI_RREADY,
   ////////////////////
   // Metadata
   ////////////////////
   input  logic           notify_in_metadata_in_VALID,
   input  logic   [127:0] notify_in_metadata_in_DATA,
   output logic           notify_out_metadata_out_VALID,
	output logic   [127:0] notify_out_metadata_out_DATA,
   `ifdef DDR4_CTRL
   ////////////////////
   // Memory Manager
   ////////////////////
   //- ADDRESS WRITE
   input  logic                    s_axi_awready,
   output logic                    s_axi_awvalid,
   output logic  [S_AXI_ID_SZ-1:0] s_axi_awid,
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
   output  logic                   s_axi_bready,
   input logic                     s_axi_bvalid,
   input logic   [S_AXI_ID_SZ-1:0] s_axi_bid,
   input logic  [S_AXI_RSP_SZ-1:0] s_axi_bresp,
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
   input  logic [S_AXI_RSP_SZ-1:0] s_axi_rresp,

   input logic clk_memory,
   input logic clk_memory_rst,
   `endif
   ////////////////////
   // Clock and Reset
   ////////////////////
   input  logic clk_line_rst,
	input  logic clk_line,
	input  logic clk_control_rst,
	input  logic clk_control,
	input  logic enable_processing,
	output logic internal_rst_done
);

///////////////////////////////////////
// Parameters
///////////////////////////////////////

localparam ROW   = `ROW;       //- Number of Rows 
localparam COL   = `COL;       //- Number of Columns
localparam TILES = ROW*COL;    //- Number of Tiles in mosaic
localparam DIS   = 4;          //- Ports in dispatcher. FIXME: Ideally equal to ROWS

//- Used for setting the type of tile
localparam BITS_TILE_TYPE = `BITS_TILE_TYPE; 
localparam [BITS_TILE_TYPE*TILES-1:0] TILE_TYPE = `TILE_TYPE;

//- Used for the AXI Controller 
localparam AXI_UX_ADDR_TILE = `AXI_UX_ADDR_TILE; //- Bits to address tiles in the AXI CONTROLLER ~log2(TILES)
localparam AXI_TILES        = `AXI_TILES;        //- Number of tiles that the Controller sees 
localparam AXI_OUTADR       = `AXI_OUTADR;       
localparam NOC_BUFFER_ADDR_W  = `NOC_BUFFER_ADDR_W;
///////////////////////////////////////
// Signals
///////////////////////////////////////

//- Clock and reset
logic clk_control_rst_low;
logic clk_control_rst_high;
logic clk_line_rst_high;
logic clk_line_rst_low;
logic sop_plain_start_of_processing;

//- Dispatcher (Hard coded: 4 ports)
logic [DIS-1:0] stream_out_dispatcher_TVALID; 
logic [DIS-1:0] stream_out_dispatcher_TREADY; 
logic [DIS-1:0] stream_out_dispatcher_TLAST; 
logic  [BW-1:0] stream_out_dispatcher_TDATA [DIS-1:0]; 
logic [BWB-1:0] stream_out_dispatcher_TKEEP [DIS-1:0];

logic  [(BW*DIS)-1:0] stream_out_dispatcher_TDATA_v; 
logic [(BWB*DIS)-1:0] stream_out_dispatcher_TKEEP_v;

logic S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TVALID;
logic S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TREADY;
logic S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TLAST;
logic [ BW-1:0] S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TDATA;
logic [BWB-1:0] S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TKEEP;

//- Gatherer
logic [DIS-1:0] stream_in_gatherer_TVALID; 
logic [DIS-1:0] stream_in_gatherer_TREADY; 
logic [DIS-1:0] stream_in_gatherer_TLAST; 
logic  [BW-1:0] stream_in_gatherer_TDATA [DIS-1:0]; 
logic [BWB-1:0] stream_in_gatherer_TKEEP [DIS-1:0];

logic  [(BW*4)-1:0] stream_in_gatherer_TDATA_v; 
logic [(BWB*4)-1:0] stream_in_gatherer_TKEEP_v;

logic           stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TVALID;
logic           stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TLAST;
logic           stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TREADY;
logic  [BW-1:0] stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TDATA;
logic [BWB-1:0] stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TKEEP;

//- AXI bus
logic [AXI_OUTADR-1:0] tile_S_AXI_AWADDR  [0:AXI_TILES-1];
logic  [AXI_TILES-1:0] tile_S_AXI_AWVALID;
logic  [AXI_TILES-1:0] tile_S_AXI_AWREADY;
logic     [BW_AXI-1:0] tile_S_AXI_WDATA [0:AXI_TILES-1];
logic    [BWB_AXI-1:0] tile_S_AXI_WSTRB [0:AXI_TILES-1];
logic  [AXI_TILES-1:0] tile_S_AXI_WVALID;
logic  [AXI_TILES-1:0] tile_S_AXI_WREADY;
logic            [1:0] tile_S_AXI_BRESP   [0:AXI_TILES-1];
logic  [AXI_TILES-1:0] tile_S_AXI_BVALID;
logic  [AXI_TILES-1:0] tile_S_AXI_BREADY;
logic [AXI_OUTADR-1:0] tile_S_AXI_ARADDR  [0:AXI_TILES-1];
logic  [AXI_TILES-1:0] tile_S_AXI_ARVALID;
logic  [AXI_TILES-1:0] tile_S_AXI_ARREADY;
logic     [BW_AXI-1:0] tile_S_AXI_RDATA   [0:AXI_TILES-1];
logic            [1:0] tile_S_AXI_RRESP   [0:AXI_TILES-1];
logic  [AXI_TILES-1:0] tile_S_AXI_RVALID;
logic  [AXI_TILES-1:0] tile_S_AXI_RREADY;

logic [AXI_OUTADR*AXI_TILES-1:0] tile_S_AXI_AWADDR_v;
logic     [BW_AXI*AXI_TILES-1:0] tile_S_AXI_WDATA_v;
logic    [BWB_AXI*AXI_TILES-1:0] tile_S_AXI_WSTRB_v;
logic          [2*AXI_TILES-1:0] tile_S_AXI_BRESP_v;
logic [AXI_OUTADR*AXI_TILES-1:0] tile_S_AXI_ARADDR_v;
logic     [BW_AXI*AXI_TILES-1:0] tile_S_AXI_RDATA_v;
logic          [2*AXI_TILES-1:0] tile_S_AXI_RRESP_v;

//- NOC

logic       [3:0] stream_out_TVALID [0:TILES-1];  // 4 ports: Left, Top, Right, Bottom 
logic       [3:0] stream_out_TREADY [0:TILES-1];
logic       [3:0] stream_out_TLAST  [0:TILES-1];
logic  [4*BW-1:0] stream_out_TDATA  [0:TILES-1];
logic [4*BWB-1:0] stream_out_TKEEP  [0:TILES-1];

logic       [3:0] stream_in_TVALID [0:TILES-1];
logic       [3:0] stream_in_TREADY [0:TILES-1];
logic       [3:0] stream_in_TLAST  [0:TILES-1];
logic  [4*BW-1:0] stream_in_TDATA  [0:TILES-1];
logic [4*BWB-1:0] stream_in_TKEEP  [0:TILES-1];

`ifdef DDR4_CTRL
  //- DDR4 manager
  logic     [COL-1:0] stream_out_mem_mgr_TVALID;
  logic     [COL-1:0] stream_out_mem_mgr_TREADY;
  logic     [COL-1:0] stream_out_mem_mgr_TLAST;
  logic  [COL*BW-1:0] stream_out_mem_mgr_TDATA;
  logic [COL*BWB-1:0] stream_out_mem_mgr_TKEEP;

  logic     [COL-1:0] stream_in_mem_mgr_TVALID;
  logic     [COL-1:0] stream_in_mem_mgr_TREADY;
  logic     [COL-1:0] stream_in_mem_mgr_TLAST;
  logic  [COL*BW-1:0] stream_in_mem_mgr_TDATA;
  logic [COL*BWB-1:0] stream_in_mem_mgr_TKEEP;
`endif

//- Que comience la fiesta

if (ROW<4) begin
  assign stream_out_dispatcher_TREADY[3:ROW] = {4-ROW{1'b0}};
end


genvar i,j;

generate
  for (i=0; i<ROW; i=i+1) begin : grid_row

    if (i<4) begin
      assign stream_out_dispatcher_TDATA[i] = stream_out_dispatcher_TDATA_v[(BW*(i+1))-1:BW*i]; 
      assign stream_out_dispatcher_TKEEP[i]  = stream_out_dispatcher_TKEEP_v[(BWB*(i+1))-1:BWB*i];

      assign stream_in_gatherer_TVALID[i] = stream_out_TVALID[(i*COL)+(COL-1)][1];          //Right
      assign stream_in_gatherer_TLAST[i]  = stream_out_TLAST[(i*COL)+(COL-1)][1];           //Right
      assign stream_in_gatherer_TDATA[i]  = stream_out_TDATA[(i*COL)+(COL-1)][2*BW-1:BW];   //Right
      assign stream_in_gatherer_TKEEP[i]  = stream_out_TKEEP[(i*COL)+(COL-1)][2*BWB-1:BWB]; //Right

      assign stream_in_gatherer_TDATA_v[(BW*(i+1))-1:BW*i] = stream_in_gatherer_TDATA[i]; 
      assign stream_in_gatherer_TKEEP_v[(BWB*(i+1))-1:BWB*i]  = stream_in_gatherer_TKEEP[i];
    end

    for (j=0; j<COL; j=j+1) begin : grid_col

      assign tile_S_AXI_AWADDR[i*COL+j]= tile_S_AXI_AWADDR_v[(AXI_OUTADR*((i*COL+j)+1))-1:AXI_OUTADR*(i*COL+j)]; 
      assign tile_S_AXI_WDATA[i*COL+j] = tile_S_AXI_WDATA_v[(BW_AXI*((i*COL+j)+1))-1:BW_AXI*(i*COL+j)]; 
      assign tile_S_AXI_WSTRB[i*COL+j] = tile_S_AXI_WSTRB_v[(BWB_AXI*((i*COL+j)+1))-1:BWB_AXI*(i*COL+j)]; 
      assign tile_S_AXI_BRESP_v[(2*((i*COL+j)+1))-1:2*(i*COL+j)] = tile_S_AXI_BRESP[i*COL+j]; 
      assign tile_S_AXI_ARADDR[i*COL+j]= tile_S_AXI_ARADDR_v[(AXI_OUTADR*((i*COL+j)+1))-1:AXI_OUTADR*(i*COL+j)]; 
      assign tile_S_AXI_RDATA_v[(BW*((i*COL+j)+1))-1:BW*(i*COL+j)]=tile_S_AXI_RDATA[i*COL+j]; 
      assign tile_S_AXI_RRESP_v[(2*((i*COL+j)+1))-1:2*(i*COL+j)]=tile_S_AXI_RRESP[i*COL+j]; 
      
      //- Connections
      if (i==0) begin
        assign stream_in_TVALID[j][2]   = 1'b0; // Top
        assign stream_in_TLAST[j][2]    = 1'b0;
        assign stream_in_TDATA[j][3*BW-1:2*BW] = 'h0;
        assign stream_in_TKEEP[j][3*BWB-1:2*BWB] = 'h0;
        assign stream_out_TREADY[j][2] = 1'b1;
      end else begin
        assign stream_in_TVALID[i*COL+j][2]   = stream_out_TVALID[(i-1)*COL+j][0]; // Top[i][j] = bottom[i-1][j]
        assign stream_in_TLAST[i*COL+j][2]    = stream_out_TLAST[(i-1)*COL+j][0];
        assign stream_in_TDATA[i*COL+j][3*BW-1:2*BW] = stream_out_TDATA[(i-1)*COL+j][BW-1:0];
        assign stream_in_TKEEP[i*COL+j][3*BWB-1:2*BWB] = stream_out_TKEEP[(i-1)*COL+j][BWB-1:0];
        assign stream_out_TREADY[i*COL+j][2] = stream_in_TREADY[(i-1)*COL+j][0];
        //assign stream_out_TREADY[(i-1)*COL+j][0] = stream_in_TREADY[i*COL+j][2];  //Bottom[i-1][j] = Top[i][j]
      end

      if (j==0) begin
        if (i<4) begin
          assign stream_in_TVALID[i*COL+j][3] = stream_out_dispatcher_TVALID[i];
          assign stream_in_TLAST[i*COL+j][3]  = stream_out_dispatcher_TLAST[i];
          assign stream_in_TDATA[i*COL+j][4*BW-1:3*BW]  = stream_out_dispatcher_TDATA[i];
          assign stream_in_TKEEP[i*COL+j][4*BWB-1:3*BWB]  = stream_out_dispatcher_TKEEP[i];
          assign stream_out_dispatcher_TREADY[i] = stream_in_TREADY[i*COL+j][3];
        end else begin
          assign stream_in_TVALID[i*COL+j][3] = 1'b0;
          assign stream_in_TDATA[i*COL+j][4*BW-1:3*BW] = 'h0;
          assign stream_in_TKEEP[i*COL+j][4*BWB-1:3*BWB] = 'h0;
          assign stream_in_TLAST[i*COL+j][3] = 1'b0;
        end
        assign stream_out_TREADY[i*COL+j][3] = 1'b1;
      end else begin
        assign stream_in_TVALID[i*COL+j][3] = stream_out_TVALID[i*COL+(j-1)][1];
        assign stream_in_TLAST[i*COL+j][3] = stream_out_TLAST[i*COL+(j-1)][1];
        assign stream_in_TDATA[i*COL+j][4*BW-1:3*BW] = stream_out_TDATA[i*COL+(j-1)][2*BW-1:BW];
        assign stream_in_TKEEP[i*COL+j][4*BWB-1:3*BWB] = stream_out_TKEEP[i*COL+(j-1)][2*BWB-1:BWB];
        assign stream_out_TREADY[i*COL+j][3] = stream_in_TREADY[i*COL+(j-1)][1];
        //assign stream_out_TREADY[i*COL+(j-1)][1] = stream_in_TREADY[i*COL+j][3];
      end

      if (j==COL-1) begin
        assign stream_in_TVALID[i*COL+j][1] = 1'b0; //Right
        assign stream_in_TLAST[i*COL+j][1] = 1'b0;
        assign stream_in_TDATA[i*COL+j][2*BW-1:BW] = 'h0;
        assign stream_in_TKEEP[i*COL+j][2*BWB-1:BWB] = 'h0;
        if (i<4)
          assign stream_out_TREADY[i*COL+j][1] = stream_in_gatherer_TREADY[i];
        else
          assign stream_out_TREADY[i*COL+j][1] = 1'b1;
      end else begin
        assign stream_in_TVALID[i*COL+j][1] = stream_out_TVALID[i*COL+(j+1)][3];
        assign stream_in_TLAST[i*COL+j][1] = stream_out_TLAST[i*COL+(j+1)][3];
        assign stream_in_TDATA[i*COL+j][2*BW-1:BW] = stream_out_TDATA[i*COL+(j+1)][4*BW-1:3*BW];
        assign stream_in_TKEEP[i*COL+j][2*BWB-1:BWB] = stream_out_TKEEP[i*COL+(j+1)][4*BWB-1:3*BWB];
        assign stream_out_TREADY[i*COL+j][1] = stream_in_TREADY[i*COL+(j+1)][3];
      end

      if (i==ROW-1) begin
        
        //if (j<4) begin
          `ifdef DDR4_CTRL
            assign stream_in_TVALID[i*COL+j][0]      = stream_out_mem_mgr_TVALID[j];
            assign stream_in_TLAST[i*COL+j][0]       = stream_out_mem_mgr_TLAST[j];
            assign stream_in_TDATA[i*COL+j][BW-1:0]  = stream_out_mem_mgr_TDATA[BW*(j+1)-1:BW*j];
            assign stream_in_TKEEP[i*COL+j][BWB-1:0] = stream_out_mem_mgr_TKEEP[BWB*(j+1)-1:BWB*j];

            assign stream_out_mem_mgr_TREADY[j] = stream_in_TREADY[i*COL+j][0];

            assign stream_in_mem_mgr_TVALID[j] = stream_out_TVALID[i*COL+j][0];
            assign stream_in_mem_mgr_TLAST[j] = stream_out_TLAST[i*COL+j][0];
            assign stream_in_mem_mgr_TDATA[BW*(j+1)-1:j*BW] = stream_out_TDATA[i*COL+j][BW-1:0];
            assign stream_in_mem_mgr_TKEEP[BWB*(j+1)-1:j*BWB] = stream_out_TKEEP[i*COL+j][BWB-1:0];
            
            assign stream_out_TREADY[i*COL+j][0] = stream_in_mem_mgr_TREADY[j];
          `else
            assign stream_in_TVALID[i*COL+j][0]      = 1'b0;  //Bottom
            assign stream_in_TLAST[i*COL+j][0]       = 1'b0;
            assign stream_in_TDATA[i*COL+j][BW-1:0]  = 'h0;
            assign stream_in_TKEEP[i*COL+j][BWB-1:0] = 'h0;
            assign stream_out_TREADY[i*COL+j][0]     = 1'b1;
          `endif
        /*end else begin
            assign stream_in_TVALID[i*COL+j][0]      = 'h0; //Bottom
            assign stream_in_TLAST[i*COL+j][0]       = 'h0;
            assign stream_in_TDATA[i*COL+j][BW-1:0]  = 'h0;
            assign stream_in_TKEEP[i*COL+j][BWB-1:0] = 'h0;  
            assign stream_out_TREADY[i*COL+j][0] = 1'b1; //Top
        end*/
        
      end else begin
        assign stream_in_TVALID[i*COL+j][0]      = stream_out_TVALID[(i+1)*COL+j][2];
        assign stream_in_TLAST[i*COL+j][0]       = stream_out_TLAST[(i+1)*COL+j][2];
        assign stream_in_TDATA[i*COL+j][BW-1:0]  = stream_out_TDATA[(i+1)*COL+j][3*BW-1:2*BW];
        assign stream_in_TKEEP[i*COL+j][BWB-1:0] = stream_out_TKEEP[(i+1)*COL+j][3*BWB-1:2*BWB];
        assign stream_out_TREADY[i*COL+j][0] = stream_in_TREADY[(i+1)*COL+j][2];
        //TEST FIXME assign stream_out_TREADY[(i+1)*COL+j][2] = stream_in_TREADY[i*COL+j][0];
      end
    end
  end
endgenerate

generate
  for (i=0; i<ROW; i=i+1) begin : row
    for (j=0; j<COL; j=j+1) begin : col
      `include "tiles.vh"
    end
  end
endgenerate

S_RESETTER_line S_RESET_clk_line(
	.clk                 	 (clk_line),
	.rst                 	 (clk_line_rst),
	.reset_out_active_high (clk_line_rst_high),
	.reset_out_active_low	 (clk_line_rst_low),
	.init_done           	 (clk_line_init_done));

S_RESETTER_control S_RESET_clk_control(
	.clk                 	 (clk_control),
	.rst                 	 (clk_control_rst),
	.reset_out_active_high (clk_control_rst_high),
	.reset_out_active_low	 (clk_control_rst_low),
	.init_done           	 (clk_control_init_done));

assign internal_rst_done = (clk_line_init_done && clk_control_init_done);

SOP sop(
	.plain_out_start_of_processing (sop_plain_start_of_processing),
	.clk_line            	         (clk_line),
	.rst                 	         (clk_line_rst_high));

Dispatcher#(
  .BW  (BW),
  .END (ROW)
) dispatcher(
	.stream_in_packet_TVALID	  (S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TVALID),
	.stream_in_packet_TREADY	  (S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TREADY), //Out
	.stream_in_packet_TDATA	     (S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TDATA),
	.stream_in_packet_TKEEP	     (S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TKEEP),
	.stream_in_packet_TLAST	     (S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TLAST),
   .stream_out_packet_TVALID    (stream_out_dispatcher_TVALID),
   .stream_out_packet_TLAST     (stream_out_dispatcher_TLAST),
   .stream_out_packet_TREADY    (stream_out_dispatcher_TREADY), //In [3:0]
   .stream_out_packet_TDATA     (stream_out_dispatcher_TDATA_v),
   .stream_out_packet_TKEEP     (stream_out_dispatcher_TKEEP_v),
   .notify_in_metadata_in_VALID (notify_in_metadata_in_VALID),
   .notify_in_metadata_in_DATA  (notify_in_metadata_in_DATA),
   .clk_line            	     (clk_line),
   .clk_line_rst_low         	  (clk_line_rst_low),
   .clk_line_rst_high           (clk_line_rst_high));

Gatherer#(
   .BW (BW)
) gatherer(
	.stream_in_packet_TVALID	     (stream_in_gatherer_TVALID),  // In [3:0]
	.stream_in_packet_TREADY	     (stream_in_gatherer_TREADY),  // Out [3:0]
	.stream_in_packet_TDATA	       (stream_in_gatherer_TDATA_v), // In [127:0]
	.stream_in_packet_TKEEP	       (stream_in_gatherer_TKEEP_v), // In [11:0]
	.stream_in_packet_TLAST	       (stream_in_gatherer_TLAST),   // In [3:0]
  .stream_out_packet_TVALID      (stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TVALID),
  .stream_out_packet_TLAST       (stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TLAST),
  .stream_out_packet_TREADY      (stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TREADY), // In
  .stream_out_packet_TDATA       (stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TDATA),
  .stream_out_packet_TKEEP       (stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TKEEP),
	.notify_out_metadata_out_VALID (notify_out_metadata_out_VALID),
	.notify_out_metadata_out_DATA	 (notify_out_metadata_out_DATA),
	.clk_line            	         (clk_line),
	.rst                      	   (clk_line_rst_high));


S_PROTOCOL_ADAPTER_INGRESS#(
   .BW (BW)
)S_PROTOCOL_ADAPTER_INGRESS(
	.stream_in_TVALID    	(stream_in_packet_in_TVALID), 
	.stream_in_TREADY    	(stream_in_packet_in_TREADY), //Out
	.stream_in_TDATA     	(stream_in_packet_in_TDATA),  
	.stream_in_TKEEP     	(stream_in_packet_in_TKEEP),
	.stream_in_TLAST     	(stream_in_packet_in_TLAST),
	.stream_out_TVALID   	(S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TVALID),
	.stream_out_TREADY   	(S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TREADY),  //In
	.stream_out_TDATA    	(S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TDATA),
	.stream_out_TKEEP    	(S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TKEEP),
	.stream_out_TLAST    	(S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TLAST),

	.backpressure_in     	(~S_PROTOCOL_ADAPTER_INGRESS_stream_in_packet_in_TREADY), 
	.backpressure_out    	( ), //FIXME
	.clk_line            	( clk_line ),
	.rst                 	( clk_line_rst_high )
);

S_PROTOCOL_ADAPTER_EGRESS#(
   .BW (BW)
) S_PROTOCOL_ADAPTER_EGRESS (
	.stream_in_TVALID    	(stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TVALID),
	.stream_in_TREADY    	(stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TREADY), // Out
	.stream_in_TDATA     	(stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TDATA),
	.stream_in_TKEEP     	(stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TKEEP),
	.stream_in_TLAST     	(stream_out_gatherer_S_PROTOCOL_ADAPTER_EGRESS_TLAST),
	.stream_out_TVALID   	(stream_out_packet_out_TVALID),
	.stream_out_TREADY   	(stream_out_packet_out_TREADY), //In
	.stream_out_TDATA    	(stream_out_packet_out_TDATA),
	.stream_out_TKEEP    	(stream_out_packet_out_TKEEP),
	.stream_out_TLAST    	(stream_out_packet_out_TLAST),
	.clk_line            	(clk_line),
	.rst                 	(clk_line_rst_high)
);

S_CONTROLLER_USS#(
  .AXI_UX_ADDR_TILE (AXI_UX_ADDR_TILE),
  .AXI_OUTADR       (AXI_OUTADR),
  .TILES            (AXI_TILES)
) S_CONTROL_USS (
	.enable_processing  (),
  //- To Tiles
	.tile_S_AXI_AWADDR	(tile_S_AXI_AWADDR_v),
	.tile_S_AXI_AWVALID (tile_S_AXI_AWVALID),
	.tile_S_AXI_AWREADY (tile_S_AXI_AWREADY),
	.tile_S_AXI_WDATA	  (tile_S_AXI_WDATA_v),
	.tile_S_AXI_WSTRB	  (tile_S_AXI_WSTRB_v),
	.tile_S_AXI_WVALID	(tile_S_AXI_WVALID),
	.tile_S_AXI_WREADY	(tile_S_AXI_WREADY),
	.tile_S_AXI_BRESP	  (tile_S_AXI_BRESP_v),
	.tile_S_AXI_BVALID	(tile_S_AXI_BVALID),
	.tile_S_AXI_BREADY	(tile_S_AXI_BREADY),
	.tile_S_AXI_ARADDR	(tile_S_AXI_ARADDR_v),
	.tile_S_AXI_ARVALID (tile_S_AXI_ARVALID),
	.tile_S_AXI_ARREADY (tile_S_AXI_ARREADY),
	.tile_S_AXI_RDATA	  (tile_S_AXI_RDATA_v),
	.tile_S_AXI_RRESP	  (tile_S_AXI_RRESP_v),
	.tile_S_AXI_RVALID	(tile_S_AXI_RVALID),
	.tile_S_AXI_RREADY	(tile_S_AXI_RREADY),
  //- From PCIE??
	.control_S_AXI_AWADDR  (control_S_AXI_AWADDR),
	.control_S_AXI_AWVALID (control_S_AXI_AWVALID),
	.control_S_AXI_AWREADY (control_S_AXI_AWREADY),
	.control_S_AXI_WDATA 	 (control_S_AXI_WDATA),
	.control_S_AXI_WSTRB 	 (control_S_AXI_WSTRB),
	.control_S_AXI_WVALID	 (control_S_AXI_WVALID),
	.control_S_AXI_WREADY	 (control_S_AXI_WREADY),
	.control_S_AXI_BRESP 	 (control_S_AXI_BRESP),
	.control_S_AXI_BVALID	 (control_S_AXI_BVALID),
	.control_S_AXI_BREADY	 (control_S_AXI_BREADY),
	.control_S_AXI_ARADDR	 (control_S_AXI_ARADDR),
	.control_S_AXI_ARVALID (control_S_AXI_ARVALID),
	.control_S_AXI_ARREADY (control_S_AXI_ARREADY),
	.control_S_AXI_RDATA 	 (control_S_AXI_RDATA),
	.control_S_AXI_RRESP 	 (control_S_AXI_RRESP),
	.control_S_AXI_RVALID	 (control_S_AXI_RVALID),
	.control_S_AXI_RREADY	 (control_S_AXI_RREADY),
	.clk_control         	 (clk_control),
	.rst                 	 (clk_control_rst_high)
);

`ifdef DDR4_CTRL

  assign tile_S_AXI_AWADDR[TILES]= tile_S_AXI_AWADDR_v[(AXI_OUTADR*(TILES+1))-1:AXI_OUTADR*TILES]; 
  assign tile_S_AXI_WDATA[TILES] = tile_S_AXI_WDATA_v[(BW_AXI*(TILES+1))-1:BW_AXI*TILES]; 
  assign tile_S_AXI_WSTRB[TILES] = tile_S_AXI_WSTRB_v[(BWB_AXI*(TILES+1))-1:BWB_AXI*TILES]; 
  assign tile_S_AXI_BRESP_v[(2*(TILES+1))-1:2*TILES] = tile_S_AXI_BRESP[TILES]; 
  assign tile_S_AXI_ARADDR[TILES]= tile_S_AXI_ARADDR_v[(AXI_OUTADR*(TILES+1))-1:AXI_OUTADR*TILES]; 
  assign tile_S_AXI_RDATA_v[(BW*(TILES+1))-1:BW*TILES]=tile_S_AXI_RDATA[TILES]; 
  assign tile_S_AXI_RRESP_v[(2*(TILES+1))-1:2*TILES]=tile_S_AXI_RRESP[TILES];

  S_RESETTER_control S_RESET_clk_memory(
	  .clk                 	 (clk_memory ),
	  .rst                 	 (clk_memory_rst ),
	  .reset_out_active_high (clk_memory_rst_high ),
	  .reset_out_active_low	 (clk_memory_rst_low ),
	  .init_done           	 (clk_memory_init_done ));

  Tile_mem_mgr#(
    .AXI_ADDR (AXI_OUTADR),
    .COL      (COL)
  ) tile_mem_mgr_inst(
   .stream_in_TVALID        (stream_in_mem_mgr_TVALID),
   .stream_in_TREADY        (stream_in_mem_mgr_TREADY),
   .stream_in_TDATA         (stream_in_mem_mgr_TDATA),
   .stream_in_TKEEP         (stream_in_mem_mgr_TKEEP),
   .stream_in_TLAST         (stream_in_mem_mgr_TLAST),
   .stream_out_TVALID       (stream_out_mem_mgr_TVALID),
   .stream_out_TREADY       (stream_out_mem_mgr_TREADY),
   .stream_out_TDATA        (stream_out_mem_mgr_TDATA),
   .stream_out_TKEEP        (stream_out_mem_mgr_TKEEP),
   .stream_out_TLAST        (stream_out_mem_mgr_TLAST),
   //- AXI bus
   .control_S_AXI_AWADDR 	  (tile_S_AXI_AWADDR[TILES]), 
   .control_S_AXI_AWVALID	  (tile_S_AXI_AWVALID[TILES]),
   .control_S_AXI_AWREADY	  (tile_S_AXI_AWREADY[TILES]),
   .control_S_AXI_WDATA  	  (tile_S_AXI_WDATA[TILES]),
   .control_S_AXI_WSTRB 	  (tile_S_AXI_WSTRB[TILES]),
   .control_S_AXI_WVALID	  (tile_S_AXI_WVALID[TILES]),
   .control_S_AXI_WREADY	  (tile_S_AXI_WREADY[TILES]),
   .control_S_AXI_BRESP 	  (tile_S_AXI_BRESP[TILES]),
   .control_S_AXI_BVALID	  (tile_S_AXI_BVALID[TILES]),
   .control_S_AXI_BREADY	  (tile_S_AXI_BREADY[TILES]),
   .control_S_AXI_ARADDR	  (tile_S_AXI_ARADDR[TILES]),
   .control_S_AXI_ARVALID	  (tile_S_AXI_ARVALID[TILES]),
   .control_S_AXI_ARREADY	  (tile_S_AXI_ARREADY[TILES]),
   .control_S_AXI_RDATA 	  (tile_S_AXI_RDATA[TILES]),
   .control_S_AXI_RRESP 	  (tile_S_AXI_RRESP[TILES]),
   .control_S_AXI_RVALID	  (tile_S_AXI_RVALID[TILES]),
   .control_S_AXI_RREADY 	  (tile_S_AXI_RREADY[TILES]),
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
   .s_axi_rresp       (s_axi_rresp),
  //- Clock and reset
	 .clk_memory           (clk_memory),
	 .clk_memory_rst_high  (clk_memory_rst_high),
   .clk_memory_rst_low   (clk_memory_rst_low),  
   .clk_control    	     (clk_control),
   .clk_control_rst_low  (clk_control_rst_low),
   .clk_control_rst_high (clk_control_rst_high),
   .clk_line             (clk_line),
   .clk_line_rst_high    (clk_line_rst_high),
   .clk_line_rst_low     (clk_line_rst_low));
`endif


endmodule
