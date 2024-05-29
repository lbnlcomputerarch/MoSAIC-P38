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
// Description : Decode the NoC header 
// File        : mem_mgr_noc_decoder.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module mem_mgr_noc_decoder #(
   parameter S_AXI_ID_SZ  = 11,
   parameter S_AXI_LEN_SZ = 8,    // LENGTH
   parameter OFFSET_SZ    = 12
)(
  //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_ctrl_rst_low,
   //- Input Interface
   input  logic        stream_in_TVALID,
   input  logic [31:0] stream_in_TDATA,
   input  logic [ 3:0] stream_in_TKEEP, 
   input  logic        stream_in_TLAST,
   output logic        stream_in_TREADY,  
   //- CPU-CACHE interface
   output logic                    cpu_req_valid, //- Cache input
   output logic                    cpu_req_rw,    //- Cache input
   output logic [31:0]             cpu_req_data,  //- Cache input
   output logic [31:0]             cpu_req_addr,  //- Cache input
   output logic [S_AXI_ID_SZ-1:0]  cpu_req_id,    //- Cache input
   output logic [S_AXI_LEN_SZ-1:0] cpu_req_len,   //-
   input  logic                    cpu_req_ready, //- Cache output
   //- Miscellaneus data
   output logic [31:0]             header1,
   output logic [31:0]             data1
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

//- NOC Input state machine : state_noc_in
localparam [2:0] IDLE        = 3'd0;
localparam [2:0] SECOND_WORD = 3'd2;
localparam [2:0] THIRD_WORD  = 3'd3;
localparam [2:0] WRITE       = 3'd4;
localparam [2:0] IGNORE      = 3'd6;
localparam [2:0] READ        = 3'd1;
localparam [2:0] FINISH      = 3'd7;

/***************************
* Connections
****************************/

//- state machines

logic [2:0] state_noc_in;
logic [2:0] next_state_noc_in;

//- CPU-CACHE interface
logic [31:0]             cpu_req_addr_reg;    //- Cache input
logic [S_AXI_ID_SZ-1:0]  next_cpu_req_id; 
logic [31:0] next_cpu_req_addr;   
logic [31:0] cpu_req_ctr;
logic [31:0] next_cpu_req_ctr;

logic [31:0] next_header1;
logic [31:0] next_data1;
logic [2:0] noc_code;

assign noc_code = header1[27:25];
assign hl       = header1[28];

assign noc_inst_put   = noc_code == MPUT;
assign noc_inst_get   = noc_code == MGET;
assign noc_inst_load  = noc_code == MLOAD; 
assign noc_inst_store = noc_code == MSTORE; 

assign noc_inst_valid = stream_in_TDATA[27:25] == MPUT  ||
                        stream_in_TDATA[27:25] == MGET  ||
                        stream_in_TDATA[27:25] == MLOAD ||
                        stream_in_TDATA[27:25] == MSTORE;

//- ADD OFFSET_SZ and XY_SZ parameters as in the other decoders
logic [11:0] noc_offset_in;
assign noc_offset_in = header1[17:6];

always @(posedge clk_ctrl or negedge clk_ctrl_rst_low) begin
   if (~clk_ctrl_rst_low)begin
      state_noc_in <= 'h0;
      header1 <= 'h0;
      data1 <= 'h0;
      cpu_req_id <= 'h0;
      cpu_req_addr_reg <= 'h0;
      cpu_req_ctr <= 'h0;
   end else begin
      state_noc_in <= next_state_noc_in;
      header1 <= next_header1;
      data1 <= next_data1;
      cpu_req_id <= next_cpu_req_id;
      cpu_req_addr_reg <= next_cpu_req_addr;
      cpu_req_ctr <= next_cpu_req_ctr;
   end
end

always @( * ) begin
   //- State
   next_state_noc_in = state_noc_in;
   next_cpu_req_ctr = cpu_req_ctr;

   //-
   next_header1 = header1;
   next_data1    = data1;
   //-
   next_cpu_req_id = cpu_req_id;
   next_cpu_req_addr = cpu_req_addr_reg;

   //- cpu_req Interface
   cpu_req_valid =  1'b0;
   cpu_req_rw    =  1'b0;
   cpu_req_data  = 32'h0; 
   cpu_req_addr  = 'h0;
   cpu_req_len  = 'h0;


   case (state_noc_in)
      IDLE: begin //0
         if (stream_in_TVALID & stream_in_TREADY) begin
            if (noc_inst_valid) begin
               next_header1      = stream_in_TDATA;
               next_state_noc_in = SECOND_WORD;
             end else next_state_noc_in = IGNORE;
         end
      end
      SECOND_WORD: begin //Second header (long packet) or data (short packet)
         if (stream_in_TVALID) begin
            if (hl) begin //- Long packet
               next_cpu_req_addr = stream_in_TDATA;
               if (noc_inst_store || noc_inst_put) begin
                  cpu_req_len       = 'h1 << header1[11:8];
                  next_cpu_req_ctr  = 'h1 << header1[11:8];
                  next_state_noc_in = WRITE;
               end else begin
                  cpu_req_len       = 'h1 << header1[15:12];
                  next_cpu_req_ctr  = 'h1 << header1[15:12];
                  next_state_noc_in = THIRD_WORD;
               end
            end else begin //- Short packet
               next_data1    = stream_in_TDATA;
               cpu_req_valid =  1'b1;
               cpu_req_addr  =  {12'h0,next_header1[5:0],noc_offset_in,2'b00}; //- LPGG May 25 2023
               cpu_req_len   = 'h1;
               if (noc_inst_store || noc_inst_put) begin
                  cpu_req_rw    =  1'b1;
                  cpu_req_data  = stream_in_TDATA;
               end else begin
                  cpu_req_rw    =  1'b0;
               end
               next_state_noc_in = FINISH;
            end
         end
      end
      THIRD_WORD: begin // only long packets for qGet/MLOAD (Third and fourth)
         if (stream_in_TVALID) begin
            if (stream_in_TLAST)
               next_state_noc_in = READ;
            else begin
               cpu_req_valid = 1;
               cpu_req_addr  = cpu_req_addr_reg; 
               cpu_req_rw    =  1'b0;
               next_cpu_req_addr = cpu_req_addr_reg + 'h4;
               next_cpu_req_ctr = cpu_req_ctr - 'h1;
               next_data1 = stream_in_TDATA;
            end
         end
      end
      IGNORE: begin //6
         if (stream_in_TVALID) begin
            if (stream_in_TLAST) next_state_noc_in = IDLE;
         end
      end
      WRITE: begin //4
         if (stream_in_TVALID & cpu_req_ready) begin //put
            cpu_req_valid =  1'b1;
            cpu_req_addr  = cpu_req_addr_reg;
            cpu_req_rw    =  1'b1;
            cpu_req_data  = stream_in_TDATA;
            next_cpu_req_addr = cpu_req_addr_reg + 'h4;
            if (stream_in_TLAST) begin
               next_state_noc_in = FINISH;
            end
         end
      end
      READ: begin //1
         if (cpu_req_ctr > 0 & cpu_req_ready) begin 
            cpu_req_valid =  1'b1;
            cpu_req_addr  = cpu_req_addr_reg;
            cpu_req_rw    =  1'b0;
            cpu_req_data  = 'h0;
            next_cpu_req_addr = cpu_req_addr_reg + 'h4;
            next_cpu_req_ctr = cpu_req_ctr - 'h1;
            if (cpu_req_ctr == 1) begin
               next_state_noc_in = FINISH;
            end
         end
      end
      FINISH: begin //7
         if (stream_in_TLAST & stream_in_TVALID) begin // If last data 
            if (cpu_req_ready) begin // wait until cpu_req_ready
               next_state_noc_in = IDLE;
               next_cpu_req_id = cpu_req_id + 'h1;
            end
         end else begin //- Otherwise don't wait up
            next_state_noc_in = IDLE;
            next_cpu_req_id = cpu_req_id + 'h1;
         end
      end
   endcase
end

assign stream_in_TREADY = cpu_req_ready & state_noc_in != READ;



endmodule

