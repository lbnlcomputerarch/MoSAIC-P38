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
// Description : Distributes packets among tiles in column 0
// File        : Dispatcher.sv
// Notes       : 
//  - FIXME: Current dispatcher/gatherer only has 
//    ports for 4 tiles. Ideally it should 
//    connect to all the tiles on the 
//    left/right.
//  - FIXME: What to do with notify_in_metadata_in ? 
////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

module Dispatcher#(
  parameter END = 3,
  parameter BW  = 32,
  parameter BWB =  BW/8
)(
   input  logic           clk_line,
   input  logic           clk_line_rst_high,
   input  logic           clk_line_rst_low,
   input  logic           stream_in_packet_TVALID,
   input  logic  [BW-1:0] stream_in_packet_TDATA,
   input  logic [BWB-1:0] stream_in_packet_TKEEP,
   input  logic           stream_in_packet_TLAST,
   output logic           stream_in_packet_TREADY,

   output logic         [3:0] stream_out_packet_TVALID,
   output logic         [3:0] stream_out_packet_TLAST,
   output logic [(BWB*4)-1:0] stream_out_packet_TKEEP,
   output logic  [(BW*4)-1:0] stream_out_packet_TDATA,
   input logic          [3:0] stream_out_packet_TREADY,

   input logic notify_in_metadata_in_VALID,
   input logic [127:0] notify_in_metadata_in_DATA
);

localparam FILLW  = BW*4 - BW;
localparam FILLWB = BWB*4 - BWB;
logic [FILLW-1:0] filler;
logic [FILLWB-1:0] fillerb;
assign filler = 'h0;
assign fillerb = 'h0;

logic         [3:0] stream_in_TREADY_t;
logic         [3:0] stream_out_TVALID;
logic         [3:0] stream_out_TLAST;
logic [(BWB*4)-1:0] stream_out_TKEEP;
logic  [(BW*4)-1:0] stream_out_TDATA;
logic         [3:0] stream_out_TREADY;

logic           stream_out_local_out_TVALID;
logic           stream_out_local_out_TLAST;
logic [BWB-1:0] stream_out_local_out_TKEEP;
logic  [BW-1:0] stream_out_local_out_TDATA;
logic           stream_out_local_out_TREADY;


assign stream_in_packet_TREADY = stream_in_TREADY_t[0];

assign stream_out_packet_TVALID = {stream_out_local_out_TVALID,stream_out_TVALID[3:1]};
assign stream_out_packet_TLAST  = {stream_out_local_out_TLAST,stream_out_TLAST[3:1]};
assign stream_out_packet_TDATA  = {stream_out_local_out_TDATA,stream_out_TDATA[(4*BW)-1:BW]};
assign stream_out_packet_TKEEP  = {stream_out_local_out_TKEEP,stream_out_TKEEP[(4*BWB)-1:BWB]};

assign stream_out_TREADY = {stream_out_packet_TREADY[2:0],1'b0};
assign stream_out_local_out_TREADY = stream_out_packet_TREADY[3];

tile_noc #(
   .DISPATCHER (1),
   .BW  (BW),
   .END (END)
)tile_noc (
  .HsrcId                      (6'h0), 
  .stream_in_TVALID            ({3'h0,stream_in_packet_TVALID}),
  .stream_in_TREADY            (stream_in_TREADY_t),          //- Output
  .stream_in_TDATA             ({filler,stream_in_packet_TDATA}),
  .stream_in_TKEEP             ({fillerb,stream_in_packet_TKEEP}),
  .stream_in_TLAST             ({3'h0,stream_in_packet_TLAST}),
  .stream_out_TVALID           (stream_out_TVALID),
  .stream_out_TREADY           (stream_out_TREADY),           //- Input
  .stream_out_TDATA            (stream_out_TDATA),
  .stream_out_TKEEP            (stream_out_TKEEP),
  .stream_out_TLAST            (stream_out_TLAST),
  .stream_out_local_out_TVALID (stream_out_local_out_TVALID),
  .stream_out_local_out_TREADY (stream_out_local_out_TREADY), //- Input
  .stream_out_local_out_TDATA  (stream_out_local_out_TDATA),
  .stream_out_local_out_TKEEP  (stream_out_local_out_TKEEP),
  .stream_out_local_out_TLAST  (stream_out_local_out_TLAST),
  .stream_in_local_in_TVALID   (1'b0),
  .stream_in_local_in_TREADY   (),
  .stream_in_local_in_TDATA    (32'h0),
  .stream_in_local_in_TKEEP    (4'h0),
  .stream_in_local_in_TLAST    (1'b0),
  .clk_line                    (clk_line ),
  .clk_line_rst_high           (clk_line_rst_high ),
  .clk_line_rst_low            (clk_line_rst_low)
);


endmodule

