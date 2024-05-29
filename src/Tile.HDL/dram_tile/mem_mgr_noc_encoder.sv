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
// Description : Forms the NoC response 
// File        : mem_mgr_noc_encoder.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module mem_mgr_noc_encoder#(
   parameter XY_SZ =  3,
   parameter OFFSET_SZ    = 12
)(
   input  logic [(XY_SZ*2)-1:0] HsrcId,     //- Tile identification
   input  logic                 clk_ctrl,
   input  logic                 clk_ctrl_rst_low,
   output logic                 stream_out_TVALID,
   output logic          [31:0] stream_out_TDATA,
   output logic           [3:0] stream_out_TKEEP,
   output logic                 stream_out_TLAST,
   input  logic                 stream_out_TREADY,
   input  logic          [31:0] header1,
   input  logic          [31:0] data1,
   input  logic                 cpu_res_valid,
   input  logic          [31:0] cpu_res_data,
   output logic  cpu_res_ready
   
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
localparam [2:0] CPU_REQ     = 3'd4;
localparam [2:0] IGNORE      = 3'd6;
localparam [2:0] WAIT        = 3'd1;
localparam [2:0] ERROR       = 3'd7;

//- NOC Output state machine: state_noc_out
localparam [2:0] GET_HEADER  = 'h1;
localparam [2:0] SEND_HEADER = 'h2;
localparam [2:0] SEND_HEADER2 = 'h6;
localparam [2:0] SEND_DATA   = 'h3;
localparam [2:0] SEND_DATA1  = 'h4;
localparam [2:0] CHECK_HEADER  = 'h5;

//- AXI (aw-ar) state machine: s_axi_state_in
localparam [2:0] WRITE_AW = 1;
localparam [2:0] WRITE_W  = 2;
localparam [2:0] READ_AR  = 3;

//- Memory parameters 
localparam IN_MEMSIZE_KB = 1;
localparam    CPU_BUS_SZ = 32;
localparam    MEM_BUS_SZ = 512;

//logic [31:0] next_header1_fifo_B_addr;
//logic [31:0] header1_fifo_B_addr;

logic [31:0] noc_out_ctr;
logic [31:0] next_noc_out_ctr;

logic [2:0] noc_out_state;
logic [2:0] next_noc_out_state;

//- NoC output
logic           [2:0] noc_out_code;
logic          [31:0] noc_out_header;
logic          [31:0] noc_out_header2;
logic                 noc_out_pt;
logic [OFFSET_SZ-1:0] noc_out_offset;
logic     [XY_SZ-1:0] noc_out_x_dest;
logic     [XY_SZ-1:0] noc_out_y_dest;
logic                 noc_out_hl;
 
logic          [31:0] cpu_res_data_reg;

always @(posedge clk_ctrl or negedge clk_ctrl_rst_low) begin
   if (~clk_ctrl_rst_low) 
      cpu_res_data_reg <= 'h0;
   else if (cpu_res_valid) 
      cpu_res_data_reg <= cpu_res_data;
end


always @(posedge clk_ctrl or negedge clk_ctrl_rst_low) begin
  if (~clk_ctrl_rst_low)begin
    noc_out_state   <= 'h0;
    noc_out_ctr         <= 'h0;
  end else begin
    noc_out_state <= next_noc_out_state;
    noc_out_ctr <= next_noc_out_ctr;
  end
end

always @( * ) begin
   //- State
   next_noc_out_state = noc_out_state;
   next_noc_out_ctr = noc_out_ctr;

   stream_out_TVALID = 1'b0;
   stream_out_TDATA  =  'h0;
   stream_out_TKEEP  =  'h0;
   stream_out_TLAST  = 1'b0;

   case (noc_out_state)
      IDLE: begin
         if (cpu_res_valid) begin
            if (header1[27:25] == MPUT) //- don't do anything
               next_noc_out_state = IDLE;
            else if (stream_out_TREADY) begin
               stream_out_TVALID = 1'b1;
               stream_out_TDATA = noc_out_header;
               stream_out_TKEEP = 'hFF;
               stream_out_TLAST = 1'b0;
               if ( header1[28]) begin //- Long packet
                  if (header1[27:25] == MGET || header1[27:25] == MLOAD ) begin
                     next_noc_out_state = SEND_HEADER2;
                     next_noc_out_ctr =  ('h1 << header1[15:12]);
                  end else begin //- MSTORE
                     next_noc_out_state = SEND_DATA1;
                     next_noc_out_ctr = 'h1;
                  end
               end else begin
                  next_noc_out_state = SEND_DATA1;
                  next_noc_out_ctr = 'h1;
              end
           end
        end
      end
      SEND_HEADER2: begin //6
          stream_out_TVALID = 1'b1;
          stream_out_TDATA = noc_out_header2;
          stream_out_TKEEP = 'hFF;
          stream_out_TLAST = 1'b0;
          next_noc_out_state = SEND_DATA1;
      end
      SEND_DATA1: begin //4
        if (stream_out_TREADY) begin
          stream_out_TVALID = 1'b1;
          stream_out_TDATA = cpu_res_data_reg;
          stream_out_TKEEP = 'hFF;
          if (noc_out_ctr == 'h1) begin
            stream_out_TLAST = 1'b1;
            next_noc_out_state = IDLE;
         end else begin
            next_noc_out_state = SEND_DATA;
            next_noc_out_ctr = next_noc_out_ctr - 'h1;
         end
        end
      end
      SEND_DATA: begin //3
         if (stream_out_TREADY) begin
            if (cpu_res_valid) begin
               stream_out_TVALID = 1'b1;
               stream_out_TDATA  = cpu_res_data;
               stream_out_TKEEP  = 'hFF;
               if (noc_out_ctr == 'h1) begin
                 stream_out_TLAST = 1'b1;
                 next_noc_out_state = IDLE;
               end else
                 next_noc_out_ctr = next_noc_out_ctr - 'h1;
            end
         end
      end
    endcase
end


assign noc_out_pt = 1;

assign noc_out_hl = header1[27:25] == MSTORE ? 1'b0  :
                    header1[27:25] == MLOAD  ? 1'b0 : 
                    header1[27:25] == MGET   ? header1[28] : 1'b0
 ;
assign noc_out_code = header1[27:25] == MSTORE ? MACK  :
                      header1[27:25] == MLOAD  ? MDATA : 
                      header1[27:25] == MGET   ? MPUT  : 'h0;

assign noc_out_offset = header1[27:25] == MSTORE ? 'h0 :
                        header1[27:25] == MLOAD  ? data1[OFFSET_SZ-1:0] :
                        header1[27:25] == MGET   ? 
                        header1[28] ? {6'b000000,header1[15:12],2'b00}  : data1[OFFSET_SZ-1:0] : 'h0; 

assign noc_out_x_dest = header1[20:18];
assign noc_out_y_dest = header1[23:21];
assign noc_out_header = {3'b0,noc_out_hl,noc_out_code,noc_out_pt,HsrcId,noc_out_offset,noc_out_y_dest,noc_out_x_dest};
assign noc_out_header2 = data1;

assign cpu_res_ready = stream_out_TREADY;

endmodule

