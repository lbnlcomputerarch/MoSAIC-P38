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
// tb_acc_picorv64.sv — Phase 3 Task 3 contract test
//
// acc_picorv64 (BW=64) must:
//   1. AXI preload: half-select writes land in the right 32-bit half
//      of the addressed 64-bit word (mem_addr_axi[0] = half select,
//      word index = mem_addr_axi[11:1]); readback muxes by the same
//      half bit (plan D18).
//   2. Boot picorv64 (PROGADDR_RESET=0) from DPRAM_BE memory preloaded
//      hierarchically (the load_fw path) and execute an RV64IM program.
//   3. The program's `sd` lands as a full 64-bit word in local memory
//      (byte address 64 -> 64-bit word index 8).
//
// Run (from src/Testbench):
//   iverilog -g2012 -I../../build -o /tmp/tb_acc_picorv64.vvp \
//     tb_acc_picorv64.sv \
//     ../Tile.HDL/picorv64_tile/acc_picorv64.sv \
//     ../Tile.HDL/picorv64_tile/Tile_picorv64.sv \
//     ../Tile.HDL/picorv64_tile/picorv64.v \
//     ../Tile.HDL/mq_common/qISAExtension.sv \
//     ../Tile.HDL/mq_common/qISAExtension_pcpi.sv \
//     ../Tile.HDL/mq_common/mem_spy.sv \
//     ../Tile.HDL/mq_common/noc_out_arbiter.sv \
//     ../Tile.HDL/noc_buffer_in.sv ../Tile.HDL/noc_buffer_out.sv \
//     ../Tile.HDL/noc_decoder.sv ../Common.HDL/DPRAM.sv ../Common.HDL/DPRAM_BE.sv \
//     ../Common.HDL/Register.v ../../models/xpm_fifo_async.sv \
//     ../../models/xpm_fifo_sync.sv ../../models/xpm_cdc_array_single.v \
//     && vvp /tmp/tb_acc_picorv64.vvp
//////////////////////////////////////////////

