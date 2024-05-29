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
// Date        : Oct 10 2023
// Description : NoC data is placed in a small FIFO  
// File        : noc_buffer_out.sv
// Notes       :
//    -10/21/2022 Cneely replaced minififo implementation 
//     with IP catalog FIFO generator
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps
`include "global_defines.sv"

module noc_buffer_out#(
   parameter ADDR_W           = 8,
   parameter USE_IP           = 0
)(
   input  logic        clk_in,
   input  logic        clk_out,
   input  logic        clk_in_rst_low,
   input  logic        clk_in_rst_high,
   input  logic        clk_out_rst_low,
   //- Input Interface
   (*mark_debug = "true" *) input  logic        stream_in_TVALID,
   (*mark_debug = "true" *) input  logic [31:0] stream_in_TDATA,
   (*mark_debug = "true" *) input  logic [ 3:0] stream_in_TKEEP, 
   (*mark_debug = "true" *) input  logic        stream_in_TLAST,
   (*mark_debug = "true" *) output logic        stream_in_TREADY,
   //- Output Interface
   (*mark_debug = "true" *) output logic        stream_out_TVALID,
   (*mark_debug = "true" *) output logic [31:0] stream_out_TDATA,
   (*mark_debug = "true" *) output logic [ 3:0] stream_out_TKEEP, 
   (*mark_debug = "true" *) output logic        stream_out_TLAST,
   (*mark_debug = "true" *) input  logic        stream_out_TREADY
);


logic [36:0] din;
logic [36:0] dout;
logic        wr_en;
logic        rd_en;
logic        full;
logic        almost_full;
(*mark_debug = "true" *) logic        empty;
logic        wr_rst_busy;
logic        rd_rst_busy;
(*mark_debug = "true" *) logic [1:0]  state;
logic [1:0]  next_state;

(*mark_debug = "true" *) logic [ADDR_W-1:0] ctr_in;
logic [ADDR_W-1:0] ctr_in_sync;
(*mark_debug = "true" *) logic [ADDR_W-1:0] ctr_out;

assign din = {stream_in_TLAST,stream_in_TKEEP,stream_in_TDATA};

/*
assign wr_en = stream_in_TVALID & ~full;
assign stream_in_TREADY = ~full;
*/
logic [ADDR_W-1:0] wr_data_count;
logic [ADDR_W-1:0] rd_data_count;
always @(posedge clk_in) begin
   if (~clk_in_rst_low) 
      stream_in_TREADY <= 1'b1;
   else
      stream_in_TREADY <= ~full;
end

assign wr_en = stream_in_TVALID & stream_in_TREADY;
always @(posedge clk_in) begin
   if (~clk_in_rst_low) ctr_in <= 'h0;
   else if (stream_in_TVALID & stream_in_TLAST & stream_in_TREADY) ctr_in <= ctr_in + 1;
end

always @(posedge clk_out) begin
  if (~clk_out_rst_low) ctr_out <= 'h0;
  else if (stream_out_TVALID & stream_out_TLAST & stream_out_TREADY) ctr_out <= ctr_out + 1;
end

always @(posedge clk_out) begin
  if (~clk_out_rst_low) state <= 'h0;
  else state <= next_state;
end

xpm_cdc_array_single#(
  .WIDTH(ADDR_W),
  .SIM_ASSERT_CHK(`SIM_ASSERT_CHK)
) valid_cdc (
  // Module ports
  .src_clk  (clk_in),
  .src_in   (ctr_in),
  .dest_clk (clk_out),
  .dest_out (ctr_in_sync));

