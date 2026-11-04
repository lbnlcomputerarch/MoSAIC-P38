// *************************************************************************
//
// *** Copyright Notice ***
//
// P38 heterogeneous multi-tiled system with support for message queues
// (MoSAIC) Copyright (c) 2024, The Regents of the University of California,
// through Lawrence Berkeley National Laboratory (subject to receipt of
// any required approvals from the U.S. Dept. of Energy). All rights reserved.
//
// *************************************************************************

//////////////////////////////////////////////
// tb_qisa_bw64.sv — Phase 2 contract test
//
// Instantiates qISAExtension at BW=64 and verifies the MQ data path
// moves full 64-bit words:
//   1. Outbound qPut: 64-bit pcpi_rs2 payload appears untruncated on the
//      NoC stream, TKEEP = {BWB{1'b1}} = 8'hFF, TLAST on the data beat.
//   2. Outbound mPut: same, via the memory-manager port.
//   3. Inbound qPut packet: 64-bit data beat stored in the MQ and
//      returned untruncated by qGet (second pop).
//
// Run (from src/Testbench):
//   iverilog -g2012 -o /tmp/tb_qisa_bw64.vvp \
//     tb_qisa_bw64.sv \
//     ../Tile.HDL/mq_common/qISAExtension.sv \
//     ../Tile.HDL/mq_common/qISAExtension_pcpi.sv \
//     ../Tile.HDL/mq_common/mem_spy.sv \
//     ../Tile.HDL/mq_common/noc_out_arbiter.sv \
//     ../Tile.HDL/noc_buffer_in.sv ../Tile.HDL/noc_buffer_out.sv \
//     ../Tile.HDL/noc_decoder.sv ../Common.HDL/DPRAM.sv \
//     ../../models/xpm_fifo_async.sv ../../models/xpm_fifo_sync.sv \
//     ../../models/xpm_cdc_array_single.v \
//     && vvp /tmp/tb_qisa_bw64.vvp
//////////////////////////////////////////////

