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

///////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : November 2022
// Description : Cache
// File        : dm_cache_fsm.sv
// Notes       :
//    - From Computer Organization and Design.
//      Patterson and Hennessy
//      Section 5.9 Advanced Material: Implementing
//      Cache Controllers
//    - Angelos added parameters for parameterizing
//      tag and data memories 
////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

module dm_cache_fsm#(
  parameter  CPU_BUS_SZ   = 32,
  parameter  MEM_BUS_SZ   = 512,
  parameter  CACHE_LINES  = 8,  // number of cache lines
  parameter  S_AXI_ID_SZ  = 11,  // ID
  parameter  S_AXI_LEN_SZ = 8    // ID
)(
   input clk,
   input rst,
   //- CPU request (CPU -> Cache)
   input  logic  [CPU_BUS_SZ-1:0]  cpu_req_addr,  // 32-bit request addr
   input  logic  [CPU_BUS_SZ-1:0]  cpu_req_data,  // 32-bit request data (used when write)
   input  logic                    cpu_req_rw,    // request type : 0 = read, 1 = write 
   input  logic                    cpu_req_valid, // request is valid
   output logic                    cpu_req_ready,
   input  logic  [S_AXI_ID_SZ-1:0] cpu_req_id,
   input  logic [S_AXI_LEN_SZ-1:0] cpu_req_len,
   //- Memory response (Memory -> Cache)
   input  logic   [MEM_BUS_SZ-1:0] mem_data_data,
   input  logic                    mem_data_ready,
   //- Memory request (Cache->Memory)
   output logic   [CPU_BUS_SZ-1:0] mem_req_addr,  //request byte addr
   output logic   [MEM_BUS_SZ-1:0] mem_req_data,  //128-output logic request data (used when write)
   output logic                    mem_req_rw,    // request type : 0=read, 1=write
   output logic                    mem_req_valid, // request is valid
   output logic  [S_AXI_ID_SZ-1:0] mem_req_id,
   output logic [S_AXI_LEN_SZ-1:0] mem_req_len,
   //- Cache result (Cache->CPU)
   output logic   [CPU_BUS_SZ-1:0] cpu_res_data,  //32-bit data
   output logic                    cpu_res_valid, //result is ready
   input  logic                    cpu_res_ready
);

//- Local parameters
localparam [2:0] IDLE     = 3'b00; //0
localparam [2:0] COMP_TAG = 3'b01; //1
localparam [2:0] ALLOCATE = 3'b10; //2
localparam [2:0] WB       = 3'b11; //3
localparam [2:0] COMP_TAG_DEL = 3'b100; //4

localparam CACHE_LINE_IN_BYTES        = MEM_BUS_SZ / 8;
localparam CACHE_LINE_BYTE_ADDR_WIDTH = $clog2(CACHE_LINE_IN_BYTES); // how many bytes to address a byte within a cache line
localparam CACHE_LINE_WIDTH           = $clog2(CACHE_LINES);         // how many bits to address (name) a cache line
localparam CACHE_ADDR_WIDTH           = CACHE_LINE_WIDTH + CACHE_LINE_BYTE_ADDR_WIDTH; // how many bits to address 
                                                                                       // any byte inside the cache
localparam TAG_WIDTH                  = 32 - CACHE_ADDR_WIDTH;        // how many bits should comprise the TAG


//- Internal signals
logic [2:0] vstate, next_vstate;

/*interface signals to tag memory*/ 
//- tag read result
logic                 tag_read_valid; //- Valid bit
logic                 tag_read_dirty; //- Dirty bit
logic [TAG_WIDTH-1:0] tag_read_tag;   //- tag bits
//- tag write data
logic                 tag_write_valid; //- Valid bit
logic                 tag_write_dirty; //- Dirty bit
logic [TAG_WIDTH-1:0] tag_write_tag;   //- tag bits
//tag request
logic   [CACHE_LINE_WIDTH-1:0] tag_req_index; // For CACHE_LINES 1024, [9:0] for a 10-bit index 
logic                          tag_req_we;    //write enable 

/*interface signals to cache data memory*/
logic [MEM_BUS_SZ-1:0] data_read; 
logic [MEM_BUS_SZ-1:0] data_write;
//data request
logic [CACHE_LINE_WIDTH-1:0] data_req_index; // For CACHE_LINES 1024, [9:0] for a 10-bit index
logic                        data_req_we;    //write enable

//- CPU request (CPU -> Cache)
logic [CPU_BUS_SZ-1:0] cpu_req_addr_reg;  // 32-bit request addr
logic [CPU_BUS_SZ-1:0] cpu_req_data_reg;  // 32-bit request data (used when write)
logic                  cpu_req_rw_reg;    // request type : 0 = read, 1 = write 


/////////////////////////
//ai: debug tmp signals
logic [TAG_WIDTH-1:0] cpu_req_addr_reg_MS_tmp;
assign cpu_req_addr_reg_MS_tmp = cpu_req_addr_reg[31:CACHE_ADDR_WIDTH];