always @(*) begin
   //- State
   next_state = state;
   
   stream_out_TVALID = 1'b0;
   rd_en = 1'b0;

   case (state)
      0: begin
         if (ctr_in_sync != ctr_out & ~empty) begin
         //if (ctr_in_sync != ctr_out) begin
            next_state = 1;
            rd_en = 1;
         end
      end
      1: begin
         stream_out_TVALID = 1'b1;
         if (stream_out_TREADY) begin
            if (stream_out_TLAST)
               next_state = 0;
            else rd_en = 1;
         end else if (stream_out_TLAST)
            next_state = 2;
      end
      2: begin
         stream_out_TVALID = 1'b1;
         if (stream_out_TREADY)
            next_state = 0;
      end
   endcase
end

assign stream_out_TLAST  = dout[36];
assign stream_out_TDATA  = dout[31:0];
assign stream_out_TKEEP  = dout[35:32];

generate
   if (USE_IP == 1) begin
      fifo_generator_0 fifo_generator_0 (
         .srst        (clk_in_rst_high),  // input wire srst
         .wr_clk      (clk_in),           // input wire wr_clk
         .rd_clk      (clk_out),          // input wire rd_clk
         .din         (din),              // input wire [36 : 0] din
         .wr_en       (wr_en),            // input wire wr_en
         .rd_en       (rd_en),            // input wire rd_en
         .dout        (dout),             // output wire [36 : 0] dout
         .full        (full),             // output wire full
         .empty       (empty),            // output wire empty
         .wr_rst_busy (wr_rst_busy),      // output wire wr_rst_busy
         .rd_rst_busy (rd_rst_busy)       // output wire rd_rst_busy
      );
   end else begin

      localparam DATA_W            = 37;
      localparam FIFO_READ_LATENCY = 1;
      localparam CDC_SYNC_STAGES   = 2;
      localparam FIFO_WRITE_DEPTH  = 1 << ADDR_W;
      localparam FIFO_FULL_THRESH  = 40;

      xpm_fifo_async# (
         // Common module parameters
         .FIFO_MEMORY_TYPE     ( "auto"),
         .ECC_MODE             ( "no_ecc"),
         .RELATED_CLOCKS       ( 0),
         .SIM_ASSERT_CHK       ( 0),
         .CASCADE_HEIGHT       ( 0),
         .FIFO_WRITE_DEPTH     ( FIFO_WRITE_DEPTH),
         .WRITE_DATA_WIDTH     ( DATA_W),
         .WR_DATA_COUNT_WIDTH  ( ADDR_W),
         .PROG_FULL_THRESH     ( FIFO_FULL_THRESH),
         .USE_ADV_FEATURES     ( "070F"),
         .READ_MODE            ( "std"),
         .FIFO_READ_LATENCY    ( FIFO_READ_LATENCY),
         .READ_DATA_WIDTH      ( DATA_W),
         .RD_DATA_COUNT_WIDTH  ( ADDR_W),
         //.PROG_EMPTY_THRESH    ( 10),
         .DOUT_RESET_VALUE     ( "0"),
         .CDC_SYNC_STAGES      ( CDC_SYNC_STAGES),
         .WAKEUP_TIME          ( 0)
      ) xpm_fifo_async (
         // Common module ports
         .sleep          (1'b0),
         .rst            (clk_in_rst_high),
         // Write Domain ports
         .wr_clk         (clk_in),
         .wr_en          (wr_en),
         .din            (din),
         .full           (full),
         .prog_full      (),
         .wr_data_count  (wr_data_count),
         .overflow       (),
         .wr_rst_busy    (wr_rst_busy),
         .almost_full    (almost_full),
         .wr_ack         (),
         // Read Domain ports
         .rd_clk        (clk_out),
         .rd_en         (rd_en),
         .dout          (dout),
         .empty         (empty),
         .prog_empty    (),
         .rd_data_count (rd_data_count),
         .underflow     (),
         .rd_rst_busy   (rd_rst_busy),
         .almost_empty  (),
         .data_valid    (),
         // ECC Related ports
         .injectsbiterr (1'b0),
         .injectdbiterr (1'b0),
         .sbiterr       (),
         .dbiterr       ());
   end
endgenerate

endmodule
