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
// Description : Accelerator with PICORV32
// File        : acc_picorv32.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module acc_picorv32#(
   parameter OFFSET_SZ         = 12,
   parameter XY_SZ             =  3,
   parameter NOC_BUFFER_ADDR_W =  8,
   parameter MEM_SZ            = 'h1000
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
   input  logic [31:0] stream_in_TDATA,
   input  logic [ 3:0] stream_in_TKEEP, 
   input  logic        stream_in_TLAST,
   output logic        stream_in_TREADY,  
   //- Output Interface
   (*mark_debug = "true" *) input  logic        stream_out_TREADY,
   (*mark_debug = "true" *) output logic        stream_out_TVALID,
   (*mark_debug = "true" *) output logic [31:0] stream_out_TDATA,
   (*mark_debug = "true" *) output logic [ 3:0] stream_out_TKEEP,
   (*mark_debug = "true" *) output logic        stream_out_TLAST,
  //- AXI memory interface 
   input  logic        mem_valid_axi,
   input  logic [31:0] mem_addr_axi,
   input  logic [31:0] mem_wdata_axi, 
   input  logic        mem_wstrb_axi, 
   output logic [31:0] mem_rdata_axi,
  //- 
  input logic  [7:0] rvControl
);

//- Between memory manager and memory 
wire        mem_valid_a;
wire        mem_valid_data_a;
wire        mem_wstrb_a;
logic       mem_wstrb_data_a;
wire [31:0] mem_addr_a;
wire [31:0] mem_wdata_a;
wire [31:0] mem_rdata_data_a;
wire [31:0] mem_rdata_a;

//- PICO and memory
logic        mem_wstrb_b;
logic [31:0] mem_addr_b;
logic [31:0] mem_addr_b_32;
logic [31:0] mem_wdata_b;
logic [31:0] mem_rdata_data_b;

(*mark_debug = "true" *) logic           local_mem;
(*mark_debug = "true" *) logic           local_mem_spy;

//- Between picorv and memory
(*mark_debug = "true" *) wire            mem_valid_rv;
(*mark_debug = "true" *) wire            mem_instr_rv;
(*mark_debug = "true" *) wire            mem_ready_rv;
(*mark_debug = "true" *) wire   [31:0]   mem_addr_rv;
(*mark_debug = "true" *) wire   [31:0]   mem_wdata_rv;
(*mark_debug = "true" *) wire   [3:0]    mem_wstrb_rv;
(*mark_debug = "true" *) wire   [31:0]   mem_rdata_rv;

//- PCPI interface
(*mark_debug = "true" *) logic        pcpi_valid;
(*mark_debug = "true" *) logic [31:0] pcpi_insn;
(*mark_debug = "true" *) logic [31:0] pcpi_rs1;
(*mark_debug = "true" *) logic [31:0] pcpi_rs2;
(*mark_debug = "true" *) logic        pcpi_wr;
(*mark_debug = "true" *) logic [31:0] pcpi_rd;
(*mark_debug = "true" *) logic        pcpi_wait;
(*mark_debug = "true" *) logic        pcpi_ready;

(*mark_debug = "true" *) logic rvRstN;

logic [(2*XY_SZ-1):0] mem_addr_xy;

logic [31:0] mem_rdata_outsi_rv;
logic mem_ready_outsi_rv;


logic        stream_out_TREADY_int;
logic        stream_out_TVALID_int;
logic [31:0] stream_out_TDATA_int;
logic [ 3:0] stream_out_TKEEP_int;
logic        stream_out_TLAST_int;

assign rvRstN = rvControl[0];

logic is_array;
logic is_array_dec; //- Not used here

`include "is_array.vh"

assign mem_addr_xy   = mem_addr_b_32[(OFFSET_SZ+(2*XY_SZ))-1:OFFSET_SZ]; //- Only if is_array
                                                                         //  look for TileID
assign mem_addr_b_32 = mem_addr_rv >> 2; //- To address 32bits words instead of bytes.
assign mem_rdata_axi = mem_rdata_data_b;

assign local_mem_spy = local_mem | mem_instr_rv;                  //- Processor reads out of local

`ifdef INSTRUCTION_MEM

//-Note: AXI bus can only write/read data memory
//       The instruction memory can't be accessed
//       through AXI. This could be changed in the
//       future

logic boot;
logic cache_valid;
logic int_valid;
logic next_cache_valid;
logic next_int_valid;
logic state;
logic next_state;
logic tvalid;
logic mem_valid_cache;
logic [31:0] mem_offset;
logic cpu_req_valid;
logic is_data;
logic mem_ready_rv_instr;
logic [31:0] mem_rdata_instr;

logic        stream_out_TREADY_cache;
logic        stream_out_TVALID_cache;
logic [31:0] stream_out_TDATA_cache;
logic [ 3:0] stream_out_TKEEP_cache;
logic        stream_out_TLAST_cache;

assign local_mem = is_array & mem_addr_xy == 0;

