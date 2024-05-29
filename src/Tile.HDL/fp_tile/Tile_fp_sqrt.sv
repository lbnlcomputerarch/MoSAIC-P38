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

////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : Nov 3 2023
// Description : Floating point tile 
// File        : Tile_fp_sqrt.sv
////////////////////////////////////////////////

`timescale 1 ps / 1 ps

module Tile_fp_sqrt#(
   parameter BW  = 32,
   parameter BWB = BW/8,
   parameter AXI_ADDR = 8,
   parameter NOC_BUFFER_ADDR_W = 8
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

Tile_fp#(
   .TYPE ("SQRT"),
   .AXI_ADDR (AXI_ADDR),
   .NOC_BUFFER_ADDR_W (NOC_BUFFER_ADDR_W)
) tile_fp_adder(
   .plain_start_of_processing  (sop_plain_start_of_processing),
   .stream_in_TVALID           (stream_in_TVALID),
   .stream_in_TREADY           (stream_in_TREADY),
   .stream_in_TDATA            (stream_in_TDATA),
   .stream_in_TKEEP            (stream_in_TKEEP),
   .stream_in_TLAST            (stream_in_TLAST),
   .stream_out_TVALID          (stream_out_TVALID),
   .stream_out_TREADY          (stream_out_TREADY),
   .stream_out_TDATA           (stream_out_TDATA),
   .stream_out_TKEEP           (stream_out_TKEEP),
   .stream_out_TLAST           (stream_out_TLAST),
   //- AXI bus
   .control_S_AXI_AWADDR       (control_S_AXI_AWADDR),
   .control_S_AXI_AWVALID      (control_S_AXI_AWVALID),
   .control_S_AXI_AWREADY      (control_S_AXI_AWREADY),
   .control_S_AXI_WDATA        (control_S_AXI_WDATA),
   .control_S_AXI_WSTRB        (control_S_AXI_WSTRB),
   .control_S_AXI_WVALID       (control_S_AXI_WVALID),
   .control_S_AXI_WREADY       (control_S_AXI_WREADY),
   .control_S_AXI_BRESP        (control_S_AXI_BRESP),
   .control_S_AXI_BVALID       (control_S_AXI_BVALID),
   .control_S_AXI_BREADY       (control_S_AXI_BREADY),
   .control_S_AXI_ARADDR       (control_S_AXI_ARADDR),
   .control_S_AXI_ARVALID      (control_S_AXI_ARVALID),
   .control_S_AXI_ARREADY      (control_S_AXI_ARREADY),
   .control_S_AXI_RDATA        (control_S_AXI_RDATA),
   .control_S_AXI_RRESP        (control_S_AXI_RRESP),
   .control_S_AXI_RVALID       (control_S_AXI_RVALID),
   .control_S_AXI_RREADY       (control_S_AXI_RREADY),
   //- Clock and reset
   .clk_control                (clk_control),
   .clk_line                   (clk_line),
   .clk_line_rst_high          (clk_line_rst_high),
   .clk_line_rst_low           (clk_line_rst_low),
   .clk_control_rst_low        (clk_control_rst_low),
   .clk_control_rst_high       (clk_control_rst_high));

endmodule

