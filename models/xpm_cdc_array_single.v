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
// Date        : June 2024
// Description : Simple register model for icarus
// File        : xpm_cdc_array_single.sv
// Notes       : 
//  - Only valid for icarus simulation.
//  - Unused ports added for compatibility with the
//    Xilinx macro
////////////////////////////////////////////////////

module xpm_cdc_array_single # (
   parameter integer DEST_SYNC_FF    = 4,
   parameter integer INIT_SYNC_FF    = 0,
   parameter integer SIM_ASSERT_CHK  = 0,
   parameter integer SRC_INPUT_REG   = 1,
   parameter integer VERSION         = 0,
   parameter integer WIDTH           = 2
)(
   input  wire             src_clk,
   input  wire [WIDTH-1:0] src_in,
   input  wire             dest_clk,
   output wire [WIDTH-1:0] dest_out
);

reg  [WIDTH-1:0] src_ff;
wire [WIDTH-1:0] src_inqual;
wire [WIDTH-1:0] async_path_bit;
reg  [WIDTH-1:0] syncstages_ff [DEST_SYNC_FF-1:0];

assign dest_out = syncstages_ff[DEST_SYNC_FF-1];

always @(posedge dest_clk) begin
   syncstages_ff[0] <= async_path_bit;
   for (int syncstage = 1; syncstage < DEST_SYNC_FF ;syncstage = syncstage + 1)
      syncstages_ff[syncstage] <= syncstages_ff [syncstage-1];
end

assign async_path_bit = src_inqual;

assign src_inqual = src_ff;

always @(posedge src_clk) 
      src_ff <= src_in;

endmodule
