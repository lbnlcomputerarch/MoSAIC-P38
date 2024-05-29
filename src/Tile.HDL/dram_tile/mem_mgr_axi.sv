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

///////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : Oct 11 2022
// Description : AXI signals
// File        : mem_mgr_axi.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module mem_mgr_axi#(
   parameter OFFSET_SZ    = 12,
   parameter XY_SZ        =  3,
   parameter MEM_BUS_SZ   = 512,
   parameter S_AXI_ID_SZ  = 11,   // ID
   parameter S_AXI_ADR_SZ = 29,  // ADDRESS
   parameter S_AXI_LEN_SZ = 8,   // LENGTH
   parameter S_AXI_SZE_SZ = 3,   // SIZE
   parameter S_AXI_BRT_SZ = 2,   // BURST
   parameter S_AXI_DAT_SZ = 512, // DATA
   parameter S_AXI_STB_SZ = 64,  // STROBE
   parameter S_AXI_RSP_SZ = 2,   // RESPONSE
   parameter S_AXI_CAC_SZ = 4,   // RESPONSE
   parameter S_AXI_PRT_SZ = 3,   // RESPONSE
   parameter S_AXI_QOS_SZ = 4   // RESPONSE  
)(
  //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_ctrl_rst_low,
   //- ADDRESS WRITE
   input  logic                    s_axi_awready,
   output logic                    s_axi_awvalid,
   output logic [S_AXI_ID_SZ-1:0]  s_axi_awid,
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
   output  logic                   s_axi_bready,
   input logic                     s_axi_bvalid,
   input logic [S_AXI_ID_SZ-1:0]   s_axi_bid,
   input logic [S_AXI_RSP_SZ-1:0]  s_axi_bresp,
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
   input  logic [S_AXI_RSP_SZ-1:0] s_axi_rresp,
   //- Memory request
   input logic [31:0] mem_req_addr,
   input logic [MEM_BUS_SZ-1:0] mem_req_data,
   input logic mem_req_rw,
   input logic mem_req_valid,
   input logic [S_AXI_ID_SZ-1:0] mem_req_id,
   input logic [S_AXI_LEN_SZ-1:0] mem_req_len,
   //- Memory response
   output logic [MEM_BUS_SZ-1:0] mem_data_data,
   output logic  mem_data_ready
);

/***************************
* Local parameters for FSMs
****************************/

//- AXI (aw-ar) state machine: s_axi_state_in
localparam [2:0] IDLE = 0;
localparam [2:0] WRITE_AW = 1;
localparam [2:0] WRITE_W  = 2;
localparam [2:0] READ_AR  = 3;

//- Memory parameters 
localparam IN_MEMSIZE_KB = 1;
localparam    CPU_BUS_SZ = 32;

logic [CPU_BUS_SZ-1:0] mem_req_addr_reg;   // Cache output
logic [MEM_BUS_SZ-1:0] mem_req_data_reg;   // Cache output
logic                  mem_req_rw_reg;     // Cache output: 0=read, 1=write

logic [2:0] s_axi_state_in;
logic [2:0] next_s_axi_state_in;

//- AXI memory interface

logic [S_AXI_LEN_SZ-1:0] next_s_axi_awlen;
logic [S_AXI_ID_SZ-1:0]  next_s_axi_awid;
logic [S_AXI_SZE_SZ-1:0] next_s_axi_awsize;

logic [S_AXI_STB_SZ-1:0] next_s_axi_wstrb;

logic [S_AXI_LEN_SZ-1:0]      s_axi_awlen_ctr;
logic [S_AXI_LEN_SZ-1:0] next_s_axi_awlen_ctr;


logic [S_AXI_LEN_SZ-1:0] next_s_axi_arlen;
logic [S_AXI_ID_SZ-1:0]  next_s_axi_arid;
logic [S_AXI_SZE_SZ-1:0] next_s_axi_arsize;

assign s_axi_bready = 1'b1; //FIXME

logic end_mem_valid_req;

always @(posedge clk_ctrl or negedge clk_ctrl_rst_low) begin
  if (~clk_ctrl_rst_low)begin
    mem_req_addr_reg  <= 'h0;   
    mem_req_data_reg  <= 'h0;   
    mem_req_rw_reg    <= 'h0;   
  end else if (mem_req_valid) begin
    mem_req_addr_reg  <= mem_req_addr;   
    mem_req_data_reg  <= mem_req_data;   
    mem_req_rw_reg    <= mem_req_rw;   
   end
end

assign s_axi_awburst = 'h1; //- Burst type: INC. can change.
assign s_axi_awlock  = 'h0;
assign s_axi_awcache = 'h0;
assign s_axi_awprot  = 'h0;
assign s_axi_awqos   = 'h0;