`timescale 1 ps / 1 ps

module tb_qisa_bw64;

   localparam BW  = 64;
   localparam BWB = BW/8;
   localparam XY_SZ = 3;

   //- Clock / reset (single clock: CDC paths are same-domain in sim)
   logic clk = 1'b0;
   always #5 clk = ~clk;

   logic rstn = 1'b0;
   wire clk_ctrl_rst_low  = rstn;
   wire clk_line_rst_low  = rstn;
   wire clk_ctrl_rst_high = ~rstn;
   wire clk_line_rst_high = ~rstn;

   logic [(2*XY_SZ)-1:0] HsrcId = 6'b00_0000;  //- tile (x=0,y=0)

   //- PCPI (64-bit processor side)
   logic        pcpi_valid = 1'b0;
   logic [31:0] pcpi_insn  = 32'h0;
   logic [BW-1:0] pcpi_rs1 = '0;
   logic [BW-1:0] pcpi_rs2 = '0;
   wire         pcpi_wr, pcpi_wait, pcpi_ready;
   wire [BW-1:0] pcpi_rd;

   //- NoC in
   logic         stream_in_TVALID = 1'b0;
   logic [BW-1:0] stream_in_TDATA = '0;
   logic [BWB-1:0] stream_in_TKEEP = '0;
   logic         stream_in_TLAST = 1'b0;
   wire          stream_in_TREADY;

   //- NoC out
   logic         stream_out_TREADY = 1'b1;
   wire          stream_out_TVALID;
   wire [BW-1:0] stream_out_TDATA;
   wire [BWB-1:0] stream_out_TKEEP;
   wire          stream_out_TLAST;

   //- Memory manager port A (only mGet/mLoad would use it; tied off here)
   wire          mem_valid_a, mem_wstrb_a;
   wire [31:0]   mem_addr_a, mem_wdata_a;
   wire          local_mem = 1'b0;
   wire [BW-1:0] mem_rdata_a = '0;

   //- Spy path (tied off: no processor memory traffic in this tb)
   wire [31:0]   mem_rdata_rv;
   wire          mem_ready_rv;
   wire [31:0]   mem_addr_rv = 32'h0;
   wire [BW-1:0] mem_wdata_rv = '0;
   wire          mem_wstrb_rv = 1'b0;
   wire          mem_valid_rv = 1'b0;

   qISAExtension #(
      .BW  (BW),
      .BWB (BWB),
      .OFFSET_SZ (12),
      .MQ_ADDR_W (9),
      .NOC_BUFFER_ADDR_W (8),
      .XY_SZ (XY_SZ)
   ) dut (
      .clk_ctrl (clk), .clk_line (clk),
      .clk_ctrl_rst_low (clk_ctrl_rst_low),
      .clk_line_rst_low (clk_line_rst_low),
      .clk_line_rst_high (clk_line_rst_high),
      .clk_ctrl_rst_high (clk_ctrl_rst_high),
      .HsrcId (HsrcId),
      .pcpi_valid (pcpi_valid), .pcpi_insn (pcpi_insn),
      .pcpi_rs1 (pcpi_rs1), .pcpi_rs2 (pcpi_rs2),
      .pcpi_wr (pcpi_wr), .pcpi_rd (pcpi_rd),
      .pcpi_wait (pcpi_wait), .pcpi_ready (pcpi_ready),
      .stream_in_TVALID (stream_in_TVALID),
      .stream_in_TDATA (stream_in_TDATA),
      .stream_in_TKEEP (stream_in_TKEEP),
      .stream_in_TLAST (stream_in_TLAST),
      .stream_in_TREADY (stream_in_TREADY),
      .stream_out_TREADY (stream_out_TREADY),
      .stream_out_TVALID (stream_out_TVALID),
      .stream_out_TDATA (stream_out_TDATA),
      .stream_out_TKEEP (stream_out_TKEEP),
      .stream_out_TLAST (stream_out_TLAST),
      .local_mem (local_mem),
      .mem_rdata_a (mem_rdata_a),
      .mem_addr_a (mem_addr_a),
      .mem_wdata_a (mem_wdata_a),
      .mem_wstrb_a (mem_wstrb_a),
      .mem_valid_a (mem_valid_a),
      .mem_rdata_rv (mem_rdata_rv),
      .mem_ready_rv (mem_ready_rv),
      .mem_addr_rv (mem_addr_rv),
      .mem_wdata_rv (mem_wdata_rv),
      .mem_wstrb_rv (mem_wstrb_rv),
      .mem_valid_rv (mem_valid_rv)
   );

   //- Beat capture queue on the NoC-out port
   localparam MAX_BEATS = 8;
   logic [BW+BWB+1:0] beat_q [0:MAX_BEATS-1];  //{TLAST,TKEEP,TDATA}
   int beat_count = 0;

   always @(posedge clk) begin
      if (rstn && stream_out_TVALID && stream_out_TREADY) begin
         if (beat_count < MAX_BEATS) begin
            beat_q[beat_count] = {stream_out_TLAST, stream_out_TKEEP, stream_out_TDATA};
            beat_count <= beat_count + 1;
         end
      end
   end

   task automatic reset_dut;
      repeat (40) @(posedge clk);  //- drain any in-flight beats first
      rstn = 1'b0;
      repeat (10) @(posedge clk);
      rstn = 1'b1;
      repeat (10) @(posedge clk);
      beat_count = 0;
   endtask

   //- Drive one NoC-in beat with AXI-S handshake
   task automatic send_beat(input logic [BW-1:0] data,
                            input logic [BWB-1:0] keep,
                            input logic last);
      stream_in_TDATA  <= data;
      stream_in_TKEEP  <= keep;
      stream_in_TLAST  <= last;
      stream_in_TVALID <= 1'b1;
      @(posedge clk);
      while (!stream_in_TREADY) @(posedge clk);
      stream_in_TVALID <= 1'b0;
      stream_in_TLAST  <= 1'b0;
      @(posedge clk);
   endtask

   //- Sample pcpi_rd at the ready edge (combinational output of the
   //- serving state; after the edge the FSM returns to IDLE and rd=0)
   logic [BW-1:0] last_rd;
   always @(posedge clk)
      if (rstn && pcpi_ready) last_rd <= pcpi_rd;

   //- Issue one PCPI instruction like picorv32 does: hold
   //! insn/rs1/rs2 stable, deassert valid at the first ready, then let
   //! the transaction drain (the FSM streams remaining beats using the
   //! live pcpi_rs2, so it must stay stable).
   task automatic pcpi_issue(input logic [31:0] insn,
                             input logic [BW-1:0] rs1,
                             input logic [BW-1:0] rs2);
      @(posedge clk);
      pcpi_insn  <= insn;
      pcpi_rs1   <= rs1;
      pcpi_rs2   <= rs2;
      pcpi_valid <= 1'b1;
      @(posedge clk);
      while (!(pcpi_ready || pcpi_wr)) @(posedge clk);
      pcpi_valid <= 1'b0;
      //- NOTE: insn/rs1/rs2 stay driven (like picorv32's stable operand
      //- registers) until the next pcpi_issue overwrites them; the FSM's
      //- QPUT_DATA_S samples live pcpi_rs2.
      //- Drain: CDC sync (~5 cycles) + FIFO latency + FSM beats
      repeat (40) @(posedge clk);
      pcpi_insn <= 32'h0; pcpi_rs1 <= '0; pcpi_rs2 <= '0;
   endtask

   //- MQ instruction encodings (R-type, opcode 0x2B; funct3 selects op)
   function automatic logic [31:0] mq_insn(input logic [2:0] funct3);
      return {5'b00000, 2'b00, 5'b00000, 5'b00000, funct3, 5'b00000, 7'h2B};
   endfunction

   localparam [2:0] QPUT_FUNCT3 = 3'd3;
   localparam [2:0] QGET_FUNCT3 = 3'd2;
   localparam [2:0] MPUT_FUNCT3 = 3'd4;

   int errors = 0;

   task automatic check(input string name, input logic ok);
      if (ok) $display("PASS: %s", name);
      else begin
         $display("FAIL: %s", name);
         errors = errors + 1;
      end
   endtask

   logic [BW-1:0] qput_data, mput_data, qget_data;
   logic [31:0] exp_hdr;
   logic [BW-1:0] exp_hdr_ext;
   logic [2:0] dest_x = 3'd1, dest_y = 3'd0;

   initial begin
      $display("=== tb_qisa_bw64: qISAExtension BW=64 contract ===");

      //- Test 1: outbound qPut with 64-bit payload --------------
      reset_dut();
      qput_data = 64'hCAFED00D_12345678;
      exp_hdr = {3'h0, 1'b0, 3'd3, 1'b0, HsrcId, 12'h0, dest_y, dest_x};
      exp_hdr_ext = {{(BW-32){1'b0}}, exp_hdr};
      pcpi_issue(mq_insn(QPUT_FUNCT3), {56'h0, dest_y, dest_x}, qput_data);
      check("qPut beat0 = 32-bit header zero-extended to BW",
            beat_count >= 1 && beat_q[0][BW-1:0] === exp_hdr_ext);
      check("qPut beat0 TKEEP = 8'hFF",
            beat_count >= 1 && beat_q[0][BW+:BWB] === {BWB{1'b1}});
      check("qPut beat1 = full 64-bit payload",
            beat_count >= 2 && beat_q[1][BW-1:0] === qput_data);
      check("qPut beat1 TKEEP = 8'hFF",
            beat_count >= 2 && beat_q[1][BW+:BWB] === {BWB{1'b1}});
      check("qPut beat1 TLAST = 1",
            beat_count >= 2 && beat_q[1][BW+BWB] === 1'b1);

      //- Test 2: outbound mPut with 64-bit payload --------------
      reset_dut();
      mput_data = 64'hF00DFACE_FEED5678;
      exp_hdr = {3'h0, 1'b0, 3'd4, 1'b0, HsrcId, 12'h042, dest_y, dest_x};
      exp_hdr_ext = {{(BW-32){1'b0}}, exp_hdr};
      pcpi_issue(mq_insn(MPUT_FUNCT3), {47'h0, dest_y, dest_x, 12'h042}, mput_data);
      check("mPut beat0 = header", beat_count >= 1 && beat_q[0][BW-1:0] === exp_hdr_ext);
      check("mPut beat1 = full 64-bit payload",
            beat_count >= 2 && beat_q[1][BW-1:0] === mput_data);
      check("mPut beat1 TLAST = 1",
            beat_count >= 2 && beat_q[1][BW+BWB] === 1'b1);

      //- Test 3: inbound qPut packet -> qGet returns 64-bit data -
      reset_dut();
      qget_data = 64'hDEADBEEF_CAFEBABE;
      exp_hdr = {3'h0, 1'b0, 3'd3, 1'b0, HsrcId, 12'h0, dest_y, dest_x};
      exp_hdr_ext = {{(BW-32){1'b0}}, exp_hdr};
      send_beat(exp_hdr_ext, {BWB{1'b1}}, 1'b0);
      send_beat(qget_data, {BWB{1'b1}}, 1'b1);
      repeat (40) @(posedge clk);
      pcpi_issue(mq_insn(QGET_FUNCT3), '0, '0);  //- pops header
      pcpi_issue(mq_insn(QGET_FUNCT3), '0, '0);  //- pops data
      check("qGet returns full 64-bit inbound payload", last_rd === qget_data);

      //- Summary -------------------------------------------------
      $display("=== tb_qisa_bw64: %0d error(s) ===", errors);
      if (errors == 0) $display("TB_RESULT: PASS");
      else             $display("TB_RESULT: FAIL");
      $finish;
   end

   //- Watchdog
   initial begin
      #1000000;
      $display("FAIL: watchdog timeout");
      $display("TB_RESULT: FAIL");
      $finish;
   end

endmodule
