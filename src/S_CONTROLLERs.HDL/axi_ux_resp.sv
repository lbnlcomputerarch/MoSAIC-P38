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
// Description : AXI decoder/encoder shell
// File        : axi_ux_resp.sv
// Notes       : 
//    - The "axi_ux_resp_var.vh" file is script generated 
////////////////////////////////////////////////////////////////

module axi_ux_resp#(
   parameter BW         = 32,
   parameter ADDR_TILE  = 4,
   parameter TILES       = 16
)(
   //- From AXI to controller
   input  logic          AXI_READY,
   output logic    [1:0] AXI_RESP,
   output logic          AXI_VALID,
   output logic [BW-1:0] AXI_DATA,
   //- From controller to Tiles
   input  logic  [2*TILES-1:0] tile_AXI_RESP,
   input  logic    [TILES-1:0] tile_AXI_VALID,
   input  logic [BW*TILES-1:0] tile_AXI_DATA,
   output logic    [TILES-1:0] tile_AXI_READY
);

//- Signals

logic [ADDR_TILE-1:0] addr;
logic [BW-1:0] tile_AXI_DATA_v [0:TILES-1];
logic    [1:0] tile_AXI_RESP_v [0:TILES-1];

//- Logic

assign AXI_VALID = tile_AXI_VALID[addr];
assign AXI_RESP  = tile_AXI_RESP_v[addr];
assign AXI_DATA  = tile_AXI_DATA_v[addr];

genvar i;
generate
   for(i=0; i<TILES; i=i+1) begin
     assign tile_AXI_RESP_v[i] = tile_AXI_RESP[2*(i+1)-1:2*i]; 
     assign tile_AXI_DATA_v[i] = tile_AXI_DATA[BW*(i+1)-1:BW*i]; 
   end
endgenerate

`include "axi_ux_resp_var.vh"

endmodule

