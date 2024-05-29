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
// Date        : Sept 29 2022
// Description : Lightweight NoC to be instantiated
//                in Tile 
// File        : tile_noc.sv
//
// LOCAL | LEFT | TOP | RIGHT | BOTTOM
//   4   |  3   |  2  |  1    |    0
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module tile_noc #(
   //- For tile memory manager
   parameter BIG    = 0,
   parameter OFFSET = 0,
   parameter LEVEL  = 0,
   //- For Dispatcher
   parameter DISPATCHER = 0,
   parameter END = 0,
   //- For everyone
   parameter XY_SZ  = 3,
   parameter BW     = 32,
   parameter BWB    = 4
)(
   input  logic                 clk_line,
   input  logic                 clk_line_rst_high,
   input  logic                 clk_line_rst_low,   //-LPGG
   input  logic [(2*XY_SZ)-1:0] HsrcId,
   input  logic           [3:0] stream_in_TVALID,
   input  logic      [4*BW-1:0] stream_in_TDATA,
   input  logic     [4*BWB-1:0] stream_in_TKEEP,
   input  logic           [3:0] stream_in_TLAST,
   output logic           [3:0] stream_in_TREADY,
   output logic           [3:0] stream_out_TVALID,
   output logic      [4*BW-1:0] stream_out_TDATA,
   output logic     [4*BWB-1:0] stream_out_TKEEP,
   output logic           [3:0] stream_out_TLAST,
   input  logic           [3:0] stream_out_TREADY,
   input  logic                 stream_in_local_in_TVALID,
   output logic                 stream_in_local_in_TREADY,
   input  logic        [BW-1:0] stream_in_local_in_TDATA,
   input  logic       [BWB-1:0] stream_in_local_in_TKEEP,
   input  logic                 stream_in_local_in_TLAST,
   output logic                 stream_out_local_out_TVALID,
   input  logic                 stream_out_local_out_TREADY,
   output logic        [BW-1:0] stream_out_local_out_TDATA,
   output logic       [BWB-1:0] stream_out_local_out_TKEEP,
   output logic                 stream_out_local_out_TLAST
);

logic [2:0] left_tdest;
logic [2:0] top_tdest;
logic [2:0] bottom_tdest;
logic [2:0] local_tdest;
logic [2:0] right_tdest;
                       
logic [2:0] myY;
logic [2:0] myX;

logic       [3:0] stream_in_TVALID_d;
logic  [4*BW-1:0] stream_in_TDATA_d;
logic [4*BWB-1:0] stream_in_TKEEP_d;
logic       [3:0] stream_in_TLAST_d;

logic           stream_in_local_in_TVALID_d;
logic  [BW-1:0] stream_in_local_in_TDATA_d;
logic [BWB-1:0] stream_in_local_in_TKEEP_d;
logic           stream_in_local_in_TLAST_d;

assign myY = HsrcId[5:3];
assign myX = HsrcId[2:0];
 
logic [4:0] grant_left;
logic [4:0] grant_top;
logic [4:0] grant_right;
logic [4:0] grant_bottom;
logic [4:0] grant_local;

assign grant_local[4]  = 1'b0;
assign grant_left[3]   = 1'b0; 
assign grant_top[2]    = 1'b0; 
assign grant_right[1]  = 1'b0; 
assign grant_bottom[0] = 1'b0;