assign s_axi_arburst = 'h1; //- Burst type: INC. can change.
assign s_axi_arlock  = 'h0;
assign s_axi_arcache = 'h0;
assign s_axi_arprot  = 'h0;
assign s_axi_arqos   = 'h0;


always @(posedge clk_ctrl or negedge clk_ctrl_rst_low) begin
  if (~clk_ctrl_rst_low)begin
    s_axi_state_in <= 'h0;

    s_axi_awid <= 'h0;
    s_axi_awlen <= 'h0;
    s_axi_awsize <= 'h0;
    s_axi_awlen_ctr  = 'h0;  

    s_axi_wstrb <= 'h0;

    s_axi_arid <= 'h0;
    s_axi_arlen <= 'h0;
    s_axi_arsize <= 'h0;
  end else begin
    s_axi_state_in <= next_s_axi_state_in;

    s_axi_awid <= next_s_axi_awid;
    s_axi_awlen <= next_s_axi_awlen;
    s_axi_awsize <= next_s_axi_awsize;
    s_axi_awlen_ctr  = next_s_axi_awlen_ctr;

    s_axi_wstrb <= next_s_axi_wstrb;

    s_axi_arid <= next_s_axi_arid;
    s_axi_arlen <= next_s_axi_arlen;
    s_axi_arsize <= next_s_axi_arsize;
  end
end

//- 64 bytes
//- 6 bits to address
//- 16 words
//- 4 bits to address


//- AW  and AR Channels -//

always @( * ) begin
   //- State
   next_s_axi_state_in = s_axi_state_in;

   next_s_axi_awid = s_axi_awid;
   next_s_axi_awlen = s_axi_awlen; 
   next_s_axi_awsize = s_axi_awsize;
   next_s_axi_awlen_ctr = s_axi_awlen_ctr;

   next_s_axi_wstrb = s_axi_wstrb;

   next_s_axi_arid = s_axi_arid;
   next_s_axi_arlen = s_axi_arlen; 
   next_s_axi_arsize = s_axi_arsize;

   //-
   s_axi_arvalid = 1'b0;
   s_axi_araddr  = 'h0;

   //- 
   s_axi_awvalid = 1'b0;
   s_axi_awaddr  = 'h0;

   //-
   s_axi_wvalid = 1'b0;
   s_axi_wlast  = 1'b0;
   s_axi_wdata  = 'h0;


   end_mem_valid_req = 1'b0;

   case (s_axi_state_in)
      IDLE: begin
        //if (mem_req_valid_reg1) begin
        if (mem_req_valid) begin
          if (mem_req_rw) begin
            next_s_axi_awlen  = 'h0; //- Transfers in a write burst
            next_s_axi_awid   = mem_req_id;        //- Transaction ID
            next_s_axi_awsize = 'h6;               //- Bytes in a transaction 6->64bytes->512bits
            next_s_axi_wstrb  = 64'hFFFFFFFFFFFFFFFF;

            next_s_axi_awlen_ctr = 'h1;      
            next_s_axi_state_in = WRITE_AW;
          end else begin
            next_s_axi_arlen = 'h0;  //- Transfers in a read burst
            next_s_axi_arid = mem_req_id;          //- Transaction ID
            next_s_axi_arsize = 'h6;               //- Bytes in a transaction 6->64bytes->512bits

            next_s_axi_state_in = READ_AR;
          end
        end 
     end
     READ_AR: begin //3
        if (s_axi_arready) begin
          s_axi_arvalid = 1'b1;
          end_mem_valid_req = 1'b1;
          s_axi_araddr  = {2'b00,mem_req_addr_reg};
          next_s_axi_state_in = IDLE;
        end
      end
      WRITE_AW:begin
        if (s_axi_awready) begin
          s_axi_awvalid = 1'b1;
          //end_mem_valid_req = 1'b1;
          s_axi_awaddr  = {2'b00,mem_req_addr_reg};
          next_s_axi_state_in = WRITE_W;
        end
      end
      WRITE_W:begin
         if (s_axi_wready) begin
            s_axi_wvalid        = 1'b1;
            s_axi_wlast         = 1'b1;
            s_axi_wdata         = mem_req_data_reg;
            next_s_axi_state_in = IDLE;
            //end_mem_valid_req   = 1'b1;
         end
      end
   endcase
end

assign mem_data_data = s_axi_rdata;
assign mem_data_ready = s_axi_rvalid || s_axi_bvalid;
assign s_axi_rready = 1'b1; //FIXME

endmodule
