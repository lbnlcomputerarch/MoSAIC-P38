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
// Date        : April 2022
// Description : Simple memory model for icarus
// File        : xpm_memory_spram.sv
// Notes       : 
//  - Only valid for simulation.
//  - Unused ports added for compatibility with the
//    Xilinx macro
//  - For this simple model 
//    READ_DATA_WIDTH_A = WRITE_DATA_WIDTH_A
////////////////////////////////////////////////////

module xpm_memory_spram #(
   parameter ADDR_WIDTH_A        = 10, // DECIMAL
   parameter AUTO_SLEEP_TIME     = 0,                // DECIMAL
   parameter CASCADE_HEIGHT      = 0,                // DECIMAL
   parameter ECC_MODE            = "no_ecc",         // String
   parameter MEMORY_INIT_FILE    = "none",           // String
   parameter MEMORY_INIT_PARAM   = "0",              // String
   parameter MEMORY_OPTIMIZATION = "true",           // String
   parameter MEMORY_PRIMITIVE    = "auto",           // String
   parameter MEMORY_SIZE         = 4096,             // DECIMAL
   parameter MESSAGE_CONTROL     = 0,                // DECIMAL
   parameter READ_DATA_WIDTH_A   = 512,              // DECIMAL
   parameter READ_LATENCY_A      = 1,                // DECIMAL
   parameter READ_RESET_VALUE_A  = "0",              // String
   parameter RST_MODE_A          = "SYNC",           // String
   parameter SIM_ASSERT_CHK      = 0,                // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
   parameter USE_MEM_INIT        = 1,                // DECIMAL
   parameter WAKEUP_TIME         = "disable_sleep",  // String
   parameter WRITE_DATA_WIDTH_A  = 512,              // DECIMAL
   parameter WRITE_MODE_A        = "read_first" 
)(
   output logic                          dbiterra,   // 1-bit output: Unused
   output logic  [READ_DATA_WIDTH_A-1:0] douta,      // READ_DATA_WIDTH_A-bit output: Data output for port A read operations. 
   output logic                          sbiterra,   // 1-bit output: Unused
   input  logic       [ADDR_WIDTH_A-1:0] addra,      // ADDR_WIDTH_A-bit input: Address for port A write and read operations. 
   input  logic                          clka,       // 1-bit input: Clock signal for port A. 
   input  logic [WRITE_DATA_WIDTH_A-1:0] dina,       // WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
   input  logic                          ena,        // 1-bit input: Memory enable signal for port A.  Must be high on clock
                                                     // cycles when read or write operations are initiate. Pipelined
                                                     // internally.
   input logic                           injectdbiterra, // 1-bit input: Unused
   input logic                           injectsbiterra, // 1-bit input: Unused
   input logic                           regcea,         // 1-bit input: Unused 
   input logic                           rsta,           // 1-bit input: Reset signal for the final port A output register stage.
                                                         // Synchronously resets output port douta to the value specified by
                                                         // parameter READ_RESET_VALUE_A.
   input logic                           sleep,          // 1-bit input: sleep signal to enable the dynamic power saving feature. 
   input logic                           wea             // WRITE_DATA_WIDTH_A/BYTE_WRITE_WIDTH_A-bit input: Write enable vector
                                                         // for port A input data port dina. 1 bit wide when word-wide writes are
                                                         // used. 
);

localparam CACHE_LINES = MEMORY_SIZE/READ_DATA_WIDTH_A;

logic [READ_DATA_WIDTH_A-1:0] mem [0:CACHE_LINES-1];

always @(posedge clka) begin 
  if (rsta)     douta <= READ_RESET_VALUE_A;
  else if (ena) douta <= mem[addra];
end

always @(posedge clka)
  if (wea & ena) mem[addra] <= dina;


endmodule