`timescale 1 ps / 1 ps

module tb_acc_picorv64;

   localparam BW  = 64;
   localparam BWB = BW/8;

   logic clk = 0;
   always #5 clk = ~clk;

   logic clk_ctrl_rst_low = 0, clk_ctrl_rst_high = 1;
   logic clk_line_rst_low = 0, clk_line_rst_high = 1;

   logic [7:0] rvControl = 8'h00;   //- rvRstN = 0: core held in reset

   //- NoC idle
   logic        stream_in_TVALID = 1'b0;
   logic [BW-1:0]  stream_in_TDATA = '0;
   logic [BWB-1:0] stream_in_TKEEP = '0;
   logic        stream_in_TLAST = 1'b0;
   wire         stream_in_TREADY;
   wire         stream_out_TVALID;
   logic        stream_out_TREADY = 1'b1;
   wire [BW-1:0]   stream_out_TDATA;
   wire [BWB-1:0]  stream_out_TKEEP;
   wire         stream_out_TLAST;

   //- AXI preload interface
   logic        mem_valid_axi = 1'b0;
   logic [31:0] mem_addr_axi  = 32'h0;
   logic [31:0] mem_wdata_axi = 32'h0;
   logic        mem_wstrb_axi = 1'b0;
   wire  [31:0] mem_rdata_axi;

   integer errors = 0;
   integer n;
   reg found;

   acc_picorv64 #(
      .BW  (BW),
      .BWB (BWB)
   ) dut (
      .clk_ctrl          (clk),
      .clk_line          (clk),
      .clk_ctrl_rst_low  (clk_ctrl_rst_low),
      .clk_ctrl_rst_high (clk_ctrl_rst_high),
      .clk_line_rst_low  (clk_line_rst_low),
      .clk_line_rst_high (clk_line_rst_high),
      .HsrcId            (6'h00),
      .rvControl         (rvControl),
      .stream_in_TVALID  (stream_in_TVALID),
      .stream_in_TDATA   (stream_in_TDATA),
      .stream_in_TKEEP   (stream_in_TKEEP),
      .stream_in_TLAST   (stream_in_TLAST),
      .stream_in_TREADY  (stream_in_TREADY),
      .stream_out_TREADY (stream_out_TREADY),
      .stream_out_TVALID (stream_out_TVALID),
      .stream_out_TDATA  (stream_out_TDATA),
      .stream_out_TKEEP  (stream_out_TKEEP),
      .stream_out_TLAST  (stream_out_TLAST),
      .mem_valid_axi     (mem_valid_axi),
      .mem_addr_axi      (mem_addr_axi),
      .mem_wdata_axi     (mem_wdata_axi),
      .mem_wstrb_axi     (mem_wstrb_axi),
      .mem_rdata_axi     (mem_rdata_axi)
   );

   task automatic check64(input [63:0] got, input [63:0] exp, input [127:0] name);
      if (got !== exp) begin
         $display("FAIL: %0s got=%h exp=%h", name, got, exp);
         errors = errors + 1;
      end else begin
         $display("PASS: %0s = %h", name, got);
      end
   endtask

   //- AXI half-write, then half-readback
   task automatic axi_write32(input [31:0] waddr, input [31:0] wdata);
      @(posedge clk);
      mem_valid_axi = 1'b1;
      mem_wstrb_axi = 1'b1;
      mem_addr_axi  = waddr;
      mem_wdata_axi = wdata;
      @(posedge clk);
      mem_valid_axi = 1'b0;
      mem_wstrb_axi = 1'b0;
   endtask

   task automatic axi_read32(input [31:0] raddr, input [31:0] exp, input [127:0] name);
      @(posedge clk);
      mem_valid_axi = 1'b1;
      mem_wstrb_axi = 1'b0;
      mem_addr_axi  = raddr;
      @(posedge clk);
      @(posedge clk);
      mem_valid_axi = 1'b0;
      if (mem_rdata_axi !== exp) begin
         $display("FAIL: %0s got=%h exp=%h", name, mem_rdata_axi, exp);
         errors = errors + 1;
      end else begin
         $display("PASS: %0s = %h", name, mem_rdata_axi);
      end
   endtask

   initial begin
      //- Program: build 0xCAFEBABEDEADBEEF in x6 (RV64 lui sign-extends,
      //- so x5 needs an slli/srli zero-extend), sd to byte addr 64, spin
      dut.dp_ram_be.mem[0] = 64'hEEF28293DEADC2B7;  // lui x5; addi x5
      dut.dp_ram_be.mem[1] = 64'h0202D29302029293;  // slli x5; srli x5 (zext)
      dut.dp_ram_be.mem[2] = 64'hABE38393CAFEC3B7;  // lui x7; addi x7
      dut.dp_ram_be.mem[3] = 64'h0053033302039313;  // slli x6; add x6
      dut.dp_ram_be.mem[4] = 64'h0000006F04603023;  // sd x6,64(x0); jal x0,0

      repeat (4) @(posedge clk);
      clk_ctrl_rst_low  = 1;
      clk_line_rst_low  = 1;
      clk_ctrl_rst_high = 0;
      clk_line_rst_high = 0;
      repeat (4) @(posedge clk);

      //- 1. AXI preload contract (core still in reset).
      //-    Test area = word64 6 (bytes 48..55); the program occupies
      //-    word64 0..4 and the store target is word64 8.
      axi_write32(32'h0000_000C, 32'hCAFED00D);   //- word32 12 = lower half of word64 6
      axi_write32(32'h0000_000D, 32'hFEEDFACE);   //- word32 13 = upper half of word64 6
      repeat (2) @(posedge clk);                  //- let NBA writes land
      check64(dut.dp_ram_be.mem[6], 64'hFEEDFACECAFED00D, "AXI half-select write");
      axi_read32(32'h0000_000C, 32'hCAFED00D, "AXI readback lower half");
      axi_read32(32'h0000_000D, 32'hFEEDFACE, "AXI readback upper half");

      //- 2. Release the core; it boots at PROGADDR_RESET=0
      @(posedge clk);
      rvControl = 8'h01;

      //- 3. Poll for the stored 64-bit pattern (byte addr 64 -> word64 index 8)
      found = 1'b0;
      for (n = 0; n < 20000 && !found; n = n + 1) begin
         @(posedge clk);
         if (dut.dp_ram_be.mem[8] === 64'hCAFEBABEDEADBEEF) found = 1'b1;
      end
      if (!found) begin
         $display("FAIL: pattern store timed out; mem[8]=%h", dut.dp_ram_be.mem[8]);
         errors = errors + 1;
      end
      check64(dut.dp_ram_be.mem[8], 64'hCAFEBABEDEADBEEF, "core sd 64-bit pattern");

      $display("=== tb_acc_picorv64: %0d error(s) ===", errors);
      if (errors == 0) $display("TB_RESULT: PASS");
      else             $display("TB_RESULT: FAIL");
      $finish;
   end

endmodule