assign boot = mem_addr_rv < 'h200;

assign mem_ready_rv = mem_ready_rv_data | mem_ready_rv_instr | mem_ready_outsi_rv;

assign mem_rdata_rv = local_mem    ? mem_rdata_data_b : 
                      mem_instr_rv ? mem_rdata_instr  : mem_rdata_outsi_rv; 
                      

assign mem_rdata_a = mem_instr_rv ? mem_rdata_instr : mem_rdata_data_b;

assign cpu_req_valid = ~boot & mem_instr_rv & mem_valid_rv;

instr_mem instr_mem_inst(
   //- Clock and reset
   .clk_ctrl          (clk_ctrl),
   .clk_line          (clk_line),
   .clk_ctrl_rst_low  (clk_ctrl_rst_low), 
   .clk_ctrl_rst_high (clk_ctrl_rst_high), 
   .clk_line_rst_low  (clk_line_rst_low),
   .clk_line_rst_high (clk_line_rst_high),
   .HsrcId            (HsrcId),              //- Tile identification
   //- CPU request (CPU -> Cache)
   .cpu_req_addr      (mem_addr_rv),         //- 32-bit request addr
   .cpu_req_data      (mem_wdata_rv),        //- 32-bit request data (used when write)
   .cpu_req_rw        (|mem_wstrb_rv),       //- request type : 0 = read, 1 = write 
   .cpu_req_valid     (cpu_req_valid),       //- request is valid
   //- Cache result (Cache->CPU)
   .cpu_res_data      (mem_rdata_instr),     //- 32-bit data
   .cpu_res_valid     (mem_ready_rv_instr),  //- result is ready
   //- NOC Interface 
   .stream_out_TREADY (stream_out_TREADY_cache),
   .stream_out_TVALID (stream_out_TVALID_cache),
   .stream_out_TDATA  (stream_out_TDATA_cache),
   .stream_out_TKEEP  (stream_out_TKEEP_cache),
   .stream_out_TLAST  (stream_out_TLAST_cache),
   //- NoC memory interface
   .mem_addr          (mem_addr_a),
   .mem_wdata         (mem_wdata_a),
   .mem_wstrb         (mem_wstrb_a),
   .mem_valid         (mem_valid_cache)
);

assign is_data = mem_addr_a < MEM_SZ;            //- Is the NoC address for data or instruction memory?
assign mem_valid_cache = mem_valid_a & ~is_data; //- The NoC writes to instruction memory

/* Signals for data memory */

assign mem_valid_b = (mem_valid_rv & local_mem) | mem_valid_axi; 
assign mem_addr_b  = mem_valid_axi ? mem_addr_axi  : mem_addr_b_32;
assign mem_wdata_b = mem_valid_axi ? mem_wdata_axi : mem_wdata_rv;
assign mem_wstrb_b = mem_valid_axi ? mem_wstrb_axi : |mem_wstrb_rv;

assign mem_valid_data_a  = mem_valid_a & is_data;
assign mem_wstrb_data_a  = mem_wstrb_a & mem_valid_data_a; //- FIXME: 
                                                           // Why valid here? It is important! 
                                                           // Do not remove!
/* NoC Arbiter */

assign tvalid = stream_out_TVALID_cache | stream_out_TVALID_int;

always @(posedge clk_line) begin
   if (~clk_line_rst_low) begin 
      state <= 0;
      cache_valid <= 1'b0;
      int_valid <= 1'b0;
   end else begin
      state <= next_state;
      cache_valid <= next_cache_valid;
      int_valid <= next_int_valid;
   end
end

always @( * ) begin
   //- State
   next_state = state;

   stream_out_TREADY_cache  = 1'b1;
   stream_out_TREADY_int  = 1'b1;

   stream_out_TDATA  = 'h0;
   stream_out_TVALID = 1'b0;
   stream_out_TLAST  = 1'b0;
   stream_out_TKEEP = 'h0;

   next_cache_valid  = cache_valid;
   next_int_valid    = int_valid;

   case (state)
      0: begin
         if (stream_out_TREADY) begin
           if (stream_out_TVALID_cache) begin 
              stream_out_TDATA        = stream_out_TDATA_cache;
              stream_out_TVALID       = stream_out_TVALID_cache;
              stream_out_TKEEP        = stream_out_TKEEP_cache;
              stream_out_TLAST        = 1'b0;
              stream_out_TREADY_cache = 1'b1;
              stream_out_TREADY_int   = 1'b0;
              next_cache_valid        = 1;
            end else if (stream_out_TVALID_int) begin 
              stream_out_TDATA        = stream_out_TDATA_int;
              stream_out_TVALID       = stream_out_TVALID_int;
              stream_out_TKEEP        = stream_out_TKEEP_int;
              stream_out_TLAST        = 1'b0;
              stream_out_TREADY_cache = 1'b0;
              stream_out_TREADY_int   = 1'b1;
              next_int_valid          = 1;
            end
         end else begin
            stream_out_TREADY_cache = 1'b0;
            stream_out_TREADY_int   = 1'b0;
         end
         if (tvalid) next_state = 1;
      end
      1: begin
         if (cache_valid) begin 
            stream_out_TDATA  = stream_out_TDATA_cache;
            stream_out_TVALID = stream_out_TVALID_cache;
            stream_out_TLAST  = stream_out_TLAST_cache;
            stream_out_TKEEP  = stream_out_TKEEP_cache;

            stream_out_TREADY_cache = stream_out_TREADY;
            stream_out_TREADY_int   = 1'b0;

            if (stream_out_TLAST_cache & stream_out_TREADY) begin
               next_state = 0;
               next_cache_valid = 1'b0;
            end
            
         end else if (int_valid) begin 
            stream_out_TDATA  = stream_out_TDATA_int;
            stream_out_TVALID = stream_out_TVALID_int;
            stream_out_TLAST  = stream_out_TLAST_int;
            stream_out_TKEEP  = stream_out_TKEEP_int;

            stream_out_TREADY_cache = 1'b0;
            stream_out_TREADY_int   = stream_out_TREADY;

            if (stream_out_TLAST_int & stream_out_TREADY) begin
               next_state = 0;
               next_int_valid = 1'b0;
            end
         end
      end
   endcase
