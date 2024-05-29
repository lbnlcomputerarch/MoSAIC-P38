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
// Date        : April 25 2022
// Description : AXI decoder/encoder
// File        : S_CONTROLLER_USS.sv
// Notes       : 
//  - FIXME: What to do with enable_processing ?
////////////////////////////////////////////////////////////////

/*
 |4096|2048|1024|512|256|128|64|32|16|8|4|2|1|
 |  12|  11|  10|  9|  8|  7| 6| 5| 4|3|2|1|0|
*/

`timescale 1 ps / 1 ps

module S_CONTROLLER_USS#(
   parameter AXI_OUTADR       = 8,  //- Output address size
   parameter AXI_INADR        = 12, //- Input address size
   parameter AXI_UX_ADDR_TILE = 4,
   parameter TILES            = 16,  //- Number of tiles
   parameter BW               = 32, 
   parameter BWB              = 4
)(
   input  logic                        clk_control,
   output logic                        enable_processing,
   input  logic                        rst,
   input  logic        [AXI_INADR-1:0] control_S_AXI_AWADDR,
   input  logic                        control_S_AXI_AWVALID,
   output logic                        control_S_AXI_AWREADY,
   input  logic                        control_S_AXI_WVALID,
   input  logic               [BW-1:0] control_S_AXI_WDATA,
   input  logic              [BWB-1:0] control_S_AXI_WSTRB,
   output logic                        control_S_AXI_WREADY,
   input  logic                        control_S_AXI_BREADY,
   output logic                        control_S_AXI_BVALID,
   output logic                  [1:0] control_S_AXI_BRESP,
   input  logic        [AXI_INADR-1:0] control_S_AXI_ARADDR,
   input  logic                        control_S_AXI_ARVALID,
   output logic                        control_S_AXI_ARREADY,
   input  logic                        control_S_AXI_RREADY,
   output logic               [BW-1:0] control_S_AXI_RDATA,
   output logic                  [1:0] control_S_AXI_RRESP,
   output logic                        control_S_AXI_RVALID,
   input  logic            [TILES-1:0] tile_S_AXI_AWREADY,
   output logic [AXI_OUTADR*TILES-1:0] tile_S_AXI_AWADDR,
   output logic            [TILES-1:0] tile_S_AXI_AWVALID,
   input  logic            [TILES-1:0] tile_S_AXI_WREADY,
   output logic         [BW*TILES-1:0] tile_S_AXI_WDATA,
   output logic        [BWB*TILES-1:0] tile_S_AXI_WSTRB,
   output logic            [TILES-1:0] tile_S_AXI_WVALID,
   input  logic          [2*TILES-1:0] tile_S_AXI_BRESP,
   input  logic            [TILES-1:0] tile_S_AXI_BVALID,
   output logic            [TILES-1:0] tile_S_AXI_BREADY,
   input  logic            [TILES-1:0] tile_S_AXI_ARREADY,
   output logic [AXI_OUTADR*TILES-1:0] tile_S_AXI_ARADDR,
   output logic            [TILES-1:0] tile_S_AXI_ARVALID,
   input  logic         [BW*TILES-1:0] tile_S_AXI_RDATA,
   input  logic          [2*TILES-1:0] tile_S_AXI_RRESP,
   input  logic            [TILES-1:0] tile_S_AXI_RVALID,
   output logic            [TILES-1:0] tile_S_AXI_RREADY
);

//- FIXME: What is enbale_processing for?
assign enable_processing = 1'd1 ;

localparam BW_BUS = TILES*BW;

// - Address Write (AW) Bus
// - Write (W) Bus
axi_ux_addr#(
   .ADDR_TILE (AXI_UX_ADDR_TILE),
   .TILES     (TILES)
) axi_ux_addr_inst0 (
   .AXI_ADDR        (control_S_AXI_AWADDR),       //- In
   .AXI_AVALID      (control_S_AXI_AWVALID),      //- In
   .AXI_AREADY      (control_S_AXI_AWREADY),      //- Out
   .AXI_VALID       (control_S_AXI_WVALID),       //- In
   .AXI_READY       (control_S_AXI_WREADY),       //- Out
   .tile_AXI_AVALID (tile_S_AXI_AWVALID), //- Out
   .tile_AXI_AREADY (tile_S_AXI_AWREADY), //- In
   .tile_AXI_READY  (tile_S_AXI_WREADY),  //- In
   .tile_AXI_VALID  (tile_S_AXI_WVALID)   //- Out
);

// - Write Response (B) Bus
axi_ux_resp#(
   .ADDR_TILE (AXI_UX_ADDR_TILE),
   .TILES     (TILES)
) axi_ux_resp_inst0 (
   .AXI_READY      (control_S_AXI_BREADY), //- In 
   .AXI_RESP       (control_S_AXI_BRESP),  //- Out
   .AXI_VALID      (control_S_AXI_BVALID), //- Out
   .AXI_DATA       (),                     //- Out
   .tile_AXI_RESP  (tile_S_AXI_BRESP),     //- In
   .tile_AXI_VALID (tile_S_AXI_BVALID),    //- In
   .tile_AXI_DATA  ('h0),                  //- In
   .tile_AXI_READY (tile_S_AXI_BREADY)     //- Out
);

// - Address Read (AR) Bus
axi_ux_addr#(
   .ADDR_TILE (AXI_UX_ADDR_TILE),
   .TILES     (TILES)
) axi_ux_addr_inst1  (
   .AXI_ADDR        (control_S_AXI_ARADDR),  //- In
   .AXI_AVALID      (control_S_AXI_ARVALID), //- In
   .AXI_AREADY      (control_S_AXI_ARREADY), //- Out
   .AXI_VALID       (1'b0),                  //- In
   .AXI_READY       (),                      //- Out
   .tile_AXI_AVALID (tile_S_AXI_ARVALID),    //- Out
   .tile_AXI_AREADY (tile_S_AXI_ARREADY),    //- In
   .tile_AXI_READY  ('h0),                   //- In
   .tile_AXI_VALID  ()                       //- Out
);


// -  Read Resp (R) Bus
axi_ux_resp#(
   .ADDR_TILE (AXI_UX_ADDR_TILE),
   .TILES     (TILES)
) axi_ux_resp_inst1 (
   .AXI_READY      (control_S_AXI_RREADY), //- In 
   .AXI_RESP       (control_S_AXI_RRESP),  //- Out
   .AXI_VALID      (control_S_AXI_RVALID), //- Out
   .AXI_DATA       (control_S_AXI_RDATA),  //- Out
   .tile_AXI_RESP  (tile_S_AXI_RRESP),     //- In
   .tile_AXI_VALID (tile_S_AXI_RVALID),    //- In
   .tile_AXI_DATA  (tile_S_AXI_RDATA),     //- In
   .tile_AXI_READY (tile_S_AXI_RREADY)     //- Out
);

assign tile_S_AXI_AWADDR = {TILES{control_S_AXI_AWADDR[AXI_OUTADR-1:0]}};
assign tile_S_AXI_ARADDR = {TILES{control_S_AXI_AWADDR[AXI_OUTADR-1:0]}};
assign tile_S_AXI_WDATA  = {TILES{control_S_AXI_WDATA}};
assign tile_S_AXI_WSTRB  = {TILES{control_S_AXI_WSTRB}};

endmodule
