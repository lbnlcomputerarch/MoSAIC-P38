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
// Description : Receives packets from tiles in column (N-1)
// File        : Gatherer.sv
// Notes       : 
//  - From USS by Farzad F. (LBL), and Chris N. (AMD). 
//  - The connections were modified such that the array of tiles 
//    can be instantitated in a generate loop.
//  - FIXME: Current dispatcher/gatherer only has 
//    ports for 4 tiles. Ideally it should 
//    connect to all the tiles on the 
//    left/right.
//  - FIXME: might have trouble when TREADY goes low!
//  - FIXME: What to do with notify_out_metadata_out 
////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

module Gatherer#(
  parameter BW  = 32,
  parameter BWB =  4
)(
   input  logic               clk_line,
   input  logic               rst,
   input  logic         [3:0] stream_in_packet_TVALID,
   input  logic  [(BW*4)-1:0] stream_in_packet_TDATA,
   input  logic [(BWB*4)-1:0] stream_in_packet_TKEEP,
   input  logic         [3:0] stream_in_packet_TLAST,
   output logic         [3:0] stream_in_packet_TREADY,
   output logic               stream_out_packet_TVALID,
   output logic      [BW-1:0] stream_out_packet_TDATA,
   output logic     [BWB-1:0] stream_out_packet_TKEEP,
   output logic               stream_out_packet_TLAST,
   input  logic               stream_out_packet_TREADY,
   output logic               notify_out_metadata_out_VALID,
   output logic       [127:0] notify_out_metadata_out_DATA
);


logic     [1:0] counter;
logic  [BW-1:0] stream_in_packet_TDATA_a [0:3];
logic [BWB-1:0] stream_in_packet_TKEEP_a [0:3];

assign stream_in_packet_TREADY[0] = stream_out_packet_TREADY;
assign stream_in_packet_TREADY[1] = stream_out_packet_TREADY;
assign stream_in_packet_TREADY[2] = stream_out_packet_TREADY;
assign stream_in_packet_TREADY[3] = stream_out_packet_TREADY;
   
always @(posedge clk_line) begin
  if (rst) begin
    counter <= 2'd0;
  end else if ((stream_in_packet_TVALID[0] && stream_in_packet_TLAST[0]) || 
               (stream_in_packet_TVALID[1] && stream_in_packet_TLAST[1]) ||
               (stream_in_packet_TVALID[2] && stream_in_packet_TLAST[2]) ||
               (stream_in_packet_TVALID[3] && stream_in_packet_TLAST[3])) begin
    counter <= counter +1;
  end else begin
   counter <= counter; 
  end
end


   
always @(posedge clk_line) begin
    notify_out_metadata_out_VALID <= 0;
    notify_out_metadata_out_DATA  <= 128'h0;
    case (counter)
    0 : begin
      stream_out_packet_TVALID <= stream_in_packet_TVALID[0];
      stream_out_packet_TDATA  <= stream_in_packet_TDATA_a[0];
      stream_out_packet_TKEEP  <= stream_in_packet_TKEEP_a[0];
      stream_out_packet_TLAST  <= stream_in_packet_TLAST[0];
    end
    1 : begin 
      stream_out_packet_TVALID <= stream_in_packet_TVALID[1];
      stream_out_packet_TDATA  <= stream_in_packet_TDATA_a[1];
      stream_out_packet_TKEEP  <= stream_in_packet_TKEEP_a[1];
      stream_out_packet_TLAST  <= stream_in_packet_TLAST[1];
    end   
    2 : begin
      stream_out_packet_TVALID <= stream_in_packet_TVALID[2];
      stream_out_packet_TDATA  <= stream_in_packet_TDATA_a[2];
      stream_out_packet_TKEEP  <= stream_in_packet_TKEEP_a[2];
      stream_out_packet_TLAST  <= stream_in_packet_TLAST[2];
    end
    3 : begin 
      stream_out_packet_TVALID <= stream_in_packet_TVALID[3];
      stream_out_packet_TDATA  <= stream_in_packet_TDATA_a[3];
      stream_out_packet_TKEEP  <= stream_in_packet_TKEEP_a[3];
      stream_out_packet_TLAST  <= stream_in_packet_TLAST[3];
    end   
  endcase
end // always @ (posedge clk_line)


genvar i;
generate
  for (i=0; i<4; i=i+1) begin
    assign stream_in_packet_TDATA_a[i] = stream_in_packet_TDATA[(BW*(i+1))-1:BW*i];
    assign stream_in_packet_TKEEP_a[i] = stream_in_packet_TKEEP[(BWB*(i+1))-1:BWB*i];
  end
endgenerate

endmodule