end

Register #(
  .Width (1)
) mem_valid_rv_data_ready (
  .Clock  (clk_ctrl),
  .Reset  (clk_ctrl_rst_high),
  .Set    (1'b0),
  .Enable (1'b1),
  .In     (mem_valid_b),
  .Out    (mem_ready_rv_data));

`else

assign local_mem = is_array & mem_addr_xy == HsrcId;

assign mem_rdata_a = mem_rdata_data_a;
assign mem_valid_data_a = mem_valid_a;
assign mem_wstrb_data_a = mem_wstrb_a & mem_valid_a;

assign mem_ready_rv = mem_ready_local_rv | mem_ready_outsi_rv;
assign mem_rdata_rv = local_mem_spy ? mem_rdata_data_b : mem_rdata_outsi_rv;

assign mem_valid_b = (mem_valid_rv & local_mem_spy) | mem_valid_axi; 
assign mem_addr_b  = mem_valid_axi ? mem_addr_axi  : {20'h0,mem_addr_b_32[OFFSET_SZ-1:0]};
assign mem_wdata_b = mem_valid_axi ? mem_wdata_axi : mem_wdata_rv;
assign mem_wstrb_b = mem_valid_axi ? mem_wstrb_axi : |mem_wstrb_rv & mem_valid_b;

Register #(
  .Width (1)
) rv_mem_valid_ready_inst (
  .Clock  (clk_ctrl),
  .Reset  (~clk_ctrl_rst_low),
  .Set    (1'b0),
  .Enable (1'b1),
  .In     (mem_valid_rv & local_mem_spy),
  .Out    (mem_ready_local_rv));

assign stream_out_TDATA      = stream_out_TDATA_int;
assign stream_out_TVALID     = stream_out_TVALID_int;
assign stream_out_TLAST      = stream_out_TLAST_int;
assign stream_out_TKEEP      = stream_out_TKEEP_int;
assign stream_out_TREADY_int = stream_out_TREADY;

`endif

/* 
* For case 1: Instrucion and Data memory
* For case 2: Data memory
* Port B is used by processor
* Port A is used by NoC
*/

logic [31:0] mem_addr_a_short;
assign mem_addr_a_short = {20'h0,mem_addr_a[OFFSET_SZ-1:0]};


DPRAM #(
  .ADDR_W     (32),
  .DATA_W     (32),
  .MEMSIZE_KB (16)
) dp_ram (
  .clk   ({clk_ctrl,         clk_line}),
  .rst_n ({clk_ctrl_rst_low, clk_line_rst_low}),
  .en    ({mem_valid_b,      mem_valid_data_a}),
  .we    ({mem_wstrb_b,      mem_wstrb_data_a}),
  .addr  ({mem_addr_b,       mem_addr_a_short}),  
  .din   ({mem_wdata_b,      mem_wdata_a}),
  .dout  ({mem_rdata_data_a, mem_rdata_data_b}));  


/* PICORV instantiation */

picorv32#(
   .ENABLE_PCPI       (1'b1),
   .COMPRESSED_ISA    (1'b1),
   .ENABLE_FAST_MUL   (1'b1),
   .ENABLE_DIV        (1'b1),
   .ENABLE_COUNTERS   (1'b1),
   .ENABLE_COUNTERS64 (1'b1),
   .BARREL_SHIFTER    (1'b1)
) picorv32 (
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
   .XY_SZ             (XY_SZ)
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
   .mem_addr_rv       (mem_addr_b_32),      //- Input 
   .mem_wdata_rv      (mem_wdata_rv),       //- Input
   .mem_wstrb_rv      (|mem_wstrb_rv),      //- Input
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

/*
12- 4096 - 16KBits - For data
*/

