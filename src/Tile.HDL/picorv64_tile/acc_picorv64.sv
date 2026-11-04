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
// works and perform publicly and display publicly.
//
// *************************************************************************

//////////////////////////////////////////////
// Author      : Farzad Fatollahi-Fard
// Date        : November 3 2026
// Description : Accelerator with PICORV64 (pico64 tile)
// File        : acc_picorv64.sv
// Notes       :
//  - Phase 3 of the 64-bit upgrade (plan D17-D20).
//  - 64-bit data plane: BW-wide NoC streams, RV64 core, 64-bit local
//    memory (2048 x 64-bit words = 16 KB, plan D15b).
//  - All MoSAIC addresses (MQ offsets, spy, AXI preload) are in
//    32-bit-word units; the local 64-bit word index is (word32 >> 1)
//    on the NoC/AXI side and (byte address >> 3) on the core side.
//  - AXI preload: mem_addr_axi[0] = half-select (0 = lower, 1 = upper
//    32-bit half); the existing host tools walk sequential 32-bit
//    word addresses unchanged (plan D18).
//  - Unified instruction/data memory for Phase 3 (plan D19): the
//    `ifdef INSTRUCTION_MEM seam below is reserved for the pico64
//    instruction-memory phase (DDR4-resident programs).
//////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module acc_picorv64#(
   parameter BW  = 64,
   parameter BWB = BW/8,
   parameter OFFSET_SZ         = 12,
   parameter XY_SZ             =  3,
   parameter NOC_BUFFER_ADDR_W =  8,
   parameter MQ_ADDR_W         =  8   //- 256 x 8B = 2 KB MQ, same bytes as pico32 (plan D12)
)(
  //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_line,
   input  logic       clk_ctrl_rst_low,
   input  logic       clk_line_rst_low,
   input  logic       clk_line_rst_high,
   input  logic       clk_ctrl_rst_high,
   input  logic [(XY_SZ*2)-1:0] HsrcId,     //- Tile identification
   //---NOC interface---//
   //- Input Interface
   input  logic        stream_in_TVALID,
   input  logic [BW-1:0] stream_in_TDATA,
   input  logic [BWB-1:0] stream_in_TKEEP,
   input  logic        stream_in_TLAST,
   output logic        stream_in_TREADY,
   //- Output Interface
   (*mark_debug = "true" *) input  logic        stream_out_TREADY,
   (*mark_debug = "true" *) output logic        stream_out_TVALID,
   (*mark_debug = "true" *) output logic [BW-1:0] stream_out_TDATA,
   (*mark_debug = "true" *) output logic [BWB-1:0] stream_out_TKEEP,
   (*mark_debug = "true" *) output logic        stream_out_TLAST,
  //- AXI memory interface (32-bit control plane, plan D6)
   input  logic        mem_valid_axi,
   input  logic [31:0] mem_addr_axi,
   input  logic [31:0] mem_wdata_axi,
   input  logic        mem_wstrb_axi,
   output logic [31:0] mem_rdata_axi,
  //-
   input logic  [7:0] rvControl
);

localparam MEM_ADDR_W = OFFSET_SZ-1;  //- 64-bit words: 2^OFFSET_SZ word32 / 2

//- Between memory manager and memory
wire        mem_valid_a;
wire        mem_wstrb_a;
wire [31:0] mem_addr_a;
wire [BW-1:0] mem_wdata_a;
wire [BW-1:0] mem_rdata_a;

//- PICO and memory
logic        mem_valid_b;
logic [MEM_ADDR_W-1:0] mem_addr_b;
logic [BW-1:0] mem_wdata_b;
logic [BWB-1:0] mem_wstrb_b;
logic [BW-1:0] mem_rdata_data_b;
logic [BW-1:0] mem_rdata_data_a;

(*mark_debug = "true" *) logic           local_mem;
(*mark_debug = "true" *) logic           local_mem_spy;

//- Between picorv64 and memory
(*mark_debug = "true" *) wire            mem_valid_rv;
(*mark_debug = "true" *) wire            mem_instr_rv;
(*mark_debug = "true" *) wire            mem_ready_rv;
(*mark_debug = "true" *) wire   [63:0]   mem_addr_rv;
(*mark_debug = "true" *) wire   [63:0]   mem_wdata_rv;
(*mark_debug = "true" *) wire   [7:0]    mem_wstrb_rv;
(*mark_debug = "true" *) wire   [63:0]   mem_rdata_rv;

//- PCPI interface
(*mark_debug = "true" *) logic        pcpi_valid;
(*mark_debug = "true" *) logic [31:0] pcpi_insn;
(*mark_debug = "true" *) logic [BW-1:0] pcpi_rs1;
(*mark_debug = "true" *) logic [BW-1:0] pcpi_rs2;
(*mark_debug = "true" *) logic        pcpi_wr;
(*mark_debug = "true" *) logic [BW-1:0] pcpi_rd;
(*mark_debug = "true" *) logic        pcpi_wait;
(*mark_debug = "true" *) logic        pcpi_ready;

