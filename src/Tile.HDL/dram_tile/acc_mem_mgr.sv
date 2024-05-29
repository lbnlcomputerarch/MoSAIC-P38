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
// Description : Logic for memory manager
// File        : acc_mem_mgr.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps
`include "global_defines.sv"
module acc_mem_mgr#(
   parameter OFFSET_SZ    = 12,
   parameter XY_SZ        =  3,
   parameter S_AXI_ID_SZ  = 11,
   parameter S_AXI_ADR_SZ = 29, // ADDRESS
   parameter S_AXI_LEN_SZ = 8,  // LENGTH
   parameter S_AXI_SZE_SZ = 3,  // SIZE
   parameter S_AXI_BRT_SZ = 2,  // BURST
   parameter S_AXI_DAT_SZ = 512,// DATA
   parameter S_AXI_STB_SZ = 64, // STROBE
   parameter S_AXI_RSP_SZ = 2,  // RESPONSE
   parameter S_AXI_CAC_SZ = 4,  // RESPONSE
   parameter S_AXI_PRT_SZ = 3,  // RESPONSE
   parameter S_AXI_QOS_SZ = 4,   // RESPONSE 
   parameter CDC_SYNC_STAGES = 4, //- For synch between ctrl and mem clock domains
   parameter BW = 32,
   parameter BWB= 32/8
)(
  //---Clock and Reset---//
   input  logic                 clk_mem,  //- Logic
   input  logic                 clk_line, //- NoC
   input  logic                 clk_ctrl, //- AXI bus
   input  logic                 clk_mem_rst_low,
   input  logic                 clk_line_rst_low,
   input  logic                 clk_mem_rst_high,
   input  logic                 clk_ctrl_rst_high,
   input  logic                 clk_line_rst_high,
   input  logic [(XY_SZ*2)-1:0] HsrcId,     //- Tile identification
   input  logic          [7:0] rvControl,
   
   //---NOC interface---//
   //- Input Interface
   input  logic           stream_in_TVALID,
   input  logic  [BW-1:0] stream_in_TDATA,
   input  logic [BWB-1:0] stream_in_TKEEP, 
   input  logic           stream_in_TLAST,
   output logic           stream_in_TREADY,  
   //- Output Interface
   input  logic stream_out_TREADY,
   output logic stream_out_TVALID,
   output logic  [BW-1:0] stream_out_TDATA,
   output logic [BWB-1:0] stream_out_TKEEP,
   output logic stream_out_TLAST,
  //- AXI Bus (from open-nic-shell) memory interface 
   input  logic        mem_valid_axi,
   input  logic [31:0] mem_addr_axi,
   input  logic [31:0] mem_wdata_axi, 
   input  logic        mem_wstrb_axi, 
   output logic [31:0] mem_rdata_axi,
   //- AXI memory controller 
  //- ADDRESS WRITE
  input  logic                    s_axi_awready,
  output logic                    s_axi_awvalid,
  output logic  [S_AXI_ID_SZ-1:0] s_axi_awid,
  output logic [S_AXI_ADR_SZ-1:0] s_axi_awaddr,
  output logic [S_AXI_LEN_SZ-1:0] s_axi_awlen,
  output logic [S_AXI_SZE_SZ-1:0] s_axi_awsize,
  output logic [S_AXI_BRT_SZ-1:0] s_axi_awburst,
  output logic                    s_axi_awlock,
  output logic [S_AXI_CAC_SZ-1:0] s_axi_awcache,
  output logic [S_AXI_PRT_SZ-1:0] s_axi_awprot,
  output logic [S_AXI_QOS_SZ-1:0] s_axi_awqos,
  //- DATA WRITE
  input  logic                    s_axi_wready,
  output logic                    s_axi_wvalid,
  output logic                    s_axi_wlast,
  output logic [S_AXI_DAT_SZ-1:0] s_axi_wdata,
  output logic [S_AXI_STB_SZ-1:0] s_axi_wstrb,
  //- VALID WRITE
  output  logic                    s_axi_bready,
  input logic                    s_axi_bvalid,
  input logic [S_AXI_ID_SZ-1:0]  s_axi_bid,
  input logic [S_AXI_RSP_SZ-1:0] s_axi_bresp,
  //- ADDRESS READ
  input  logic                    s_axi_arready,
  output logic                    s_axi_arvalid,
  output logic [S_AXI_ID_SZ-1:0]  s_axi_arid,
  output logic [S_AXI_ADR_SZ-1:0] s_axi_araddr,
  output logic [S_AXI_LEN_SZ-1:0] s_axi_arlen,
  output logic [S_AXI_SZE_SZ-1:0] s_axi_arsize,
  output logic [S_AXI_BRT_SZ-1:0] s_axi_arburst,
  output logic                    s_axi_arlock,
  output logic [S_AXI_CAC_SZ-1:0] s_axi_arcache,
  output logic [S_AXI_PRT_SZ-1:0] s_axi_arprot,
  output logic [S_AXI_QOS_SZ-1:0] s_axi_arqos,
  //- RESPONSE READ
  output logic                    s_axi_rready,
  input  logic                    s_axi_rvalid,
  input  logic                    s_axi_rlast,
  input  logic [S_AXI_DAT_SZ-1:0] s_axi_rdata,
  input  logic [S_AXI_ID_SZ-1:0]  s_axi_rid,
  input  logic [S_AXI_RSP_SZ-1:0] s_axi_rresp
);

/***************************
* Local parameters for FSMs
****************************/

//- Memory parameters 
localparam CACHE_LINES  = `CACHE_LINES;
localparam  CPU_BUS_SZ = 32;
localparam  MEM_BUS_SZ = 512;

