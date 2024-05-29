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

/////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : April 25 2022
// Description : Testbench file for DDR4
// File        : tb_memory_controller.sv
// Notes       : 
//  - Chris N. brought up the DDR4 memory model
//  - Chris N. provided the script to setup the Xilinx memory 
//    controller
////////////////////////////////////////////////////////////////

module tb_memory_controller#(
   parameter S_AXI_ID_SZ  = 11,
   parameter S_AXI_ADR_SZ = 34, // ADDRESS
   parameter S_AXI_LEN_SZ = 8,  // LENGTH
   parameter S_AXI_SZE_SZ = 3,  // SIZE
   parameter S_AXI_BRT_SZ = 2,  // BURST
   parameter S_AXI_DAT_SZ = 512,// DATA
   parameter S_AXI_STB_SZ = 64, // STROBE
   parameter S_AXI_RSP_SZ = 2,  // RESPONSE
   parameter S_AXI_CAC_SZ = 4,  // RESPONSE
   parameter S_AXI_PRT_SZ = 3,  // RESPONSE
   parameter S_AXI_QOS_SZ = 4   // RESPONSE
)(
   //- ADDRESS WRITE
   output logic                    s_axi_awready,
   input  logic                    s_axi_awvalid,
   input  logic [S_AXI_ID_SZ-1:0]  s_axi_awid,
   input  logic [S_AXI_ADR_SZ-1:0] s_axi_awaddr,
   input  logic [S_AXI_LEN_SZ-1:0] s_axi_awlen,
   input  logic [S_AXI_SZE_SZ-1:0] s_axi_awsize,
   input  logic [S_AXI_BRT_SZ-1:0] s_axi_awburst,
   input  logic                    s_axi_awlock,
   input  logic [S_AXI_CAC_SZ-1:0] s_axi_awcache,
   input  logic [S_AXI_PRT_SZ-1:0] s_axi_awprot,
   input  logic [S_AXI_QOS_SZ-1:0] s_axi_awqos,
   //- DATA WRITE
   output logic                    s_axi_wready,
   input  logic                    s_axi_wvalid,
   input  logic                    s_axi_wlast,
   input  logic [S_AXI_DAT_SZ-1:0] s_axi_wdata,
   input  logic [S_AXI_STB_SZ-1:0] s_axi_wstrb,
   //- VALID WRITE
   input  logic                    s_axi_bready,
   output logic                    s_axi_bvalid,
   output logic [S_AXI_ID_SZ-1:0]  s_axi_bid,
   output logic [S_AXI_RSP_SZ-1:0] s_axi_bresp,
   //- ADDRESS READ
   output logic                    s_axi_arready,
   input  logic                    s_axi_arvalid,
   input  logic [S_AXI_ID_SZ-1:0]  s_axi_arid,
   input  logic [S_AXI_ADR_SZ-1:0] s_axi_araddr,
   input  logic [S_AXI_LEN_SZ-1:0] s_axi_arlen,
   input  logic [S_AXI_SZE_SZ-1:0] s_axi_arsize,
   input  logic [S_AXI_BRT_SZ-1:0] s_axi_arburst,
   input  logic                    s_axi_arlock,
   input  logic [S_AXI_CAC_SZ-1:0] s_axi_arcache,
   input  logic [S_AXI_PRT_SZ-1:0] s_axi_arprot,
   input  logic [S_AXI_QOS_SZ-1:0] s_axi_arqos,
   //- RESPONSE READ
   input  logic                    s_axi_rready,
   output logic                    s_axi_rvalid,
   output logic                    s_axi_rlast,
   output logic [S_AXI_DAT_SZ-1:0] s_axi_rdata,
   output logic [S_AXI_ID_SZ-1:0]  s_axi_rid,
   output logic [S_AXI_RSP_SZ-1:0] s_axi_rresp,
    output logic c0_init_calib_complete,
   //- Clock and Reset
   output logic clk_memory,
   output logic clk_memory_rst
);


`ifdef VIVADO_IP_DRAM

`ifdef BOARD_u280
  localparam SYS_CLK_PERIOD = 10000; //For U280
