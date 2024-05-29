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
// Description : Input packet interface between open-nic-shell and MoSAIC
// File        : S_PROTOCOL_ADAPTER_INGRESS.sv
// Notes       : 
//    - Empty blackbox. TBD
//////////////////////////////////////////////////////////////////////////////////////////


`timescale 1 ps / 1 ps

module S_PROTOCOL_ADAPTER_INGRESS (
   input  logic        clk_line,
   input  logic        rst,
   input  logic        backpressure_in,
   output logic        backpressure_out,
   input  logic        stream_in_TLAST,
   input  logic        stream_in_TVALID,
   output logic        stream_in_TREADY,
   input  logic [31:0] stream_in_TDATA,
   input  logic  [4:0] stream_in_TKEEP,
   output logic        stream_out_TLAST,
   output logic        stream_out_TVALID,
   input  logic        stream_out_TREADY,
   output logic [31:0] stream_out_TDATA,
   output logic  [3:0] stream_out_TKEEP
);

assign stream_out_TVALID = stream_in_TVALID;
assign stream_out_TLAST  = stream_in_TLAST;
assign stream_out_TKEEP  = stream_in_TKEEP;
assign stream_out_TDATA  = stream_in_TDATA;
assign stream_in_TREADY = stream_out_TREADY;

endmodule