logic           stream_in_TVALID_int;
logic  [BW-1:0] stream_in_TDATA_int;
logic [BWB-1:0] stream_in_TKEEP_int; 
logic           stream_in_TLAST_int;
logic           stream_in_TREADY_int; 

logic            stream_out_TVALID_int;
logic   [BW-1:0] stream_out_TDATA_int;
logic [ BWB-1:0] stream_out_TKEEP_int; 
logic            stream_out_TLAST_int;
logic            stream_out_TREADY_int;

//- CPU-CACHE interface
logic cpu_req_valid; //- Cache input
logic cpu_req_rw;    //- Cache input
logic [BW-1:0]           cpu_req_data;  //- Cache input
logic [BW-1:0]           cpu_req_addr;    //- Cache input
logic [S_AXI_ID_SZ-1:0]  cpu_req_id;      //- Cache input
logic [S_AXI_LEN_SZ-1:0] cpu_req_len; //-
logic cpu_req_ready; //- Cache output

//- Open-nic-shell aXI bus memory interface
logic                    cpu_req_valid_dec; //- Cache input
logic                    cpu_req_rw_dec;    //- Cache input
logic [BW-1:0]           cpu_req_data_dec;  //- Cache input
logic [BW-1:0]           cpu_req_addr_dec;  //- Cache input
logic [S_AXI_ID_SZ-1:0]  cpu_req_id_dec;    //- Cache input
logic [S_AXI_LEN_SZ-1:0] cpu_req_len_dec;   //-


logic [BW-1:0] cpu_res_data;
logic [BW-1:0] header1; 
logic [BW-1:0] data1;

//- MEM. CTRL - CACHE
logic [MEM_BUS_SZ-1:0] mem_data_data;  //- Cache input
logic                  mem_data_ready; //- Cache input

//- CACHE-MEM. CTRL saved interface
logic [CPU_BUS_SZ-1:0] mem_req_addr;   //- Cache output
logic [MEM_BUS_SZ-1:0] mem_req_data;   //- Cache output 
logic mem_req_rw;     //- Cache output 
logic mem_req_valid;  //- Cache output 
logic  [S_AXI_ID_SZ-1:0] mem_req_id;     //- Cache output 
logic [S_AXI_LEN_SZ-1:0] mem_req_len; //-

//- AXI control bus
logic mem_valid_axi_fast;
logic [31:0] mem_addr_axi_fast;  
logic [31:0] mem_wdata_axi_fast;
logic [S_AXI_ID_SZ-1:0] mem_req_id_axi_fast;
logic axi_in_en;
logic [31:0] mem_addr_axi_last;
logic mem_valid_axi_one;