(*mark_debug = "true" *) logic rvRstN;

logic [(2*XY_SZ)-1:0] mem_addr_xy;

logic [BW-1:0] mem_rdata_outsi_rv;
logic mem_ready_outsi_rv;

logic        stream_out_TREADY_int;
logic        stream_out_TVALID_int;
logic [BW-1:0] stream_out_TDATA_int;
logic [BWB-1:0] stream_out_TKEEP_int;
logic        stream_out_TLAST_int;

assign rvRstN = rvControl[0];

logic is_array;
logic is_array_dec; //- Not used here

//- MoSAIC addresses are 32-bit-word units (plan D15b)
logic [31:0] mem_addr_b_32;
assign mem_addr_b_32 = mem_addr_rv[31:2]; //- byte address -> 32-bit-word units

`include "is_array.vh"

assign mem_addr_xy   = mem_addr_b_32[(OFFSET_SZ+(2*XY_SZ))-1:OFFSET_SZ];

assign local_mem_spy = local_mem | mem_instr_rv;  //- Processor reads out of local

//- AXI preload: half-select readback mux (plan D18)
assign mem_rdata_axi = mem_addr_axi[0] ? mem_rdata_data_b[63:32]
                                       : mem_rdata_data_b[31:0];

`ifdef INSTRUCTION_MEM
//- RESERVED (plan D19): pico64 instruction-memory mode (DDR4-resident
//- programs) is its own later phase. Phase 3 ships unified memory only.
`endif

//- Unified memory: Port B = processor + AXI preload (clk_ctrl)
//-               Port A = NoC (clk_line)

logic mem_ready_local_rv;

assign local_mem = is_array & mem_addr_xy == HsrcId;

assign mem_ready_rv = mem_ready_local_rv | mem_ready_outsi_rv;
assign mem_rdata_rv = local_mem_spy ? mem_rdata_data_b : mem_rdata_outsi_rv;

assign mem_valid_b = (mem_valid_rv & local_mem_spy) | mem_valid_axi;
always @(*) begin
   if (mem_valid_axi) begin
      //- AXI preload: half-select write strobes (plan D18);
      //- mem_addr_axi[OFFSET_SZ] is always 0 for the 16 KB window
      mem_addr_b  = mem_addr_axi[OFFSET_SZ-1:1];
      mem_wdata_b = mem_addr_axi[0] ? {mem_wdata_axi, 32'h0}
                                    : {32'h0, mem_wdata_axi};
      mem_wstrb_b = mem_wstrb_axi ? (mem_addr_axi[0] ? 8'hF0 : 8'h0F)
                                  : 8'h00;
   end else begin
      mem_addr_b  = mem_addr_rv[OFFSET_SZ+1:3];
      mem_wdata_b = mem_wdata_rv;
      mem_wstrb_b = mem_wstrb_rv & {BWB{mem_valid_rv & local_mem_spy}};
   end
end

Register #(
  .Width (1)
) rv_mem_valid_ready_inst (
  .Clock  (clk_ctrl),
  .Reset  (~clk_ctrl_rst_low),
  .Set    (1'b0),
  .Enable (1'b1),
  .In     (mem_valid_rv & local_mem_spy),
  .Out    (mem_ready_local_rv));

//- NoC side (port A): full-word writes at (word32 >> 1) index
assign mem_rdata_a = mem_rdata_data_a;

logic [BWB-1:0] mem_wstrb_data_a;
logic mem_valid_data_a;
assign mem_valid_data_a = mem_valid_a;
assign mem_wstrb_data_a = {BWB{mem_wstrb_a & mem_valid_data_a}};

assign stream_out_TDATA      = stream_out_TDATA_int;
assign stream_out_TVALID     = stream_out_TVALID_int;
assign stream_out_TLAST      = stream_out_TLAST_int;
assign stream_out_TKEEP      = stream_out_TKEEP_int;
assign stream_out_TREADY_int = stream_out_TREADY;

DPRAM_BE #(
  .ADDR_W     (MEM_ADDR_W),
  //- Memory is 64-bit wide regardless of the tile's BW parameter: this
  //- tile is BW=64-only (plan D17) and the core is RV64 (review F5).
  .DATA_W     (64),
  .MEMSIZE_KB (16)
) dp_ram_be (
  .clk   ({clk_ctrl,         clk_line}),
  .rst_n ({clk_ctrl_rst_low, clk_line_rst_low}),
  .en    ({mem_valid_b,      mem_valid_data_a}),
  .wstrb ({mem_wstrb_b,      mem_wstrb_data_a}),
  .addr  ({mem_addr_b,       mem_addr_a[OFFSET_SZ-1:1]}),
  .din   ({mem_wdata_b,      mem_wdata_a}),
  .dout  ({mem_rdata_data_a, mem_rdata_data_b}));


/* PICORV64 instantiation (plan D20) */

picorv64#(
   .ENABLE_PCPI       (1'b1),
   .COMPRESSED_ISA    (1'b1),
   .ENABLE_FAST_MUL   (1'b1),
   .ENABLE_DIV        (1'b1),
   .ENABLE_COUNTERS   (1'b1),
   .BARREL_SHIFTER    (1'b1),
   .ENABLE_IRQ        (1'b0),
   .PROGADDR_RESET    (64'h0),
   .PROGADDR_IRQ      (64'h10)
) picorv64 (
   .clk        (clk_ctrl),
   .resetn     (clk_ctrl_rst_low && rvRstN),
   .trap       ( ),
   //- Simple memory interface
   .mem_valid  (mem_valid_rv),  // Output
   .mem_instr  (mem_instr_rv),  // Output
   .mem_ready  (mem_ready_rv),  // Input
   .mem_addr   (mem_addr_rv),   // Output
   .mem_wdata  (mem_wdata_rv),  // Output
   .mem_wstrb  (mem_wstrb_rv),  // Output
   .mem_rdata  (mem_rdata_rv),  // Input
   .irq        (32'b0),
   .eoi        ( ),
   //- Pico Co-Processor Interface (PCPI)
   .pcpi_valid (pcpi_valid),
   .pcpi_insn  (pcpi_insn),
   .pcpi_rs1   (pcpi_rs1),
   .pcpi_rs2   (pcpi_rs2),
   .pcpi_wr    (pcpi_wr),
   .pcpi_rd    (pcpi_rd),
   .pcpi_wait  (pcpi_wait),
   .pcpi_ready (pcpi_ready)
);


//- LPGG: The memory  and Queue managers
qISAExtension#(
   .NOC_BUFFER_ADDR_W (NOC_BUFFER_ADDR_W),
   .OFFSET_SZ         (OFFSET_SZ),
   .XY_SZ             (XY_SZ),
   .MQ_ADDR_W         (MQ_ADDR_W),
   .BW                (BW),
   .BWB               (BWB)
) qISAExtension_inst (
   //- Clock and reset
   .clk_ctrl         (clk_ctrl),
   .clk_line         (clk_line),
   .clk_ctrl_rst_low (clk_ctrl_rst_low && rvRstN),
   .clk_line_rst_low (clk_line_rst_low),
   .clk_line_rst_high (clk_line_rst_high),
   .clk_ctrl_rst_high (clk_ctrl_rst_high),
   //- Tile identification
   .HsrcId           (HsrcId),
   //- NOC interface
   //- Input Interface: Switch writing to the memory manager
   .stream_in_TVALID  (stream_in_TVALID),
   .stream_in_TDATA   (stream_in_TDATA),
   .stream_in_TKEEP   (stream_in_TKEEP),
   .stream_in_TLAST   (stream_in_TLAST),
   .stream_in_TREADY  (stream_in_TREADY),
   //- Output Interface: Switch reading from memory manager
   .stream_out_TREADY (stream_out_TREADY_int),
   .stream_out_TVALID (stream_out_TVALID_int),
   .stream_out_TDATA  (stream_out_TDATA_int),
   .stream_out_TKEEP  (stream_out_TKEEP_int),
   .stream_out_TLAST  (stream_out_TLAST_int),
   //---Interface with main memory (Both Ports)---//
   //- Port A : Memory manager (clk_line)
   .mem_valid_a       (mem_valid_a), //- Output
   .mem_addr_a        (mem_addr_a),  //- Output
   .mem_wdata_a       (mem_wdata_a), //- Output
   .mem_wstrb_a       (mem_wstrb_a), //- Output
   .mem_rdata_a       (mem_rdata_a), //- Input
   // Spying in the interface between Processor and memory
   .local_mem         (local_mem_spy),
   .mem_valid_rv      (mem_valid_rv),       //- Input
   .mem_ready_rv      (mem_ready_outsi_rv), //- Output
   .mem_addr_rv       (mem_addr_b_32),      //- Input (word32 units)
   .mem_wdata_rv      (mem_wdata_rv),       //- Input
   .mem_wstrb_rv      (|mem_wstrb_rv),      //- Input (D13: full-word remote writes)
   .mem_rdata_rv      (mem_rdata_outsi_rv), //- Output
   //- PCPI Processor Interface
   .pcpi_valid        (pcpi_valid),
   .pcpi_insn         (pcpi_insn),
   .pcpi_rs1          (pcpi_rs1),
   .pcpi_rs2          (pcpi_rs2),
   .pcpi_wr           (pcpi_wr),
   .pcpi_rd           (pcpi_rd),
   .pcpi_wait         (pcpi_wait),
   .pcpi_ready        (pcpi_ready));

endmodule
