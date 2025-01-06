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
// Date        : Sept 29 2022
// Description : Decode the NoC header 
// File        : noc_decoder.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps
`include "global_defines.sv"

module noc_decoder #(
   parameter BW    = 32,
   parameter BWB   = BW/8,
   parameter XY_SZ = 3
)(
  //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_line,
   input  logic       clk_ctrl_rst_low,
   input  logic       clk_line_rst_low,
   input  logic [(XY_SZ*2)-1:0] HsrcId,     //- Tile identification
   //---NOC interface---//
   //- Input Interface
   input  logic        stream_in_TVALID,
   input  logic  [BW-1:0] stream_in_TDATA,
   input  logic [BWB-1:0] stream_in_TKEEP, 
   input  logic        stream_in_TLAST,
   output logic        stream_in_TREADY,  
   //- Output Interface
   input  logic        stream_out_TREADY,
   output logic        stream_out_TVALID,
   output logic  [BW-1:0] stream_out_TDATA,
   output logic [BWB-1:0] stream_out_TKEEP,
   output logic        stream_out_TLAST,
   //--- Decoding ---//
   output logic          unblock,      //- Set to 1 if not used
   input  logic          spy_idle,     //- Set to 1 if not used
   input  logic          pcpi_idle,    //- Set to 1 is not used
   input  logic          fifo_0_full,
   output logic          fifo_0A_en,   //- Message queues
   output logic   [31:0] fifo_0A_addr,
   output logic   [31:0] mem_addr_a,   //- Scratchpad memory
   output logic [BW-1:0] mem_wdata_a, 
   output logic          mem_wstrb_a,
   output logic          mem_valid_a,
   input  logic [BW-1:0] mem_rdata_a,
   output logic   [31:0] mem_rdata_rv
);

/***************************
* Local parameters for FSMs
****************************/
localparam OFFSET_SZ = 12;
//- NOC Instruction decoder  
localparam [2:0] MPUT    = 3'd4;  //- A far-away-galaxy is writing to this Tile
localparam [2:0] MGET    = 3'd5;  //- A far away galaxy is reading from this Tile.
localparam [2:0] MLOAD   = 3'd6;  //- A far-away-galaxy is reading from this Tile. The far-away-galaxy is blocked until the data is received.
localparam [2:0] MSTORE  = 3'd7;  //- A far-away-galaxy is writing to this Tile. The far-away-galaxy is blocked until this Tile sends an ACK.
localparam [2:0] MACK    = 3'd1;  //- This Tile issued a MEM_STORE to a far-away-galaxy and is waiting for this ACK from the far-away-galaxy.  
localparam [2:0] MDATA   = 3'd2;  //- This Tile issued a LOAD to a far-away-galaxy and is waiting for this MEM_DATA from the far-away-galaxy.
localparam [2:0] QM      = 3'd3;  //- This Tile issued a MEM_STORE to a far-away-galaxy and is waiting for this ACK from the far-away-galaxy. 

//- State machine
localparam [3:0] IDLE       = 4'd0; //
localparam [3:0] FIFO_WR    = 4'd1; //
localparam [3:0] MEM_WR     = 4'd2; //
localparam [3:0] MEM_WR_ACK = 4'd3; //
localparam [3:0] MEM_WR_DAT = 4'd7; //
localparam [3:0] MEM_ACK    = 4'd8; //
localparam [3:0] WAIT       = 4'd4; //
localparam [3:0] MEM_RD     = 4'd5; //
localparam [3:0] MEM_RD2    = 4'hB; //
localparam [3:0] WAIT_SEND  = 4'd6; //
localparam [3:0] HEADER2    = 4'd9; 
localparam [3:0] ERROR      = 4'd15; //
localparam [3:0] IGNORE     = 4'hA;


//***************************
//* The connections 
//****************************

//- FSMs
(*mark_debug = "true" *) logic [3:0] currentState1; //- NoC input 
logic [3:0] nextState1;
logic  [2:0] noc_out_code;
logic [31:0] next_fifo_0A_addr;

logic [BW-1:0] noc_data_in;
logic [31:0] next_mem_addr_a;
logic [BW-1:0] next_noc_header1_in;
logic [BW-1:0] noc_header1_in;
logic [BW-1:0] next_noc_data_in;
logic [31:0] next_ctr;
logic [31:0] ctr;
logic [31:0] noc_offset_in;

logic hl_reg;

logic pt;
assign pt=0;

logic  [5:0] noc_out_dest;
logic [11:0] noc_out_offset;

logic [BW-1:0] noc_out_header1a;

//logic fifo_0A_we;

//- Get and decode the NOC code 
logic [2:0] noc_code;
logic [2:0] noc_code_reg;
assign noc_code     = stream_in_TDATA[27:25];
assign noc_code_reg = noc_header1_in[27:25];

assign noc_inst_put   = noc_code == MPUT;
assign noc_inst_get   = noc_code == MGET;
assign noc_inst_load  = noc_code == MLOAD; 
assign noc_inst_store = noc_code == MSTORE; 
assign noc_inst_ack   = noc_code == MACK;
assign noc_inst_queue = noc_code == QM; 
assign noc_inst_data  = noc_code == MDATA;

logic [31:0] next_mem_rdata_rv;

always @(posedge clk_ctrl or negedge clk_ctrl_rst_low) begin
   if (~clk_ctrl_rst_low) begin
      currentState1 <= IDLE;
      fifo_0A_addr  <= 'h0; //- Write address for inbound FIFO
      noc_header1_in <= 'h0;
      noc_data_in   <= 'h0;
      mem_addr_a   <= 'h0;
      ctr <= 'h0;
      mem_rdata_rv <= 'h0;
   end else begin
      currentState1 <= nextState1;
      fifo_0A_addr  <= next_fifo_0A_addr;   
      noc_header1_in <= next_noc_header1_in;
      noc_data_in   <= next_noc_data_in;
      mem_addr_a   <= next_mem_addr_a;
      ctr <= next_ctr;
      mem_rdata_rv <= next_mem_rdata_rv;
   end
end

logic hl;
assign hl = stream_in_TDATA[28];
assign hl_reg = noc_header1_in[28];
assign noc_offset_in = {20'h0,stream_in_TDATA[17:6]};

logic [31:0] req_id;
logic [31:0] next_req_id;

always @( * ) begin
   //- State
   nextState1 = currentState1;

   //- Memory
   mem_valid_a = 1'b0;
   mem_wstrb_a = 1'b0;
   next_mem_addr_a = mem_addr_a;
   next_mem_rdata_rv = mem_rdata_rv;
  
   next_noc_header1_in = noc_header1_in;
   next_noc_data_in   = noc_data_in;
   next_ctr = ctr;

   stream_out_TVALID = 1'b0;
   stream_out_TLAST  = 1'b0;
   stream_out_TKEEP  = 4'hF;
   stream_out_TDATA  =  'h0;

   stream_in_TREADY = 1'b1;

   fifo_0A_en = 1'b0;
   next_fifo_0A_addr = fifo_0A_addr;


   case (currentState1)
      IDLE: begin                                              // Waiting for an incoming packet
         if (stream_in_TVALID) begin
            next_noc_header1_in = stream_in_TDATA;
            if      (noc_inst_data)     nextState1 = MEM_WR_DAT;  // End previous MLOAD transaction after writing to MEM 
            else if (noc_inst_ack)      nextState1 = MEM_ACK;     // End previous MSTORE transaction 
            else if (noc_inst_queue) begin     // - Write to Queue
               if (fifo_0_full) begin
                  stream_in_TREADY = 1'b0;
               end else begin
                  fifo_0A_en        = 1'b1;
                  next_fifo_0A_addr = fifo_0A_addr + 'h1;
                  nextState1        = FIFO_WR;
               end
            end else if (hl) begin 
               nextState1 = HEADER2;     // Write
               if (noc_inst_put) next_ctr = (1 << stream_in_TDATA[11:8])-1;
               else if (noc_inst_get) next_ctr = (1 << stream_in_TDATA[15:12])-1;
            end else begin
               next_mem_addr_a = noc_offset_in;
               next_ctr = 0;
               if (noc_inst_put || noc_inst_store)
                 nextState1 = MEM_WR;
               else if (noc_inst_get || noc_inst_load)
                 nextState1 = MEM_RD;
               else
                 nextState1   = IGNORE;
            end
         end
      end
      HEADER2: begin //9
         if (stream_in_TVALID) begin
            //next_mem_addr_a = stream_in_TDATA[OFFSET_SZ-1:0]; //Nov 30 2023
            next_mem_addr_a = stream_in_TDATA;
            if (noc_code_reg == MPUT || noc_code_reg == MSTORE)
               nextState1 = MEM_WR;  
            else if (noc_code_reg == MGET || noc_code_reg == MLOAD)
               nextState1 = MEM_RD;     // Write
            else
              nextState1   = IGNORE;
         end
      end
      FIFO_WR: begin //- Get the data and push it in the FIFO
         if (stream_in_TVALID) begin
            if (fifo_0_full) begin
               stream_in_TREADY = 1'b0;
            end else begin
               next_noc_data_in = stream_in_TDATA;
               fifo_0A_en = 1'b1;
               next_fifo_0A_addr = fifo_0A_addr + 'h1;
               if (stream_in_TLAST)
                  nextState1 = IDLE;
            end
        end
      end
      MEM_WR: begin  //-2 MPUT (Write memory)
         if (stream_in_TVALID) begin              
            next_noc_data_in = stream_in_TDATA;
            mem_valid_a = 1'b1;
            mem_wstrb_a = 1'b1;
            next_mem_addr_a = mem_addr_a + 'h1;
            if (stream_in_TLAST) begin
               if (noc_code_reg == MSTORE) nextState1 = MEM_WR_ACK;
               else                        nextState1 = IDLE;
            end
         end
      end
      MEM_WR_ACK:begin //- MSTORE (Write and send ACK)
          stream_out_TVALID = 1'b1;
          stream_out_TKEEP  = 4'hF;
          stream_out_TDATA  = noc_out_header1a;
          stream_in_TREADY = 1'b0;
          nextState1   = WAIT_SEND;
      end
      MEM_WR_DAT: begin //- MDATA (Unblock processor)                   
        if (stream_in_TVALID) begin
          next_mem_rdata_rv = stream_in_TDATA;
          //if (currentState4 == MIO_IDLE && currentState2 == IDLE_S) begin
          if (spy_idle && pcpi_idle) begin
            nextState1 = IDLE;
          end else nextState1 = WAIT;
        end
      end
      MEM_ACK: begin
        if (stream_in_TVALID) begin
          next_noc_data_in = stream_in_TDATA;
          nextState1 = WAIT;
        end
      end
      MEM_RD: begin //-5 MLOAD/MGET Read and send response
         if (stream_out_TREADY) begin
            if (stream_in_TVALID) begin
               next_noc_data_in = stream_in_TDATA;
               stream_out_TVALID = 1'b1;
               stream_out_TLAST  = 1'b0;
               stream_out_TKEEP  = 4'hF;
               stream_out_TDATA  = noc_out_header1a;

               if (hl_reg)
                  nextState1 = MEM_RD2;
               else begin
                  nextState1 = WAIT_SEND;
                  mem_valid_a = 1'b1;
               end
            end
         end else stream_in_TREADY = 1'b0;
      end
      MEM_RD2: begin //-B
         stream_out_TVALID = 1'b1;
         stream_out_TLAST  = 1'b0;
         stream_out_TKEEP  = 4'hF;
         stream_out_TDATA  = noc_data_in;
         if (stream_out_TREADY) begin
            nextState1 = WAIT_SEND;
            mem_valid_a = 1'b1;
            next_mem_addr_a = mem_addr_a + 'h1; //- August 17 2023
         end else stream_in_TREADY = 1'b0;
      end      
      WAIT: begin //4
        if (spy_idle && pcpi_idle) begin
          nextState1 = IDLE;
        end
         stream_in_TREADY = 1'b0;
      end
      WAIT_SEND: begin //6
         stream_out_TVALID = 1'b1;
         if (noc_code_reg == MSTORE)
            stream_out_TDATA = 'h0;
         else
            stream_out_TDATA = mem_rdata_a;

         if (stream_out_TREADY) begin
            if (ctr == 0)begin
                stream_out_TLAST  = 1'b1;
                if (noc_code_reg == MSTORE) 
                   nextState1 = WAIT;
                else
                   nextState1 = IDLE;
            end else begin
                mem_valid_a = 1'b1;
                next_mem_addr_a = mem_addr_a + 'h1;
                stream_out_TLAST  = 1'b0;
                next_ctr = ctr -1;
            end
         end
         stream_in_TREADY = 1'b0;
      end
      IGNORE: begin //A
         if (stream_in_TLAST) 
            nextState1 = IDLE;
      end 
  endcase
end


/*
//FIXME: ADD condition for message queue fifo
assign stream_in_TREADY = currentState1 != WAIT_SEND && currentState1 != MEM_WR_ACK && currentState1 != WAIT && 
                         (stream_out_TREADY || noc_code == MPUT || noc_code_reg == MPUT) && clk_ctrl_rst_low;
*/

assign mem_wdata_a = stream_in_TDATA; 

//- Unblock processor 
assign unblock = currentState1==WAIT;

//- Not used
logic is_array; 
logic mem_addr_b_32;
assign mem_addr_b_32 = 0;
logic is_array_dec;
`include "is_array.vh"

/* If it inside the array, each tile only has a 32 bits offset 
 * Other than that, it should go to DRAM.*/
assign noc_out_dest = noc_code_reg == MGET & hl_reg ? 
                      is_array_dec ? stream_in_TDATA[OFFSET_SZ+5:OFFSET_SZ] : `ROW : 
                      noc_header1_in[23:18];

assign noc_out_code   = noc_code_reg == MGET ? MPUT :
                        noc_code_reg == MSTORE ? MACK: MDATA;

assign noc_out_offset = hl_reg ? 
                       (noc_code_reg == MGET   ? {4'h0,noc_header1_in[15:12],2'b00} : {6'h0,4'h0,2'b00}) : 
                        stream_in_TDATA[OFFSET_SZ-1:0];

assign noc_out_header1a = {3'b0,hl_reg,noc_out_code,pt,HsrcId,noc_out_offset,noc_out_dest};

endmodule

