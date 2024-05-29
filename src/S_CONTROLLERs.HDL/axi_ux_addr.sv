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
// File        : axi_ux_addr.sv
// Notes       : 
//    - The "axi_ux_addr_var.vh" file is script generated 
////////////////////////////////////////////////////////////////

module axi_ux_addr#(
   parameter AXI_INADR = 12,
   parameter ADDR_TILE  = 4,
   parameter TILES      = 16
)(
   //- From AXI to controller
   input  logic [AXI_INADR-1:0] AXI_ADDR,  //- Address bus
   input  logic                 AXI_AVALID,
   output logic                 AXI_AREADY,
   input  logic                 AXI_VALID,  //- Write data bus
   output logic                 AXI_READY,
   //- From controller to Tiles
   input  logic    [TILES-1:0] tile_AXI_AREADY, // AWREADY, ARREADY
   input  logic    [TILES-1:0] tile_AXI_READY,  // WREADY, RREADY,
   output logic    [TILES-1:0] tile_AXI_AVALID,
   output logic    [TILES-1:0] tile_AXI_VALID
);


logic [ADDR_TILE-1:0] addr;
assign AXI_AREADY = tile_AXI_AREADY[addr];
assign AXI_READY  = tile_AXI_READY[addr];

`include "axi_ux_addr_var.vh"

endmodule