always @(posedge clk_ctrl) begin
   if (clk_ctrl_rst_high)
      mem_addr_axi_last <= 32'hFFFFFFFF;
   else if (mem_valid_axi & mem_wstrb_axi) mem_addr_axi_last <= mem_addr_axi;
end

always @(posedge clk_ctrl) begin
   if (clk_ctrl_rst_high)
      mem_valid_axi_one <= 1'b0;
   else if ((mem_addr_axi_last != mem_addr_axi) & mem_valid_axi) 
      mem_valid_axi_one <= 1'b1;
   else 
      mem_valid_axi_one <= 1'b0;
end

always @(posedge clk_mem) begin
   if (~clk_mem_rst_low) axi_in_en <= 1'b0;
   else if (axi_in_en) axi_in_en <= 1'b0;
   else if (~axi_in_empty & cpu_req_ready) axi_in_en <= 1'b1;
end

//- Delayed version of axi_in_en
always @(posedge clk_mem) begin
   if (~clk_mem_rst_low) mem_valid_axi_fast <= 1'b0;
   else mem_valid_axi_fast <= axi_in_en;
end


always @(posedge clk_mem) begin
  if (clk_mem_rst_high) mem_req_id_axi_fast <= 'h0;
  else if (mem_valid_axi_fast) mem_req_id_axi_fast <= mem_req_id_axi_fast + 'h1;
end


