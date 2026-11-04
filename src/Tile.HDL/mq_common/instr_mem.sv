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
// Date        : Dec 1 2023
// Description : Instruction memory for picorv32.  
// File        : instr_mem.sv
// Notes       :
////////////////////////////////////////////////

`timescale 1 ps / 1 ps
`include "global_defines.sv"

module instr_mem#(
   parameter CPU_BUS_SZ   = 32,
   parameter MEM_BUS_SZ   = 512,
   parameter OFFSET_SZ    = 12,
   parameter CACHE_LINES  = 8   // number of cache lines
)(
   input logic       clk_ctrl,
   input logic       clk_ctrl_rst_low,
   input logic       clk_ctrl_rst_high,
   input logic       clk_line, 
   input logic       clk_line_rst_low,
   input logic       clk_line_rst_high,
   input logic [5:0] HsrcId,
   //- CPU request (CPU -> Cache)
   input  logic  [CPU_BUS_SZ-1:0]  cpu_req_addr,  // 32-bit request addr
   input  logic  [CPU_BUS_SZ-1:0]  cpu_req_data,  // 32-bit request data (used when write)
   input  logic                    cpu_req_rw,    // request type : 0 = read, 1 = write 
   input  logic                    cpu_req_valid, // request is valid
   //- Cache result (Cache->CPU)
   output logic   [CPU_BUS_SZ-1:0] cpu_res_data,  //32-bit data
   output logic                    cpu_res_valid, //result is ready
   //- NOC Interface 
   input  logic        stream_out_TREADY,
   output logic        stream_out_TVALID,
   output logic [31:0] stream_out_TDATA,
   output logic [ 3:0] stream_out_TKEEP,
   output logic        stream_out_TLAST,
   //- NoC memory interface
   input logic [31:0] mem_addr,
   input logic [31:0] mem_wdata,
   input logic        mem_wstrb,
   input logic        mem_valid
);

localparam [2:0] MLOAD   = 3'd6;  //- A far-away-galaxy is reading from this Tile. 
                                  //  The far-away-galaxy is blocked until the data is received.
localparam [2:0] MSTORE  = 3'd7;  //- A far-away-galaxy is writing to this Tile. 
                                  //  The far-away-galaxy is blocked until this Tile sends an ACK.
localparam [2:0] MPUT    = 3'd4;  //- A far-away-galaxy is writing to this Tile
localparam [2:0] MGET    = 3'd5;  //- A far away galaxy is reading from this Tile.

localparam [2:0] X_DRAM = `X_DRAM; 
localparam [2:0] Y_DRAM = `Y_DRAM;

/* signals */

//- Memory request (Cache->Memory)
logic   [CPU_BUS_SZ-1:0] mem_req_addr;  //request byte addr

/* For scratchpad
logic [31:0] mem_req_addr_32b;
logic [31:0] mem_req_addr_32b_o;
logic [31:0] mem_req_addr_32b_o_n;
assign mem_req_addr_32b = (mem_req_addr >> 2); 
assign mem_req_addr_32b_o = mem_req_addr_32b - 2048; //- FIXME: This has to go along with software
assign mem_req_addr_32b_o_n = {mem_req_addr_32b_o[31:4],4'h0}; //- Align
*/

logic [31:0] cpu_req_addr_norm;
logic [31:0] mem_req_addr_0;
logic [31:0] mem_req_addr_1;
logic [31:0] mem_req_addr_2;

assign cpu_req_addr_norm = cpu_req_addr - 'h28000;

