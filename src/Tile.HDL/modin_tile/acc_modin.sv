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
// Author      : Laura Kallem
// Date        : Aug 5 2025
// Description : Modin accelerator instantiation, template from acc_scratchpad.sv
// File        : acc_modin.sv - instantiate odin w/ axi ctrl
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module acc_modin#(
   parameter OFFSET_SZ         = 12,
   parameter XY_SZ             =  3,
   parameter BW                = 32,
   parameter BWB               = BW/8,
   parameter NOC_BUFFER_ADDR_W =  8,
   parameter N = 256,
   parameter M = 8,
   parameter SCRATCHPAD_SIZE = (4*1024)
)(
  //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_line,
   input  logic       clk_ctrl_rst_low,
   input  logic       clk_line_rst_low,
   input  logic       clk_ctrl_rst_high,
   input  logic       clk_line_rst_high,
   input  logic [(XY_SZ*2)-1:0] HsrcId,     //- Tile identification
   
   //---NOC interface---//
   //- Input Interface
   input  logic           stream_in_TVALID,
   input  logic  [BW-1:0] stream_in_TDATA,
   input  logic [BWB-1:0] stream_in_TKEEP, 
   input  logic           stream_in_TLAST,
   output logic           stream_in_TREADY,  
   //- Output Interface
   input  logic           stream_out_TREADY,
   output logic           stream_out_TVALID,
   output logic  [BW-1:0] stream_out_TDATA,
   output logic [BWB-1:0] stream_out_TKEEP,
   output logic           stream_out_TLAST,
  //- AXI memory interface 
   input  logic        mem_valid_axi,
   input  logic [31:0] mem_addr_axi,
   input  logic [31:0] mem_wdata_axi, 
   input  logic        mem_wstrb_axi, 
   output logic [31:0] mem_rdata_axi,
   input  logic  [7:0] rvControl
);

logic           stream_in_TVALID_int;
logic  [BW-1:0] stream_in_TDATA_int;
logic [BWB-1:0] stream_in_TKEEP_int; 
logic           stream_in_TLAST_int;
logic           stream_in_TREADY_int; 

//- Memory and Memory Manager
(*mark_debug = "true" *) logic [BW-1:0] mm_mem_rdata;
(*mark_debug = "true" *) logic [BW-1:0] mm_mem_wdata;
(*mark_debug = "true" *) logic [31:0] mm_mem_addr;
(*mark_debug = "true" *) logic          mm_mem_wstrb; 
(*mark_debug = "true" *) logic          mm_mem_valid;

logic           stream_out_TVALID_int;
logic  [BW-1:0] stream_out_TDATA_int;
logic [BWB-1:0] stream_out_TKEEP_int; 
logic           stream_out_TLAST_int;
logic           stream_out_TREADY_int;

logic [11:0] scratchpad_counter;
logic [31:0] scratchpad_write_addr;

wire [7:0] AEROUT_ADDR; 
wire AEROUT_REQ;
wire AEROUT_ACK;
wire spy_idle;

logic rvRstN;

assign rvRstN = rvControl[0]; //1'b0;

noc_buffer_in#(
   .BW (BW),
   .ADDR_W (NOC_BUFFER_ADDR_W)
) noc_buffer(
   .clk_in            (clk_line),
   .clk_in_rst_high   (clk_line_rst_high),
   .clk_in_rst_low    (clk_line_rst_low),
   .clk_out           (clk_ctrl),
   .clk_out_rst_low   (clk_ctrl_rst_low),
   .stream_in_TVALID  (stream_in_TVALID),
   .stream_in_TDATA   (stream_in_TDATA),
   .stream_in_TKEEP   (stream_in_TKEEP),
   .stream_in_TLAST   (stream_in_TLAST),
   .stream_in_TREADY  (stream_in_TREADY),
   .stream_out_TVALID (stream_in_TVALID_int),
   .stream_out_TDATA  (stream_in_TDATA_int),
   .stream_out_TKEEP  (stream_in_TKEEP_int),
   .stream_out_TLAST  (stream_in_TLAST_int),
   .stream_out_TREADY (stream_in_TREADY_int)
);

