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

/////////////////////////////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : April 25 2022
// Description : Output packet interface between open-nic-shell and MoSAIC
// File        : S_PROTOCOL_ADAPTER_EGRESS.sv
// Notes       : 
//  - From USS by Farzad F. (LBL), and Chris N. (AMD).
//  - FIXME: Needs to be verified 
//////////////////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

module S_PROTOCOL_ADAPTER_EGRESS #(
   parameter BW  = 32,
   parameter BWB = BW/8
)(
   input  logic           clk_line,
   input  logic           rst,
   input  logic           stream_in_TLAST,
   input  logic           stream_in_TVALID,
   output logic           stream_in_TREADY,
   input  logic  [BW-1:0] stream_in_TDATA,
   input  logic [BWB-1:0] stream_in_TKEEP,
   output logic           stream_out_TLAST,
   output logic           stream_out_TVALID,
   input  logic           stream_out_TREADY,
   output logic  [BW-1:0] stream_out_TDATA,
   output logic [BWB-1:0] stream_out_TKEEP
);


assign stream_in_TREADY = stream_out_TREADY;

always @( posedge clk_line ) begin
   stream_out_TVALID <= stream_in_TVALID;
   stream_out_TLAST <= stream_in_TLAST;
end

reg [31:0] TDATA_i;
reg  [3:0] TKEEP_i;
always @(posedge clk_line) begin
   TDATA_i <= stream_in_TDATA;
   TKEEP_i <= stream_in_TKEEP;
end
   
genvar i;
genvar j;

for (i=0; i<4; i=i+1) begin
   for (j=0; j<8; j=j+1) begin
      assign stream_out_TDATA[i*8+j] = TDATA_i[(4-i-1)*8+j];
   end
end

for (i=0; i<4; i=i+1) begin 
   assign stream_out_TKEEP[i] = TKEEP_i[3-i];
end


endmodule