`else
  localparam SYS_CLK_PERIOD =  3332; //For U250
`endif

///////////////////////////////////////
// Memory Controller
///////////////////////////////////////

logic        c0_init_valid_complete;
logic        c0_sys_clk_p;
logic        c0_sys_clk_n;
logic        c0_ddr4_act_n;
logic [16:0] c0_ddr4_adr;
logic  [1:0] c0_ddr4_ba;
logic  [1:0] c0_ddr4_bg;
logic  [0:0] c0_ddr4_ck_c;
logic  [0:0] c0_ddr4_ck_t;
logic  [0:0] c0_ddr4_cke;
logic  [0:0] c0_ddr4_cs_n;
wire  [71:0] c0_ddr4_dq;   
wire  [17:0] c0_ddr4_dqs_c;
wire  [17:0] c0_ddr4_dqs_t;
logic  [0:0] c0_ddr4_odt;
logic        c0_ddr4_parity;  
logic        c0_ddr4_reset_n;

//- Signals for model
logic   [0:0] c0_ddr4_ck_t_int;
logic   [0:0] c0_ddr4_ck_c_int;
logic  [16:0] c0_ddr4_adr_sdram[1:0];
logic   [1:0] c0_ddr4_ba_sdram[1:0];
logic   [1:0] c0_ddr4_bg_sdram[1:0];
logic  [31:0] cmdName;

logic powerup_rstn;
logic box_250mhz_rstn;

logic [511:0] dbg_bus;

initial begin 
   powerup_rstn = 0;  
   #1000000 powerup_rstn = 1; 
end

initial begin 
   box_250mhz_rstn = 0;  
   #1000000 box_250mhz_rstn = 1; 
end

always begin 
  #(SYS_CLK_PERIOD/2.0 ) c0_sys_clk_p =  1; 
  #(SYS_CLK_PERIOD/2.0 ) c0_sys_clk_p =  0; 
end

always begin 
  #(SYS_CLK_PERIOD/2.0) c0_sys_clk_n =  0; 
  #(SYS_CLK_PERIOD/2.0) c0_sys_clk_n =  1; 
end


