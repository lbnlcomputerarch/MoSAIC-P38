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
// Date        : Jan 27 2021
// Description : Message and memory managers 
// File        : qISAExtension.sv
////////////////////////////////////////////////

`timescale 1 ps / 1 ps

module qISAExtension#(
   parameter OFFSET_SZ         = 11,
   parameter MQ_ADDR_W         =  9,
   parameter MQ_MEMSIZE_KB     =  2,  // Inbound FIFO size 2kB/4=512, 1<<9 = 512
   parameter NOC_BUFFER_ADDR_W =  8,
   parameter XY_SZ             =  3
)(
  //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_line,
   input  logic       clk_ctrl_rst_low,
   input  logic       clk_line_rst_low,
   input  logic       clk_line_rst_high,
   input  logic       clk_ctrl_rst_high,
   input  logic [(XY_SZ*2)-1:0] HsrcId,     //- Tile identification
   //---Processor Interface---//
   input  logic        pcpi_valid,
   input  logic [31:0] pcpi_insn,
   input  logic [31:0] pcpi_rs1,
   input  logic [31:0] pcpi_rs2,
   output logic        pcpi_wr,
   output logic [31:0] pcpi_rd,
   output logic        pcpi_wait,
   output logic        pcpi_ready,
   //---NOC interface---//
   //- Input Interface
   input  logic        stream_in_TVALID,
   input  logic [31:0] stream_in_TDATA,
   input  logic [ 3:0] stream_in_TKEEP, 
   input  logic        stream_in_TLAST,
   output logic        stream_in_TREADY,  
   //- Output Interface
   input  logic        stream_out_TREADY,
   output logic        stream_out_TVALID,
   output logic [31:0] stream_out_TDATA,
   output logic [ 3:0] stream_out_TKEEP,
   output logic        stream_out_TLAST,
   //---Memory Interface---//
   input  logic        local_mem, 
   //- Memory port A (Memory Manager)
   input  logic [31:0] mem_rdata_a,
   output logic [31:0] mem_addr_a,
   output logic [31:0] mem_wdata_a, 
   output logic        mem_wstrb_a, 
   output logic        mem_valid_a,
   //- Spying on the Processor-memory Interface 
   output logic [31:0] mem_rdata_rv,
   output logic        mem_ready_rv,
   input  logic [31:0] mem_addr_rv,
   input  logic [31:0] mem_wdata_rv, 
   input  logic        mem_wstrb_rv, 
   input  logic        mem_valid_rv //,
);

localparam FIFO_ADDR_SZ     = 9; 
localparam FIFO_WRITE_DEPTH = 1 << MQ_ADDR_W;
localparam ADDR_W = 10;
//***************************
//* The connections 
//****************************


logic        fifo_0A_en,   fifo_0B_en;
logic [31:0] fifo_0A_addr, fifo_0B_addr;
logic [31:0] fifo_0A_dout, fifo_0B_dout;
logic        fifo_0_empty;
logic        fifo_0_full;

logic        stream_in_TVALID_int;
logic [31:0] stream_in_TDATA_int;
logic [ 3:0] stream_in_TKEEP_int; 
logic        stream_in_TLAST_int;
logic        stream_in_TREADY_int;

logic        stream_out_dec_TVALID;
logic [31:0] stream_out_dec_TDATA;
logic [ 3:0] stream_out_dec_TKEEP; 
logic        stream_out_dec_TLAST;
logic        stream_out_dec_TREADY;

logic        stream_out_dec_TVALID_int;
logic [31:0] stream_out_dec_TDATA_int;
logic [ 3:0] stream_out_dec_TKEEP_int; 
logic        stream_out_dec_TLAST_int;
logic        stream_out_dec_TREADY_int; 

logic        stream_out_pcpi_TVALID;
logic [31:0] stream_out_pcpi_TDATA;
logic [ 3:0] stream_out_pcpi_TKEEP; 
logic        stream_out_pcpi_TLAST;
logic        stream_out_pcpi_TREADY; 

logic        stream_out_mem_TVALID;
logic [31:0] stream_out_mem_TDATA;
logic [ 3:0] stream_out_mem_TKEEP; 
logic        stream_out_mem_TLAST;
logic        stream_out_mem_TREADY; 

logic        stream_out_spy_TVALID;
logic [31:0] stream_out_spy_TDATA;
logic [ 3:0] stream_out_spy_TKEEP; 
logic        stream_out_spy_TLAST;
logic        stream_out_spy_TREADY; 

//***************************
//* Que comience la fiesta
//* Start the code 
//***************************

//- The data from the NoC is received
//  in a FIFO.  

noc_buffer_in#(
   .ADDR_W (NOC_BUFFER_ADDR_W)
) noc_buffer_in(
   .clk_in            (clk_line),
   .clk_in_rst_low    (clk_line_rst_low),
   .clk_in_rst_high   (clk_line_rst_high),
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



noc_decoder noc_decoder(
   //- Clock and reset
   .clk_ctrl         (clk_ctrl),
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
   .stream_out_TREADY (stream_out_dec_TREADY_int),
   .stream_out_TVALID (stream_out_dec_TVALID_int),
   .stream_out_TDATA  (stream_out_dec_TDATA_int),
   .stream_out_TKEEP  (stream_out_dec_TKEEP_int),
   .stream_out_TLAST  (stream_out_dec_TLAST_int),
   .unblock           (unblock),
   .spy_idle          (spy_idle),
   .pcpi_idle         (pcpi_idle),
   .fifo_0_full       (fifo_0_full),
   .fifo_0A_en        (fifo_0A_en),
   .fifo_0A_addr      (fifo_0A_addr),
   .mem_rdata_a       (mem_rdata_a),
   .mem_addr_a        (mem_addr_a),
   .mem_wdata_a       (mem_wdata_a),
   .mem_wstrb_a       (mem_wstrb_a),
   .mem_valid_a       (mem_valid_a),
   .mem_rdata_rv      (mem_rdata_rv)
);

//////////////////////////////
// Buffer NoC data
//////////////////////////////

noc_buffer_out#(
   .ADDR_W (NOC_BUFFER_ADDR_W-2)
) noc_buffer_out(
   .clk_in            (clk_ctrl),
   .clk_in_rst_low    (clk_ctrl_rst_low),
   .clk_in_rst_high   (clk_ctrl_rst_high),
   .clk_out           (clk_line),
   .clk_out_rst_low   (clk_line_rst_low),
   .stream_in_TVALID  (stream_out_dec_TVALID_int),
   .stream_in_TDATA   (stream_out_dec_TDATA_int),
   .stream_in_TKEEP   (stream_out_dec_TKEEP_int),
   .stream_in_TLAST   (stream_out_dec_TLAST_int),
   .stream_in_TREADY  (stream_out_dec_TREADY_int),
   .stream_out_TVALID (stream_out_dec_TVALID),
   .stream_out_TDATA  (stream_out_dec_TDATA),
   .stream_out_TKEEP  (stream_out_dec_TKEEP),
   .stream_out_TLAST  (stream_out_dec_TLAST),
   .stream_out_TREADY (stream_out_dec_TREADY)
);

qISAExtension_pcpi#(
   .NOC_BUFFER_ADDR_W (NOC_BUFFER_ADDR_W-2)
) qISAExtension_pcpi(
   //- Clock and reset
   .clk_ctrl         (clk_ctrl),
   .clk_ctrl_rst_low (clk_ctrl_rst_low), 
   .clk_line         (clk_line),
   .clk_line_rst_low (clk_line_rst_low), 
   .clk_ctrl_rst_high (clk_ctrl_rst_high), 
   //- Tile identification
   .HsrcId           (HsrcId),
   //- NOC interface
   //- Output Interface: Switch reading from memory manager
   .stream_out_pcpi_TREADY (stream_out_pcpi_TREADY),
   .stream_out_pcpi_TVALID (stream_out_pcpi_TVALID),
   .stream_out_pcpi_TDATA  (stream_out_pcpi_TDATA),
   .stream_out_pcpi_TKEEP  (stream_out_pcpi_TKEEP),
   .stream_out_pcpi_TLAST  (stream_out_pcpi_TLAST),
   .stream_out_mem_TREADY (stream_out_mem_TREADY),
   .stream_out_mem_TVALID (stream_out_mem_TVALID),
   .stream_out_mem_TDATA  (stream_out_mem_TDATA),
   .stream_out_mem_TKEEP  (stream_out_mem_TKEEP),
   .stream_out_mem_TLAST  (stream_out_mem_TLAST),
   //- FIFO Interface
   .fifo_0B_en        (fifo_0B_en),
   .fifo_0B_addr      (fifo_0B_addr),
   .fifo_0B_dout      (fifo_0B_dout),
   .fifo_0_empty      (fifo_0_empty),
   .fifo_0_full       (fifo_0_full),
   //- PCPI Processor Interface
   .pcpi_valid        (pcpi_valid),
   .pcpi_insn         (pcpi_insn),
   .pcpi_rs1          (pcpi_rs1),
   .pcpi_rs2          (pcpi_rs2),
   .pcpi_wr           (pcpi_wr),
   .pcpi_rd           (pcpi_rd),
   .pcpi_wait         (pcpi_wait),
   .pcpi_ready        (pcpi_ready),
   .pcpi_idle         (pcpi_idle));


//assign mem_rdata_rv = stream_in_TDATA_int; //FIXME;

mem_spy#(
   .NOC_BUFFER_ADDR_W (NOC_BUFFER_ADDR_W-2)
) mem_spy(
   //---Clock and Reset---//
   .clk_ctrl          (clk_ctrl),
   .clk_line          (clk_line),
   .clk_ctrl_rst_low  (clk_ctrl_rst_low), 
   .clk_line_rst_low  (clk_line_rst_low), 
   .clk_ctrl_rst_high (clk_ctrl_rst_high), 
   //- Tile identification
   .HsrcId            (HsrcId),
   .local_mem         (local_mem),
   .mem_valid_rv      (mem_valid_rv),       //- Input
   .mem_ready_rv      (mem_ready_rv), //- Output
   .mem_addr_rv       (mem_addr_rv),      //- Input 
   .mem_wdata_rv      (mem_wdata_rv),       //- Input
   .mem_wstrb_rv      (|mem_wstrb_rv),      //- Input
   .unblock           (unblock),
   .spy_idle          (spy_idle),
   .stream_out_TREADY (stream_out_spy_TREADY),
   .stream_out_TVALID (stream_out_spy_TVALID),
   .stream_out_TDATA  (stream_out_spy_TDATA),
   .stream_out_TKEEP  (stream_out_spy_TKEEP),
   .stream_out_TLAST  (stream_out_spy_TLAST));


//- Inbound Message Queue
//- Only for message Queues
//- A: NoC writes
//- B: Processor reads
DPRAM #(
  .ADDR_W     (MQ_ADDR_W),
  .DATA_W     (32),
  .MEMSIZE_KB (MQ_MEMSIZE_KB)
) fifo_0_ram (
  .clk   ({clk_ctrl,         clk_ctrl}),
  .rst_n ({clk_ctrl_rst_low, clk_ctrl_rst_low}),
  .en    ({fifo_0A_en,       fifo_0B_en}),
  .we    ({fifo_0A_en,       1'b0}),
  .addr  ({fifo_0A_addr[MQ_ADDR_W-1:0], fifo_0B_addr[MQ_ADDR_W-1:0]}),
  .din   ({stream_in_TDATA_int, 32'h0}),
  .dout  ({fifo_0B_dout,     fifo_0A_dout})
);
assign fifo_0_empty = fifo_0A_addr >= fifo_0B_addr ? fifo_0A_addr - fifo_0B_addr == 0 : fifo_0A_addr + FIFO_WRITE_DEPTH - fifo_0B_addr <= 1;
assign fifo_0_full  = fifo_0A_addr >  fifo_0B_addr ? fifo_0A_addr - fifo_0B_addr == FIFO_WRITE_DEPTH - 1 : fifo_0B_addr - fifo_0A_addr == 'h1; 

noc_out_arbiter noc_out_arbiter (
   .clk_line_rst_low      (clk_line_rst_low),
   .clk_line              (clk_line),
   .stream_in_pcpi_TREADY (stream_out_pcpi_TREADY),
   .stream_in_pcpi_TVALID (stream_out_pcpi_TVALID),
   .stream_in_pcpi_TDATA  (stream_out_pcpi_TDATA),
   .stream_in_pcpi_TKEEP  (stream_out_pcpi_TKEEP),
   .stream_in_pcpi_TLAST  (stream_out_pcpi_TLAST),
   .stream_in_mem_TREADY  (stream_out_mem_TREADY),
   .stream_in_mem_TVALID  (stream_out_mem_TVALID),
   .stream_in_mem_TDATA   (stream_out_mem_TDATA),
   .stream_in_mem_TKEEP   (stream_out_mem_TKEEP),
   .stream_in_mem_TLAST   (stream_out_mem_TLAST),
   .stream_in_spy_TREADY  (stream_out_spy_TREADY),
   .stream_in_spy_TVALID  (stream_out_spy_TVALID),
   .stream_in_spy_TDATA   (stream_out_spy_TDATA),
   .stream_in_spy_TKEEP   (stream_out_spy_TKEEP),
   .stream_in_spy_TLAST   (stream_out_spy_TLAST),
   .stream_in_noc_TREADY  (stream_out_dec_TREADY),
   .stream_in_noc_TVALID  (stream_out_dec_TVALID),
   .stream_in_noc_TDATA   (stream_out_dec_TDATA),
   .stream_in_noc_TKEEP   (stream_out_dec_TKEEP),
   .stream_in_noc_TLAST   (stream_out_dec_TLAST),
   .stream_out_TREADY     (stream_out_TREADY),
   .stream_out_TVALID     (stream_out_TVALID),
   .stream_out_TDATA      (stream_out_TDATA),
   .stream_out_TKEEP      (stream_out_TKEEP),
   .stream_out_TLAST      (stream_out_TLAST));

endmodule