logic cache_hit;
assign cache_hit = (cpu_req_addr_reg[31:CACHE_ADDR_WIDTH] == tag_read_tag && tag_read_valid) & (vstate == COMP_TAG_DEL);
logic cache_miss;
assign cache_miss = !(cpu_req_addr_reg[31:CACHE_ADDR_WIDTH] == tag_read_tag && tag_read_valid) & (vstate == COMP_TAG_DEL);
/////////////////////////

always @(posedge clk or posedge rst) begin
  if (rst) begin
    cpu_req_addr_reg <=  'h0;
    cpu_req_data_reg <=  'h0;
    cpu_req_rw_reg   <= 1'b0;
  end else if (cpu_req_valid) begin
    cpu_req_addr_reg <= cpu_req_addr;
    cpu_req_data_reg <= cpu_req_data;
    cpu_req_rw_reg   <= cpu_req_rw;
  end
end


dm_cache_tag#(
  .CACHE_LINES (CACHE_LINES)
) ctag (
  .clk             (clk),
  .rst             (rst),
  .tag_req_index   (tag_req_index),
  .tag_req_we      (tag_req_we),
  .tag_write_valid (tag_write_valid),
  .tag_write_dirty (tag_write_dirty),
  .tag_write_tag   (tag_write_tag),
  .tag_read_valid  (tag_read_valid),
  .tag_read_dirty  (tag_read_dirty),
  .tag_read_tag    (tag_read_tag)
);


dm_cache_data#(
  .CACHE_LINES (CACHE_LINES)
) cdata (
  .clk            (clk),
  .rst             (rst),
  .data_req_index (data_req_index),
  .data_req_we    (data_req_we),
  .data_write     (data_write),
  .data_read      (data_read)
);

//- Direct map index for tag & cache data
assign tag_req_index  = cpu_req_addr_reg[CACHE_ADDR_WIDTH-1:CACHE_LINE_BYTE_ADDR_WIDTH]; 
assign data_req_index = cpu_req_addr_reg[CACHE_ADDR_WIDTH-1:CACHE_LINE_BYTE_ADDR_WIDTH];

/*read out correct word(32-bit) from cache (to CPU)
* Chris changed it to this format for better FPGA mapping*/
always @(*) begin
   case (cpu_req_addr_reg[5:2])  // could use CACHE_LINE_BYTE_ADDR_WIDTH, but need to change the case statements as well
     4'b00 : cpu_res_data <= data_read[31:0];
     4'b01 : cpu_res_data <= data_read[63:32];
     4'd02 : cpu_res_data <= data_read[95:64];
     4'd03 : cpu_res_data <= data_read[127:96];
     4'd04 : cpu_res_data <= data_read[159:128];
     4'd05 : cpu_res_data <= data_read[191:160];
     4'd06 : cpu_res_data <= data_read[223:192];
     4'd07 : cpu_res_data <= data_read[255:224];
     4'd08 : cpu_res_data <= data_read[287:256];
     4'd09 : cpu_res_data <= data_read[319:288];
     4'd10 : cpu_res_data <= data_read[351:320];
     4'd11 : cpu_res_data <= data_read[383:352];
     4'd12 : cpu_res_data <= data_read[415:384];
     4'd13 : cpu_res_data <= data_read[447:416];
     4'd14 : cpu_res_data <= data_read[479:448];
     default : cpu_res_data <= data_read[511:480];
   endcase // case (cpu_req_addr_reg[5:2])
end

always @(posedge clk or posedge rst) begin
  if (rst) vstate <= IDLE;
  else vstate <= next_vstate;
end

logic [S_AXI_ID_SZ-1:0] cpu_req_id_reg;
logic [S_AXI_LEN_SZ-1:0] cpu_req_len_reg;

always @(posedge clk or posedge rst) begin
  if (rst) cpu_req_id_reg <= 'h0;
  else if (cpu_req_valid) cpu_req_id_reg <= cpu_req_id;
  else if (next_vstate == WB && vstate == COMP_TAG) cpu_req_id_reg <= cpu_req_id_reg + 'h1;
end

assign mem_req_id = cpu_req_id_reg;

always @(posedge clk or posedge rst) begin
  if (rst) cpu_req_len_reg <= 'h0;
  else if (cpu_req_valid) cpu_req_len_reg <= cpu_req_len;
end

assign mem_req_len = cpu_req_len_reg;

