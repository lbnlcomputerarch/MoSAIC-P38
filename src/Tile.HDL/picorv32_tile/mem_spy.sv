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
// Description : Spy processor-memory interface
// File        : mem_spy.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module mem_spy#(
   parameter NOC_BUFFER_ADDR_W = 8,
   parameter XY_SZ = 3,
   parameter OFFSET_SZ=12
)(
   //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_ctrl_rst_low,
   input  logic       clk_ctrl_rst_high,
   input logic        clk_line,
   input logic        clk_line_rst_low,
   input  logic [(XY_SZ*2)-1:0] HsrcId,     //- Tile identification
   output logic        mem_ready_rv,
   input  logic [31:0] mem_addr_rv,
   input  logic [31:0] mem_wdata_rv, 
   input  logic        mem_wstrb_rv, 
   input  logic        mem_valid_rv,
   input  logic        unblock,
   output logic        spy_idle,
   input logic         local_mem,
   input  logic        stream_out_TREADY,
   output logic        stream_out_TVALID,
   output logic [31:0] stream_out_TDATA,
   output logic [ 3:0] stream_out_TKEEP,
   output logic        stream_out_TLAST
);

localparam [2:0] MIO_IDLE  = 3'd0; 
localparam [2:0] MIO_SEND  = 3'd1; 
localparam [2:0] MIO_SEND2 = 3'd4; 
localparam [2:0] MIO_WAIT  = 3'd2; 
localparam [2:0] MIO_READY = 3'd3; 

localparam [2:0] MPUT    = 3'd4;  //- A far-away-galaxy is writing to this Tile
localparam [2:0] MGET    = 3'd5;  //- A far away galaxy is reading from this Tile.
localparam [2:0] MLOAD   = 3'd6;  //- A far-away-galaxy is reading from this Tile. The far-away-galaxy is blocked until the data is received.
localparam [2:0] MSTORE  = 3'd7;  //- A far-away-galaxy is writing to this Tile. The far-away-galaxy is blocked until this Tile sends an ACK.
localparam [2:0] MACK    = 3'd1;  //- This Tile issued a MEM_STORE to a far-away-galaxy and is waiting for this ACK from the far-away-galaxy.  
localparam [2:0] MDATA   = 3'd2;  //- This Tile issued a LOAD to a far-away-galaxy and is waiting for this MEM_DATA from the far-away-galaxy.
localparam [2:0] QM      = 3'd3;  //- This Tile is
//***************************
//* The connections 
//****************************

//- FSMs
logic [2:0] currentState4;
logic [2:0] nextState4;
logic next_mem_ready_rv;

logic stream_out_TVALID_int;
logic   [31:0] stream_out_TDATA_int; 
logic stream_out_TLAST_int;
logic [3:0] stream_out_TKEEP_int;

logic [31:0] mem_header;
logic [OFFSET_SZ-1:0] mem_offset;
logic [XY_SZ-1:0] mem_x_dest;
logic [XY_SZ-1:0] mem_y_dest;
logic [2:0] mem_code;
logic mem_hl;
logic pt;

always @(posedge clk_ctrl or negedge clk_ctrl_rst_low) begin
   if (~clk_ctrl_rst_low) begin
      currentState4 <= MIO_IDLE;
      mem_ready_rv <= 1'b0;
   end else begin
      currentState4 <= nextState4;
      mem_ready_rv <= next_mem_ready_rv;
   end
end

assign spy_idle = currentState4 == MIO_IDLE; 

always @( * ) begin
   //- State
   nextState4 = currentState4;
   next_mem_ready_rv = mem_ready_rv;

   stream_out_TVALID_int = 1'b0;
   stream_out_TDATA_int  = 'h0; 
   stream_out_TLAST_int  = 1'b0;

   case (currentState4)
      MIO_IDLE: begin //0
        next_mem_ready_rv = 1'b0;
        if (mem_valid_rv)
          if (!local_mem && !mem_ready_rv)
            nextState4 = MIO_SEND;
      end
      MIO_SEND:begin //1
        next_mem_ready_rv = 1'b0;
        if (stream_out_TREADY_int) begin
          nextState4 = MIO_SEND2;
        end
        stream_out_TVALID_int = 1'b1;
        stream_out_TDATA_int  = mem_header; 
        stream_out_TLAST_int = 1'b0;
      end
      MIO_SEND2:begin //4
        next_mem_ready_rv = 1'b0;
        if (stream_out_TREADY_int) begin
          nextState4 = MIO_WAIT;
        end
        stream_out_TVALID_int = 1'b1;
        if (|mem_wstrb_rv) stream_out_TDATA_int  =  mem_wdata_rv;
        else stream_out_TDATA_int  = 'h0;
        stream_out_TLAST_int = 1'b1;
      end
      MIO_WAIT:begin //2
        if (unblock) begin
          nextState4 = MIO_IDLE;
          next_mem_ready_rv = 1'b1;
        end
      end
      MIO_READY:begin //3
          next_mem_ready_rv = 1'b1;
          nextState4 = MIO_IDLE;
      end
   endcase
end

assign stream_out_TKEEP_int = 4'hF;

noc_buffer_out#(
   .ADDR_W (NOC_BUFFER_ADDR_W)
) noc_buffer_out(
   .clk_in            (clk_ctrl),
   .clk_in_rst_low    (clk_ctrl_rst_low),
   .clk_in_rst_high   (clk_ctrl_rst_high),
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

assign pt = 0;

assign mem_hl     = 1'b0;
assign mem_offset = mem_addr_rv[OFFSET_SZ-1:0]; 

assign mem_y_dest = mem_addr_rv[OFFSET_SZ+(2*XY_SZ)-1:OFFSET_SZ+XY_SZ];
assign mem_x_dest = mem_addr_rv[OFFSET_SZ+XY_SZ-1:OFFSET_SZ];


assign mem_code   = |mem_wstrb_rv ? MSTORE : MLOAD;
assign mem_header = {3'b0,mem_hl,mem_code,pt,HsrcId,mem_offset,mem_y_dest,mem_x_dest};

endmodule
