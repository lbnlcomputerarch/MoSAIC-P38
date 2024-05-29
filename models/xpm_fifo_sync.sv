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
// Date        : November 2023
// Description : Simple memory model for icarus
// File        : xpm_fifo_sync.sv
// Notes       : 
//  - Only valid for icarus simulation.
//  - Unused ports added for compatibility with the
//    Xilinx macro
//  - For this simple model 
//    READ_DATA_WIDTH_A = WRITE_DATA_WIDTH_A
////////////////////////////////////////////////////

module xpm_fifo_sync #(
   parameter FULL_RESET_VALUE = 0,
    // Common module parameters
    parameter FIFO_MEMORY_TYPE     = "auto",
    parameter ECC_MODE             = "no_ecc",
    parameter RELATED_CLOCKS       = 0,
    parameter SIM_ASSERT_CHK       = 0,
    parameter CASCADE_HEIGHT       = 0,
    parameter FIFO_WRITE_DEPTH     = 8,
    parameter WRITE_DATA_WIDTH     = 3,
    parameter WR_DATA_COUNT_WIDTH  = 8,
    parameter USE_ADV_FEATURES     = "0707",
    parameter READ_MODE            = "std",
    parameter FIFO_READ_LATENCY    = 1,
    parameter READ_DATA_WIDTH      = 8,
    parameter RD_DATA_COUNT_WIDTH  = 3,
    parameter DOUT_RESET_VALUE     = "0",
    parameter CDC_SYNC_STAGES      = 4,
    parameter WAKEUP_TIME          = 0
)(
    // Common module ports
   input  logic sleep,
   input  logic rst,
    // Write Domain ports
   input  logic wr_clk,
   input  logic wr_en,
   input  logic [WRITE_DATA_WIDTH-1:0] din,
   output logic full,
   output logic prog_full,
   output logic [WR_DATA_COUNT_WIDTH-1:0] wr_data_count,
   output logic overflow,
   output logic wr_rst_busy,
   output logic almost_full,
   output logic wr_ack,
    // Read Domain ports
   input  logic rd_clk,
   input  logic rd_en,
   output logic [READ_DATA_WIDTH-1:0] dout,
   output logic empty,
   output logic prog_empty,
   output logic [RD_DATA_COUNT_WIDTH-1:0] rd_data_count,
   output logic underflow,
   output logic rd_rst_busy,
   output logic almost_empty,
   output logic data_valid,
    // ECC Related ports
   input  logic injectsbiterr,
   input  logic injectdbiterr,
   output logic sbiterr,
   output logic dbiterr);

localparam  ADDR_W = $clog2(FIFO_WRITE_DEPTH);

logic  [WRITE_DATA_WIDTH-1:0]  mem [0:FIFO_WRITE_DEPTH-1];
logic  [ADDR_W-1:0] addra;
logic  [ADDR_W-1:0] addra_sync;
logic  [ADDR_W-1:0] addrb;
logic  [ADDR_W-1:0] addrb_sync;

always @(posedge wr_clk)
   if (rst) addra <= 'h0;
   else if (wr_en) addra <= addra + 'h1;

always @(posedge rd_clk)
   if (rst) addrb <= 'h0;
   else if (rd_en) addrb <= addrb + 'h1;
  
always @(posedge wr_clk)
   if (wr_en) mem[addra] <= din;

always @(posedge rd_clk) begin
   if (rst) dout <= 'h0;
   else if (rd_en) dout <= mem[addrb];
end


assign empty = addra_sync >= addrb ? addra_sync - addrb == 0 : addra_sync + FIFO_WRITE_DEPTH - addrb <= 1;
assign full = addra_sync > addrb ? addra_sync - addrb == FIFO_WRITE_DEPTH - 1 : addrb - addra_sync == 'h1; 

xpm_cdc_array_single#(
   .WIDTH(ADDR_W),
   .SIM_ASSERT_CHK(0) //- FIXME!!
) cdc_sync1 (
   // Module ports
   .src_clk  (wr_clk),
   .src_in   (addra),
   .dest_clk (rd_clk),
   .dest_out (addra_sync));

    
xpm_cdc_array_single#(
   .WIDTH(ADDR_W),
   .SIM_ASSERT_CHK(0) //- FIXME!!
) cdc_sync2 (
   // Module ports
   .src_clk  (rd_clk),
   .src_in   (addrb),
   .dest_clk (wr_clk),
   .dest_out (addrb_sync));


endmodule