/*modify correct word (32-bit) based on address
* Chris Neely changed it to this format for 
* better FPGA mapping */
always @(*) begin
   if (vstate == ALLOCATE) begin 
        data_write = mem_data_data;
   end else begin 
      data_write[31:0]    = cpu_req_addr_reg[5:2] == 4'd0  ? cpu_req_data_reg : data_read[31:0];
      data_write[63:32]   = cpu_req_addr_reg[5:2] == 4'd1  ? cpu_req_data_reg : data_read[63:32];
      data_write[95:64]   = cpu_req_addr_reg[5:2] == 4'd2  ? cpu_req_data_reg : data_read[95:64];
      data_write[127:96]  = cpu_req_addr_reg[5:2] == 4'd3  ? cpu_req_data_reg : data_read[127:96];
      data_write[159:128] = cpu_req_addr_reg[5:2] == 4'd4  ? cpu_req_data_reg : data_read[159:128];
      data_write[191:160] = cpu_req_addr_reg[5:2] == 4'd5  ? cpu_req_data_reg : data_read[191:160];
      data_write[223:192] = cpu_req_addr_reg[5:2] == 4'd6  ? cpu_req_data_reg : data_read[223:192];
      data_write[255:224] = cpu_req_addr_reg[5:2] == 4'd7  ? cpu_req_data_reg : data_read[255:224];
      data_write[287:256] = cpu_req_addr_reg[5:2] == 4'd8  ? cpu_req_data_reg : data_read[287:256];
      data_write[319:288] = cpu_req_addr_reg[5:2] == 4'd9  ? cpu_req_data_reg : data_read[319:288];
      data_write[351:320] = cpu_req_addr_reg[5:2] == 4'd10 ? cpu_req_data_reg : data_read[351:320];
      data_write[383:352] = cpu_req_addr_reg[5:2] == 4'd11 ? cpu_req_data_reg : data_read[383:352];
      data_write[415:384] = cpu_req_addr_reg[5:2] == 4'd12 ? cpu_req_data_reg : data_read[415:384];
      data_write[447:416] = cpu_req_addr_reg[5:2] == 4'd13 ? cpu_req_data_reg : data_read[447:416];
      data_write[479:448] = cpu_req_addr_reg[5:2] == 4'd14 ? cpu_req_data_reg : data_read[479:448];
      data_write[511:480] = cpu_req_addr_reg[5:2] == 4'd15 ? cpu_req_data_reg : data_read[511:480];
   end 
end // always @ (*)



always @(*) begin
  //- state 
  next_vstate = vstate;
  cpu_res_valid = 1'b0;

  mem_req_rw = 1'b0;
  /*memory request address (sampled from CPU request)*/ 
  mem_req_addr = cpu_req_addr_reg;
  /*memory request data (used in write)*/ 
  mem_req_data = data_read;
  mem_req_valid = 1'b0;

  data_req_we = 1'b0;

  tag_req_we = 1'b0;
  tag_write_valid = 1'b0;
  tag_write_dirty = 1'b0;
  tag_write_tag   = 1'b0;
  case (vstate)
    IDLE: begin
      if (cpu_req_valid) begin
        next_vstate = COMP_TAG;
      end
    end
    COMP_TAG: begin //1
      next_vstate = COMP_TAG_DEL;
    end
    COMP_TAG_DEL : begin //- Added to fit the one clock delay of the rams
     /*cache hit (tag match and cache entry is valid)*/
      if (cpu_req_addr_reg[31:CACHE_ADDR_WIDTH] == tag_read_tag && tag_read_valid) begin
        if (cpu_res_ready) begin   
          cpu_res_valid = 1;
          /*write hit*/
          if (cpu_req_rw_reg)begin
            tag_req_we  = 1;
            data_req_we = 1;
            /*no change in tag*/ 
            tag_write_tag   = tag_read_tag; 
            tag_write_valid = 1; 
            /*cache line is dirty*/ 
            tag_write_dirty = 1;
          end
          next_vstate = IDLE;
        end else begin
             cpu_res_valid = 1;
             next_vstate = IDLE;
        end 
      end else begin /*cache miss*/ 
        /*generate new tag*/
        tag_req_we      = 1'b1;
        tag_write_valid = 1'b1;
        /*new tag*/
        tag_write_tag = cpu_req_addr_reg[31:CACHE_ADDR_WIDTH]; 
        /*cache line is dirty if write*/ 
        tag_write_dirty = cpu_req_rw_reg;
        /*generate memory request on miss*/
        mem_req_valid = 1'b1;
        /*compulsory miss or miss with clean block*/
        if (tag_read_valid == 1'b0 || tag_read_dirty == 1'b0) begin
          /*wait till a new block is allocated*/ 
          next_vstate = ALLOCATE;
        end else begin /*miss with dirty line*/
          /*write back address*/
          /* For 1024 use mem_req_addr = {tag_read_tag, cpu_req_addr_reg[15:6],6'h0}; */
          mem_req_addr = {tag_read_tag, cpu_req_addr_reg[CACHE_ADDR_WIDTH-1:CACHE_LINE_BYTE_ADDR_WIDTH], {CACHE_LINE_BYTE_ADDR_WIDTH{1'b0}}};
          mem_req_rw = 1;
          /*wait till write is completed*/
          next_vstate = WB;
       end 
     end
    end
    ALLOCATE: begin //2
      /*memory controller has responded*/ 
      if (mem_data_ready) begin
        /*re-compare tag for write miss (need modify correct word)*/ 
        next_vstate = COMP_TAG;
        /*update cache line data*/
        data_req_we = 1;
      end 
    end
    WB : begin
      /*wait for writing back dirty cache line*/ 
      /*write back is completed*/ 
      if (mem_data_ready) begin
        /*issue new memory request (allocating a new line)*/ 
        mem_req_valid = 1;
        mem_req_rw    = 0;
        next_vstate   = ALLOCATE; 
      end
    end
  endcase
end

assign cpu_req_ready = vstate == IDLE;

endmodule