xpm_fifo_async# (
   // Common module parameters
   .FIFO_MEMORY_TYPE     ( "auto"),
   .ECC_MODE             ( "no_ecc"),
   .RELATED_CLOCKS       ( 0),
   .SIM_ASSERT_CHK       ( 0),
   .CASCADE_HEIGHT       ( 0),
   .FIFO_WRITE_DEPTH     ( 16),
   .WRITE_DATA_WIDTH     ( 64),
   .WR_DATA_COUNT_WIDTH  ( 4),
   .USE_ADV_FEATURES     ( "0707"),
   .READ_MODE            ( "std"),
   .FIFO_READ_LATENCY    ( 1),
   .READ_DATA_WIDTH      ( 64),
   .RD_DATA_COUNT_WIDTH  ( 4),
   .DOUT_RESET_VALUE     ( "0"),
   .CDC_SYNC_STAGES      ( 4),
   .WAKEUP_TIME          ( 0)
) xpm_fifo_async (
   // Common module ports
   .sleep          (1'b0),
   .rst            (clk_ctrl_rst_high),
   // Write Domain ports
   .wr_clk         (clk_ctrl),
   .wr_en          (mem_valid_axi_one),
   .din            ({mem_addr_axi, mem_wdata_axi}),
   .full           (axi_in_full),
   .prog_full      (),
   .wr_data_count  (),
   .overflow       (),
   .wr_rst_busy    (),
   .almost_full    (),
   .wr_ack         (),
   // Read Domain ports
   .rd_clk        (clk_mem),
   .rd_en         (axi_in_en),
   .dout          ({mem_addr_axi_fast, mem_wdata_axi_fast}),
   .empty         (axi_in_empty),
   .prog_empty    (),
   .rd_data_count (),
   .underflow     (),
   .rd_rst_busy   (),
   .almost_empty  (),
   .data_valid    (),
   // ECC Related ports
   .injectsbiterr (1'b0),
   .injectdbiterr (1'b0),
   .sbiterr       (),
   .dbiterr       ()
);


/*Temporal MacGyver*/
assign cpu_req_valid = ~rvControl[0] ? mem_valid_axi_fast : cpu_req_valid_dec;
assign cpu_req_data  = ~rvControl[0] ? mem_wdata_axi_fast  : cpu_req_data_dec;
assign cpu_req_rw    = ~rvControl[0] ? 1  : cpu_req_rw_dec; 
assign cpu_req_addr  = ~rvControl[0] ? mem_addr_axi_fast << 2 : cpu_req_addr_dec;  
assign cpu_req_id    = ~rvControl[0] ? mem_req_id_axi_fast : cpu_req_id_dec;
assign cpu_req_len   = ~rvControl[0] ? 1                   : cpu_req_len_dec;
assign mem_rdata_axi = 'h0; //- FIXME: synchronization issues.

noc_buffer_in noc_buffer(
   .clk_in            (clk_line),
   .clk_in_rst_high   (clk_line_rst_high),
   .clk_in_rst_low    (clk_line_rst_low),
   .clk_out           (clk_mem),
   .clk_out_rst_low   (clk_mem_rst_low),
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


mem_mgr_noc_decoder mem_mgr_noc_decoder(
   //- Clock and reset
   .clk_ctrl         (clk_mem),
   .clk_ctrl_rst_low (clk_mem_rst_low), 
   //- NOC interface
   //- Input Interface: Switch writing to the memory manager 
   .stream_in_TVALID  (stream_in_TVALID_int),
   .stream_in_TDATA   (stream_in_TDATA_int),
   .stream_in_TKEEP   (stream_in_TKEEP_int), 
   .stream_in_TLAST   (stream_in_TLAST_int),
   .stream_in_TREADY  (stream_in_TREADY_int),
    //- CPU request (CPU -> Cache)
   .cpu_req_addr   (cpu_req_addr_dec),  // 32-bit request addr
   .cpu_req_data   (cpu_req_data_dec),  // 32-bit request data (used when write)
   .cpu_req_rw     (cpu_req_rw_dec),    // request type : 0 = read, 1 = write 
   .cpu_req_valid  (cpu_req_valid_dec), // request is valid
   .cpu_req_ready  (cpu_req_ready), 
   .cpu_req_id     (cpu_req_id_dec),
   .cpu_req_len    (cpu_req_len_dec),
   .header1        (header1),
   .data1          (data1)
);

//////////////////////////////
// Cache
//////////////////////////////

dm_cache_fsm #(
  .CPU_BUS_SZ (CPU_BUS_SZ),
  .MEM_BUS_SZ (MEM_BUS_SZ)
)dm_cache_fsm_inst(
   .clk            (clk_mem),
   .rst            (~clk_mem_rst_low),
   //- CPU request (CPU -> Cache)
   .cpu_req_addr   (cpu_req_addr),  // 32-bit request addr
   .cpu_req_data   (cpu_req_data),  // 32-bit request data (used when write)
   .cpu_req_rw     (cpu_req_rw),    // request type : 0 = read, 1 = write 
   .cpu_req_valid  (cpu_req_valid), // request is valid
   .cpu_req_ready  (cpu_req_ready), // Output 
   .cpu_req_id     (cpu_req_id),
   .cpu_req_len    (cpu_req_len),
   //- Memory response (Memory -> Cache)
   .mem_data_data  (mem_data_data),
   .mem_data_ready (mem_data_ready),
   //- Memory request (Cache->Memory)
   .mem_req_addr   (mem_req_addr),  // request byte addr
   .mem_req_data   (mem_req_data),  // 128-.request data (used when write)
   .mem_req_rw     (mem_req_rw),    // request type : 0=read, 1=write
   .mem_req_valid  (mem_req_valid), // request is valid
   .mem_req_id     (mem_req_id),
   .mem_req_len    (mem_req_len),
   //- Cache result (Cache->CPU)
   .cpu_res_data   (cpu_res_data),  //32-bit data
   .cpu_res_ready  (cpu_res_ready), //
   .cpu_res_valid  (cpu_res_valid)  // result is ready
);

///////////////////////////////
// AXI Manager
///////////////////////////////

mem_mgr_axi#(
   .S_AXI_ADR_SZ (S_AXI_ADR_SZ)
) mem_mgr_axi (
   .clk_ctrl         (clk_mem),
   .clk_ctrl_rst_low (clk_mem_rst_low),
   //- Memory response (Memory -> Cache)
   .mem_data_data  (mem_data_data),
   .mem_data_ready (mem_data_ready),
   //- Memory request (Cache->Memory)
   .mem_req_addr   (mem_req_addr),  // request byte addr
   .mem_req_data   (mem_req_data),  // 128-.request data (used when write)
   .mem_req_rw     (mem_req_rw),    // request type : 0=read, 1=write
   .mem_req_valid  (mem_req_valid), // request is valid
   .mem_req_id     (mem_req_id),
   .mem_req_len    (mem_req_len),
  //- MEMORY CONTROLLER
  //- ADDRESS WRITE
   .s_axi_awready  (s_axi_awready),
   .s_axi_awvalid  (s_axi_awvalid),
   .s_axi_awid     (s_axi_awid),
   .s_axi_awaddr   (s_axi_awaddr),
   .s_axi_awlen    (s_axi_awlen),
   .s_axi_awsize   (s_axi_awsize),
   .s_axi_awburst  (s_axi_awburst),
   .s_axi_awlock   (s_axi_awlock),
   .s_axi_awcache  (s_axi_awcache),
   .s_axi_awprot   (s_axi_awprot),
   .s_axi_awqos    (s_axi_awqos),
  //- DATA WRITE
   .s_axi_wready  (s_axi_wready),
   .s_axi_wvalid  (s_axi_wvalid),
   .s_axi_wlast   (s_axi_wlast),
   .s_axi_wdata   (s_axi_wdata),
   .s_axi_wstrb   (s_axi_wstrb),
  //- VALID WRITE
   .s_axi_bready  (s_axi_bready),
   .s_axi_bvalid  (s_axi_bvalid),
   .s_axi_bid     (s_axi_bid),
   .s_axi_bresp   (s_axi_bresp),
  //- ADDRESS READ
   .s_axi_arready (s_axi_arready),
   .s_axi_arvalid (s_axi_arvalid),
   .s_axi_arid    (s_axi_arid),
   .s_axi_araddr  (s_axi_araddr),
   .s_axi_arlen   (s_axi_arlen),
   .s_axi_arsize  (s_axi_arsize),
   .s_axi_arburst (s_axi_arburst),
   .s_axi_arlock  (s_axi_arlock),
   .s_axi_arcache (s_axi_arcache),
   .s_axi_arprot  (s_axi_arprot),
   .s_axi_arqos   (s_axi_arqos),
  //- RESPONSE READ
   .s_axi_rready  (s_axi_rready),
   .s_axi_rvalid  (s_axi_rvalid),
   .s_axi_rlast   (s_axi_rlast),
   .s_axi_rdata   (s_axi_rdata),
   .s_axi_rid     (s_axi_rid),
   .s_axi_rresp   (s_axi_rresp));

///////////////////////////////
// NOC encoder
///////////////////////////////

mem_mgr_noc_encoder mem_mgr_noc_encoder(
   .clk_ctrl          (clk_mem),
   .clk_ctrl_rst_low  (clk_mem_rst_low),
   //- Tile identification
   .HsrcId            (HsrcId),
   .header1           (header1),
   .data1             (data1),
   .stream_out_TVALID (stream_out_TVALID_int),
   .stream_out_TDATA  (stream_out_TDATA_int),
   .stream_out_TKEEP  (stream_out_TKEEP_int),
   .stream_out_TLAST  (stream_out_TLAST_int),
   .stream_out_TREADY (stream_out_TREADY_int),
   .cpu_res_valid     (cpu_res_valid & rvControl[0]),
   .cpu_res_data      (cpu_res_data),
   .cpu_res_ready     (cpu_res_ready)
);

//////////////////////////////
// Buffer NoC data
//////////////////////////////


noc_buffer_out#(
   .USE_IP (1)
) noc_buffer_out(
   .clk_in            (clk_mem),
   .clk_in_rst_high   (clk_mem_rst_high),
   .clk_in_rst_low    (clk_mem_rst_low),
   .clk_out           (clk_line),
   .clk_out_rst_low   (clk_line_rst_low),
   .stream_in_TVALID  (stream_out_TVALID_int),
   .stream_in_TDATA   (stream_out_TDATA_int),
   .stream_in_TKEEP   (stream_out_TKEEP_int),
   .stream_in_TLAST   (stream_out_TLAST_int),
   .stream_in_TREADY  (stream_out_TREADY_int),
   .stream_out_TVALID (stream_out_TVALID),
   .stream_out_TDATA  (stream_out_TDATA),
   .stream_out_TKEEP  (stream_out_TKEEP),
   .stream_out_TLAST  (stream_out_TLAST),
   .stream_out_TREADY (stream_out_TREADY)
);

endmodule

