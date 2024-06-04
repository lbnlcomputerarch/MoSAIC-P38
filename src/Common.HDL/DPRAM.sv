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

/////////////////////////////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : April 25 2022
// Description : Scratchpad memory model
// File        : DPRAM.sv
// Notes       : 
//  - From USS by Farzad F. (LBL), and Chris N. (AMD). 
//  - This memory model is valid for simulation only. 
//  - For FPGA synthesis, this should be replaced by a macro. 
//    For example with AMDXilinx, this will be replaced by: 
//    https://docs.amd.com/r/en-US/ug974-vivado-ultrascale-libraries/XPM_MEMORY_SDPRAM
//  - For ASIC synthesis replace this with an SRAM Macro.
//    and set the `ASIC_SYNTH define
//////////////////////////////////////////////////////////////////////////////////////////

module DPRAM #(
  parameter ADDR_W = 32,
  parameter DATA_W = 32,
  parameter MEMSIZE_KB = 128
) (
  input  wire  [1:0]          clk,
  input  wire  [1:0]          rst_n,
  input  wire  [1:0]          en,
  input  wire  [1:0]          we,
  input  wire  [2*ADDR_W-1:0] addr,
  input  wire  [2*DATA_W-1:0] din,
  output wire  [2*DATA_W-1:0] dout
);

localparam  unsigned MAX_ADDRESS =  MEMSIZE_KB*1024/4-1;
//localparam  unsigned ADDR_W =       $clog(MAX_ADDRESS);

wire               clka, clkb;
wire               wea, web;
wire [ADDR_W-1:0]  addra, addrb;
wire [DATA_W-1:0]  dina, dinb;
reg  [DATA_W-1:0]  douta, doutb;
reg  [DATA_W-1:0]  doutb_i1, doutb_i2;

`ifdef ASIC_SYNTH
   //- TBD: Add SRAM macro
`else

reg  [DATA_W-1:0]  mem [(MAX_ADDRESS)-1:0];

//- Only for simulation
integer            i;
initial for (i=0; i< (MAX_ADDRESS); i=i+1) mem[i] = 0;

assign clka   = clk[0];
assign ena    = en[0];
assign wea    = we[0];
assign dina   = din[DATA_W-1:0];
assign addra  = addr[ADDR_W-1:0];

assign clkb   = clk[1];
assign enb    = en[1];
assign web    = we[1];
assign dinb   = din[(2*DATA_W)-1:DATA_W];
assign addrb  = addr[(2*ADDR_W)-1:ADDR_W];

assign dout   = {douta, doutb};


always @(posedge clka) begin
  if (wea) begin
    douta       <= dina;
    mem[addra]  <= dina;
  end else
    douta       <= mem[addra];
end

always @(posedge clkb) begin
  if(web) begin
    doutb       <= dinb;
    mem[addrb]  <= dinb;
  end else
    doutb       <= mem[addrb];
end

`endif


endmodule // DPRAM