assign mem_req_addr_0 = {mem_req_addr[31:6],6'h0};      //- Align
//assign mem_req_addr_1 = mem_req_addr_0 - 'h28000;     //- Remove offset. 
assign mem_req_addr_1 = mem_req_addr_0;                 
assign mem_req_addr_2 = (mem_req_addr_0 >> 2) + 'h1000; //- In 32b words. 
                                                        //  Only the 4 LSB are used

logic   [MEM_BUS_SZ-1:0] mem_req_data;  //128-output logic request data (used when write)
logic                    mem_req_rw;    // request type : 0=read, 1=write
logic                    mem_req_valid; // request is valid

//- (Memory -> Cache)
logic [MEM_BUS_SZ-1:0] mem_data_data;
logic mem_data_ready;


//- Internal interface to NoC
logic        stream_out_TVALID_int;
logic [31:0] stream_out_TDATA_int; 
logic        stream_out_TLAST_int;
logic  [3:0] stream_out_TKEEP_int;
logic        stream_out_TREADY_int;

//- Packet
logic [2:0] pkt_code;
logic [3:0] pkt_sz_code;
logic [31:0] header;
logic [CPU_BUS_SZ-1:0] mem_req_data_32;

//- logic
logic [1:0] state_in;
logic [1:0] next_state_in;
logic [1:0] state_out;
logic [1:0] next_state_out;

logic [3:0] counter_in;
logic [3:0] counter_out;

logic [3:0] next_counter_in;
logic [3:0] next_counter_out;

logic [CPU_BUS_SZ-1:0] mem_data_data_array [0:15];

//////////////////////////////
// Cache
//////////////////////////////

dm_cache_fsm #(
  .CPU_BUS_SZ (CPU_BUS_SZ),
  .MEM_BUS_SZ (MEM_BUS_SZ)
)dm_cache_fsm_inst(
   .clk            (clk_ctrl),
   .rst            (~clk_ctrl_rst_low),
   //- CPU request (CPU -> Cache)
   .cpu_req_addr   (cpu_req_addr_norm), // 32-bit request addr
   .cpu_req_data   (cpu_req_data),  // 32-bit request data (used when write)
   .cpu_req_rw     (cpu_req_rw),    // request type : 0 = read, 1 = write 
   .cpu_req_valid  (cpu_req_valid), // request is valid
   .cpu_req_ready  (), // Output 
   .cpu_req_id     (11'h0),           // Input not used here
   .cpu_req_len    (8'h0),           // Input not used here
   //- Memory response (Memory -> Cache)
   .mem_data_data  (mem_data_data),
   .mem_data_ready (mem_data_ready),
   //- Memory request (Cache->Memory)
   .mem_req_addr   (mem_req_addr),  // request byte addr
   .mem_req_data   (mem_req_data),  // MEM_BUS_SZ.request data (used when write)
   .mem_req_rw     (mem_req_rw),    // request type : 0=read, 1=write
   .mem_req_valid  (mem_req_valid), // request is valid
   .mem_req_id     (),           // Output not used here
   .mem_req_len    (),           // Output not used here
   //- Cache result (Cache->CPU)
   .cpu_res_data   (cpu_res_data),  //32-bit data
   .cpu_res_ready  (1'b1), //
   .cpu_res_valid  (cpu_res_valid)  // result is ready
);


//////////////////
// NOC ENCODER
/////////////////

always @(posedge clk_ctrl) begin
  if (~clk_ctrl_rst_low)begin
    state_in   <= 'h0;
    counter_in <= 'h0;
  end else begin
    state_in <= next_state_in;
    counter_in <= next_counter_in;
  end
end


always @(*) begin
   case(counter_in)
      15: mem_req_data_32 = mem_req_data[31:0];
      14: mem_req_data_32 = mem_req_data[(32* 2)-1:32*1];
      13: mem_req_data_32 = mem_req_data[(32* 3)-1:32*2];
      12: mem_req_data_32 = mem_req_data[(32* 4)-1:32*3];
      11: mem_req_data_32 = mem_req_data[(32* 5)-1:32*4];
      10: mem_req_data_32 = mem_req_data[(32* 6)-1:32*5];
       9: mem_req_data_32 = mem_req_data[(32* 7)-1:32*6];
       8: mem_req_data_32 = mem_req_data[(32* 8)-1:32*7];
       7: mem_req_data_32 = mem_req_data[(32* 9)-1:32*8];
       6: mem_req_data_32 = mem_req_data[(32*10)-1:32*9];
       5: mem_req_data_32 = mem_req_data[(32*11)-1:32*10];
       4: mem_req_data_32 = mem_req_data[(32*12)-1:32*11];
       3: mem_req_data_32 = mem_req_data[(32*13)-1:32*12];
       2: mem_req_data_32 = mem_req_data[(32*14)-1:32*13];
       1: mem_req_data_32 = mem_req_data[(32*15)-1:32*14];
       0: mem_req_data_32 = mem_req_data[(32*16)-1:32*15];
   endcase
end


// MGET Header
// Request address //- Aligned and without offset
// Local address
// Whatever

always @(*) begin
   next_counter_in = counter_in;
   next_state_in = state_in;

   stream_out_TVALID_int = 1'b0;
   stream_out_TDATA_int = 'h0;
   stream_out_TKEEP_int = 4'h0;
   stream_out_TLAST_int = 1'b0;

   case(state_in)
      0: begin
         if (mem_req_valid)begin
            if (stream_out_TREADY_int) begin
               stream_out_TVALID_int = 1'b1;
               stream_out_TDATA_int = header;
               stream_out_TKEEP_int = 4'hF;
               stream_out_TLAST_int = 1'b0;
               next_state_in = 1;
               if (mem_req_rw) next_counter_in = 4'd15;
               else next_counter_in = 4'd0;
            end
         end
      end
      1: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TDATA_int = mem_req_addr_1; //- Aligned
            stream_out_TKEEP_int = 4'hF;
            stream_out_TLAST_int = 1'b0;
            next_state_in = 2;
         end
      end
      2: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            //stream_out_TDATA_int = {14'h0,HsrcId,mem_req_addr_2[OFFSET_SZ-1:0]}; //- Source
            stream_out_TDATA_int = mem_req_addr_2; //- Source
            stream_out_TKEEP_int = 4'hF;
            stream_out_TLAST_int = 1'b0;
            next_state_in = 3;
         end
      end
      3: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 4'hF;

            if (mem_req_rw) stream_out_TDATA_int = mem_req_data_32;
            else            stream_out_TDATA_int = 'h0;

            if (counter_in == 0) begin
               stream_out_TLAST_int = 1'b1;
               next_state_in = 0;
            end else begin
               stream_out_TLAST_int = 1'b0;
               next_counter_in = counter_in - 1;
            end
         end
      end
   endcase
end

assign pkt_code = mem_req_rw ? MPUT : MGET;
assign pkt_sz_code = mem_req_rw ? 4'b0100 : 4'b0001;
assign header = {3'b0,1'b1,pkt_code,1'b0,HsrcId,2'b00,4'b0100,pkt_sz_code,2'b0,Y_DRAM,X_DRAM};

/* Like a NoC decoder */

logic mem_wstrb_int;
logic mem_valid_int;

assign mem_valid_int = mem_valid;
assign mem_wstrb_int = mem_wstrb & mem_valid_int; 

always @(posedge clk_ctrl) begin
   if (~clk_ctrl_rst_low) begin
   end else if (mem_valid_int & mem_wstrb_int) begin
      mem_data_data_array[mem_addr[3:0]] <= mem_wdata; 
   end
end

always @(posedge clk_ctrl) begin
  if (~clk_ctrl_rst_low)begin
    state_out   <= 'h0;
    counter_out <= 'h0;
  end else begin
    state_out <= next_state_out;
    counter_out <= next_counter_out;
  end
end

assign mem_data_data[31:0] = mem_data_data_array[0];
assign mem_data_data[(32*2)-1:(32*1)] = mem_data_data_array[1];
assign mem_data_data[(32*3)-1:(32*2)] = mem_data_data_array[2];
assign mem_data_data[(32*4)-1:(32*3)] = mem_data_data_array[3];
assign mem_data_data[(32*5)-1:(32*4)] = mem_data_data_array[4];
assign mem_data_data[(32*6)-1:(32*5)] = mem_data_data_array[5];
assign mem_data_data[(32*7)-1:(32*6)] = mem_data_data_array[6];
assign mem_data_data[(32*8)-1:(32*7)] = mem_data_data_array[7];
assign mem_data_data[(32*9)-1:(32*8)] = mem_data_data_array[8];
assign mem_data_data[(32*10)-1:(32*9)] = mem_data_data_array[9];
assign mem_data_data[(32*11)-1:(32*10)] = mem_data_data_array[10];
assign mem_data_data[(32*12)-1:(32*11)] = mem_data_data_array[11];
assign mem_data_data[(32*13)-1:(32*12)] = mem_data_data_array[12];
assign mem_data_data[(32*14)-1:(32*13)] = mem_data_data_array[13];
assign mem_data_data[(32*15)-1:(32*14)] = mem_data_data_array[14];
assign mem_data_data[(32*16)-1:(32*15)] = mem_data_data_array[15];

always @(*) begin
   next_state_out = state_out;
   next_counter_out = 'h0;
   mem_data_ready = 0;
   
   case(state_out)
      0: begin
         if (mem_valid_int) begin
            next_state_out   = 1;
            next_counter_out = 'hE; 
         end
      end
      1: begin
         if (mem_valid_int) begin
            if (mem_wstrb_int) begin
               if (counter_out == 'h0) next_state_out = 2;
               else next_counter_out = counter_out - 1;
            end
         end
      end
      2: begin
         next_state_out = 0;
         mem_data_ready = 1;
      end
   endcase
end

noc_buffer_out noc_buffer_out(
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



endmodule

