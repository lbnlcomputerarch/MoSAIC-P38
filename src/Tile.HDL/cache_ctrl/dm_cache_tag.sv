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
// File        : dm_cache_tag.sv
// Notes       :
//    - From Computer Organization and Design.
//      Patterson and Hennessy
//      Section 5.9 Advanced Material: Implementing
//      Cache Controllers
//    - Angelos added parameters for parameterizing
//      tag and data memories 
////////////////////////////////////////////////////

module dm_cache_tag#(
  parameter CACHE_LINES      = 8, // number of Words of TAG_WIDTH bits
  parameter CACHE_LINE_WIDTH = $clog2(CACHE_LINES),  //bits to designate a cache line among others (i.e. log2(Cache_Lines)
  parameter TAG_WIDTH        = 32 - CACHE_LINE_WIDTH - $clog2(512/8)
)(
  input  logic                        clk,
  input  logic                        rst,
  input  logic [CACHE_LINE_WIDTH-1:0] tag_req_index,   //- 10-input logic index
  input  logic                        tag_req_we,      //- write enable
  input  logic                        tag_write_valid, //- Valid input logic
  input  logic                        tag_write_dirty, //- Dirty input logic
  //input  logic [31:16] tag_write_tag,   //- tag input logics
  input  logic        [TAG_WIDTH-1:0] tag_write_tag,   //- tag input logics
  output logic                        tag_read_valid,  //- Valid input logic
  output logic                        tag_read_dirty,  //- Dirty input logic
  //output logic [31:16] tag_read_tag     //- tag input logics
  output logic        [TAG_WIDTH-1:0] tag_read_tag     //- tag input logics
);

logic [CACHE_LINES-1:0] tag_mem_valid;
logic [CACHE_LINES-1:0] tag_mem_dirty; 

xpm_memory_spram #(
   //.ADDR_WIDTH_A(10),                     // DECIMAL
   .ADDR_WIDTH_A        (CACHE_LINE_WIDTH), // DECIMAL
   .AUTO_SLEEP_TIME     (0),                // DECIMAL
   //.BYTE_WRITE_WIDTH_A(16),               // DECIMAL
   .CASCADE_HEIGHT      (0),                // DECIMAL
   .ECC_MODE            ("no_ecc"),         // String
   .MEMORY_INIT_FILE    ("none"),           // String
   .MEMORY_INIT_PARAM   ("0"),              // String
   .MEMORY_OPTIMIZATION ("true"),           // String
   .MEMORY_PRIMITIVE    ("auto"),           // String
   //.MEMORY_SIZE(16384),                   // DECIMAL
   .MEMORY_SIZE         (CACHE_LINES*TAG_WIDTH),// DECIMAL
   .MESSAGE_CONTROL     (0),                // DECIMAL
   .READ_DATA_WIDTH_A   (TAG_WIDTH),        // DECIMAL
   .READ_LATENCY_A      (1),                // DECIMAL
   .READ_RESET_VALUE_A  ("0"),              // String
   .RST_MODE_A          ("SYNC"),           // String
   .SIM_ASSERT_CHK      (0),                // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
   .USE_MEM_INIT        (1),                // DECIMAL
   .WAKEUP_TIME         ("disable_sleep"),  // String
   .WRITE_DATA_WIDTH_A  (TAG_WIDTH),        // DECIMAL
   .WRITE_MODE_A        ("read_first")      // String
)
dm_cache_tag_mem (
   .dbiterra (),              // 1-bit output: Status signal to indicate double bit error occurrence
                              // on the data output of port A.
   .douta    (tag_read_tag),  // READ_DATA_WIDTH_A-bit output: Data output for port A read operations.
   .sbiterra (),              // 1-bit output: Status signal to indicate single bit error occurrence
                              // on the data output of port A.
   .addra    (tag_req_index), // ADDR_WIDTH_A-bit input: Address for port A write and read operations.
   .clka     (clk),           // 1-bit input: Clock signal for port A.
   .dina     (tag_write_tag), // WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
   .ena      (1'b1),          // 1-bit input: Memory enable signal for port A. Must be high on clock
                             // cycles when read or write operations are initiated. Pipelined
                             // internally.
   .injectdbiterra(1'b0),    // 1-bit input: Controls double bit error injection on input data when
                             // ECC enabled (Error injection capability is not available in
                             // "decode_only" mode).
   .injectsbiterra(1'b0),    // 1-bit input: Controls single bit error injection on input data when
                             // ECC enabled (Error injection capability is not available in
                             // "decode_only" mode).
   .regcea(1'b1),            // 1-bit input: Clock Enable for the last register stage on the output
                             // data path.
   .rsta(rst),               // 1-bit input: Reset signal for the final port A output register stage.
                             // Synchronously resets output port douta to the value specified by
                             // parameter READ_RESET_VALUE_A.
   .sleep(1'b0),                // 1-bit input: sleep signal to enable the dynamic power saving feature.
   .wea(tag_req_we));        // WRITE_DATA_WIDTH_A/BYTE_WRITE_WIDTH_A-bit input: Write enable vector
                             // for port A input data port dina. 1 bit wide when word-wide writes are
                             // used. In byte-wide write configurations, each bit controls the
                             // writing one byte of dina to address addra. For example, to
                             // synchronously write only bits [15-8] of dina when WRITE_DATA_WIDTH_A
                             // is 32, wea would be 4'b0010.


always @(posedge clk or posedge rst) begin
  if (rst) begin
      tag_mem_valid <= 'h0;
      tag_mem_dirty <= 'h0;
  end else if (tag_req_we) begin
      tag_mem_valid[tag_req_index] <= tag_write_valid; 
      tag_mem_dirty[tag_req_index] <= tag_write_dirty; 
  end
end

always @(posedge clk or posedge rst) begin
  if (rst) begin
     tag_read_valid <= 'b0;   
     tag_read_dirty <= 'b0;
  end else begin
     tag_read_valid <= tag_mem_valid[tag_req_index];   
     tag_read_dirty <= tag_mem_dirty[tag_req_index];  
  end
end 


/* Only valid for simulation
logic [31:16] tag_mem_tag [0:CACHE_LINES-1];

initial begin
  for (int i=0; i<CACHE_LINES; i++) begin
    tag_mem_valid[i] = 1'b0;
    tag_mem_dirty[i] = 1'b0;
    tag_mem_tag[i]   = 'h0;
  end
end
 
assign tag_read_valid = tag_mem_valid[tag_req_index];
assign tag_read_dirty = tag_mem_dirty[tag_req_index];
assign tag_read_tag   = tag_mem_tag[tag_req_index];
*/

endmodule

