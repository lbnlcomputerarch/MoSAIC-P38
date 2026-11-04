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
// works and perform publicly and display publicly.
//
// *************************************************************************

/////////////////////////////////////////////////////////////////////////////////////////
// Author      : Farzad Fatollahi-Fard
// Date        : November 3 2026
// Description : Dual-port RAM with byte-enable writes
// File        : DPRAM_BE.sv
// Notes       :
//  - Byte-enable variant of DPRAM.sv (Phase 3 of the 64-bit upgrade, plan D16).
//    Used only by acc_picorv64 (RV64 sub-word stores need per-byte writes).
//  - This memory model is valid for simulation only.
//  - For FPGA synthesis, this should be replaced by a macro with byte enables,
//    for example with AMDXilinx:
//    https://docs.amd.com/r/en-US/ug974-vivado-ultrascale-libraries/XPM_MEMORY_SDPRAM
//    (xpm_memory_sdpram supports per-byte write masks via its we ports).
//  - For ASIC synthesis replace this with an SRAM Macro and set `ASIC_SYNTH.
//  - Unlike DPRAM.sv, MEMSIZE_KB sizes the memory in KB of DATA (entries =
//    MEMSIZE_KB*1024/(DATA_W/8)), not in 32-bit words.
//  - Port-vector convention matches DPRAM.sv: {portB, portA} on clk/rst_n/en/
//    wstrb/addr/din; dout = {douta, doutb}.
//  - Difference from DPRAM.sv (review F4): reads are en-gated. dout holds
//    its value while en is low; DPRAM.sv reads every cycle. Consumers that
//    assume DPRAM's always-read semantics must hold en high.
/////////////////////////////////////////////////////////////////////////////////////////

module DPRAM_BE #(
   parameter ADDR_W = 32,
   parameter DATA_W = 64,
   parameter MEMSIZE_KB = 16
) (
   input  wire  [1:0]            clk,
   input  wire  [1:0]            rst_n,
   input  wire  [1:0]            en,
   input  wire  [2*(DATA_W/8)-1:0] wstrb,
   input  wire  [2*ADDR_W-1:0]   addr,
   input  wire  [2*DATA_W-1:0]   din,
   output wire  [2*DATA_W-1:0]   dout
);

localparam unsigned BWB         = DATA_W/8;
localparam unsigned MAX_ADDRESS = MEMSIZE_KB*1024/BWB-1;

wire               clka, clkb;
wire [BWB-1:0]     wstrb_a, wstrb_b;
wire [ADDR_W-1:0]  addra, addrb;
wire [DATA_W-1:0]  dina, dinb;
reg  [DATA_W-1:0]  douta, doutb;
wire               ena, enb;

`ifdef ASIC_SYNTH
   //- TBD: Add SRAM macro with byte enables
`else

reg  [DATA_W-1:0]  mem [MAX_ADDRESS:0];   //- MEMSIZE_KB*1024/BWB entries (F1: was [(MAX_ADDRESS)-1:0], one short)

//- Only for simulation
integer            i;
initial for (i=0; i<=MAX_ADDRESS; i=i+1) mem[i] = 0;

assign clka   = clk[0];
assign ena    = en[0];
assign wstrb_a = wstrb[BWB-1:0];
assign dina   = din[DATA_W-1:0];
assign addra  = addr[ADDR_W-1:0];

assign clkb   = clk[1];
assign enb    = en[1];
assign wstrb_b = wstrb[(2*BWB)-1:BWB];
assign dinb   = din[(2*DATA_W)-1:DATA_W];
assign addrb  = addr[(2*ADDR_W)-1:ADDR_W];

assign dout   = {douta, doutb};

always @(posedge clka) begin
  if (ena) begin
    if (|wstrb_a) begin
      douta <= dina;
      for (integer b = 0; b < BWB; b = b + 1) begin
        if (wstrb_a[b]) mem[addra][8*b +: 8] <= dina[8*b +: 8];
      end
    end else begin
      douta <= mem[addra];
    end
  end
end

always @(posedge clkb) begin
  if (enb) begin
    if (|wstrb_b) begin
      doutb <= dinb;
      for (integer b = 0; b < BWB; b = b + 1) begin
        if (wstrb_b[b]) mem[addrb][8*b +: 8] <= dinb[8*b +: 8];
      end
    end else begin
      doutb <= mem[addrb];
    end
  end
end

`endif

endmodule // DPRAM_BE
