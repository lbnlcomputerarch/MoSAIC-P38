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
// File        : dm_cache_data.sv
// Notes       :
//    - From Computer Organization and Design.
//      Patterson and Hennessy
//      Section 5.9 Advanced Material: Implementing
//      Cache Controllers
//    - Angelos added parameters for parameterizing
//      tag and data memories 
////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

module dm_cache_data#(
  parameter CACHE_LINES      = 8,                   //- 8 Words of 512 bits
  parameter CACHE_LINE_WIDTH = $clog2(CACHE_LINES)  //bits to designate a cache 
                                                    // line among others (i.e. log2(Cache_Lines)
)(
  input  logic	                       clk,
  input  logic                        rst,
  input  logic [CACHE_LINE_WIDTH-1:0] data_req_index, //10-input logic index
  input  logic	                       data_req_we,    //write enable
  input  logic                [511:0] data_write, 
  output logic                [511:0] data_read 
);

xpm_memory_spram #(
   //.ADDR_WIDTH_A(10),             // DECIMAL
   .ADDR_WIDTH_A(CACHE_LINE_WIDTH), // DECIMAL
   .AUTO_SLEEP_TIME(0),             // DECIMAL
   //.BYTE_WRITE_WIDTH_A(512),      // DECIMAL
   .CASCADE_HEIGHT(0),              // DECIMAL
   .ECC_MODE("no_ecc"),             // String
   .MEMORY_INIT_FILE("none"),       // String
   .MEMORY_INIT_PARAM("0"),         // String
   .MEMORY_OPTIMIZATION("true"),    // String
   .MEMORY_PRIMITIVE("auto"),       // String
   //.MEMORY_SIZE(524288),          // DECIMAL
   .MEMORY_SIZE(CACHE_LINES * 512), // DECIMAL
   .MESSAGE_CONTROL(0),             // DECIMAL
   .READ_DATA_WIDTH_A(512),         // DECIMAL
   .READ_LATENCY_A(1),              // DECIMAL
   .READ_RESET_VALUE_A("0"),        // String
   .RST_MODE_A("SYNC"),             // String
   .SIM_ASSERT_CHK(0),              // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
   .USE_MEM_INIT(1),                // DECIMAL
   .WAKEUP_TIME("disable_sleep"),   // String
   .WRITE_DATA_WIDTH_A(512),        // DECIMAL
   .WRITE_MODE_A("read_first")      // String
)
dm_cache_data_mem (
    .dbiterra(),             // 1-bit output: Status signal to indicate double bit error occurrence
                             // on the data output of port A.
   .douta(data_read),        // READ_DATA_WIDTH_A-bit output: Data output for port A read operations.
   .sbiterra(),              // 1-bit output: Status signal to indicate single bit error occurrence
                             // on the data output of port A.
   .addra(data_req_index),   // ADDR_WIDTH_A-bit input: Address for port A write and read operations.
   .clka(clk),               // 1-bit input: Clock signal for port A.
   .dina(data_write),        // WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
   .ena(1'b1),               // 1-bit input: Memory enable signal for port A. Must be high on clock
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
   .sleep(1'b0),             // 1-bit input: sleep signal to enable the dynamic power saving feature.
   .wea(data_req_we));       // WRITE_DATA_WIDTH_A/BYTE_WRITE_WIDTH_A-bit input: Write enable vector
                             // for port A input data port dina. 1 bit wide when word-wide writes are
                             // used. In byte-wide write configurations, each bit controls the
                             // writing one byte of dina to address addra. For example, to
                             // synchronously write only bits [15-8] of dina when WRITE_DATA_WIDTH_A
                             // is 32, wea would be 4'b0010.


/*
logic [511:0] data_mem [0:CACHE_LINES-1];
assign data_read = data_mem[data_req_index];

always @(posedge(clk)) begin 
   if (rst) begin 
      for (int i=0; i<CACHE_LINES; i++)
	data_mem[i] = 'h0;
   end else if (data_req_we) begin 
      data_mem[data_req_index] <= data_write;
   end 
end
*/
   
endmodule