noc_decoder#(
   .BW (BW)
) noc_decoder(
   //- Clock and reset
   .clk_ctrl         (clk_ctrl),
   //.clk_ctrl_rst_low (clk_ctrl_rst_low && rvRstN), 
   .clk_ctrl_rst_low (clk_ctrl_rst_low), 
   .clk_line         (clk_line),
   .clk_line_rst_low (clk_line_rst_low), 
   //- Tile identification
   .HsrcId           (HsrcId),
   //- NOC interface
   //- Input Interface: Switch writing to the memory manager 
   .stream_in_TVALID  (stream_in_TVALID_int),
   .stream_in_TDATA   (stream_in_TDATA_int),
   .stream_in_TKEEP   (stream_in_TKEEP_int), 
   .stream_in_TLAST   (stream_in_TLAST_int),
   .stream_in_TREADY  (stream_in_TREADY_int),

   //- Output Interface: Switch reading from memory manager
   .stream_out_TREADY (1'b1), // 1 'b1
   .stream_out_TVALID (), // stream_out_TVALID_int
   .stream_out_TDATA  (), // stream_out_TDATA_int
   .stream_out_TKEEP  (), // stream_out_TKEEP_int
   .stream_out_TLAST  (), // stream_out_TLAST_int
   // 
   .unblock           (),
   .spy_idle          (1'b1),
   .pcpi_idle         (1'b1),
   .fifo_0A_en        (),
   .fifo_0A_addr      (),
   .mem_rdata_a       (mm_mem_rdata),
   .mem_addr_a        (mm_mem_addr), 
   .mem_wdata_a       (mm_mem_wdata),
   .mem_wstrb_a       (mm_mem_wstrb),
   .mem_valid_a       (mm_mem_valid),
   .mem_rdata_rv      ()
);


//////////////////////////////
// tinyMODIN Instantiation
//////////////////////////////

tinyMODIN #(
  .N     (N),
  .M     (M)
) tinyMODIN_inst (
   .CLK   (clk_ctrl),
   .RST   (clk_ctrl_rst_high),
   .mem_valid_axi    (mem_valid_axi),
   .mem_addr_axi    (mem_addr_axi),
   .mem_wdata_axi  (mem_wdata_axi),  
   .mem_wstrb_axi   (mem_wstrb_axi),
   .mem_rdata_axi  (mem_rdata_axi),
   .rvControl      (rvControl),

  // message passing interface!
   .AERIN_ADDR        (mm_mem_wdata[9:0]),
   .AERIN_REQ(mm_mem_valid & mm_mem_wstrb), 
   .AERIN_ACK      (), // disconnected

   // .AEROUT_ADDR(mem_wdata_rv[7:0]),  // dc, work on later , addr of req sent to data
   // .AEROUT_REQ(mem_valid_rv), // aerout req, valid and wstrb
   // .AEROUT_ACK(mem_wstrb_rv), // ready?

   .AEROUT_ADDR    (AEROUT_ADDR), // AEROUT_ADDR
   .AEROUT_REQ     (AEROUT_REQ), // AEROUT_REQ
   .AEROUT_ACK     (AEROUT_ACK),  // AEROUT_ACK
   .SCHED_FULL     ()
);

//////////////////////////////
// Buffer NoC data
//////////////////////////////

mem_spy#(
   .NOC_BUFFER_ADDR_W(NOC_BUFFER_ADDR_W),
   .XY_SZ(XY_SZ),
   .OFFSET_SZ(OFFSET_SZ)  
) mem_spy(
   .clk_ctrl          (clk_ctrl),
   .clk_ctrl_rst_low    (clk_ctrl_rst_low),
   .clk_ctrl_rst_high   (clk_ctrl_rst_high),
   .clk_line           (clk_line),
   .clk_line_rst_low   (clk_line_rst_low),
   .HsrcId(HsrcId),

   .mem_ready_rv(AEROUT_ACK), // AEROUT_ACK
   .mem_addr_rv(scratchpad_write_addr), // scratchpad_write_addr
   .mem_wdata_rv({24'b0, AEROUT_ADDR}), // AEROUT_ADDR
   .mem_wstrb_rv(AEROUT_REQ), // AEROUT_REQ
   .mem_valid_rv(AEROUT_REQ), // AEROUT_REQ

   .unblock(AEROUT_REQ),
   .spy_idle(), 
   .local_mem(1'b0),

   .stream_out_TREADY (stream_out_TREADY), // stream_out_TREADY
   .stream_out_TVALID (stream_out_TVALID),
   .stream_out_TDATA  (stream_out_TDATA),
   .stream_out_TKEEP  (stream_out_TKEEP),
   .stream_out_TLAST  (stream_out_TLAST)
);

logic [31:0] tile_addr;
assign tile_addr = 8 << 12;
assign scratchpad_write_addr = tile_addr | scratchpad_counter;

always_ff @(posedge clk_ctrl or posedge clk_ctrl_rst_high) begin
   if (clk_ctrl_rst_high) begin
      scratchpad_counter <= 'd0;
   end 
   else begin
      if (AEROUT_ACK && AEROUT_REQ) begin
         if (scratchpad_counter == SCRATCHPAD_SIZE - 1) begin
            scratchpad_counter <= 12'd0;
         end 
         else begin
            scratchpad_counter <= scratchpad_counter + 12'd1;
         end
      end
   end
end

endmodule