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
// *************************************************************************

//////////////////////////////////////////////
// tb_dpram_be.sv — Phase 3 Task 2 contract test
//
// DPRAM_BE at DATA_W=64 must:
//   1. Merge byte-lane writes on port B without disturbing
//      unmasked lanes (per-lane read-modify-write).
//   2. Write full words on port A.
//   3. Make data written by one port visible to the other.
//
// Port-vector convention matches DPRAM.sv: {portB, portA} on
// en/wstrb/addr/din; dout = {douta, doutb}.
//
// Run (from src/Testbench):
//   iverilog -g2012 -o /tmp/tb_dpram_be.vvp \
//     tb_dpram_be.sv ../Common.HDL/DPRAM_BE.sv \
//     && vvp /tmp/tb_dpram_be.vvp
//////////////////////////////////////////////

`timescale 1 ps / 1 ps

module tb_dpram_be;

   localparam ADDR_W = 4;
   localparam DATA_W = 64;
   localparam BWB    = DATA_W/8;

   logic clk = 0;
   logic rst_n = 0;
   always #5 clk = ~clk;

   logic [1:0]           en;
   logic [2*BWB-1:0]     wstrb;
   logic [2*ADDR_W-1:0]  addr;
   logic [2*DATA_W-1:0]  din;
   wire  [2*DATA_W-1:0]  dout;

   wire [DATA_W-1:0] dout_a = dout[2*DATA_W-1:DATA_W];
   wire [DATA_W-1:0] dout_b = dout[DATA_W-1:0];

   integer errors = 0;

   DPRAM_BE #(
      .ADDR_W (ADDR_W),
      .DATA_W (DATA_W)
   ) dut (
      .clk   ({clk, clk}),
      .rst_n ({rst_n, rst_n}),
      .en    (en),
      .wstrb (wstrb),
      .addr  (addr),
      .din   (din),
      .dout  (dout)
   );

   task automatic check(input [63:0] got, input [63:0] exp, input [127:0] name);
      if (got !== exp) begin
         $display("FAIL: %0s got=%h exp=%h", name, got, exp);
         errors = errors + 1;
      end else begin
         $display("PASS: %0s = %h", name, got);
      end
   endtask

   initial begin
      rst_n = 0;
      en    = 2'b00;
      wstrb = '0;
      addr  = '0;
      din   = '0;
      repeat (2) @(posedge clk);
      rst_n = 1;

      //- 1. Byte-lane merge on port B, two writes to addr 2
      @(posedge clk);
      en    = 2'b10;                  //- port B
      wstrb = {8'h0F, 8'h00};         //- port B, low lanes only
      addr  = {ADDR_W'(2), ADDR_W'(0)};
      din   = {64'hDEADBEEFCAFEBABE, 64'h0};
      @(posedge clk);
      wstrb = {8'hF0, 8'h00};         //- port B, high lanes only
      din   = {64'h1122334455667788, 64'h0};
      @(posedge clk);
      en    = 2'b01;                  //- read back on port A
      addr  = {ADDR_W'(0), ADDR_W'(2)};
      @(posedge clk);
      en    = 2'b00;
      check(dout_a, 64'h11223344CAFEBABE, "lane merge (low+high)");

      //- 2. Port A full-word write, read on port B (cross-port visibility)
      @(posedge clk);
      en    = 2'b01;                  //- port A
      wstrb = {8'h00, 8'hFF};         //- port A, full word
      addr  = {ADDR_W'(0), ADDR_W'(3)};
      din   = {64'h0, 64'hA5A5A5A55A5A5A5A};
      @(posedge clk);
      en    = 2'b10;                  //- read on port B
      addr  = {ADDR_W'(3), ADDR_W'(0)};
      @(posedge clk);
      en    = 2'b00;
      check(dout_b, 64'hA5A5A5A55A5A5A5A, "port A full-word write");

      //- 3. Single-lane rewrite preserves the other lanes
      @(posedge clk);
      en    = 2'b10;
      wstrb = {8'h01, 8'h00};         //- lane 0 only
      addr  = {ADDR_W'(3), ADDR_W'(0)};
      din   = {64'hFFFF_FFFF_FFFF_FFFF, 64'h0};
      @(posedge clk);
      en    = 2'b01;                  //- read on port A
      addr  = {ADDR_W'(0), ADDR_W'(3)};
      @(posedge clk);
      en    = 2'b00;
      check(dout_a, 64'hA5A5A5A55A5A5AFF, "single-lane rewrite");

      $display("=== tb_dpram_be: %0d error(s) ===", errors);
      if (errors == 0) $display("TB_RESULT: PASS");
      else             $display("TB_RESULT: FAIL");
      $finish;
   end

endmodule