in_dest#(
   .XY_SZ (XY_SZ),
   .BIG   (BIG),
   .OFFSET (OFFSET),
   .LEVEL (LEVEL) 
) in_dest_left(
   .clk_line           (clk_line),
   .rst                (clk_line_rst_low),
   .myX                (myX), 
   .myY                (myY),
   .stream_in_TVALID   (stream_in_TVALID[3]),
   .stream_in_TLAST    (stream_in_TLAST[3]),
   .stream_in_TDATA    (stream_in_TDATA[4*BW-1:3*BW]),
   .stream_in_TKEEP    (stream_in_TKEEP[4*BWB-1:3*BWB]),
   .grant              ({grant_local[3],1'b0,grant_top[3],grant_right[3],grant_bottom[3]}),
   .stream_in_TVALID_d (stream_in_TVALID_d[3]),
   .stream_in_TLAST_d  (stream_in_TLAST_d[3]),
   .stream_in_TDATA_d  (stream_in_TDATA_d[4*BW-1:3*BW]),
   .stream_in_TKEEP_d  (stream_in_TKEEP_d[4*BWB-1:3*BWB]),
   .tdest              (left_tdest),
   .stream_in_TREADY   (stream_in_TREADY[3]));


in_dest#(
   .XY_SZ  (XY_SZ),
   .BIG    (BIG),
   .OFFSET (OFFSET),
   .LEVEL  (LEVEL) 
)in_dest_top(
   .clk_line           (clk_line),
   .rst                (clk_line_rst_low),
   .myX                (myX), 
   .myY                (myY),
   .stream_in_TVALID   (stream_in_TVALID[2]),
   .stream_in_TLAST    (stream_in_TLAST[2]),
   .stream_in_TDATA    (stream_in_TDATA[3*BW-1:2*BW]),
   .stream_in_TKEEP    (stream_in_TKEEP[3*BWB-1:2*BWB]),
   .grant              ({grant_local[2],grant_left[2],1'b0,grant_right[2],grant_bottom[2]}),
   .stream_in_TVALID_d (stream_in_TVALID_d[2]),
   .stream_in_TLAST_d  (stream_in_TLAST_d[2]),
   .stream_in_TDATA_d  (stream_in_TDATA_d[3*BW-1:2*BW]),
   .stream_in_TKEEP_d  (stream_in_TKEEP_d[3*BWB-1:2*BWB]),
   .tdest              (top_tdest),
   .stream_in_TREADY   (stream_in_TREADY[2]));

in_dest#(
   .XY_SZ (XY_SZ),
   .BIG   (BIG),
   .OFFSET (OFFSET),
   .LEVEL (LEVEL) 
)in_dest_right(
   .clk_line           (clk_line),
   .rst                (clk_line_rst_low),
   .myX                (myX), 
   .myY                (myY),
   .stream_in_TVALID   (stream_in_TVALID[1]),
   .stream_in_TLAST    (stream_in_TLAST[1]),
   .stream_in_TDATA    (stream_in_TDATA[2*BW-1:BW]),
   .stream_in_TKEEP    (stream_in_TKEEP[2*BWB-1:BWB]),
   .grant              ({grant_local[1],grant_left[1],grant_top[1],1'b0,grant_bottom[1]}),
   .stream_in_TVALID_d (stream_in_TVALID_d[1]),
   .stream_in_TLAST_d  (stream_in_TLAST_d[1]),
   .stream_in_TDATA_d  (stream_in_TDATA_d[2*BW-1:BW]),
   .stream_in_TKEEP_d  (stream_in_TKEEP_d[2*BWB-1:BWB]),
   .tdest              (right_tdest),
   .stream_in_TREADY   (stream_in_TREADY[1]));

in_dest#(
   .XY_SZ (XY_SZ),
   .BIG   (BIG),
   .OFFSET (OFFSET),
   .DISPATCHER (DISPATCHER),
   .END (END),
   .LEVEL (LEVEL) 
)in_dest_bottom(
   .clk_line           (clk_line),
   .rst                (clk_line_rst_low),
   .myX                (myX), 
   .myY                (myY),
   .stream_in_TVALID   (stream_in_TVALID[0]),
   .stream_in_TLAST    (stream_in_TLAST[0]),
   .stream_in_TDATA    (stream_in_TDATA[BW-1:0]),
   .stream_in_TKEEP    (stream_in_TKEEP[BWB-1:0]),
   .grant              ({grant_local[0],grant_left[0],grant_top[0],grant_right[0],1'b0}),
   .stream_in_TVALID_d (stream_in_TVALID_d[0]),
   .stream_in_TLAST_d  (stream_in_TLAST_d[0]),
   .stream_in_TDATA_d  (stream_in_TDATA_d[BW-1:0]),
   .stream_in_TKEEP_d  (stream_in_TKEEP_d[BWB-1:0]),
   .tdest              (bottom_tdest),
   .stream_in_TREADY   (stream_in_TREADY[0]));

in_dest#(
   .XY_SZ (XY_SZ),
   .BIG   (BIG),
   .OFFSET (OFFSET),
   .LEVEL (LEVEL) 
)in_dest_local(
   .clk_line           (clk_line),
   .rst                (clk_line_rst_low),
   .myX                (myX),
   .myY                (myY),
   .stream_in_TVALID   (stream_in_local_in_TVALID),
   .stream_in_TLAST    (stream_in_local_in_TLAST),
   .stream_in_TDATA    (stream_in_local_in_TDATA),
   .stream_in_TKEEP    (stream_in_local_in_TKEEP),
   .grant              ({1'b0,grant_left[4],grant_top[4],grant_right[4],grant_bottom[4]}),
   .stream_in_TVALID_d (stream_in_local_in_TVALID_d),
   .stream_in_TLAST_d  (stream_in_local_in_TLAST_d),
   .stream_in_TDATA_d  (stream_in_local_in_TDATA_d),
   .stream_in_TKEEP_d  (stream_in_local_in_TKEEP_d),
   .tdest              (local_tdest),
   .stream_in_TREADY   (stream_in_local_in_TREADY));


grant_out#(
   .ID (3'd4)
) grant_out_left(
   .clk_line               (clk_line),
   .rst                    (clk_line_rst_low),
   //- local, top, right, bottom
   .stream_in_TVALID       ({stream_in_local_in_TVALID_d,stream_in_TVALID_d[2:0]}),
   .stream_in_TDATA        ({stream_in_local_in_TDATA_d,stream_in_TDATA_d[(3*BW)-1:0]}),   
   .stream_in_TKEEP        ({stream_in_local_in_TKEEP_d,stream_in_TKEEP_d[(3*BWB)-1:0]}), 
   .stream_in_TLAST        ({stream_in_local_in_TLAST_d,stream_in_TLAST_d[2:0]}),       
   .tdest                  ({local_tdest,top_tdest,right_tdest,bottom_tdest}),
   .grant                  ({grant_left[4],grant_left[2:0]}),
   //- Left 
   .stream_out_TVALID      (stream_out_TVALID[3]),
   .stream_out_TDATA       (stream_out_TDATA[(4*BW)-1:(3*BW)]),
   .stream_out_TKEEP       (stream_out_TKEEP[(4*BWB)-1:(3*BWB)]),
   .stream_out_TLAST       (stream_out_TLAST[3]),
   .stream_out_TREADY      (stream_out_TREADY[3])); //- Input

grant_out#(
   .ID (3'd3)
) grant_out_top(
   .clk_line               (clk_line),
   .rst                    (clk_line_rst_low),
   //- local, left, right, bottom
   .stream_in_TVALID       ({stream_in_local_in_TVALID_d,stream_in_TVALID_d[3],stream_in_TVALID_d[1:0]}),
   .stream_in_TDATA        ({stream_in_local_in_TDATA_d,stream_in_TDATA_d[4*BW-1:3*BW],stream_in_TDATA_d[2*BW-1:0]}),   
   .stream_in_TKEEP        ({stream_in_local_in_TKEEP_d,stream_in_TKEEP_d[4*BWB-1:3*BWB],stream_in_TKEEP_d[2*BWB-1:0]}), 
   .stream_in_TLAST        ({stream_in_local_in_TLAST_d,stream_in_TLAST_d[3],stream_in_TLAST_d[1:0]}),       
   .tdest                  ({local_tdest,left_tdest,right_tdest,bottom_tdest}),
   .grant                  ({grant_top[4:3],grant_top[1:0]}),
   //- Top
   .stream_out_TVALID      (stream_out_TVALID[2]),
   .stream_out_TDATA       (stream_out_TDATA[3*BW-1:2*BW]),
   .stream_out_TKEEP       (stream_out_TKEEP[3*BWB-1:2*BWB]),
   .stream_out_TLAST       (stream_out_TLAST[2]),
   .stream_out_TREADY      (stream_out_TREADY[2])); //- Input

grant_out#(
   .ID (3'd2)
) grant_out_right(
   .clk_line               (clk_line),
   .rst                    (clk_line_rst_low),
   //- local, left, top, bottom
   .stream_in_TVALID       ({stream_in_local_in_TVALID_d,stream_in_TVALID_d[3:2],stream_in_TVALID_d[0]}),
   .stream_in_TDATA        ({stream_in_local_in_TDATA_d,stream_in_TDATA_d[4*BW-1:2*BW],stream_in_TDATA_d[1*BW-1:0]}),   
   .stream_in_TKEEP        ({stream_in_local_in_TKEEP_d,stream_in_TKEEP_d[4*BWB-1:2*BWB],stream_in_TKEEP_d[1*BWB-1:0]}), 
   .stream_in_TLAST        ({stream_in_local_in_TLAST_d,stream_in_TLAST_d[3:2],stream_in_TLAST_d[0]}),       
   .tdest                  ({local_tdest,left_tdest,top_tdest,bottom_tdest}),
   .grant                  ({grant_right[4:2],grant_right[0]}),
   //- Right
   .stream_out_TVALID      (stream_out_TVALID[1]),
   .stream_out_TDATA       (stream_out_TDATA[2*BW-1:BW]),
   .stream_out_TKEEP       (stream_out_TKEEP[2*BWB-1:BWB]),
   .stream_out_TLAST       (stream_out_TLAST[1]),
   .stream_out_TREADY      (stream_out_TREADY[1]));

grant_out#(
   .ID (3'd1)
) grant_out_bottom(
   .clk_line               (clk_line),
   .rst                    (clk_line_rst_low),
   //- local, left, top, right
   .stream_in_TVALID       ({stream_in_local_in_TVALID_d,stream_in_TVALID_d[3:1]}),
   .stream_in_TDATA        ({stream_in_local_in_TDATA_d,stream_in_TDATA_d[4*BW-1:1*BW]}),   
   .stream_in_TKEEP        ({stream_in_local_in_TKEEP_d,stream_in_TKEEP_d[4*BWB-1:1*BWB]}), 
   .stream_in_TLAST        ({stream_in_local_in_TLAST_d,stream_in_TLAST_d[3:1]}),       
   .tdest                  ({local_tdest,left_tdest,top_tdest,right_tdest}),
   .grant                  (grant_bottom[4:1]),
   //- Bottom
   .stream_out_TVALID      (stream_out_TVALID[0]),
   .stream_out_TDATA       (stream_out_TDATA[BW-1:0]),
   .stream_out_TKEEP       (stream_out_TKEEP[BWB-1:0]),
   .stream_out_TLAST       (stream_out_TLAST[0]),
   .stream_out_TREADY      (stream_out_TREADY[0]));

grant_out#(
   .ID (3'd5)
) grant_out_local(
  .clk_line               (clk_line),
  .rst                    (clk_line_rst_low),
  //- left, top, right, bottom
  .stream_in_TVALID       (stream_in_TVALID_d),
  .stream_in_TDATA        (stream_in_TDATA_d),   
  .stream_in_TKEEP        (stream_in_TKEEP_d), 
  .stream_in_TLAST        (stream_in_TLAST_d),       
  .tdest                  ({left_tdest,top_tdest,right_tdest,bottom_tdest}),
  .grant                  (grant_local[3:0]),
  //- Local
  .stream_out_TVALID      (stream_out_local_out_TVALID),
  .stream_out_TDATA       (stream_out_local_out_TDATA),
  .stream_out_TKEEP       (stream_out_local_out_TKEEP),
  .stream_out_TLAST       (stream_out_local_out_TLAST),
  .stream_out_TREADY      (stream_out_local_out_TREADY));

endmodule

