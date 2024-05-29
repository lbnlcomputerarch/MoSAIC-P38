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
// Description : PCPI extension 
// File        : qISAExtension_pcpi.sv
////////////////////////////////////////////////

`timescale 1 ps / 1 ps
//---Interface with the processor---//

module qISAExtension_pcpi#(
   parameter NOC_BUFFER_ADDR_W = 8,
   parameter OFFSET_SZ         = 12,
   parameter XY_SZ             =  3
)(
  //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_ctrl_rst_low,
   input  logic       clk_line,
   input  logic       clk_line_rst_low,   
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
   //- Output Interface
   input  logic        stream_out_pcpi_TREADY,
   output logic        stream_out_pcpi_TVALID,
   output logic [31:0] stream_out_pcpi_TDATA,
   output logic [ 3:0] stream_out_pcpi_TKEEP,
   output logic        stream_out_pcpi_TLAST,

   input  logic        stream_out_mem_TREADY,
   output logic        stream_out_mem_TVALID,
   output logic [31:0] stream_out_mem_TDATA,
   output logic [ 3:0] stream_out_mem_TKEEP,
   output logic        stream_out_mem_TLAST,

   output logic        fifo_0B_en,
   output logic [31:0] fifo_0B_addr,
   input logic [31:0]  fifo_0B_dout,
   input logic         fifo_0_empty,
   input logic         fifo_0_full,

   output logic pcpi_idle
);

/***************************
* Local parameters for FSMs
****************************/

//- NOC Instruction decoder  
localparam [2:0] MPUT    = 3'd4;  //- A far-away-galaxy is writing to this Tile
localparam [2:0] MGET    = 3'd5;  //- A far away galaxy is reading from this Tile.
localparam [2:0] MLOAD   = 3'd6;  //- A far-away-galaxy is reading from this Tile. The far-away-galaxy is blocked until the data is received.
localparam [2:0] MSTORE  = 3'd7;  //- A far-away-galaxy is writing to this Tile. The far-away-galaxy is blocked until this Tile sends an ACK.
localparam [2:0] MACK    = 3'd1;  //- This Tile issued a MEM_STORE to a far-away-galaxy and is waiting for this ACK from the far-away-galaxy.  
localparam [2:0] MDATA   = 3'd2;  //- This Tile issued a LOAD to a far-away-galaxy and is waiting for this MEM_DATA from the far-away-galaxy.
localparam [2:0] QM      = 3'd3;  //- This Tile issued a MEM_STORE to a far-away-galaxy and is waiting for this ACK from the far-away-galaxy. 

//- PCPI Instruction decoder
localparam [2:0] QPOLL   = 3'd0; //
localparam [2:0] QWAIT   = 3'd1; //
localparam [2:0] QGET    = 3'd2;  //
localparam [2:0] QPUT    = 3'd3;  //

//- State machine state2
//-2,7-
localparam [3:0] IDLE_S       =  4'd0;        
localparam [3:0] QPOLL_S      = {1'b1,3'd0};
localparam [3:0] QPUT_S       = {1'b1,3'd3}; //1 011 //B
localparam [3:0] QWAIT0_S     = {1'b1,3'd1};
localparam [3:0] QWAIT1_S     = 4'd6;
localparam [3:0] SEND_S       = 4'd3;
localparam [3:0] SEND2_S       = 4'd7;
localparam [3:0] QPUT_DATA_S  = 4'd1; 
localparam [3:0] MDONE_S      = 4'd4;
localparam [3:0] QGET1_S      = 4'd5;

localparam [3:0] QPUT_H0_S    = 4'hC;
localparam [3:0] QPUT_H1_S    = 4'hD;
localparam [3:0] QPUT_DATA0_S = 4'hE;
localparam [3:0] QPUT_DATA1_S = 4'hF;

//***************************
//* The connections 
//****************************

//- FSMs
(*mark_debug = "true" *) logic [3:0] currentState2; //- ISA extension
logic [3:0] nextState2;

logic [31:0] pcpi_header;
logic [31:0] pcpi_header1;

//- Inbound/Outbound FIFO  and Queue Manager

logic [31:0] next_fifo_0B_addr;

logic inst_valid; 
logic inst_m_put;
logic inst_m_get; 
logic inst_q_put;
logic inst_q_poll; 
logic inst_q_wait;
logic inst_q_get;
logic inst_q_put_h;
logic inst_q_put_d;
logic inst_m_put_h;
logic inst_m_put_d;
logic inst_m_get_h; //Jul 14 2023

logic inst_m_put_r;
logic inst_m_get_r; 
logic inst_q_put_r;
logic inst_q_put_h_r;
logic inst_q_put_d_r;
logic inst_m_put_h_r;
logic inst_m_put_d_r;
logic inst_m_get_h_r; //Jul 14 2023
logic inst_m_get_d_r; //Jul 14 2023

logic [2:0] pcpi_code;

logic fifo_2B_en;
logic [31:0] fifo_2B_din;

//- Preserve the instruction for further processing

logic [31:0] pcpi_rs1_int;
logic [31:0] pcpi_rs2_int;

logic stream_out_pcpi_TVALID_int;
logic   [31:0] stream_out_pcpi_TDATA_int; 
logic stream_out_pcpi_TLAST_int;
logic [3:0] stream_out_pcpi_TKEEP_int;

logic stream_out_mem_TVALID_int;
logic   [31:0] stream_out_mem_TDATA_int; 
logic stream_out_mem_TLAST_int;
logic [3:0] stream_out_mem_TKEEP_int;

logic [OFFSET_SZ-1:0] pcpi_offset_short; //- Header fields
logic      [XY_SZ-1:0] pcpi_x_dest;
logic      [XY_SZ-1:0] pcpi_y_dest;
logic pcpi_hl;
logic pcpi_hl_short;

logic  [3:0] pcpi_pkt_code;
logic  [3:0] pcpi_pkt_code_get;

logic pt;
assign pt=0;

assign inst_valid   = pcpi_valid & pcpi_insn[6:0] == 7'h2B;

always @(posedge clk_ctrl) begin
   if (currentState2 == IDLE_S & inst_valid) begin
      pcpi_rs1_int  <= pcpi_rs1;
      pcpi_rs2_int  <= pcpi_rs2;
      inst_q_put_r <= inst_q_put;
      inst_m_put_r <= inst_m_put;
      inst_m_get_r <= inst_m_get;
      inst_m_put_h_r <= inst_m_put_h;
      inst_m_put_d_r <= inst_m_put_d;
      inst_m_get_h_r <= inst_m_get_h;
      inst_m_get_d_r <= inst_m_get_d;
      inst_q_put_h_r <= inst_q_put_h;
      inst_q_put_d_r <= inst_q_put_d;
   end
end

assign inst_m_put   = inst_valid & pcpi_insn[14:12] == MPUT & pcpi_insn[26:25] == 0;   //- MM Non-Blocking write to memory
assign inst_m_get   = inst_valid & pcpi_insn[14:12] == MGET & pcpi_insn[26:25] == 0;   //- MM Non-Blocking read from memory
assign inst_m_put_h = inst_valid & pcpi_insn[14:12] == MPUT & pcpi_insn[26:25] == 1;   //- MM Non-Blocking write to memory
assign inst_m_put_d = inst_valid & pcpi_insn[14:12] == MPUT & pcpi_insn[26:25] == 2;   //- MM Non-Blocking write to memory
assign inst_m_get_h = inst_valid & pcpi_insn[14:12] == MGET & pcpi_insn[26:25] == 1;   //- MM Non-Blocking
assign inst_m_get_d = inst_valid & pcpi_insn[14:12] == MGET & pcpi_insn[26:25] == 2;   //- MM Non-Blocking


assign inst_q_put   = inst_valid & pcpi_insn[14:12] == QPUT & pcpi_insn[26:25] == 0;   //- QM
assign inst_q_poll  = inst_valid & pcpi_insn[14:12] == QPOLL;  //- QM
assign inst_q_wait  = inst_valid & pcpi_insn[14:12] == QWAIT;  //- QM
assign inst_q_get   = inst_valid & pcpi_insn[14:12] == QGET;   //- QM
assign inst_q_put_h = inst_valid & pcpi_insn[14:12] == QPUT & pcpi_insn[26:25] == 1;   //- QM: long header long packet
assign inst_q_put_d = inst_valid & pcpi_insn[14:12] == QPUT & pcpi_insn[26:25] == 2;   //- QM: data for long packet

logic [7:0] pkt_size_qput;  //Jun 2023
logic [7:0] next_pkt_size_qput; //Jun 2023

always @(posedge clk_ctrl or negedge clk_ctrl_rst_low) begin
   if (~clk_ctrl_rst_low) begin
      currentState2 <= IDLE_S;
      fifo_0B_addr  <= 'h0; //- Read address for inbound FIFO
      pkt_size_qput <= 'h0;
   end else begin
      currentState2 <= nextState2;
      fifo_0B_addr  <= next_fifo_0B_addr;
      pkt_size_qput <= next_pkt_size_qput;
   end
end

assign pcpi_idle = currentState2 == IDLE_S;
assign pcpi_code = pcpi_insn[14:12]; //- assumes QM is the same as QPUT
always @( * ) begin
   //- State
   nextState2 = currentState2;

   //- PCPI interface
   pcpi_rd = 32'h0;
   pcpi_wr = 1'b0;
   pcpi_wait = 1'b0;
   pcpi_ready = 1'b0;

   //- Memory Interface
   
   //- Inbound FIFO
   fifo_0B_en   = 1'b0;
   next_fifo_0B_addr = fifo_0B_addr;

   //- Outbound FIFO
   fifo_2B_en = 1'b0;
   fifo_2B_din = 32'b0;

   //- NOC interface
   stream_out_mem_TVALID_int = 1'b0;
   stream_out_mem_TDATA_int = 'h0;
   stream_out_mem_TLAST_int = 'b0;

   stream_out_pcpi_TLAST_int = 'b0;

   next_pkt_size_qput = pkt_size_qput;
   pcpi_pkt_code = 0;
   pcpi_pkt_code_get = 0;

   case (currentState2)
      IDLE_S: begin
         if (inst_q_wait) begin
            if (!fifo_0_empty) begin
               fifo_0B_en = 1'b1;
               nextState2 = QWAIT1_S;
            end else
               nextState2 = QWAIT0_S;
        end else if (inst_q_poll) nextState2 = QPOLL_S;
        else if (inst_q_get) begin
           /* FIXME: Should we only get the data and increment
            *         the address by 2. Or get header and data
            *         and issue two gets to obtain the data??? */
           fifo_0B_en = 1'b1;
           nextState2  = QGET1_S;
        end else begin /*Generate Packets*/ 
           if (inst_q_put | inst_q_put_h | inst_q_put_d) begin
              if (stream_out_pcpi_TREADY_int) begin
                 fifo_2B_en  = 1'b1;
                 pcpi_ready  = 1'b1;
                 nextState2 = QPUT_DATA_S;
                 pcpi_x_dest = pcpi_rs1[XY_SZ-1:0];
                 pcpi_y_dest = pcpi_rs1[(2*XY_SZ)-1:XY_SZ]; // LPGG May 26 2023
                 if (inst_q_put) //- Short packet
                    fifo_2B_din = pcpi_header;
                 else if (inst_q_put_h) begin //- Long header
                    pcpi_pkt_code = pcpi_rs2[3:0];
                    next_pkt_size_qput = 1 << (pcpi_rs2-1);
                    fifo_2B_din = pcpi_header1;
                 end else //- Data for long header
                    fifo_2B_din = pcpi_rs1;
              end
           end else if (inst_m_put | inst_m_put_h | inst_m_get | inst_m_get_h | inst_m_put_d | inst_m_get_d) begin
              if (stream_out_mem_TREADY_int) begin
                 nextState2 = SEND2_S;
                 pcpi_x_dest = pcpi_rs1[OFFSET_SZ+XY_SZ-1:OFFSET_SZ];
                 pcpi_y_dest = pcpi_rs1[OFFSET_SZ+(2*XY_SZ)-1:OFFSET_SZ+XY_SZ];
                 stream_out_mem_TVALID_int = 1'b1;
                 if (inst_m_put | inst_m_get) //- Short packer
                      stream_out_mem_TDATA_int = pcpi_header;
                 else if (inst_m_put_h | inst_m_get_h) begin //- Long header
                    if (inst_m_get_h) begin //- Long header
                       pcpi_pkt_code = 1;
                       pcpi_pkt_code_get = pcpi_rs2[3:0];
                       next_pkt_size_qput = 1;
                    end else begin
                       pcpi_pkt_code = pcpi_rs2[3:0];
                       next_pkt_size_qput = 1 << (pcpi_rs2-1);
                    end
                      stream_out_mem_TDATA_int = pcpi_header1;
                 end else //- Data for long header
                      stream_out_mem_TDATA_int = pcpi_rs1;
               end else pcpi_wait = 1'b1;
           end
        end
     end
     QWAIT0_S: begin
        if (!fifo_0_empty) begin //- If there is a message in the queue read memory
           fifo_0B_en   = 1'b1;
           nextState2   = QWAIT1_S;
        end else pcpi_wait = 1'b1;
     end
     QWAIT1_S: begin
        if (!fifo_0_empty) begin
           pcpi_rd      = fifo_0B_dout; //- Reads a header
           pcpi_wr      = 1'b1;
           pcpi_ready   = 1'b1;
           nextState2   = IDLE_S;
           pcpi_wait    = 1'b0;
        end else pcpi_wait = 1'b1;
      end
     QPOLL_S: begin 
        //- This is a modification Jun 13 2022
        // before this day 
        //- If there is a message in the queue send a 1
        //if (!fifo_0_empty) pcpi_rd = 32'h1;
        //else               pcpi_rd = 32'h0;
        //- Now, if there is a message in the queue send the header
        if (fifo_0_empty) pcpi_rd = 32'h1;
        else              pcpi_rd = fifo_0B_dout;
        pcpi_wr    = 1'b1;
        pcpi_ready = 1'b1;
        nextState2 = IDLE_S;
     end
     QGET1_S:begin
        pcpi_rd           = fifo_0B_dout;
        pcpi_wr           = 1'b1;
        pcpi_ready        = 1'b1;
        nextState2        = IDLE_S;
        if (!fifo_0_empty)
           next_fifo_0B_addr = fifo_0B_addr + 'h1;
     end
     QPUT_DATA_S: begin
        //- Write the outbound fifo, advance the write address 
        fifo_2B_en        = 1'b1;
        nextState2        = IDLE_S;
        pcpi_ready        = 1'b1;
        if (inst_q_put_r | inst_q_put_d_r) begin
           fifo_2B_din       = pcpi_rs2;
           if (inst_q_put_r) 
               stream_out_pcpi_TLAST_int = 1'h1; //LPGG May 18 2023 !!
           else begin // q_put_d
               next_pkt_size_qput = pkt_size_qput - 'h1;
                if (pkt_size_qput == 1)
                  stream_out_pcpi_TLAST_int = 1'h1;
           end
        end else if (inst_q_put_h_r)
           fifo_2B_din       = 'h0;
      end
      SEND2_S: begin //7
         if (stream_out_mem_TREADY_int) begin
            //- Write the outbound fifo, advance the write address
            nextState2 = MDONE_S;
            stream_out_mem_TVALID_int = 1'b1;
            if (inst_m_put_r | inst_m_get_r) begin //- Short packet
               stream_out_mem_TDATA_int = pcpi_rs2_int;
               stream_out_mem_TLAST_int = 1'b1;
            end else if (inst_m_put_h_r | inst_m_get_h_r) //- Long header
               //stream_out_mem_TDATA_int = pcpi_rs1_int[OFFSET_SZ-1:0];
               stream_out_mem_TDATA_int = pcpi_rs1_int;
            else begin //- Long data
               next_pkt_size_qput = pkt_size_qput - 'h1;
               stream_out_mem_TDATA_int = pcpi_rs2_int;
               if (pkt_size_qput == 1)
                  stream_out_mem_TLAST_int = 1'h1;
            end
         end else pcpi_wait = 1'b1;
      end
      MDONE_S:begin //4
        //pcpi_code  = pcpi_insn[14:12];
        pcpi_wait  = 1'b0;
        pcpi_ready = 1'b1;
        nextState2 = IDLE_S;
      end
   endcase
end


noc_buffer_out #(
   .ADDR_W (NOC_BUFFER_ADDR_W)
)noc_buffer_out_mq(
   .clk_in            (clk_ctrl),
   .clk_out           (clk_line),
   .clk_in_rst_low    (clk_ctrl_rst_low),
   .clk_in_rst_high   (clk_ctrl_rst_high),
   .clk_out_rst_low   (clk_line_rst_low),

   .stream_out_TVALID (stream_out_pcpi_TVALID),
   .stream_out_TDATA  (stream_out_pcpi_TDATA),
   .stream_out_TKEEP  (stream_out_pcpi_TKEEP),
   .stream_out_TLAST  (stream_out_pcpi_TLAST),
   .stream_out_TREADY (stream_out_pcpi_TREADY),

   .stream_in_TVALID  (stream_out_pcpi_TVALID_int),
   .stream_in_TDATA   (stream_out_pcpi_TDATA_int),
   .stream_in_TKEEP   (stream_out_pcpi_TKEEP_int),
   .stream_in_TLAST   (stream_out_pcpi_TLAST_int),
   .stream_in_TREADY  (stream_out_pcpi_TREADY_int)
);

assign stream_out_pcpi_TVALID_int = fifo_2B_en;
assign stream_out_pcpi_TKEEP_int = 4'hF;
assign stream_out_pcpi_TDATA_int = fifo_2B_din;


noc_buffer_out#(
   .ADDR_W (NOC_BUFFER_ADDR_W)
) noc_buffer_out_mm(
   .clk_in            (clk_ctrl),
   .clk_out           (clk_line),
   .clk_in_rst_low    (clk_ctrl_rst_low),
   .clk_in_rst_high   (clk_ctrl_rst_high),
   .clk_out_rst_low   (clk_line_rst_low),
   .stream_out_TVALID (stream_out_mem_TVALID),
   .stream_out_TDATA  (stream_out_mem_TDATA),
   .stream_out_TKEEP  (stream_out_mem_TKEEP),
   .stream_out_TLAST  (stream_out_mem_TLAST),
   .stream_out_TREADY (stream_out_mem_TREADY),
   .stream_in_TVALID  (stream_out_mem_TVALID_int),
   .stream_in_TDATA   (stream_out_mem_TDATA_int),
   .stream_in_TKEEP   (stream_out_mem_TKEEP_int),
   .stream_in_TLAST   (stream_out_mem_TLAST_int),
   .stream_in_TREADY  (stream_out_mem_TREADY_int));

assign stream_out_mem_TKEEP_int = 4'hF;

//- Short header
assign pcpi_hl_short       = 1'b0;
assign pcpi_offset_short   = inst_q_put || inst_q_get ? 'h0 :  pcpi_rs1[OFFSET_SZ-1:0] ; 
assign pcpi_header  = {3'h0,pcpi_hl_short,pcpi_code,pt,HsrcId,pcpi_offset_short,pcpi_y_dest,pcpi_x_dest};

//- Long header
assign pcpi_hl       = 1'b1;
assign pcpi_header1  = {3'h0,pcpi_hl,pcpi_code,pt,HsrcId,2'b0,pcpi_pkt_code_get,pcpi_pkt_code,{(8-(2*XY_SZ)){1'b0}},pcpi_y_dest,pcpi_x_dest};


endmodule