memory_ctrl_etc u_ddr4_0 (
   //- To the proc_sys_reset
   .resetn                    (powerup_rstn),
   .mb_debug_sys_rst_0        (1'b0),
   .dcm_locked_0              (1'b0),
   //- To the memory manager
   .c0_init_calib_complete_0  (c0_init_calib_complete),
   .c0_sys_clk_p_0            (c0_sys_clk_p),    //- Input
   .c0_sys_clk_n_0            (c0_sys_clk_n),    //- Output
   .c0_ddr4_reset_n           (c0_ddr4_reset_n), //- Output
   .c0_ddr4_act_n             (c0_ddr4_act_n),
   .c0_ddr4_adr               (c0_ddr4_adr),
   .c0_ddr4_ba                (c0_ddr4_ba),
   .c0_ddr4_bg                (c0_ddr4_bg),
   .c0_ddr4_cke               (c0_ddr4_cke),
   .c0_ddr4_odt               (c0_ddr4_odt),
   .c0_ddr4_cs_n              (c0_ddr4_cs_n),
   .c0_ddr4_ck_t              (c0_ddr4_ck_t),
   .c0_ddr4_ck_c              (c0_ddr4_ck_c),
   .c0_ddr4_par               (c0_ddr4_parity), // added this
// .c0_ddr4_dm_dbi_n          (c0_ddr4_dm_dbi_n),
   .c0_ddr4_dq                (c0_ddr4_dq),
   .c0_ddr4_dqs_c             (c0_ddr4_dqs_c),
   .c0_ddr4_dqs_t             (c0_ddr4_dqs_t),
// .c0_ddr4_ui_clk_0          (c0_ddr4_clk),
// .c0_ddr4_ui_clk_sync_rst_0 (c0_ddr4_rst),
   .c0_ddr4_ui_clk_0          (clk_memory),
   .c0_ddr4_ui_clk_sync_rst_0 (clk_memory_rst),
   .addn_ui_clkout1_0         (),
   .dbg_clk_0                 (dbg_clk),
   // AXI CTRL port
   .C0_DDR4_S_AXI_CTRL_0_awvalid (1'b0),
   .C0_DDR4_S_AXI_CTRL_0_awready (),
   .C0_DDR4_S_AXI_CTRL_0_awaddr  (32'b0),
   // Slave Interface Write Data Ports
   .C0_DDR4_S_AXI_CTRL_0_wvalid  (1'b0),
   .C0_DDR4_S_AXI_CTRL_0_wready  (),
   .C0_DDR4_S_AXI_CTRL_0_wdata   (32'b0),
   // Slave Interface Write Response Ports
   .C0_DDR4_S_AXI_CTRL_0_bvalid  (),
   .C0_DDR4_S_AXI_CTRL_0_bready  (1'b1),
   .C0_DDR4_S_AXI_CTRL_0_bresp   (),
   // Slave Interface Read Address Ports
   .C0_DDR4_S_AXI_CTRL_0_arvalid (1'b0),
   .C0_DDR4_S_AXI_CTRL_0_arready (),
   .C0_DDR4_S_AXI_CTRL_0_araddr  (32'b0),
   // Slave Interface Read Data Ports
   .C0_DDR4_S_AXI_CTRL_0_rvalid  (),
   .C0_DDR4_S_AXI_CTRL_0_rready  (1'b1),
   .C0_DDR4_S_AXI_CTRL_0_rdata   (),
   .C0_DDR4_S_AXI_CTRL_0_rresp   (),
   // Interrupt output
   .c0_ddr4_interrupt_0          (),
   // Slave Interface Write Address Ports
   .c0_ddr4_aresetn_0            (box_250mhz_rstn), //(aresetn),
   .C0_DDR4_S_AXI_0_awid         (s_axi_awid),
   .C0_DDR4_S_AXI_0_awaddr       (s_axi_awaddr),
   .C0_DDR4_S_AXI_0_awlen        (s_axi_awlen),
   .C0_DDR4_S_AXI_0_awsize       (s_axi_awsize),
   .C0_DDR4_S_AXI_0_awburst      (s_axi_awburst),
   .C0_DDR4_S_AXI_0_awlock       (1'b0),
   .C0_DDR4_S_AXI_0_awcache      (s_axi_awcache),
   .C0_DDR4_S_AXI_0_awprot       (s_axi_awprot),
   .C0_DDR4_S_AXI_0_awqos        (4'b0),
   .C0_DDR4_S_AXI_0_awvalid      (s_axi_awvalid),
   .C0_DDR4_S_AXI_0_awready      (s_axi_awready),
   // Slave Interface Write Data Ports
   .C0_DDR4_S_AXI_0_wdata        (s_axi_wdata),
   .C0_DDR4_S_AXI_0_wstrb        (s_axi_wstrb),
   .C0_DDR4_S_AXI_0_wlast        (s_axi_wlast),
   .C0_DDR4_S_AXI_0_wvalid       (s_axi_wvalid),
   .C0_DDR4_S_AXI_0_wready       (s_axi_wready),
   // Slave Interface Write Response Ports
   .C0_DDR4_S_AXI_0_bid          (s_axi_bid),
   .C0_DDR4_S_AXI_0_bresp        (s_axi_bresp),
   .C0_DDR4_S_AXI_0_bvalid       (s_axi_bvalid),
   .C0_DDR4_S_AXI_0_bready       (s_axi_bready),
   // Slave Interface Read Address Ports
   .C0_DDR4_S_AXI_0_arid         (s_axi_arid),
   .C0_DDR4_S_AXI_0_araddr       (s_axi_araddr),
   .C0_DDR4_S_AXI_0_arlen        (s_axi_arlen),
   .C0_DDR4_S_AXI_0_arsize       (s_axi_arsize),
   .C0_DDR4_S_AXI_0_arburst      (s_axi_arburst),
   .C0_DDR4_S_AXI_0_arlock       (1'b0),
   .C0_DDR4_S_AXI_0_arcache      (s_axi_arcache),
   .C0_DDR4_S_AXI_0_arprot       (3'b0),
   .C0_DDR4_S_AXI_0_arqos        (4'b0),
   .C0_DDR4_S_AXI_0_arvalid      (s_axi_arvalid),
   .C0_DDR4_S_AXI_0_arready      (s_axi_arready),
   // Slave Interface Read Data Ports
   .C0_DDR4_S_AXI_0_rid          (s_axi_rid),
   .C0_DDR4_S_AXI_0_rdata        (s_axi_rdata),
   .C0_DDR4_S_AXI_0_rresp        (s_axi_rresp),
   .C0_DDR4_S_AXI_0_rlast        (s_axi_rlast),
   .C0_DDR4_S_AXI_0_rvalid       (s_axi_rvalid),
   .C0_DDR4_S_AXI_0_rready       (s_axi_rready),  
   // Debug Port
   .dbg_bus_0                    (dbg_bus));


///////////////////////////////////////////
// DRAM Memory Model
///////////////////////////////////////////

import arch_package::*;

parameter UTYPE_density CONFIGURED_DENSITY = _8G;
  
localparam ADDR_WIDTH         = 17;
localparam DQ_WIDTH           = 72;
localparam DQS_WIDTH          = 18;
localparam DM_WIDTH           = 9;
localparam DRAM_WIDTH         = 4;
localparam tCK                = 833 ; //DDR4 interface clock period in ps
localparam real SYSCLK_PERIOD = tCK; 
localparam NUM_PHYSICAL_PARTS = (DQ_WIDTH/DRAM_WIDTH) ;
localparam CLAMSHELL_PARTS    = (NUM_PHYSICAL_PARTS/2);
localparam ODD_PARTS          = ((CLAMSHELL_PARTS*2) < NUM_PHYSICAL_PARTS) ? 1 : 0;
parameter  RANK_WIDTH         = 1;
parameter  CS_WIDTH           = 1;
parameter  ODT_WIDTH          = 1;
parameter  CA_MIRROR          = "OFF";

localparam MRS                           = 3'b000;
localparam REF                           = 3'b001;
localparam PRE                           = 3'b010;
localparam ACT                           = 3'b011;
localparam WR                            = 3'b100;
localparam RD                            = 3'b101;
localparam ZQC                           = 3'b110;
localparam NOP                           = 3'b111;

//Added to support RDIMM wrapper
localparam ODT_WIDTH_RDIMM   = 1;
localparam CKE_WIDTH_RDIMM   = 1;
localparam CS_WIDTH_RDIMM   = 1;
localparam RANK_WIDTH_RDIMM   = 1;
localparam RDIMM_SLOTS   = 1;
localparam BANK_WIDTH_RDIMM = 2;
localparam BANK_GROUP_WIDTH_RDIMM     = 2;

localparam DM_DBI                        = "NONE";
localparam DM_WIDTH_RDIMM                  = 18;
   
localparam MEM_PART_WIDTH       = "x4";
localparam REG_CTRL             = "ON";

localparam APP_ADDR_WIDTH   = 34;
localparam MEM_ADDR_ORDER   = "ROW_COLUMN_BANK_INTLV";
localparam DBG_WR_STS_WIDTH = 32;
localparam DBG_RD_STS_WIDTH = 32;
localparam ECC              = "ON";

assign c0_ddr4_ck_t = c0_ddr4_ck_t_int[0];
assign c0_ddr4_ck_c = c0_ddr4_ck_c_int[0];

always @( * ) begin
   c0_ddr4_adr_sdram[0]   <=  c0_ddr4_adr;
   c0_ddr4_adr_sdram[1]   <=  (CA_MIRROR == "ON") ?
                              {c0_ddr4_adr[ADDR_WIDTH-1:14],
                               c0_ddr4_adr[11], c0_ddr4_adr[12],
                               c0_ddr4_adr[13], c0_ddr4_adr[10:9],
                               c0_ddr4_adr[7], c0_ddr4_adr[8],
                               c0_ddr4_adr[5], c0_ddr4_adr[6],
                               c0_ddr4_adr[3], c0_ddr4_adr[4],
                               c0_ddr4_adr[2:0]} :
                               c0_ddr4_adr;
   c0_ddr4_ba_sdram[0]    <=  c0_ddr4_ba;
   c0_ddr4_ba_sdram[1]    <=  (CA_MIRROR == "ON") ?
                              {c0_ddr4_ba[0],
                               c0_ddr4_ba[1]} :
                               c0_ddr4_ba;
   c0_ddr4_bg_sdram[0] <=  c0_ddr4_bg;
   c0_ddr4_bg_sdram[1] <=  (CA_MIRROR == "ON" && DRAM_WIDTH != 16) ?
                           {c0_ddr4_bg[0],
                            c0_ddr4_bg[1]} :
                            c0_ddr4_bg;
    end

reg [ADDR_WIDTH-1:0] DDR4_ADRMOD[RANK_WIDTH-1:0];

  always @(*)
    if (c0_ddr4_cs_n == 4'b1111)
      cmdName = "DSEL";
    else
    if (c0_ddr4_act_n)
      casez (DDR4_ADRMOD[0][16:14])
       MRS:     cmdName = "MRS";
       REF:     cmdName = "REF";
       PRE:     cmdName = "PRE";
       WR:      cmdName = "WR";
       RD:      cmdName = "RD";
       ZQC:     cmdName = "ZQC";
       NOP:     cmdName = "NOP";
      default:  cmdName = "***";
      endcase
    else
      cmdName = "ACT";

   reg wr_en ;
   always@(posedge c0_ddr4_ck_t)begin
     if(!c0_ddr4_reset_n)begin
       wr_en <= #100 1'b0 ;
     end else begin
       if(cmdName == "WR")begin
         wr_en <= #100 1'b1 ;
       end else if (cmdName == "RD")begin
         wr_en <= #100 1'b0 ;
       end
     end
   end

//===========================================================================
//                         Memory Model instantiation
//===========================================================================
genvar rdimm_x;
generate
  for(rdimm_x=0; rdimm_x<RDIMM_SLOTS; rdimm_x=rdimm_x+1)
    begin: instance_of_rdimm_slots
       ddr4_rdimm_wrapper #(
             .MC_DQ_WIDTH(DQ_WIDTH),
             .MC_DQS_BITS(DQS_WIDTH),
             .MC_DM_WIDTH(DM_WIDTH_RDIMM),
             .MC_CKE_NUM(CKE_WIDTH_RDIMM),
             .MC_ODT_WIDTH(ODT_WIDTH_RDIMM),
             .MC_ABITS(ADDR_WIDTH),
             .MC_BANK_WIDTH(BANK_WIDTH_RDIMM),
             .MC_BANK_GROUP(BANK_GROUP_WIDTH_RDIMM),
             .MC_CS_NUM(CS_WIDTH_RDIMM),
             .MC_RANKS_NUM(RANK_WIDTH_RDIMM),
             .NUM_PHYSICAL_PARTS(NUM_PHYSICAL_PARTS),
             .CALIB_EN("NO"),
             .tCK(tCK),
             .tPDM(),
             .MIN_TOTAL_R2R_DELAY(),
             .MAX_TOTAL_R2R_DELAY(),
             .TOTAL_FBT_DELAY(),
             .MEM_PART_WIDTH(MEM_PART_WIDTH),
             .MC_CA_MIRROR(CA_MIRROR),
            // .SDRAM("DDR4"),
   `ifdef SAMSUNG
             .DDR_SIM_MODEL("SAMSUNG"),

   `else         
             .DDR_SIM_MODEL("MICRON"),
   `endif
             .DM_DBI(DM_DBI),
             .MC_REG_CTRL(REG_CTRL),
             .DIMM_MODEL ("RDIMM"),
             .RDIMM_SLOTS (RDIMM_SLOTS),
             .CONFIGURED_DENSITY (CONFIGURED_DENSITY)
                     )
   u_ddr4_rdimm_wrapper  (
     .ddr4_act_n(c0_ddr4_act_n), // input
      .ddr4_addr(c0_ddr4_adr), // input
      .ddr4_ba(c0_ddr4_ba), // input
      .ddr4_bg(c0_ddr4_bg), // input
      .ddr4_par(c0_ddr4_parity), // input
      .ddr4_cke(c0_ddr4_cke[CKE_WIDTH_RDIMM-1:0]), // input
      .ddr4_odt(c0_ddr4_odt[ODT_WIDTH_RDIMM-1:0]), // input
      .ddr4_cs_n(c0_ddr4_cs_n[CS_WIDTH_RDIMM-1:0]), // input
      .ddr4_ck_t(c0_ddr4_ck_t), // input
      .ddr4_ck_c(c0_ddr4_ck_c), // input
      .ddr4_reset_n(c0_ddr4_reset_n), // input
      .ddr4_dm_dbi_n       (),
      .ddr4_dq(c0_ddr4_dq), // inout
      .ddr4_dqs_t(c0_ddr4_dqs_t), // inout
      .ddr4_dqs_c(c0_ddr4_dqs_c), // inout
      .ddr4_alert_n(), // inout
      .initDone(c0_init_calib_complete), // inout
      .scl(), // input
      .sa0(), // input
      .sa1(), // input
      .sa2(), // input
      .sda(), // inout
      .bfunc(), // input
      .vddspd() // input
   );
   end
endgenerate
   
genvar rnk;
generate
localparam IDX = CS_WIDTH;
for (rnk = 0; rnk < IDX; rnk++) begin:rankup
 always @(*)
    if (c0_ddr4_act_n)
      casez (c0_ddr4_adr_sdram[0][16:14])
      WR, RD: begin
        DDR4_ADRMOD[rnk] = c0_ddr4_adr_sdram[rnk];
      end
      default: begin
        DDR4_ADRMOD[rnk] = c0_ddr4_adr_sdram[rnk];
      end
      endcase
    else begin
      DDR4_ADRMOD[rnk] = c0_ddr4_adr_sdram[rnk];
    end
end
endgenerate

`else  
   // else VIVADO_IP_DRAM
   // If not using the memory model from Vivado 
   // This code sets the signals
   // but does not give any valid response
   assign s_axi_awready = 1'b1;
   assign s_axi_wready  = 1'b1;
   assign s_axi_arready = 1'b1;

   always begin 
      #(333 / 2) clk_memory =  0; 
      #(333 / 2) clk_memory =  1; 
   end

   initial begin 
      clk_memory_rst = 1; 
      #1000000 clk_memory_rst = 0; 
   end

   initial begin
      c0_init_calib_complete = 1;
      #1000000 c0_init_calib_complete = 1;
   end

   always @(posedge clk_memory) begin
      if (clk_memory_rst) begin
         s_axi_rvalid = 1'b0;
         s_axi_rlast  = 1'b0;
         s_axi_rdata   = 'h0;
         s_axi_rid    = 'h0;
         s_axi_rresp  = 'h0;
      end else begin
         if (s_axi_arvalid & s_axi_rready) begin
            s_axi_rvalid <= 1'b1;
            s_axi_rdata  <= {16{$random}};
            s_axi_rid    <= s_axi_arid;
            s_axi_rlast  <= 1'b1;
         end else begin
            s_axi_rvalid <= 1'b0;
            s_axi_rdata  <= 'h0;
            s_axi_rid    <= 'h0;
            s_axi_rlast  <= 1'b0;
         end        

         if (s_axi_wvalid & s_axi_bready) begin
            s_axi_bvalid <= 1'b1;
            s_axi_bresp  <= $random;
            s_axi_bid    <= s_axi_awid;
         end else begin
            s_axi_bvalid <= 1'b0;
            s_axi_bid    <= 'h0;
            s_axi_bresp  <= 'h0;
         end 
      end
  end
`endif

endmodule
