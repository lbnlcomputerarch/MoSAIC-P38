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
// Author      : Mario Vega
// Date        : Jan 29 2024
// Description : Fast Fourier 
//               Transform (FFT) accelerator
// File        : Batched3DFFT8_RealOutv6.v
// Notes       : 
//    - Chisel generated
////////////////////////////////////////////////

module simple_RAM_depth4_bw32(
  input         clock,
  input  [1:0]  io_in_addr,
  input  [31:0] io_in_data,
  input         io_in_en,
  input         io_in_we,
  output [31:0] io_out_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] smem [0:3]; // @[PaddingDesigns.scala 56:27]
  wire  smem_io_out_data_MPORT_en; // @[PaddingDesigns.scala 56:27]
  wire [1:0] smem_io_out_data_MPORT_addr; // @[PaddingDesigns.scala 56:27]
  wire [31:0] smem_io_out_data_MPORT_data; // @[PaddingDesigns.scala 56:27]
  wire [31:0] smem_MPORT_data; // @[PaddingDesigns.scala 56:27]
  wire [1:0] smem_MPORT_addr; // @[PaddingDesigns.scala 56:27]
  wire  smem_MPORT_mask; // @[PaddingDesigns.scala 56:27]
  wire  smem_MPORT_en; // @[PaddingDesigns.scala 56:27]
  reg  smem_io_out_data_MPORT_en_pipe_0;
  reg [1:0] smem_io_out_data_MPORT_addr_pipe_0;
  wire  _io_out_data_T = ~io_in_we; // @[PaddingDesigns.scala 57:52]
  assign smem_io_out_data_MPORT_en = smem_io_out_data_MPORT_en_pipe_0;
  assign smem_io_out_data_MPORT_addr = smem_io_out_data_MPORT_addr_pipe_0;
  assign smem_io_out_data_MPORT_data = smem[smem_io_out_data_MPORT_addr]; // @[PaddingDesigns.scala 56:27]
  assign smem_MPORT_data = io_in_data;
  assign smem_MPORT_addr = io_in_addr;
  assign smem_MPORT_mask = 1'h1;
  assign smem_MPORT_en = io_in_we & io_in_en;
  assign io_out_data = smem_io_out_data_MPORT_data; // @[PaddingDesigns.scala 57:17]
  always @(posedge clock) begin
    if (smem_MPORT_en & smem_MPORT_mask) begin
      smem[smem_MPORT_addr] <= smem_MPORT_data; // @[PaddingDesigns.scala 56:27]
    end
    smem_io_out_data_MPORT_en_pipe_0 <= io_in_en & _io_out_data_T;
    if (io_in_en & _io_out_data_T) begin
      smem_io_out_data_MPORT_addr_pipe_0 <= io_in_addr;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    smem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  smem_io_out_data_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  smem_io_out_data_MPORT_addr_pipe_0 = _RAND_2[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SyncMEM(
  input         clock,
  input         io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input         io_in_mem_write,
  input         io_in_mem_read,
  input  [1:0]  io_in_mem_waddr,
  input  [1:0]  io_in_mem_raddr,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im
);
  wire  simple_RAM_depth4_bw32_clock; // @[PaddingDesigns.scala 69:37]
  wire [1:0] simple_RAM_depth4_bw32_io_in_addr; // @[PaddingDesigns.scala 69:37]
  wire [31:0] simple_RAM_depth4_bw32_io_in_data; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth4_bw32_io_in_en; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth4_bw32_io_in_we; // @[PaddingDesigns.scala 69:37]
  wire [31:0] simple_RAM_depth4_bw32_io_out_data; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth4_bw32_1_clock; // @[PaddingDesigns.scala 69:37]
  wire [1:0] simple_RAM_depth4_bw32_1_io_in_addr; // @[PaddingDesigns.scala 69:37]
  wire [31:0] simple_RAM_depth4_bw32_1_io_in_data; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth4_bw32_1_io_in_en; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth4_bw32_1_io_in_we; // @[PaddingDesigns.scala 69:37]
  wire [31:0] simple_RAM_depth4_bw32_1_io_out_data; // @[PaddingDesigns.scala 69:37]
  wire  _T = io_in_mem_write & io_in_valid; // @[PaddingDesigns.scala 85:28]
  wire [1:0] _GEN_3 = io_in_mem_read ? io_in_mem_raddr : 2'h0; // @[PaddingDesigns.scala 74:29 93:33 95:33]
  wire [31:0] _GEN_4 = io_in_mem_write & io_in_valid ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 85:43 86:26 73:29]
  wire [31:0] _GEN_5 = io_in_mem_write & io_in_valid ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 85:43 87:26 73:29]
  wire [1:0] _GEN_7 = io_in_mem_write & io_in_valid ? io_in_mem_waddr : _GEN_3; // @[PaddingDesigns.scala 85:43 89:33]
  simple_RAM_depth4_bw32 simple_RAM_depth4_bw32 ( // @[PaddingDesigns.scala 69:37]
    .clock(simple_RAM_depth4_bw32_clock),
    .io_in_addr(simple_RAM_depth4_bw32_io_in_addr),
    .io_in_data(simple_RAM_depth4_bw32_io_in_data),
    .io_in_en(simple_RAM_depth4_bw32_io_in_en),
    .io_in_we(simple_RAM_depth4_bw32_io_in_we),
    .io_out_data(simple_RAM_depth4_bw32_io_out_data)
  );
  simple_RAM_depth4_bw32 simple_RAM_depth4_bw32_1 ( // @[PaddingDesigns.scala 69:37]
    .clock(simple_RAM_depth4_bw32_1_clock),
    .io_in_addr(simple_RAM_depth4_bw32_1_io_in_addr),
    .io_in_data(simple_RAM_depth4_bw32_1_io_in_data),
    .io_in_en(simple_RAM_depth4_bw32_1_io_in_en),
    .io_in_we(simple_RAM_depth4_bw32_1_io_in_we),
    .io_out_data(simple_RAM_depth4_bw32_1_io_out_data)
  );
  assign io_out_data_0_Re = simple_RAM_depth4_bw32_io_out_data; // @[PaddingDesigns.scala 78:25]
  assign io_out_data_0_Im = simple_RAM_depth4_bw32_1_io_out_data; // @[PaddingDesigns.scala 79:25]
  assign simple_RAM_depth4_bw32_clock = clock;
  assign simple_RAM_depth4_bw32_io_in_addr = io_in_ready ? _GEN_7 : 2'h0; // @[PaddingDesigns.scala 84:22 74:29]
  assign simple_RAM_depth4_bw32_io_in_data = io_in_ready ? _GEN_4 : 32'h0; // @[PaddingDesigns.scala 84:22 73:29]
  assign simple_RAM_depth4_bw32_io_in_en = io_in_ready; // @[PaddingDesigns.scala 75:27]
  assign simple_RAM_depth4_bw32_io_in_we = io_in_ready & _T; // @[PaddingDesigns.scala 84:22 76:27]
  assign simple_RAM_depth4_bw32_1_clock = clock;
  assign simple_RAM_depth4_bw32_1_io_in_addr = io_in_ready ? _GEN_7 : 2'h0; // @[PaddingDesigns.scala 84:22 74:29]
  assign simple_RAM_depth4_bw32_1_io_in_data = io_in_ready ? _GEN_5 : 32'h0; // @[PaddingDesigns.scala 84:22 73:29]
  assign simple_RAM_depth4_bw32_1_io_in_en = io_in_ready; // @[PaddingDesigns.scala 75:27]
  assign simple_RAM_depth4_bw32_1_io_in_we = io_in_ready & _T; // @[PaddingDesigns.scala 84:22 76:27]
endmodule
module PencilGroup(
  input         clock,
  input         io_in_ready_0,
  input         io_in_ready_1,
  input         io_in_valid_0,
  input         io_in_valid_1,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input  [31:0] io_in_data_1_Re,
  input  [31:0] io_in_data_1_Im,
  input         io_in_mems_0_write,
  input         io_in_mems_0_read,
  input  [1:0]  io_in_mems_0_waddr,
  input  [1:0]  io_in_mems_0_raddr,
  input         io_in_mems_1_write,
  input         io_in_mems_1_read,
  input  [1:0]  io_in_mems_1_waddr,
  input  [1:0]  io_in_mems_1_raddr,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
  wire  pgroup_0_clock; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_0_io_in_ready; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_0_io_in_valid; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_0_io_in_data_0_Re; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_0_io_in_data_0_Im; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_0_io_in_mem_write; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_0_io_in_mem_read; // @[PaddingDesigns.scala 126:40]
  wire [1:0] pgroup_0_io_in_mem_waddr; // @[PaddingDesigns.scala 126:40]
  wire [1:0] pgroup_0_io_in_mem_raddr; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_0_io_out_data_0_Re; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_0_io_out_data_0_Im; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_clock; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_io_in_ready; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_io_in_valid; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_1_io_in_data_0_Re; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_1_io_in_data_0_Im; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_io_in_mem_write; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_io_in_mem_read; // @[PaddingDesigns.scala 126:40]
  wire [1:0] pgroup_1_io_in_mem_waddr; // @[PaddingDesigns.scala 126:40]
  wire [1:0] pgroup_1_io_in_mem_raddr; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 126:40]
  SyncMEM pgroup_0 ( // @[PaddingDesigns.scala 126:40]
    .clock(pgroup_0_clock),
    .io_in_ready(pgroup_0_io_in_ready),
    .io_in_valid(pgroup_0_io_in_valid),
    .io_in_data_0_Re(pgroup_0_io_in_data_0_Re),
    .io_in_data_0_Im(pgroup_0_io_in_data_0_Im),
    .io_in_mem_write(pgroup_0_io_in_mem_write),
    .io_in_mem_read(pgroup_0_io_in_mem_read),
    .io_in_mem_waddr(pgroup_0_io_in_mem_waddr),
    .io_in_mem_raddr(pgroup_0_io_in_mem_raddr),
    .io_out_data_0_Re(pgroup_0_io_out_data_0_Re),
    .io_out_data_0_Im(pgroup_0_io_out_data_0_Im)
  );
  SyncMEM pgroup_1 ( // @[PaddingDesigns.scala 126:40]
    .clock(pgroup_1_clock),
    .io_in_ready(pgroup_1_io_in_ready),
    .io_in_valid(pgroup_1_io_in_valid),
    .io_in_data_0_Re(pgroup_1_io_in_data_0_Re),
    .io_in_data_0_Im(pgroup_1_io_in_data_0_Im),
    .io_in_mem_write(pgroup_1_io_in_mem_write),
    .io_in_mem_read(pgroup_1_io_in_mem_read),
    .io_in_mem_waddr(pgroup_1_io_in_mem_waddr),
    .io_in_mem_raddr(pgroup_1_io_in_mem_raddr),
    .io_out_data_0_Re(pgroup_1_io_out_data_0_Re),
    .io_out_data_0_Im(pgroup_1_io_out_data_0_Im)
  );
  assign io_out_data_0_Re = pgroup_0_io_out_data_0_Re; // @[PaddingDesigns.scala 137:22]
  assign io_out_data_0_Im = pgroup_0_io_out_data_0_Im; // @[PaddingDesigns.scala 137:22]
  assign io_out_data_1_Re = pgroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 137:22]
  assign io_out_data_1_Im = pgroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 137:22]
  assign pgroup_0_clock = clock;
  assign pgroup_0_io_in_ready = io_in_ready_0; // @[PaddingDesigns.scala 131:29]
  assign pgroup_0_io_in_valid = io_in_valid_0; // @[PaddingDesigns.scala 129:29]
  assign pgroup_0_io_in_data_0_Re = io_in_data_0_Re; // @[PaddingDesigns.scala 132:33]
  assign pgroup_0_io_in_data_0_Im = io_in_data_0_Im; // @[PaddingDesigns.scala 132:33]
  assign pgroup_0_io_in_mem_write = io_in_mems_0_write; // @[PaddingDesigns.scala 134:33]
  assign pgroup_0_io_in_mem_read = io_in_mems_0_read; // @[PaddingDesigns.scala 133:32]
  assign pgroup_0_io_in_mem_waddr = io_in_mems_0_waddr; // @[PaddingDesigns.scala 136:33]
  assign pgroup_0_io_in_mem_raddr = io_in_mems_0_raddr; // @[PaddingDesigns.scala 135:33]
  assign pgroup_1_clock = clock;
  assign pgroup_1_io_in_ready = io_in_ready_1; // @[PaddingDesigns.scala 131:29]
  assign pgroup_1_io_in_valid = io_in_valid_1; // @[PaddingDesigns.scala 129:29]
  assign pgroup_1_io_in_data_0_Re = io_in_data_1_Re; // @[PaddingDesigns.scala 132:33]
  assign pgroup_1_io_in_data_0_Im = io_in_data_1_Im; // @[PaddingDesigns.scala 132:33]
  assign pgroup_1_io_in_mem_write = io_in_mems_1_write; // @[PaddingDesigns.scala 134:33]
  assign pgroup_1_io_in_mem_read = io_in_mems_1_read; // @[PaddingDesigns.scala 133:32]
  assign pgroup_1_io_in_mem_waddr = io_in_mems_1_waddr; // @[PaddingDesigns.scala 136:33]
  assign pgroup_1_io_in_mem_raddr = io_in_mems_1_raddr; // @[PaddingDesigns.scala 135:33]
endmodule
module SlabGroup(
  input         clock,
  input         io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input  [31:0] io_in_data_1_Re,
  input  [31:0] io_in_data_1_Im,
  input         io_in_write,
  input  [1:0]  io_in_pgroup_slct_0,
  input  [1:0]  io_in_pgroup_slct_1,
  input  [1:0]  io_in_RAM_slct_0,
  input  [1:0]  io_in_RAM_slct_1,
  input  [1:0]  io_in_addr_slct_0,
  input  [1:0]  io_in_addr_slct_1,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  PencilGroup_clock; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_ready_0; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_ready_1; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_valid_0; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_valid_1; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_in_data_0_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_in_data_0_Im; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_in_data_1_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_in_data_1_Im; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_mems_0_write; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_mems_0_read; // @[PaddingDesigns.scala 154:53]
  wire [1:0] PencilGroup_io_in_mems_0_waddr; // @[PaddingDesigns.scala 154:53]
  wire [1:0] PencilGroup_io_in_mems_0_raddr; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_mems_1_write; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_mems_1_read; // @[PaddingDesigns.scala 154:53]
  wire [1:0] PencilGroup_io_in_mems_1_waddr; // @[PaddingDesigns.scala 154:53]
  wire [1:0] PencilGroup_io_in_mems_1_raddr; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_clock; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_ready_0; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_ready_1; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_valid_0; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_valid_1; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_in_data_0_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_in_data_0_Im; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_in_data_1_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_in_data_1_Im; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_mems_0_write; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_mems_0_read; // @[PaddingDesigns.scala 154:53]
  wire [1:0] PencilGroup_1_io_in_mems_0_waddr; // @[PaddingDesigns.scala 154:53]
  wire [1:0] PencilGroup_1_io_in_mems_0_raddr; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_mems_1_write; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_mems_1_read; // @[PaddingDesigns.scala 154:53]
  wire [1:0] PencilGroup_1_io_in_mems_1_waddr; // @[PaddingDesigns.scala 154:53]
  wire [1:0] PencilGroup_1_io_in_mems_1_raddr; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 154:53]
  wire  _io_out_last_T = ~io_in_write; // @[PaddingDesigns.scala 166:79]
  wire  _io_out_last_T_1 = io_in_ready & ~io_in_write; // @[PaddingDesigns.scala 166:77]
  wire  _GEN_146 = ~io_in_pgroup_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_147 = ~io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_148 = ~io_in_pgroup_slct_0[0] & ~io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_12 = ~io_in_pgroup_slct_0[0] & ~io_in_RAM_slct_0[0] & io_in_write; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_150 = ~io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_13 = ~io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] & io_in_write; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_152 = io_in_pgroup_slct_0[0] & ~io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_14 = io_in_pgroup_slct_0[0] & ~io_in_RAM_slct_0[0] & io_in_write; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_153 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_15 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] & io_in_write; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_16 = _GEN_148 & _io_out_last_T; // @[PaddingDesigns.scala 161:35 172:{71,71}]
  wire  _GEN_17 = _GEN_150 & _io_out_last_T; // @[PaddingDesigns.scala 161:35 172:{71,71}]
  wire  _GEN_18 = _GEN_152 & _io_out_last_T; // @[PaddingDesigns.scala 161:35 172:{71,71}]
  wire  _GEN_19 = _GEN_153 & _io_out_last_T; // @[PaddingDesigns.scala 161:35 172:{71,71}]
  wire [1:0] _GEN_20 = _GEN_146 & _GEN_147 ? io_in_addr_slct_0 : 2'h0; // @[PaddingDesigns.scala 163:36 173:{72,72}]
  wire [1:0] _GEN_21 = _GEN_146 & io_in_RAM_slct_0[0] ? io_in_addr_slct_0 : 2'h0; // @[PaddingDesigns.scala 163:36 173:{72,72}]
  wire [1:0] _GEN_22 = io_in_pgroup_slct_0[0] & _GEN_147 ? io_in_addr_slct_0 : 2'h0; // @[PaddingDesigns.scala 163:36 173:{72,72}]
  wire [1:0] _GEN_23 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] ? io_in_addr_slct_0 : 2'h0; // @[PaddingDesigns.scala 163:36 173:{72,72}]
  wire  _GEN_28 = _GEN_148 & io_in_valid; // @[PaddingDesigns.scala 156:28 175:{67,67}]
  wire  _GEN_29 = _GEN_150 & io_in_valid; // @[PaddingDesigns.scala 156:28 175:{67,67}]
  wire  _GEN_30 = _GEN_152 & io_in_valid; // @[PaddingDesigns.scala 156:28 175:{67,67}]
  wire  _GEN_31 = _GEN_153 & io_in_valid; // @[PaddingDesigns.scala 156:28 175:{67,67}]
  wire  _GEN_32 = _GEN_148 & io_in_ready; // @[PaddingDesigns.scala 158:28 176:{67,67}]
  wire  _GEN_33 = _GEN_150 & io_in_ready; // @[PaddingDesigns.scala 158:28 176:{67,67}]
  wire  _GEN_34 = _GEN_152 & io_in_ready; // @[PaddingDesigns.scala 158:28 176:{67,67}]
  wire  _GEN_35 = _GEN_153 & io_in_ready; // @[PaddingDesigns.scala 158:28 176:{67,67}]
  wire [31:0] _GEN_40 = _GEN_146 & _GEN_147 ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_41 = _GEN_146 & io_in_RAM_slct_0[0] ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_42 = io_in_pgroup_slct_0[0] & _GEN_147 ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_43 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_44 = _GEN_146 & _GEN_147 ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_45 = _GEN_146 & io_in_RAM_slct_0[0] ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_46 = io_in_pgroup_slct_0[0] & _GEN_147 ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_47 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  reg [1:0] io_out_data_0_r; // @[Reg.scala 16:16]
  reg [1:0] io_out_data_0_r_1; // @[Reg.scala 16:16]
  wire [31:0] pgroups_0_out_data_0_Im = PencilGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] pgroups_0_out_data_1_Im = PencilGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_51 = ~io_out_data_0_r[0] & io_out_data_0_r_1[0] ? pgroups_0_out_data_1_Im : pgroups_0_out_data_0_Im; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_1_out_data_0_Im = PencilGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_52 = io_out_data_0_r[0] & ~io_out_data_0_r_1[0] ? pgroups_1_out_data_0_Im : _GEN_51; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_1_out_data_1_Im = PencilGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_53 = io_out_data_0_r[0] & io_out_data_0_r_1[0] ? pgroups_1_out_data_1_Im : _GEN_52; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_0_out_data_0_Re = PencilGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] pgroups_0_out_data_1_Re = PencilGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_55 = ~io_out_data_0_r[0] & io_out_data_0_r_1[0] ? pgroups_0_out_data_1_Re : pgroups_0_out_data_0_Re; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_1_out_data_0_Re = PencilGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_56 = io_out_data_0_r[0] & ~io_out_data_0_r_1[0] ? pgroups_1_out_data_0_Re : _GEN_55; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_1_out_data_1_Re = PencilGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_57 = io_out_data_0_r[0] & io_out_data_0_r_1[0] ? pgroups_1_out_data_1_Re : _GEN_56; // @[PaddingDesigns.scala 179:{24,24}]
  wire  _GEN_198 = ~io_in_pgroup_slct_1[0]; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_199 = ~io_in_RAM_slct_1[0]; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_58 = ~io_in_pgroup_slct_1[0] & ~io_in_RAM_slct_1[0] ? io_in_write : _GEN_12; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_59 = ~io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_write : _GEN_13; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_60 = io_in_pgroup_slct_1[0] & ~io_in_RAM_slct_1[0] ? io_in_write : _GEN_14; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_61 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_write : _GEN_15; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_62 = _GEN_198 & _GEN_199 ? _io_out_last_T : _GEN_16; // @[PaddingDesigns.scala 172:{71,71}]
  wire  _GEN_63 = _GEN_198 & io_in_RAM_slct_1[0] ? _io_out_last_T : _GEN_17; // @[PaddingDesigns.scala 172:{71,71}]
  wire  _GEN_64 = io_in_pgroup_slct_1[0] & _GEN_199 ? _io_out_last_T : _GEN_18; // @[PaddingDesigns.scala 172:{71,71}]
  wire  _GEN_65 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? _io_out_last_T : _GEN_19; // @[PaddingDesigns.scala 172:{71,71}]
  wire [1:0] _GEN_66 = _GEN_198 & _GEN_199 ? io_in_addr_slct_1 : _GEN_20; // @[PaddingDesigns.scala 173:{72,72}]
  wire [1:0] _GEN_67 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_addr_slct_1 : _GEN_21; // @[PaddingDesigns.scala 173:{72,72}]
  wire [1:0] _GEN_68 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_addr_slct_1 : _GEN_22; // @[PaddingDesigns.scala 173:{72,72}]
  wire [1:0] _GEN_69 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_addr_slct_1 : _GEN_23; // @[PaddingDesigns.scala 173:{72,72}]
  wire  _GEN_74 = _GEN_198 & _GEN_199 ? io_in_valid : _GEN_28; // @[PaddingDesigns.scala 175:{67,67}]
  wire  _GEN_75 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_valid : _GEN_29; // @[PaddingDesigns.scala 175:{67,67}]
  wire  _GEN_76 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_valid : _GEN_30; // @[PaddingDesigns.scala 175:{67,67}]
  wire  _GEN_77 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_valid : _GEN_31; // @[PaddingDesigns.scala 175:{67,67}]
  wire  _GEN_78 = _GEN_198 & _GEN_199 ? io_in_ready : _GEN_32; // @[PaddingDesigns.scala 176:{67,67}]
  wire  _GEN_79 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_ready : _GEN_33; // @[PaddingDesigns.scala 176:{67,67}]
  wire  _GEN_80 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_ready : _GEN_34; // @[PaddingDesigns.scala 176:{67,67}]
  wire  _GEN_81 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_ready : _GEN_35; // @[PaddingDesigns.scala 176:{67,67}]
  wire [31:0] _GEN_86 = _GEN_198 & _GEN_199 ? io_in_data_1_Im : _GEN_40; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_87 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_data_1_Im : _GEN_41; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_88 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_data_1_Im : _GEN_42; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_89 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_data_1_Im : _GEN_43; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_90 = _GEN_198 & _GEN_199 ? io_in_data_1_Re : _GEN_44; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_91 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_data_1_Re : _GEN_45; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_92 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_data_1_Re : _GEN_46; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_93 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_data_1_Re : _GEN_47; // @[PaddingDesigns.scala 178:{66,66}]
  reg [1:0] io_out_data_1_r; // @[Reg.scala 16:16]
  reg [1:0] io_out_data_1_r_1; // @[Reg.scala 16:16]
  wire [31:0] _GEN_97 = ~io_out_data_1_r[0] & io_out_data_1_r_1[0] ? pgroups_0_out_data_1_Im : pgroups_0_out_data_0_Im; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_98 = io_out_data_1_r[0] & ~io_out_data_1_r_1[0] ? pgroups_1_out_data_0_Im : _GEN_97; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_99 = io_out_data_1_r[0] & io_out_data_1_r_1[0] ? pgroups_1_out_data_1_Im : _GEN_98; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_101 = ~io_out_data_1_r[0] & io_out_data_1_r_1[0] ? pgroups_0_out_data_1_Re : pgroups_0_out_data_0_Re; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_102 = io_out_data_1_r[0] & ~io_out_data_1_r_1[0] ? pgroups_1_out_data_0_Re : _GEN_101; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_103 = io_out_data_1_r[0] & io_out_data_1_r_1[0] ? pgroups_1_out_data_1_Re : _GEN_102; // @[PaddingDesigns.scala 179:{24,24}]
  PencilGroup PencilGroup ( // @[PaddingDesigns.scala 154:53]
    .clock(PencilGroup_clock),
    .io_in_ready_0(PencilGroup_io_in_ready_0),
    .io_in_ready_1(PencilGroup_io_in_ready_1),
    .io_in_valid_0(PencilGroup_io_in_valid_0),
    .io_in_valid_1(PencilGroup_io_in_valid_1),
    .io_in_data_0_Re(PencilGroup_io_in_data_0_Re),
    .io_in_data_0_Im(PencilGroup_io_in_data_0_Im),
    .io_in_data_1_Re(PencilGroup_io_in_data_1_Re),
    .io_in_data_1_Im(PencilGroup_io_in_data_1_Im),
    .io_in_mems_0_write(PencilGroup_io_in_mems_0_write),
    .io_in_mems_0_read(PencilGroup_io_in_mems_0_read),
    .io_in_mems_0_waddr(PencilGroup_io_in_mems_0_waddr),
    .io_in_mems_0_raddr(PencilGroup_io_in_mems_0_raddr),
    .io_in_mems_1_write(PencilGroup_io_in_mems_1_write),
    .io_in_mems_1_read(PencilGroup_io_in_mems_1_read),
    .io_in_mems_1_waddr(PencilGroup_io_in_mems_1_waddr),
    .io_in_mems_1_raddr(PencilGroup_io_in_mems_1_raddr),
    .io_out_data_0_Re(PencilGroup_io_out_data_0_Re),
    .io_out_data_0_Im(PencilGroup_io_out_data_0_Im),
    .io_out_data_1_Re(PencilGroup_io_out_data_1_Re),
    .io_out_data_1_Im(PencilGroup_io_out_data_1_Im)
  );
  PencilGroup PencilGroup_1 ( // @[PaddingDesigns.scala 154:53]
    .clock(PencilGroup_1_clock),
    .io_in_ready_0(PencilGroup_1_io_in_ready_0),
    .io_in_ready_1(PencilGroup_1_io_in_ready_1),
    .io_in_valid_0(PencilGroup_1_io_in_valid_0),
    .io_in_valid_1(PencilGroup_1_io_in_valid_1),
    .io_in_data_0_Re(PencilGroup_1_io_in_data_0_Re),
    .io_in_data_0_Im(PencilGroup_1_io_in_data_0_Im),
    .io_in_data_1_Re(PencilGroup_1_io_in_data_1_Re),
    .io_in_data_1_Im(PencilGroup_1_io_in_data_1_Im),
    .io_in_mems_0_write(PencilGroup_1_io_in_mems_0_write),
    .io_in_mems_0_read(PencilGroup_1_io_in_mems_0_read),
    .io_in_mems_0_waddr(PencilGroup_1_io_in_mems_0_waddr),
    .io_in_mems_0_raddr(PencilGroup_1_io_in_mems_0_raddr),
    .io_in_mems_1_write(PencilGroup_1_io_in_mems_1_write),
    .io_in_mems_1_read(PencilGroup_1_io_in_mems_1_read),
    .io_in_mems_1_waddr(PencilGroup_1_io_in_mems_1_waddr),
    .io_in_mems_1_raddr(PencilGroup_1_io_in_mems_1_raddr),
    .io_out_data_0_Re(PencilGroup_1_io_out_data_0_Re),
    .io_out_data_0_Im(PencilGroup_1_io_out_data_0_Im),
    .io_out_data_1_Re(PencilGroup_1_io_out_data_1_Re),
    .io_out_data_1_Im(PencilGroup_1_io_out_data_1_Im)
  );
  assign io_out_data_0_Re = io_in_ready ? _GEN_57 : 32'h0; // @[PaddingDesigns.scala 169:22 179:24 168:27]
  assign io_out_data_0_Im = io_in_ready ? _GEN_53 : 32'h0; // @[PaddingDesigns.scala 169:22 179:24 168:27]
  assign io_out_data_1_Re = io_in_ready ? _GEN_103 : 32'h0; // @[PaddingDesigns.scala 169:22 179:24 168:27]
  assign io_out_data_1_Im = io_in_ready ? _GEN_99 : 32'h0; // @[PaddingDesigns.scala 169:22 179:24 168:27]
  assign PencilGroup_clock = clock;
  assign PencilGroup_io_in_ready_0 = io_in_ready & _GEN_78; // @[PaddingDesigns.scala 169:22 158:28]
  assign PencilGroup_io_in_ready_1 = io_in_ready & _GEN_79; // @[PaddingDesigns.scala 169:22 158:28]
  assign PencilGroup_io_in_valid_0 = io_in_ready & _GEN_74; // @[PaddingDesigns.scala 169:22 156:28]
  assign PencilGroup_io_in_valid_1 = io_in_ready & _GEN_75; // @[PaddingDesigns.scala 169:22 156:28]
  assign PencilGroup_io_in_data_0_Re = io_in_ready ? _GEN_90 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_io_in_data_0_Im = io_in_ready ? _GEN_86 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_io_in_data_1_Re = io_in_ready ? _GEN_91 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_io_in_data_1_Im = io_in_ready ? _GEN_87 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_io_in_mems_0_write = io_in_ready & _GEN_58; // @[PaddingDesigns.scala 169:22 160:36]
  assign PencilGroup_io_in_mems_0_read = io_in_ready & _GEN_62; // @[PaddingDesigns.scala 169:22 161:35]
  assign PencilGroup_io_in_mems_0_waddr = io_in_ready ? _GEN_66 : 2'h0; // @[PaddingDesigns.scala 169:22 163:36]
  assign PencilGroup_io_in_mems_0_raddr = io_in_ready ? _GEN_66 : 2'h0; // @[PaddingDesigns.scala 169:22 162:36]
  assign PencilGroup_io_in_mems_1_write = io_in_ready & _GEN_59; // @[PaddingDesigns.scala 169:22 160:36]
  assign PencilGroup_io_in_mems_1_read = io_in_ready & _GEN_63; // @[PaddingDesigns.scala 169:22 161:35]
  assign PencilGroup_io_in_mems_1_waddr = io_in_ready ? _GEN_67 : 2'h0; // @[PaddingDesigns.scala 169:22 163:36]
  assign PencilGroup_io_in_mems_1_raddr = io_in_ready ? _GEN_67 : 2'h0; // @[PaddingDesigns.scala 169:22 162:36]
  assign PencilGroup_1_clock = clock;
  assign PencilGroup_1_io_in_ready_0 = io_in_ready & _GEN_80; // @[PaddingDesigns.scala 169:22 158:28]
  assign PencilGroup_1_io_in_ready_1 = io_in_ready & _GEN_81; // @[PaddingDesigns.scala 169:22 158:28]
  assign PencilGroup_1_io_in_valid_0 = io_in_ready & _GEN_76; // @[PaddingDesigns.scala 169:22 156:28]
  assign PencilGroup_1_io_in_valid_1 = io_in_ready & _GEN_77; // @[PaddingDesigns.scala 169:22 156:28]
  assign PencilGroup_1_io_in_data_0_Re = io_in_ready ? _GEN_92 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_1_io_in_data_0_Im = io_in_ready ? _GEN_88 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_1_io_in_data_1_Re = io_in_ready ? _GEN_93 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_1_io_in_data_1_Im = io_in_ready ? _GEN_89 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_1_io_in_mems_0_write = io_in_ready & _GEN_60; // @[PaddingDesigns.scala 169:22 160:36]
  assign PencilGroup_1_io_in_mems_0_read = io_in_ready & _GEN_64; // @[PaddingDesigns.scala 169:22 161:35]
  assign PencilGroup_1_io_in_mems_0_waddr = io_in_ready ? _GEN_68 : 2'h0; // @[PaddingDesigns.scala 169:22 163:36]
  assign PencilGroup_1_io_in_mems_0_raddr = io_in_ready ? _GEN_68 : 2'h0; // @[PaddingDesigns.scala 169:22 162:36]
  assign PencilGroup_1_io_in_mems_1_write = io_in_ready & _GEN_61; // @[PaddingDesigns.scala 169:22 160:36]
  assign PencilGroup_1_io_in_mems_1_read = io_in_ready & _GEN_65; // @[PaddingDesigns.scala 169:22 161:35]
  assign PencilGroup_1_io_in_mems_1_waddr = io_in_ready ? _GEN_69 : 2'h0; // @[PaddingDesigns.scala 169:22 163:36]
  assign PencilGroup_1_io_in_mems_1_raddr = io_in_ready ? _GEN_69 : 2'h0; // @[PaddingDesigns.scala 169:22 162:36]
  always @(posedge clock) begin
    if (_io_out_last_T_1) begin // @[Reg.scala 17:18]
      io_out_data_0_r <= io_in_pgroup_slct_0; // @[Reg.scala 17:22]
    end
    if (_io_out_last_T_1) begin // @[Reg.scala 17:18]
      io_out_data_0_r_1 <= io_in_RAM_slct_0; // @[Reg.scala 17:22]
    end
    if (_io_out_last_T_1) begin // @[Reg.scala 17:18]
      io_out_data_1_r <= io_in_pgroup_slct_1; // @[Reg.scala 17:22]
    end
    if (_io_out_last_T_1) begin // @[Reg.scala 17:18]
      io_out_data_1_r_1 <= io_in_RAM_slct_1; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_out_data_0_r = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  io_out_data_0_r_1 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  io_out_data_1_r = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  io_out_data_1_r_1 = _RAND_3[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SimpleTrnsp_batched(
  input         clock,
  input         reset,
  input         io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input  [31:0] io_in_data_1_Re,
  input  [31:0] io_in_data_1_Im,
  output        io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  wire  SlabGroup_clock; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_io_in_ready; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_io_in_valid; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_1_Im; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_io_in_write; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_pgroup_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_pgroup_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_RAM_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_RAM_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_addr_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_addr_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_clock; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_io_in_ready; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_io_in_valid; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_1_Im; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_io_in_write; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_pgroup_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_pgroup_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_RAM_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_RAM_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_addr_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_addr_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 463:39]
  reg [2:0] value; // @[Counter.scala 62:40]
  reg [2:0] value_1; // @[Counter.scala 62:40]
  reg  reg_read_out; // @[PaddingDesigns.scala 450:31]
  reg [1:0] value_2; // @[Counter.scala 62:40]
  reg [2:0] reg_out_addr_offst; // @[PaddingDesigns.scala 456:37]
  reg [1:0] value_5; // @[Counter.scala 62:40]
  reg  value_6; // @[Counter.scala 62:40]
  reg [2:0] reg_in_addr_offst; // @[PaddingDesigns.scala 459:36]
  reg [1:0] value_7; // @[Counter.scala 62:40]
  reg  value_8; // @[Counter.scala 62:40]
  reg  WR_mode; // @[PaddingDesigns.scala 462:26]
  wire  _io_out_last_T = ~WR_mode; // @[PaddingDesigns.scala 475:40]
  wire  _io_out_valid_T_1 = reg_read_out & value_2 == 2'h0; // @[PaddingDesigns.scala 477:48]
  reg  io_out_valid_r; // @[Reg.scala 16:16]
  reg  r; // @[Reg.scala 16:16]
  wire [31:0] slabs_0_out_data_0_Im = SlabGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_0_Im = SlabGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_0_out_data_0_Re = SlabGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_0_Re = SlabGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_0_out_data_1_Im = SlabGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_1_Im = SlabGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_0_out_data_1_Re = SlabGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_1_Re = SlabGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire  _GEN_15 = _io_out_last_T & io_in_ready; // @[PaddingDesigns.scala 466:18 483:{38,38}]
  wire  _GEN_16 = WR_mode & io_in_ready; // @[PaddingDesigns.scala 466:18 483:{38,38}]
  wire  _GEN_19 = _io_out_last_T & io_in_valid; // @[PaddingDesigns.scala 467:18 485:{38,38}]
  wire  _GEN_20 = WR_mode & io_in_valid; // @[PaddingDesigns.scala 467:18 485:{38,38}]
  wire [31:0] _GEN_21 = ~WR_mode ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_22 = WR_mode ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_23 = ~WR_mode ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_24 = WR_mode ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_25 = ~WR_mode ? io_in_data_1_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_26 = WR_mode ? io_in_data_1_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_27 = ~WR_mode ? io_in_data_1_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_28 = WR_mode ? io_in_data_1_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [1:0] _slabs_WR_mode_in_pgroup_slct_0 = {{1'd0}, value_8}; // @[PaddingDesigns.scala 487:{54,54}]
  wire [1:0] _GEN_29 = ~WR_mode ? _slabs_WR_mode_in_pgroup_slct_0 : 2'h0; // @[PaddingDesigns.scala 471:33 487:{54,54}]
  wire [1:0] _GEN_30 = WR_mode ? _slabs_WR_mode_in_pgroup_slct_0 : 2'h0; // @[PaddingDesigns.scala 471:33 487:{54,54}]
  wire [1:0] _GEN_35 = ~WR_mode ? 2'h1 : 2'h0; // @[PaddingDesigns.scala 472:30 488:{41,41}]
  wire [1:0] _GEN_36 = WR_mode ? 2'h1 : 2'h0; // @[PaddingDesigns.scala 472:30 488:{41,41}]
  wire [2:0] _GEN_158 = {{1'd0}, value_7}; // @[PaddingDesigns.scala 489:73]
  wire [2:0] _slabs_in_addr_slct_0_T_1 = reg_in_addr_offst + _GEN_158; // @[PaddingDesigns.scala 489:73]
  wire [3:0] _slabs_in_addr_slct_0_T_2 = {{1'd0}, _slabs_in_addr_slct_0_T_1}; // @[PaddingDesigns.scala 489:93]
  wire [1:0] _GEN_37 = ~WR_mode ? _slabs_in_addr_slct_0_T_2[1:0] : 2'h0; // @[PaddingDesigns.scala 473:31 489:{52,52}]
  wire [1:0] _GEN_38 = WR_mode ? _slabs_in_addr_slct_0_T_2[1:0] : 2'h0; // @[PaddingDesigns.scala 473:31 489:{52,52}]
  wire  _T_3 = value_1 == 3'h7; // @[PaddingDesigns.scala 494:27]
  wire [2:0] _value_T_1 = value_1 + 3'h1; // @[Counter.scala 78:24]
  wire  wrap_1 = value_7 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_3 = value_7 + 2'h1; // @[Counter.scala 78:24]
  wire [2:0] _reg_in_addr_offst_T_1 = reg_in_addr_offst + 3'h4; // @[PaddingDesigns.scala 507:54]
  wire [2:0] _GEN_41 = value_8 ? _reg_in_addr_offst_T_1 : reg_in_addr_offst; // @[PaddingDesigns.scala 506:54 507:33 459:36]
  wire  _GEN_46 = value_1 == 3'h7 | reg_read_out; // @[PaddingDesigns.scala 494:76 497:24 450:31]
  wire  _GEN_57 = io_in_ready & io_in_valid & _io_out_last_T; // @[PaddingDesigns.scala 470:18 481:36]
  wire  _GEN_58 = io_in_ready & io_in_valid & WR_mode; // @[PaddingDesigns.scala 470:18 481:36]
  wire  _GEN_59 = io_in_ready & io_in_valid & _GEN_15; // @[PaddingDesigns.scala 466:18 481:36]
  wire  _GEN_60 = io_in_ready & io_in_valid & _GEN_16; // @[PaddingDesigns.scala 466:18 481:36]
  wire [1:0] _GEN_73 = io_in_ready & io_in_valid ? _GEN_29 : 2'h0; // @[PaddingDesigns.scala 471:33 481:36]
  wire [1:0] _GEN_74 = io_in_ready & io_in_valid ? _GEN_30 : 2'h0; // @[PaddingDesigns.scala 471:33 481:36]
  wire [1:0] _GEN_79 = io_in_ready & io_in_valid ? _GEN_35 : 2'h0; // @[PaddingDesigns.scala 472:30 481:36]
  wire [1:0] _GEN_80 = io_in_ready & io_in_valid ? _GEN_36 : 2'h0; // @[PaddingDesigns.scala 472:30 481:36]
  wire [1:0] _GEN_81 = io_in_ready & io_in_valid ? _GEN_37 : 2'h0; // @[PaddingDesigns.scala 473:31 481:36]
  wire [1:0] _GEN_82 = io_in_ready & io_in_valid ? _GEN_38 : 2'h0; // @[PaddingDesigns.scala 473:31 481:36]
  wire  _GEN_88 = io_in_ready & io_in_valid ? _GEN_46 : reg_read_out; // @[PaddingDesigns.scala 450:31 481:36]
  wire  _GEN_92 = ~_io_out_last_T ? 1'h0 : _GEN_57; // @[PaddingDesigns.scala 520:{39,39}]
  wire  _GEN_93 = _io_out_last_T ? 1'h0 : _GEN_58; // @[PaddingDesigns.scala 520:{39,39}]
  wire  _GEN_94 = ~_io_out_last_T ? io_in_ready : _GEN_59; // @[PaddingDesigns.scala 521:{39,39}]
  wire  _GEN_95 = _io_out_last_T ? io_in_ready : _GEN_60; // @[PaddingDesigns.scala 521:{39,39}]
  wire [1:0] _GEN_96 = ~_io_out_last_T ? 2'h0 : _GEN_73; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _GEN_97 = _io_out_last_T ? 2'h0 : _GEN_74; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _GEN_98 = ~_io_out_last_T ? 2'h1 : _GEN_73; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _GEN_99 = _io_out_last_T ? 2'h1 : _GEN_74; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _slabs_T_10_in_RAM_slct_0 = {{1'd0}, value_6}; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_100 = ~_io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : 2'h0; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_101 = _io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : 2'h0; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_102 = ~_io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : _GEN_79; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_103 = _io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : _GEN_80; // @[PaddingDesigns.scala 523:{52,52}]
  wire [2:0] _GEN_160 = {{1'd0}, value_5}; // @[PaddingDesigns.scala 524:75]
  wire [2:0] _slabs_in_addr_slct_0_T_5 = reg_out_addr_offst + _GEN_160; // @[PaddingDesigns.scala 524:75]
  wire [3:0] _slabs_in_addr_slct_0_T_6 = {{1'd0}, _slabs_in_addr_slct_0_T_5}; // @[PaddingDesigns.scala 524:96]
  wire [1:0] _GEN_104 = ~_io_out_last_T ? _slabs_in_addr_slct_0_T_6[1:0] : _GEN_81; // @[PaddingDesigns.scala 524:{53,53}]
  wire [1:0] _GEN_105 = _io_out_last_T ? _slabs_in_addr_slct_0_T_6[1:0] : _GEN_82; // @[PaddingDesigns.scala 524:{53,53}]
  wire  wrap_3 = value_2 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_7 = value_2 + 2'h1; // @[Counter.scala 78:24]
  wire  _T_16 = io_in_valid & _T_3; // @[PaddingDesigns.scala 533:30]
  wire [2:0] _value_T_9 = value + 3'h1; // @[Counter.scala 78:24]
  wire [1:0] _value_T_13 = value_5 + 2'h1; // @[Counter.scala 78:24]
  wire [1:0] _GEN_109 = value_6 ? _value_T_13 : value_5; // @[PaddingDesigns.scala 547:54 Counter.scala 78:15 62:40]
  wire [2:0] _reg_out_addr_offst_T_1 = reg_out_addr_offst + 3'h4; // @[PaddingDesigns.scala 551:56]
  wire [2:0] _GEN_110 = reg_out_addr_offst == 3'h0 ? 3'h0 : _reg_out_addr_offst_T_1; // @[PaddingDesigns.scala 544:95 545:34 551:34]
  wire  _GEN_111 = reg_out_addr_offst == 3'h0 ? value_6 + 1'h1 : value_6; // @[PaddingDesigns.scala 544:95 Counter.scala 78:15 62:40]
  wire [1:0] _GEN_112 = reg_out_addr_offst == 3'h0 ? _GEN_109 : value_5; // @[PaddingDesigns.scala 544:95 Counter.scala 62:40]
  SlabGroup SlabGroup ( // @[PaddingDesigns.scala 463:39]
    .clock(SlabGroup_clock),
    .io_in_ready(SlabGroup_io_in_ready),
    .io_in_valid(SlabGroup_io_in_valid),
    .io_in_data_0_Re(SlabGroup_io_in_data_0_Re),
    .io_in_data_0_Im(SlabGroup_io_in_data_0_Im),
    .io_in_data_1_Re(SlabGroup_io_in_data_1_Re),
    .io_in_data_1_Im(SlabGroup_io_in_data_1_Im),
    .io_in_write(SlabGroup_io_in_write),
    .io_in_pgroup_slct_0(SlabGroup_io_in_pgroup_slct_0),
    .io_in_pgroup_slct_1(SlabGroup_io_in_pgroup_slct_1),
    .io_in_RAM_slct_0(SlabGroup_io_in_RAM_slct_0),
    .io_in_RAM_slct_1(SlabGroup_io_in_RAM_slct_1),
    .io_in_addr_slct_0(SlabGroup_io_in_addr_slct_0),
    .io_in_addr_slct_1(SlabGroup_io_in_addr_slct_1),
    .io_out_data_0_Re(SlabGroup_io_out_data_0_Re),
    .io_out_data_0_Im(SlabGroup_io_out_data_0_Im),
    .io_out_data_1_Re(SlabGroup_io_out_data_1_Re),
    .io_out_data_1_Im(SlabGroup_io_out_data_1_Im)
  );
  SlabGroup SlabGroup_1 ( // @[PaddingDesigns.scala 463:39]
    .clock(SlabGroup_1_clock),
    .io_in_ready(SlabGroup_1_io_in_ready),
    .io_in_valid(SlabGroup_1_io_in_valid),
    .io_in_data_0_Re(SlabGroup_1_io_in_data_0_Re),
    .io_in_data_0_Im(SlabGroup_1_io_in_data_0_Im),
    .io_in_data_1_Re(SlabGroup_1_io_in_data_1_Re),
    .io_in_data_1_Im(SlabGroup_1_io_in_data_1_Im),
    .io_in_write(SlabGroup_1_io_in_write),
    .io_in_pgroup_slct_0(SlabGroup_1_io_in_pgroup_slct_0),
    .io_in_pgroup_slct_1(SlabGroup_1_io_in_pgroup_slct_1),
    .io_in_RAM_slct_0(SlabGroup_1_io_in_RAM_slct_0),
    .io_in_RAM_slct_1(SlabGroup_1_io_in_RAM_slct_1),
    .io_in_addr_slct_0(SlabGroup_1_io_in_addr_slct_0),
    .io_in_addr_slct_1(SlabGroup_1_io_in_addr_slct_1),
    .io_out_data_0_Re(SlabGroup_1_io_out_data_0_Re),
    .io_out_data_0_Im(SlabGroup_1_io_out_data_0_Im),
    .io_out_data_1_Re(SlabGroup_1_io_out_data_1_Re),
    .io_out_data_1_Im(SlabGroup_1_io_out_data_1_Im)
  );
  assign io_out_ready = io_in_ready; // @[PaddingDesigns.scala 478:18]
  assign io_out_valid = io_out_valid_r; // @[PaddingDesigns.scala 477:18]
  assign io_out_data_0_Re = r ? slabs_1_out_data_0_Re : slabs_0_out_data_0_Re; // @[PaddingDesigns.scala 479:{17,17}]
  assign io_out_data_0_Im = r ? slabs_1_out_data_0_Im : slabs_0_out_data_0_Im; // @[PaddingDesigns.scala 479:{17,17}]
  assign io_out_data_1_Re = r ? slabs_1_out_data_1_Re : slabs_0_out_data_1_Re; // @[PaddingDesigns.scala 479:{17,17}]
  assign io_out_data_1_Im = r ? slabs_1_out_data_1_Im : slabs_0_out_data_1_Im; // @[PaddingDesigns.scala 479:{17,17}]
  assign SlabGroup_clock = clock;
  assign SlabGroup_io_in_ready = io_in_ready & reg_read_out ? _GEN_94 : _GEN_59; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_valid = io_in_ready & io_in_valid & _GEN_19; // @[PaddingDesigns.scala 467:18 481:36]
  assign SlabGroup_io_in_data_0_Re = io_in_ready & io_in_valid ? _GEN_23 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_data_0_Im = io_in_ready & io_in_valid ? _GEN_21 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_data_1_Re = io_in_ready & io_in_valid ? _GEN_27 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_data_1_Im = io_in_ready & io_in_valid ? _GEN_25 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_write = io_in_ready & reg_read_out ? _GEN_92 : _GEN_57; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_pgroup_slct_0 = io_in_ready & reg_read_out ? _GEN_96 : _GEN_73; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_pgroup_slct_1 = io_in_ready & reg_read_out ? _GEN_98 : _GEN_73; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_RAM_slct_0 = io_in_ready & reg_read_out ? _GEN_100 : 2'h0; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_RAM_slct_1 = io_in_ready & reg_read_out ? _GEN_102 : _GEN_79; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_addr_slct_0 = io_in_ready & reg_read_out ? _GEN_104 : _GEN_81; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_addr_slct_1 = io_in_ready & reg_read_out ? _GEN_104 : _GEN_81; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_clock = clock;
  assign SlabGroup_1_io_in_ready = io_in_ready & reg_read_out ? _GEN_95 : _GEN_60; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_valid = io_in_ready & io_in_valid & _GEN_20; // @[PaddingDesigns.scala 467:18 481:36]
  assign SlabGroup_1_io_in_data_0_Re = io_in_ready & io_in_valid ? _GEN_24 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_data_0_Im = io_in_ready & io_in_valid ? _GEN_22 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_data_1_Re = io_in_ready & io_in_valid ? _GEN_28 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_data_1_Im = io_in_ready & io_in_valid ? _GEN_26 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_write = io_in_ready & reg_read_out ? _GEN_93 : _GEN_58; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_pgroup_slct_0 = io_in_ready & reg_read_out ? _GEN_97 : _GEN_74; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_pgroup_slct_1 = io_in_ready & reg_read_out ? _GEN_99 : _GEN_74; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_RAM_slct_0 = io_in_ready & reg_read_out ? _GEN_101 : 2'h0; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_RAM_slct_1 = io_in_ready & reg_read_out ? _GEN_103 : _GEN_80; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_addr_slct_0 = io_in_ready & reg_read_out ? _GEN_105 : _GEN_82; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_addr_slct_1 = io_in_ready & reg_read_out ? _GEN_105 : _GEN_82; // @[PaddingDesigns.scala 519:37]
  always @(posedge clock) begin
    if (reset) begin // @[Counter.scala 62:40]
      value <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_3) begin // @[PaddingDesigns.scala 527:46]
        if (value == 3'h7) begin // @[PaddingDesigns.scala 531:79]
          value <= 3'h0; // @[Counter.scala 99:11]
        end else begin
          value <= _value_T_9; // @[Counter.scala 78:15]
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_1 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (value_1 == 3'h7) begin // @[PaddingDesigns.scala 494:76]
        value_1 <= 3'h0; // @[Counter.scala 99:11]
      end else begin
        value_1 <= _value_T_1; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 450:31]
      reg_read_out <= 1'h0; // @[PaddingDesigns.scala 450:31]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_3) begin // @[PaddingDesigns.scala 527:46]
        if (value == 3'h7) begin // @[PaddingDesigns.scala 531:79]
          reg_read_out <= _T_16;
        end else begin
          reg_read_out <= _GEN_88;
        end
      end else begin
        reg_read_out <= _GEN_88;
      end
    end else begin
      reg_read_out <= _GEN_88;
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_2 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_3) begin // @[PaddingDesigns.scala 527:46]
        if (value == 3'h7) begin // @[PaddingDesigns.scala 531:79]
          value_2 <= 2'h0; // @[Counter.scala 99:11]
        end else begin
          value_2 <= _value_T_7; // @[Counter.scala 78:15]
        end
      end else begin
        value_2 <= _value_T_7; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 456:37]
      reg_out_addr_offst <= 3'h0; // @[PaddingDesigns.scala 456:37]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_3) begin // @[PaddingDesigns.scala 527:46]
        if (value == 3'h7) begin // @[PaddingDesigns.scala 531:79]
          reg_out_addr_offst <= 3'h0; // @[PaddingDesigns.scala 538:32]
        end else begin
          reg_out_addr_offst <= _GEN_110;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_5 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_3) begin // @[PaddingDesigns.scala 527:46]
        if (value == 3'h7) begin // @[PaddingDesigns.scala 531:79]
          value_5 <= 2'h0; // @[Counter.scala 99:11]
        end else begin
          value_5 <= _GEN_112;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_6 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_3) begin // @[PaddingDesigns.scala 527:46]
        if (value == 3'h7) begin // @[PaddingDesigns.scala 531:79]
          value_6 <= 1'h0; // @[Counter.scala 99:11]
        end else begin
          value_6 <= _GEN_111;
        end
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 459:36]
      reg_in_addr_offst <= 3'h0; // @[PaddingDesigns.scala 459:36]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (value_1 == 3'h7) begin // @[PaddingDesigns.scala 494:76]
        reg_in_addr_offst <= 3'h0; // @[PaddingDesigns.scala 498:29]
      end else if (wrap_1) begin // @[PaddingDesigns.scala 504:67]
        reg_in_addr_offst <= _GEN_41;
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_7 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (value_1 == 3'h7) begin // @[PaddingDesigns.scala 494:76]
        value_7 <= 2'h0; // @[Counter.scala 99:11]
      end else begin
        value_7 <= _value_T_3; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_8 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (value_1 == 3'h7) begin // @[PaddingDesigns.scala 494:76]
        value_8 <= 1'h0; // @[Counter.scala 99:11]
      end else if (wrap_1) begin // @[PaddingDesigns.scala 504:67]
        value_8 <= value_8 + 1'h1; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 462:26]
      WR_mode <= 1'h0; // @[PaddingDesigns.scala 462:26]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (value_1 == 3'h7) begin // @[PaddingDesigns.scala 494:76]
        WR_mode <= _io_out_last_T; // @[PaddingDesigns.scala 496:19]
      end
    end
    if (io_in_ready) begin // @[Reg.scala 17:18]
      io_out_valid_r <= _io_out_valid_T_1; // @[Reg.scala 17:22]
    end
    if (io_in_ready) begin // @[Reg.scala 17:18]
      r <= _io_out_last_T; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  value = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  value_1 = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  reg_read_out = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  value_2 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  reg_out_addr_offst = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  value_5 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  value_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  reg_in_addr_offst = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  value_7 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  value_8 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  WR_mode = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  io_out_valid_r = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  r = _RAND_12[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SimpleTrnsp_batched_1(
  input         clock,
  input         reset,
  input         io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input  [31:0] io_in_data_1_Re,
  input  [31:0] io_in_data_1_Im,
  output        io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  wire  SlabGroup_clock; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_io_in_ready; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_io_in_valid; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_1_Im; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_io_in_write; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_pgroup_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_pgroup_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_RAM_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_RAM_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_addr_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_addr_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_clock; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_io_in_ready; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_io_in_valid; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_1_Im; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_io_in_write; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_pgroup_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_pgroup_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_RAM_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_RAM_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_addr_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_addr_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 463:39]
  reg [2:0] value; // @[Counter.scala 62:40]
  reg [2:0] value_1; // @[Counter.scala 62:40]
  reg  reg_read_out; // @[PaddingDesigns.scala 450:31]
  reg [1:0] value_2; // @[Counter.scala 62:40]
  reg [2:0] reg_out_addr_offst; // @[PaddingDesigns.scala 456:37]
  reg  value_6; // @[Counter.scala 62:40]
  reg [2:0] reg_in_addr_offst; // @[PaddingDesigns.scala 459:36]
  reg  value_8; // @[Counter.scala 62:40]
  reg  WR_mode; // @[PaddingDesigns.scala 462:26]
  wire  _io_out_last_T = ~WR_mode; // @[PaddingDesigns.scala 475:40]
  wire  _io_out_valid_T_1 = reg_read_out & value_2 == 2'h0; // @[PaddingDesigns.scala 477:48]
  reg  io_out_valid_r; // @[Reg.scala 16:16]
  reg  r; // @[Reg.scala 16:16]
  wire [31:0] slabs_0_out_data_0_Im = SlabGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_0_Im = SlabGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_0_out_data_0_Re = SlabGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_0_Re = SlabGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_0_out_data_1_Im = SlabGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_1_Im = SlabGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_0_out_data_1_Re = SlabGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_1_Re = SlabGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire  _GEN_15 = _io_out_last_T & io_in_ready; // @[PaddingDesigns.scala 466:18 483:{38,38}]
  wire  _GEN_16 = WR_mode & io_in_ready; // @[PaddingDesigns.scala 466:18 483:{38,38}]
  wire  _GEN_19 = _io_out_last_T & io_in_valid; // @[PaddingDesigns.scala 467:18 485:{38,38}]
  wire  _GEN_20 = WR_mode & io_in_valid; // @[PaddingDesigns.scala 467:18 485:{38,38}]
  wire [31:0] _GEN_21 = ~WR_mode ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_22 = WR_mode ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_23 = ~WR_mode ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_24 = WR_mode ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_25 = ~WR_mode ? io_in_data_1_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_26 = WR_mode ? io_in_data_1_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_27 = ~WR_mode ? io_in_data_1_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_28 = WR_mode ? io_in_data_1_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [1:0] _slabs_WR_mode_in_pgroup_slct_0 = {{1'd0}, value_8}; // @[PaddingDesigns.scala 487:{54,54}]
  wire [1:0] _GEN_29 = ~WR_mode ? _slabs_WR_mode_in_pgroup_slct_0 : 2'h0; // @[PaddingDesigns.scala 471:33 487:{54,54}]
  wire [1:0] _GEN_30 = WR_mode ? _slabs_WR_mode_in_pgroup_slct_0 : 2'h0; // @[PaddingDesigns.scala 471:33 487:{54,54}]
  wire [1:0] _GEN_35 = ~WR_mode ? 2'h1 : 2'h0; // @[PaddingDesigns.scala 472:30 488:{41,41}]
  wire [1:0] _GEN_36 = WR_mode ? 2'h1 : 2'h0; // @[PaddingDesigns.scala 472:30 488:{41,41}]
  wire  _T_3 = value_1 == 3'h7; // @[PaddingDesigns.scala 494:27]
  wire [3:0] _slabs_in_addr_slct_0_T = {{1'd0}, reg_in_addr_offst}; // @[PaddingDesigns.scala 489:73]
  wire [3:0] _slabs_in_addr_slct_0_T_2 = {{1'd0}, _slabs_in_addr_slct_0_T[2:0]}; // @[PaddingDesigns.scala 489:93]
  wire [1:0] _GEN_37 = ~WR_mode ? _slabs_in_addr_slct_0_T_2[1:0] : 2'h0; // @[PaddingDesigns.scala 473:31 489:{52,52}]
  wire [1:0] _GEN_38 = WR_mode ? _slabs_in_addr_slct_0_T_2[1:0] : 2'h0; // @[PaddingDesigns.scala 473:31 489:{52,52}]
  wire [2:0] _value_T_1 = value_1 + 3'h1; // @[Counter.scala 78:24]
  wire  _value_T_3 = value_8 + 1'h1; // @[Counter.scala 78:24]
  wire [2:0] _reg_in_addr_offst_T_1 = reg_in_addr_offst + 3'h1; // @[PaddingDesigns.scala 507:54]
  wire  _GEN_46 = value_1 == 3'h7 | reg_read_out; // @[PaddingDesigns.scala 494:76 497:24 450:31]
  wire  _GEN_57 = io_in_ready & io_in_valid & _io_out_last_T; // @[PaddingDesigns.scala 470:18 481:36]
  wire  _GEN_58 = io_in_ready & io_in_valid & WR_mode; // @[PaddingDesigns.scala 470:18 481:36]
  wire  _GEN_59 = io_in_ready & io_in_valid & _GEN_15; // @[PaddingDesigns.scala 466:18 481:36]
  wire  _GEN_60 = io_in_ready & io_in_valid & _GEN_16; // @[PaddingDesigns.scala 466:18 481:36]
  wire [1:0] _GEN_73 = io_in_ready & io_in_valid ? _GEN_29 : 2'h0; // @[PaddingDesigns.scala 471:33 481:36]
  wire [1:0] _GEN_74 = io_in_ready & io_in_valid ? _GEN_30 : 2'h0; // @[PaddingDesigns.scala 471:33 481:36]
  wire [1:0] _GEN_79 = io_in_ready & io_in_valid ? _GEN_35 : 2'h0; // @[PaddingDesigns.scala 472:30 481:36]
  wire [1:0] _GEN_80 = io_in_ready & io_in_valid ? _GEN_36 : 2'h0; // @[PaddingDesigns.scala 472:30 481:36]
  wire [1:0] _GEN_81 = io_in_ready & io_in_valid ? _GEN_37 : 2'h0; // @[PaddingDesigns.scala 473:31 481:36]
  wire [1:0] _GEN_82 = io_in_ready & io_in_valid ? _GEN_38 : 2'h0; // @[PaddingDesigns.scala 473:31 481:36]
  wire  _GEN_88 = io_in_ready & io_in_valid ? _GEN_46 : reg_read_out; // @[PaddingDesigns.scala 450:31 481:36]
  wire  _GEN_92 = ~_io_out_last_T ? 1'h0 : _GEN_57; // @[PaddingDesigns.scala 520:{39,39}]
  wire  _GEN_93 = _io_out_last_T ? 1'h0 : _GEN_58; // @[PaddingDesigns.scala 520:{39,39}]
  wire  _GEN_94 = ~_io_out_last_T ? io_in_ready : _GEN_59; // @[PaddingDesigns.scala 521:{39,39}]
  wire  _GEN_95 = _io_out_last_T ? io_in_ready : _GEN_60; // @[PaddingDesigns.scala 521:{39,39}]
  wire [1:0] _GEN_96 = ~_io_out_last_T ? 2'h0 : _GEN_73; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _GEN_97 = _io_out_last_T ? 2'h0 : _GEN_74; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _GEN_98 = ~_io_out_last_T ? 2'h1 : _GEN_73; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _GEN_99 = _io_out_last_T ? 2'h1 : _GEN_74; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _slabs_T_10_in_RAM_slct_0 = {{1'd0}, value_6}; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_100 = ~_io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : 2'h0; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_101 = _io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : 2'h0; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_102 = ~_io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : _GEN_79; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_103 = _io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : _GEN_80; // @[PaddingDesigns.scala 523:{52,52}]
  wire [3:0] _slabs_in_addr_slct_0_T_4 = {{1'd0}, reg_out_addr_offst}; // @[PaddingDesigns.scala 524:75]
  wire [3:0] _slabs_in_addr_slct_0_T_6 = {{1'd0}, _slabs_in_addr_slct_0_T_4[2:0]}; // @[PaddingDesigns.scala 524:96]
  wire [1:0] _GEN_104 = ~_io_out_last_T ? _slabs_in_addr_slct_0_T_6[1:0] : _GEN_81; // @[PaddingDesigns.scala 524:{53,53}]
  wire [1:0] _GEN_105 = _io_out_last_T ? _slabs_in_addr_slct_0_T_6[1:0] : _GEN_82; // @[PaddingDesigns.scala 524:{53,53}]
  wire [1:0] _value_T_5 = value_2 + 2'h1; // @[Counter.scala 78:24]
  wire  _T_16 = io_in_valid & _T_3; // @[PaddingDesigns.scala 533:30]
  wire [2:0] _value_T_7 = value + 3'h1; // @[Counter.scala 78:24]
  wire [2:0] _reg_out_addr_offst_T_1 = reg_out_addr_offst + 3'h1; // @[PaddingDesigns.scala 551:56]
  wire [2:0] _GEN_109 = reg_out_addr_offst == 3'h3 ? 3'h0 : _reg_out_addr_offst_T_1; // @[PaddingDesigns.scala 544:95 545:34 551:34]
  wire  _GEN_110 = reg_out_addr_offst == 3'h3 ? value_6 + 1'h1 : value_6; // @[PaddingDesigns.scala 544:95 Counter.scala 78:15 62:40]
  SlabGroup SlabGroup ( // @[PaddingDesigns.scala 463:39]
    .clock(SlabGroup_clock),
    .io_in_ready(SlabGroup_io_in_ready),
    .io_in_valid(SlabGroup_io_in_valid),
    .io_in_data_0_Re(SlabGroup_io_in_data_0_Re),
    .io_in_data_0_Im(SlabGroup_io_in_data_0_Im),
    .io_in_data_1_Re(SlabGroup_io_in_data_1_Re),
    .io_in_data_1_Im(SlabGroup_io_in_data_1_Im),
    .io_in_write(SlabGroup_io_in_write),
    .io_in_pgroup_slct_0(SlabGroup_io_in_pgroup_slct_0),
    .io_in_pgroup_slct_1(SlabGroup_io_in_pgroup_slct_1),
    .io_in_RAM_slct_0(SlabGroup_io_in_RAM_slct_0),
    .io_in_RAM_slct_1(SlabGroup_io_in_RAM_slct_1),
    .io_in_addr_slct_0(SlabGroup_io_in_addr_slct_0),
    .io_in_addr_slct_1(SlabGroup_io_in_addr_slct_1),
    .io_out_data_0_Re(SlabGroup_io_out_data_0_Re),
    .io_out_data_0_Im(SlabGroup_io_out_data_0_Im),
    .io_out_data_1_Re(SlabGroup_io_out_data_1_Re),
    .io_out_data_1_Im(SlabGroup_io_out_data_1_Im)
  );
  SlabGroup SlabGroup_1 ( // @[PaddingDesigns.scala 463:39]
    .clock(SlabGroup_1_clock),
    .io_in_ready(SlabGroup_1_io_in_ready),
    .io_in_valid(SlabGroup_1_io_in_valid),
    .io_in_data_0_Re(SlabGroup_1_io_in_data_0_Re),
    .io_in_data_0_Im(SlabGroup_1_io_in_data_0_Im),
    .io_in_data_1_Re(SlabGroup_1_io_in_data_1_Re),
    .io_in_data_1_Im(SlabGroup_1_io_in_data_1_Im),
    .io_in_write(SlabGroup_1_io_in_write),
    .io_in_pgroup_slct_0(SlabGroup_1_io_in_pgroup_slct_0),
    .io_in_pgroup_slct_1(SlabGroup_1_io_in_pgroup_slct_1),
    .io_in_RAM_slct_0(SlabGroup_1_io_in_RAM_slct_0),
    .io_in_RAM_slct_1(SlabGroup_1_io_in_RAM_slct_1),
    .io_in_addr_slct_0(SlabGroup_1_io_in_addr_slct_0),
    .io_in_addr_slct_1(SlabGroup_1_io_in_addr_slct_1),
    .io_out_data_0_Re(SlabGroup_1_io_out_data_0_Re),
    .io_out_data_0_Im(SlabGroup_1_io_out_data_0_Im),
    .io_out_data_1_Re(SlabGroup_1_io_out_data_1_Re),
    .io_out_data_1_Im(SlabGroup_1_io_out_data_1_Im)
  );
  assign io_out_ready = io_in_ready; // @[PaddingDesigns.scala 478:18]
  assign io_out_valid = io_out_valid_r; // @[PaddingDesigns.scala 477:18]
  assign io_out_data_0_Re = r ? slabs_1_out_data_0_Re : slabs_0_out_data_0_Re; // @[PaddingDesigns.scala 479:{17,17}]
  assign io_out_data_0_Im = r ? slabs_1_out_data_0_Im : slabs_0_out_data_0_Im; // @[PaddingDesigns.scala 479:{17,17}]
  assign io_out_data_1_Re = r ? slabs_1_out_data_1_Re : slabs_0_out_data_1_Re; // @[PaddingDesigns.scala 479:{17,17}]
  assign io_out_data_1_Im = r ? slabs_1_out_data_1_Im : slabs_0_out_data_1_Im; // @[PaddingDesigns.scala 479:{17,17}]
  assign SlabGroup_clock = clock;
  assign SlabGroup_io_in_ready = io_in_ready & reg_read_out ? _GEN_94 : _GEN_59; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_valid = io_in_ready & io_in_valid & _GEN_19; // @[PaddingDesigns.scala 467:18 481:36]
  assign SlabGroup_io_in_data_0_Re = io_in_ready & io_in_valid ? _GEN_23 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_data_0_Im = io_in_ready & io_in_valid ? _GEN_21 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_data_1_Re = io_in_ready & io_in_valid ? _GEN_27 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_data_1_Im = io_in_ready & io_in_valid ? _GEN_25 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_write = io_in_ready & reg_read_out ? _GEN_92 : _GEN_57; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_pgroup_slct_0 = io_in_ready & reg_read_out ? _GEN_96 : _GEN_73; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_pgroup_slct_1 = io_in_ready & reg_read_out ? _GEN_98 : _GEN_73; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_RAM_slct_0 = io_in_ready & reg_read_out ? _GEN_100 : 2'h0; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_RAM_slct_1 = io_in_ready & reg_read_out ? _GEN_102 : _GEN_79; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_addr_slct_0 = io_in_ready & reg_read_out ? _GEN_104 : _GEN_81; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_addr_slct_1 = io_in_ready & reg_read_out ? _GEN_104 : _GEN_81; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_clock = clock;
  assign SlabGroup_1_io_in_ready = io_in_ready & reg_read_out ? _GEN_95 : _GEN_60; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_valid = io_in_ready & io_in_valid & _GEN_20; // @[PaddingDesigns.scala 467:18 481:36]
  assign SlabGroup_1_io_in_data_0_Re = io_in_ready & io_in_valid ? _GEN_24 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_data_0_Im = io_in_ready & io_in_valid ? _GEN_22 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_data_1_Re = io_in_ready & io_in_valid ? _GEN_28 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_data_1_Im = io_in_ready & io_in_valid ? _GEN_26 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_write = io_in_ready & reg_read_out ? _GEN_93 : _GEN_58; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_pgroup_slct_0 = io_in_ready & reg_read_out ? _GEN_97 : _GEN_74; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_pgroup_slct_1 = io_in_ready & reg_read_out ? _GEN_99 : _GEN_74; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_RAM_slct_0 = io_in_ready & reg_read_out ? _GEN_101 : 2'h0; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_RAM_slct_1 = io_in_ready & reg_read_out ? _GEN_103 : _GEN_80; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_addr_slct_0 = io_in_ready & reg_read_out ? _GEN_105 : _GEN_82; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_addr_slct_1 = io_in_ready & reg_read_out ? _GEN_105 : _GEN_82; // @[PaddingDesigns.scala 519:37]
  always @(posedge clock) begin
    if (reset) begin // @[Counter.scala 62:40]
      value <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (value_2 == 2'h3) begin // @[PaddingDesigns.scala 527:46]
        if (value == 3'h7) begin // @[PaddingDesigns.scala 531:79]
          value <= 3'h0; // @[Counter.scala 99:11]
        end else begin
          value <= _value_T_7; // @[Counter.scala 78:15]
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_1 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (value_1 == 3'h7) begin // @[PaddingDesigns.scala 494:76]
        value_1 <= 3'h0; // @[Counter.scala 99:11]
      end else begin
        value_1 <= _value_T_1; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 450:31]
      reg_read_out <= 1'h0; // @[PaddingDesigns.scala 450:31]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (value_2 == 2'h3) begin // @[PaddingDesigns.scala 527:46]
        if (value == 3'h7) begin // @[PaddingDesigns.scala 531:79]
          reg_read_out <= _T_16;
        end else begin
          reg_read_out <= _GEN_88;
        end
      end else begin
        reg_read_out <= _GEN_88;
      end
    end else begin
      reg_read_out <= _GEN_88;
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_2 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (value_2 == 2'h3) begin // @[PaddingDesigns.scala 527:46]
        if (value == 3'h7) begin // @[PaddingDesigns.scala 531:79]
          value_2 <= 2'h0; // @[Counter.scala 99:11]
        end else begin
          value_2 <= _value_T_5; // @[Counter.scala 78:15]
        end
      end else begin
        value_2 <= _value_T_5; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 456:37]
      reg_out_addr_offst <= 3'h0; // @[PaddingDesigns.scala 456:37]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (value_2 == 2'h3) begin // @[PaddingDesigns.scala 527:46]
        if (value == 3'h7) begin // @[PaddingDesigns.scala 531:79]
          reg_out_addr_offst <= 3'h0; // @[PaddingDesigns.scala 538:32]
        end else begin
          reg_out_addr_offst <= _GEN_109;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_6 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (value_2 == 2'h3) begin // @[PaddingDesigns.scala 527:46]
        if (value == 3'h7) begin // @[PaddingDesigns.scala 531:79]
          value_6 <= 1'h0; // @[Counter.scala 99:11]
        end else begin
          value_6 <= _GEN_110;
        end
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 459:36]
      reg_in_addr_offst <= 3'h0; // @[PaddingDesigns.scala 459:36]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (value_1 == 3'h7) begin // @[PaddingDesigns.scala 494:76]
        reg_in_addr_offst <= 3'h0; // @[PaddingDesigns.scala 498:29]
      end else if (value_8) begin // @[PaddingDesigns.scala 506:54]
        reg_in_addr_offst <= _reg_in_addr_offst_T_1; // @[PaddingDesigns.scala 507:33]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_8 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (value_1 == 3'h7) begin // @[PaddingDesigns.scala 494:76]
        value_8 <= 1'h0; // @[Counter.scala 99:11]
      end else begin
        value_8 <= _value_T_3;
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 462:26]
      WR_mode <= 1'h0; // @[PaddingDesigns.scala 462:26]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (value_1 == 3'h7) begin // @[PaddingDesigns.scala 494:76]
        WR_mode <= _io_out_last_T; // @[PaddingDesigns.scala 496:19]
      end
    end
    if (io_in_ready) begin // @[Reg.scala 17:18]
      io_out_valid_r <= _io_out_valid_T_1; // @[Reg.scala 17:22]
    end
    if (io_in_ready) begin // @[Reg.scala 17:18]
      r <= _io_out_last_T; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  value = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  value_1 = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  reg_read_out = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  value_2 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  reg_out_addr_offst = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  value_6 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  reg_in_addr_offst = _RAND_6[2:0];
  _RAND_7 = {1{`RANDOM}};
  value_8 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  WR_mode = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  io_out_valid_r = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  r = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module full_subtractor_bw8(
  input  [7:0] io_in_a,
  input  [7:0] io_in_b,
  output [7:0] io_out_s,
  output       io_out_c
);
  wire [8:0] _result_T = io_in_a - io_in_b; // @[Arithmetic.scala 94:23]
  wire [9:0] _result_T_2 = _result_T - 9'h0; // @[Arithmetic.scala 94:34]
  wire [8:0] result = _result_T_2[8:0]; // @[Arithmetic.scala 93:22 94:12]
  assign io_out_s = result[7:0]; // @[Arithmetic.scala 95:23]
  assign io_out_c = result[8]; // @[Arithmetic.scala 96:23]
endmodule
module full_adder_bw24(
  input  [23:0] io_in_a,
  input  [23:0] io_in_b,
  output [23:0] io_out_s,
  output        io_out_c
);
  wire [24:0] _result_T = io_in_a + io_in_b; // @[Arithmetic.scala 79:23]
  wire [25:0] _result_T_1 = {{1'd0}, _result_T}; // @[Arithmetic.scala 79:34]
  wire [24:0] result = _result_T_1[24:0]; // @[Arithmetic.scala 78:22 79:12]
  assign io_out_s = result[23:0]; // @[Arithmetic.scala 80:23]
  assign io_out_c = result[24]; // @[Arithmetic.scala 81:23]
endmodule
module FP_adder_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_135;
`endif // RANDOMIZE_REG_INIT
  wire [7:0] subber_io_in_a; // @[FPArithmetic.scala 111:24]
  wire [7:0] subber_io_in_b; // @[FPArithmetic.scala 111:24]
  wire [7:0] subber_io_out_s; // @[FPArithmetic.scala 111:24]
  wire  subber_io_out_c; // @[FPArithmetic.scala 111:24]
  wire [23:0] adder_io_in_a; // @[FPArithmetic.scala 117:23]
  wire [23:0] adder_io_in_b; // @[FPArithmetic.scala 117:23]
  wire [23:0] adder_io_out_s; // @[FPArithmetic.scala 117:23]
  wire  adder_io_out_c; // @[FPArithmetic.scala 117:23]
  wire [7:0] subber2_io_in_a; // @[FPArithmetic.scala 178:25]
  wire [7:0] subber2_io_in_b; // @[FPArithmetic.scala 178:25]
  wire [7:0] subber2_io_out_s; // @[FPArithmetic.scala 178:25]
  wire  subber2_io_out_c; // @[FPArithmetic.scala 178:25]
  wire  sign_0 = io_in_a[31]; // @[FPArithmetic.scala 40:23]
  wire  sign_1 = io_in_b[31]; // @[FPArithmetic.scala 41:23]
  wire [8:0] _T_2 = 9'h100 - 9'h2; // @[FPArithmetic.scala 44:64]
  wire [8:0] _GEN_167 = {{1'd0}, io_in_a[30:23]}; // @[FPArithmetic.scala 44:36]
  wire [7:0] _GEN_0 = io_in_a[30:23] < 8'h1 ? 8'h1 : io_in_a[30:23]; // @[FPArithmetic.scala 46:46 47:14 49:14]
  wire [8:0] _GEN_1 = _GEN_167 > _T_2 ? _T_2 : {{1'd0}, _GEN_0}; // @[FPArithmetic.scala 44:71 45:14]
  wire [8:0] _GEN_168 = {{1'd0}, io_in_b[30:23]}; // @[FPArithmetic.scala 51:36]
  wire [7:0] _GEN_2 = io_in_b[30:23] < 8'h1 ? 8'h1 : io_in_b[30:23]; // @[FPArithmetic.scala 53:45 54:14 56:14]
  wire [8:0] _GEN_3 = _GEN_168 > _T_2 ? _T_2 : {{1'd0}, _GEN_2}; // @[FPArithmetic.scala 51:71 52:14]
  wire [22:0] frac_0 = io_in_a[22:0]; // @[FPArithmetic.scala 61:23]
  wire [22:0] frac_1 = io_in_b[22:0]; // @[FPArithmetic.scala 62:23]
  wire [23:0] whole_frac_0 = {1'h1,frac_0}; // @[FPArithmetic.scala 66:26]
  wire [23:0] whole_frac_1 = {1'h1,frac_1}; // @[FPArithmetic.scala 67:26]
  reg  sign_reg_0_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_0_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_1_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_1_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_2_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_2_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_3_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_3_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_4_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_4_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_5_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_5_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_6_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_6_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_7_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_7_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_8_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_8_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_9_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_9_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_10_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_10_1; // @[FPArithmetic.scala 69:28]
  reg [7:0] exp_reg_0_0; // @[FPArithmetic.scala 70:28]
  reg [7:0] exp_reg_0_1; // @[FPArithmetic.scala 70:28]
  reg [7:0] exp_reg_1_0; // @[FPArithmetic.scala 70:28]
  reg [7:0] exp_reg_1_1; // @[FPArithmetic.scala 70:28]
  reg [7:0] exp_reg_2_0; // @[FPArithmetic.scala 70:28]
  reg [7:0] exp_reg_2_1; // @[FPArithmetic.scala 70:28]
  reg [22:0] frac_reg_0_0; // @[FPArithmetic.scala 71:28]
  reg [22:0] frac_reg_0_1; // @[FPArithmetic.scala 71:28]
  reg [22:0] frac_reg_1_0; // @[FPArithmetic.scala 71:28]
  reg [22:0] frac_reg_1_1; // @[FPArithmetic.scala 71:28]
  reg [22:0] frac_reg_2_0; // @[FPArithmetic.scala 71:28]
  reg [22:0] frac_reg_2_1; // @[FPArithmetic.scala 71:28]
  reg [23:0] wfrac_reg_0_0; // @[FPArithmetic.scala 72:28]
  reg [23:0] wfrac_reg_0_1; // @[FPArithmetic.scala 72:28]
  reg [23:0] wfrac_reg_1_0; // @[FPArithmetic.scala 72:28]
  reg [23:0] wfrac_reg_1_1; // @[FPArithmetic.scala 72:28]
  reg [23:0] wfrac_reg_2_0; // @[FPArithmetic.scala 72:28]
  reg [23:0] wfrac_reg_2_1; // @[FPArithmetic.scala 72:28]
  reg [7:0] subber_out_s_reg_0; // @[FPArithmetic.scala 74:35]
  reg [7:0] subber_out_s_reg_1; // @[FPArithmetic.scala 74:35]
  reg  subber_out_c_reg_0; // @[FPArithmetic.scala 75:35]
  reg  subber_out_c_reg_1; // @[FPArithmetic.scala 75:35]
  reg [23:0] wire_temp_add_in_reg_0_0; // @[FPArithmetic.scala 77:39]
  reg [23:0] wire_temp_add_in_reg_0_1; // @[FPArithmetic.scala 77:39]
  reg [23:0] wire_temp_add_in_reg_1_0; // @[FPArithmetic.scala 77:39]
  reg [23:0] wire_temp_add_in_reg_1_1; // @[FPArithmetic.scala 77:39]
  reg  ref_s_reg_0; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_1; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_2; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_3; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_4; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_5; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_6; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_7; // @[FPArithmetic.scala 79:31]
  reg [22:0] ref_frac_reg_0; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_1; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_2; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_3; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_4; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_5; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_6; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_7; // @[FPArithmetic.scala 80:31]
  reg [7:0] ref_exp_reg_0; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_1; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_2; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_3; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_4; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_5; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_6; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_7; // @[FPArithmetic.scala 81:31]
  reg [7:0] sub_exp_reg_0; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_1; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_2; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_3; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_4; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_5; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_6; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_7; // @[FPArithmetic.scala 82:31]
  reg [23:0] adder_io_out_s_reg_0; // @[FPArithmetic.scala 84:37]
  reg [23:0] adder_io_out_s_reg_1; // @[FPArithmetic.scala 84:37]
  reg [23:0] adder_io_out_s_reg_2; // @[FPArithmetic.scala 84:37]
  reg  adder_io_out_c_reg_0; // @[FPArithmetic.scala 85:37]
  reg  new_s_reg_0; // @[FPArithmetic.scala 87:35]
  reg  new_s_reg_1; // @[FPArithmetic.scala 87:35]
  reg  new_s_reg_2; // @[FPArithmetic.scala 87:35]
  reg  new_s_reg_3; // @[FPArithmetic.scala 87:35]
  reg  new_s_reg_4; // @[FPArithmetic.scala 87:35]
  reg  new_s_reg_5; // @[FPArithmetic.scala 87:35]
  reg [22:0] new_out_frac_reg_0; // @[FPArithmetic.scala 88:35]
  reg [7:0] new_out_exp_reg_0; // @[FPArithmetic.scala 89:35]
  reg  E_reg_0; // @[FPArithmetic.scala 90:24]
  reg  E_reg_1; // @[FPArithmetic.scala 90:24]
  reg  E_reg_2; // @[FPArithmetic.scala 90:24]
  reg  E_reg_3; // @[FPArithmetic.scala 90:24]
  reg  E_reg_4; // @[FPArithmetic.scala 90:24]
  reg  D_reg_0; // @[FPArithmetic.scala 91:24]
  reg  D_reg_1; // @[FPArithmetic.scala 91:24]
  reg  D_reg_2; // @[FPArithmetic.scala 91:24]
  reg  D_reg_3; // @[FPArithmetic.scala 91:24]
  reg  D_reg_4; // @[FPArithmetic.scala 91:24]
  reg [23:0] adder_result_reg_0; // @[FPArithmetic.scala 93:35]
  reg [23:0] adder_result_reg_1; // @[FPArithmetic.scala 93:35]
  reg [23:0] adder_result_reg_2; // @[FPArithmetic.scala 93:35]
  reg [5:0] leadingOne_reg_0; // @[FPArithmetic.scala 95:33]
  reg [5:0] leadingOne_reg_1; // @[FPArithmetic.scala 95:33]
  reg [31:0] io_in_a_reg_0; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_1; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_2; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_3; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_4; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_5; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_6; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_7; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_8; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_9; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_10; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_b_reg_0; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_1; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_2; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_3; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_4; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_5; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_6; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_7; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_8; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_9; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_10; // @[FPArithmetic.scala 98:30]
  reg [7:0] subber2_out_s_reg_0; // @[FPArithmetic.scala 100:36]
  reg  subber2_out_c_reg_0; // @[FPArithmetic.scala 101:36]
  reg [7:0] cmpl_subber_out_s_reg_0; // @[FPArithmetic.scala 122:40]
  wire [7:0] _cmpl_subber_out_s_reg_0_T = ~subber_out_s_reg_0; // @[FPArithmetic.scala 124:41]
  wire [7:0] _cmpl_subber_out_s_reg_0_T_2 = 8'h1 + _cmpl_subber_out_s_reg_0_T; // @[FPArithmetic.scala 124:39]
  wire [23:0] _wire_temp_add_in_0_T = wfrac_reg_2_0 >> cmpl_subber_out_s_reg_0; // @[FPArithmetic.scala 132:46]
  wire [23:0] _wire_temp_add_in_1_T = wfrac_reg_2_1 >> subber_out_s_reg_1; // @[FPArithmetic.scala 140:46]
  reg [23:0] cmpl_wire_temp_add_in_reg_0_0; // @[FPArithmetic.scala 143:44]
  reg [23:0] cmpl_wire_temp_add_in_reg_0_1; // @[FPArithmetic.scala 143:44]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_0_T = ~wire_temp_add_in_reg_0_0; // @[FPArithmetic.scala 145:48]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_0_T_2 = 24'h1 + _cmpl_wire_temp_add_in_reg_0_0_T; // @[FPArithmetic.scala 145:46]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_1_T = ~wire_temp_add_in_reg_0_1; // @[FPArithmetic.scala 146:48]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_1_T_2 = 24'h1 + _cmpl_wire_temp_add_in_reg_0_1_T; // @[FPArithmetic.scala 146:46]
  wire [1:0] _adder_io_in_a_T = {sign_reg_4_1,sign_reg_4_0}; // @[FPArithmetic.scala 149:38]
  wire  _new_s_T = ~adder_io_out_c_reg_0; // @[FPArithmetic.scala 156:15]
  wire  new_s = ~adder_io_out_c_reg_0 & (sign_reg_5_0 | sign_reg_5_1) | sign_reg_5_0 & sign_reg_5_1; // @[FPArithmetic.scala 156:75]
  wire  _D_T_1 = sign_reg_5_0 ^ sign_reg_5_1; // @[FPArithmetic.scala 163:53]
  wire  D = _new_s_T | sign_reg_5_0 ^ sign_reg_5_1; // @[FPArithmetic.scala 163:35]
  wire  E = _new_s_T & ~adder_io_out_s_reg_0[23] | _new_s_T & ~_D_T_1 | adder_io_out_c_reg_0 & adder_io_out_s_reg_0[23]
     & _D_T_1; // @[FPArithmetic.scala 165:134]
  reg [23:0] cmpl_adder_io_out_s_reg_0; // @[FPArithmetic.scala 167:42]
  wire [23:0] _cmpl_adder_io_out_s_reg_0_T = ~adder_io_out_s_reg_1; // @[FPArithmetic.scala 170:43]
  wire [23:0] _cmpl_adder_io_out_s_reg_0_T_2 = 24'h1 + _cmpl_adder_io_out_s_reg_0_T; // @[FPArithmetic.scala 170:41]
  wire [1:0] _adder_result_T = {sign_reg_7_1,sign_reg_7_0}; // @[FPArithmetic.scala 174:53]
  wire [1:0] _leadingOne_T_25 = adder_result_reg_0[2] ? 2'h2 : {{1'd0}, adder_result_reg_0[1]}; // @[FPArithmetic.scala 177:70]
  wire [1:0] _leadingOne_T_26 = adder_result_reg_0[3] ? 2'h3 : _leadingOne_T_25; // @[FPArithmetic.scala 177:70]
  wire [2:0] _leadingOne_T_27 = adder_result_reg_0[4] ? 3'h4 : {{1'd0}, _leadingOne_T_26}; // @[FPArithmetic.scala 177:70]
  wire [2:0] _leadingOne_T_28 = adder_result_reg_0[5] ? 3'h5 : _leadingOne_T_27; // @[FPArithmetic.scala 177:70]
  wire [2:0] _leadingOne_T_29 = adder_result_reg_0[6] ? 3'h6 : _leadingOne_T_28; // @[FPArithmetic.scala 177:70]
  wire [2:0] _leadingOne_T_30 = adder_result_reg_0[7] ? 3'h7 : _leadingOne_T_29; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_31 = adder_result_reg_0[8] ? 4'h8 : {{1'd0}, _leadingOne_T_30}; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_32 = adder_result_reg_0[9] ? 4'h9 : _leadingOne_T_31; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_33 = adder_result_reg_0[10] ? 4'ha : _leadingOne_T_32; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_34 = adder_result_reg_0[11] ? 4'hb : _leadingOne_T_33; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_35 = adder_result_reg_0[12] ? 4'hc : _leadingOne_T_34; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_36 = adder_result_reg_0[13] ? 4'hd : _leadingOne_T_35; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_37 = adder_result_reg_0[14] ? 4'he : _leadingOne_T_36; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_38 = adder_result_reg_0[15] ? 4'hf : _leadingOne_T_37; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_39 = adder_result_reg_0[16] ? 5'h10 : {{1'd0}, _leadingOne_T_38}; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_40 = adder_result_reg_0[17] ? 5'h11 : _leadingOne_T_39; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_41 = adder_result_reg_0[18] ? 5'h12 : _leadingOne_T_40; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_42 = adder_result_reg_0[19] ? 5'h13 : _leadingOne_T_41; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_43 = adder_result_reg_0[20] ? 5'h14 : _leadingOne_T_42; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_44 = adder_result_reg_0[21] ? 5'h15 : _leadingOne_T_43; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_45 = adder_result_reg_0[22] ? 5'h16 : _leadingOne_T_44; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_46 = adder_result_reg_0[23] ? 5'h17 : _leadingOne_T_45; // @[FPArithmetic.scala 177:70]
  wire [5:0] leadingOne = _leadingOne_T_46 + 5'h1; // @[FPArithmetic.scala 177:77]
  wire [5:0] _subber2_io_in_b_T_1 = 6'h18 - leadingOne_reg_0; // @[FPArithmetic.scala 180:42]
  wire [7:0] exp_0 = _GEN_1[7:0]; // @[FPArithmetic.scala 42:19]
  wire [7:0] exp_1 = _GEN_3[7:0]; // @[FPArithmetic.scala 42:19]
  reg [31:0] reg_out_s; // @[FPArithmetic.scala 249:28]
  wire [8:0] _GEN_169 = {{1'd0}, ref_exp_reg_7}; // @[FPArithmetic.scala 266:29]
  wire [23:0] _new_out_frac_reg_0_T_2 = 24'h800000 - 24'h1; // @[FPArithmetic.scala 268:60]
  wire [7:0] _new_out_exp_reg_0_T_3 = ref_exp_reg_7 + 8'h1; // @[FPArithmetic.scala 270:48]
  wire [8:0] _GEN_142 = _GEN_169 == _T_2 ? _T_2 : {{1'd0}, _new_out_exp_reg_0_T_3}; // @[FPArithmetic.scala 266:66 267:30 270:30]
  wire [23:0] _GEN_143 = _GEN_169 == _T_2 ? _new_out_frac_reg_0_T_2 : {{1'd0}, adder_result_reg_2[23:1]}; // @[FPArithmetic.scala 266:66 268:31 271:31]
  wire [5:0] _new_out_frac_reg_0_T_6 = 6'h18 - leadingOne_reg_1; // @[FPArithmetic.scala 284:94]
  wire [85:0] _GEN_5 = {{63'd0}, adder_result_reg_2[22:0]}; // @[FPArithmetic.scala 284:73]
  wire [85:0] _new_out_frac_reg_0_T_7 = _GEN_5 << _new_out_frac_reg_0_T_6; // @[FPArithmetic.scala 284:73]
  wire [7:0] _GEN_144 = subber2_out_c_reg_0 ? 8'h1 : subber2_out_s_reg_0; // @[FPArithmetic.scala 279:46 280:32 283:32]
  wire [85:0] _GEN_145 = subber2_out_c_reg_0 ? 86'h0 : _new_out_frac_reg_0_T_7; // @[FPArithmetic.scala 279:46 281:33 284:33]
  wire [7:0] _GEN_146 = leadingOne_reg_1 == 6'h1 & adder_result_reg_2 == 24'h0 & ((sign_reg_10_0 ^ sign_reg_10_1) &
    io_in_a_reg_10[30:0] == io_in_b_reg_10[30:0]) ? 8'h0 : _GEN_144; // @[FPArithmetic.scala 275:184 276:30]
  wire [85:0] _GEN_147 = leadingOne_reg_1 == 6'h1 & adder_result_reg_2 == 24'h0 & ((sign_reg_10_0 ^ sign_reg_10_1) &
    io_in_a_reg_10[30:0] == io_in_b_reg_10[30:0]) ? 86'h0 : _GEN_145; // @[FPArithmetic.scala 275:184 277:31]
  wire  _GEN_148 = D_reg_4 ? new_s_reg_4 : new_s_reg_5; // @[FPArithmetic.scala 273:36 274:22 87:35]
  wire [7:0] _GEN_149 = D_reg_4 ? _GEN_146 : new_out_exp_reg_0; // @[FPArithmetic.scala 273:36 89:35]
  wire [85:0] _GEN_150 = D_reg_4 ? _GEN_147 : {{63'd0}, new_out_frac_reg_0}; // @[FPArithmetic.scala 273:36 88:35]
  wire  _GEN_151 = ~D_reg_4 ? new_s_reg_4 : _GEN_148; // @[FPArithmetic.scala 264:36 265:22]
  wire [8:0] _GEN_152 = ~D_reg_4 ? _GEN_142 : {{1'd0}, _GEN_149}; // @[FPArithmetic.scala 264:36]
  wire [85:0] _GEN_153 = ~D_reg_4 ? {{62'd0}, _GEN_143} : _GEN_150; // @[FPArithmetic.scala 264:36]
  wire  _GEN_154 = E_reg_4 ? new_s_reg_4 : _GEN_151; // @[FPArithmetic.scala 260:36 261:22]
  wire [8:0] _GEN_155 = E_reg_4 ? {{1'd0}, ref_exp_reg_7} : _GEN_152; // @[FPArithmetic.scala 260:36 262:28]
  wire [85:0] _GEN_156 = E_reg_4 ? {{63'd0}, adder_result_reg_2[22:0]} : _GEN_153; // @[FPArithmetic.scala 260:36 263:29]
  wire [85:0] _GEN_158 = sub_exp_reg_7 >= 8'h17 ? {{63'd0}, ref_frac_reg_7} : _GEN_156; // @[FPArithmetic.scala 256:48 258:29]
  wire [8:0] _GEN_159 = sub_exp_reg_7 >= 8'h17 ? {{1'd0}, ref_exp_reg_7} : _GEN_155; // @[FPArithmetic.scala 256:48 259:28]
  wire [8:0] _GEN_161 = io_in_a_reg_10[30:0] == 31'h0 & io_in_b_reg_10[30:0] == 31'h0 ? 9'h0 : _GEN_159; // @[FPArithmetic.scala 252:86 254:28]
  wire [85:0] _GEN_162 = io_in_a_reg_10[30:0] == 31'h0 & io_in_b_reg_10[30:0] == 31'h0 ? 86'h0 : _GEN_158; // @[FPArithmetic.scala 252:86 255:29]
  wire [31:0] _reg_out_s_T_1 = {new_s_reg_5,new_out_exp_reg_0,new_out_frac_reg_0}; // @[FPArithmetic.scala 288:55]
  wire [8:0] _GEN_164 = io_in_en ? _GEN_161 : {{1'd0}, new_out_exp_reg_0}; // @[FPArithmetic.scala 251:20 89:35]
  wire [85:0] _GEN_165 = io_in_en ? _GEN_162 : {{63'd0}, new_out_frac_reg_0}; // @[FPArithmetic.scala 251:20 88:35]
  wire [85:0] _GEN_170 = reset ? 86'h0 : _GEN_165; // @[FPArithmetic.scala 88:{35,35}]
  wire [8:0] _GEN_171 = reset ? 9'h0 : _GEN_164; // @[FPArithmetic.scala 89:{35,35}]
  full_subtractor_bw8 subber ( // @[FPArithmetic.scala 111:24]
    .io_in_a(subber_io_in_a),
    .io_in_b(subber_io_in_b),
    .io_out_s(subber_io_out_s),
    .io_out_c(subber_io_out_c)
  );
  full_adder_bw24 adder ( // @[FPArithmetic.scala 117:23]
    .io_in_a(adder_io_in_a),
    .io_in_b(adder_io_in_b),
    .io_out_s(adder_io_out_s),
    .io_out_c(adder_io_out_c)
  );
  full_subtractor_bw8 subber2 ( // @[FPArithmetic.scala 178:25]
    .io_in_a(subber2_io_in_a),
    .io_in_b(subber2_io_in_b),
    .io_out_s(subber2_io_out_s),
    .io_out_c(subber2_io_out_c)
  );
  assign io_out_s = reg_out_s; // @[FPArithmetic.scala 250:14]
  assign subber_io_in_a = exp_reg_0_0; // @[FPArithmetic.scala 112:20]
  assign subber_io_in_b = exp_reg_0_1; // @[FPArithmetic.scala 113:20]
  assign adder_io_in_a = _adder_io_in_a_T == 2'h1 ? cmpl_wire_temp_add_in_reg_0_0 : wire_temp_add_in_reg_1_0; // @[FPArithmetic.scala 149:25]
  assign adder_io_in_b = _adder_io_in_a_T == 2'h2 ? cmpl_wire_temp_add_in_reg_0_1 : wire_temp_add_in_reg_1_1; // @[FPArithmetic.scala 150:25]
  assign subber2_io_in_a = ref_exp_reg_6; // @[FPArithmetic.scala 179:21]
  assign subber2_io_in_b = {{2'd0}, _subber2_io_in_b_T_1}; // @[FPArithmetic.scala 180:21]
  always @(posedge clock) begin
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_0_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_0_0 <= sign_0; // @[FPArithmetic.scala 188:19]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_0_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_0_1 <= sign_1; // @[FPArithmetic.scala 188:19]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_1_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_1_0 <= sign_reg_0_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_1_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_1_1 <= sign_reg_0_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_2_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_2_0 <= sign_reg_1_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_2_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_2_1 <= sign_reg_1_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_3_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_3_0 <= sign_reg_2_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_3_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_3_1 <= sign_reg_2_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_4_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_4_0 <= sign_reg_3_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_4_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_4_1 <= sign_reg_3_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_5_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_5_0 <= sign_reg_4_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_5_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_5_1 <= sign_reg_4_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_6_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_6_0 <= sign_reg_5_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_6_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_6_1 <= sign_reg_5_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_7_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_7_0 <= sign_reg_6_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_7_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_7_1 <= sign_reg_6_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_8_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_8_0 <= sign_reg_7_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_8_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_8_1 <= sign_reg_7_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_9_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_9_0 <= sign_reg_8_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_9_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_9_1 <= sign_reg_8_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_10_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_10_0 <= sign_reg_9_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_10_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_10_1 <= sign_reg_9_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 70:28]
      exp_reg_0_0 <= 8'h0; // @[FPArithmetic.scala 70:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      exp_reg_0_0 <= exp_0; // @[FPArithmetic.scala 189:18]
    end
    if (reset) begin // @[FPArithmetic.scala 70:28]
      exp_reg_0_1 <= 8'h0; // @[FPArithmetic.scala 70:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      exp_reg_0_1 <= exp_1; // @[FPArithmetic.scala 189:18]
    end
    if (reset) begin // @[FPArithmetic.scala 70:28]
      exp_reg_1_0 <= 8'h0; // @[FPArithmetic.scala 70:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      exp_reg_1_0 <= exp_reg_0_0; // @[FPArithmetic.scala 237:22]
    end
    if (reset) begin // @[FPArithmetic.scala 70:28]
      exp_reg_1_1 <= 8'h0; // @[FPArithmetic.scala 70:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      exp_reg_1_1 <= exp_reg_0_1; // @[FPArithmetic.scala 237:22]
    end
    if (reset) begin // @[FPArithmetic.scala 70:28]
      exp_reg_2_0 <= 8'h0; // @[FPArithmetic.scala 70:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      exp_reg_2_0 <= exp_reg_1_0; // @[FPArithmetic.scala 237:22]
    end
    if (reset) begin // @[FPArithmetic.scala 70:28]
      exp_reg_2_1 <= 8'h0; // @[FPArithmetic.scala 70:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      exp_reg_2_1 <= exp_reg_1_1; // @[FPArithmetic.scala 237:22]
    end
    if (reset) begin // @[FPArithmetic.scala 71:28]
      frac_reg_0_0 <= 23'h0; // @[FPArithmetic.scala 71:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      frac_reg_0_0 <= frac_0; // @[FPArithmetic.scala 190:19]
    end
    if (reset) begin // @[FPArithmetic.scala 71:28]
      frac_reg_0_1 <= 23'h0; // @[FPArithmetic.scala 71:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      frac_reg_0_1 <= frac_1; // @[FPArithmetic.scala 190:19]
    end
    if (reset) begin // @[FPArithmetic.scala 71:28]
      frac_reg_1_0 <= 23'h0; // @[FPArithmetic.scala 71:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      frac_reg_1_0 <= frac_reg_0_0; // @[FPArithmetic.scala 238:23]
    end
    if (reset) begin // @[FPArithmetic.scala 71:28]
      frac_reg_1_1 <= 23'h0; // @[FPArithmetic.scala 71:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      frac_reg_1_1 <= frac_reg_0_1; // @[FPArithmetic.scala 238:23]
    end
    if (reset) begin // @[FPArithmetic.scala 71:28]
      frac_reg_2_0 <= 23'h0; // @[FPArithmetic.scala 71:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      frac_reg_2_0 <= frac_reg_1_0; // @[FPArithmetic.scala 238:23]
    end
    if (reset) begin // @[FPArithmetic.scala 71:28]
      frac_reg_2_1 <= 23'h0; // @[FPArithmetic.scala 71:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      frac_reg_2_1 <= frac_reg_1_1; // @[FPArithmetic.scala 238:23]
    end
    if (reset) begin // @[FPArithmetic.scala 72:28]
      wfrac_reg_0_0 <= 24'h0; // @[FPArithmetic.scala 72:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wfrac_reg_0_0 <= whole_frac_0; // @[FPArithmetic.scala 191:20]
    end
    if (reset) begin // @[FPArithmetic.scala 72:28]
      wfrac_reg_0_1 <= 24'h0; // @[FPArithmetic.scala 72:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wfrac_reg_0_1 <= whole_frac_1; // @[FPArithmetic.scala 191:20]
    end
    if (reset) begin // @[FPArithmetic.scala 72:28]
      wfrac_reg_1_0 <= 24'h0; // @[FPArithmetic.scala 72:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wfrac_reg_1_0 <= wfrac_reg_0_0; // @[FPArithmetic.scala 239:24]
    end
    if (reset) begin // @[FPArithmetic.scala 72:28]
      wfrac_reg_1_1 <= 24'h0; // @[FPArithmetic.scala 72:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wfrac_reg_1_1 <= wfrac_reg_0_1; // @[FPArithmetic.scala 239:24]
    end
    if (reset) begin // @[FPArithmetic.scala 72:28]
      wfrac_reg_2_0 <= 24'h0; // @[FPArithmetic.scala 72:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wfrac_reg_2_0 <= wfrac_reg_1_0; // @[FPArithmetic.scala 239:24]
    end
    if (reset) begin // @[FPArithmetic.scala 72:28]
      wfrac_reg_2_1 <= 24'h0; // @[FPArithmetic.scala 72:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wfrac_reg_2_1 <= wfrac_reg_1_1; // @[FPArithmetic.scala 239:24]
    end
    if (reset) begin // @[FPArithmetic.scala 74:35]
      subber_out_s_reg_0 <= 8'h0; // @[FPArithmetic.scala 74:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      subber_out_s_reg_0 <= subber_io_out_s; // @[FPArithmetic.scala 193:27]
    end
    if (reset) begin // @[FPArithmetic.scala 74:35]
      subber_out_s_reg_1 <= 8'h0; // @[FPArithmetic.scala 74:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      subber_out_s_reg_1 <= subber_out_s_reg_0; // @[FPArithmetic.scala 242:31]
    end
    if (reset) begin // @[FPArithmetic.scala 75:35]
      subber_out_c_reg_0 <= 1'h0; // @[FPArithmetic.scala 75:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      subber_out_c_reg_0 <= subber_io_out_c; // @[FPArithmetic.scala 194:27]
    end
    if (reset) begin // @[FPArithmetic.scala 75:35]
      subber_out_c_reg_1 <= 1'h0; // @[FPArithmetic.scala 75:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      subber_out_c_reg_1 <= subber_out_c_reg_0; // @[FPArithmetic.scala 243:31]
    end
    if (reset) begin // @[FPArithmetic.scala 77:39]
      wire_temp_add_in_reg_0_0 <= 24'h0; // @[FPArithmetic.scala 77:39]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (subber_out_c_reg_1) begin // @[FPArithmetic.scala 127:39]
        wire_temp_add_in_reg_0_0 <= _wire_temp_add_in_0_T; // @[FPArithmetic.scala 132:27]
      end else begin
        wire_temp_add_in_reg_0_0 <= wfrac_reg_2_0; // @[FPArithmetic.scala 139:27]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 77:39]
      wire_temp_add_in_reg_0_1 <= 24'h0; // @[FPArithmetic.scala 77:39]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (subber_out_c_reg_1) begin // @[FPArithmetic.scala 127:39]
        wire_temp_add_in_reg_0_1 <= wfrac_reg_2_1; // @[FPArithmetic.scala 133:27]
      end else begin
        wire_temp_add_in_reg_0_1 <= _wire_temp_add_in_1_T; // @[FPArithmetic.scala 140:27]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 77:39]
      wire_temp_add_in_reg_1_0 <= 24'h0; // @[FPArithmetic.scala 77:39]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wire_temp_add_in_reg_1_0 <= wire_temp_add_in_reg_0_0; // @[FPArithmetic.scala 245:35]
    end
    if (reset) begin // @[FPArithmetic.scala 77:39]
      wire_temp_add_in_reg_1_1 <= 24'h0; // @[FPArithmetic.scala 77:39]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wire_temp_add_in_reg_1_1 <= wire_temp_add_in_reg_0_1; // @[FPArithmetic.scala 245:35]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_0 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (subber_out_c_reg_1) begin // @[FPArithmetic.scala 127:39]
        ref_s_reg_0 <= sign_reg_2_1; // @[FPArithmetic.scala 130:13]
      end else begin
        ref_s_reg_0 <= sign_reg_2_0; // @[FPArithmetic.scala 137:13]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_1 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_1 <= ref_s_reg_0; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_2 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_2 <= ref_s_reg_1; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_3 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_3 <= ref_s_reg_2; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_4 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_4 <= ref_s_reg_3; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_5 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_5 <= ref_s_reg_4; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_6 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_6 <= ref_s_reg_5; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_7 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_7 <= ref_s_reg_6; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_0 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (subber_out_c_reg_1) begin // @[FPArithmetic.scala 127:39]
        ref_frac_reg_0 <= frac_reg_2_1; // @[FPArithmetic.scala 131:16]
      end else begin
        ref_frac_reg_0 <= frac_reg_2_0; // @[FPArithmetic.scala 138:16]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_1 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_1 <= ref_frac_reg_0; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_2 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_2 <= ref_frac_reg_1; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_3 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_3 <= ref_frac_reg_2; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_4 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_4 <= ref_frac_reg_3; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_5 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_5 <= ref_frac_reg_4; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_6 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_6 <= ref_frac_reg_5; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_7 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_7 <= ref_frac_reg_6; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_0 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (subber_out_c_reg_1) begin // @[FPArithmetic.scala 127:39]
        ref_exp_reg_0 <= exp_reg_2_1; // @[FPArithmetic.scala 128:15]
      end else begin
        ref_exp_reg_0 <= exp_reg_2_0; // @[FPArithmetic.scala 135:15]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_1 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_1 <= ref_exp_reg_0; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_2 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_2 <= ref_exp_reg_1; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_3 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_3 <= ref_exp_reg_2; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_4 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_4 <= ref_exp_reg_3; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_5 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_5 <= ref_exp_reg_4; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_6 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_6 <= ref_exp_reg_5; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_7 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_7 <= ref_exp_reg_6; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_0 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (subber_out_c_reg_1) begin // @[FPArithmetic.scala 127:39]
        sub_exp_reg_0 <= cmpl_subber_out_s_reg_0; // @[FPArithmetic.scala 129:15]
      end else begin
        sub_exp_reg_0 <= subber_out_s_reg_1; // @[FPArithmetic.scala 136:15]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_1 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_1 <= sub_exp_reg_0; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_2 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_2 <= sub_exp_reg_1; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_3 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_3 <= sub_exp_reg_2; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_4 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_4 <= sub_exp_reg_3; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_5 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_5 <= sub_exp_reg_4; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_6 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_6 <= sub_exp_reg_5; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_7 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_7 <= sub_exp_reg_6; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 84:37]
      adder_io_out_s_reg_0 <= 24'h0; // @[FPArithmetic.scala 84:37]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      adder_io_out_s_reg_0 <= adder_io_out_s; // @[FPArithmetic.scala 207:29]
    end
    if (reset) begin // @[FPArithmetic.scala 84:37]
      adder_io_out_s_reg_1 <= 24'h0; // @[FPArithmetic.scala 84:37]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      adder_io_out_s_reg_1 <= adder_io_out_s_reg_0; // @[FPArithmetic.scala 236:33]
    end
    if (reset) begin // @[FPArithmetic.scala 84:37]
      adder_io_out_s_reg_2 <= 24'h0; // @[FPArithmetic.scala 84:37]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      adder_io_out_s_reg_2 <= adder_io_out_s_reg_1; // @[FPArithmetic.scala 236:33]
    end
    if (reset) begin // @[FPArithmetic.scala 85:37]
      adder_io_out_c_reg_0 <= 1'h0; // @[FPArithmetic.scala 85:37]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      adder_io_out_c_reg_0 <= adder_io_out_c; // @[FPArithmetic.scala 208:29]
    end
    if (reset) begin // @[FPArithmetic.scala 87:35]
      new_s_reg_0 <= 1'h0; // @[FPArithmetic.scala 87:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      new_s_reg_0 <= new_s; // @[FPArithmetic.scala 203:20]
    end
    if (reset) begin // @[FPArithmetic.scala 87:35]
      new_s_reg_1 <= 1'h0; // @[FPArithmetic.scala 87:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      new_s_reg_1 <= new_s_reg_0; // @[FPArithmetic.scala 232:24]
    end
    if (reset) begin // @[FPArithmetic.scala 87:35]
      new_s_reg_2 <= 1'h0; // @[FPArithmetic.scala 87:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      new_s_reg_2 <= new_s_reg_1; // @[FPArithmetic.scala 232:24]
    end
    if (reset) begin // @[FPArithmetic.scala 87:35]
      new_s_reg_3 <= 1'h0; // @[FPArithmetic.scala 87:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      new_s_reg_3 <= new_s_reg_2; // @[FPArithmetic.scala 232:24]
    end
    if (reset) begin // @[FPArithmetic.scala 87:35]
      new_s_reg_4 <= 1'h0; // @[FPArithmetic.scala 87:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      new_s_reg_4 <= new_s_reg_3; // @[FPArithmetic.scala 232:24]
    end
    if (reset) begin // @[FPArithmetic.scala 87:35]
      new_s_reg_5 <= 1'h0; // @[FPArithmetic.scala 87:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 251:20]
      if (io_in_a_reg_10[30:0] == 31'h0 & io_in_b_reg_10[30:0] == 31'h0) begin // @[FPArithmetic.scala 252:86]
        new_s_reg_5 <= 1'h0; // @[FPArithmetic.scala 253:22]
      end else if (sub_exp_reg_7 >= 8'h17) begin // @[FPArithmetic.scala 256:48]
        new_s_reg_5 <= ref_s_reg_7; // @[FPArithmetic.scala 257:22]
      end else begin
        new_s_reg_5 <= _GEN_154;
      end
    end
    new_out_frac_reg_0 <= _GEN_170[22:0]; // @[FPArithmetic.scala 88:{35,35}]
    new_out_exp_reg_0 <= _GEN_171[7:0]; // @[FPArithmetic.scala 89:{35,35}]
    if (reset) begin // @[FPArithmetic.scala 90:24]
      E_reg_0 <= 1'h0; // @[FPArithmetic.scala 90:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      E_reg_0 <= E; // @[FPArithmetic.scala 204:16]
    end
    if (reset) begin // @[FPArithmetic.scala 90:24]
      E_reg_1 <= 1'h0; // @[FPArithmetic.scala 90:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      E_reg_1 <= E_reg_0; // @[FPArithmetic.scala 230:20]
    end
    if (reset) begin // @[FPArithmetic.scala 90:24]
      E_reg_2 <= 1'h0; // @[FPArithmetic.scala 90:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      E_reg_2 <= E_reg_1; // @[FPArithmetic.scala 230:20]
    end
    if (reset) begin // @[FPArithmetic.scala 90:24]
      E_reg_3 <= 1'h0; // @[FPArithmetic.scala 90:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      E_reg_3 <= E_reg_2; // @[FPArithmetic.scala 230:20]
    end
    if (reset) begin // @[FPArithmetic.scala 90:24]
      E_reg_4 <= 1'h0; // @[FPArithmetic.scala 90:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      E_reg_4 <= E_reg_3; // @[FPArithmetic.scala 230:20]
    end
    if (reset) begin // @[FPArithmetic.scala 91:24]
      D_reg_0 <= 1'h0; // @[FPArithmetic.scala 91:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      D_reg_0 <= D; // @[FPArithmetic.scala 205:16]
    end
    if (reset) begin // @[FPArithmetic.scala 91:24]
      D_reg_1 <= 1'h0; // @[FPArithmetic.scala 91:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      D_reg_1 <= D_reg_0; // @[FPArithmetic.scala 231:20]
    end
    if (reset) begin // @[FPArithmetic.scala 91:24]
      D_reg_2 <= 1'h0; // @[FPArithmetic.scala 91:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      D_reg_2 <= D_reg_1; // @[FPArithmetic.scala 231:20]
    end
    if (reset) begin // @[FPArithmetic.scala 91:24]
      D_reg_3 <= 1'h0; // @[FPArithmetic.scala 91:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      D_reg_3 <= D_reg_2; // @[FPArithmetic.scala 231:20]
    end
    if (reset) begin // @[FPArithmetic.scala 91:24]
      D_reg_4 <= 1'h0; // @[FPArithmetic.scala 91:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      D_reg_4 <= D_reg_3; // @[FPArithmetic.scala 231:20]
    end
    if (reset) begin // @[FPArithmetic.scala 93:35]
      adder_result_reg_0 <= 24'h0; // @[FPArithmetic.scala 93:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (new_s_reg_1 & ^_adder_result_T) begin // @[FPArithmetic.scala 174:24]
        adder_result_reg_0 <= cmpl_adder_io_out_s_reg_0;
      end else begin
        adder_result_reg_0 <= adder_io_out_s_reg_2;
      end
    end
    if (reset) begin // @[FPArithmetic.scala 93:35]
      adder_result_reg_1 <= 24'h0; // @[FPArithmetic.scala 93:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      adder_result_reg_1 <= adder_result_reg_0; // @[FPArithmetic.scala 235:31]
    end
    if (reset) begin // @[FPArithmetic.scala 93:35]
      adder_result_reg_2 <= 24'h0; // @[FPArithmetic.scala 93:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      adder_result_reg_2 <= adder_result_reg_1; // @[FPArithmetic.scala 235:31]
    end
    if (reset) begin // @[FPArithmetic.scala 95:33]
      leadingOne_reg_0 <= 6'h0; // @[FPArithmetic.scala 95:33]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      leadingOne_reg_0 <= leadingOne; // @[FPArithmetic.scala 212:25]
    end
    if (reset) begin // @[FPArithmetic.scala 95:33]
      leadingOne_reg_1 <= 6'h0; // @[FPArithmetic.scala 95:33]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      leadingOne_reg_1 <= leadingOne_reg_0; // @[FPArithmetic.scala 244:29]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_0 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_0 <= io_in_a; // @[FPArithmetic.scala 185:22]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_1 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_1 <= io_in_a_reg_0; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_2 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_2 <= io_in_a_reg_1; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_3 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_3 <= io_in_a_reg_2; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_4 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_4 <= io_in_a_reg_3; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_5 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_5 <= io_in_a_reg_4; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_6 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_6 <= io_in_a_reg_5; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_7 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_7 <= io_in_a_reg_6; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_8 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_8 <= io_in_a_reg_7; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_9 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_9 <= io_in_a_reg_8; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_10 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_10 <= io_in_a_reg_9; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_0 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_0 <= io_in_b; // @[FPArithmetic.scala 186:22]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_1 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_1 <= io_in_b_reg_0; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_2 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_2 <= io_in_b_reg_1; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_3 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_3 <= io_in_b_reg_2; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_4 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_4 <= io_in_b_reg_3; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_5 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_5 <= io_in_b_reg_4; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_6 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_6 <= io_in_b_reg_5; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_7 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_7 <= io_in_b_reg_6; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_8 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_8 <= io_in_b_reg_7; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_9 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_9 <= io_in_b_reg_8; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_10 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_10 <= io_in_b_reg_9; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 100:36]
      subber2_out_s_reg_0 <= 8'h0; // @[FPArithmetic.scala 100:36]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      subber2_out_s_reg_0 <= subber2_io_out_s; // @[FPArithmetic.scala 214:28]
    end
    if (reset) begin // @[FPArithmetic.scala 101:36]
      subber2_out_c_reg_0 <= 1'h0; // @[FPArithmetic.scala 101:36]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      subber2_out_c_reg_0 <= subber2_io_out_c; // @[FPArithmetic.scala 215:28]
    end
    if (reset) begin // @[FPArithmetic.scala 122:40]
      cmpl_subber_out_s_reg_0 <= 8'h0; // @[FPArithmetic.scala 122:40]
    end else if (io_in_en) begin // @[FPArithmetic.scala 123:19]
      cmpl_subber_out_s_reg_0 <= _cmpl_subber_out_s_reg_0_T_2; // @[FPArithmetic.scala 124:32]
    end
    if (reset) begin // @[FPArithmetic.scala 143:44]
      cmpl_wire_temp_add_in_reg_0_0 <= 24'h0; // @[FPArithmetic.scala 143:44]
    end else if (io_in_en) begin // @[FPArithmetic.scala 144:19]
      cmpl_wire_temp_add_in_reg_0_0 <= _cmpl_wire_temp_add_in_reg_0_0_T_2; // @[FPArithmetic.scala 145:39]
    end
    if (reset) begin // @[FPArithmetic.scala 143:44]
      cmpl_wire_temp_add_in_reg_0_1 <= 24'h0; // @[FPArithmetic.scala 143:44]
    end else if (io_in_en) begin // @[FPArithmetic.scala 144:19]
      cmpl_wire_temp_add_in_reg_0_1 <= _cmpl_wire_temp_add_in_reg_0_1_T_2; // @[FPArithmetic.scala 146:39]
    end
    if (reset) begin // @[FPArithmetic.scala 167:42]
      cmpl_adder_io_out_s_reg_0 <= 24'h0; // @[FPArithmetic.scala 167:42]
    end else if (io_in_en) begin // @[FPArithmetic.scala 169:19]
      cmpl_adder_io_out_s_reg_0 <= _cmpl_adder_io_out_s_reg_0_T_2; // @[FPArithmetic.scala 170:34]
    end
    if (reset) begin // @[FPArithmetic.scala 249:28]
      reg_out_s <= 32'h0; // @[FPArithmetic.scala 249:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 251:20]
      reg_out_s <= _reg_out_s_T_1; // @[FPArithmetic.scala 288:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sign_reg_0_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  sign_reg_0_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  sign_reg_1_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  sign_reg_1_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  sign_reg_2_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  sign_reg_2_1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  sign_reg_3_0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  sign_reg_3_1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  sign_reg_4_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  sign_reg_4_1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sign_reg_5_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  sign_reg_5_1 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sign_reg_6_0 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  sign_reg_6_1 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sign_reg_7_0 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  sign_reg_7_1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  sign_reg_8_0 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sign_reg_8_1 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  sign_reg_9_0 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  sign_reg_9_1 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  sign_reg_10_0 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  sign_reg_10_1 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  exp_reg_0_0 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  exp_reg_0_1 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  exp_reg_1_0 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  exp_reg_1_1 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  exp_reg_2_0 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  exp_reg_2_1 = _RAND_27[7:0];
  _RAND_28 = {1{`RANDOM}};
  frac_reg_0_0 = _RAND_28[22:0];
  _RAND_29 = {1{`RANDOM}};
  frac_reg_0_1 = _RAND_29[22:0];
  _RAND_30 = {1{`RANDOM}};
  frac_reg_1_0 = _RAND_30[22:0];
  _RAND_31 = {1{`RANDOM}};
  frac_reg_1_1 = _RAND_31[22:0];
  _RAND_32 = {1{`RANDOM}};
  frac_reg_2_0 = _RAND_32[22:0];
  _RAND_33 = {1{`RANDOM}};
  frac_reg_2_1 = _RAND_33[22:0];
  _RAND_34 = {1{`RANDOM}};
  wfrac_reg_0_0 = _RAND_34[23:0];
  _RAND_35 = {1{`RANDOM}};
  wfrac_reg_0_1 = _RAND_35[23:0];
  _RAND_36 = {1{`RANDOM}};
  wfrac_reg_1_0 = _RAND_36[23:0];
  _RAND_37 = {1{`RANDOM}};
  wfrac_reg_1_1 = _RAND_37[23:0];
  _RAND_38 = {1{`RANDOM}};
  wfrac_reg_2_0 = _RAND_38[23:0];
  _RAND_39 = {1{`RANDOM}};
  wfrac_reg_2_1 = _RAND_39[23:0];
  _RAND_40 = {1{`RANDOM}};
  subber_out_s_reg_0 = _RAND_40[7:0];
  _RAND_41 = {1{`RANDOM}};
  subber_out_s_reg_1 = _RAND_41[7:0];
  _RAND_42 = {1{`RANDOM}};
  subber_out_c_reg_0 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  subber_out_c_reg_1 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  wire_temp_add_in_reg_0_0 = _RAND_44[23:0];
  _RAND_45 = {1{`RANDOM}};
  wire_temp_add_in_reg_0_1 = _RAND_45[23:0];
  _RAND_46 = {1{`RANDOM}};
  wire_temp_add_in_reg_1_0 = _RAND_46[23:0];
  _RAND_47 = {1{`RANDOM}};
  wire_temp_add_in_reg_1_1 = _RAND_47[23:0];
  _RAND_48 = {1{`RANDOM}};
  ref_s_reg_0 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  ref_s_reg_1 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  ref_s_reg_2 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  ref_s_reg_3 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  ref_s_reg_4 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  ref_s_reg_5 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  ref_s_reg_6 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  ref_s_reg_7 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  ref_frac_reg_0 = _RAND_56[22:0];
  _RAND_57 = {1{`RANDOM}};
  ref_frac_reg_1 = _RAND_57[22:0];
  _RAND_58 = {1{`RANDOM}};
  ref_frac_reg_2 = _RAND_58[22:0];
  _RAND_59 = {1{`RANDOM}};
  ref_frac_reg_3 = _RAND_59[22:0];
  _RAND_60 = {1{`RANDOM}};
  ref_frac_reg_4 = _RAND_60[22:0];
  _RAND_61 = {1{`RANDOM}};
  ref_frac_reg_5 = _RAND_61[22:0];
  _RAND_62 = {1{`RANDOM}};
  ref_frac_reg_6 = _RAND_62[22:0];
  _RAND_63 = {1{`RANDOM}};
  ref_frac_reg_7 = _RAND_63[22:0];
  _RAND_64 = {1{`RANDOM}};
  ref_exp_reg_0 = _RAND_64[7:0];
  _RAND_65 = {1{`RANDOM}};
  ref_exp_reg_1 = _RAND_65[7:0];
  _RAND_66 = {1{`RANDOM}};
  ref_exp_reg_2 = _RAND_66[7:0];
  _RAND_67 = {1{`RANDOM}};
  ref_exp_reg_3 = _RAND_67[7:0];
  _RAND_68 = {1{`RANDOM}};
  ref_exp_reg_4 = _RAND_68[7:0];
  _RAND_69 = {1{`RANDOM}};
  ref_exp_reg_5 = _RAND_69[7:0];
  _RAND_70 = {1{`RANDOM}};
  ref_exp_reg_6 = _RAND_70[7:0];
  _RAND_71 = {1{`RANDOM}};
  ref_exp_reg_7 = _RAND_71[7:0];
  _RAND_72 = {1{`RANDOM}};
  sub_exp_reg_0 = _RAND_72[7:0];
  _RAND_73 = {1{`RANDOM}};
  sub_exp_reg_1 = _RAND_73[7:0];
  _RAND_74 = {1{`RANDOM}};
  sub_exp_reg_2 = _RAND_74[7:0];
  _RAND_75 = {1{`RANDOM}};
  sub_exp_reg_3 = _RAND_75[7:0];
  _RAND_76 = {1{`RANDOM}};
  sub_exp_reg_4 = _RAND_76[7:0];
  _RAND_77 = {1{`RANDOM}};
  sub_exp_reg_5 = _RAND_77[7:0];
  _RAND_78 = {1{`RANDOM}};
  sub_exp_reg_6 = _RAND_78[7:0];
  _RAND_79 = {1{`RANDOM}};
  sub_exp_reg_7 = _RAND_79[7:0];
  _RAND_80 = {1{`RANDOM}};
  adder_io_out_s_reg_0 = _RAND_80[23:0];
  _RAND_81 = {1{`RANDOM}};
  adder_io_out_s_reg_1 = _RAND_81[23:0];
  _RAND_82 = {1{`RANDOM}};
  adder_io_out_s_reg_2 = _RAND_82[23:0];
  _RAND_83 = {1{`RANDOM}};
  adder_io_out_c_reg_0 = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  new_s_reg_0 = _RAND_84[0:0];
  _RAND_85 = {1{`RANDOM}};
  new_s_reg_1 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  new_s_reg_2 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  new_s_reg_3 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  new_s_reg_4 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  new_s_reg_5 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  new_out_frac_reg_0 = _RAND_90[22:0];
  _RAND_91 = {1{`RANDOM}};
  new_out_exp_reg_0 = _RAND_91[7:0];
  _RAND_92 = {1{`RANDOM}};
  E_reg_0 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  E_reg_1 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  E_reg_2 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  E_reg_3 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  E_reg_4 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  D_reg_0 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  D_reg_1 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  D_reg_2 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  D_reg_3 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  D_reg_4 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  adder_result_reg_0 = _RAND_102[23:0];
  _RAND_103 = {1{`RANDOM}};
  adder_result_reg_1 = _RAND_103[23:0];
  _RAND_104 = {1{`RANDOM}};
  adder_result_reg_2 = _RAND_104[23:0];
  _RAND_105 = {1{`RANDOM}};
  leadingOne_reg_0 = _RAND_105[5:0];
  _RAND_106 = {1{`RANDOM}};
  leadingOne_reg_1 = _RAND_106[5:0];
  _RAND_107 = {1{`RANDOM}};
  io_in_a_reg_0 = _RAND_107[31:0];
  _RAND_108 = {1{`RANDOM}};
  io_in_a_reg_1 = _RAND_108[31:0];
  _RAND_109 = {1{`RANDOM}};
  io_in_a_reg_2 = _RAND_109[31:0];
  _RAND_110 = {1{`RANDOM}};
  io_in_a_reg_3 = _RAND_110[31:0];
  _RAND_111 = {1{`RANDOM}};
  io_in_a_reg_4 = _RAND_111[31:0];
  _RAND_112 = {1{`RANDOM}};
  io_in_a_reg_5 = _RAND_112[31:0];
  _RAND_113 = {1{`RANDOM}};
  io_in_a_reg_6 = _RAND_113[31:0];
  _RAND_114 = {1{`RANDOM}};
  io_in_a_reg_7 = _RAND_114[31:0];
  _RAND_115 = {1{`RANDOM}};
  io_in_a_reg_8 = _RAND_115[31:0];
  _RAND_116 = {1{`RANDOM}};
  io_in_a_reg_9 = _RAND_116[31:0];
  _RAND_117 = {1{`RANDOM}};
  io_in_a_reg_10 = _RAND_117[31:0];
  _RAND_118 = {1{`RANDOM}};
  io_in_b_reg_0 = _RAND_118[31:0];
  _RAND_119 = {1{`RANDOM}};
  io_in_b_reg_1 = _RAND_119[31:0];
  _RAND_120 = {1{`RANDOM}};
  io_in_b_reg_2 = _RAND_120[31:0];
  _RAND_121 = {1{`RANDOM}};
  io_in_b_reg_3 = _RAND_121[31:0];
  _RAND_122 = {1{`RANDOM}};
  io_in_b_reg_4 = _RAND_122[31:0];
  _RAND_123 = {1{`RANDOM}};
  io_in_b_reg_5 = _RAND_123[31:0];
  _RAND_124 = {1{`RANDOM}};
  io_in_b_reg_6 = _RAND_124[31:0];
  _RAND_125 = {1{`RANDOM}};
  io_in_b_reg_7 = _RAND_125[31:0];
  _RAND_126 = {1{`RANDOM}};
  io_in_b_reg_8 = _RAND_126[31:0];
  _RAND_127 = {1{`RANDOM}};
  io_in_b_reg_9 = _RAND_127[31:0];
  _RAND_128 = {1{`RANDOM}};
  io_in_b_reg_10 = _RAND_128[31:0];
  _RAND_129 = {1{`RANDOM}};
  subber2_out_s_reg_0 = _RAND_129[7:0];
  _RAND_130 = {1{`RANDOM}};
  subber2_out_c_reg_0 = _RAND_130[0:0];
  _RAND_131 = {1{`RANDOM}};
  cmpl_subber_out_s_reg_0 = _RAND_131[7:0];
  _RAND_132 = {1{`RANDOM}};
  cmpl_wire_temp_add_in_reg_0_0 = _RAND_132[23:0];
  _RAND_133 = {1{`RANDOM}};
  cmpl_wire_temp_add_in_reg_0_1 = _RAND_133[23:0];
  _RAND_134 = {1{`RANDOM}};
  cmpl_adder_io_out_s_reg_0 = _RAND_134[23:0];
  _RAND_135 = {1{`RANDOM}};
  reg_out_s = _RAND_135[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FPComplexAdder_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a_Re,
  input  [31:0] io_in_a_Im,
  input  [31:0] io_in_b_Re,
  input  [31:0] io_in_b_Im,
  output [31:0] io_out_s_Re,
  output [31:0] io_out_s_Im
);
  wire  FP_adder_bw32_clock; // @[FPComplex.scala 42:25]
  wire  FP_adder_bw32_reset; // @[FPComplex.scala 42:25]
  wire  FP_adder_bw32_io_in_en; // @[FPComplex.scala 42:25]
  wire [31:0] FP_adder_bw32_io_in_a; // @[FPComplex.scala 42:25]
  wire [31:0] FP_adder_bw32_io_in_b; // @[FPComplex.scala 42:25]
  wire [31:0] FP_adder_bw32_io_out_s; // @[FPComplex.scala 42:25]
  wire  FP_adder_bw32_1_clock; // @[FPComplex.scala 42:25]
  wire  FP_adder_bw32_1_reset; // @[FPComplex.scala 42:25]
  wire  FP_adder_bw32_1_io_in_en; // @[FPComplex.scala 42:25]
  wire [31:0] FP_adder_bw32_1_io_in_a; // @[FPComplex.scala 42:25]
  wire [31:0] FP_adder_bw32_1_io_in_b; // @[FPComplex.scala 42:25]
  wire [31:0] FP_adder_bw32_1_io_out_s; // @[FPComplex.scala 42:25]
  FP_adder_bw32 FP_adder_bw32 ( // @[FPComplex.scala 42:25]
    .clock(FP_adder_bw32_clock),
    .reset(FP_adder_bw32_reset),
    .io_in_en(FP_adder_bw32_io_in_en),
    .io_in_a(FP_adder_bw32_io_in_a),
    .io_in_b(FP_adder_bw32_io_in_b),
    .io_out_s(FP_adder_bw32_io_out_s)
  );
  FP_adder_bw32 FP_adder_bw32_1 ( // @[FPComplex.scala 42:25]
    .clock(FP_adder_bw32_1_clock),
    .reset(FP_adder_bw32_1_reset),
    .io_in_en(FP_adder_bw32_1_io_in_en),
    .io_in_a(FP_adder_bw32_1_io_in_a),
    .io_in_b(FP_adder_bw32_1_io_in_b),
    .io_out_s(FP_adder_bw32_1_io_out_s)
  );
  assign io_out_s_Re = FP_adder_bw32_io_out_s; // @[FPComplex.scala 51:17]
  assign io_out_s_Im = FP_adder_bw32_1_io_out_s; // @[FPComplex.scala 52:17]
  assign FP_adder_bw32_clock = clock;
  assign FP_adder_bw32_reset = reset;
  assign FP_adder_bw32_io_in_en = io_in_en; // @[FPComplex.scala 45:24]
  assign FP_adder_bw32_io_in_a = io_in_a_Re; // @[FPComplex.scala 47:23]
  assign FP_adder_bw32_io_in_b = io_in_b_Re; // @[FPComplex.scala 48:23]
  assign FP_adder_bw32_1_clock = clock;
  assign FP_adder_bw32_1_reset = reset;
  assign FP_adder_bw32_1_io_in_en = io_in_en; // @[FPComplex.scala 46:24]
  assign FP_adder_bw32_1_io_in_a = io_in_a_Im; // @[FPComplex.scala 49:23]
  assign FP_adder_bw32_1_io_in_b = io_in_b_Im; // @[FPComplex.scala 50:23]
endmodule
module FP_subtractor_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
);
  wire  FP_adder_clock; // @[FPArithmetic.scala 302:26]
  wire  FP_adder_reset; // @[FPArithmetic.scala 302:26]
  wire  FP_adder_io_in_en; // @[FPArithmetic.scala 302:26]
  wire [31:0] FP_adder_io_in_a; // @[FPArithmetic.scala 302:26]
  wire [31:0] FP_adder_io_in_b; // @[FPArithmetic.scala 302:26]
  wire [31:0] FP_adder_io_out_s; // @[FPArithmetic.scala 302:26]
  wire  _adjusted_in_b_T_1 = ~io_in_b[31]; // @[FPArithmetic.scala 304:23]
  FP_adder_bw32 FP_adder ( // @[FPArithmetic.scala 302:26]
    .clock(FP_adder_clock),
    .reset(FP_adder_reset),
    .io_in_en(FP_adder_io_in_en),
    .io_in_a(FP_adder_io_in_a),
    .io_in_b(FP_adder_io_in_b),
    .io_out_s(FP_adder_io_out_s)
  );
  assign io_out_s = FP_adder_io_out_s; // @[FPArithmetic.scala 308:14]
  assign FP_adder_clock = clock;
  assign FP_adder_reset = reset;
  assign FP_adder_io_in_en = io_in_en; // @[FPArithmetic.scala 305:23]
  assign FP_adder_io_in_a = io_in_a; // @[FPArithmetic.scala 306:22]
  assign FP_adder_io_in_b = {_adjusted_in_b_T_1,io_in_b[30:0]}; // @[FPArithmetic.scala 304:41]
endmodule
module FPComplexSubtractor_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a_Re,
  input  [31:0] io_in_a_Im,
  input  [31:0] io_in_b_Re,
  input  [31:0] io_in_b_Im,
  output [31:0] io_out_s_Re,
  output [31:0] io_out_s_Im
);
  wire  FP_subtractor_bw32_clock; // @[FPComplex.scala 112:25]
  wire  FP_subtractor_bw32_reset; // @[FPComplex.scala 112:25]
  wire  FP_subtractor_bw32_io_in_en; // @[FPComplex.scala 112:25]
  wire [31:0] FP_subtractor_bw32_io_in_a; // @[FPComplex.scala 112:25]
  wire [31:0] FP_subtractor_bw32_io_in_b; // @[FPComplex.scala 112:25]
  wire [31:0] FP_subtractor_bw32_io_out_s; // @[FPComplex.scala 112:25]
  wire  FP_subtractor_bw32_1_clock; // @[FPComplex.scala 112:25]
  wire  FP_subtractor_bw32_1_reset; // @[FPComplex.scala 112:25]
  wire  FP_subtractor_bw32_1_io_in_en; // @[FPComplex.scala 112:25]
  wire [31:0] FP_subtractor_bw32_1_io_in_a; // @[FPComplex.scala 112:25]
  wire [31:0] FP_subtractor_bw32_1_io_in_b; // @[FPComplex.scala 112:25]
  wire [31:0] FP_subtractor_bw32_1_io_out_s; // @[FPComplex.scala 112:25]
  FP_subtractor_bw32 FP_subtractor_bw32 ( // @[FPComplex.scala 112:25]
    .clock(FP_subtractor_bw32_clock),
    .reset(FP_subtractor_bw32_reset),
    .io_in_en(FP_subtractor_bw32_io_in_en),
    .io_in_a(FP_subtractor_bw32_io_in_a),
    .io_in_b(FP_subtractor_bw32_io_in_b),
    .io_out_s(FP_subtractor_bw32_io_out_s)
  );
  FP_subtractor_bw32 FP_subtractor_bw32_1 ( // @[FPComplex.scala 112:25]
    .clock(FP_subtractor_bw32_1_clock),
    .reset(FP_subtractor_bw32_1_reset),
    .io_in_en(FP_subtractor_bw32_1_io_in_en),
    .io_in_a(FP_subtractor_bw32_1_io_in_a),
    .io_in_b(FP_subtractor_bw32_1_io_in_b),
    .io_out_s(FP_subtractor_bw32_1_io_out_s)
  );
  assign io_out_s_Re = FP_subtractor_bw32_io_out_s; // @[FPComplex.scala 121:17]
  assign io_out_s_Im = FP_subtractor_bw32_1_io_out_s; // @[FPComplex.scala 122:17]
  assign FP_subtractor_bw32_clock = clock;
  assign FP_subtractor_bw32_reset = reset;
  assign FP_subtractor_bw32_io_in_en = io_in_en; // @[FPComplex.scala 115:25]
  assign FP_subtractor_bw32_io_in_a = io_in_a_Re; // @[FPComplex.scala 117:24]
  assign FP_subtractor_bw32_io_in_b = io_in_b_Re; // @[FPComplex.scala 118:24]
  assign FP_subtractor_bw32_1_clock = clock;
  assign FP_subtractor_bw32_1_reset = reset;
  assign FP_subtractor_bw32_1_io_in_en = io_in_en; // @[FPComplex.scala 116:25]
  assign FP_subtractor_bw32_1_io_in_a = io_in_a_Im; // @[FPComplex.scala 119:24]
  assign FP_subtractor_bw32_1_io_in_b = io_in_b_Im; // @[FPComplex.scala 120:24]
endmodule
module DFT_SymmetryExploits_fullwidth_r2_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input         io_in_valid,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  output [31:0] io_out_0_Re,
  output [31:0] io_out_0_Im,
  output [31:0] io_out_1_Re,
  output [31:0] io_out_1_Im,
  output        io_out_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
`endif // RANDOMIZE_REG_INIT
  wire  FPComplexAdder_bw32_clock; // @[DFTDesigns.scala 70:25]
  wire  FPComplexAdder_bw32_reset; // @[DFTDesigns.scala 70:25]
  wire  FPComplexAdder_bw32_io_in_en; // @[DFTDesigns.scala 70:25]
  wire [31:0] FPComplexAdder_bw32_io_in_a_Re; // @[DFTDesigns.scala 70:25]
  wire [31:0] FPComplexAdder_bw32_io_in_a_Im; // @[DFTDesigns.scala 70:25]
  wire [31:0] FPComplexAdder_bw32_io_in_b_Re; // @[DFTDesigns.scala 70:25]
  wire [31:0] FPComplexAdder_bw32_io_in_b_Im; // @[DFTDesigns.scala 70:25]
  wire [31:0] FPComplexAdder_bw32_io_out_s_Re; // @[DFTDesigns.scala 70:25]
  wire [31:0] FPComplexAdder_bw32_io_out_s_Im; // @[DFTDesigns.scala 70:25]
  wire  FPComplexSubtractor_bw32_clock; // @[DFTDesigns.scala 71:30]
  wire  FPComplexSubtractor_bw32_reset; // @[DFTDesigns.scala 71:30]
  wire  FPComplexSubtractor_bw32_io_in_en; // @[DFTDesigns.scala 71:30]
  wire [31:0] FPComplexSubtractor_bw32_io_in_a_Re; // @[DFTDesigns.scala 71:30]
  wire [31:0] FPComplexSubtractor_bw32_io_in_a_Im; // @[DFTDesigns.scala 71:30]
  wire [31:0] FPComplexSubtractor_bw32_io_in_b_Re; // @[DFTDesigns.scala 71:30]
  wire [31:0] FPComplexSubtractor_bw32_io_in_b_Im; // @[DFTDesigns.scala 71:30]
  wire [31:0] FPComplexSubtractor_bw32_io_out_s_Re; // @[DFTDesigns.scala 71:30]
  wire [31:0] FPComplexSubtractor_bw32_io_out_s_Im; // @[DFTDesigns.scala 71:30]
  reg  shift_regs_r; // @[Reg.scala 16:16]
  reg  shift_regs_r_1; // @[Reg.scala 16:16]
  reg  shift_regs_r_2; // @[Reg.scala 16:16]
  reg  shift_regs_r_3; // @[Reg.scala 16:16]
  reg  shift_regs_r_4; // @[Reg.scala 16:16]
  reg  shift_regs_r_5; // @[Reg.scala 16:16]
  reg  shift_regs_r_6; // @[Reg.scala 16:16]
  reg  shift_regs_r_7; // @[Reg.scala 16:16]
  reg  shift_regs_r_8; // @[Reg.scala 16:16]
  reg  shift_regs_r_9; // @[Reg.scala 16:16]
  reg  shift_regs_r_10; // @[Reg.scala 16:16]
  reg  shift_regs_r_11; // @[Reg.scala 16:16]
  reg  shift_regs_r_12; // @[Reg.scala 16:16]
  reg  shift_regs; // @[Reg.scala 16:16]
  reg [31:0] sr_addout_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_addout_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_subout_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_subout_Im; // @[Reg.scala 16:16]
  FPComplexAdder_bw32 FPComplexAdder_bw32 ( // @[DFTDesigns.scala 70:25]
    .clock(FPComplexAdder_bw32_clock),
    .reset(FPComplexAdder_bw32_reset),
    .io_in_en(FPComplexAdder_bw32_io_in_en),
    .io_in_a_Re(FPComplexAdder_bw32_io_in_a_Re),
    .io_in_a_Im(FPComplexAdder_bw32_io_in_a_Im),
    .io_in_b_Re(FPComplexAdder_bw32_io_in_b_Re),
    .io_in_b_Im(FPComplexAdder_bw32_io_in_b_Im),
    .io_out_s_Re(FPComplexAdder_bw32_io_out_s_Re),
    .io_out_s_Im(FPComplexAdder_bw32_io_out_s_Im)
  );
  FPComplexSubtractor_bw32 FPComplexSubtractor_bw32 ( // @[DFTDesigns.scala 71:30]
    .clock(FPComplexSubtractor_bw32_clock),
    .reset(FPComplexSubtractor_bw32_reset),
    .io_in_en(FPComplexSubtractor_bw32_io_in_en),
    .io_in_a_Re(FPComplexSubtractor_bw32_io_in_a_Re),
    .io_in_a_Im(FPComplexSubtractor_bw32_io_in_a_Im),
    .io_in_b_Re(FPComplexSubtractor_bw32_io_in_b_Re),
    .io_in_b_Im(FPComplexSubtractor_bw32_io_in_b_Im),
    .io_out_s_Re(FPComplexSubtractor_bw32_io_out_s_Re),
    .io_out_s_Im(FPComplexSubtractor_bw32_io_out_s_Im)
  );
  assign io_out_0_Re = sr_addout_Re; // @[DFTDesigns.scala 82:17]
  assign io_out_0_Im = sr_addout_Im; // @[DFTDesigns.scala 82:17]
  assign io_out_1_Re = sr_subout_Re; // @[DFTDesigns.scala 83:17]
  assign io_out_1_Im = sr_subout_Im; // @[DFTDesigns.scala 83:17]
  assign io_out_valid = shift_regs; // @[DFTDesigns.scala 81:20]
  assign FPComplexAdder_bw32_clock = clock;
  assign FPComplexAdder_bw32_reset = reset;
  assign FPComplexAdder_bw32_io_in_en = io_in_en; // @[DFTDesigns.scala 75:19]
  assign FPComplexAdder_bw32_io_in_a_Re = io_in_0_Re; // @[DFTDesigns.scala 77:18]
  assign FPComplexAdder_bw32_io_in_a_Im = io_in_0_Im; // @[DFTDesigns.scala 77:18]
  assign FPComplexAdder_bw32_io_in_b_Re = io_in_1_Re; // @[DFTDesigns.scala 78:18]
  assign FPComplexAdder_bw32_io_in_b_Im = io_in_1_Im; // @[DFTDesigns.scala 78:18]
  assign FPComplexSubtractor_bw32_clock = clock;
  assign FPComplexSubtractor_bw32_reset = reset;
  assign FPComplexSubtractor_bw32_io_in_en = io_in_en; // @[DFTDesigns.scala 76:24]
  assign FPComplexSubtractor_bw32_io_in_a_Re = io_in_0_Re; // @[DFTDesigns.scala 79:23]
  assign FPComplexSubtractor_bw32_io_in_a_Im = io_in_0_Im; // @[DFTDesigns.scala 79:23]
  assign FPComplexSubtractor_bw32_io_in_b_Re = io_in_1_Re; // @[DFTDesigns.scala 80:23]
  assign FPComplexSubtractor_bw32_io_in_b_Im = io_in_1_Im; // @[DFTDesigns.scala 80:23]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r <= io_in_valid; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_1 <= shift_regs_r; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_2 <= shift_regs_r_1; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_3 <= shift_regs_r_2; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_4 <= shift_regs_r_3; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_5 <= shift_regs_r_4; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_6 <= shift_regs_r_5; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_7 <= shift_regs_r_6; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_8 <= shift_regs_r_7; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_9 <= shift_regs_r_8; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_10 <= shift_regs_r_9; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_11 <= shift_regs_r_10; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_12 <= shift_regs_r_11; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs <= shift_regs_r_12; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      sr_addout_Re <= FPComplexAdder_bw32_io_out_s_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      sr_addout_Im <= FPComplexAdder_bw32_io_out_s_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      sr_subout_Re <= FPComplexSubtractor_bw32_io_out_s_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      sr_subout_Im <= FPComplexSubtractor_bw32_io_out_s_Im; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  shift_regs_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  shift_regs_r_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  shift_regs_r_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  shift_regs_r_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  shift_regs_r_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  shift_regs_r_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  shift_regs_r_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  shift_regs_r_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  shift_regs_r_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  shift_regs_r_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  shift_regs_r_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  shift_regs_r_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  shift_regs_r_12 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  shift_regs = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sr_addout_Re = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  sr_addout_Im = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  sr_subout_Re = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  sr_subout_Im = _RAND_17[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module simple_RAM_depth32_bw32(
  input         clock,
  input  [4:0]  io_in_addr,
  input  [31:0] io_in_data,
  input         io_in_en,
  input         io_in_we,
  output [31:0] io_out_data
);
  blk_mem_gen_0 u_blk_mem_gen_0(
    .clka(clock),
    .addra(io_in_addr),
    .dina(io_in_data),
    .ena(io_in_en),
    .wea(io_in_we),
    .douta(io_out_data)
  );
endmodule
module RAM_n32_bw32(
  input         clock,
  input         io_in_en,
  input         io_in_valid,
  input  [31:0] io_in_data_Re,
  input  [31:0] io_in_data_Im,
  input         io_in_we,
  input  [5:0]  io_in_addr,
  output [31:0] io_out_data_Re,
  output [31:0] io_out_data_Im
);
  wire  simple_RAM_depth32_bw32_clock; // @[PermutationDesigns.scala 1356:36]
  wire [4:0] simple_RAM_depth32_bw32_io_in_addr; // @[PermutationDesigns.scala 1356:36]
  wire [31:0] simple_RAM_depth32_bw32_io_in_data; // @[PermutationDesigns.scala 1356:36]
  wire  simple_RAM_depth32_bw32_io_in_en; // @[PermutationDesigns.scala 1356:36]
  wire  simple_RAM_depth32_bw32_io_in_we; // @[PermutationDesigns.scala 1356:36]
  wire [31:0] simple_RAM_depth32_bw32_io_out_data; // @[PermutationDesigns.scala 1356:36]
  wire  simple_RAM_depth32_bw32_1_clock; // @[PermutationDesigns.scala 1356:36]
  wire [4:0] simple_RAM_depth32_bw32_1_io_in_addr; // @[PermutationDesigns.scala 1356:36]
  wire [31:0] simple_RAM_depth32_bw32_1_io_in_data; // @[PermutationDesigns.scala 1356:36]
  wire  simple_RAM_depth32_bw32_1_io_in_en; // @[PermutationDesigns.scala 1356:36]
  wire  simple_RAM_depth32_bw32_1_io_in_we; // @[PermutationDesigns.scala 1356:36]
  wire [31:0] simple_RAM_depth32_bw32_1_io_out_data; // @[PermutationDesigns.scala 1356:36]
  wire [31:0] _GEN_0 = io_in_valid ? io_in_data_Re : 32'h0; // @[PermutationDesigns.scala 1374:27 1375:27 1357:28]
  wire [31:0] _GEN_1 = io_in_valid ? io_in_data_Im : 32'h0; // @[PermutationDesigns.scala 1374:27 1376:27 1357:28]
  wire [5:0] _GEN_3 = io_in_valid ? io_in_addr : 6'h0; // @[PermutationDesigns.scala 1374:27 1358:28 1378:34]
  wire [31:0] _GEN_4 = io_in_we ? _GEN_0 : 32'h0; // @[PermutationDesigns.scala 1373:21 1357:28]
  wire [31:0] _GEN_5 = io_in_we ? _GEN_1 : 32'h0; // @[PermutationDesigns.scala 1373:21 1357:28]
  wire  _GEN_6 = io_in_we & io_in_valid; // @[PermutationDesigns.scala 1373:21 1384:30]
  wire [5:0] _GEN_7 = io_in_we ? _GEN_3 : io_in_addr; // @[PermutationDesigns.scala 1373:21 1385:32]
  wire [5:0] _GEN_12 = io_in_en ? _GEN_7 : 6'h0; // @[PermutationDesigns.scala 1372:19 1358:28]
  simple_RAM_depth32_bw32 simple_RAM_depth32_bw32 ( // @[PermutationDesigns.scala 1356:36]
    .clock(simple_RAM_depth32_bw32_clock),
    .io_in_addr(simple_RAM_depth32_bw32_io_in_addr),
    .io_in_data(simple_RAM_depth32_bw32_io_in_data),
    .io_in_en(simple_RAM_depth32_bw32_io_in_en),
    .io_in_we(simple_RAM_depth32_bw32_io_in_we),
    .io_out_data(simple_RAM_depth32_bw32_io_out_data)
  );
  simple_RAM_depth32_bw32 simple_RAM_depth32_bw32_1 ( // @[PermutationDesigns.scala 1356:36]
    .clock(simple_RAM_depth32_bw32_1_clock),
    .io_in_addr(simple_RAM_depth32_bw32_1_io_in_addr),
    .io_in_data(simple_RAM_depth32_bw32_1_io_in_data),
    .io_in_en(simple_RAM_depth32_bw32_1_io_in_en),
    .io_in_we(simple_RAM_depth32_bw32_1_io_in_we),
    .io_out_data(simple_RAM_depth32_bw32_1_io_out_data)
  );
  assign io_out_data_Re = simple_RAM_depth32_bw32_io_out_data; // @[PermutationDesigns.scala 1366:28 1367:21]
  assign io_out_data_Im = simple_RAM_depth32_bw32_1_io_out_data; // @[PermutationDesigns.scala 1366:28 1368:21]
  assign simple_RAM_depth32_bw32_clock = clock;
  assign simple_RAM_depth32_bw32_io_in_addr = _GEN_12[4:0];
  assign simple_RAM_depth32_bw32_io_in_data = io_in_en ? _GEN_4 : 32'h0; // @[PermutationDesigns.scala 1372:19 1357:28]
  assign simple_RAM_depth32_bw32_io_in_en = io_in_en; // @[PermutationDesigns.scala 1360:26]
  assign simple_RAM_depth32_bw32_io_in_we = io_in_en & _GEN_6; // @[PermutationDesigns.scala 1372:19 1359:26]
  assign simple_RAM_depth32_bw32_1_clock = clock;
  assign simple_RAM_depth32_bw32_1_io_in_addr = _GEN_12[4:0];
  assign simple_RAM_depth32_bw32_1_io_in_data = io_in_en ? _GEN_5 : 32'h0; // @[PermutationDesigns.scala 1372:19 1357:28]
  assign simple_RAM_depth32_bw32_1_io_in_en = io_in_en; // @[PermutationDesigns.scala 1360:26]
  assign simple_RAM_depth32_bw32_1_io_in_we = io_in_en & _GEN_6; // @[PermutationDesigns.scala 1372:19 1359:26]
endmodule
module RAM_Block_N64_w2_bw32(
  input         clock,
  input  [5:0]  io_in_raddr,
  input  [5:0]  io_in_waddr,
  input  [31:0] io_in_data_Re,
  input  [31:0] io_in_data_Im,
  input         io_in_offset_switch,
  input         io_in_valid,
  input         io_in_en,
  output [31:0] io_out_data_Re,
  output [31:0] io_out_data_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  RAM_n32_bw32_clock; // @[PermutationDesigns.scala 514:35]
  wire  RAM_n32_bw32_io_in_en; // @[PermutationDesigns.scala 514:35]
  wire  RAM_n32_bw32_io_in_valid; // @[PermutationDesigns.scala 514:35]
  wire [31:0] RAM_n32_bw32_io_in_data_Re; // @[PermutationDesigns.scala 514:35]
  wire [31:0] RAM_n32_bw32_io_in_data_Im; // @[PermutationDesigns.scala 514:35]
  wire  RAM_n32_bw32_io_in_we; // @[PermutationDesigns.scala 514:35]
  wire [5:0] RAM_n32_bw32_io_in_addr; // @[PermutationDesigns.scala 514:35]
  wire [31:0] RAM_n32_bw32_io_out_data_Re; // @[PermutationDesigns.scala 514:35]
  wire [31:0] RAM_n32_bw32_io_out_data_Im; // @[PermutationDesigns.scala 514:35]
  wire  RAM_n32_bw32_1_clock; // @[PermutationDesigns.scala 514:35]
  wire  RAM_n32_bw32_1_io_in_en; // @[PermutationDesigns.scala 514:35]
  wire  RAM_n32_bw32_1_io_in_valid; // @[PermutationDesigns.scala 514:35]
  wire [31:0] RAM_n32_bw32_1_io_in_data_Re; // @[PermutationDesigns.scala 514:35]
  wire [31:0] RAM_n32_bw32_1_io_in_data_Im; // @[PermutationDesigns.scala 514:35]
  wire  RAM_n32_bw32_1_io_in_we; // @[PermutationDesigns.scala 514:35]
  wire [5:0] RAM_n32_bw32_1_io_in_addr; // @[PermutationDesigns.scala 514:35]
  wire [31:0] RAM_n32_bw32_1_io_out_data_Re; // @[PermutationDesigns.scala 514:35]
  wire [31:0] RAM_n32_bw32_1_io_out_data_Im; // @[PermutationDesigns.scala 514:35]
  reg  offset_switch_reg; // @[Reg.scala 16:16]
  wire  _T_1 = ~io_in_offset_switch; // @[PermutationDesigns.scala 525:21]
  RAM_n32_bw32 RAM_n32_bw32 ( // @[PermutationDesigns.scala 514:35]
    .clock(RAM_n32_bw32_clock),
    .io_in_en(RAM_n32_bw32_io_in_en),
    .io_in_valid(RAM_n32_bw32_io_in_valid),
    .io_in_data_Re(RAM_n32_bw32_io_in_data_Re),
    .io_in_data_Im(RAM_n32_bw32_io_in_data_Im),
    .io_in_we(RAM_n32_bw32_io_in_we),
    .io_in_addr(RAM_n32_bw32_io_in_addr),
    .io_out_data_Re(RAM_n32_bw32_io_out_data_Re),
    .io_out_data_Im(RAM_n32_bw32_io_out_data_Im)
  );
  RAM_n32_bw32 RAM_n32_bw32_1 ( // @[PermutationDesigns.scala 514:35]
    .clock(RAM_n32_bw32_1_clock),
    .io_in_en(RAM_n32_bw32_1_io_in_en),
    .io_in_valid(RAM_n32_bw32_1_io_in_valid),
    .io_in_data_Re(RAM_n32_bw32_1_io_in_data_Re),
    .io_in_data_Im(RAM_n32_bw32_1_io_in_data_Im),
    .io_in_we(RAM_n32_bw32_1_io_in_we),
    .io_in_addr(RAM_n32_bw32_1_io_in_addr),
    .io_out_data_Re(RAM_n32_bw32_1_io_out_data_Re),
    .io_out_data_Im(RAM_n32_bw32_1_io_out_data_Im)
  );
  assign io_out_data_Re = offset_switch_reg ? RAM_n32_bw32_io_out_data_Re : RAM_n32_bw32_1_io_out_data_Re; // @[PermutationDesigns.scala 529:23]
  assign io_out_data_Im = offset_switch_reg ? RAM_n32_bw32_io_out_data_Im : RAM_n32_bw32_1_io_out_data_Im; // @[PermutationDesigns.scala 529:23]
  assign RAM_n32_bw32_clock = clock;
  assign RAM_n32_bw32_io_in_en = io_in_en; // @[PermutationDesigns.scala 522:18]
  assign RAM_n32_bw32_io_in_valid = io_in_valid; // @[PermutationDesigns.scala 523:21]
  assign RAM_n32_bw32_io_in_data_Re = io_in_data_Re; // @[PermutationDesigns.scala 526:20]
  assign RAM_n32_bw32_io_in_data_Im = io_in_data_Im; // @[PermutationDesigns.scala 526:20]
  assign RAM_n32_bw32_io_in_we = ~io_in_offset_switch; // @[PermutationDesigns.scala 525:21]
  assign RAM_n32_bw32_io_in_addr = _T_1 ? io_in_waddr : io_in_raddr; // @[PermutationDesigns.scala 527:26]
  assign RAM_n32_bw32_1_clock = clock;
  assign RAM_n32_bw32_1_io_in_en = io_in_en; // @[PermutationDesigns.scala 516:18]
  assign RAM_n32_bw32_1_io_in_valid = io_in_valid; // @[PermutationDesigns.scala 517:21]
  assign RAM_n32_bw32_1_io_in_data_Re = io_in_data_Re; // @[PermutationDesigns.scala 520:20]
  assign RAM_n32_bw32_1_io_in_data_Im = io_in_data_Im; // @[PermutationDesigns.scala 520:20]
  assign RAM_n32_bw32_1_io_in_we = io_in_offset_switch; // @[PermutationDesigns.scala 519:18]
  assign RAM_n32_bw32_1_io_in_addr = io_in_offset_switch ? io_in_waddr : io_in_raddr; // @[PermutationDesigns.scala 521:26]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      offset_switch_reg <= io_in_offset_switch; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  offset_switch_reg = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PrePermute_Config_ROM_N8_r2_base_r2_ptype1_w2(
  input  [1:0] io_in_cnt,
  output [1:0] io_out_0,
  output [1:0] io_out_1
);
  wire [1:0] _GEN_1 = 2'h1 == io_in_cnt ? 2'h1 : 2'h0; // @[PermutationDesigns.scala 430:{31,31}]
  wire [1:0] _GEN_2 = 2'h2 == io_in_cnt ? 2'h2 : _GEN_1; // @[PermutationDesigns.scala 430:{31,31}]
  wire [1:0] _GEN_5 = 2'h1 == io_in_cnt ? 2'h3 : 2'h2; // @[PermutationDesigns.scala 430:{31,31}]
  wire [1:0] _GEN_6 = 2'h2 == io_in_cnt ? 2'h0 : _GEN_5; // @[PermutationDesigns.scala 430:{31,31}]
  assign io_out_0 = 2'h3 == io_in_cnt ? 2'h3 : _GEN_2; // @[PermutationDesigns.scala 430:{31,31}]
  assign io_out_1 = 2'h3 == io_in_cnt ? 2'h1 : _GEN_6; // @[PermutationDesigns.scala 430:{31,31}]
endmodule
module Permute_Config_ROM_N8_r2_base_r2_ptype1_w2(
  input        clock,
  input        io_in_en,
  input  [1:0] io_in_cnt,
  output       io_out_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  out_reg_data_r; // @[Reg.scala 16:16]
  assign io_out_0 = out_reg_data_r; // @[PermutationDesigns.scala 494:{31,31}]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_reg_data_r <= 2'h3 == io_in_cnt | 2'h2 == io_in_cnt; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  out_reg_data_r = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Permutation_Wiring_w2_bw32(
  input         clock,
  input         io_in_valid,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  input         io_in_config_0,
  input         io_in_en,
  output        io_out_valid,
  output [31:0] io_out_0_Re,
  output [31:0] io_out_0_Im,
  output [31:0] io_out_1_Re,
  output [31:0] io_out_1_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] in_reg_0_Re; // @[Reg.scala 16:16]
  reg [31:0] in_reg_0_Im; // @[Reg.scala 16:16]
  reg [31:0] in_reg_1_Re; // @[Reg.scala 16:16]
  reg [31:0] in_reg_1_Im; // @[Reg.scala 16:16]
  reg  in_config_reg_0; // @[Reg.scala 16:16]
  reg  out_valid_reg; // @[Reg.scala 16:16]
  wire  _T = ~in_config_reg_0; // @[PermutationDesigns.scala 388:36]
  wire  pms_0 = _T ? 1'h0 : 1'h1; // @[Mux.scala 47:70]
  wire  pms_1 = in_config_reg_0 ? 1'h0 : 1'h1; // @[Mux.scala 47:70]
  assign io_out_valid = out_valid_reg; // @[PermutationDesigns.scala 400:18]
  assign io_out_0_Re = pms_0 ? in_reg_1_Re : in_reg_0_Re; // @[PermutationDesigns.scala 397:{31,31}]
  assign io_out_0_Im = pms_0 ? in_reg_1_Im : in_reg_0_Im; // @[PermutationDesigns.scala 397:{31,31}]
  assign io_out_1_Re = pms_1 ? in_reg_1_Re : in_reg_0_Re; // @[PermutationDesigns.scala 397:{31,31}]
  assign io_out_1_Im = pms_1 ? in_reg_1_Im : in_reg_0_Im; // @[PermutationDesigns.scala 397:{31,31}]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      in_reg_0_Re <= io_in_0_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      in_reg_0_Im <= io_in_0_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      in_reg_1_Re <= io_in_1_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      in_reg_1_Im <= io_in_1_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      in_config_reg_0 <= io_in_config_0; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_valid_reg <= io_in_valid; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  in_reg_0_Re = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  in_reg_0_Im = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  in_reg_1_Re = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  in_reg_1_Im = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  in_config_reg_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  out_valid_reg = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2(
  input        clock,
  input        io_in_en,
  input  [1:0] io_in_cnt,
  output [1:0] io_out_0,
  output [1:0] io_out_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] out_reg_data_r; // @[Reg.scala 16:16]
  reg [1:0] out_reg_data_r_1; // @[Reg.scala 16:16]
  assign io_out_0 = out_reg_data_r; // @[PermutationDesigns.scala 462:{31,31}]
  assign io_out_1 = out_reg_data_r_1; // @[PermutationDesigns.scala 462:{31,31}]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      if (2'h3 == io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r <= 2'h3; // @[Reg.scala 17:22]
      end else if (2'h2 == io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r <= 2'h2; // @[Reg.scala 17:22]
      end else if (2'h1 == io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r <= 2'h1; // @[Reg.scala 17:22]
      end else begin
        out_reg_data_r <= 2'h0;
      end
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      if (2'h3 == io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r_1 <= 2'h1; // @[Reg.scala 17:22]
      end else if (2'h2 == io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r_1 <= 2'h0; // @[Reg.scala 17:22]
      end else if (2'h1 == io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r_1 <= 2'h3; // @[Reg.scala 17:22]
      end else begin
        out_reg_data_r_1 <= 2'h2;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  out_reg_data_r = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  out_reg_data_r_1 = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  input         io_in_valid,
  output [31:0] io_out_0_Re,
  output [31:0] io_out_0_Im,
  output [31:0] io_out_1_Re,
  output [31:0] io_out_1_Im,
  output        io_out_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
`endif // RANDOMIZE_REG_INIT
  wire  RAM_Block_N64_w2_bw32_clock; // @[PermutationDesigns.scala 207:41]
  wire [5:0] RAM_Block_N64_w2_bw32_io_in_raddr; // @[PermutationDesigns.scala 207:41]
  wire [5:0] RAM_Block_N64_w2_bw32_io_in_waddr; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_io_in_data_Re; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_io_in_data_Im; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_io_in_offset_switch; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_io_in_valid; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_io_in_en; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_io_out_data_Re; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_io_out_data_Im; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_1_clock; // @[PermutationDesigns.scala 207:41]
  wire [5:0] RAM_Block_N64_w2_bw32_1_io_in_raddr; // @[PermutationDesigns.scala 207:41]
  wire [5:0] RAM_Block_N64_w2_bw32_1_io_in_waddr; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_1_io_in_data_Re; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_1_io_in_data_Im; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_1_io_in_offset_switch; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_1_io_in_valid; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_1_io_in_en; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_1_io_out_data_Re; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_1_io_out_data_Im; // @[PermutationDesigns.scala 207:41]
  wire [1:0] PrePermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_cnt; // @[PermutationDesigns.scala 209:25]
  wire [1:0] PrePermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_0; // @[PermutationDesigns.scala 209:25]
  wire [1:0] PrePermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_1; // @[PermutationDesigns.scala 209:25]
  wire  Permute_Config_ROM_N8_r2_base_r2_ptype1_w2_clock; // @[PermutationDesigns.scala 212:22]
  wire  Permute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_en; // @[PermutationDesigns.scala 212:22]
  wire [1:0] Permute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_cnt; // @[PermutationDesigns.scala 212:22]
  wire  Permute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_0; // @[PermutationDesigns.scala 212:22]
  wire  Permutation_Wiring_w2_bw32_clock; // @[PermutationDesigns.scala 213:24]
  wire  Permutation_Wiring_w2_bw32_io_in_valid; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_in_0_Re; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_in_0_Im; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_in_1_Re; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_in_1_Im; // @[PermutationDesigns.scala 213:24]
  wire  Permutation_Wiring_w2_bw32_io_in_config_0; // @[PermutationDesigns.scala 213:24]
  wire  Permutation_Wiring_w2_bw32_io_in_en; // @[PermutationDesigns.scala 213:24]
  wire  Permutation_Wiring_w2_bw32_io_out_valid; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_out_0_Re; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_out_0_Im; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_out_1_Re; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_out_1_Im; // @[PermutationDesigns.scala 213:24]
  wire  PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_clock; // @[PermutationDesigns.scala 219:26]
  wire  PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_en; // @[PermutationDesigns.scala 219:26]
  wire [1:0] PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_cnt; // @[PermutationDesigns.scala 219:26]
  wire [1:0] PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_0; // @[PermutationDesigns.scala 219:26]
  wire [1:0] PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_1; // @[PermutationDesigns.scala 219:26]
  wire  RAM_Block_N64_w2_bw32_2_clock; // @[PermutationDesigns.scala 220:41]
  wire [5:0] RAM_Block_N64_w2_bw32_2_io_in_raddr; // @[PermutationDesigns.scala 220:41]
  wire [5:0] RAM_Block_N64_w2_bw32_2_io_in_waddr; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_2_io_in_data_Re; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_2_io_in_data_Im; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_2_io_in_offset_switch; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_2_io_in_valid; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_2_io_in_en; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_2_io_out_data_Re; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_2_io_out_data_Im; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_3_clock; // @[PermutationDesigns.scala 220:41]
  wire [5:0] RAM_Block_N64_w2_bw32_3_io_in_raddr; // @[PermutationDesigns.scala 220:41]
  wire [5:0] RAM_Block_N64_w2_bw32_3_io_in_waddr; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_3_io_in_data_Re; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_3_io_in_data_Im; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_3_io_in_offset_switch; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_3_io_in_valid; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_3_io_in_en; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_3_io_out_data_Re; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_3_io_out_data_Im; // @[PermutationDesigns.scala 220:41]
  reg [31:0] Perm_shiftregs_data_r_Re; // @[Reg.scala 16:16]
  reg [31:0] Perm_shiftregs_data_r_Im; // @[Reg.scala 16:16]
  reg [31:0] Perm_shiftregs_data_r_1_Re; // @[Reg.scala 16:16]
  reg [31:0] Perm_shiftregs_data_r_1_Im; // @[Reg.scala 16:16]
  reg  Perm_shiftregs_valid; // @[Reg.scala 16:16]
  reg  REG; // @[PermutationDesigns.scala 222:47]
  reg  REG_1; // @[PermutationDesigns.scala 222:47]
  reg [1:0] value; // @[Counter.scala 62:40]
  reg [1:0] value_1; // @[Counter.scala 62:40]
  reg [1:0] value_2; // @[Counter.scala 62:40]
  reg [1:0] value_3; // @[Counter.scala 62:40]
  wire  _T_1 = REG & value_2 == 2'h0; // @[PermutationDesigns.scala 226:39]
  reg  r; // @[Reg.scala 16:16]
  wire  _T_3 = REG_1 & value_3 == 2'h0; // @[PermutationDesigns.scala 226:39]
  reg  r_1; // @[Reg.scala 16:16]
  reg [31:0] M0_shiftregs_data_r_Re; // @[Reg.scala 16:16]
  reg [31:0] M0_shiftregs_data_r_Im; // @[Reg.scala 16:16]
  reg [31:0] M0_shiftregs_data_r_1_Re; // @[Reg.scala 16:16]
  reg [31:0] M0_shiftregs_data_r_1_Im; // @[Reg.scala 16:16]
  reg  M0_shiftregs_valid; // @[Reg.scala 16:16]
  reg [1:0] value_4; // @[Counter.scala 62:40]
  reg [1:0] value_5; // @[Counter.scala 62:40]
  reg [1:0] value_6; // @[Counter.scala 62:40]
  reg  value_7; // @[Counter.scala 62:40]
  reg  value_9; // @[Counter.scala 62:40]
  reg [1:0] PostPC_fullcnt_reg; // @[Reg.scala 16:16]
  reg  PostPC_swtchcnt_reg; // @[Reg.scala 16:16]
  reg [2:0] value_10; // @[Counter.scala 62:40]
  reg [2:0] value_11; // @[Counter.scala 62:40]
  reg [2:0] value_12; // @[Counter.scala 62:40]
  reg [2:0] value_13; // @[Counter.scala 62:40]
  reg [2:0] value_14; // @[Counter.scala 62:40]
  reg [31:0] REG_2; // @[PermutationDesigns.scala 238:50]
  reg [31:0] REG_4; // @[PermutationDesigns.scala 238:50]
  reg [31:0] REG_5; // @[PermutationDesigns.scala 238:50]
  reg [31:0] REG_6; // @[PermutationDesigns.scala 238:50]
  wire  _T_4 = io_in_en & io_in_valid; // @[PermutationDesigns.scala 243:21]
  wire  wrap = value_10 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_1 = value_10 + 3'h1; // @[Counter.scala 78:24]
  wire  wrap_1 = value_4 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_3 = value_4 + 2'h1; // @[Counter.scala 78:24]
  wire  _GEN_15 = wrap_1 | REG; // @[PermutationDesigns.scala 248:52 250:29 222:47]
  wire [31:0] _T_8 = REG_2 + 32'h4; // @[PermutationDesigns.scala 253:52]
  wire  _GEN_19 = wrap ? _GEN_15 : REG; // @[PermutationDesigns.scala 222:47 245:54]
  wire  _GEN_24 = io_in_en & io_in_valid ? _GEN_19 : REG; // @[PermutationDesigns.scala 243:35 222:47]
  wire  wrap_3 = value_11 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_7 = value_11 + 3'h1; // @[Counter.scala 78:24]
  wire [1:0] _value_T_9 = value_5 + 2'h1; // @[Counter.scala 78:24]
  wire  wrap_6 = value_12 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_13 = value_12 + 3'h1; // @[Counter.scala 78:24]
  wire  wrap_7 = value_6 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_15 = value_6 + 2'h1; // @[Counter.scala 78:24]
  wire [31:0] _T_18 = REG_4 + 32'h4; // @[PermutationDesigns.scala 278:52]
  wire  _T_19 = io_in_en & Perm_shiftregs_valid; // @[PermutationDesigns.scala 281:21]
  reg [2:0] r_2; // @[Reg.scala 16:16]
  wire  _T_21 = PostPC_fullcnt_reg == 2'h3; // @[PermutationDesigns.scala 283:35]
  wire  _GEN_42 = PostPC_fullcnt_reg == 2'h3 | REG_1; // @[PermutationDesigns.scala 283:54 284:29 222:47]
  wire  _GEN_43 = r_2 == 3'h7 ? _GEN_42 : REG_1; // @[PermutationDesigns.scala 222:47 282:86]
  wire  _GEN_44 = io_in_en & Perm_shiftregs_valid ? _GEN_43 : REG_1; // @[PermutationDesigns.scala 281:44 222:47]
  wire  wrap_9 = value_2 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_19 = value_2 + 2'h1; // @[Counter.scala 78:24]
  wire  wrap_10 = value_13 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_21 = value_13 + 3'h1; // @[Counter.scala 78:24]
  wire  wrap_11 = value == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_23 = value + 2'h1; // @[Counter.scala 78:24]
  wire  _T_28 = _T_4 & wrap_1; // @[PermutationDesigns.scala 299:47]
  wire  _GEN_46 = wrap_11 ? _T_28 : _GEN_24; // @[PermutationDesigns.scala 297:57]
  wire [31:0] _T_30 = REG_5 + 32'h4; // @[PermutationDesigns.scala 313:60]
  wire  wrap_12 = value_3 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_25 = value_3 + 2'h1; // @[Counter.scala 78:24]
  wire  wrap_13 = value_14 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_27 = value_14 + 3'h1; // @[Counter.scala 78:24]
  wire  wrap_14 = value_1 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_29 = value_1 + 2'h1; // @[Counter.scala 78:24]
  wire  _T_37 = _T_19 & _T_21; // @[PermutationDesigns.scala 305:56]
  wire  _GEN_60 = wrap_14 ? _T_37 : _GEN_44; // @[PermutationDesigns.scala 297:57]
  wire [31:0] _T_39 = REG_6 + 32'h4; // @[PermutationDesigns.scala 313:60]
  wire [31:0] _GEN_85 = {{30'd0}, value_4}; // @[PermutationDesigns.scala 336:44]
  wire [31:0] _T_43 = _GEN_85 + REG_2; // @[PermutationDesigns.scala 336:44]
  wire [31:0] _GEN_86 = {{30'd0}, PrePermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_0}; // @[PermutationDesigns.scala 338:40]
  wire [31:0] _T_45 = _GEN_86 + REG_5; // @[PermutationDesigns.scala 338:40]
  reg [31:0] r_3; // @[Reg.scala 16:16]
  wire [31:0] _GEN_87 = {{30'd0}, PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_0}; // @[PermutationDesigns.scala 350:41]
  wire [31:0] _T_48 = _GEN_87 + r_3; // @[PermutationDesigns.scala 350:41]
  wire [31:0] _GEN_88 = {{30'd0}, value_1}; // @[PermutationDesigns.scala 351:45]
  wire [31:0] _T_50 = _GEN_88 + REG_6; // @[PermutationDesigns.scala 351:45]
  wire [31:0] _GEN_90 = {{30'd0}, PrePermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_1}; // @[PermutationDesigns.scala 338:40]
  wire [31:0] _T_54 = _GEN_90 + REG_5; // @[PermutationDesigns.scala 338:40]
  reg [31:0] r_4; // @[Reg.scala 16:16]
  wire [31:0] _GEN_91 = {{30'd0}, PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_1}; // @[PermutationDesigns.scala 350:41]
  wire [31:0] _T_57 = _GEN_91 + r_4; // @[PermutationDesigns.scala 350:41]
  reg  out_valid_sr_1; // @[Reg.scala 16:16]
  reg [31:0] out_data_sr_r_2_Re; // @[Reg.scala 16:16]
  reg [31:0] out_data_sr_r_2_Im; // @[Reg.scala 16:16]
  reg [31:0] out_data_sr_r_3_Re; // @[Reg.scala 16:16]
  reg [31:0] out_data_sr_r_3_Im; // @[Reg.scala 16:16]
  RAM_Block_N64_w2_bw32 RAM_Block_N64_w2_bw32 ( // @[PermutationDesigns.scala 207:41]
    .clock(RAM_Block_N64_w2_bw32_clock),
    .io_in_raddr(RAM_Block_N64_w2_bw32_io_in_raddr),
    .io_in_waddr(RAM_Block_N64_w2_bw32_io_in_waddr),
    .io_in_data_Re(RAM_Block_N64_w2_bw32_io_in_data_Re),
    .io_in_data_Im(RAM_Block_N64_w2_bw32_io_in_data_Im),
    .io_in_offset_switch(RAM_Block_N64_w2_bw32_io_in_offset_switch),
    .io_in_valid(RAM_Block_N64_w2_bw32_io_in_valid),
    .io_in_en(RAM_Block_N64_w2_bw32_io_in_en),
    .io_out_data_Re(RAM_Block_N64_w2_bw32_io_out_data_Re),
    .io_out_data_Im(RAM_Block_N64_w2_bw32_io_out_data_Im)
  );
  RAM_Block_N64_w2_bw32 RAM_Block_N64_w2_bw32_1 ( // @[PermutationDesigns.scala 207:41]
    .clock(RAM_Block_N64_w2_bw32_1_clock),
    .io_in_raddr(RAM_Block_N64_w2_bw32_1_io_in_raddr),
    .io_in_waddr(RAM_Block_N64_w2_bw32_1_io_in_waddr),
    .io_in_data_Re(RAM_Block_N64_w2_bw32_1_io_in_data_Re),
    .io_in_data_Im(RAM_Block_N64_w2_bw32_1_io_in_data_Im),
    .io_in_offset_switch(RAM_Block_N64_w2_bw32_1_io_in_offset_switch),
    .io_in_valid(RAM_Block_N64_w2_bw32_1_io_in_valid),
    .io_in_en(RAM_Block_N64_w2_bw32_1_io_in_en),
    .io_out_data_Re(RAM_Block_N64_w2_bw32_1_io_out_data_Re),
    .io_out_data_Im(RAM_Block_N64_w2_bw32_1_io_out_data_Im)
  );
  PrePermute_Config_ROM_N8_r2_base_r2_ptype1_w2 PrePermute_Config_ROM_N8_r2_base_r2_ptype1_w2 ( // @[PermutationDesigns.scala 209:25]
    .io_in_cnt(PrePermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_cnt),
    .io_out_0(PrePermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_0),
    .io_out_1(PrePermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_1)
  );
  Permute_Config_ROM_N8_r2_base_r2_ptype1_w2 Permute_Config_ROM_N8_r2_base_r2_ptype1_w2 ( // @[PermutationDesigns.scala 212:22]
    .clock(Permute_Config_ROM_N8_r2_base_r2_ptype1_w2_clock),
    .io_in_en(Permute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_en),
    .io_in_cnt(Permute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_cnt),
    .io_out_0(Permute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_0)
  );
  Permutation_Wiring_w2_bw32 Permutation_Wiring_w2_bw32 ( // @[PermutationDesigns.scala 213:24]
    .clock(Permutation_Wiring_w2_bw32_clock),
    .io_in_valid(Permutation_Wiring_w2_bw32_io_in_valid),
    .io_in_0_Re(Permutation_Wiring_w2_bw32_io_in_0_Re),
    .io_in_0_Im(Permutation_Wiring_w2_bw32_io_in_0_Im),
    .io_in_1_Re(Permutation_Wiring_w2_bw32_io_in_1_Re),
    .io_in_1_Im(Permutation_Wiring_w2_bw32_io_in_1_Im),
    .io_in_config_0(Permutation_Wiring_w2_bw32_io_in_config_0),
    .io_in_en(Permutation_Wiring_w2_bw32_io_in_en),
    .io_out_valid(Permutation_Wiring_w2_bw32_io_out_valid),
    .io_out_0_Re(Permutation_Wiring_w2_bw32_io_out_0_Re),
    .io_out_0_Im(Permutation_Wiring_w2_bw32_io_out_0_Im),
    .io_out_1_Re(Permutation_Wiring_w2_bw32_io_out_1_Re),
    .io_out_1_Im(Permutation_Wiring_w2_bw32_io_out_1_Im)
  );
  PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2 PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2 ( // @[PermutationDesigns.scala 219:26]
    .clock(PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_clock),
    .io_in_en(PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_en),
    .io_in_cnt(PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_cnt),
    .io_out_0(PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_0),
    .io_out_1(PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_1)
  );
  RAM_Block_N64_w2_bw32 RAM_Block_N64_w2_bw32_2 ( // @[PermutationDesigns.scala 220:41]
    .clock(RAM_Block_N64_w2_bw32_2_clock),
    .io_in_raddr(RAM_Block_N64_w2_bw32_2_io_in_raddr),
    .io_in_waddr(RAM_Block_N64_w2_bw32_2_io_in_waddr),
    .io_in_data_Re(RAM_Block_N64_w2_bw32_2_io_in_data_Re),
    .io_in_data_Im(RAM_Block_N64_w2_bw32_2_io_in_data_Im),
    .io_in_offset_switch(RAM_Block_N64_w2_bw32_2_io_in_offset_switch),
    .io_in_valid(RAM_Block_N64_w2_bw32_2_io_in_valid),
    .io_in_en(RAM_Block_N64_w2_bw32_2_io_in_en),
    .io_out_data_Re(RAM_Block_N64_w2_bw32_2_io_out_data_Re),
    .io_out_data_Im(RAM_Block_N64_w2_bw32_2_io_out_data_Im)
  );
  RAM_Block_N64_w2_bw32 RAM_Block_N64_w2_bw32_3 ( // @[PermutationDesigns.scala 220:41]
    .clock(RAM_Block_N64_w2_bw32_3_clock),
    .io_in_raddr(RAM_Block_N64_w2_bw32_3_io_in_raddr),
    .io_in_waddr(RAM_Block_N64_w2_bw32_3_io_in_waddr),
    .io_in_data_Re(RAM_Block_N64_w2_bw32_3_io_in_data_Re),
    .io_in_data_Im(RAM_Block_N64_w2_bw32_3_io_in_data_Im),
    .io_in_offset_switch(RAM_Block_N64_w2_bw32_3_io_in_offset_switch),
    .io_in_valid(RAM_Block_N64_w2_bw32_3_io_in_valid),
    .io_in_en(RAM_Block_N64_w2_bw32_3_io_in_en),
    .io_out_data_Re(RAM_Block_N64_w2_bw32_3_io_out_data_Re),
    .io_out_data_Im(RAM_Block_N64_w2_bw32_3_io_out_data_Im)
  );
  assign io_out_0_Re = out_data_sr_r_2_Re; // @[PermutationDesigns.scala 356:{34,34}]
  assign io_out_0_Im = out_data_sr_r_2_Im; // @[PermutationDesigns.scala 356:{34,34}]
  assign io_out_1_Re = out_data_sr_r_3_Re; // @[PermutationDesigns.scala 356:{34,34}]
  assign io_out_1_Im = out_data_sr_r_3_Im; // @[PermutationDesigns.scala 356:{34,34}]
  assign io_out_valid = out_valid_sr_1; // @[PermutationDesigns.scala 360:22]
  assign RAM_Block_N64_w2_bw32_clock = clock;
  assign RAM_Block_N64_w2_bw32_io_in_raddr = _T_45[5:0]; // @[PermutationDesigns.scala 338:24]
  assign RAM_Block_N64_w2_bw32_io_in_waddr = _T_43[5:0]; // @[PermutationDesigns.scala 336:24]
  assign RAM_Block_N64_w2_bw32_io_in_data_Re = io_in_0_Re; // @[PermutationDesigns.scala 334:23]
  assign RAM_Block_N64_w2_bw32_io_in_data_Im = io_in_0_Im; // @[PermutationDesigns.scala 334:23]
  assign RAM_Block_N64_w2_bw32_io_in_offset_switch = value_7; // @[PermutationDesigns.scala 339:53]
  assign RAM_Block_N64_w2_bw32_io_in_valid = io_in_valid; // @[PermutationDesigns.scala 335:24]
  assign RAM_Block_N64_w2_bw32_io_in_en = io_in_en; // @[PermutationDesigns.scala 333:21]
  assign RAM_Block_N64_w2_bw32_1_clock = clock;
  assign RAM_Block_N64_w2_bw32_1_io_in_raddr = _T_54[5:0]; // @[PermutationDesigns.scala 338:24]
  assign RAM_Block_N64_w2_bw32_1_io_in_waddr = _T_43[5:0]; // @[PermutationDesigns.scala 336:24]
  assign RAM_Block_N64_w2_bw32_1_io_in_data_Re = io_in_1_Re; // @[PermutationDesigns.scala 334:23]
  assign RAM_Block_N64_w2_bw32_1_io_in_data_Im = io_in_1_Im; // @[PermutationDesigns.scala 334:23]
  assign RAM_Block_N64_w2_bw32_1_io_in_offset_switch = value_7; // @[PermutationDesigns.scala 339:53]
  assign RAM_Block_N64_w2_bw32_1_io_in_valid = io_in_valid; // @[PermutationDesigns.scala 335:24]
  assign RAM_Block_N64_w2_bw32_1_io_in_en = io_in_en; // @[PermutationDesigns.scala 333:21]
  assign PrePermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_cnt = value; // @[PermutationDesigns.scala 322:20]
  assign Permute_Config_ROM_N8_r2_base_r2_ptype1_w2_clock = clock;
  assign Permute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_en = io_in_en; // @[PermutationDesigns.scala 324:16]
  assign Permute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_cnt = value_5; // @[PermutationDesigns.scala 327:17]
  assign Permutation_Wiring_w2_bw32_clock = clock;
  assign Permutation_Wiring_w2_bw32_io_in_valid = M0_shiftregs_valid; // @[PermutationDesigns.scala 343:23]
  assign Permutation_Wiring_w2_bw32_io_in_0_Re = M0_shiftregs_data_r_Re; // @[PermutationDesigns.scala 228:{38,38}]
  assign Permutation_Wiring_w2_bw32_io_in_0_Im = M0_shiftregs_data_r_Im; // @[PermutationDesigns.scala 228:{38,38}]
  assign Permutation_Wiring_w2_bw32_io_in_1_Re = M0_shiftregs_data_r_1_Re; // @[PermutationDesigns.scala 228:{38,38}]
  assign Permutation_Wiring_w2_bw32_io_in_1_Im = M0_shiftregs_data_r_1_Im; // @[PermutationDesigns.scala 228:{38,38}]
  assign Permutation_Wiring_w2_bw32_io_in_config_0 = Permute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_out_0; // @[PermutationDesigns.scala 344:27]
  assign Permutation_Wiring_w2_bw32_io_in_en = io_in_en; // @[PermutationDesigns.scala 341:20]
  assign PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_clock = clock;
  assign PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_en = io_in_en; // @[PermutationDesigns.scala 328:20]
  assign PostPermute_Config_ROM_N8_r2_base_r2_ptype1_w2_io_in_cnt = value_6; // @[PermutationDesigns.scala 330:21]
  assign RAM_Block_N64_w2_bw32_2_clock = clock;
  assign RAM_Block_N64_w2_bw32_2_io_in_raddr = _T_50[5:0]; // @[PermutationDesigns.scala 351:24]
  assign RAM_Block_N64_w2_bw32_2_io_in_waddr = _T_48[5:0]; // @[PermutationDesigns.scala 350:24]
  assign RAM_Block_N64_w2_bw32_2_io_in_data_Re = Perm_shiftregs_data_r_Re; // @[PermutationDesigns.scala 214:{40,40}]
  assign RAM_Block_N64_w2_bw32_2_io_in_data_Im = Perm_shiftregs_data_r_Im; // @[PermutationDesigns.scala 214:{40,40}]
  assign RAM_Block_N64_w2_bw32_2_io_in_offset_switch = PostPC_swtchcnt_reg; // @[PermutationDesigns.scala 352:32]
  assign RAM_Block_N64_w2_bw32_2_io_in_valid = Perm_shiftregs_valid; // @[PermutationDesigns.scala 349:24]
  assign RAM_Block_N64_w2_bw32_2_io_in_en = io_in_en; // @[PermutationDesigns.scala 346:21]
  assign RAM_Block_N64_w2_bw32_3_clock = clock;
  assign RAM_Block_N64_w2_bw32_3_io_in_raddr = _T_50[5:0]; // @[PermutationDesigns.scala 351:24]
  assign RAM_Block_N64_w2_bw32_3_io_in_waddr = _T_57[5:0]; // @[PermutationDesigns.scala 350:24]
  assign RAM_Block_N64_w2_bw32_3_io_in_data_Re = Perm_shiftregs_data_r_1_Re; // @[PermutationDesigns.scala 214:{40,40}]
  assign RAM_Block_N64_w2_bw32_3_io_in_data_Im = Perm_shiftregs_data_r_1_Im; // @[PermutationDesigns.scala 214:{40,40}]
  assign RAM_Block_N64_w2_bw32_3_io_in_offset_switch = PostPC_swtchcnt_reg; // @[PermutationDesigns.scala 352:32]
  assign RAM_Block_N64_w2_bw32_3_io_in_valid = Perm_shiftregs_valid; // @[PermutationDesigns.scala 349:24]
  assign RAM_Block_N64_w2_bw32_3_io_in_en = io_in_en; // @[PermutationDesigns.scala 346:21]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_data_r_Re <= Permutation_Wiring_w2_bw32_io_out_0_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_data_r_Im <= Permutation_Wiring_w2_bw32_io_out_0_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_data_r_1_Re <= Permutation_Wiring_w2_bw32_io_out_1_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_data_r_1_Im <= Permutation_Wiring_w2_bw32_io_out_1_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_valid <= Permutation_Wiring_w2_bw32_io_out_valid; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[PermutationDesigns.scala 222:47]
      REG <= 1'h0; // @[PermutationDesigns.scala 222:47]
    end else if (io_in_en & REG) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_9) begin // @[PermutationDesigns.scala 292:56]
        if (wrap_10) begin // @[PermutationDesigns.scala 294:60]
          REG <= _GEN_46;
        end else begin
          REG <= _GEN_24;
        end
      end else begin
        REG <= _GEN_24;
      end
    end else begin
      REG <= _GEN_24;
    end
    if (reset) begin // @[PermutationDesigns.scala 222:47]
      REG_1 <= 1'h0; // @[PermutationDesigns.scala 222:47]
    end else if (io_in_en & REG_1) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_12) begin // @[PermutationDesigns.scala 292:56]
        if (wrap_13) begin // @[PermutationDesigns.scala 294:60]
          REG_1 <= _GEN_60;
        end else begin
          REG_1 <= _GEN_44;
        end
      end else begin
        REG_1 <= _GEN_44;
      end
    end else begin
      REG_1 <= _GEN_44;
    end
    if (reset) begin // @[Counter.scala 62:40]
      value <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & REG) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_9) begin // @[PermutationDesigns.scala 292:56]
        if (wrap_10) begin // @[PermutationDesigns.scala 294:60]
          value <= _value_T_23; // @[Counter.scala 78:15]
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_1 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & REG_1) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_12) begin // @[PermutationDesigns.scala 292:56]
        if (wrap_13) begin // @[PermutationDesigns.scala 294:60]
          value_1 <= _value_T_29; // @[Counter.scala 78:15]
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_2 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & REG) begin // @[PermutationDesigns.scala 290:41]
      value_2 <= _value_T_19; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_3 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & REG_1) begin // @[PermutationDesigns.scala 290:41]
      value_3 <= _value_T_25; // @[Counter.scala 78:15]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      r <= _T_1; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      r_1 <= _T_3; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_data_r_Re <= RAM_Block_N64_w2_bw32_io_out_data_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_data_r_Im <= RAM_Block_N64_w2_bw32_io_out_data_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_data_r_1_Re <= RAM_Block_N64_w2_bw32_1_io_out_data_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_data_r_1_Im <= RAM_Block_N64_w2_bw32_1_io_out_data_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_valid <= r; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_4 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & io_in_valid) begin // @[PermutationDesigns.scala 243:35]
      if (wrap) begin // @[PermutationDesigns.scala 245:54]
        value_4 <= _value_T_3; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_5 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & r) begin // @[PermutationDesigns.scala 257:40]
      if (wrap_3) begin // @[PermutationDesigns.scala 259:54]
        value_5 <= _value_T_9; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_6 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & Permutation_Wiring_w2_bw32_io_out_valid) begin // @[PermutationDesigns.scala 269:38]
      if (wrap_6) begin // @[PermutationDesigns.scala 271:54]
        value_6 <= _value_T_15; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_7 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & io_in_valid) begin // @[PermutationDesigns.scala 243:35]
      if (wrap) begin // @[PermutationDesigns.scala 245:54]
        if (wrap_1) begin // @[PermutationDesigns.scala 248:52]
          value_7 <= value_7 + 1'h1; // @[Counter.scala 78:15]
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_9 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & Permutation_Wiring_w2_bw32_io_out_valid) begin // @[PermutationDesigns.scala 269:38]
      if (wrap_6) begin // @[PermutationDesigns.scala 271:54]
        if (wrap_7) begin // @[PermutationDesigns.scala 274:52]
          value_9 <= value_9 + 1'h1; // @[Counter.scala 78:15]
        end
      end
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      PostPC_fullcnt_reg <= value_6; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      PostPC_swtchcnt_reg <= value_9; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_10 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & io_in_valid) begin // @[PermutationDesigns.scala 243:35]
      value_10 <= _value_T_1; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_11 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & r) begin // @[PermutationDesigns.scala 257:40]
      value_11 <= _value_T_7; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_12 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & Permutation_Wiring_w2_bw32_io_out_valid) begin // @[PermutationDesigns.scala 269:38]
      value_12 <= _value_T_13; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_13 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & REG) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_9) begin // @[PermutationDesigns.scala 292:56]
        value_13 <= _value_T_21; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_14 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & REG_1) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_12) begin // @[PermutationDesigns.scala 292:56]
        value_14 <= _value_T_27; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[PermutationDesigns.scala 238:50]
      REG_2 <= 32'h0; // @[PermutationDesigns.scala 238:50]
    end else if (io_in_en & io_in_valid) begin // @[PermutationDesigns.scala 243:35]
      if (wrap) begin // @[PermutationDesigns.scala 245:54]
        REG_2 <= 32'h0; // @[PermutationDesigns.scala 247:30]
      end else begin
        REG_2 <= _T_8; // @[PermutationDesigns.scala 253:30]
      end
    end
    if (reset) begin // @[PermutationDesigns.scala 238:50]
      REG_4 <= 32'h0; // @[PermutationDesigns.scala 238:50]
    end else if (io_in_en & Permutation_Wiring_w2_bw32_io_out_valid) begin // @[PermutationDesigns.scala 269:38]
      if (wrap_6) begin // @[PermutationDesigns.scala 271:54]
        REG_4 <= 32'h0; // @[PermutationDesigns.scala 273:30]
      end else begin
        REG_4 <= _T_18; // @[PermutationDesigns.scala 278:30]
      end
    end
    if (reset) begin // @[PermutationDesigns.scala 238:50]
      REG_5 <= 32'h0; // @[PermutationDesigns.scala 238:50]
    end else if (io_in_en & REG) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_9) begin // @[PermutationDesigns.scala 292:56]
        if (wrap_10) begin // @[PermutationDesigns.scala 294:60]
          REG_5 <= 32'h0; // @[PermutationDesigns.scala 296:36]
        end else begin
          REG_5 <= _T_30; // @[PermutationDesigns.scala 313:36]
        end
      end
    end
    if (reset) begin // @[PermutationDesigns.scala 238:50]
      REG_6 <= 32'h0; // @[PermutationDesigns.scala 238:50]
    end else if (io_in_en & REG_1) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_12) begin // @[PermutationDesigns.scala 292:56]
        if (wrap_13) begin // @[PermutationDesigns.scala 294:60]
          REG_6 <= 32'h0; // @[PermutationDesigns.scala 296:36]
        end else begin
          REG_6 <= _T_39; // @[PermutationDesigns.scala 313:36]
        end
      end
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      r_2 <= value_12; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      r_3 <= REG_4; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      r_4 <= REG_4; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_valid_sr_1 <= r_1; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_data_sr_r_2_Re <= RAM_Block_N64_w2_bw32_2_io_out_data_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_data_sr_r_2_Im <= RAM_Block_N64_w2_bw32_2_io_out_data_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_data_sr_r_3_Re <= RAM_Block_N64_w2_bw32_3_io_out_data_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_data_sr_r_3_Im <= RAM_Block_N64_w2_bw32_3_io_out_data_Im; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  Perm_shiftregs_data_r_Re = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  Perm_shiftregs_data_r_Im = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  Perm_shiftregs_data_r_1_Re = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  Perm_shiftregs_data_r_1_Im = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  Perm_shiftregs_valid = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  REG = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  REG_1 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  value = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  value_1 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  value_2 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  value_3 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  r = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  r_1 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  M0_shiftregs_data_r_Re = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  M0_shiftregs_data_r_Im = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  M0_shiftregs_data_r_1_Re = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  M0_shiftregs_data_r_1_Im = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  M0_shiftregs_valid = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  value_4 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  value_5 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  value_6 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  value_7 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  value_9 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  PostPC_fullcnt_reg = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  PostPC_swtchcnt_reg = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  value_10 = _RAND_25[2:0];
  _RAND_26 = {1{`RANDOM}};
  value_11 = _RAND_26[2:0];
  _RAND_27 = {1{`RANDOM}};
  value_12 = _RAND_27[2:0];
  _RAND_28 = {1{`RANDOM}};
  value_13 = _RAND_28[2:0];
  _RAND_29 = {1{`RANDOM}};
  value_14 = _RAND_29[2:0];
  _RAND_30 = {1{`RANDOM}};
  REG_2 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  REG_4 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  REG_5 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  REG_6 = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  r_2 = _RAND_34[2:0];
  _RAND_35 = {1{`RANDOM}};
  r_3 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  r_4 = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  out_valid_sr_1 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  out_data_sr_r_2_Re = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  out_data_sr_r_2_Im = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  out_data_sr_r_3_Re = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  out_data_sr_r_3_Im = _RAND_41[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PrePermute_Config_ROM_N8_r2_base_r2_ptype0_w2(
  input  [1:0] io_in_cnt,
  output [1:0] io_out_0,
  output [1:0] io_out_1
);
  wire [1:0] _GEN_1 = 2'h1 == io_in_cnt ? 2'h1 : 2'h0; // @[PermutationDesigns.scala 430:{31,31}]
  wire [1:0] _GEN_2 = 2'h2 == io_in_cnt ? 2'h2 : _GEN_1; // @[PermutationDesigns.scala 430:{31,31}]
  wire [1:0] _GEN_5 = 2'h1 == io_in_cnt ? 2'h2 : 2'h1; // @[PermutationDesigns.scala 430:{31,31}]
  wire [1:0] _GEN_6 = 2'h2 == io_in_cnt ? 2'h3 : _GEN_5; // @[PermutationDesigns.scala 430:{31,31}]
  assign io_out_0 = 2'h3 == io_in_cnt ? 2'h3 : _GEN_2; // @[PermutationDesigns.scala 430:{31,31}]
  assign io_out_1 = 2'h3 == io_in_cnt ? 2'h0 : _GEN_6; // @[PermutationDesigns.scala 430:{31,31}]
endmodule
module Permute_Config_ROM_N8_r2_base_r2_ptype0_w2(
  input        clock,
  input        io_in_en,
  input  [1:0] io_in_cnt,
  output       io_out_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  out_reg_data_r; // @[Reg.scala 16:16]
  wire  _GEN_2 = 2'h2 == io_in_cnt ? 1'h0 : 2'h1 == io_in_cnt; // @[Reg.scala 17:{22,22}]
  assign io_out_0 = out_reg_data_r; // @[PermutationDesigns.scala 494:{31,31}]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_reg_data_r <= 2'h3 == io_in_cnt | _GEN_2; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  out_reg_data_r = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2(
  input        clock,
  input        io_in_en,
  input  [1:0] io_in_cnt,
  output [1:0] io_out_0,
  output [1:0] io_out_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] out_reg_data_r; // @[Reg.scala 16:16]
  reg [1:0] out_reg_data_r_1; // @[Reg.scala 16:16]
  assign io_out_0 = out_reg_data_r; // @[PermutationDesigns.scala 462:{31,31}]
  assign io_out_1 = out_reg_data_r_1; // @[PermutationDesigns.scala 462:{31,31}]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      if (2'h3 == io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r <= 2'h2; // @[Reg.scala 17:22]
      end else if (2'h2 == io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r <= 2'h1; // @[Reg.scala 17:22]
      end else if (2'h1 == io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r <= 2'h3; // @[Reg.scala 17:22]
      end else begin
        out_reg_data_r <= 2'h0;
      end
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      if (2'h3 == io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r_1 <= 2'h1; // @[Reg.scala 17:22]
      end else if (2'h2 == io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r_1 <= 2'h3; // @[Reg.scala 17:22]
      end else if (2'h1 == io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r_1 <= 2'h0; // @[Reg.scala 17:22]
      end else begin
        out_reg_data_r_1 <= 2'h2;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  out_reg_data_r = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  out_reg_data_r_1 = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  input         io_in_valid,
  output [31:0] io_out_0_Re,
  output [31:0] io_out_0_Im,
  output [31:0] io_out_1_Re,
  output [31:0] io_out_1_Im,
  output        io_out_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
`endif // RANDOMIZE_REG_INIT
  wire  RAM_Block_N64_w2_bw32_clock; // @[PermutationDesigns.scala 207:41]
  wire [5:0] RAM_Block_N64_w2_bw32_io_in_raddr; // @[PermutationDesigns.scala 207:41]
  wire [5:0] RAM_Block_N64_w2_bw32_io_in_waddr; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_io_in_data_Re; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_io_in_data_Im; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_io_in_offset_switch; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_io_in_valid; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_io_in_en; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_io_out_data_Re; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_io_out_data_Im; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_1_clock; // @[PermutationDesigns.scala 207:41]
  wire [5:0] RAM_Block_N64_w2_bw32_1_io_in_raddr; // @[PermutationDesigns.scala 207:41]
  wire [5:0] RAM_Block_N64_w2_bw32_1_io_in_waddr; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_1_io_in_data_Re; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_1_io_in_data_Im; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_1_io_in_offset_switch; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_1_io_in_valid; // @[PermutationDesigns.scala 207:41]
  wire  RAM_Block_N64_w2_bw32_1_io_in_en; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_1_io_out_data_Re; // @[PermutationDesigns.scala 207:41]
  wire [31:0] RAM_Block_N64_w2_bw32_1_io_out_data_Im; // @[PermutationDesigns.scala 207:41]
  wire [1:0] PrePermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_cnt; // @[PermutationDesigns.scala 209:25]
  wire [1:0] PrePermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_0; // @[PermutationDesigns.scala 209:25]
  wire [1:0] PrePermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_1; // @[PermutationDesigns.scala 209:25]
  wire  Permute_Config_ROM_N8_r2_base_r2_ptype0_w2_clock; // @[PermutationDesigns.scala 212:22]
  wire  Permute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_en; // @[PermutationDesigns.scala 212:22]
  wire [1:0] Permute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_cnt; // @[PermutationDesigns.scala 212:22]
  wire  Permute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_0; // @[PermutationDesigns.scala 212:22]
  wire  Permutation_Wiring_w2_bw32_clock; // @[PermutationDesigns.scala 213:24]
  wire  Permutation_Wiring_w2_bw32_io_in_valid; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_in_0_Re; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_in_0_Im; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_in_1_Re; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_in_1_Im; // @[PermutationDesigns.scala 213:24]
  wire  Permutation_Wiring_w2_bw32_io_in_config_0; // @[PermutationDesigns.scala 213:24]
  wire  Permutation_Wiring_w2_bw32_io_in_en; // @[PermutationDesigns.scala 213:24]
  wire  Permutation_Wiring_w2_bw32_io_out_valid; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_out_0_Re; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_out_0_Im; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_out_1_Re; // @[PermutationDesigns.scala 213:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_out_1_Im; // @[PermutationDesigns.scala 213:24]
  wire  PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_clock; // @[PermutationDesigns.scala 219:26]
  wire  PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_en; // @[PermutationDesigns.scala 219:26]
  wire [1:0] PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_cnt; // @[PermutationDesigns.scala 219:26]
  wire [1:0] PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_0; // @[PermutationDesigns.scala 219:26]
  wire [1:0] PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_1; // @[PermutationDesigns.scala 219:26]
  wire  RAM_Block_N64_w2_bw32_2_clock; // @[PermutationDesigns.scala 220:41]
  wire [5:0] RAM_Block_N64_w2_bw32_2_io_in_raddr; // @[PermutationDesigns.scala 220:41]
  wire [5:0] RAM_Block_N64_w2_bw32_2_io_in_waddr; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_2_io_in_data_Re; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_2_io_in_data_Im; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_2_io_in_offset_switch; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_2_io_in_valid; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_2_io_in_en; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_2_io_out_data_Re; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_2_io_out_data_Im; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_3_clock; // @[PermutationDesigns.scala 220:41]
  wire [5:0] RAM_Block_N64_w2_bw32_3_io_in_raddr; // @[PermutationDesigns.scala 220:41]
  wire [5:0] RAM_Block_N64_w2_bw32_3_io_in_waddr; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_3_io_in_data_Re; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_3_io_in_data_Im; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_3_io_in_offset_switch; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_3_io_in_valid; // @[PermutationDesigns.scala 220:41]
  wire  RAM_Block_N64_w2_bw32_3_io_in_en; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_3_io_out_data_Re; // @[PermutationDesigns.scala 220:41]
  wire [31:0] RAM_Block_N64_w2_bw32_3_io_out_data_Im; // @[PermutationDesigns.scala 220:41]
  reg [31:0] Perm_shiftregs_data_r_Re; // @[Reg.scala 16:16]
  reg [31:0] Perm_shiftregs_data_r_Im; // @[Reg.scala 16:16]
  reg [31:0] Perm_shiftregs_data_r_1_Re; // @[Reg.scala 16:16]
  reg [31:0] Perm_shiftregs_data_r_1_Im; // @[Reg.scala 16:16]
  reg  Perm_shiftregs_valid; // @[Reg.scala 16:16]
  reg  REG; // @[PermutationDesigns.scala 222:47]
  reg  REG_1; // @[PermutationDesigns.scala 222:47]
  reg [1:0] value; // @[Counter.scala 62:40]
  reg [1:0] value_1; // @[Counter.scala 62:40]
  reg [1:0] value_2; // @[Counter.scala 62:40]
  reg [1:0] value_3; // @[Counter.scala 62:40]
  wire  _T_1 = REG & value_2 == 2'h0; // @[PermutationDesigns.scala 226:39]
  reg  r; // @[Reg.scala 16:16]
  wire  _T_3 = REG_1 & value_3 == 2'h0; // @[PermutationDesigns.scala 226:39]
  reg  r_1; // @[Reg.scala 16:16]
  reg [31:0] M0_shiftregs_data_r_Re; // @[Reg.scala 16:16]
  reg [31:0] M0_shiftregs_data_r_Im; // @[Reg.scala 16:16]
  reg [31:0] M0_shiftregs_data_r_1_Re; // @[Reg.scala 16:16]
  reg [31:0] M0_shiftregs_data_r_1_Im; // @[Reg.scala 16:16]
  reg  M0_shiftregs_valid; // @[Reg.scala 16:16]
  reg [1:0] value_4; // @[Counter.scala 62:40]
  reg [1:0] value_5; // @[Counter.scala 62:40]
  reg [1:0] value_6; // @[Counter.scala 62:40]
  reg  value_7; // @[Counter.scala 62:40]
  reg  value_9; // @[Counter.scala 62:40]
  reg [1:0] PostPC_fullcnt_reg; // @[Reg.scala 16:16]
  reg  PostPC_swtchcnt_reg; // @[Reg.scala 16:16]
  reg [2:0] value_10; // @[Counter.scala 62:40]
  reg [2:0] value_11; // @[Counter.scala 62:40]
  reg [2:0] value_12; // @[Counter.scala 62:40]
  reg [2:0] value_13; // @[Counter.scala 62:40]
  reg [2:0] value_14; // @[Counter.scala 62:40]
  reg [31:0] REG_2; // @[PermutationDesigns.scala 238:50]
  reg [31:0] REG_4; // @[PermutationDesigns.scala 238:50]
  reg [31:0] REG_5; // @[PermutationDesigns.scala 238:50]
  reg [31:0] REG_6; // @[PermutationDesigns.scala 238:50]
  wire  _T_4 = io_in_en & io_in_valid; // @[PermutationDesigns.scala 243:21]
  wire  wrap = value_10 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_1 = value_10 + 3'h1; // @[Counter.scala 78:24]
  wire  wrap_1 = value_4 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_3 = value_4 + 2'h1; // @[Counter.scala 78:24]
  wire  _GEN_15 = wrap_1 | REG; // @[PermutationDesigns.scala 248:52 250:29 222:47]
  wire [31:0] _T_8 = REG_2 + 32'h4; // @[PermutationDesigns.scala 253:52]
  wire  _GEN_19 = wrap ? _GEN_15 : REG; // @[PermutationDesigns.scala 222:47 245:54]
  wire  _GEN_24 = io_in_en & io_in_valid ? _GEN_19 : REG; // @[PermutationDesigns.scala 243:35 222:47]
  wire  wrap_3 = value_11 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_7 = value_11 + 3'h1; // @[Counter.scala 78:24]
  wire [1:0] _value_T_9 = value_5 + 2'h1; // @[Counter.scala 78:24]
  wire  wrap_6 = value_12 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_13 = value_12 + 3'h1; // @[Counter.scala 78:24]
  wire  wrap_7 = value_6 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_15 = value_6 + 2'h1; // @[Counter.scala 78:24]
  wire [31:0] _T_18 = REG_4 + 32'h4; // @[PermutationDesigns.scala 278:52]
  wire  _T_19 = io_in_en & Perm_shiftregs_valid; // @[PermutationDesigns.scala 281:21]
  reg [2:0] r_2; // @[Reg.scala 16:16]
  wire  _T_21 = PostPC_fullcnt_reg == 2'h3; // @[PermutationDesigns.scala 283:35]
  wire  _GEN_42 = PostPC_fullcnt_reg == 2'h3 | REG_1; // @[PermutationDesigns.scala 283:54 284:29 222:47]
  wire  _GEN_43 = r_2 == 3'h7 ? _GEN_42 : REG_1; // @[PermutationDesigns.scala 222:47 282:86]
  wire  _GEN_44 = io_in_en & Perm_shiftregs_valid ? _GEN_43 : REG_1; // @[PermutationDesigns.scala 281:44 222:47]
  wire  wrap_9 = value_2 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_19 = value_2 + 2'h1; // @[Counter.scala 78:24]
  wire  wrap_10 = value_13 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_21 = value_13 + 3'h1; // @[Counter.scala 78:24]
  wire  wrap_11 = value == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_23 = value + 2'h1; // @[Counter.scala 78:24]
  wire  _T_28 = _T_4 & wrap_1; // @[PermutationDesigns.scala 299:47]
  wire  _GEN_46 = wrap_11 ? _T_28 : _GEN_24; // @[PermutationDesigns.scala 297:57]
  wire [31:0] _T_30 = REG_5 + 32'h4; // @[PermutationDesigns.scala 313:60]
  wire  wrap_12 = value_3 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_25 = value_3 + 2'h1; // @[Counter.scala 78:24]
  wire  wrap_13 = value_14 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_27 = value_14 + 3'h1; // @[Counter.scala 78:24]
  wire  wrap_14 = value_1 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_29 = value_1 + 2'h1; // @[Counter.scala 78:24]
  wire  _T_37 = _T_19 & _T_21; // @[PermutationDesigns.scala 305:56]
  wire  _GEN_60 = wrap_14 ? _T_37 : _GEN_44; // @[PermutationDesigns.scala 297:57]
  wire [31:0] _T_39 = REG_6 + 32'h4; // @[PermutationDesigns.scala 313:60]
  wire [31:0] _GEN_85 = {{30'd0}, value_4}; // @[PermutationDesigns.scala 336:44]
  wire [31:0] _T_43 = _GEN_85 + REG_2; // @[PermutationDesigns.scala 336:44]
  wire [31:0] _GEN_86 = {{30'd0}, PrePermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_0}; // @[PermutationDesigns.scala 338:40]
  wire [31:0] _T_45 = _GEN_86 + REG_5; // @[PermutationDesigns.scala 338:40]
  reg [31:0] r_3; // @[Reg.scala 16:16]
  wire [31:0] _GEN_87 = {{30'd0}, PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_0}; // @[PermutationDesigns.scala 350:41]
  wire [31:0] _T_48 = _GEN_87 + r_3; // @[PermutationDesigns.scala 350:41]
  wire [31:0] _GEN_88 = {{30'd0}, value_1}; // @[PermutationDesigns.scala 351:45]
  wire [31:0] _T_50 = _GEN_88 + REG_6; // @[PermutationDesigns.scala 351:45]
  wire [31:0] _GEN_90 = {{30'd0}, PrePermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_1}; // @[PermutationDesigns.scala 338:40]
  wire [31:0] _T_54 = _GEN_90 + REG_5; // @[PermutationDesigns.scala 338:40]
  reg [31:0] r_4; // @[Reg.scala 16:16]
  wire [31:0] _GEN_91 = {{30'd0}, PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_1}; // @[PermutationDesigns.scala 350:41]
  wire [31:0] _T_57 = _GEN_91 + r_4; // @[PermutationDesigns.scala 350:41]
  reg  out_valid_sr_1; // @[Reg.scala 16:16]
  reg [31:0] out_data_sr_r_2_Re; // @[Reg.scala 16:16]
  reg [31:0] out_data_sr_r_2_Im; // @[Reg.scala 16:16]
  reg [31:0] out_data_sr_r_3_Re; // @[Reg.scala 16:16]
  reg [31:0] out_data_sr_r_3_Im; // @[Reg.scala 16:16]
  RAM_Block_N64_w2_bw32 RAM_Block_N64_w2_bw32 ( // @[PermutationDesigns.scala 207:41]
    .clock(RAM_Block_N64_w2_bw32_clock),
    .io_in_raddr(RAM_Block_N64_w2_bw32_io_in_raddr),
    .io_in_waddr(RAM_Block_N64_w2_bw32_io_in_waddr),
    .io_in_data_Re(RAM_Block_N64_w2_bw32_io_in_data_Re),
    .io_in_data_Im(RAM_Block_N64_w2_bw32_io_in_data_Im),
    .io_in_offset_switch(RAM_Block_N64_w2_bw32_io_in_offset_switch),
    .io_in_valid(RAM_Block_N64_w2_bw32_io_in_valid),
    .io_in_en(RAM_Block_N64_w2_bw32_io_in_en),
    .io_out_data_Re(RAM_Block_N64_w2_bw32_io_out_data_Re),
    .io_out_data_Im(RAM_Block_N64_w2_bw32_io_out_data_Im)
  );
  RAM_Block_N64_w2_bw32 RAM_Block_N64_w2_bw32_1 ( // @[PermutationDesigns.scala 207:41]
    .clock(RAM_Block_N64_w2_bw32_1_clock),
    .io_in_raddr(RAM_Block_N64_w2_bw32_1_io_in_raddr),
    .io_in_waddr(RAM_Block_N64_w2_bw32_1_io_in_waddr),
    .io_in_data_Re(RAM_Block_N64_w2_bw32_1_io_in_data_Re),
    .io_in_data_Im(RAM_Block_N64_w2_bw32_1_io_in_data_Im),
    .io_in_offset_switch(RAM_Block_N64_w2_bw32_1_io_in_offset_switch),
    .io_in_valid(RAM_Block_N64_w2_bw32_1_io_in_valid),
    .io_in_en(RAM_Block_N64_w2_bw32_1_io_in_en),
    .io_out_data_Re(RAM_Block_N64_w2_bw32_1_io_out_data_Re),
    .io_out_data_Im(RAM_Block_N64_w2_bw32_1_io_out_data_Im)
  );
  PrePermute_Config_ROM_N8_r2_base_r2_ptype0_w2 PrePermute_Config_ROM_N8_r2_base_r2_ptype0_w2 ( // @[PermutationDesigns.scala 209:25]
    .io_in_cnt(PrePermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_cnt),
    .io_out_0(PrePermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_0),
    .io_out_1(PrePermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_1)
  );
  Permute_Config_ROM_N8_r2_base_r2_ptype0_w2 Permute_Config_ROM_N8_r2_base_r2_ptype0_w2 ( // @[PermutationDesigns.scala 212:22]
    .clock(Permute_Config_ROM_N8_r2_base_r2_ptype0_w2_clock),
    .io_in_en(Permute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_en),
    .io_in_cnt(Permute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_cnt),
    .io_out_0(Permute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_0)
  );
  Permutation_Wiring_w2_bw32 Permutation_Wiring_w2_bw32 ( // @[PermutationDesigns.scala 213:24]
    .clock(Permutation_Wiring_w2_bw32_clock),
    .io_in_valid(Permutation_Wiring_w2_bw32_io_in_valid),
    .io_in_0_Re(Permutation_Wiring_w2_bw32_io_in_0_Re),
    .io_in_0_Im(Permutation_Wiring_w2_bw32_io_in_0_Im),
    .io_in_1_Re(Permutation_Wiring_w2_bw32_io_in_1_Re),
    .io_in_1_Im(Permutation_Wiring_w2_bw32_io_in_1_Im),
    .io_in_config_0(Permutation_Wiring_w2_bw32_io_in_config_0),
    .io_in_en(Permutation_Wiring_w2_bw32_io_in_en),
    .io_out_valid(Permutation_Wiring_w2_bw32_io_out_valid),
    .io_out_0_Re(Permutation_Wiring_w2_bw32_io_out_0_Re),
    .io_out_0_Im(Permutation_Wiring_w2_bw32_io_out_0_Im),
    .io_out_1_Re(Permutation_Wiring_w2_bw32_io_out_1_Re),
    .io_out_1_Im(Permutation_Wiring_w2_bw32_io_out_1_Im)
  );
  PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2 PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2 ( // @[PermutationDesigns.scala 219:26]
    .clock(PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_clock),
    .io_in_en(PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_en),
    .io_in_cnt(PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_cnt),
    .io_out_0(PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_0),
    .io_out_1(PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_1)
  );
  RAM_Block_N64_w2_bw32 RAM_Block_N64_w2_bw32_2 ( // @[PermutationDesigns.scala 220:41]
    .clock(RAM_Block_N64_w2_bw32_2_clock),
    .io_in_raddr(RAM_Block_N64_w2_bw32_2_io_in_raddr),
    .io_in_waddr(RAM_Block_N64_w2_bw32_2_io_in_waddr),
    .io_in_data_Re(RAM_Block_N64_w2_bw32_2_io_in_data_Re),
    .io_in_data_Im(RAM_Block_N64_w2_bw32_2_io_in_data_Im),
    .io_in_offset_switch(RAM_Block_N64_w2_bw32_2_io_in_offset_switch),
    .io_in_valid(RAM_Block_N64_w2_bw32_2_io_in_valid),
    .io_in_en(RAM_Block_N64_w2_bw32_2_io_in_en),
    .io_out_data_Re(RAM_Block_N64_w2_bw32_2_io_out_data_Re),
    .io_out_data_Im(RAM_Block_N64_w2_bw32_2_io_out_data_Im)
  );
  RAM_Block_N64_w2_bw32 RAM_Block_N64_w2_bw32_3 ( // @[PermutationDesigns.scala 220:41]
    .clock(RAM_Block_N64_w2_bw32_3_clock),
    .io_in_raddr(RAM_Block_N64_w2_bw32_3_io_in_raddr),
    .io_in_waddr(RAM_Block_N64_w2_bw32_3_io_in_waddr),
    .io_in_data_Re(RAM_Block_N64_w2_bw32_3_io_in_data_Re),
    .io_in_data_Im(RAM_Block_N64_w2_bw32_3_io_in_data_Im),
    .io_in_offset_switch(RAM_Block_N64_w2_bw32_3_io_in_offset_switch),
    .io_in_valid(RAM_Block_N64_w2_bw32_3_io_in_valid),
    .io_in_en(RAM_Block_N64_w2_bw32_3_io_in_en),
    .io_out_data_Re(RAM_Block_N64_w2_bw32_3_io_out_data_Re),
    .io_out_data_Im(RAM_Block_N64_w2_bw32_3_io_out_data_Im)
  );
  assign io_out_0_Re = out_data_sr_r_2_Re; // @[PermutationDesigns.scala 356:{34,34}]
  assign io_out_0_Im = out_data_sr_r_2_Im; // @[PermutationDesigns.scala 356:{34,34}]
  assign io_out_1_Re = out_data_sr_r_3_Re; // @[PermutationDesigns.scala 356:{34,34}]
  assign io_out_1_Im = out_data_sr_r_3_Im; // @[PermutationDesigns.scala 356:{34,34}]
  assign io_out_valid = out_valid_sr_1; // @[PermutationDesigns.scala 360:22]
  assign RAM_Block_N64_w2_bw32_clock = clock;
  assign RAM_Block_N64_w2_bw32_io_in_raddr = _T_45[5:0]; // @[PermutationDesigns.scala 338:24]
  assign RAM_Block_N64_w2_bw32_io_in_waddr = _T_43[5:0]; // @[PermutationDesigns.scala 336:24]
  assign RAM_Block_N64_w2_bw32_io_in_data_Re = io_in_0_Re; // @[PermutationDesigns.scala 334:23]
  assign RAM_Block_N64_w2_bw32_io_in_data_Im = io_in_0_Im; // @[PermutationDesigns.scala 334:23]
  assign RAM_Block_N64_w2_bw32_io_in_offset_switch = value_7; // @[PermutationDesigns.scala 339:53]
  assign RAM_Block_N64_w2_bw32_io_in_valid = io_in_valid; // @[PermutationDesigns.scala 335:24]
  assign RAM_Block_N64_w2_bw32_io_in_en = io_in_en; // @[PermutationDesigns.scala 333:21]
  assign RAM_Block_N64_w2_bw32_1_clock = clock;
  assign RAM_Block_N64_w2_bw32_1_io_in_raddr = _T_54[5:0]; // @[PermutationDesigns.scala 338:24]
  assign RAM_Block_N64_w2_bw32_1_io_in_waddr = _T_43[5:0]; // @[PermutationDesigns.scala 336:24]
  assign RAM_Block_N64_w2_bw32_1_io_in_data_Re = io_in_1_Re; // @[PermutationDesigns.scala 334:23]
  assign RAM_Block_N64_w2_bw32_1_io_in_data_Im = io_in_1_Im; // @[PermutationDesigns.scala 334:23]
  assign RAM_Block_N64_w2_bw32_1_io_in_offset_switch = value_7; // @[PermutationDesigns.scala 339:53]
  assign RAM_Block_N64_w2_bw32_1_io_in_valid = io_in_valid; // @[PermutationDesigns.scala 335:24]
  assign RAM_Block_N64_w2_bw32_1_io_in_en = io_in_en; // @[PermutationDesigns.scala 333:21]
  assign PrePermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_cnt = value; // @[PermutationDesigns.scala 322:20]
  assign Permute_Config_ROM_N8_r2_base_r2_ptype0_w2_clock = clock;
  assign Permute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_en = io_in_en; // @[PermutationDesigns.scala 324:16]
  assign Permute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_cnt = value_5; // @[PermutationDesigns.scala 327:17]
  assign Permutation_Wiring_w2_bw32_clock = clock;
  assign Permutation_Wiring_w2_bw32_io_in_valid = M0_shiftregs_valid; // @[PermutationDesigns.scala 343:23]
  assign Permutation_Wiring_w2_bw32_io_in_0_Re = M0_shiftregs_data_r_Re; // @[PermutationDesigns.scala 228:{38,38}]
  assign Permutation_Wiring_w2_bw32_io_in_0_Im = M0_shiftregs_data_r_Im; // @[PermutationDesigns.scala 228:{38,38}]
  assign Permutation_Wiring_w2_bw32_io_in_1_Re = M0_shiftregs_data_r_1_Re; // @[PermutationDesigns.scala 228:{38,38}]
  assign Permutation_Wiring_w2_bw32_io_in_1_Im = M0_shiftregs_data_r_1_Im; // @[PermutationDesigns.scala 228:{38,38}]
  assign Permutation_Wiring_w2_bw32_io_in_config_0 = Permute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_out_0; // @[PermutationDesigns.scala 344:27]
  assign Permutation_Wiring_w2_bw32_io_in_en = io_in_en; // @[PermutationDesigns.scala 341:20]
  assign PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_clock = clock;
  assign PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_en = io_in_en; // @[PermutationDesigns.scala 328:20]
  assign PostPermute_Config_ROM_N8_r2_base_r2_ptype0_w2_io_in_cnt = value_6; // @[PermutationDesigns.scala 330:21]
  assign RAM_Block_N64_w2_bw32_2_clock = clock;
  assign RAM_Block_N64_w2_bw32_2_io_in_raddr = _T_50[5:0]; // @[PermutationDesigns.scala 351:24]
  assign RAM_Block_N64_w2_bw32_2_io_in_waddr = _T_48[5:0]; // @[PermutationDesigns.scala 350:24]
  assign RAM_Block_N64_w2_bw32_2_io_in_data_Re = Perm_shiftregs_data_r_Re; // @[PermutationDesigns.scala 214:{40,40}]
  assign RAM_Block_N64_w2_bw32_2_io_in_data_Im = Perm_shiftregs_data_r_Im; // @[PermutationDesigns.scala 214:{40,40}]
  assign RAM_Block_N64_w2_bw32_2_io_in_offset_switch = PostPC_swtchcnt_reg; // @[PermutationDesigns.scala 352:32]
  assign RAM_Block_N64_w2_bw32_2_io_in_valid = Perm_shiftregs_valid; // @[PermutationDesigns.scala 349:24]
  assign RAM_Block_N64_w2_bw32_2_io_in_en = io_in_en; // @[PermutationDesigns.scala 346:21]
  assign RAM_Block_N64_w2_bw32_3_clock = clock;
  assign RAM_Block_N64_w2_bw32_3_io_in_raddr = _T_50[5:0]; // @[PermutationDesigns.scala 351:24]
  assign RAM_Block_N64_w2_bw32_3_io_in_waddr = _T_57[5:0]; // @[PermutationDesigns.scala 350:24]
  assign RAM_Block_N64_w2_bw32_3_io_in_data_Re = Perm_shiftregs_data_r_1_Re; // @[PermutationDesigns.scala 214:{40,40}]
  assign RAM_Block_N64_w2_bw32_3_io_in_data_Im = Perm_shiftregs_data_r_1_Im; // @[PermutationDesigns.scala 214:{40,40}]
  assign RAM_Block_N64_w2_bw32_3_io_in_offset_switch = PostPC_swtchcnt_reg; // @[PermutationDesigns.scala 352:32]
  assign RAM_Block_N64_w2_bw32_3_io_in_valid = Perm_shiftregs_valid; // @[PermutationDesigns.scala 349:24]
  assign RAM_Block_N64_w2_bw32_3_io_in_en = io_in_en; // @[PermutationDesigns.scala 346:21]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_data_r_Re <= Permutation_Wiring_w2_bw32_io_out_0_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_data_r_Im <= Permutation_Wiring_w2_bw32_io_out_0_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_data_r_1_Re <= Permutation_Wiring_w2_bw32_io_out_1_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_data_r_1_Im <= Permutation_Wiring_w2_bw32_io_out_1_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_valid <= Permutation_Wiring_w2_bw32_io_out_valid; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[PermutationDesigns.scala 222:47]
      REG <= 1'h0; // @[PermutationDesigns.scala 222:47]
    end else if (io_in_en & REG) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_9) begin // @[PermutationDesigns.scala 292:56]
        if (wrap_10) begin // @[PermutationDesigns.scala 294:60]
          REG <= _GEN_46;
        end else begin
          REG <= _GEN_24;
        end
      end else begin
        REG <= _GEN_24;
      end
    end else begin
      REG <= _GEN_24;
    end
    if (reset) begin // @[PermutationDesigns.scala 222:47]
      REG_1 <= 1'h0; // @[PermutationDesigns.scala 222:47]
    end else if (io_in_en & REG_1) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_12) begin // @[PermutationDesigns.scala 292:56]
        if (wrap_13) begin // @[PermutationDesigns.scala 294:60]
          REG_1 <= _GEN_60;
        end else begin
          REG_1 <= _GEN_44;
        end
      end else begin
        REG_1 <= _GEN_44;
      end
    end else begin
      REG_1 <= _GEN_44;
    end
    if (reset) begin // @[Counter.scala 62:40]
      value <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & REG) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_9) begin // @[PermutationDesigns.scala 292:56]
        if (wrap_10) begin // @[PermutationDesigns.scala 294:60]
          value <= _value_T_23; // @[Counter.scala 78:15]
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_1 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & REG_1) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_12) begin // @[PermutationDesigns.scala 292:56]
        if (wrap_13) begin // @[PermutationDesigns.scala 294:60]
          value_1 <= _value_T_29; // @[Counter.scala 78:15]
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_2 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & REG) begin // @[PermutationDesigns.scala 290:41]
      value_2 <= _value_T_19; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_3 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & REG_1) begin // @[PermutationDesigns.scala 290:41]
      value_3 <= _value_T_25; // @[Counter.scala 78:15]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      r <= _T_1; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      r_1 <= _T_3; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_data_r_Re <= RAM_Block_N64_w2_bw32_io_out_data_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_data_r_Im <= RAM_Block_N64_w2_bw32_io_out_data_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_data_r_1_Re <= RAM_Block_N64_w2_bw32_1_io_out_data_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_data_r_1_Im <= RAM_Block_N64_w2_bw32_1_io_out_data_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_valid <= r; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_4 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & io_in_valid) begin // @[PermutationDesigns.scala 243:35]
      if (wrap) begin // @[PermutationDesigns.scala 245:54]
        value_4 <= _value_T_3; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_5 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & r) begin // @[PermutationDesigns.scala 257:40]
      if (wrap_3) begin // @[PermutationDesigns.scala 259:54]
        value_5 <= _value_T_9; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_6 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & Permutation_Wiring_w2_bw32_io_out_valid) begin // @[PermutationDesigns.scala 269:38]
      if (wrap_6) begin // @[PermutationDesigns.scala 271:54]
        value_6 <= _value_T_15; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_7 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & io_in_valid) begin // @[PermutationDesigns.scala 243:35]
      if (wrap) begin // @[PermutationDesigns.scala 245:54]
        if (wrap_1) begin // @[PermutationDesigns.scala 248:52]
          value_7 <= value_7 + 1'h1; // @[Counter.scala 78:15]
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_9 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & Permutation_Wiring_w2_bw32_io_out_valid) begin // @[PermutationDesigns.scala 269:38]
      if (wrap_6) begin // @[PermutationDesigns.scala 271:54]
        if (wrap_7) begin // @[PermutationDesigns.scala 274:52]
          value_9 <= value_9 + 1'h1; // @[Counter.scala 78:15]
        end
      end
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      PostPC_fullcnt_reg <= value_6; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      PostPC_swtchcnt_reg <= value_9; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_10 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & io_in_valid) begin // @[PermutationDesigns.scala 243:35]
      value_10 <= _value_T_1; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_11 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & r) begin // @[PermutationDesigns.scala 257:40]
      value_11 <= _value_T_7; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_12 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & Permutation_Wiring_w2_bw32_io_out_valid) begin // @[PermutationDesigns.scala 269:38]
      value_12 <= _value_T_13; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_13 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & REG) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_9) begin // @[PermutationDesigns.scala 292:56]
        value_13 <= _value_T_21; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_14 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & REG_1) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_12) begin // @[PermutationDesigns.scala 292:56]
        value_14 <= _value_T_27; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[PermutationDesigns.scala 238:50]
      REG_2 <= 32'h0; // @[PermutationDesigns.scala 238:50]
    end else if (io_in_en & io_in_valid) begin // @[PermutationDesigns.scala 243:35]
      if (wrap) begin // @[PermutationDesigns.scala 245:54]
        REG_2 <= 32'h0; // @[PermutationDesigns.scala 247:30]
      end else begin
        REG_2 <= _T_8; // @[PermutationDesigns.scala 253:30]
      end
    end
    if (reset) begin // @[PermutationDesigns.scala 238:50]
      REG_4 <= 32'h0; // @[PermutationDesigns.scala 238:50]
    end else if (io_in_en & Permutation_Wiring_w2_bw32_io_out_valid) begin // @[PermutationDesigns.scala 269:38]
      if (wrap_6) begin // @[PermutationDesigns.scala 271:54]
        REG_4 <= 32'h0; // @[PermutationDesigns.scala 273:30]
      end else begin
        REG_4 <= _T_18; // @[PermutationDesigns.scala 278:30]
      end
    end
    if (reset) begin // @[PermutationDesigns.scala 238:50]
      REG_5 <= 32'h0; // @[PermutationDesigns.scala 238:50]
    end else if (io_in_en & REG) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_9) begin // @[PermutationDesigns.scala 292:56]
        if (wrap_10) begin // @[PermutationDesigns.scala 294:60]
          REG_5 <= 32'h0; // @[PermutationDesigns.scala 296:36]
        end else begin
          REG_5 <= _T_30; // @[PermutationDesigns.scala 313:36]
        end
      end
    end
    if (reset) begin // @[PermutationDesigns.scala 238:50]
      REG_6 <= 32'h0; // @[PermutationDesigns.scala 238:50]
    end else if (io_in_en & REG_1) begin // @[PermutationDesigns.scala 290:41]
      if (wrap_12) begin // @[PermutationDesigns.scala 292:56]
        if (wrap_13) begin // @[PermutationDesigns.scala 294:60]
          REG_6 <= 32'h0; // @[PermutationDesigns.scala 296:36]
        end else begin
          REG_6 <= _T_39; // @[PermutationDesigns.scala 313:36]
        end
      end
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      r_2 <= value_12; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      r_3 <= REG_4; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      r_4 <= REG_4; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_valid_sr_1 <= r_1; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_data_sr_r_2_Re <= RAM_Block_N64_w2_bw32_2_io_out_data_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_data_sr_r_2_Im <= RAM_Block_N64_w2_bw32_2_io_out_data_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_data_sr_r_3_Re <= RAM_Block_N64_w2_bw32_3_io_out_data_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_data_sr_r_3_Im <= RAM_Block_N64_w2_bw32_3_io_out_data_Im; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  Perm_shiftregs_data_r_Re = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  Perm_shiftregs_data_r_Im = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  Perm_shiftregs_data_r_1_Re = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  Perm_shiftregs_data_r_1_Im = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  Perm_shiftregs_valid = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  REG = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  REG_1 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  value = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  value_1 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  value_2 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  value_3 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  r = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  r_1 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  M0_shiftregs_data_r_Re = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  M0_shiftregs_data_r_Im = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  M0_shiftregs_data_r_1_Re = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  M0_shiftregs_data_r_1_Im = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  M0_shiftregs_valid = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  value_4 = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  value_5 = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  value_6 = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  value_7 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  value_9 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  PostPC_fullcnt_reg = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  PostPC_swtchcnt_reg = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  value_10 = _RAND_25[2:0];
  _RAND_26 = {1{`RANDOM}};
  value_11 = _RAND_26[2:0];
  _RAND_27 = {1{`RANDOM}};
  value_12 = _RAND_27[2:0];
  _RAND_28 = {1{`RANDOM}};
  value_13 = _RAND_28[2:0];
  _RAND_29 = {1{`RANDOM}};
  value_14 = _RAND_29[2:0];
  _RAND_30 = {1{`RANDOM}};
  REG_2 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  REG_4 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  REG_5 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  REG_6 = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  r_2 = _RAND_34[2:0];
  _RAND_35 = {1{`RANDOM}};
  r_3 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  r_4 = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  out_valid_sr_1 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  out_data_sr_r_2_Re = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  out_data_sr_r_2_Im = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  out_data_sr_r_3_Re = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  out_data_sr_r_3_Im = _RAND_41[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32(
  input         io_in_inv,
  input  [2:0]  io_in_addr,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
  wire [31:0] _GEN_10 = 2'h2 == io_in_addr[1:0] ? 32'hbed51130 : 32'h3f800000; // @[TwidFactorDesigns.scala 66:{27,27}]
  wire [31:0] _GEN_11 = 2'h3 == io_in_addr[1:0] ? 32'hbed51130 : _GEN_10; // @[TwidFactorDesigns.scala 66:{27,27}]
  wire [31:0] _GEN_14 = 2'h2 == io_in_addr[1:0] ? 32'h3f68c7b6 : 32'h0; // @[TwidFactorDesigns.scala 67:{27,27}]
  wire [31:0] _GEN_15 = 2'h3 == io_in_addr[1:0] ? 32'h3f68c7b6 : _GEN_14; // @[TwidFactorDesigns.scala 67:{27,27}]
  wire [31:0] _GEN_26 = 2'h2 == io_in_addr[1:0] ? 32'h248d3131 : 32'h3f800000; // @[TwidFactorDesigns.scala 71:{27,27}]
  wire [31:0] _GEN_27 = 2'h3 == io_in_addr[1:0] ? 32'h248d3131 : _GEN_26; // @[TwidFactorDesigns.scala 71:{27,27}]
  wire [31:0] _GEN_30 = 2'h2 == io_in_addr[1:0] ? 32'hbf800000 : 32'h80800000; // @[TwidFactorDesigns.scala 72:{27,27}]
  wire [31:0] _GEN_31 = 2'h3 == io_in_addr[1:0] ? 32'hbf800000 : _GEN_30; // @[TwidFactorDesigns.scala 72:{27,27}]
  assign io_out_data_1_Re = io_in_inv ? _GEN_11 : _GEN_27; // @[TwidFactorDesigns.scala 64:21 66:27 71:27]
  assign io_out_data_1_Im = io_in_inv ? _GEN_15 : _GEN_31; // @[TwidFactorDesigns.scala 64:21 67:27 72:27]
endmodule
module FPComplexScale_NonFPMult_bw32(
  input         clock,
  input         reset,
  input  [31:0] io_in_Re,
  input  [31:0] io_in_Im,
  input         io_in_en,
  input         io_is_neg,
  input         io_is_flip,
  output [31:0] io_out_Re,
  output [31:0] io_out_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  sign_0 = io_in_Re[31]; // @[FPComplex.scala 738:24]
  wire  sign_1 = io_in_Im[31]; // @[FPComplex.scala 739:24]
  wire [7:0] exp_0 = io_in_Re[30:23]; // @[FPComplex.scala 741:23]
  wire [7:0] exp_1 = io_in_Im[30:23]; // @[FPComplex.scala 742:23]
  wire [22:0] frac_0 = io_in_Re[22:0]; // @[FPComplex.scala 744:24]
  wire [22:0] frac_1 = io_in_Im[22:0]; // @[FPComplex.scala 745:24]
  wire  new_sign_0 = io_is_neg ? ~sign_0 : sign_0; // @[FPComplex.scala 747:21 748:19 751:19]
  wire  new_sign_1 = io_is_neg ? ~sign_1 : sign_1; // @[FPComplex.scala 747:21 749:19 752:19]
  wire [7:0] _new_exp_0_T_1 = exp_0 - 8'h0; // @[FPComplex.scala 756:28]
  wire [7:0] new_exp_0 = exp_0 != 8'h0 ? _new_exp_0_T_1 : exp_0; // @[FPComplex.scala 755:26 756:18 758:18]
  wire [7:0] _new_exp_1_T_1 = exp_1 - 8'h0; // @[FPComplex.scala 761:28]
  wire [7:0] new_exp_1 = exp_1 != 8'h0 ? _new_exp_1_T_1 : exp_1; // @[FPComplex.scala 760:26 761:18 763:18]
  reg [31:0] out_reg_save_Re; // @[FPComplex.scala 766:31]
  reg [31:0] out_reg_save_Im; // @[FPComplex.scala 766:31]
  wire  _io_out_Re_T = ~new_sign_1; // @[FPComplex.scala 769:23]
  wire [31:0] _io_out_Re_T_2 = {_io_out_Re_T,new_exp_1,frac_1}; // @[FPComplex.scala 769:51]
  wire [31:0] _io_out_Im_T_1 = {new_sign_0,new_exp_0,frac_0}; // @[FPComplex.scala 770:50]
  wire [31:0] _GEN_4 = io_in_en ? _io_out_Re_T_2 : out_reg_save_Re; // @[FPComplex.scala 768:22 769:19 774:19]
  wire [31:0] _GEN_5 = io_in_en ? _io_out_Im_T_1 : out_reg_save_Im; // @[FPComplex.scala 768:22 770:19 775:19]
  wire [31:0] _io_out_Im_T_3 = {new_sign_1,new_exp_1,frac_1}; // @[FPComplex.scala 780:50]
  wire [31:0] _GEN_8 = io_in_en ? _io_out_Im_T_1 : out_reg_save_Re; // @[FPComplex.scala 778:22 779:19 784:19]
  wire [31:0] _GEN_9 = io_in_en ? _io_out_Im_T_3 : out_reg_save_Im; // @[FPComplex.scala 778:22 780:19 785:19]
  assign io_out_Re = io_is_flip ? _GEN_4 : _GEN_8; // @[FPComplex.scala 767:22]
  assign io_out_Im = io_is_flip ? _GEN_5 : _GEN_9; // @[FPComplex.scala 767:22]
  always @(posedge clock) begin
    if (reset) begin // @[FPComplex.scala 766:31]
      out_reg_save_Re <= 32'h0; // @[FPComplex.scala 766:31]
    end else if (io_is_flip) begin // @[FPComplex.scala 767:22]
      if (io_in_en) begin // @[FPComplex.scala 768:22]
        out_reg_save_Re <= _io_out_Re_T_2; // @[FPComplex.scala 769:19]
      end
    end else if (io_in_en) begin // @[FPComplex.scala 778:22]
      out_reg_save_Re <= _io_out_Im_T_1; // @[FPComplex.scala 779:19]
    end
    if (reset) begin // @[FPComplex.scala 766:31]
      out_reg_save_Im <= 32'h0; // @[FPComplex.scala 766:31]
    end else if (io_is_flip) begin // @[FPComplex.scala 767:22]
      if (io_in_en) begin // @[FPComplex.scala 768:22]
        out_reg_save_Im <= _io_out_Im_T_1; // @[FPComplex.scala 770:19]
      end
    end else if (io_in_en) begin // @[FPComplex.scala 778:22]
      out_reg_save_Im <= _io_out_Im_T_3; // @[FPComplex.scala 780:19]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  out_reg_save_Re = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  out_reg_save_Im = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32(
  input         clock,
  input         reset,
  input         io_in_inv,
  input         io_in_en_main,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  input         io_in_valid,
  output        io_out_valid,
  output [31:0] io_out_0_Re,
  output [31:0] io_out_0_Im,
  output [31:0] io_out_1_Re,
  output [31:0] io_out_1_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
`endif // RANDOMIZE_REG_INIT
  wire  TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_in_inv; // @[TwidFactorDesigns.scala 280:26]
  wire [2:0] TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_in_addr; // @[TwidFactorDesigns.scala 280:26]
  wire [31:0] TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_out_data_1_Re; // @[TwidFactorDesigns.scala 280:26]
  wire [31:0] TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_out_data_1_Im; // @[TwidFactorDesigns.scala 280:26]
  wire  FPComplexScale_NonFPMult_bw32_clock; // @[TwidFactorDesigns.scala 335:30]
  wire  FPComplexScale_NonFPMult_bw32_reset; // @[TwidFactorDesigns.scala 335:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_io_in_Re; // @[TwidFactorDesigns.scala 335:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_io_in_Im; // @[TwidFactorDesigns.scala 335:30]
  wire  FPComplexScale_NonFPMult_bw32_io_in_en; // @[TwidFactorDesigns.scala 335:30]
  wire  FPComplexScale_NonFPMult_bw32_io_is_neg; // @[TwidFactorDesigns.scala 335:30]
  wire  FPComplexScale_NonFPMult_bw32_io_is_flip; // @[TwidFactorDesigns.scala 335:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_io_out_Re; // @[TwidFactorDesigns.scala 335:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_io_out_Im; // @[TwidFactorDesigns.scala 335:30]
  wire  FPComplexScale_NonFPMult_bw32_1_clock; // @[TwidFactorDesigns.scala 335:30]
  wire  FPComplexScale_NonFPMult_bw32_1_reset; // @[TwidFactorDesigns.scala 335:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_1_io_in_Re; // @[TwidFactorDesigns.scala 335:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_1_io_in_Im; // @[TwidFactorDesigns.scala 335:30]
  wire  FPComplexScale_NonFPMult_bw32_1_io_in_en; // @[TwidFactorDesigns.scala 335:30]
  wire  FPComplexScale_NonFPMult_bw32_1_io_is_neg; // @[TwidFactorDesigns.scala 335:30]
  wire  FPComplexScale_NonFPMult_bw32_1_io_is_flip; // @[TwidFactorDesigns.scala 335:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_1_io_out_Re; // @[TwidFactorDesigns.scala 335:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_1_io_out_Im; // @[TwidFactorDesigns.scala 335:30]
  reg  sr_valid_regs_r; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_1; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_2; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_3; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_4; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_5; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_6; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_7; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_8; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_9; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_10; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_11; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_12; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_13; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_14; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_15; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_16; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_17; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_18; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_19; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_20; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_21; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_22; // @[Reg.scala 16:16]
  reg  sr_valid_regs; // @[Reg.scala 16:16]
  reg [2:0] value; // @[Counter.scala 62:40]
  reg [1:0] cnt; // @[TwidFactorDesigns.scala 333:24]
  wire  wrap = value == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_1 = value + 3'h1; // @[Counter.scala 78:24]
  wire [1:0] _cnt_T_1 = cnt + 2'h1; // @[TwidFactorDesigns.scala 369:26]
  wire [1:0] _GEN_32 = cnt == 2'h3 ? 2'h0 : _cnt_T_1; // @[TwidFactorDesigns.scala 366:43 367:19 369:19]
  reg [31:0] sr_result_regs_r_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_1_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_1_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_2_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_2_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_3_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_3_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_4_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_4_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_5_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_5_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_6_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_6_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_7_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_7_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_8_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_8_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_9_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_9_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_10_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_10_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_11_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_11_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_12_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_12_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_13_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_13_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_14_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_14_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_15_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_15_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_16_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_16_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_17_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_17_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_18_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_18_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_19_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_19_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_20_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_20_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_21_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_21_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_22_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_22_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_23_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_23_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_24_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_24_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_25_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_25_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_26_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_26_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_27_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_27_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_28_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_28_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_29_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_29_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_30_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_30_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_31_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_31_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_32_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_32_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_33_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_33_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_34_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_34_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_35_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_35_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_36_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_36_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_37_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_37_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_38_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_38_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_39_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_39_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_40_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_40_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_41_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_41_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_42_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_42_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_43_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_43_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_44_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_44_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_45_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_45_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_46_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_46_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_47_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_47_Im; // @[Reg.scala 16:16]
  TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32 TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32 ( // @[TwidFactorDesigns.scala 280:26]
    .io_in_inv(TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_in_inv),
    .io_in_addr(TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_in_addr),
    .io_out_data_1_Re(TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_out_data_1_Re),
    .io_out_data_1_Im(TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_out_data_1_Im)
  );
  FPComplexScale_NonFPMult_bw32 FPComplexScale_NonFPMult_bw32 ( // @[TwidFactorDesigns.scala 335:30]
    .clock(FPComplexScale_NonFPMult_bw32_clock),
    .reset(FPComplexScale_NonFPMult_bw32_reset),
    .io_in_Re(FPComplexScale_NonFPMult_bw32_io_in_Re),
    .io_in_Im(FPComplexScale_NonFPMult_bw32_io_in_Im),
    .io_in_en(FPComplexScale_NonFPMult_bw32_io_in_en),
    .io_is_neg(FPComplexScale_NonFPMult_bw32_io_is_neg),
    .io_is_flip(FPComplexScale_NonFPMult_bw32_io_is_flip),
    .io_out_Re(FPComplexScale_NonFPMult_bw32_io_out_Re),
    .io_out_Im(FPComplexScale_NonFPMult_bw32_io_out_Im)
  );
  FPComplexScale_NonFPMult_bw32 FPComplexScale_NonFPMult_bw32_1 ( // @[TwidFactorDesigns.scala 335:30]
    .clock(FPComplexScale_NonFPMult_bw32_1_clock),
    .reset(FPComplexScale_NonFPMult_bw32_1_reset),
    .io_in_Re(FPComplexScale_NonFPMult_bw32_1_io_in_Re),
    .io_in_Im(FPComplexScale_NonFPMult_bw32_1_io_in_Im),
    .io_in_en(FPComplexScale_NonFPMult_bw32_1_io_in_en),
    .io_is_neg(FPComplexScale_NonFPMult_bw32_1_io_is_neg),
    .io_is_flip(FPComplexScale_NonFPMult_bw32_1_io_is_flip),
    .io_out_Re(FPComplexScale_NonFPMult_bw32_1_io_out_Re),
    .io_out_Im(FPComplexScale_NonFPMult_bw32_1_io_out_Im)
  );
  assign io_out_valid = sr_valid_regs; // @[TwidFactorDesigns.scala 282:18]
  assign io_out_0_Re = sr_result_regs_r_23_Re; // @[TwidFactorDesigns.scala 401:{35,35}]
  assign io_out_0_Im = sr_result_regs_r_23_Im; // @[TwidFactorDesigns.scala 401:{35,35}]
  assign io_out_1_Re = sr_result_regs_r_47_Re; // @[TwidFactorDesigns.scala 401:{35,35}]
  assign io_out_1_Im = sr_result_regs_r_47_Im; // @[TwidFactorDesigns.scala 401:{35,35}]
  assign TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_in_inv = io_in_inv; // @[TwidFactorDesigns.scala 406:23]
  assign TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_in_addr = {{1'd0}, cnt}; // @[TwidFactorDesigns.scala 405:24]
  assign FPComplexScale_NonFPMult_bw32_clock = clock;
  assign FPComplexScale_NonFPMult_bw32_reset = reset;
  assign FPComplexScale_NonFPMult_bw32_io_in_Re = io_in_0_Re; // @[TwidFactorDesigns.scala 344:27]
  assign FPComplexScale_NonFPMult_bw32_io_in_Im = io_in_0_Im; // @[TwidFactorDesigns.scala 344:27]
  assign FPComplexScale_NonFPMult_bw32_io_in_en = io_in_en_main; // @[TwidFactorDesigns.scala 339:30]
  assign FPComplexScale_NonFPMult_bw32_io_is_neg = 1'h0; // @[TwidFactorDesigns.scala 346:94]
  assign FPComplexScale_NonFPMult_bw32_io_is_flip = 1'h0; // @[TwidFactorDesigns.scala 346:94 347:34 354:34]
  assign FPComplexScale_NonFPMult_bw32_1_clock = clock;
  assign FPComplexScale_NonFPMult_bw32_1_reset = reset;
  assign FPComplexScale_NonFPMult_bw32_1_io_in_Re = io_in_1_Re; // @[TwidFactorDesigns.scala 344:27]
  assign FPComplexScale_NonFPMult_bw32_1_io_in_Im = io_in_1_Im; // @[TwidFactorDesigns.scala 344:27]
  assign FPComplexScale_NonFPMult_bw32_1_io_in_en = io_in_en_main; // @[TwidFactorDesigns.scala 339:30]
  assign FPComplexScale_NonFPMult_bw32_1_io_is_neg = TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_out_data_1_Re
    [30:0] == 31'h3f800000 ? TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_out_data_1_Re[31] :
    TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_out_data_1_Im[31]; // @[TwidFactorDesigns.scala 346:94]
  assign FPComplexScale_NonFPMult_bw32_1_io_is_flip =
    TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage0_bw32_io_out_data_1_Re[30:0] == 31'h3f800000 ? 1'h0 : 1'h1; // @[TwidFactorDesigns.scala 346:94 347:34 354:34]
  always @(posedge clock) begin
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r <= io_in_valid; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_1 <= sr_valid_regs_r; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_2 <= sr_valid_regs_r_1; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_3 <= sr_valid_regs_r_2; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_4 <= sr_valid_regs_r_3; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_5 <= sr_valid_regs_r_4; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_6 <= sr_valid_regs_r_5; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_7 <= sr_valid_regs_r_6; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_8 <= sr_valid_regs_r_7; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_9 <= sr_valid_regs_r_8; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_10 <= sr_valid_regs_r_9; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_11 <= sr_valid_regs_r_10; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_12 <= sr_valid_regs_r_11; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_13 <= sr_valid_regs_r_12; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_14 <= sr_valid_regs_r_13; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_15 <= sr_valid_regs_r_14; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_16 <= sr_valid_regs_r_15; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_17 <= sr_valid_regs_r_16; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_18 <= sr_valid_regs_r_17; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_19 <= sr_valid_regs_r_18; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_20 <= sr_valid_regs_r_19; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_21 <= sr_valid_regs_r_20; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_22 <= sr_valid_regs_r_21; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs <= sr_valid_regs_r_22; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_en_main) begin // @[TwidFactorDesigns.scala 362:27]
      if (io_in_valid) begin // @[TwidFactorDesigns.scala 363:27]
        value <= _value_T_1; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[TwidFactorDesigns.scala 333:24]
      cnt <= 2'h0; // @[TwidFactorDesigns.scala 333:24]
    end else if (io_in_en_main) begin // @[TwidFactorDesigns.scala 362:27]
      if (io_in_valid) begin // @[TwidFactorDesigns.scala 363:27]
        if (wrap) begin // @[TwidFactorDesigns.scala 365:53]
          cnt <= _GEN_32;
        end
      end
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_Re <= FPComplexScale_NonFPMult_bw32_io_out_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_Im <= FPComplexScale_NonFPMult_bw32_io_out_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_1_Re <= sr_result_regs_r_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_1_Im <= sr_result_regs_r_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_2_Re <= sr_result_regs_r_1_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_2_Im <= sr_result_regs_r_1_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_3_Re <= sr_result_regs_r_2_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_3_Im <= sr_result_regs_r_2_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_4_Re <= sr_result_regs_r_3_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_4_Im <= sr_result_regs_r_3_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_5_Re <= sr_result_regs_r_4_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_5_Im <= sr_result_regs_r_4_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_6_Re <= sr_result_regs_r_5_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_6_Im <= sr_result_regs_r_5_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_7_Re <= sr_result_regs_r_6_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_7_Im <= sr_result_regs_r_6_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_8_Re <= sr_result_regs_r_7_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_8_Im <= sr_result_regs_r_7_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_9_Re <= sr_result_regs_r_8_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_9_Im <= sr_result_regs_r_8_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_10_Re <= sr_result_regs_r_9_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_10_Im <= sr_result_regs_r_9_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_11_Re <= sr_result_regs_r_10_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_11_Im <= sr_result_regs_r_10_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_12_Re <= sr_result_regs_r_11_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_12_Im <= sr_result_regs_r_11_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_13_Re <= sr_result_regs_r_12_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_13_Im <= sr_result_regs_r_12_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_14_Re <= sr_result_regs_r_13_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_14_Im <= sr_result_regs_r_13_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_15_Re <= sr_result_regs_r_14_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_15_Im <= sr_result_regs_r_14_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_16_Re <= sr_result_regs_r_15_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_16_Im <= sr_result_regs_r_15_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_17_Re <= sr_result_regs_r_16_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_17_Im <= sr_result_regs_r_16_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_18_Re <= sr_result_regs_r_17_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_18_Im <= sr_result_regs_r_17_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_19_Re <= sr_result_regs_r_18_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_19_Im <= sr_result_regs_r_18_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_20_Re <= sr_result_regs_r_19_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_20_Im <= sr_result_regs_r_19_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_21_Re <= sr_result_regs_r_20_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_21_Im <= sr_result_regs_r_20_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_22_Re <= sr_result_regs_r_21_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_22_Im <= sr_result_regs_r_21_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_23_Re <= sr_result_regs_r_22_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_23_Im <= sr_result_regs_r_22_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_24_Re <= FPComplexScale_NonFPMult_bw32_1_io_out_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_24_Im <= FPComplexScale_NonFPMult_bw32_1_io_out_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_25_Re <= sr_result_regs_r_24_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_25_Im <= sr_result_regs_r_24_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_26_Re <= sr_result_regs_r_25_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_26_Im <= sr_result_regs_r_25_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_27_Re <= sr_result_regs_r_26_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_27_Im <= sr_result_regs_r_26_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_28_Re <= sr_result_regs_r_27_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_28_Im <= sr_result_regs_r_27_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_29_Re <= sr_result_regs_r_28_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_29_Im <= sr_result_regs_r_28_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_30_Re <= sr_result_regs_r_29_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_30_Im <= sr_result_regs_r_29_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_31_Re <= sr_result_regs_r_30_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_31_Im <= sr_result_regs_r_30_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_32_Re <= sr_result_regs_r_31_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_32_Im <= sr_result_regs_r_31_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_33_Re <= sr_result_regs_r_32_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_33_Im <= sr_result_regs_r_32_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_34_Re <= sr_result_regs_r_33_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_34_Im <= sr_result_regs_r_33_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_35_Re <= sr_result_regs_r_34_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_35_Im <= sr_result_regs_r_34_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_36_Re <= sr_result_regs_r_35_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_36_Im <= sr_result_regs_r_35_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_37_Re <= sr_result_regs_r_36_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_37_Im <= sr_result_regs_r_36_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_38_Re <= sr_result_regs_r_37_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_38_Im <= sr_result_regs_r_37_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_39_Re <= sr_result_regs_r_38_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_39_Im <= sr_result_regs_r_38_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_40_Re <= sr_result_regs_r_39_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_40_Im <= sr_result_regs_r_39_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_41_Re <= sr_result_regs_r_40_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_41_Im <= sr_result_regs_r_40_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_42_Re <= sr_result_regs_r_41_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_42_Im <= sr_result_regs_r_41_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_43_Re <= sr_result_regs_r_42_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_43_Im <= sr_result_regs_r_42_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_44_Re <= sr_result_regs_r_43_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_44_Im <= sr_result_regs_r_43_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_45_Re <= sr_result_regs_r_44_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_45_Im <= sr_result_regs_r_44_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_46_Re <= sr_result_regs_r_45_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_46_Im <= sr_result_regs_r_45_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_47_Re <= sr_result_regs_r_46_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_47_Im <= sr_result_regs_r_46_Im; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sr_valid_regs_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  sr_valid_regs_r_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  sr_valid_regs_r_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  sr_valid_regs_r_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  sr_valid_regs_r_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  sr_valid_regs_r_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  sr_valid_regs_r_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  sr_valid_regs_r_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  sr_valid_regs_r_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  sr_valid_regs_r_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sr_valid_regs_r_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  sr_valid_regs_r_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sr_valid_regs_r_12 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  sr_valid_regs_r_13 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sr_valid_regs_r_14 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  sr_valid_regs_r_15 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  sr_valid_regs_r_16 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sr_valid_regs_r_17 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  sr_valid_regs_r_18 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  sr_valid_regs_r_19 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  sr_valid_regs_r_20 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  sr_valid_regs_r_21 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  sr_valid_regs_r_22 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  sr_valid_regs = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  value = _RAND_24[2:0];
  _RAND_25 = {1{`RANDOM}};
  cnt = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  sr_result_regs_r_Re = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  sr_result_regs_r_Im = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  sr_result_regs_r_1_Re = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  sr_result_regs_r_1_Im = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  sr_result_regs_r_2_Re = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  sr_result_regs_r_2_Im = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  sr_result_regs_r_3_Re = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  sr_result_regs_r_3_Im = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  sr_result_regs_r_4_Re = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  sr_result_regs_r_4_Im = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  sr_result_regs_r_5_Re = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  sr_result_regs_r_5_Im = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  sr_result_regs_r_6_Re = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  sr_result_regs_r_6_Im = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  sr_result_regs_r_7_Re = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  sr_result_regs_r_7_Im = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  sr_result_regs_r_8_Re = _RAND_42[31:0];
  _RAND_43 = {1{`RANDOM}};
  sr_result_regs_r_8_Im = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  sr_result_regs_r_9_Re = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  sr_result_regs_r_9_Im = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  sr_result_regs_r_10_Re = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  sr_result_regs_r_10_Im = _RAND_47[31:0];
  _RAND_48 = {1{`RANDOM}};
  sr_result_regs_r_11_Re = _RAND_48[31:0];
  _RAND_49 = {1{`RANDOM}};
  sr_result_regs_r_11_Im = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  sr_result_regs_r_12_Re = _RAND_50[31:0];
  _RAND_51 = {1{`RANDOM}};
  sr_result_regs_r_12_Im = _RAND_51[31:0];
  _RAND_52 = {1{`RANDOM}};
  sr_result_regs_r_13_Re = _RAND_52[31:0];
  _RAND_53 = {1{`RANDOM}};
  sr_result_regs_r_13_Im = _RAND_53[31:0];
  _RAND_54 = {1{`RANDOM}};
  sr_result_regs_r_14_Re = _RAND_54[31:0];
  _RAND_55 = {1{`RANDOM}};
  sr_result_regs_r_14_Im = _RAND_55[31:0];
  _RAND_56 = {1{`RANDOM}};
  sr_result_regs_r_15_Re = _RAND_56[31:0];
  _RAND_57 = {1{`RANDOM}};
  sr_result_regs_r_15_Im = _RAND_57[31:0];
  _RAND_58 = {1{`RANDOM}};
  sr_result_regs_r_16_Re = _RAND_58[31:0];
  _RAND_59 = {1{`RANDOM}};
  sr_result_regs_r_16_Im = _RAND_59[31:0];
  _RAND_60 = {1{`RANDOM}};
  sr_result_regs_r_17_Re = _RAND_60[31:0];
  _RAND_61 = {1{`RANDOM}};
  sr_result_regs_r_17_Im = _RAND_61[31:0];
  _RAND_62 = {1{`RANDOM}};
  sr_result_regs_r_18_Re = _RAND_62[31:0];
  _RAND_63 = {1{`RANDOM}};
  sr_result_regs_r_18_Im = _RAND_63[31:0];
  _RAND_64 = {1{`RANDOM}};
  sr_result_regs_r_19_Re = _RAND_64[31:0];
  _RAND_65 = {1{`RANDOM}};
  sr_result_regs_r_19_Im = _RAND_65[31:0];
  _RAND_66 = {1{`RANDOM}};
  sr_result_regs_r_20_Re = _RAND_66[31:0];
  _RAND_67 = {1{`RANDOM}};
  sr_result_regs_r_20_Im = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  sr_result_regs_r_21_Re = _RAND_68[31:0];
  _RAND_69 = {1{`RANDOM}};
  sr_result_regs_r_21_Im = _RAND_69[31:0];
  _RAND_70 = {1{`RANDOM}};
  sr_result_regs_r_22_Re = _RAND_70[31:0];
  _RAND_71 = {1{`RANDOM}};
  sr_result_regs_r_22_Im = _RAND_71[31:0];
  _RAND_72 = {1{`RANDOM}};
  sr_result_regs_r_23_Re = _RAND_72[31:0];
  _RAND_73 = {1{`RANDOM}};
  sr_result_regs_r_23_Im = _RAND_73[31:0];
  _RAND_74 = {1{`RANDOM}};
  sr_result_regs_r_24_Re = _RAND_74[31:0];
  _RAND_75 = {1{`RANDOM}};
  sr_result_regs_r_24_Im = _RAND_75[31:0];
  _RAND_76 = {1{`RANDOM}};
  sr_result_regs_r_25_Re = _RAND_76[31:0];
  _RAND_77 = {1{`RANDOM}};
  sr_result_regs_r_25_Im = _RAND_77[31:0];
  _RAND_78 = {1{`RANDOM}};
  sr_result_regs_r_26_Re = _RAND_78[31:0];
  _RAND_79 = {1{`RANDOM}};
  sr_result_regs_r_26_Im = _RAND_79[31:0];
  _RAND_80 = {1{`RANDOM}};
  sr_result_regs_r_27_Re = _RAND_80[31:0];
  _RAND_81 = {1{`RANDOM}};
  sr_result_regs_r_27_Im = _RAND_81[31:0];
  _RAND_82 = {1{`RANDOM}};
  sr_result_regs_r_28_Re = _RAND_82[31:0];
  _RAND_83 = {1{`RANDOM}};
  sr_result_regs_r_28_Im = _RAND_83[31:0];
  _RAND_84 = {1{`RANDOM}};
  sr_result_regs_r_29_Re = _RAND_84[31:0];
  _RAND_85 = {1{`RANDOM}};
  sr_result_regs_r_29_Im = _RAND_85[31:0];
  _RAND_86 = {1{`RANDOM}};
  sr_result_regs_r_30_Re = _RAND_86[31:0];
  _RAND_87 = {1{`RANDOM}};
  sr_result_regs_r_30_Im = _RAND_87[31:0];
  _RAND_88 = {1{`RANDOM}};
  sr_result_regs_r_31_Re = _RAND_88[31:0];
  _RAND_89 = {1{`RANDOM}};
  sr_result_regs_r_31_Im = _RAND_89[31:0];
  _RAND_90 = {1{`RANDOM}};
  sr_result_regs_r_32_Re = _RAND_90[31:0];
  _RAND_91 = {1{`RANDOM}};
  sr_result_regs_r_32_Im = _RAND_91[31:0];
  _RAND_92 = {1{`RANDOM}};
  sr_result_regs_r_33_Re = _RAND_92[31:0];
  _RAND_93 = {1{`RANDOM}};
  sr_result_regs_r_33_Im = _RAND_93[31:0];
  _RAND_94 = {1{`RANDOM}};
  sr_result_regs_r_34_Re = _RAND_94[31:0];
  _RAND_95 = {1{`RANDOM}};
  sr_result_regs_r_34_Im = _RAND_95[31:0];
  _RAND_96 = {1{`RANDOM}};
  sr_result_regs_r_35_Re = _RAND_96[31:0];
  _RAND_97 = {1{`RANDOM}};
  sr_result_regs_r_35_Im = _RAND_97[31:0];
  _RAND_98 = {1{`RANDOM}};
  sr_result_regs_r_36_Re = _RAND_98[31:0];
  _RAND_99 = {1{`RANDOM}};
  sr_result_regs_r_36_Im = _RAND_99[31:0];
  _RAND_100 = {1{`RANDOM}};
  sr_result_regs_r_37_Re = _RAND_100[31:0];
  _RAND_101 = {1{`RANDOM}};
  sr_result_regs_r_37_Im = _RAND_101[31:0];
  _RAND_102 = {1{`RANDOM}};
  sr_result_regs_r_38_Re = _RAND_102[31:0];
  _RAND_103 = {1{`RANDOM}};
  sr_result_regs_r_38_Im = _RAND_103[31:0];
  _RAND_104 = {1{`RANDOM}};
  sr_result_regs_r_39_Re = _RAND_104[31:0];
  _RAND_105 = {1{`RANDOM}};
  sr_result_regs_r_39_Im = _RAND_105[31:0];
  _RAND_106 = {1{`RANDOM}};
  sr_result_regs_r_40_Re = _RAND_106[31:0];
  _RAND_107 = {1{`RANDOM}};
  sr_result_regs_r_40_Im = _RAND_107[31:0];
  _RAND_108 = {1{`RANDOM}};
  sr_result_regs_r_41_Re = _RAND_108[31:0];
  _RAND_109 = {1{`RANDOM}};
  sr_result_regs_r_41_Im = _RAND_109[31:0];
  _RAND_110 = {1{`RANDOM}};
  sr_result_regs_r_42_Re = _RAND_110[31:0];
  _RAND_111 = {1{`RANDOM}};
  sr_result_regs_r_42_Im = _RAND_111[31:0];
  _RAND_112 = {1{`RANDOM}};
  sr_result_regs_r_43_Re = _RAND_112[31:0];
  _RAND_113 = {1{`RANDOM}};
  sr_result_regs_r_43_Im = _RAND_113[31:0];
  _RAND_114 = {1{`RANDOM}};
  sr_result_regs_r_44_Re = _RAND_114[31:0];
  _RAND_115 = {1{`RANDOM}};
  sr_result_regs_r_44_Im = _RAND_115[31:0];
  _RAND_116 = {1{`RANDOM}};
  sr_result_regs_r_45_Re = _RAND_116[31:0];
  _RAND_117 = {1{`RANDOM}};
  sr_result_regs_r_45_Im = _RAND_117[31:0];
  _RAND_118 = {1{`RANDOM}};
  sr_result_regs_r_46_Re = _RAND_118[31:0];
  _RAND_119 = {1{`RANDOM}};
  sr_result_regs_r_46_Im = _RAND_119[31:0];
  _RAND_120 = {1{`RANDOM}};
  sr_result_regs_r_47_Re = _RAND_120[31:0];
  _RAND_121 = {1{`RANDOM}};
  sr_result_regs_r_47_Im = _RAND_121[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32(
  input         io_in_inv,
  input  [2:0]  io_in_addr,
  output [31:0] io_out_data_0_Im,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
  wire [31:0] _GEN_9 = 2'h1 == io_in_addr[1:0] ? 32'h3f0a5140 : 32'h3f800000; // @[TwidFactorDesigns.scala 66:{27,27}]
  wire [31:0] _GEN_10 = 2'h2 == io_in_addr[1:0] ? 32'hbed51130 : _GEN_9; // @[TwidFactorDesigns.scala 66:{27,27}]
  wire [31:0] _GEN_11 = 2'h3 == io_in_addr[1:0] ? 32'hbf7d7024 : _GEN_10; // @[TwidFactorDesigns.scala 66:{27,27}]
  wire [31:0] _GEN_13 = 2'h1 == io_in_addr[1:0] ? 32'h3f576aa4 : 32'h0; // @[TwidFactorDesigns.scala 67:{27,27}]
  wire [31:0] _GEN_14 = 2'h2 == io_in_addr[1:0] ? 32'h3f68c7b6 : _GEN_13; // @[TwidFactorDesigns.scala 67:{27,27}]
  wire [31:0] _GEN_15 = 2'h3 == io_in_addr[1:0] ? 32'h3e1081c0 : _GEN_14; // @[TwidFactorDesigns.scala 67:{27,27}]
  wire [31:0] _GEN_25 = 2'h1 == io_in_addr[1:0] ? 32'h3f3504f2 : 32'h3f800000; // @[TwidFactorDesigns.scala 71:{27,27}]
  wire [31:0] _GEN_26 = 2'h2 == io_in_addr[1:0] ? 32'h248d3131 : _GEN_25; // @[TwidFactorDesigns.scala 71:{27,27}]
  wire [31:0] _GEN_27 = 2'h3 == io_in_addr[1:0] ? 32'hbf3504f2 : _GEN_26; // @[TwidFactorDesigns.scala 71:{27,27}]
  wire [31:0] _GEN_29 = 2'h1 == io_in_addr[1:0] ? 32'hbf3504f2 : 32'h80800000; // @[TwidFactorDesigns.scala 72:{27,27}]
  wire [31:0] _GEN_30 = 2'h2 == io_in_addr[1:0] ? 32'hbf800000 : _GEN_29; // @[TwidFactorDesigns.scala 72:{27,27}]
  wire [31:0] _GEN_31 = 2'h3 == io_in_addr[1:0] ? 32'hbf3504f2 : _GEN_30; // @[TwidFactorDesigns.scala 72:{27,27}]
  assign io_out_data_0_Im = io_in_inv ? 32'h0 : 32'h80800000; // @[TwidFactorDesigns.scala 64:21 67:27 72:27]
  assign io_out_data_1_Re = io_in_inv ? _GEN_11 : _GEN_27; // @[TwidFactorDesigns.scala 64:21 66:27 71:27]
  assign io_out_data_1_Im = io_in_inv ? _GEN_15 : _GEN_31; // @[TwidFactorDesigns.scala 64:21 67:27 72:27]
endmodule
module multiplier_bw24(
  input  [23:0] io_in_a,
  input  [23:0] io_in_b,
  output [47:0] io_out_s
);
  assign io_out_s = io_in_a * io_in_b; // @[Arithmetic.scala 107:23]
endmodule
module twoscomplement_bw8(
  input  [7:0] io_in,
  output [7:0] io_out
);
  wire [7:0] _x_T = ~io_in; // @[Arithmetic.scala 47:16]
  assign io_out = 8'h1 + _x_T; // @[Arithmetic.scala 47:14]
endmodule
module full_adder_bw8(
  input  [7:0] io_in_a,
  input  [7:0] io_in_b,
  output [7:0] io_out_s,
  output       io_out_c
);
  wire [8:0] _result_T = io_in_a + io_in_b; // @[Arithmetic.scala 79:23]
  wire [9:0] _result_T_1 = {{1'd0}, _result_T}; // @[Arithmetic.scala 79:34]
  wire [8:0] result = _result_T_1[8:0]; // @[Arithmetic.scala 78:22 79:12]
  assign io_out_s = result[7:0]; // @[Arithmetic.scala 80:23]
  assign io_out_c = result[8]; // @[Arithmetic.scala 81:23]
endmodule
module FP_multiplier_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [63:0] _RAND_32;
  reg [63:0] _RAND_33;
  reg [63:0] _RAND_34;
  reg [63:0] _RAND_35;
  reg [63:0] _RAND_36;
  reg [63:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
`endif // RANDOMIZE_REG_INIT
  wire [23:0] multiplier_io_in_a; // @[FPArithmetic.scala 372:28]
  wire [23:0] multiplier_io_in_b; // @[FPArithmetic.scala 372:28]
  wire [47:0] multiplier_io_out_s; // @[FPArithmetic.scala 372:28]
  wire [7:0] subber_io_in_a; // @[FPArithmetic.scala 379:24]
  wire [7:0] subber_io_in_b; // @[FPArithmetic.scala 379:24]
  wire [7:0] subber_io_out_s; // @[FPArithmetic.scala 379:24]
  wire  subber_io_out_c; // @[FPArithmetic.scala 379:24]
  wire [7:0] complementN_io_in; // @[FPArithmetic.scala 388:29]
  wire [7:0] complementN_io_out; // @[FPArithmetic.scala 388:29]
  wire [7:0] adderN_io_in_a; // @[FPArithmetic.scala 406:24]
  wire [7:0] adderN_io_in_b; // @[FPArithmetic.scala 406:24]
  wire [7:0] adderN_io_out_s; // @[FPArithmetic.scala 406:24]
  wire  adderN_io_out_c; // @[FPArithmetic.scala 406:24]
  wire  s_0 = io_in_a[31]; // @[FPArithmetic.scala 338:20]
  wire  s_1 = io_in_b[31]; // @[FPArithmetic.scala 339:20]
  wire [8:0] _T_2 = 9'h100 - 9'h2; // @[FPArithmetic.scala 343:64]
  wire [8:0] _GEN_63 = {{1'd0}, io_in_a[30:23]}; // @[FPArithmetic.scala 343:36]
  wire [7:0] _GEN_0 = io_in_a[30:23] < 8'h1 ? 8'h1 : io_in_a[30:23]; // @[FPArithmetic.scala 345:45 346:14 348:14]
  wire [8:0] _GEN_1 = _GEN_63 > _T_2 ? _T_2 : {{1'd0}, _GEN_0}; // @[FPArithmetic.scala 343:71 344:14]
  wire [8:0] _GEN_64 = {{1'd0}, io_in_b[30:23]}; // @[FPArithmetic.scala 350:36]
  wire [7:0] _GEN_2 = io_in_b[30:23] < 8'h1 ? 8'h1 : io_in_b[30:23]; // @[FPArithmetic.scala 352:45 353:14 355:14]
  wire [8:0] _GEN_3 = _GEN_64 > _T_2 ? _T_2 : {{1'd0}, _GEN_2}; // @[FPArithmetic.scala 350:71 351:14]
  wire [22:0] frac_0 = io_in_a[22:0]; // @[FPArithmetic.scala 360:23]
  wire [22:0] frac_1 = io_in_b[22:0]; // @[FPArithmetic.scala 361:23]
  wire [23:0] new_frac_0 = {1'h1,frac_0}; // @[FPArithmetic.scala 365:24]
  wire [23:0] new_frac_1 = {1'h1,frac_1}; // @[FPArithmetic.scala 366:24]
  reg  s_reg_0_0; // @[FPArithmetic.scala 368:24]
  reg  s_reg_0_1; // @[FPArithmetic.scala 368:24]
  reg  s_reg_1_0; // @[FPArithmetic.scala 368:24]
  reg  s_reg_1_1; // @[FPArithmetic.scala 368:24]
  reg  s_reg_2_0; // @[FPArithmetic.scala 368:24]
  reg  s_reg_2_1; // @[FPArithmetic.scala 368:24]
  reg  s_reg_3_0; // @[FPArithmetic.scala 368:24]
  reg  s_reg_3_1; // @[FPArithmetic.scala 368:24]
  reg  s_reg_4_0; // @[FPArithmetic.scala 368:24]
  reg  s_reg_4_1; // @[FPArithmetic.scala 368:24]
  reg [7:0] exp_reg_0_0; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_0_1; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_1_0; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_1_1; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_2_0; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_2_1; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_3_0; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_3_1; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_4_0; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_4_1; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_5_0; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_5_1; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_6_0; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_6_1; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_7_0; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_7_1; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_8_0; // @[FPArithmetic.scala 369:26]
  reg [7:0] exp_reg_8_1; // @[FPArithmetic.scala 369:26]
  reg [23:0] new_frac_reg_0_0; // @[FPArithmetic.scala 370:31]
  reg [23:0] new_frac_reg_0_1; // @[FPArithmetic.scala 370:31]
  reg [23:0] new_frac_reg_1_0; // @[FPArithmetic.scala 370:31]
  reg [23:0] new_frac_reg_1_1; // @[FPArithmetic.scala 370:31]
  reg [47:0] multipplier_out_s_reg_0; // @[FPArithmetic.scala 376:40]
  reg [47:0] multipplier_out_s_reg_1; // @[FPArithmetic.scala 376:40]
  reg [47:0] multipplier_out_s_reg_2; // @[FPArithmetic.scala 376:40]
  reg [47:0] multipplier_out_s_reg_3; // @[FPArithmetic.scala 376:40]
  reg [47:0] multipplier_out_s_reg_4; // @[FPArithmetic.scala 376:40]
  reg [47:0] multipplier_out_s_reg_5; // @[FPArithmetic.scala 376:40]
  reg [7:0] subber_out_s_reg_0; // @[FPArithmetic.scala 384:35]
  reg [7:0] complementN_out_reg_0; // @[FPArithmetic.scala 391:38]
  reg [7:0] complementN_out_reg_1; // @[FPArithmetic.scala 391:38]
  reg [7:0] complementN_out_reg_2; // @[FPArithmetic.scala 391:38]
  wire  new_s = s_reg_4_0 ^ s_reg_4_1; // @[FPArithmetic.scala 394:26]
  reg  new_s_reg_0; // @[FPArithmetic.scala 396:28]
  reg  new_s_reg_1; // @[FPArithmetic.scala 396:28]
  reg  new_s_reg_2; // @[FPArithmetic.scala 396:28]
  reg  new_s_reg_3; // @[FPArithmetic.scala 396:28]
  wire  is_exp1_neg_wire = exp_reg_5_1 < 8'h7f; // @[FPArithmetic.scala 400:40]
  reg  is_exp1_neg_reg_0; // @[FPArithmetic.scala 402:34]
  reg  is_exp1_neg_reg_1; // @[FPArithmetic.scala 402:34]
  wire [7:0] _adderN_io_in_a_T_1 = exp_reg_6_0 + 8'h1; // @[FPArithmetic.scala 410:39]
  reg [7:0] adderN_out_s_reg_0; // @[FPArithmetic.scala 417:35]
  reg  adderN_out_c_reg_0; // @[FPArithmetic.scala 418:35]
  reg [7:0] new_exp_reg_0; // @[FPArithmetic.scala 420:30]
  reg [22:0] new_mant_reg_0; // @[FPArithmetic.scala 421:31]
  reg [31:0] reg_out_s; // @[FPArithmetic.scala 423:28]
  wire  _new_exp_reg_0_T_1 = ~adderN_out_c_reg_0; // @[FPArithmetic.scala 427:55]
  wire [7:0] _new_exp_reg_0_T_2 = ~adderN_out_c_reg_0 ? 8'h1 : adderN_out_s_reg_0; // @[FPArithmetic.scala 427:54]
  wire  _new_exp_reg_0_T_5 = adderN_out_c_reg_0 | adderN_out_s_reg_0 > 8'hfe; // @[FPArithmetic.scala 427:142]
  wire [7:0] _new_exp_reg_0_T_6 = adderN_out_c_reg_0 | adderN_out_s_reg_0 > 8'hfe ? 8'hfe : adderN_out_s_reg_0; // @[FPArithmetic.scala 427:114]
  wire [7:0] _new_exp_reg_0_T_7 = is_exp1_neg_reg_1 ? _new_exp_reg_0_T_2 : _new_exp_reg_0_T_6; // @[FPArithmetic.scala 427:30]
  wire [22:0] _new_mant_reg_0_T_3 = _new_exp_reg_0_T_1 ? 23'h0 : multipplier_out_s_reg_5[46:24]; // @[FPArithmetic.scala 428:55]
  wire [22:0] _new_mant_reg_0_T_8 = _new_exp_reg_0_T_5 ? 23'h7fffff : multipplier_out_s_reg_5[46:24]; // @[FPArithmetic.scala 428:160]
  wire [22:0] _new_mant_reg_0_T_13 = _new_exp_reg_0_T_1 ? 23'h0 : multipplier_out_s_reg_5[45:23]; // @[FPArithmetic.scala 431:55]
  wire [22:0] _new_mant_reg_0_T_18 = _new_exp_reg_0_T_5 ? 23'h7fffff : multipplier_out_s_reg_5[45:23]; // @[FPArithmetic.scala 431:156]
  wire [31:0] _reg_out_s_T_1 = {new_s_reg_3,new_exp_reg_0,new_mant_reg_0}; // @[FPArithmetic.scala 469:53]
  wire [7:0] exp_0 = _GEN_1[7:0]; // @[FPArithmetic.scala 342:19]
  wire [7:0] exp_1 = _GEN_3[7:0]; // @[FPArithmetic.scala 342:19]
  multiplier_bw24 multiplier ( // @[FPArithmetic.scala 372:28]
    .io_in_a(multiplier_io_in_a),
    .io_in_b(multiplier_io_in_b),
    .io_out_s(multiplier_io_out_s)
  );
  full_subtractor_bw8 subber ( // @[FPArithmetic.scala 379:24]
    .io_in_a(subber_io_in_a),
    .io_in_b(subber_io_in_b),
    .io_out_s(subber_io_out_s),
    .io_out_c(subber_io_out_c)
  );
  twoscomplement_bw8 complementN ( // @[FPArithmetic.scala 388:29]
    .io_in(complementN_io_in),
    .io_out(complementN_io_out)
  );
  full_adder_bw8 adderN ( // @[FPArithmetic.scala 406:24]
    .io_in_a(adderN_io_in_a),
    .io_in_b(adderN_io_in_b),
    .io_out_s(adderN_io_out_s),
    .io_out_c(adderN_io_out_c)
  );
  assign io_out_s = reg_out_s; // @[FPArithmetic.scala 472:14]
  assign multiplier_io_in_a = new_frac_reg_1_0; // @[FPArithmetic.scala 373:24]
  assign multiplier_io_in_b = new_frac_reg_1_1; // @[FPArithmetic.scala 374:24]
  assign subber_io_in_a = 8'h7f; // @[FPArithmetic.scala 380:20]
  assign subber_io_in_b = exp_reg_2_1; // @[FPArithmetic.scala 381:20]
  assign complementN_io_in = subber_out_s_reg_0; // @[FPArithmetic.scala 389:23]
  assign adderN_io_in_a = multipplier_out_s_reg_4[47] ? _adderN_io_in_a_T_1 : exp_reg_6_0; // @[FPArithmetic.scala 409:70 410:22 413:22]
  assign adderN_io_in_b = complementN_out_reg_2; // @[FPArithmetic.scala 409:70 411:22 414:22]
  always @(posedge clock) begin
    if (reset) begin // @[FPArithmetic.scala 368:24]
      s_reg_0_0 <= 1'h0; // @[FPArithmetic.scala 368:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      s_reg_0_0 <= s_0; // @[FPArithmetic.scala 434:16]
    end
    if (reset) begin // @[FPArithmetic.scala 368:24]
      s_reg_0_1 <= 1'h0; // @[FPArithmetic.scala 368:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      s_reg_0_1 <= s_1; // @[FPArithmetic.scala 434:16]
    end
    if (reset) begin // @[FPArithmetic.scala 368:24]
      s_reg_1_0 <= 1'h0; // @[FPArithmetic.scala 368:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      s_reg_1_0 <= s_reg_0_0; // @[FPArithmetic.scala 451:22]
    end
    if (reset) begin // @[FPArithmetic.scala 368:24]
      s_reg_1_1 <= 1'h0; // @[FPArithmetic.scala 368:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      s_reg_1_1 <= s_reg_0_1; // @[FPArithmetic.scala 451:22]
    end
    if (reset) begin // @[FPArithmetic.scala 368:24]
      s_reg_2_0 <= 1'h0; // @[FPArithmetic.scala 368:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      s_reg_2_0 <= s_reg_1_0; // @[FPArithmetic.scala 451:22]
    end
    if (reset) begin // @[FPArithmetic.scala 368:24]
      s_reg_2_1 <= 1'h0; // @[FPArithmetic.scala 368:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      s_reg_2_1 <= s_reg_1_1; // @[FPArithmetic.scala 451:22]
    end
    if (reset) begin // @[FPArithmetic.scala 368:24]
      s_reg_3_0 <= 1'h0; // @[FPArithmetic.scala 368:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      s_reg_3_0 <= s_reg_2_0; // @[FPArithmetic.scala 451:22]
    end
    if (reset) begin // @[FPArithmetic.scala 368:24]
      s_reg_3_1 <= 1'h0; // @[FPArithmetic.scala 368:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      s_reg_3_1 <= s_reg_2_1; // @[FPArithmetic.scala 451:22]
    end
    if (reset) begin // @[FPArithmetic.scala 368:24]
      s_reg_4_0 <= 1'h0; // @[FPArithmetic.scala 368:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      s_reg_4_0 <= s_reg_3_0; // @[FPArithmetic.scala 451:22]
    end
    if (reset) begin // @[FPArithmetic.scala 368:24]
      s_reg_4_1 <= 1'h0; // @[FPArithmetic.scala 368:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      s_reg_4_1 <= s_reg_3_1; // @[FPArithmetic.scala 451:22]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_0_0 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_0_0 <= exp_0; // @[FPArithmetic.scala 435:18]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_0_1 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_0_1 <= exp_1; // @[FPArithmetic.scala 435:18]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_1_0 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_1_0 <= exp_reg_0_0; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_1_1 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_1_1 <= exp_reg_0_1; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_2_0 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_2_0 <= exp_reg_1_0; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_2_1 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_2_1 <= exp_reg_1_1; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_3_0 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_3_0 <= exp_reg_2_0; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_3_1 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_3_1 <= exp_reg_2_1; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_4_0 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_4_0 <= exp_reg_3_0; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_4_1 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_4_1 <= exp_reg_3_1; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_5_0 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_5_0 <= exp_reg_4_0; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_5_1 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_5_1 <= exp_reg_4_1; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_6_0 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_6_0 <= exp_reg_5_0; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_6_1 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_6_1 <= exp_reg_5_1; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_7_0 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_7_0 <= exp_reg_6_0; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_7_1 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_7_1 <= exp_reg_6_1; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_8_0 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_8_0 <= exp_reg_7_0; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 369:26]
      exp_reg_8_1 <= 8'h0; // @[FPArithmetic.scala 369:26]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      exp_reg_8_1 <= exp_reg_7_1; // @[FPArithmetic.scala 447:20]
    end
    if (reset) begin // @[FPArithmetic.scala 370:31]
      new_frac_reg_0_0 <= 24'h0; // @[FPArithmetic.scala 370:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      new_frac_reg_0_0 <= new_frac_0; // @[FPArithmetic.scala 436:23]
    end
    if (reset) begin // @[FPArithmetic.scala 370:31]
      new_frac_reg_0_1 <= 24'h0; // @[FPArithmetic.scala 370:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      new_frac_reg_0_1 <= new_frac_1; // @[FPArithmetic.scala 436:23]
    end
    if (reset) begin // @[FPArithmetic.scala 370:31]
      new_frac_reg_1_0 <= 24'h0; // @[FPArithmetic.scala 370:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      new_frac_reg_1_0 <= new_frac_reg_0_0; // @[FPArithmetic.scala 457:35]
    end
    if (reset) begin // @[FPArithmetic.scala 370:31]
      new_frac_reg_1_1 <= 24'h0; // @[FPArithmetic.scala 370:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      new_frac_reg_1_1 <= new_frac_reg_0_1; // @[FPArithmetic.scala 457:35]
    end
    if (reset) begin // @[FPArithmetic.scala 376:40]
      multipplier_out_s_reg_0 <= 48'h0; // @[FPArithmetic.scala 376:40]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      multipplier_out_s_reg_0 <= multiplier_io_out_s; // @[FPArithmetic.scala 437:32]
    end
    if (reset) begin // @[FPArithmetic.scala 376:40]
      multipplier_out_s_reg_1 <= 48'h0; // @[FPArithmetic.scala 376:40]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      multipplier_out_s_reg_1 <= multipplier_out_s_reg_0; // @[FPArithmetic.scala 449:36]
    end
    if (reset) begin // @[FPArithmetic.scala 376:40]
      multipplier_out_s_reg_2 <= 48'h0; // @[FPArithmetic.scala 376:40]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      multipplier_out_s_reg_2 <= multipplier_out_s_reg_1; // @[FPArithmetic.scala 449:36]
    end
    if (reset) begin // @[FPArithmetic.scala 376:40]
      multipplier_out_s_reg_3 <= 48'h0; // @[FPArithmetic.scala 376:40]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      multipplier_out_s_reg_3 <= multipplier_out_s_reg_2; // @[FPArithmetic.scala 449:36]
    end
    if (reset) begin // @[FPArithmetic.scala 376:40]
      multipplier_out_s_reg_4 <= 48'h0; // @[FPArithmetic.scala 376:40]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      multipplier_out_s_reg_4 <= multipplier_out_s_reg_3; // @[FPArithmetic.scala 449:36]
    end
    if (reset) begin // @[FPArithmetic.scala 376:40]
      multipplier_out_s_reg_5 <= 48'h0; // @[FPArithmetic.scala 376:40]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      multipplier_out_s_reg_5 <= multipplier_out_s_reg_4; // @[FPArithmetic.scala 449:36]
    end
    if (reset) begin // @[FPArithmetic.scala 384:35]
      subber_out_s_reg_0 <= 8'h0; // @[FPArithmetic.scala 384:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      subber_out_s_reg_0 <= subber_io_out_s; // @[FPArithmetic.scala 438:27]
    end
    if (reset) begin // @[FPArithmetic.scala 391:38]
      complementN_out_reg_0 <= 8'h0; // @[FPArithmetic.scala 391:38]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      complementN_out_reg_0 <= complementN_io_out; // @[FPArithmetic.scala 440:30]
    end
    if (reset) begin // @[FPArithmetic.scala 391:38]
      complementN_out_reg_1 <= 8'h0; // @[FPArithmetic.scala 391:38]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      complementN_out_reg_1 <= complementN_out_reg_0; // @[FPArithmetic.scala 455:40]
    end
    if (reset) begin // @[FPArithmetic.scala 391:38]
      complementN_out_reg_2 <= 8'h0; // @[FPArithmetic.scala 391:38]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      complementN_out_reg_2 <= complementN_out_reg_1; // @[FPArithmetic.scala 455:40]
    end
    if (reset) begin // @[FPArithmetic.scala 396:28]
      new_s_reg_0 <= 1'h0; // @[FPArithmetic.scala 396:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      new_s_reg_0 <= new_s; // @[FPArithmetic.scala 441:20]
    end
    if (reset) begin // @[FPArithmetic.scala 396:28]
      new_s_reg_1 <= 1'h0; // @[FPArithmetic.scala 396:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      new_s_reg_1 <= new_s_reg_0; // @[FPArithmetic.scala 453:28]
    end
    if (reset) begin // @[FPArithmetic.scala 396:28]
      new_s_reg_2 <= 1'h0; // @[FPArithmetic.scala 396:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      new_s_reg_2 <= new_s_reg_1; // @[FPArithmetic.scala 453:28]
    end
    if (reset) begin // @[FPArithmetic.scala 396:28]
      new_s_reg_3 <= 1'h0; // @[FPArithmetic.scala 396:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      new_s_reg_3 <= new_s_reg_2; // @[FPArithmetic.scala 453:28]
    end
    if (reset) begin // @[FPArithmetic.scala 402:34]
      is_exp1_neg_reg_0 <= 1'h0; // @[FPArithmetic.scala 402:34]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      is_exp1_neg_reg_0 <= is_exp1_neg_wire; // @[FPArithmetic.scala 442:26]
    end
    if (reset) begin // @[FPArithmetic.scala 402:34]
      is_exp1_neg_reg_1 <= 1'h0; // @[FPArithmetic.scala 402:34]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      is_exp1_neg_reg_1 <= is_exp1_neg_reg_0; // @[FPArithmetic.scala 458:38]
    end
    if (reset) begin // @[FPArithmetic.scala 417:35]
      adderN_out_s_reg_0 <= 8'h0; // @[FPArithmetic.scala 417:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      adderN_out_s_reg_0 <= adderN_io_out_s; // @[FPArithmetic.scala 443:27]
    end
    if (reset) begin // @[FPArithmetic.scala 418:35]
      adderN_out_c_reg_0 <= 1'h0; // @[FPArithmetic.scala 418:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      adderN_out_c_reg_0 <= adderN_io_out_c; // @[FPArithmetic.scala 444:27]
    end
    if (reset) begin // @[FPArithmetic.scala 420:30]
      new_exp_reg_0 <= 8'h0; // @[FPArithmetic.scala 420:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      if (multipplier_out_s_reg_5[47]) begin // @[FPArithmetic.scala 426:72]
        new_exp_reg_0 <= _new_exp_reg_0_T_7; // @[FPArithmetic.scala 427:24]
      end else begin
        new_exp_reg_0 <= _new_exp_reg_0_T_7; // @[FPArithmetic.scala 430:24]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 421:31]
      new_mant_reg_0 <= 23'h0; // @[FPArithmetic.scala 421:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      if (multipplier_out_s_reg_5[47]) begin // @[FPArithmetic.scala 426:72]
        if (is_exp1_neg_reg_1) begin // @[FPArithmetic.scala 428:31]
          new_mant_reg_0 <= _new_mant_reg_0_T_3;
        end else begin
          new_mant_reg_0 <= _new_mant_reg_0_T_8;
        end
      end else if (is_exp1_neg_reg_1) begin // @[FPArithmetic.scala 431:31]
        new_mant_reg_0 <= _new_mant_reg_0_T_13;
      end else begin
        new_mant_reg_0 <= _new_mant_reg_0_T_18;
      end
    end
    if (reset) begin // @[FPArithmetic.scala 423:28]
      reg_out_s <= 32'h0; // @[FPArithmetic.scala 423:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 425:19]
      if (exp_reg_8_0 == 8'h0 | exp_reg_8_1 == 8'h0) begin // @[FPArithmetic.scala 466:60]
        reg_out_s <= 32'h0; // @[FPArithmetic.scala 467:19]
      end else begin
        reg_out_s <= _reg_out_s_T_1; // @[FPArithmetic.scala 469:19]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  s_reg_0_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  s_reg_0_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  s_reg_1_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  s_reg_1_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  s_reg_2_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  s_reg_2_1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  s_reg_3_0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  s_reg_3_1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  s_reg_4_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  s_reg_4_1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  exp_reg_0_0 = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  exp_reg_0_1 = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  exp_reg_1_0 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  exp_reg_1_1 = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  exp_reg_2_0 = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  exp_reg_2_1 = _RAND_15[7:0];
  _RAND_16 = {1{`RANDOM}};
  exp_reg_3_0 = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  exp_reg_3_1 = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  exp_reg_4_0 = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  exp_reg_4_1 = _RAND_19[7:0];
  _RAND_20 = {1{`RANDOM}};
  exp_reg_5_0 = _RAND_20[7:0];
  _RAND_21 = {1{`RANDOM}};
  exp_reg_5_1 = _RAND_21[7:0];
  _RAND_22 = {1{`RANDOM}};
  exp_reg_6_0 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  exp_reg_6_1 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  exp_reg_7_0 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  exp_reg_7_1 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  exp_reg_8_0 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  exp_reg_8_1 = _RAND_27[7:0];
  _RAND_28 = {1{`RANDOM}};
  new_frac_reg_0_0 = _RAND_28[23:0];
  _RAND_29 = {1{`RANDOM}};
  new_frac_reg_0_1 = _RAND_29[23:0];
  _RAND_30 = {1{`RANDOM}};
  new_frac_reg_1_0 = _RAND_30[23:0];
  _RAND_31 = {1{`RANDOM}};
  new_frac_reg_1_1 = _RAND_31[23:0];
  _RAND_32 = {2{`RANDOM}};
  multipplier_out_s_reg_0 = _RAND_32[47:0];
  _RAND_33 = {2{`RANDOM}};
  multipplier_out_s_reg_1 = _RAND_33[47:0];
  _RAND_34 = {2{`RANDOM}};
  multipplier_out_s_reg_2 = _RAND_34[47:0];
  _RAND_35 = {2{`RANDOM}};
  multipplier_out_s_reg_3 = _RAND_35[47:0];
  _RAND_36 = {2{`RANDOM}};
  multipplier_out_s_reg_4 = _RAND_36[47:0];
  _RAND_37 = {2{`RANDOM}};
  multipplier_out_s_reg_5 = _RAND_37[47:0];
  _RAND_38 = {1{`RANDOM}};
  subber_out_s_reg_0 = _RAND_38[7:0];
  _RAND_39 = {1{`RANDOM}};
  complementN_out_reg_0 = _RAND_39[7:0];
  _RAND_40 = {1{`RANDOM}};
  complementN_out_reg_1 = _RAND_40[7:0];
  _RAND_41 = {1{`RANDOM}};
  complementN_out_reg_2 = _RAND_41[7:0];
  _RAND_42 = {1{`RANDOM}};
  new_s_reg_0 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  new_s_reg_1 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  new_s_reg_2 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  new_s_reg_3 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  is_exp1_neg_reg_0 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  is_exp1_neg_reg_1 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  adderN_out_s_reg_0 = _RAND_48[7:0];
  _RAND_49 = {1{`RANDOM}};
  adderN_out_c_reg_0 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  new_exp_reg_0 = _RAND_50[7:0];
  _RAND_51 = {1{`RANDOM}};
  new_mant_reg_0 = _RAND_51[22:0];
  _RAND_52 = {1{`RANDOM}};
  reg_out_s = _RAND_52[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FPComplexMultiplier_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a_Re,
  input  [31:0] io_in_a_Im,
  input  [31:0] io_in_b_Re,
  input  [31:0] io_in_b_Im,
  output [31:0] io_out_s_Re,
  output [31:0] io_out_s_Im
);
  wire  FP_subtractor_bw32_clock; // @[FPComplex.scala 180:24]
  wire  FP_subtractor_bw32_reset; // @[FPComplex.scala 180:24]
  wire  FP_subtractor_bw32_io_in_en; // @[FPComplex.scala 180:24]
  wire [31:0] FP_subtractor_bw32_io_in_a; // @[FPComplex.scala 180:24]
  wire [31:0] FP_subtractor_bw32_io_in_b; // @[FPComplex.scala 180:24]
  wire [31:0] FP_subtractor_bw32_io_out_s; // @[FPComplex.scala 180:24]
  wire  FP_adder_bw32_clock; // @[FPComplex.scala 181:24]
  wire  FP_adder_bw32_reset; // @[FPComplex.scala 181:24]
  wire  FP_adder_bw32_io_in_en; // @[FPComplex.scala 181:24]
  wire [31:0] FP_adder_bw32_io_in_a; // @[FPComplex.scala 181:24]
  wire [31:0] FP_adder_bw32_io_in_b; // @[FPComplex.scala 181:24]
  wire [31:0] FP_adder_bw32_io_out_s; // @[FPComplex.scala 181:24]
  wire  FP_multiplier_bw32_clock; // @[FPComplex.scala 183:26]
  wire  FP_multiplier_bw32_reset; // @[FPComplex.scala 183:26]
  wire  FP_multiplier_bw32_io_in_en; // @[FPComplex.scala 183:26]
  wire [31:0] FP_multiplier_bw32_io_in_a; // @[FPComplex.scala 183:26]
  wire [31:0] FP_multiplier_bw32_io_in_b; // @[FPComplex.scala 183:26]
  wire [31:0] FP_multiplier_bw32_io_out_s; // @[FPComplex.scala 183:26]
  wire  FP_multiplier_bw32_1_clock; // @[FPComplex.scala 183:26]
  wire  FP_multiplier_bw32_1_reset; // @[FPComplex.scala 183:26]
  wire  FP_multiplier_bw32_1_io_in_en; // @[FPComplex.scala 183:26]
  wire [31:0] FP_multiplier_bw32_1_io_in_a; // @[FPComplex.scala 183:26]
  wire [31:0] FP_multiplier_bw32_1_io_in_b; // @[FPComplex.scala 183:26]
  wire [31:0] FP_multiplier_bw32_1_io_out_s; // @[FPComplex.scala 183:26]
  wire  FP_multiplier_bw32_2_clock; // @[FPComplex.scala 183:26]
  wire  FP_multiplier_bw32_2_reset; // @[FPComplex.scala 183:26]
  wire  FP_multiplier_bw32_2_io_in_en; // @[FPComplex.scala 183:26]
  wire [31:0] FP_multiplier_bw32_2_io_in_a; // @[FPComplex.scala 183:26]
  wire [31:0] FP_multiplier_bw32_2_io_in_b; // @[FPComplex.scala 183:26]
  wire [31:0] FP_multiplier_bw32_2_io_out_s; // @[FPComplex.scala 183:26]
  wire  FP_multiplier_bw32_3_clock; // @[FPComplex.scala 183:26]
  wire  FP_multiplier_bw32_3_reset; // @[FPComplex.scala 183:26]
  wire  FP_multiplier_bw32_3_io_in_en; // @[FPComplex.scala 183:26]
  wire [31:0] FP_multiplier_bw32_3_io_in_a; // @[FPComplex.scala 183:26]
  wire [31:0] FP_multiplier_bw32_3_io_in_b; // @[FPComplex.scala 183:26]
  wire [31:0] FP_multiplier_bw32_3_io_out_s; // @[FPComplex.scala 183:26]
  FP_subtractor_bw32 FP_subtractor_bw32 ( // @[FPComplex.scala 180:24]
    .clock(FP_subtractor_bw32_clock),
    .reset(FP_subtractor_bw32_reset),
    .io_in_en(FP_subtractor_bw32_io_in_en),
    .io_in_a(FP_subtractor_bw32_io_in_a),
    .io_in_b(FP_subtractor_bw32_io_in_b),
    .io_out_s(FP_subtractor_bw32_io_out_s)
  );
  FP_adder_bw32 FP_adder_bw32 ( // @[FPComplex.scala 181:24]
    .clock(FP_adder_bw32_clock),
    .reset(FP_adder_bw32_reset),
    .io_in_en(FP_adder_bw32_io_in_en),
    .io_in_a(FP_adder_bw32_io_in_a),
    .io_in_b(FP_adder_bw32_io_in_b),
    .io_out_s(FP_adder_bw32_io_out_s)
  );
  FP_multiplier_bw32 FP_multiplier_bw32 ( // @[FPComplex.scala 183:26]
    .clock(FP_multiplier_bw32_clock),
    .reset(FP_multiplier_bw32_reset),
    .io_in_en(FP_multiplier_bw32_io_in_en),
    .io_in_a(FP_multiplier_bw32_io_in_a),
    .io_in_b(FP_multiplier_bw32_io_in_b),
    .io_out_s(FP_multiplier_bw32_io_out_s)
  );
  FP_multiplier_bw32 FP_multiplier_bw32_1 ( // @[FPComplex.scala 183:26]
    .clock(FP_multiplier_bw32_1_clock),
    .reset(FP_multiplier_bw32_1_reset),
    .io_in_en(FP_multiplier_bw32_1_io_in_en),
    .io_in_a(FP_multiplier_bw32_1_io_in_a),
    .io_in_b(FP_multiplier_bw32_1_io_in_b),
    .io_out_s(FP_multiplier_bw32_1_io_out_s)
  );
  FP_multiplier_bw32 FP_multiplier_bw32_2 ( // @[FPComplex.scala 183:26]
    .clock(FP_multiplier_bw32_2_clock),
    .reset(FP_multiplier_bw32_2_reset),
    .io_in_en(FP_multiplier_bw32_2_io_in_en),
    .io_in_a(FP_multiplier_bw32_2_io_in_a),
    .io_in_b(FP_multiplier_bw32_2_io_in_b),
    .io_out_s(FP_multiplier_bw32_2_io_out_s)
  );
  FP_multiplier_bw32 FP_multiplier_bw32_3 ( // @[FPComplex.scala 183:26]
    .clock(FP_multiplier_bw32_3_clock),
    .reset(FP_multiplier_bw32_3_reset),
    .io_in_en(FP_multiplier_bw32_3_io_in_en),
    .io_in_a(FP_multiplier_bw32_3_io_in_a),
    .io_in_b(FP_multiplier_bw32_3_io_in_b),
    .io_out_s(FP_multiplier_bw32_3_io_out_s)
  );
  assign io_out_s_Re = FP_subtractor_bw32_io_out_s; // @[FPComplex.scala 203:17]
  assign io_out_s_Im = FP_adder_bw32_io_out_s; // @[FPComplex.scala 204:17]
  assign FP_subtractor_bw32_clock = clock;
  assign FP_subtractor_bw32_reset = reset;
  assign FP_subtractor_bw32_io_in_en = io_in_en; // @[FPComplex.scala 189:18]
  assign FP_subtractor_bw32_io_in_a = FP_multiplier_bw32_io_out_s; // @[FPComplex.scala 199:17]
  assign FP_subtractor_bw32_io_in_b = FP_multiplier_bw32_1_io_out_s; // @[FPComplex.scala 200:17]
  assign FP_adder_bw32_clock = clock;
  assign FP_adder_bw32_reset = reset;
  assign FP_adder_bw32_io_in_en = io_in_en; // @[FPComplex.scala 190:18]
  assign FP_adder_bw32_io_in_a = FP_multiplier_bw32_2_io_out_s; // @[FPComplex.scala 201:17]
  assign FP_adder_bw32_io_in_b = FP_multiplier_bw32_3_io_out_s; // @[FPComplex.scala 202:17]
  assign FP_multiplier_bw32_clock = clock;
  assign FP_multiplier_bw32_reset = reset;
  assign FP_multiplier_bw32_io_in_en = io_in_en; // @[FPComplex.scala 187:31]
  assign FP_multiplier_bw32_io_in_a = io_in_a_Re; // @[FPComplex.scala 191:28]
  assign FP_multiplier_bw32_io_in_b = io_in_b_Re; // @[FPComplex.scala 192:28]
  assign FP_multiplier_bw32_1_clock = clock;
  assign FP_multiplier_bw32_1_reset = reset;
  assign FP_multiplier_bw32_1_io_in_en = io_in_en; // @[FPComplex.scala 187:31]
  assign FP_multiplier_bw32_1_io_in_a = io_in_a_Im; // @[FPComplex.scala 193:28]
  assign FP_multiplier_bw32_1_io_in_b = io_in_b_Im; // @[FPComplex.scala 194:28]
  assign FP_multiplier_bw32_2_clock = clock;
  assign FP_multiplier_bw32_2_reset = reset;
  assign FP_multiplier_bw32_2_io_in_en = io_in_en; // @[FPComplex.scala 187:31]
  assign FP_multiplier_bw32_2_io_in_a = io_in_a_Re; // @[FPComplex.scala 195:28]
  assign FP_multiplier_bw32_2_io_in_b = io_in_b_Im; // @[FPComplex.scala 196:28]
  assign FP_multiplier_bw32_3_clock = clock;
  assign FP_multiplier_bw32_3_reset = reset;
  assign FP_multiplier_bw32_3_io_in_en = io_in_en; // @[FPComplex.scala 187:31]
  assign FP_multiplier_bw32_3_io_in_a = io_in_a_Im; // @[FPComplex.scala 197:28]
  assign FP_multiplier_bw32_3_io_in_b = io_in_b_Re; // @[FPComplex.scala 198:28]
endmodule
module TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32(
  input         clock,
  input         reset,
  input         io_in_inv,
  input         io_in_en_main,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  input         io_in_valid,
  output        io_out_valid,
  output [31:0] io_out_0_Re,
  output [31:0] io_out_0_Im,
  output [31:0] io_out_1_Re,
  output [31:0] io_out_1_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
`endif // RANDOMIZE_REG_INIT
  wire  TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_in_inv; // @[TwidFactorDesigns.scala 280:26]
  wire [2:0] TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_in_addr; // @[TwidFactorDesigns.scala 280:26]
  wire [31:0] TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_out_data_0_Im; // @[TwidFactorDesigns.scala 280:26]
  wire [31:0] TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_out_data_1_Re; // @[TwidFactorDesigns.scala 280:26]
  wire [31:0] TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_out_data_1_Im; // @[TwidFactorDesigns.scala 280:26]
  wire  FPComplexMultiplier_bw32_clock; // @[TwidFactorDesigns.scala 293:30]
  wire  FPComplexMultiplier_bw32_reset; // @[TwidFactorDesigns.scala 293:30]
  wire  FPComplexMultiplier_bw32_io_in_en; // @[TwidFactorDesigns.scala 293:30]
  wire [31:0] FPComplexMultiplier_bw32_io_in_a_Re; // @[TwidFactorDesigns.scala 293:30]
  wire [31:0] FPComplexMultiplier_bw32_io_in_a_Im; // @[TwidFactorDesigns.scala 293:30]
  wire [31:0] FPComplexMultiplier_bw32_io_in_b_Re; // @[TwidFactorDesigns.scala 293:30]
  wire [31:0] FPComplexMultiplier_bw32_io_in_b_Im; // @[TwidFactorDesigns.scala 293:30]
  wire [31:0] FPComplexMultiplier_bw32_io_out_s_Re; // @[TwidFactorDesigns.scala 293:30]
  wire [31:0] FPComplexMultiplier_bw32_io_out_s_Im; // @[TwidFactorDesigns.scala 293:30]
  wire  FPComplexMultiplier_bw32_1_clock; // @[TwidFactorDesigns.scala 293:30]
  wire  FPComplexMultiplier_bw32_1_reset; // @[TwidFactorDesigns.scala 293:30]
  wire  FPComplexMultiplier_bw32_1_io_in_en; // @[TwidFactorDesigns.scala 293:30]
  wire [31:0] FPComplexMultiplier_bw32_1_io_in_a_Re; // @[TwidFactorDesigns.scala 293:30]
  wire [31:0] FPComplexMultiplier_bw32_1_io_in_a_Im; // @[TwidFactorDesigns.scala 293:30]
  wire [31:0] FPComplexMultiplier_bw32_1_io_in_b_Re; // @[TwidFactorDesigns.scala 293:30]
  wire [31:0] FPComplexMultiplier_bw32_1_io_in_b_Im; // @[TwidFactorDesigns.scala 293:30]
  wire [31:0] FPComplexMultiplier_bw32_1_io_out_s_Re; // @[TwidFactorDesigns.scala 293:30]
  wire [31:0] FPComplexMultiplier_bw32_1_io_out_s_Im; // @[TwidFactorDesigns.scala 293:30]
  reg  sr_valid_regs_r; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_1; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_2; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_3; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_4; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_5; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_6; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_7; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_8; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_9; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_10; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_11; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_12; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_13; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_14; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_15; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_16; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_17; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_18; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_19; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_20; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_21; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_22; // @[Reg.scala 16:16]
  reg  sr_valid_regs; // @[Reg.scala 16:16]
  reg [2:0] value; // @[Counter.scala 62:40]
  reg [1:0] cnt; // @[TwidFactorDesigns.scala 291:24]
  wire  wrap = value == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_1 = value + 3'h1; // @[Counter.scala 78:24]
  wire [1:0] _cnt_T_1 = cnt + 2'h1; // @[TwidFactorDesigns.scala 310:26]
  wire [1:0] _GEN_24 = cnt == 2'h3 ? 2'h0 : _cnt_T_1; // @[TwidFactorDesigns.scala 307:43 308:19 310:19]
  reg [31:0] multipliers_sr_out_r_Re; // @[Reg.scala 16:16]
  reg [31:0] multipliers_sr_out_r_Im; // @[Reg.scala 16:16]
  reg [31:0] multipliers_sr_out_r_1_Re; // @[Reg.scala 16:16]
  reg [31:0] multipliers_sr_out_r_1_Im; // @[Reg.scala 16:16]
  TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32 TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32 ( // @[TwidFactorDesigns.scala 280:26]
    .io_in_inv(TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_in_inv),
    .io_in_addr(TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_in_addr),
    .io_out_data_0_Im(TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_out_data_0_Im),
    .io_out_data_1_Re(TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_out_data_1_Re),
    .io_out_data_1_Im(TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_out_data_1_Im)
  );
  FPComplexMultiplier_bw32 FPComplexMultiplier_bw32 ( // @[TwidFactorDesigns.scala 293:30]
    .clock(FPComplexMultiplier_bw32_clock),
    .reset(FPComplexMultiplier_bw32_reset),
    .io_in_en(FPComplexMultiplier_bw32_io_in_en),
    .io_in_a_Re(FPComplexMultiplier_bw32_io_in_a_Re),
    .io_in_a_Im(FPComplexMultiplier_bw32_io_in_a_Im),
    .io_in_b_Re(FPComplexMultiplier_bw32_io_in_b_Re),
    .io_in_b_Im(FPComplexMultiplier_bw32_io_in_b_Im),
    .io_out_s_Re(FPComplexMultiplier_bw32_io_out_s_Re),
    .io_out_s_Im(FPComplexMultiplier_bw32_io_out_s_Im)
  );
  FPComplexMultiplier_bw32 FPComplexMultiplier_bw32_1 ( // @[TwidFactorDesigns.scala 293:30]
    .clock(FPComplexMultiplier_bw32_1_clock),
    .reset(FPComplexMultiplier_bw32_1_reset),
    .io_in_en(FPComplexMultiplier_bw32_1_io_in_en),
    .io_in_a_Re(FPComplexMultiplier_bw32_1_io_in_a_Re),
    .io_in_a_Im(FPComplexMultiplier_bw32_1_io_in_a_Im),
    .io_in_b_Re(FPComplexMultiplier_bw32_1_io_in_b_Re),
    .io_in_b_Im(FPComplexMultiplier_bw32_1_io_in_b_Im),
    .io_out_s_Re(FPComplexMultiplier_bw32_1_io_out_s_Re),
    .io_out_s_Im(FPComplexMultiplier_bw32_1_io_out_s_Im)
  );
  assign io_out_valid = sr_valid_regs; // @[TwidFactorDesigns.scala 282:18]
  assign io_out_0_Re = multipliers_sr_out_r_Re; // @[TwidFactorDesigns.scala 325:{39,39}]
  assign io_out_0_Im = multipliers_sr_out_r_Im; // @[TwidFactorDesigns.scala 325:{39,39}]
  assign io_out_1_Re = multipliers_sr_out_r_1_Re; // @[TwidFactorDesigns.scala 325:{39,39}]
  assign io_out_1_Im = multipliers_sr_out_r_1_Im; // @[TwidFactorDesigns.scala 325:{39,39}]
  assign TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_in_inv = io_in_inv; // @[TwidFactorDesigns.scala 330:23]
  assign TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_in_addr = {{1'd0}, cnt}; // @[TwidFactorDesigns.scala 329:24]
  assign FPComplexMultiplier_bw32_clock = clock;
  assign FPComplexMultiplier_bw32_reset = reset;
  assign FPComplexMultiplier_bw32_io_in_en = io_in_en_main; // @[TwidFactorDesigns.scala 297:30]
  assign FPComplexMultiplier_bw32_io_in_a_Re = io_in_0_Re; // @[TwidFactorDesigns.scala 300:29]
  assign FPComplexMultiplier_bw32_io_in_a_Im = io_in_0_Im; // @[TwidFactorDesigns.scala 300:29]
  assign FPComplexMultiplier_bw32_io_in_b_Re = 32'h3f800000; // @[TwidFactorDesigns.scala 301:29]
  assign FPComplexMultiplier_bw32_io_in_b_Im = TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_out_data_0_Im; // @[TwidFactorDesigns.scala 301:29]
  assign FPComplexMultiplier_bw32_1_clock = clock;
  assign FPComplexMultiplier_bw32_1_reset = reset;
  assign FPComplexMultiplier_bw32_1_io_in_en = io_in_en_main; // @[TwidFactorDesigns.scala 297:30]
  assign FPComplexMultiplier_bw32_1_io_in_a_Re = io_in_1_Re; // @[TwidFactorDesigns.scala 300:29]
  assign FPComplexMultiplier_bw32_1_io_in_a_Im = io_in_1_Im; // @[TwidFactorDesigns.scala 300:29]
  assign FPComplexMultiplier_bw32_1_io_in_b_Re = TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_out_data_1_Re; // @[TwidFactorDesigns.scala 301:29]
  assign FPComplexMultiplier_bw32_1_io_in_b_Im = TwiddleFactorROM_sr_Streaming_N8_r2_w2_stage1_bw32_io_out_data_1_Im; // @[TwidFactorDesigns.scala 301:29]
  always @(posedge clock) begin
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r <= io_in_valid; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_1 <= sr_valid_regs_r; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_2 <= sr_valid_regs_r_1; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_3 <= sr_valid_regs_r_2; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_4 <= sr_valid_regs_r_3; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_5 <= sr_valid_regs_r_4; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_6 <= sr_valid_regs_r_5; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_7 <= sr_valid_regs_r_6; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_8 <= sr_valid_regs_r_7; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_9 <= sr_valid_regs_r_8; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_10 <= sr_valid_regs_r_9; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_11 <= sr_valid_regs_r_10; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_12 <= sr_valid_regs_r_11; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_13 <= sr_valid_regs_r_12; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_14 <= sr_valid_regs_r_13; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_15 <= sr_valid_regs_r_14; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_16 <= sr_valid_regs_r_15; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_17 <= sr_valid_regs_r_16; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_18 <= sr_valid_regs_r_17; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_19 <= sr_valid_regs_r_18; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_20 <= sr_valid_regs_r_19; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_21 <= sr_valid_regs_r_20; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_22 <= sr_valid_regs_r_21; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs <= sr_valid_regs_r_22; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_en_main) begin // @[TwidFactorDesigns.scala 303:27]
      if (io_in_valid) begin // @[TwidFactorDesigns.scala 304:27]
        value <= _value_T_1; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[TwidFactorDesigns.scala 291:24]
      cnt <= 2'h0; // @[TwidFactorDesigns.scala 291:24]
    end else if (io_in_en_main) begin // @[TwidFactorDesigns.scala 303:27]
      if (io_in_valid) begin // @[TwidFactorDesigns.scala 304:27]
        if (wrap) begin // @[TwidFactorDesigns.scala 306:53]
          cnt <= _GEN_24;
        end
      end
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      multipliers_sr_out_r_Re <= FPComplexMultiplier_bw32_io_out_s_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      multipliers_sr_out_r_Im <= FPComplexMultiplier_bw32_io_out_s_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      multipliers_sr_out_r_1_Re <= FPComplexMultiplier_bw32_1_io_out_s_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      multipliers_sr_out_r_1_Im <= FPComplexMultiplier_bw32_1_io_out_s_Im; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sr_valid_regs_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  sr_valid_regs_r_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  sr_valid_regs_r_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  sr_valid_regs_r_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  sr_valid_regs_r_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  sr_valid_regs_r_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  sr_valid_regs_r_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  sr_valid_regs_r_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  sr_valid_regs_r_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  sr_valid_regs_r_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sr_valid_regs_r_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  sr_valid_regs_r_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sr_valid_regs_r_12 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  sr_valid_regs_r_13 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sr_valid_regs_r_14 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  sr_valid_regs_r_15 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  sr_valid_regs_r_16 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sr_valid_regs_r_17 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  sr_valid_regs_r_18 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  sr_valid_regs_r_19 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  sr_valid_regs_r_20 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  sr_valid_regs_r_21 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  sr_valid_regs_r_22 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  sr_valid_regs = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  value = _RAND_24[2:0];
  _RAND_25 = {1{`RANDOM}};
  cnt = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  multipliers_sr_out_r_Re = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  multipliers_sr_out_r_Im = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  multipliers_sr_out_r_1_Re = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  multipliers_sr_out_r_1_Im = _RAND_29[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FFT_SingleRadix_Streaming_N8_r2_w2_bw32(
  input         clock,
  input         reset,
  input         io_in_inv,
  input         io_in_ready,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  input         io_in_valid,
  output        io_out_valid,
  output [31:0] io_out_0_Re,
  output [31:0] io_out_0_Im,
  output [31:0] io_out_1_Re,
  output [31:0] io_out_1_Im,
  output        io_out_ready
);
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_clock; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_reset; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_en; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_valid; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_0_Re; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_0_Im; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_1_Re; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_1_Im; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_valid; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_1_clock; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_1_reset; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_en; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_valid; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_0_Re; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_0_Im; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_1_Re; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_1_Im; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_0_Re; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_0_Im; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_1_Re; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_1_Im; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_valid; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_2_clock; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_2_reset; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_en; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_valid; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_0_Re; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_0_Im; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_1_Re; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_1_Im; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_0_Re; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_0_Im; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_1_Re; // @[FFTSRDesigns.scala 189:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_1_Im; // @[FFTSRDesigns.scala 189:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_valid; // @[FFTSRDesigns.scala 189:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_clock; // @[FFTSRDesigns.scala 196:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_reset; // @[FFTSRDesigns.scala 196:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_en; // @[FFTSRDesigns.scala 196:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_0_Re; // @[FFTSRDesigns.scala 196:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_0_Im; // @[FFTSRDesigns.scala 196:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_1_Re; // @[FFTSRDesigns.scala 196:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_1_Im; // @[FFTSRDesigns.scala 196:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_valid; // @[FFTSRDesigns.scala 196:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 196:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 196:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 196:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 196:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_valid; // @[FFTSRDesigns.scala 196:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_clock; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_reset; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_en; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_0_Re; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_0_Im; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_1_Re; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_1_Im; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_valid; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_valid; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_clock; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_reset; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_en; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_0_Re; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_0_Im; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_1_Re; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_1_Im; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_valid; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_0_Re; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_0_Im; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_1_Re; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_1_Im; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_valid; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_clock; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_reset; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_en; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_0_Re; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_0_Im; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_1_Re; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_1_Im; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_valid; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_0_Re; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_0_Im; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_1_Re; // @[FFTSRDesigns.scala 199:30]
  wire [31:0] Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_1_Im; // @[FFTSRDesigns.scala 199:30]
  wire  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_valid; // @[FFTSRDesigns.scala 199:30]
  wire  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_clock; // @[FFTSRDesigns.scala 204:28]
  wire  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_reset; // @[FFTSRDesigns.scala 204:28]
  wire  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_inv; // @[FFTSRDesigns.scala 204:28]
  wire  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_en_main; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_0_Re; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_0_Im; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_1_Re; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_1_Im; // @[FFTSRDesigns.scala 204:28]
  wire  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_valid; // @[FFTSRDesigns.scala 204:28]
  wire  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_valid; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 204:28]
  wire  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_clock; // @[FFTSRDesigns.scala 204:28]
  wire  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_reset; // @[FFTSRDesigns.scala 204:28]
  wire  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_inv; // @[FFTSRDesigns.scala 204:28]
  wire  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_en_main; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_0_Re; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_0_Im; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_1_Re; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_1_Im; // @[FFTSRDesigns.scala 204:28]
  wire  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_valid; // @[FFTSRDesigns.scala 204:28]
  wire  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_valid; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 204:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 204:28]
  DFT_SymmetryExploits_fullwidth_r2_bw32 DFT_SymmetryExploits_fullwidth_r2_bw32 ( // @[FFTSRDesigns.scala 189:30]
    .clock(DFT_SymmetryExploits_fullwidth_r2_bw32_clock),
    .reset(DFT_SymmetryExploits_fullwidth_r2_bw32_reset),
    .io_in_en(DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_en),
    .io_in_valid(DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_valid),
    .io_in_0_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_0_Re),
    .io_in_0_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_0_Im),
    .io_in_1_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_1_Re),
    .io_in_1_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_1_Im),
    .io_out_0_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_0_Re),
    .io_out_0_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_0_Im),
    .io_out_1_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_1_Re),
    .io_out_1_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_1_Im),
    .io_out_valid(DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_valid)
  );
  DFT_SymmetryExploits_fullwidth_r2_bw32 DFT_SymmetryExploits_fullwidth_r2_bw32_1 ( // @[FFTSRDesigns.scala 189:30]
    .clock(DFT_SymmetryExploits_fullwidth_r2_bw32_1_clock),
    .reset(DFT_SymmetryExploits_fullwidth_r2_bw32_1_reset),
    .io_in_en(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_en),
    .io_in_valid(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_valid),
    .io_in_0_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_0_Re),
    .io_in_0_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_0_Im),
    .io_in_1_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_1_Re),
    .io_in_1_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_1_Im),
    .io_out_0_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_0_Re),
    .io_out_0_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_0_Im),
    .io_out_1_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_1_Re),
    .io_out_1_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_1_Im),
    .io_out_valid(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_valid)
  );
  DFT_SymmetryExploits_fullwidth_r2_bw32 DFT_SymmetryExploits_fullwidth_r2_bw32_2 ( // @[FFTSRDesigns.scala 189:30]
    .clock(DFT_SymmetryExploits_fullwidth_r2_bw32_2_clock),
    .reset(DFT_SymmetryExploits_fullwidth_r2_bw32_2_reset),
    .io_in_en(DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_en),
    .io_in_valid(DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_valid),
    .io_in_0_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_0_Re),
    .io_in_0_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_0_Im),
    .io_in_1_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_1_Re),
    .io_in_1_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_1_Im),
    .io_out_0_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_0_Re),
    .io_out_0_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_0_Im),
    .io_out_1_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_1_Re),
    .io_out_1_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_1_Im),
    .io_out_valid(DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_valid)
  );
  Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32 Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32 ( // @[FFTSRDesigns.scala 196:30]
    .clock(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_clock),
    .reset(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_reset),
    .io_in_en(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_en),
    .io_in_0_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_0_Re),
    .io_in_0_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_0_Im),
    .io_in_1_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_1_Re),
    .io_in_1_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_1_Im),
    .io_in_valid(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_valid),
    .io_out_0_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_0_Re),
    .io_out_0_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_0_Im),
    .io_out_1_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_1_Re),
    .io_out_1_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_1_Im),
    .io_out_valid(Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_valid)
  );
  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32 Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32 ( // @[FFTSRDesigns.scala 199:30]
    .clock(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_clock),
    .reset(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_reset),
    .io_in_en(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_en),
    .io_in_0_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_0_Re),
    .io_in_0_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_0_Im),
    .io_in_1_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_1_Re),
    .io_in_1_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_1_Im),
    .io_in_valid(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_valid),
    .io_out_0_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_0_Re),
    .io_out_0_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_0_Im),
    .io_out_1_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_1_Re),
    .io_out_1_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_1_Im),
    .io_out_valid(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_valid)
  );
  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32 Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1 ( // @[FFTSRDesigns.scala 199:30]
    .clock(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_clock),
    .reset(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_reset),
    .io_in_en(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_en),
    .io_in_0_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_0_Re),
    .io_in_0_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_0_Im),
    .io_in_1_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_1_Re),
    .io_in_1_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_1_Im),
    .io_in_valid(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_valid),
    .io_out_0_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_0_Re),
    .io_out_0_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_0_Im),
    .io_out_1_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_1_Re),
    .io_out_1_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_1_Im),
    .io_out_valid(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_valid)
  );
  Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32 Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2 ( // @[FFTSRDesigns.scala 199:30]
    .clock(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_clock),
    .reset(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_reset),
    .io_in_en(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_en),
    .io_in_0_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_0_Re),
    .io_in_0_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_0_Im),
    .io_in_1_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_1_Re),
    .io_in_1_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_1_Im),
    .io_in_valid(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_valid),
    .io_out_0_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_0_Re),
    .io_out_0_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_0_Im),
    .io_out_1_Re(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_1_Re),
    .io_out_1_Im(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_1_Im),
    .io_out_valid(Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_valid)
  );
  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32 TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32 ( // @[FFTSRDesigns.scala 204:28]
    .clock(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_clock),
    .reset(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_reset),
    .io_in_inv(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_inv),
    .io_in_en_main(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_en_main),
    .io_in_0_Re(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_0_Re),
    .io_in_0_Im(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_0_Im),
    .io_in_1_Re(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_1_Re),
    .io_in_1_Im(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_1_Im),
    .io_in_valid(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_valid),
    .io_out_valid(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_valid),
    .io_out_0_Re(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_0_Re),
    .io_out_0_Im(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_0_Im),
    .io_out_1_Re(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_1_Re),
    .io_out_1_Im(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_1_Im)
  );
  TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32 TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32 ( // @[FFTSRDesigns.scala 204:28]
    .clock(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_clock),
    .reset(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_reset),
    .io_in_inv(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_inv),
    .io_in_en_main(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_en_main),
    .io_in_0_Re(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_0_Re),
    .io_in_0_Im(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_0_Im),
    .io_in_1_Re(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_1_Re),
    .io_in_1_Im(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_1_Im),
    .io_in_valid(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_valid),
    .io_out_valid(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_valid),
    .io_out_0_Re(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_0_Re),
    .io_out_0_Im(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_0_Im),
    .io_out_1_Re(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_1_Re),
    .io_out_1_Im(TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_1_Im)
  );
  assign io_out_valid = Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_valid; // @[FFTSRDesigns.scala 208:18]
  assign io_out_0_Re = Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_0_Re; // @[FFTSRDesigns.scala 209:12]
  assign io_out_0_Im = Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_0_Im; // @[FFTSRDesigns.scala 209:12]
  assign io_out_1_Re = Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_1_Re; // @[FFTSRDesigns.scala 209:12]
  assign io_out_1_Im = Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_out_1_Im; // @[FFTSRDesigns.scala 209:12]
  assign io_out_ready = io_in_ready; // @[FFTSRDesigns.scala 207:18]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_clock = clock;
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_reset = reset;
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 236:33]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_valid =
    Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_valid; // @[FFTSRDesigns.scala 239:38]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_0_Re = Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 240:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_0_Im = Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 240:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_1_Re = Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 240:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_1_Im = Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 240:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_clock = clock;
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_reset = reset;
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 236:33]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_valid =
    TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_valid; // @[FFTSRDesigns.scala 242:38]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_0_Re =
    TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 243:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_0_Im =
    TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 243:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_1_Re =
    TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 243:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_1_Im =
    TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 243:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_2_clock = clock;
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_2_reset = reset;
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 236:33]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_valid =
    TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_valid; // @[FFTSRDesigns.scala 242:38]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_0_Re =
    TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 243:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_0_Im =
    TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 243:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_1_Re =
    TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 243:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_in_1_Im =
    TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 243:{42,42}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_clock = clock;
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_reset = reset;
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 219:27]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_0_Re = io_in_0_Re; // @[FFTSRDesigns.scala 220:24]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_0_Im = io_in_0_Im; // @[FFTSRDesigns.scala 220:24]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_1_Re = io_in_1_Re; // @[FFTSRDesigns.scala 220:24]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_1_Im = io_in_1_Im; // @[FFTSRDesigns.scala 220:24]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype1_bw32_io_in_valid = io_in_valid; // @[FFTSRDesigns.scala 221:30]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_clock = clock;
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_reset = reset;
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 224:31]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_0_Re = DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 226:{38,38}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_0_Im = DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 226:{38,38}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_1_Re = DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 226:{38,38}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_1_Im = DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 226:{38,38}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_in_valid =
    DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_valid; // @[FFTSRDesigns.scala 225:34]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_clock = clock;
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_reset = reset;
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 224:31]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_0_Re =
    DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_0_Re; // @[FFTSRDesigns.scala 226:{38,38}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_0_Im =
    DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_0_Im; // @[FFTSRDesigns.scala 226:{38,38}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_1_Re =
    DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_1_Re; // @[FFTSRDesigns.scala 226:{38,38}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_1_Im =
    DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_1_Im; // @[FFTSRDesigns.scala 226:{38,38}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_in_valid =
    DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_valid; // @[FFTSRDesigns.scala 225:34]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_clock = clock;
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_reset = reset;
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 224:31]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_0_Re =
    DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_0_Re; // @[FFTSRDesigns.scala 226:{38,38}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_0_Im =
    DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_0_Im; // @[FFTSRDesigns.scala 226:{38,38}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_1_Re =
    DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_1_Re; // @[FFTSRDesigns.scala 226:{38,38}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_1_Im =
    DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_1_Im; // @[FFTSRDesigns.scala 226:{38,38}]
  assign Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_2_io_in_valid =
    DFT_SymmetryExploits_fullwidth_r2_bw32_2_io_out_valid; // @[FFTSRDesigns.scala 225:34]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_clock = clock;
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_reset = reset;
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_inv = io_in_inv; // @[FFTSRDesigns.scala 230:34]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_en_main = io_in_ready; // @[FFTSRDesigns.scala 231:38]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_0_Re =
    Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 233:30]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_0_Im =
    Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 233:30]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_1_Re =
    Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 233:30]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_1_Im =
    Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 233:30]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage0_bw32_io_in_valid =
    Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_io_out_valid; // @[FFTSRDesigns.scala 232:36]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_clock = clock;
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_reset = reset;
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_inv = io_in_inv; // @[FFTSRDesigns.scala 230:34]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_en_main = io_in_ready; // @[FFTSRDesigns.scala 231:38]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_0_Re =
    Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_0_Re; // @[FFTSRDesigns.scala 233:30]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_0_Im =
    Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_0_Im; // @[FFTSRDesigns.scala 233:30]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_1_Re =
    Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_1_Re; // @[FFTSRDesigns.scala 233:30]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_1_Im =
    Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_1_Im; // @[FFTSRDesigns.scala 233:30]
  assign TwiddleApply_Streaming_NoValid_N8_r2_w2_stage1_bw32_io_in_valid =
    Permute_Streaming_N8_r2_base_r2_w2_ptype0_bw32_1_io_out_valid; // @[FFTSRDesigns.scala 232:36]
endmodule
module simple_RAM_depth128_bw32(
  input         clock,
  input  [6:0]  io_in_addr,
  input  [31:0] io_in_data,
  input         io_in_en,
  input         io_in_we,
  output [31:0] io_out_data
);
  blk_mem_gen_1 u_blk_mem_gen_1(
    .clka(clock),
    .addra(io_in_addr),
    .dina(io_in_data),
    .ena(io_in_en),
    .wea(io_in_we),
    .douta(io_out_data)
  );
endmodule
module SyncMEM_16(
  input         clock,
  input         io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input         io_in_mem_write,
  input         io_in_mem_read,
  input  [6:0]  io_in_mem_waddr,
  input  [6:0]  io_in_mem_raddr,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im
);
  wire  simple_RAM_depth128_bw32_clock; // @[PaddingDesigns.scala 69:37]
  wire [6:0] simple_RAM_depth128_bw32_io_in_addr; // @[PaddingDesigns.scala 69:37]
  wire [31:0] simple_RAM_depth128_bw32_io_in_data; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth128_bw32_io_in_en; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth128_bw32_io_in_we; // @[PaddingDesigns.scala 69:37]
  wire [31:0] simple_RAM_depth128_bw32_io_out_data; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth128_bw32_1_clock; // @[PaddingDesigns.scala 69:37]
  wire [6:0] simple_RAM_depth128_bw32_1_io_in_addr; // @[PaddingDesigns.scala 69:37]
  wire [31:0] simple_RAM_depth128_bw32_1_io_in_data; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth128_bw32_1_io_in_en; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth128_bw32_1_io_in_we; // @[PaddingDesigns.scala 69:37]
  wire [31:0] simple_RAM_depth128_bw32_1_io_out_data; // @[PaddingDesigns.scala 69:37]
  wire  _T = io_in_mem_write & io_in_valid; // @[PaddingDesigns.scala 85:28]
  wire [6:0] _GEN_3 = io_in_mem_read ? io_in_mem_raddr : 7'h0; // @[PaddingDesigns.scala 74:29 93:33 95:33]
  wire [31:0] _GEN_4 = io_in_mem_write & io_in_valid ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 85:43 86:26 73:29]
  wire [31:0] _GEN_5 = io_in_mem_write & io_in_valid ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 85:43 87:26 73:29]
  wire [6:0] _GEN_7 = io_in_mem_write & io_in_valid ? io_in_mem_waddr : _GEN_3; // @[PaddingDesigns.scala 85:43 89:33]
  simple_RAM_depth128_bw32 simple_RAM_depth128_bw32 ( // @[PaddingDesigns.scala 69:37]
    .clock(simple_RAM_depth128_bw32_clock),
    .io_in_addr(simple_RAM_depth128_bw32_io_in_addr),
    .io_in_data(simple_RAM_depth128_bw32_io_in_data),
    .io_in_en(simple_RAM_depth128_bw32_io_in_en),
    .io_in_we(simple_RAM_depth128_bw32_io_in_we),
    .io_out_data(simple_RAM_depth128_bw32_io_out_data)
  );
  simple_RAM_depth128_bw32 simple_RAM_depth128_bw32_1 ( // @[PaddingDesigns.scala 69:37]
    .clock(simple_RAM_depth128_bw32_1_clock),
    .io_in_addr(simple_RAM_depth128_bw32_1_io_in_addr),
    .io_in_data(simple_RAM_depth128_bw32_1_io_in_data),
    .io_in_en(simple_RAM_depth128_bw32_1_io_in_en),
    .io_in_we(simple_RAM_depth128_bw32_1_io_in_we),
    .io_out_data(simple_RAM_depth128_bw32_1_io_out_data)
  );
  assign io_out_data_0_Re = simple_RAM_depth128_bw32_io_out_data; // @[PaddingDesigns.scala 78:25]
  assign io_out_data_0_Im = simple_RAM_depth128_bw32_1_io_out_data; // @[PaddingDesigns.scala 79:25]
  assign simple_RAM_depth128_bw32_clock = clock;
  assign simple_RAM_depth128_bw32_io_in_addr = io_in_ready ? _GEN_7 : 7'h0; // @[PaddingDesigns.scala 84:22 74:29]
  assign simple_RAM_depth128_bw32_io_in_data = io_in_ready ? _GEN_4 : 32'h0; // @[PaddingDesigns.scala 84:22 73:29]
  assign simple_RAM_depth128_bw32_io_in_en = io_in_ready; // @[PaddingDesigns.scala 75:27]
  assign simple_RAM_depth128_bw32_io_in_we = io_in_ready & _T; // @[PaddingDesigns.scala 84:22 76:27]
  assign simple_RAM_depth128_bw32_1_clock = clock;
  assign simple_RAM_depth128_bw32_1_io_in_addr = io_in_ready ? _GEN_7 : 7'h0; // @[PaddingDesigns.scala 84:22 74:29]
  assign simple_RAM_depth128_bw32_1_io_in_data = io_in_ready ? _GEN_5 : 32'h0; // @[PaddingDesigns.scala 84:22 73:29]
  assign simple_RAM_depth128_bw32_1_io_in_en = io_in_ready; // @[PaddingDesigns.scala 75:27]
  assign simple_RAM_depth128_bw32_1_io_in_we = io_in_ready & _T; // @[PaddingDesigns.scala 84:22 76:27]
endmodule
module PencilGroup_8(
  input         clock,
  input         io_in_ready_0,
  input         io_in_ready_1,
  input         io_in_valid_0,
  input         io_in_valid_1,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input  [31:0] io_in_data_1_Re,
  input  [31:0] io_in_data_1_Im,
  input         io_in_mems_0_write,
  input         io_in_mems_0_read,
  input  [6:0]  io_in_mems_0_waddr,
  input  [6:0]  io_in_mems_0_raddr,
  input         io_in_mems_1_write,
  input         io_in_mems_1_read,
  input  [6:0]  io_in_mems_1_waddr,
  input  [6:0]  io_in_mems_1_raddr,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
  wire  pgroup_0_clock; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_0_io_in_ready; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_0_io_in_valid; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_0_io_in_data_0_Re; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_0_io_in_data_0_Im; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_0_io_in_mem_write; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_0_io_in_mem_read; // @[PaddingDesigns.scala 126:40]
  wire [6:0] pgroup_0_io_in_mem_waddr; // @[PaddingDesigns.scala 126:40]
  wire [6:0] pgroup_0_io_in_mem_raddr; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_0_io_out_data_0_Re; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_0_io_out_data_0_Im; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_clock; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_io_in_ready; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_io_in_valid; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_1_io_in_data_0_Re; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_1_io_in_data_0_Im; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_io_in_mem_write; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_io_in_mem_read; // @[PaddingDesigns.scala 126:40]
  wire [6:0] pgroup_1_io_in_mem_waddr; // @[PaddingDesigns.scala 126:40]
  wire [6:0] pgroup_1_io_in_mem_raddr; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 126:40]
  SyncMEM_16 pgroup_0 ( // @[PaddingDesigns.scala 126:40]
    .clock(pgroup_0_clock),
    .io_in_ready(pgroup_0_io_in_ready),
    .io_in_valid(pgroup_0_io_in_valid),
    .io_in_data_0_Re(pgroup_0_io_in_data_0_Re),
    .io_in_data_0_Im(pgroup_0_io_in_data_0_Im),
    .io_in_mem_write(pgroup_0_io_in_mem_write),
    .io_in_mem_read(pgroup_0_io_in_mem_read),
    .io_in_mem_waddr(pgroup_0_io_in_mem_waddr),
    .io_in_mem_raddr(pgroup_0_io_in_mem_raddr),
    .io_out_data_0_Re(pgroup_0_io_out_data_0_Re),
    .io_out_data_0_Im(pgroup_0_io_out_data_0_Im)
  );
  SyncMEM_16 pgroup_1 ( // @[PaddingDesigns.scala 126:40]
    .clock(pgroup_1_clock),
    .io_in_ready(pgroup_1_io_in_ready),
    .io_in_valid(pgroup_1_io_in_valid),
    .io_in_data_0_Re(pgroup_1_io_in_data_0_Re),
    .io_in_data_0_Im(pgroup_1_io_in_data_0_Im),
    .io_in_mem_write(pgroup_1_io_in_mem_write),
    .io_in_mem_read(pgroup_1_io_in_mem_read),
    .io_in_mem_waddr(pgroup_1_io_in_mem_waddr),
    .io_in_mem_raddr(pgroup_1_io_in_mem_raddr),
    .io_out_data_0_Re(pgroup_1_io_out_data_0_Re),
    .io_out_data_0_Im(pgroup_1_io_out_data_0_Im)
  );
  assign io_out_data_0_Re = pgroup_0_io_out_data_0_Re; // @[PaddingDesigns.scala 137:22]
  assign io_out_data_0_Im = pgroup_0_io_out_data_0_Im; // @[PaddingDesigns.scala 137:22]
  assign io_out_data_1_Re = pgroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 137:22]
  assign io_out_data_1_Im = pgroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 137:22]
  assign pgroup_0_clock = clock;
  assign pgroup_0_io_in_ready = io_in_ready_0; // @[PaddingDesigns.scala 131:29]
  assign pgroup_0_io_in_valid = io_in_valid_0; // @[PaddingDesigns.scala 129:29]
  assign pgroup_0_io_in_data_0_Re = io_in_data_0_Re; // @[PaddingDesigns.scala 132:33]
  assign pgroup_0_io_in_data_0_Im = io_in_data_0_Im; // @[PaddingDesigns.scala 132:33]
  assign pgroup_0_io_in_mem_write = io_in_mems_0_write; // @[PaddingDesigns.scala 134:33]
  assign pgroup_0_io_in_mem_read = io_in_mems_0_read; // @[PaddingDesigns.scala 133:32]
  assign pgroup_0_io_in_mem_waddr = io_in_mems_0_waddr; // @[PaddingDesigns.scala 136:33]
  assign pgroup_0_io_in_mem_raddr = io_in_mems_0_raddr; // @[PaddingDesigns.scala 135:33]
  assign pgroup_1_clock = clock;
  assign pgroup_1_io_in_ready = io_in_ready_1; // @[PaddingDesigns.scala 131:29]
  assign pgroup_1_io_in_valid = io_in_valid_1; // @[PaddingDesigns.scala 129:29]
  assign pgroup_1_io_in_data_0_Re = io_in_data_1_Re; // @[PaddingDesigns.scala 132:33]
  assign pgroup_1_io_in_data_0_Im = io_in_data_1_Im; // @[PaddingDesigns.scala 132:33]
  assign pgroup_1_io_in_mem_write = io_in_mems_1_write; // @[PaddingDesigns.scala 134:33]
  assign pgroup_1_io_in_mem_read = io_in_mems_1_read; // @[PaddingDesigns.scala 133:32]
  assign pgroup_1_io_in_mem_waddr = io_in_mems_1_waddr; // @[PaddingDesigns.scala 136:33]
  assign pgroup_1_io_in_mem_raddr = io_in_mems_1_raddr; // @[PaddingDesigns.scala 135:33]
endmodule
module SlabGroup_4(
  input         clock,
  input         io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input  [31:0] io_in_data_1_Re,
  input  [31:0] io_in_data_1_Im,
  input         io_in_write,
  input  [1:0]  io_in_pgroup_slct_0,
  input  [1:0]  io_in_pgroup_slct_1,
  input  [1:0]  io_in_RAM_slct_0,
  input  [1:0]  io_in_RAM_slct_1,
  input  [6:0]  io_in_addr_slct_0,
  input  [6:0]  io_in_addr_slct_1,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  PencilGroup_clock; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_ready_0; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_ready_1; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_valid_0; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_valid_1; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_in_data_0_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_in_data_0_Im; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_in_data_1_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_in_data_1_Im; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_mems_0_write; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_mems_0_read; // @[PaddingDesigns.scala 154:53]
  wire [6:0] PencilGroup_io_in_mems_0_waddr; // @[PaddingDesigns.scala 154:53]
  wire [6:0] PencilGroup_io_in_mems_0_raddr; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_mems_1_write; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_mems_1_read; // @[PaddingDesigns.scala 154:53]
  wire [6:0] PencilGroup_io_in_mems_1_waddr; // @[PaddingDesigns.scala 154:53]
  wire [6:0] PencilGroup_io_in_mems_1_raddr; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_clock; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_ready_0; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_ready_1; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_valid_0; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_valid_1; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_in_data_0_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_in_data_0_Im; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_in_data_1_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_in_data_1_Im; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_mems_0_write; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_mems_0_read; // @[PaddingDesigns.scala 154:53]
  wire [6:0] PencilGroup_1_io_in_mems_0_waddr; // @[PaddingDesigns.scala 154:53]
  wire [6:0] PencilGroup_1_io_in_mems_0_raddr; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_mems_1_write; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_mems_1_read; // @[PaddingDesigns.scala 154:53]
  wire [6:0] PencilGroup_1_io_in_mems_1_waddr; // @[PaddingDesigns.scala 154:53]
  wire [6:0] PencilGroup_1_io_in_mems_1_raddr; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 154:53]
  wire  _io_out_last_T = ~io_in_write; // @[PaddingDesigns.scala 166:79]
  wire  _io_out_last_T_1 = io_in_ready & ~io_in_write; // @[PaddingDesigns.scala 166:77]
  wire  _GEN_146 = ~io_in_pgroup_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_147 = ~io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_148 = ~io_in_pgroup_slct_0[0] & ~io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_12 = ~io_in_pgroup_slct_0[0] & ~io_in_RAM_slct_0[0] & io_in_write; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_150 = ~io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_13 = ~io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] & io_in_write; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_152 = io_in_pgroup_slct_0[0] & ~io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_14 = io_in_pgroup_slct_0[0] & ~io_in_RAM_slct_0[0] & io_in_write; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_153 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_15 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] & io_in_write; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_16 = _GEN_148 & _io_out_last_T; // @[PaddingDesigns.scala 161:35 172:{71,71}]
  wire  _GEN_17 = _GEN_150 & _io_out_last_T; // @[PaddingDesigns.scala 161:35 172:{71,71}]
  wire  _GEN_18 = _GEN_152 & _io_out_last_T; // @[PaddingDesigns.scala 161:35 172:{71,71}]
  wire  _GEN_19 = _GEN_153 & _io_out_last_T; // @[PaddingDesigns.scala 161:35 172:{71,71}]
  wire [6:0] _GEN_20 = _GEN_146 & _GEN_147 ? io_in_addr_slct_0 : 7'h0; // @[PaddingDesigns.scala 163:36 173:{72,72}]
  wire [6:0] _GEN_21 = _GEN_146 & io_in_RAM_slct_0[0] ? io_in_addr_slct_0 : 7'h0; // @[PaddingDesigns.scala 163:36 173:{72,72}]
  wire [6:0] _GEN_22 = io_in_pgroup_slct_0[0] & _GEN_147 ? io_in_addr_slct_0 : 7'h0; // @[PaddingDesigns.scala 163:36 173:{72,72}]
  wire [6:0] _GEN_23 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] ? io_in_addr_slct_0 : 7'h0; // @[PaddingDesigns.scala 163:36 173:{72,72}]
  wire  _GEN_28 = _GEN_148 & io_in_valid; // @[PaddingDesigns.scala 156:28 175:{67,67}]
  wire  _GEN_29 = _GEN_150 & io_in_valid; // @[PaddingDesigns.scala 156:28 175:{67,67}]
  wire  _GEN_30 = _GEN_152 & io_in_valid; // @[PaddingDesigns.scala 156:28 175:{67,67}]
  wire  _GEN_31 = _GEN_153 & io_in_valid; // @[PaddingDesigns.scala 156:28 175:{67,67}]
  wire  _GEN_32 = _GEN_148 & io_in_ready; // @[PaddingDesigns.scala 158:28 176:{67,67}]
  wire  _GEN_33 = _GEN_150 & io_in_ready; // @[PaddingDesigns.scala 158:28 176:{67,67}]
  wire  _GEN_34 = _GEN_152 & io_in_ready; // @[PaddingDesigns.scala 158:28 176:{67,67}]
  wire  _GEN_35 = _GEN_153 & io_in_ready; // @[PaddingDesigns.scala 158:28 176:{67,67}]
  wire [31:0] _GEN_40 = _GEN_146 & _GEN_147 ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_41 = _GEN_146 & io_in_RAM_slct_0[0] ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_42 = io_in_pgroup_slct_0[0] & _GEN_147 ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_43 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_44 = _GEN_146 & _GEN_147 ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_45 = _GEN_146 & io_in_RAM_slct_0[0] ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_46 = io_in_pgroup_slct_0[0] & _GEN_147 ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_47 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  reg [1:0] io_out_data_0_r; // @[Reg.scala 16:16]
  reg [1:0] io_out_data_0_r_1; // @[Reg.scala 16:16]
  wire [31:0] pgroups_0_out_data_0_Im = PencilGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] pgroups_0_out_data_1_Im = PencilGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_51 = ~io_out_data_0_r[0] & io_out_data_0_r_1[0] ? pgroups_0_out_data_1_Im : pgroups_0_out_data_0_Im; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_1_out_data_0_Im = PencilGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_52 = io_out_data_0_r[0] & ~io_out_data_0_r_1[0] ? pgroups_1_out_data_0_Im : _GEN_51; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_1_out_data_1_Im = PencilGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_53 = io_out_data_0_r[0] & io_out_data_0_r_1[0] ? pgroups_1_out_data_1_Im : _GEN_52; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_0_out_data_0_Re = PencilGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] pgroups_0_out_data_1_Re = PencilGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_55 = ~io_out_data_0_r[0] & io_out_data_0_r_1[0] ? pgroups_0_out_data_1_Re : pgroups_0_out_data_0_Re; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_1_out_data_0_Re = PencilGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_56 = io_out_data_0_r[0] & ~io_out_data_0_r_1[0] ? pgroups_1_out_data_0_Re : _GEN_55; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_1_out_data_1_Re = PencilGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_57 = io_out_data_0_r[0] & io_out_data_0_r_1[0] ? pgroups_1_out_data_1_Re : _GEN_56; // @[PaddingDesigns.scala 179:{24,24}]
  wire  _GEN_198 = ~io_in_pgroup_slct_1[0]; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_199 = ~io_in_RAM_slct_1[0]; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_58 = ~io_in_pgroup_slct_1[0] & ~io_in_RAM_slct_1[0] ? io_in_write : _GEN_12; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_59 = ~io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_write : _GEN_13; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_60 = io_in_pgroup_slct_1[0] & ~io_in_RAM_slct_1[0] ? io_in_write : _GEN_14; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_61 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_write : _GEN_15; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_62 = _GEN_198 & _GEN_199 ? _io_out_last_T : _GEN_16; // @[PaddingDesigns.scala 172:{71,71}]
  wire  _GEN_63 = _GEN_198 & io_in_RAM_slct_1[0] ? _io_out_last_T : _GEN_17; // @[PaddingDesigns.scala 172:{71,71}]
  wire  _GEN_64 = io_in_pgroup_slct_1[0] & _GEN_199 ? _io_out_last_T : _GEN_18; // @[PaddingDesigns.scala 172:{71,71}]
  wire  _GEN_65 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? _io_out_last_T : _GEN_19; // @[PaddingDesigns.scala 172:{71,71}]
  wire [6:0] _GEN_66 = _GEN_198 & _GEN_199 ? io_in_addr_slct_1 : _GEN_20; // @[PaddingDesigns.scala 173:{72,72}]
  wire [6:0] _GEN_67 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_addr_slct_1 : _GEN_21; // @[PaddingDesigns.scala 173:{72,72}]
  wire [6:0] _GEN_68 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_addr_slct_1 : _GEN_22; // @[PaddingDesigns.scala 173:{72,72}]
  wire [6:0] _GEN_69 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_addr_slct_1 : _GEN_23; // @[PaddingDesigns.scala 173:{72,72}]
  wire  _GEN_74 = _GEN_198 & _GEN_199 ? io_in_valid : _GEN_28; // @[PaddingDesigns.scala 175:{67,67}]
  wire  _GEN_75 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_valid : _GEN_29; // @[PaddingDesigns.scala 175:{67,67}]
  wire  _GEN_76 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_valid : _GEN_30; // @[PaddingDesigns.scala 175:{67,67}]
  wire  _GEN_77 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_valid : _GEN_31; // @[PaddingDesigns.scala 175:{67,67}]
  wire  _GEN_78 = _GEN_198 & _GEN_199 ? io_in_ready : _GEN_32; // @[PaddingDesigns.scala 176:{67,67}]
  wire  _GEN_79 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_ready : _GEN_33; // @[PaddingDesigns.scala 176:{67,67}]
  wire  _GEN_80 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_ready : _GEN_34; // @[PaddingDesigns.scala 176:{67,67}]
  wire  _GEN_81 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_ready : _GEN_35; // @[PaddingDesigns.scala 176:{67,67}]
  wire [31:0] _GEN_86 = _GEN_198 & _GEN_199 ? io_in_data_1_Im : _GEN_40; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_87 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_data_1_Im : _GEN_41; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_88 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_data_1_Im : _GEN_42; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_89 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_data_1_Im : _GEN_43; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_90 = _GEN_198 & _GEN_199 ? io_in_data_1_Re : _GEN_44; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_91 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_data_1_Re : _GEN_45; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_92 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_data_1_Re : _GEN_46; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_93 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_data_1_Re : _GEN_47; // @[PaddingDesigns.scala 178:{66,66}]
  reg [1:0] io_out_data_1_r; // @[Reg.scala 16:16]
  reg [1:0] io_out_data_1_r_1; // @[Reg.scala 16:16]
  wire [31:0] _GEN_97 = ~io_out_data_1_r[0] & io_out_data_1_r_1[0] ? pgroups_0_out_data_1_Im : pgroups_0_out_data_0_Im; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_98 = io_out_data_1_r[0] & ~io_out_data_1_r_1[0] ? pgroups_1_out_data_0_Im : _GEN_97; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_99 = io_out_data_1_r[0] & io_out_data_1_r_1[0] ? pgroups_1_out_data_1_Im : _GEN_98; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_101 = ~io_out_data_1_r[0] & io_out_data_1_r_1[0] ? pgroups_0_out_data_1_Re : pgroups_0_out_data_0_Re; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_102 = io_out_data_1_r[0] & ~io_out_data_1_r_1[0] ? pgroups_1_out_data_0_Re : _GEN_101; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_103 = io_out_data_1_r[0] & io_out_data_1_r_1[0] ? pgroups_1_out_data_1_Re : _GEN_102; // @[PaddingDesigns.scala 179:{24,24}]
  PencilGroup_8 PencilGroup ( // @[PaddingDesigns.scala 154:53]
    .clock(PencilGroup_clock),
    .io_in_ready_0(PencilGroup_io_in_ready_0),
    .io_in_ready_1(PencilGroup_io_in_ready_1),
    .io_in_valid_0(PencilGroup_io_in_valid_0),
    .io_in_valid_1(PencilGroup_io_in_valid_1),
    .io_in_data_0_Re(PencilGroup_io_in_data_0_Re),
    .io_in_data_0_Im(PencilGroup_io_in_data_0_Im),
    .io_in_data_1_Re(PencilGroup_io_in_data_1_Re),
    .io_in_data_1_Im(PencilGroup_io_in_data_1_Im),
    .io_in_mems_0_write(PencilGroup_io_in_mems_0_write),
    .io_in_mems_0_read(PencilGroup_io_in_mems_0_read),
    .io_in_mems_0_waddr(PencilGroup_io_in_mems_0_waddr),
    .io_in_mems_0_raddr(PencilGroup_io_in_mems_0_raddr),
    .io_in_mems_1_write(PencilGroup_io_in_mems_1_write),
    .io_in_mems_1_read(PencilGroup_io_in_mems_1_read),
    .io_in_mems_1_waddr(PencilGroup_io_in_mems_1_waddr),
    .io_in_mems_1_raddr(PencilGroup_io_in_mems_1_raddr),
    .io_out_data_0_Re(PencilGroup_io_out_data_0_Re),
    .io_out_data_0_Im(PencilGroup_io_out_data_0_Im),
    .io_out_data_1_Re(PencilGroup_io_out_data_1_Re),
    .io_out_data_1_Im(PencilGroup_io_out_data_1_Im)
  );
  PencilGroup_8 PencilGroup_1 ( // @[PaddingDesigns.scala 154:53]
    .clock(PencilGroup_1_clock),
    .io_in_ready_0(PencilGroup_1_io_in_ready_0),
    .io_in_ready_1(PencilGroup_1_io_in_ready_1),
    .io_in_valid_0(PencilGroup_1_io_in_valid_0),
    .io_in_valid_1(PencilGroup_1_io_in_valid_1),
    .io_in_data_0_Re(PencilGroup_1_io_in_data_0_Re),
    .io_in_data_0_Im(PencilGroup_1_io_in_data_0_Im),
    .io_in_data_1_Re(PencilGroup_1_io_in_data_1_Re),
    .io_in_data_1_Im(PencilGroup_1_io_in_data_1_Im),
    .io_in_mems_0_write(PencilGroup_1_io_in_mems_0_write),
    .io_in_mems_0_read(PencilGroup_1_io_in_mems_0_read),
    .io_in_mems_0_waddr(PencilGroup_1_io_in_mems_0_waddr),
    .io_in_mems_0_raddr(PencilGroup_1_io_in_mems_0_raddr),
    .io_in_mems_1_write(PencilGroup_1_io_in_mems_1_write),
    .io_in_mems_1_read(PencilGroup_1_io_in_mems_1_read),
    .io_in_mems_1_waddr(PencilGroup_1_io_in_mems_1_waddr),
    .io_in_mems_1_raddr(PencilGroup_1_io_in_mems_1_raddr),
    .io_out_data_0_Re(PencilGroup_1_io_out_data_0_Re),
    .io_out_data_0_Im(PencilGroup_1_io_out_data_0_Im),
    .io_out_data_1_Re(PencilGroup_1_io_out_data_1_Re),
    .io_out_data_1_Im(PencilGroup_1_io_out_data_1_Im)
  );
  assign io_out_data_0_Re = io_in_ready ? _GEN_57 : 32'h0; // @[PaddingDesigns.scala 169:22 179:24 168:27]
  assign io_out_data_0_Im = io_in_ready ? _GEN_53 : 32'h0; // @[PaddingDesigns.scala 169:22 179:24 168:27]
  assign io_out_data_1_Re = io_in_ready ? _GEN_103 : 32'h0; // @[PaddingDesigns.scala 169:22 179:24 168:27]
  assign io_out_data_1_Im = io_in_ready ? _GEN_99 : 32'h0; // @[PaddingDesigns.scala 169:22 179:24 168:27]
  assign PencilGroup_clock = clock;
  assign PencilGroup_io_in_ready_0 = io_in_ready & _GEN_78; // @[PaddingDesigns.scala 169:22 158:28]
  assign PencilGroup_io_in_ready_1 = io_in_ready & _GEN_79; // @[PaddingDesigns.scala 169:22 158:28]
  assign PencilGroup_io_in_valid_0 = io_in_ready & _GEN_74; // @[PaddingDesigns.scala 169:22 156:28]
  assign PencilGroup_io_in_valid_1 = io_in_ready & _GEN_75; // @[PaddingDesigns.scala 169:22 156:28]
  assign PencilGroup_io_in_data_0_Re = io_in_ready ? _GEN_90 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_io_in_data_0_Im = io_in_ready ? _GEN_86 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_io_in_data_1_Re = io_in_ready ? _GEN_91 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_io_in_data_1_Im = io_in_ready ? _GEN_87 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_io_in_mems_0_write = io_in_ready & _GEN_58; // @[PaddingDesigns.scala 169:22 160:36]
  assign PencilGroup_io_in_mems_0_read = io_in_ready & _GEN_62; // @[PaddingDesigns.scala 169:22 161:35]
  assign PencilGroup_io_in_mems_0_waddr = io_in_ready ? _GEN_66 : 7'h0; // @[PaddingDesigns.scala 169:22 163:36]
  assign PencilGroup_io_in_mems_0_raddr = io_in_ready ? _GEN_66 : 7'h0; // @[PaddingDesigns.scala 169:22 162:36]
  assign PencilGroup_io_in_mems_1_write = io_in_ready & _GEN_59; // @[PaddingDesigns.scala 169:22 160:36]
  assign PencilGroup_io_in_mems_1_read = io_in_ready & _GEN_63; // @[PaddingDesigns.scala 169:22 161:35]
  assign PencilGroup_io_in_mems_1_waddr = io_in_ready ? _GEN_67 : 7'h0; // @[PaddingDesigns.scala 169:22 163:36]
  assign PencilGroup_io_in_mems_1_raddr = io_in_ready ? _GEN_67 : 7'h0; // @[PaddingDesigns.scala 169:22 162:36]
  assign PencilGroup_1_clock = clock;
  assign PencilGroup_1_io_in_ready_0 = io_in_ready & _GEN_80; // @[PaddingDesigns.scala 169:22 158:28]
  assign PencilGroup_1_io_in_ready_1 = io_in_ready & _GEN_81; // @[PaddingDesigns.scala 169:22 158:28]
  assign PencilGroup_1_io_in_valid_0 = io_in_ready & _GEN_76; // @[PaddingDesigns.scala 169:22 156:28]
  assign PencilGroup_1_io_in_valid_1 = io_in_ready & _GEN_77; // @[PaddingDesigns.scala 169:22 156:28]
  assign PencilGroup_1_io_in_data_0_Re = io_in_ready ? _GEN_92 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_1_io_in_data_0_Im = io_in_ready ? _GEN_88 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_1_io_in_data_1_Re = io_in_ready ? _GEN_93 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_1_io_in_data_1_Im = io_in_ready ? _GEN_89 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_1_io_in_mems_0_write = io_in_ready & _GEN_60; // @[PaddingDesigns.scala 169:22 160:36]
  assign PencilGroup_1_io_in_mems_0_read = io_in_ready & _GEN_64; // @[PaddingDesigns.scala 169:22 161:35]
  assign PencilGroup_1_io_in_mems_0_waddr = io_in_ready ? _GEN_68 : 7'h0; // @[PaddingDesigns.scala 169:22 163:36]
  assign PencilGroup_1_io_in_mems_0_raddr = io_in_ready ? _GEN_68 : 7'h0; // @[PaddingDesigns.scala 169:22 162:36]
  assign PencilGroup_1_io_in_mems_1_write = io_in_ready & _GEN_61; // @[PaddingDesigns.scala 169:22 160:36]
  assign PencilGroup_1_io_in_mems_1_read = io_in_ready & _GEN_65; // @[PaddingDesigns.scala 169:22 161:35]
  assign PencilGroup_1_io_in_mems_1_waddr = io_in_ready ? _GEN_69 : 7'h0; // @[PaddingDesigns.scala 169:22 163:36]
  assign PencilGroup_1_io_in_mems_1_raddr = io_in_ready ? _GEN_69 : 7'h0; // @[PaddingDesigns.scala 169:22 162:36]
  always @(posedge clock) begin
    if (_io_out_last_T_1) begin // @[Reg.scala 17:18]
      io_out_data_0_r <= io_in_pgroup_slct_0; // @[Reg.scala 17:22]
    end
    if (_io_out_last_T_1) begin // @[Reg.scala 17:18]
      io_out_data_0_r_1 <= io_in_RAM_slct_0; // @[Reg.scala 17:22]
    end
    if (_io_out_last_T_1) begin // @[Reg.scala 17:18]
      io_out_data_1_r <= io_in_pgroup_slct_1; // @[Reg.scala 17:22]
    end
    if (_io_out_last_T_1) begin // @[Reg.scala 17:18]
      io_out_data_1_r_1 <= io_in_RAM_slct_1; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_out_data_0_r = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  io_out_data_0_r_1 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  io_out_data_1_r = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  io_out_data_1_r_1 = _RAND_3[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SimpleTrnsp_batched_2(
  input         clock,
  input         reset,
  input         io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input  [31:0] io_in_data_1_Re,
  input  [31:0] io_in_data_1_Im,
  output        io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
`endif // RANDOMIZE_REG_INIT
  wire  SlabGroup_clock; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_io_in_ready; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_io_in_valid; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_1_Im; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_io_in_write; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_pgroup_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_pgroup_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_RAM_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_RAM_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [6:0] SlabGroup_io_in_addr_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [6:0] SlabGroup_io_in_addr_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_clock; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_io_in_ready; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_io_in_valid; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_1_Im; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_io_in_write; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_pgroup_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_pgroup_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_RAM_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_RAM_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [6:0] SlabGroup_1_io_in_addr_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [6:0] SlabGroup_1_io_in_addr_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 463:39]
  reg [4:0] value; // @[Counter.scala 62:40]
  reg [4:0] value_1; // @[Counter.scala 62:40]
  reg  reg_read_out; // @[PaddingDesigns.scala 450:31]
  reg [1:0] value_2; // @[Counter.scala 62:40]
  reg [2:0] value_3; // @[Counter.scala 62:40]
  reg [2:0] value_4; // @[Counter.scala 62:40]
  reg [7:0] reg_in_batch_offst; // @[PaddingDesigns.scala 454:37]
  reg [7:0] reg_out_batch_offst; // @[PaddingDesigns.scala 455:38]
  reg [7:0] reg_out_addr_offst; // @[PaddingDesigns.scala 456:37]
  reg [1:0] value_5; // @[Counter.scala 62:40]
  reg  value_6; // @[Counter.scala 62:40]
  reg [7:0] reg_in_addr_offst; // @[PaddingDesigns.scala 459:36]
  reg [1:0] value_7; // @[Counter.scala 62:40]
  reg  value_8; // @[Counter.scala 62:40]
  reg  WR_mode; // @[PaddingDesigns.scala 462:26]
  wire  _io_out_last_T = ~WR_mode; // @[PaddingDesigns.scala 475:40]
  wire  _io_out_valid_T_1 = reg_read_out & value_2 == 2'h0; // @[PaddingDesigns.scala 477:48]
  reg  io_out_valid_r; // @[Reg.scala 16:16]
  reg  r; // @[Reg.scala 16:16]
  wire [31:0] slabs_0_out_data_0_Im = SlabGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_0_Im = SlabGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_0_out_data_0_Re = SlabGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_0_Re = SlabGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_0_out_data_1_Im = SlabGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_1_Im = SlabGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_0_out_data_1_Re = SlabGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_1_Re = SlabGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire  _GEN_15 = _io_out_last_T & io_in_ready; // @[PaddingDesigns.scala 466:18 483:{38,38}]
  wire  _GEN_16 = WR_mode & io_in_ready; // @[PaddingDesigns.scala 466:18 483:{38,38}]
  wire  _GEN_19 = _io_out_last_T & io_in_valid; // @[PaddingDesigns.scala 467:18 485:{38,38}]
  wire  _GEN_20 = WR_mode & io_in_valid; // @[PaddingDesigns.scala 467:18 485:{38,38}]
  wire [31:0] _GEN_21 = ~WR_mode ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_22 = WR_mode ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_23 = ~WR_mode ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_24 = WR_mode ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_25 = ~WR_mode ? io_in_data_1_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_26 = WR_mode ? io_in_data_1_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_27 = ~WR_mode ? io_in_data_1_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_28 = WR_mode ? io_in_data_1_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [1:0] _slabs_WR_mode_in_pgroup_slct_0 = {{1'd0}, value_8}; // @[PaddingDesigns.scala 487:{54,54}]
  wire [1:0] _GEN_29 = ~WR_mode ? _slabs_WR_mode_in_pgroup_slct_0 : 2'h0; // @[PaddingDesigns.scala 471:33 487:{54,54}]
  wire [1:0] _GEN_30 = WR_mode ? _slabs_WR_mode_in_pgroup_slct_0 : 2'h0; // @[PaddingDesigns.scala 471:33 487:{54,54}]
  wire [1:0] _GEN_35 = ~WR_mode ? 2'h1 : 2'h0; // @[PaddingDesigns.scala 472:30 488:{41,41}]
  wire [1:0] _GEN_36 = WR_mode ? 2'h1 : 2'h0; // @[PaddingDesigns.scala 472:30 488:{41,41}]
  wire [7:0] _GEN_161 = {{6'd0}, value_7}; // @[PaddingDesigns.scala 489:73]
  wire [7:0] _slabs_in_addr_slct_0_T_1 = reg_in_addr_offst + _GEN_161; // @[PaddingDesigns.scala 489:73]
  wire [7:0] _slabs_in_addr_slct_0_T_3 = _slabs_in_addr_slct_0_T_1 + reg_in_batch_offst; // @[PaddingDesigns.scala 489:93]
  wire [6:0] _GEN_37 = ~WR_mode ? _slabs_in_addr_slct_0_T_3[6:0] : 7'h0; // @[PaddingDesigns.scala 473:31 489:{52,52}]
  wire [6:0] _GEN_38 = WR_mode ? _slabs_in_addr_slct_0_T_3[6:0] : 7'h0; // @[PaddingDesigns.scala 473:31 489:{52,52}]
  wire  wrap = value_3 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_1 = value_3 + 3'h1; // @[Counter.scala 78:24]
  wire  _T_3 = value_1 == 5'h1f; // @[PaddingDesigns.scala 494:27]
  wire [4:0] _value_T_3 = value_1 + 5'h1; // @[Counter.scala 78:24]
  wire  wrap_2 = value_7 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_5 = value_7 + 2'h1; // @[Counter.scala 78:24]
  wire [7:0] _reg_in_addr_offst_T_1 = reg_in_addr_offst + 8'h4; // @[PaddingDesigns.scala 507:54]
  wire [7:0] _GEN_41 = value_8 ? _reg_in_addr_offst_T_1 : reg_in_addr_offst; // @[PaddingDesigns.scala 506:54 507:33 459:36]
  wire  _GEN_42 = wrap_2 ? value_8 + 1'h1 : value_8; // @[PaddingDesigns.scala 504:67 Counter.scala 78:15 62:40]
  wire [7:0] _GEN_43 = wrap_2 ? _GEN_41 : reg_in_addr_offst; // @[PaddingDesigns.scala 459:36 504:67]
  wire  _GEN_46 = value_1 == 5'h1f | reg_read_out; // @[PaddingDesigns.scala 494:76 497:24 450:31]
  wire [7:0] _reg_in_batch_offst_T_1 = reg_in_batch_offst + 8'h10; // @[PaddingDesigns.scala 512:50]
  wire  _GEN_53 = wrap ? _GEN_46 : reg_read_out; // @[PaddingDesigns.scala 450:31 492:52]
  wire  _GEN_57 = io_in_ready & io_in_valid & _io_out_last_T; // @[PaddingDesigns.scala 470:18 481:36]
  wire  _GEN_58 = io_in_ready & io_in_valid & WR_mode; // @[PaddingDesigns.scala 470:18 481:36]
  wire  _GEN_59 = io_in_ready & io_in_valid & _GEN_15; // @[PaddingDesigns.scala 466:18 481:36]
  wire  _GEN_60 = io_in_ready & io_in_valid & _GEN_16; // @[PaddingDesigns.scala 466:18 481:36]
  wire [1:0] _GEN_73 = io_in_ready & io_in_valid ? _GEN_29 : 2'h0; // @[PaddingDesigns.scala 471:33 481:36]
  wire [1:0] _GEN_74 = io_in_ready & io_in_valid ? _GEN_30 : 2'h0; // @[PaddingDesigns.scala 471:33 481:36]
  wire [1:0] _GEN_79 = io_in_ready & io_in_valid ? _GEN_35 : 2'h0; // @[PaddingDesigns.scala 472:30 481:36]
  wire [1:0] _GEN_80 = io_in_ready & io_in_valid ? _GEN_36 : 2'h0; // @[PaddingDesigns.scala 472:30 481:36]
  wire [6:0] _GEN_81 = io_in_ready & io_in_valid ? _GEN_37 : 7'h0; // @[PaddingDesigns.scala 473:31 481:36]
  wire [6:0] _GEN_82 = io_in_ready & io_in_valid ? _GEN_38 : 7'h0; // @[PaddingDesigns.scala 473:31 481:36]
  wire  _GEN_89 = io_in_ready & io_in_valid ? _GEN_53 : reg_read_out; // @[PaddingDesigns.scala 450:31 481:36]
  wire  _GEN_93 = ~_io_out_last_T ? 1'h0 : _GEN_57; // @[PaddingDesigns.scala 520:{39,39}]
  wire  _GEN_94 = _io_out_last_T ? 1'h0 : _GEN_58; // @[PaddingDesigns.scala 520:{39,39}]
  wire  _GEN_95 = ~_io_out_last_T ? io_in_ready : _GEN_59; // @[PaddingDesigns.scala 521:{39,39}]
  wire  _GEN_96 = _io_out_last_T ? io_in_ready : _GEN_60; // @[PaddingDesigns.scala 521:{39,39}]
  wire [1:0] _GEN_97 = ~_io_out_last_T ? 2'h0 : _GEN_73; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _GEN_98 = _io_out_last_T ? 2'h0 : _GEN_74; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _GEN_99 = ~_io_out_last_T ? 2'h1 : _GEN_73; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _GEN_100 = _io_out_last_T ? 2'h1 : _GEN_74; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _slabs_T_10_in_RAM_slct_0 = {{1'd0}, value_6}; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_101 = ~_io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : 2'h0; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_102 = _io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : 2'h0; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_103 = ~_io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : _GEN_79; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_104 = _io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : _GEN_80; // @[PaddingDesigns.scala 523:{52,52}]
  wire [7:0] _GEN_163 = {{6'd0}, value_5}; // @[PaddingDesigns.scala 524:75]
  wire [7:0] _slabs_in_addr_slct_0_T_5 = reg_out_addr_offst + _GEN_163; // @[PaddingDesigns.scala 524:75]
  wire [7:0] _slabs_in_addr_slct_0_T_7 = _slabs_in_addr_slct_0_T_5 + reg_out_batch_offst; // @[PaddingDesigns.scala 524:96]
  wire [6:0] _GEN_105 = ~_io_out_last_T ? _slabs_in_addr_slct_0_T_7[6:0] : _GEN_81; // @[PaddingDesigns.scala 524:{53,53}]
  wire [6:0] _GEN_106 = _io_out_last_T ? _slabs_in_addr_slct_0_T_7[6:0] : _GEN_82; // @[PaddingDesigns.scala 524:{53,53}]
  wire  wrap_4 = value_2 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_9 = value_2 + 2'h1; // @[Counter.scala 78:24]
  wire  wrap_5 = value_4 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_11 = value_4 + 3'h1; // @[Counter.scala 78:24]
  wire  _T_16 = io_in_valid & _T_3; // @[PaddingDesigns.scala 533:30]
  wire [4:0] _value_T_13 = value + 5'h1; // @[Counter.scala 78:24]
  wire [1:0] _value_T_17 = value_5 + 2'h1; // @[Counter.scala 78:24]
  wire [1:0] _GEN_110 = value_6 ? _value_T_17 : value_5; // @[PaddingDesigns.scala 547:54 Counter.scala 78:15 62:40]
  wire [7:0] _reg_out_addr_offst_T_1 = reg_out_addr_offst + 8'h4; // @[PaddingDesigns.scala 551:56]
  wire [7:0] _GEN_111 = reg_out_addr_offst == 8'hc ? 8'h0 : _reg_out_addr_offst_T_1; // @[PaddingDesigns.scala 544:95 545:34 551:34]
  wire  _GEN_112 = reg_out_addr_offst == 8'hc ? value_6 + 1'h1 : value_6; // @[PaddingDesigns.scala 544:95 Counter.scala 78:15 62:40]
  wire [1:0] _GEN_113 = reg_out_addr_offst == 8'hc ? _GEN_110 : value_5; // @[PaddingDesigns.scala 544:95 Counter.scala 62:40]
  wire [4:0] _GEN_114 = value == 5'h1f ? 5'h0 : _value_T_13; // @[PaddingDesigns.scala 531:79 Counter.scala 99:11 78:15]
  wire  _GEN_115 = value == 5'h1f ? _T_16 : _GEN_89; // @[PaddingDesigns.scala 531:79]
  wire [7:0] _GEN_116 = value == 5'h1f ? 8'h0 : _GEN_111; // @[PaddingDesigns.scala 531:79 538:32]
  wire [1:0] _GEN_117 = value == 5'h1f ? 2'h0 : _GEN_113; // @[PaddingDesigns.scala 531:79 Counter.scala 99:11]
  wire  _GEN_118 = value == 5'h1f ? 1'h0 : _GEN_112; // @[PaddingDesigns.scala 531:79 Counter.scala 99:11]
  wire [1:0] _GEN_119 = value == 5'h1f ? 2'h0 : _value_T_9; // @[PaddingDesigns.scala 531:79 Counter.scala 99:11 78:15]
  wire [7:0] _reg_out_batch_offst_T_1 = reg_out_batch_offst + 8'h10; // @[PaddingDesigns.scala 555:54]
  SlabGroup_4 SlabGroup ( // @[PaddingDesigns.scala 463:39]
    .clock(SlabGroup_clock),
    .io_in_ready(SlabGroup_io_in_ready),
    .io_in_valid(SlabGroup_io_in_valid),
    .io_in_data_0_Re(SlabGroup_io_in_data_0_Re),
    .io_in_data_0_Im(SlabGroup_io_in_data_0_Im),
    .io_in_data_1_Re(SlabGroup_io_in_data_1_Re),
    .io_in_data_1_Im(SlabGroup_io_in_data_1_Im),
    .io_in_write(SlabGroup_io_in_write),
    .io_in_pgroup_slct_0(SlabGroup_io_in_pgroup_slct_0),
    .io_in_pgroup_slct_1(SlabGroup_io_in_pgroup_slct_1),
    .io_in_RAM_slct_0(SlabGroup_io_in_RAM_slct_0),
    .io_in_RAM_slct_1(SlabGroup_io_in_RAM_slct_1),
    .io_in_addr_slct_0(SlabGroup_io_in_addr_slct_0),
    .io_in_addr_slct_1(SlabGroup_io_in_addr_slct_1),
    .io_out_data_0_Re(SlabGroup_io_out_data_0_Re),
    .io_out_data_0_Im(SlabGroup_io_out_data_0_Im),
    .io_out_data_1_Re(SlabGroup_io_out_data_1_Re),
    .io_out_data_1_Im(SlabGroup_io_out_data_1_Im)
  );
  SlabGroup_4 SlabGroup_1 ( // @[PaddingDesigns.scala 463:39]
    .clock(SlabGroup_1_clock),
    .io_in_ready(SlabGroup_1_io_in_ready),
    .io_in_valid(SlabGroup_1_io_in_valid),
    .io_in_data_0_Re(SlabGroup_1_io_in_data_0_Re),
    .io_in_data_0_Im(SlabGroup_1_io_in_data_0_Im),
    .io_in_data_1_Re(SlabGroup_1_io_in_data_1_Re),
    .io_in_data_1_Im(SlabGroup_1_io_in_data_1_Im),
    .io_in_write(SlabGroup_1_io_in_write),
    .io_in_pgroup_slct_0(SlabGroup_1_io_in_pgroup_slct_0),
    .io_in_pgroup_slct_1(SlabGroup_1_io_in_pgroup_slct_1),
    .io_in_RAM_slct_0(SlabGroup_1_io_in_RAM_slct_0),
    .io_in_RAM_slct_1(SlabGroup_1_io_in_RAM_slct_1),
    .io_in_addr_slct_0(SlabGroup_1_io_in_addr_slct_0),
    .io_in_addr_slct_1(SlabGroup_1_io_in_addr_slct_1),
    .io_out_data_0_Re(SlabGroup_1_io_out_data_0_Re),
    .io_out_data_0_Im(SlabGroup_1_io_out_data_0_Im),
    .io_out_data_1_Re(SlabGroup_1_io_out_data_1_Re),
    .io_out_data_1_Im(SlabGroup_1_io_out_data_1_Im)
  );
  assign io_out_ready = io_in_ready; // @[PaddingDesigns.scala 478:18]
  assign io_out_valid = io_out_valid_r; // @[PaddingDesigns.scala 477:18]
  assign io_out_data_0_Re = r ? slabs_1_out_data_0_Re : slabs_0_out_data_0_Re; // @[PaddingDesigns.scala 479:{17,17}]
  assign io_out_data_0_Im = r ? slabs_1_out_data_0_Im : slabs_0_out_data_0_Im; // @[PaddingDesigns.scala 479:{17,17}]
  assign io_out_data_1_Re = r ? slabs_1_out_data_1_Re : slabs_0_out_data_1_Re; // @[PaddingDesigns.scala 479:{17,17}]
  assign io_out_data_1_Im = r ? slabs_1_out_data_1_Im : slabs_0_out_data_1_Im; // @[PaddingDesigns.scala 479:{17,17}]
  assign SlabGroup_clock = clock;
  assign SlabGroup_io_in_ready = io_in_ready & reg_read_out ? _GEN_95 : _GEN_59; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_valid = io_in_ready & io_in_valid & _GEN_19; // @[PaddingDesigns.scala 467:18 481:36]
  assign SlabGroup_io_in_data_0_Re = io_in_ready & io_in_valid ? _GEN_23 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_data_0_Im = io_in_ready & io_in_valid ? _GEN_21 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_data_1_Re = io_in_ready & io_in_valid ? _GEN_27 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_data_1_Im = io_in_ready & io_in_valid ? _GEN_25 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_write = io_in_ready & reg_read_out ? _GEN_93 : _GEN_57; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_pgroup_slct_0 = io_in_ready & reg_read_out ? _GEN_97 : _GEN_73; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_pgroup_slct_1 = io_in_ready & reg_read_out ? _GEN_99 : _GEN_73; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_RAM_slct_0 = io_in_ready & reg_read_out ? _GEN_101 : 2'h0; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_RAM_slct_1 = io_in_ready & reg_read_out ? _GEN_103 : _GEN_79; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_addr_slct_0 = io_in_ready & reg_read_out ? _GEN_105 : _GEN_81; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_addr_slct_1 = io_in_ready & reg_read_out ? _GEN_105 : _GEN_81; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_clock = clock;
  assign SlabGroup_1_io_in_ready = io_in_ready & reg_read_out ? _GEN_96 : _GEN_60; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_valid = io_in_ready & io_in_valid & _GEN_20; // @[PaddingDesigns.scala 467:18 481:36]
  assign SlabGroup_1_io_in_data_0_Re = io_in_ready & io_in_valid ? _GEN_24 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_data_0_Im = io_in_ready & io_in_valid ? _GEN_22 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_data_1_Re = io_in_ready & io_in_valid ? _GEN_28 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_data_1_Im = io_in_ready & io_in_valid ? _GEN_26 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_write = io_in_ready & reg_read_out ? _GEN_94 : _GEN_58; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_pgroup_slct_0 = io_in_ready & reg_read_out ? _GEN_98 : _GEN_74; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_pgroup_slct_1 = io_in_ready & reg_read_out ? _GEN_100 : _GEN_74; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_RAM_slct_0 = io_in_ready & reg_read_out ? _GEN_102 : 2'h0; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_RAM_slct_1 = io_in_ready & reg_read_out ? _GEN_104 : _GEN_80; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_addr_slct_0 = io_in_ready & reg_read_out ? _GEN_106 : _GEN_82; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_addr_slct_1 = io_in_ready & reg_read_out ? _GEN_106 : _GEN_82; // @[PaddingDesigns.scala 519:37]
  always @(posedge clock) begin
    if (reset) begin // @[Counter.scala 62:40]
      value <= 5'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          value <= _GEN_114;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_1 <= 5'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (wrap) begin // @[PaddingDesigns.scala 492:52]
        if (value_1 == 5'h1f) begin // @[PaddingDesigns.scala 494:76]
          value_1 <= 5'h0; // @[Counter.scala 99:11]
        end else begin
          value_1 <= _value_T_3; // @[Counter.scala 78:15]
        end
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 450:31]
      reg_read_out <= 1'h0; // @[PaddingDesigns.scala 450:31]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          reg_read_out <= _GEN_115;
        end else begin
          reg_read_out <= _GEN_89;
        end
      end else begin
        reg_read_out <= _GEN_89;
      end
    end else begin
      reg_read_out <= _GEN_89;
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_2 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          value_2 <= _GEN_119;
        end else begin
          value_2 <= _value_T_9; // @[Counter.scala 78:15]
        end
      end else begin
        value_2 <= _value_T_9; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_3 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      value_3 <= _value_T_1; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_4 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        value_4 <= _value_T_11; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 454:37]
      reg_in_batch_offst <= 8'h0; // @[PaddingDesigns.scala 454:37]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (wrap) begin // @[PaddingDesigns.scala 492:52]
        reg_in_batch_offst <= 8'h0; // @[PaddingDesigns.scala 493:28]
      end else begin
        reg_in_batch_offst <= _reg_in_batch_offst_T_1; // @[PaddingDesigns.scala 512:28]
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 455:38]
      reg_out_batch_offst <= 8'h0; // @[PaddingDesigns.scala 455:38]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          reg_out_batch_offst <= 8'h0; // @[PaddingDesigns.scala 530:31]
        end else begin
          reg_out_batch_offst <= _reg_out_batch_offst_T_1; // @[PaddingDesigns.scala 555:31]
        end
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 456:37]
      reg_out_addr_offst <= 8'h0; // @[PaddingDesigns.scala 456:37]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          reg_out_addr_offst <= _GEN_116;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_5 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          value_5 <= _GEN_117;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_6 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          value_6 <= _GEN_118;
        end
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 459:36]
      reg_in_addr_offst <= 8'h0; // @[PaddingDesigns.scala 459:36]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (wrap) begin // @[PaddingDesigns.scala 492:52]
        if (value_1 == 5'h1f) begin // @[PaddingDesigns.scala 494:76]
          reg_in_addr_offst <= 8'h0; // @[PaddingDesigns.scala 498:29]
        end else begin
          reg_in_addr_offst <= _GEN_43;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_7 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (wrap) begin // @[PaddingDesigns.scala 492:52]
        if (value_1 == 5'h1f) begin // @[PaddingDesigns.scala 494:76]
          value_7 <= 2'h0; // @[Counter.scala 99:11]
        end else begin
          value_7 <= _value_T_5; // @[Counter.scala 78:15]
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_8 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (wrap) begin // @[PaddingDesigns.scala 492:52]
        if (value_1 == 5'h1f) begin // @[PaddingDesigns.scala 494:76]
          value_8 <= 1'h0; // @[Counter.scala 99:11]
        end else begin
          value_8 <= _GEN_42;
        end
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 462:26]
      WR_mode <= 1'h0; // @[PaddingDesigns.scala 462:26]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (wrap) begin // @[PaddingDesigns.scala 492:52]
        if (value_1 == 5'h1f) begin // @[PaddingDesigns.scala 494:76]
          WR_mode <= _io_out_last_T; // @[PaddingDesigns.scala 496:19]
        end
      end
    end
    if (io_in_ready) begin // @[Reg.scala 17:18]
      io_out_valid_r <= _io_out_valid_T_1; // @[Reg.scala 17:22]
    end
    if (io_in_ready) begin // @[Reg.scala 17:18]
      r <= _io_out_last_T; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  value = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  value_1 = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  reg_read_out = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  value_2 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  value_3 = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  value_4 = _RAND_5[2:0];
  _RAND_6 = {1{`RANDOM}};
  reg_in_batch_offst = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  reg_out_batch_offst = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  reg_out_addr_offst = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  value_5 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  value_6 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  reg_in_addr_offst = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  value_7 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  value_8 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  WR_mode = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  io_out_valid_r = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  r = _RAND_16[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module simple_RAM_depth1024_bw32(
  input         clock,
  input  [9:0]  io_in_addr,
  input  [31:0] io_in_data,
  input         io_in_en,
  input         io_in_we,
  output [31:0] io_out_data
);
  blk_mem_gen_2 u_blk_mem_gen_2(
    .clka(clock),
    .addra(io_in_addr),
    .dina(io_in_data),
    .ena(io_in_en),
    .wea(io_in_we),
    .douta(io_out_data)
  );
endmodule
module SyncMEM_24(
  input         clock,
  input         io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input         io_in_mem_write,
  input         io_in_mem_read,
  input  [9:0]  io_in_mem_waddr,
  input  [9:0]  io_in_mem_raddr,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im
);
  wire  simple_RAM_depth1024_bw32_clock; // @[PaddingDesigns.scala 69:37]
  wire [9:0] simple_RAM_depth1024_bw32_io_in_addr; // @[PaddingDesigns.scala 69:37]
  wire [31:0] simple_RAM_depth1024_bw32_io_in_data; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth1024_bw32_io_in_en; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth1024_bw32_io_in_we; // @[PaddingDesigns.scala 69:37]
  wire [31:0] simple_RAM_depth1024_bw32_io_out_data; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth1024_bw32_1_clock; // @[PaddingDesigns.scala 69:37]
  wire [9:0] simple_RAM_depth1024_bw32_1_io_in_addr; // @[PaddingDesigns.scala 69:37]
  wire [31:0] simple_RAM_depth1024_bw32_1_io_in_data; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth1024_bw32_1_io_in_en; // @[PaddingDesigns.scala 69:37]
  wire  simple_RAM_depth1024_bw32_1_io_in_we; // @[PaddingDesigns.scala 69:37]
  wire [31:0] simple_RAM_depth1024_bw32_1_io_out_data; // @[PaddingDesigns.scala 69:37]
  wire  _T = io_in_mem_write & io_in_valid; // @[PaddingDesigns.scala 85:28]
  wire [9:0] _GEN_3 = io_in_mem_read ? io_in_mem_raddr : 10'h0; // @[PaddingDesigns.scala 74:29 93:33 95:33]
  wire [31:0] _GEN_4 = io_in_mem_write & io_in_valid ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 85:43 86:26 73:29]
  wire [31:0] _GEN_5 = io_in_mem_write & io_in_valid ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 85:43 87:26 73:29]
  wire [9:0] _GEN_7 = io_in_mem_write & io_in_valid ? io_in_mem_waddr : _GEN_3; // @[PaddingDesigns.scala 85:43 89:33]
  simple_RAM_depth1024_bw32 simple_RAM_depth1024_bw32 ( // @[PaddingDesigns.scala 69:37]
    .clock(simple_RAM_depth1024_bw32_clock),
    .io_in_addr(simple_RAM_depth1024_bw32_io_in_addr),
    .io_in_data(simple_RAM_depth1024_bw32_io_in_data),
    .io_in_en(simple_RAM_depth1024_bw32_io_in_en),
    .io_in_we(simple_RAM_depth1024_bw32_io_in_we),
    .io_out_data(simple_RAM_depth1024_bw32_io_out_data)
  );
  simple_RAM_depth1024_bw32 simple_RAM_depth1024_bw32_1 ( // @[PaddingDesigns.scala 69:37]
    .clock(simple_RAM_depth1024_bw32_1_clock),
    .io_in_addr(simple_RAM_depth1024_bw32_1_io_in_addr),
    .io_in_data(simple_RAM_depth1024_bw32_1_io_in_data),
    .io_in_en(simple_RAM_depth1024_bw32_1_io_in_en),
    .io_in_we(simple_RAM_depth1024_bw32_1_io_in_we),
    .io_out_data(simple_RAM_depth1024_bw32_1_io_out_data)
  );
  assign io_out_data_0_Re = simple_RAM_depth1024_bw32_io_out_data; // @[PaddingDesigns.scala 78:25]
  assign io_out_data_0_Im = simple_RAM_depth1024_bw32_1_io_out_data; // @[PaddingDesigns.scala 79:25]
  assign simple_RAM_depth1024_bw32_clock = clock;
  assign simple_RAM_depth1024_bw32_io_in_addr = io_in_ready ? _GEN_7 : 10'h0; // @[PaddingDesigns.scala 84:22 74:29]
  assign simple_RAM_depth1024_bw32_io_in_data = io_in_ready ? _GEN_4 : 32'h0; // @[PaddingDesigns.scala 84:22 73:29]
  assign simple_RAM_depth1024_bw32_io_in_en = io_in_ready; // @[PaddingDesigns.scala 75:27]
  assign simple_RAM_depth1024_bw32_io_in_we = io_in_ready & _T; // @[PaddingDesigns.scala 84:22 76:27]
  assign simple_RAM_depth1024_bw32_1_clock = clock;
  assign simple_RAM_depth1024_bw32_1_io_in_addr = io_in_ready ? _GEN_7 : 10'h0; // @[PaddingDesigns.scala 84:22 74:29]
  assign simple_RAM_depth1024_bw32_1_io_in_data = io_in_ready ? _GEN_5 : 32'h0; // @[PaddingDesigns.scala 84:22 73:29]
  assign simple_RAM_depth1024_bw32_1_io_in_en = io_in_ready; // @[PaddingDesigns.scala 75:27]
  assign simple_RAM_depth1024_bw32_1_io_in_we = io_in_ready & _T; // @[PaddingDesigns.scala 84:22 76:27]
endmodule
module PencilGroup_12(
  input         clock,
  input         io_in_ready_0,
  input         io_in_ready_1,
  input         io_in_valid_0,
  input         io_in_valid_1,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input  [31:0] io_in_data_1_Re,
  input  [31:0] io_in_data_1_Im,
  input         io_in_mems_0_write,
  input         io_in_mems_0_read,
  input  [9:0]  io_in_mems_0_waddr,
  input  [9:0]  io_in_mems_0_raddr,
  input         io_in_mems_1_write,
  input         io_in_mems_1_read,
  input  [9:0]  io_in_mems_1_waddr,
  input  [9:0]  io_in_mems_1_raddr,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
  wire  pgroup_0_clock; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_0_io_in_ready; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_0_io_in_valid; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_0_io_in_data_0_Re; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_0_io_in_data_0_Im; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_0_io_in_mem_write; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_0_io_in_mem_read; // @[PaddingDesigns.scala 126:40]
  wire [9:0] pgroup_0_io_in_mem_waddr; // @[PaddingDesigns.scala 126:40]
  wire [9:0] pgroup_0_io_in_mem_raddr; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_0_io_out_data_0_Re; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_0_io_out_data_0_Im; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_clock; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_io_in_ready; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_io_in_valid; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_1_io_in_data_0_Re; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_1_io_in_data_0_Im; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_io_in_mem_write; // @[PaddingDesigns.scala 126:40]
  wire  pgroup_1_io_in_mem_read; // @[PaddingDesigns.scala 126:40]
  wire [9:0] pgroup_1_io_in_mem_waddr; // @[PaddingDesigns.scala 126:40]
  wire [9:0] pgroup_1_io_in_mem_raddr; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 126:40]
  wire [31:0] pgroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 126:40]
  SyncMEM_24 pgroup_0 ( // @[PaddingDesigns.scala 126:40]
    .clock(pgroup_0_clock),
    .io_in_ready(pgroup_0_io_in_ready),
    .io_in_valid(pgroup_0_io_in_valid),
    .io_in_data_0_Re(pgroup_0_io_in_data_0_Re),
    .io_in_data_0_Im(pgroup_0_io_in_data_0_Im),
    .io_in_mem_write(pgroup_0_io_in_mem_write),
    .io_in_mem_read(pgroup_0_io_in_mem_read),
    .io_in_mem_waddr(pgroup_0_io_in_mem_waddr),
    .io_in_mem_raddr(pgroup_0_io_in_mem_raddr),
    .io_out_data_0_Re(pgroup_0_io_out_data_0_Re),
    .io_out_data_0_Im(pgroup_0_io_out_data_0_Im)
  );
  SyncMEM_24 pgroup_1 ( // @[PaddingDesigns.scala 126:40]
    .clock(pgroup_1_clock),
    .io_in_ready(pgroup_1_io_in_ready),
    .io_in_valid(pgroup_1_io_in_valid),
    .io_in_data_0_Re(pgroup_1_io_in_data_0_Re),
    .io_in_data_0_Im(pgroup_1_io_in_data_0_Im),
    .io_in_mem_write(pgroup_1_io_in_mem_write),
    .io_in_mem_read(pgroup_1_io_in_mem_read),
    .io_in_mem_waddr(pgroup_1_io_in_mem_waddr),
    .io_in_mem_raddr(pgroup_1_io_in_mem_raddr),
    .io_out_data_0_Re(pgroup_1_io_out_data_0_Re),
    .io_out_data_0_Im(pgroup_1_io_out_data_0_Im)
  );
  assign io_out_data_0_Re = pgroup_0_io_out_data_0_Re; // @[PaddingDesigns.scala 137:22]
  assign io_out_data_0_Im = pgroup_0_io_out_data_0_Im; // @[PaddingDesigns.scala 137:22]
  assign io_out_data_1_Re = pgroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 137:22]
  assign io_out_data_1_Im = pgroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 137:22]
  assign pgroup_0_clock = clock;
  assign pgroup_0_io_in_ready = io_in_ready_0; // @[PaddingDesigns.scala 131:29]
  assign pgroup_0_io_in_valid = io_in_valid_0; // @[PaddingDesigns.scala 129:29]
  assign pgroup_0_io_in_data_0_Re = io_in_data_0_Re; // @[PaddingDesigns.scala 132:33]
  assign pgroup_0_io_in_data_0_Im = io_in_data_0_Im; // @[PaddingDesigns.scala 132:33]
  assign pgroup_0_io_in_mem_write = io_in_mems_0_write; // @[PaddingDesigns.scala 134:33]
  assign pgroup_0_io_in_mem_read = io_in_mems_0_read; // @[PaddingDesigns.scala 133:32]
  assign pgroup_0_io_in_mem_waddr = io_in_mems_0_waddr; // @[PaddingDesigns.scala 136:33]
  assign pgroup_0_io_in_mem_raddr = io_in_mems_0_raddr; // @[PaddingDesigns.scala 135:33]
  assign pgroup_1_clock = clock;
  assign pgroup_1_io_in_ready = io_in_ready_1; // @[PaddingDesigns.scala 131:29]
  assign pgroup_1_io_in_valid = io_in_valid_1; // @[PaddingDesigns.scala 129:29]
  assign pgroup_1_io_in_data_0_Re = io_in_data_1_Re; // @[PaddingDesigns.scala 132:33]
  assign pgroup_1_io_in_data_0_Im = io_in_data_1_Im; // @[PaddingDesigns.scala 132:33]
  assign pgroup_1_io_in_mem_write = io_in_mems_1_write; // @[PaddingDesigns.scala 134:33]
  assign pgroup_1_io_in_mem_read = io_in_mems_1_read; // @[PaddingDesigns.scala 133:32]
  assign pgroup_1_io_in_mem_waddr = io_in_mems_1_waddr; // @[PaddingDesigns.scala 136:33]
  assign pgroup_1_io_in_mem_raddr = io_in_mems_1_raddr; // @[PaddingDesigns.scala 135:33]
endmodule
module SlabGroup_6(
  input         clock,
  input         io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input  [31:0] io_in_data_1_Re,
  input  [31:0] io_in_data_1_Im,
  input         io_in_write,
  input  [1:0]  io_in_pgroup_slct_0,
  input  [1:0]  io_in_pgroup_slct_1,
  input  [1:0]  io_in_RAM_slct_0,
  input  [1:0]  io_in_RAM_slct_1,
  input  [9:0]  io_in_addr_slct_0,
  input  [9:0]  io_in_addr_slct_1,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  PencilGroup_clock; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_ready_0; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_ready_1; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_valid_0; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_valid_1; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_in_data_0_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_in_data_0_Im; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_in_data_1_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_in_data_1_Im; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_mems_0_write; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_mems_0_read; // @[PaddingDesigns.scala 154:53]
  wire [9:0] PencilGroup_io_in_mems_0_waddr; // @[PaddingDesigns.scala 154:53]
  wire [9:0] PencilGroup_io_in_mems_0_raddr; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_mems_1_write; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_io_in_mems_1_read; // @[PaddingDesigns.scala 154:53]
  wire [9:0] PencilGroup_io_in_mems_1_waddr; // @[PaddingDesigns.scala 154:53]
  wire [9:0] PencilGroup_io_in_mems_1_raddr; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_clock; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_ready_0; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_ready_1; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_valid_0; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_valid_1; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_in_data_0_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_in_data_0_Im; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_in_data_1_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_in_data_1_Im; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_mems_0_write; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_mems_0_read; // @[PaddingDesigns.scala 154:53]
  wire [9:0] PencilGroup_1_io_in_mems_0_waddr; // @[PaddingDesigns.scala 154:53]
  wire [9:0] PencilGroup_1_io_in_mems_0_raddr; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_mems_1_write; // @[PaddingDesigns.scala 154:53]
  wire  PencilGroup_1_io_in_mems_1_read; // @[PaddingDesigns.scala 154:53]
  wire [9:0] PencilGroup_1_io_in_mems_1_waddr; // @[PaddingDesigns.scala 154:53]
  wire [9:0] PencilGroup_1_io_in_mems_1_raddr; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 154:53]
  wire [31:0] PencilGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 154:53]
  wire  _io_out_last_T = ~io_in_write; // @[PaddingDesigns.scala 166:79]
  wire  _io_out_last_T_1 = io_in_ready & ~io_in_write; // @[PaddingDesigns.scala 166:77]
  wire  _GEN_146 = ~io_in_pgroup_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_147 = ~io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_148 = ~io_in_pgroup_slct_0[0] & ~io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_12 = ~io_in_pgroup_slct_0[0] & ~io_in_RAM_slct_0[0] & io_in_write; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_150 = ~io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_13 = ~io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] & io_in_write; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_152 = io_in_pgroup_slct_0[0] & ~io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_14 = io_in_pgroup_slct_0[0] & ~io_in_RAM_slct_0[0] & io_in_write; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_153 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0]; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_15 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] & io_in_write; // @[PaddingDesigns.scala 160:36 171:{72,72}]
  wire  _GEN_16 = _GEN_148 & _io_out_last_T; // @[PaddingDesigns.scala 161:35 172:{71,71}]
  wire  _GEN_17 = _GEN_150 & _io_out_last_T; // @[PaddingDesigns.scala 161:35 172:{71,71}]
  wire  _GEN_18 = _GEN_152 & _io_out_last_T; // @[PaddingDesigns.scala 161:35 172:{71,71}]
  wire  _GEN_19 = _GEN_153 & _io_out_last_T; // @[PaddingDesigns.scala 161:35 172:{71,71}]
  wire [9:0] _GEN_20 = _GEN_146 & _GEN_147 ? io_in_addr_slct_0 : 10'h0; // @[PaddingDesigns.scala 163:36 173:{72,72}]
  wire [9:0] _GEN_21 = _GEN_146 & io_in_RAM_slct_0[0] ? io_in_addr_slct_0 : 10'h0; // @[PaddingDesigns.scala 163:36 173:{72,72}]
  wire [9:0] _GEN_22 = io_in_pgroup_slct_0[0] & _GEN_147 ? io_in_addr_slct_0 : 10'h0; // @[PaddingDesigns.scala 163:36 173:{72,72}]
  wire [9:0] _GEN_23 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] ? io_in_addr_slct_0 : 10'h0; // @[PaddingDesigns.scala 163:36 173:{72,72}]
  wire  _GEN_28 = _GEN_148 & io_in_valid; // @[PaddingDesigns.scala 156:28 175:{67,67}]
  wire  _GEN_29 = _GEN_150 & io_in_valid; // @[PaddingDesigns.scala 156:28 175:{67,67}]
  wire  _GEN_30 = _GEN_152 & io_in_valid; // @[PaddingDesigns.scala 156:28 175:{67,67}]
  wire  _GEN_31 = _GEN_153 & io_in_valid; // @[PaddingDesigns.scala 156:28 175:{67,67}]
  wire  _GEN_32 = _GEN_148 & io_in_ready; // @[PaddingDesigns.scala 158:28 176:{67,67}]
  wire  _GEN_33 = _GEN_150 & io_in_ready; // @[PaddingDesigns.scala 158:28 176:{67,67}]
  wire  _GEN_34 = _GEN_152 & io_in_ready; // @[PaddingDesigns.scala 158:28 176:{67,67}]
  wire  _GEN_35 = _GEN_153 & io_in_ready; // @[PaddingDesigns.scala 158:28 176:{67,67}]
  wire [31:0] _GEN_40 = _GEN_146 & _GEN_147 ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_41 = _GEN_146 & io_in_RAM_slct_0[0] ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_42 = io_in_pgroup_slct_0[0] & _GEN_147 ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_43 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_44 = _GEN_146 & _GEN_147 ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_45 = _GEN_146 & io_in_RAM_slct_0[0] ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_46 = io_in_pgroup_slct_0[0] & _GEN_147 ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  wire [31:0] _GEN_47 = io_in_pgroup_slct_0[0] & io_in_RAM_slct_0[0] ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 159:30 178:{66,66}]
  reg [1:0] io_out_data_0_r; // @[Reg.scala 16:16]
  reg [1:0] io_out_data_0_r_1; // @[Reg.scala 16:16]
  wire [31:0] pgroups_0_out_data_0_Im = PencilGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] pgroups_0_out_data_1_Im = PencilGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_51 = ~io_out_data_0_r[0] & io_out_data_0_r_1[0] ? pgroups_0_out_data_1_Im : pgroups_0_out_data_0_Im; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_1_out_data_0_Im = PencilGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_52 = io_out_data_0_r[0] & ~io_out_data_0_r_1[0] ? pgroups_1_out_data_0_Im : _GEN_51; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_1_out_data_1_Im = PencilGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_53 = io_out_data_0_r[0] & io_out_data_0_r_1[0] ? pgroups_1_out_data_1_Im : _GEN_52; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_0_out_data_0_Re = PencilGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] pgroups_0_out_data_1_Re = PencilGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_55 = ~io_out_data_0_r[0] & io_out_data_0_r_1[0] ? pgroups_0_out_data_1_Re : pgroups_0_out_data_0_Re; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_1_out_data_0_Re = PencilGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_56 = io_out_data_0_r[0] & ~io_out_data_0_r_1[0] ? pgroups_1_out_data_0_Re : _GEN_55; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] pgroups_1_out_data_1_Re = PencilGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 154:{46,46}]
  wire [31:0] _GEN_57 = io_out_data_0_r[0] & io_out_data_0_r_1[0] ? pgroups_1_out_data_1_Re : _GEN_56; // @[PaddingDesigns.scala 179:{24,24}]
  wire  _GEN_198 = ~io_in_pgroup_slct_1[0]; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_199 = ~io_in_RAM_slct_1[0]; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_58 = ~io_in_pgroup_slct_1[0] & ~io_in_RAM_slct_1[0] ? io_in_write : _GEN_12; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_59 = ~io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_write : _GEN_13; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_60 = io_in_pgroup_slct_1[0] & ~io_in_RAM_slct_1[0] ? io_in_write : _GEN_14; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_61 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_write : _GEN_15; // @[PaddingDesigns.scala 171:{72,72}]
  wire  _GEN_62 = _GEN_198 & _GEN_199 ? _io_out_last_T : _GEN_16; // @[PaddingDesigns.scala 172:{71,71}]
  wire  _GEN_63 = _GEN_198 & io_in_RAM_slct_1[0] ? _io_out_last_T : _GEN_17; // @[PaddingDesigns.scala 172:{71,71}]
  wire  _GEN_64 = io_in_pgroup_slct_1[0] & _GEN_199 ? _io_out_last_T : _GEN_18; // @[PaddingDesigns.scala 172:{71,71}]
  wire  _GEN_65 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? _io_out_last_T : _GEN_19; // @[PaddingDesigns.scala 172:{71,71}]
  wire [9:0] _GEN_66 = _GEN_198 & _GEN_199 ? io_in_addr_slct_1 : _GEN_20; // @[PaddingDesigns.scala 173:{72,72}]
  wire [9:0] _GEN_67 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_addr_slct_1 : _GEN_21; // @[PaddingDesigns.scala 173:{72,72}]
  wire [9:0] _GEN_68 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_addr_slct_1 : _GEN_22; // @[PaddingDesigns.scala 173:{72,72}]
  wire [9:0] _GEN_69 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_addr_slct_1 : _GEN_23; // @[PaddingDesigns.scala 173:{72,72}]
  wire  _GEN_74 = _GEN_198 & _GEN_199 ? io_in_valid : _GEN_28; // @[PaddingDesigns.scala 175:{67,67}]
  wire  _GEN_75 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_valid : _GEN_29; // @[PaddingDesigns.scala 175:{67,67}]
  wire  _GEN_76 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_valid : _GEN_30; // @[PaddingDesigns.scala 175:{67,67}]
  wire  _GEN_77 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_valid : _GEN_31; // @[PaddingDesigns.scala 175:{67,67}]
  wire  _GEN_78 = _GEN_198 & _GEN_199 ? io_in_ready : _GEN_32; // @[PaddingDesigns.scala 176:{67,67}]
  wire  _GEN_79 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_ready : _GEN_33; // @[PaddingDesigns.scala 176:{67,67}]
  wire  _GEN_80 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_ready : _GEN_34; // @[PaddingDesigns.scala 176:{67,67}]
  wire  _GEN_81 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_ready : _GEN_35; // @[PaddingDesigns.scala 176:{67,67}]
  wire [31:0] _GEN_86 = _GEN_198 & _GEN_199 ? io_in_data_1_Im : _GEN_40; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_87 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_data_1_Im : _GEN_41; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_88 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_data_1_Im : _GEN_42; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_89 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_data_1_Im : _GEN_43; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_90 = _GEN_198 & _GEN_199 ? io_in_data_1_Re : _GEN_44; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_91 = _GEN_198 & io_in_RAM_slct_1[0] ? io_in_data_1_Re : _GEN_45; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_92 = io_in_pgroup_slct_1[0] & _GEN_199 ? io_in_data_1_Re : _GEN_46; // @[PaddingDesigns.scala 178:{66,66}]
  wire [31:0] _GEN_93 = io_in_pgroup_slct_1[0] & io_in_RAM_slct_1[0] ? io_in_data_1_Re : _GEN_47; // @[PaddingDesigns.scala 178:{66,66}]
  reg [1:0] io_out_data_1_r; // @[Reg.scala 16:16]
  reg [1:0] io_out_data_1_r_1; // @[Reg.scala 16:16]
  wire [31:0] _GEN_97 = ~io_out_data_1_r[0] & io_out_data_1_r_1[0] ? pgroups_0_out_data_1_Im : pgroups_0_out_data_0_Im; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_98 = io_out_data_1_r[0] & ~io_out_data_1_r_1[0] ? pgroups_1_out_data_0_Im : _GEN_97; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_99 = io_out_data_1_r[0] & io_out_data_1_r_1[0] ? pgroups_1_out_data_1_Im : _GEN_98; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_101 = ~io_out_data_1_r[0] & io_out_data_1_r_1[0] ? pgroups_0_out_data_1_Re : pgroups_0_out_data_0_Re; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_102 = io_out_data_1_r[0] & ~io_out_data_1_r_1[0] ? pgroups_1_out_data_0_Re : _GEN_101; // @[PaddingDesigns.scala 179:{24,24}]
  wire [31:0] _GEN_103 = io_out_data_1_r[0] & io_out_data_1_r_1[0] ? pgroups_1_out_data_1_Re : _GEN_102; // @[PaddingDesigns.scala 179:{24,24}]
  PencilGroup_12 PencilGroup ( // @[PaddingDesigns.scala 154:53]
    .clock(PencilGroup_clock),
    .io_in_ready_0(PencilGroup_io_in_ready_0),
    .io_in_ready_1(PencilGroup_io_in_ready_1),
    .io_in_valid_0(PencilGroup_io_in_valid_0),
    .io_in_valid_1(PencilGroup_io_in_valid_1),
    .io_in_data_0_Re(PencilGroup_io_in_data_0_Re),
    .io_in_data_0_Im(PencilGroup_io_in_data_0_Im),
    .io_in_data_1_Re(PencilGroup_io_in_data_1_Re),
    .io_in_data_1_Im(PencilGroup_io_in_data_1_Im),
    .io_in_mems_0_write(PencilGroup_io_in_mems_0_write),
    .io_in_mems_0_read(PencilGroup_io_in_mems_0_read),
    .io_in_mems_0_waddr(PencilGroup_io_in_mems_0_waddr),
    .io_in_mems_0_raddr(PencilGroup_io_in_mems_0_raddr),
    .io_in_mems_1_write(PencilGroup_io_in_mems_1_write),
    .io_in_mems_1_read(PencilGroup_io_in_mems_1_read),
    .io_in_mems_1_waddr(PencilGroup_io_in_mems_1_waddr),
    .io_in_mems_1_raddr(PencilGroup_io_in_mems_1_raddr),
    .io_out_data_0_Re(PencilGroup_io_out_data_0_Re),
    .io_out_data_0_Im(PencilGroup_io_out_data_0_Im),
    .io_out_data_1_Re(PencilGroup_io_out_data_1_Re),
    .io_out_data_1_Im(PencilGroup_io_out_data_1_Im)
  );
  PencilGroup_12 PencilGroup_1 ( // @[PaddingDesigns.scala 154:53]
    .clock(PencilGroup_1_clock),
    .io_in_ready_0(PencilGroup_1_io_in_ready_0),
    .io_in_ready_1(PencilGroup_1_io_in_ready_1),
    .io_in_valid_0(PencilGroup_1_io_in_valid_0),
    .io_in_valid_1(PencilGroup_1_io_in_valid_1),
    .io_in_data_0_Re(PencilGroup_1_io_in_data_0_Re),
    .io_in_data_0_Im(PencilGroup_1_io_in_data_0_Im),
    .io_in_data_1_Re(PencilGroup_1_io_in_data_1_Re),
    .io_in_data_1_Im(PencilGroup_1_io_in_data_1_Im),
    .io_in_mems_0_write(PencilGroup_1_io_in_mems_0_write),
    .io_in_mems_0_read(PencilGroup_1_io_in_mems_0_read),
    .io_in_mems_0_waddr(PencilGroup_1_io_in_mems_0_waddr),
    .io_in_mems_0_raddr(PencilGroup_1_io_in_mems_0_raddr),
    .io_in_mems_1_write(PencilGroup_1_io_in_mems_1_write),
    .io_in_mems_1_read(PencilGroup_1_io_in_mems_1_read),
    .io_in_mems_1_waddr(PencilGroup_1_io_in_mems_1_waddr),
    .io_in_mems_1_raddr(PencilGroup_1_io_in_mems_1_raddr),
    .io_out_data_0_Re(PencilGroup_1_io_out_data_0_Re),
    .io_out_data_0_Im(PencilGroup_1_io_out_data_0_Im),
    .io_out_data_1_Re(PencilGroup_1_io_out_data_1_Re),
    .io_out_data_1_Im(PencilGroup_1_io_out_data_1_Im)
  );
  assign io_out_data_0_Re = io_in_ready ? _GEN_57 : 32'h0; // @[PaddingDesigns.scala 169:22 179:24 168:27]
  assign io_out_data_0_Im = io_in_ready ? _GEN_53 : 32'h0; // @[PaddingDesigns.scala 169:22 179:24 168:27]
  assign io_out_data_1_Re = io_in_ready ? _GEN_103 : 32'h0; // @[PaddingDesigns.scala 169:22 179:24 168:27]
  assign io_out_data_1_Im = io_in_ready ? _GEN_99 : 32'h0; // @[PaddingDesigns.scala 169:22 179:24 168:27]
  assign PencilGroup_clock = clock;
  assign PencilGroup_io_in_ready_0 = io_in_ready & _GEN_78; // @[PaddingDesigns.scala 169:22 158:28]
  assign PencilGroup_io_in_ready_1 = io_in_ready & _GEN_79; // @[PaddingDesigns.scala 169:22 158:28]
  assign PencilGroup_io_in_valid_0 = io_in_ready & _GEN_74; // @[PaddingDesigns.scala 169:22 156:28]
  assign PencilGroup_io_in_valid_1 = io_in_ready & _GEN_75; // @[PaddingDesigns.scala 169:22 156:28]
  assign PencilGroup_io_in_data_0_Re = io_in_ready ? _GEN_90 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_io_in_data_0_Im = io_in_ready ? _GEN_86 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_io_in_data_1_Re = io_in_ready ? _GEN_91 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_io_in_data_1_Im = io_in_ready ? _GEN_87 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_io_in_mems_0_write = io_in_ready & _GEN_58; // @[PaddingDesigns.scala 169:22 160:36]
  assign PencilGroup_io_in_mems_0_read = io_in_ready & _GEN_62; // @[PaddingDesigns.scala 169:22 161:35]
  assign PencilGroup_io_in_mems_0_waddr = io_in_ready ? _GEN_66 : 10'h0; // @[PaddingDesigns.scala 169:22 163:36]
  assign PencilGroup_io_in_mems_0_raddr = io_in_ready ? _GEN_66 : 10'h0; // @[PaddingDesigns.scala 169:22 162:36]
  assign PencilGroup_io_in_mems_1_write = io_in_ready & _GEN_59; // @[PaddingDesigns.scala 169:22 160:36]
  assign PencilGroup_io_in_mems_1_read = io_in_ready & _GEN_63; // @[PaddingDesigns.scala 169:22 161:35]
  assign PencilGroup_io_in_mems_1_waddr = io_in_ready ? _GEN_67 : 10'h0; // @[PaddingDesigns.scala 169:22 163:36]
  assign PencilGroup_io_in_mems_1_raddr = io_in_ready ? _GEN_67 : 10'h0; // @[PaddingDesigns.scala 169:22 162:36]
  assign PencilGroup_1_clock = clock;
  assign PencilGroup_1_io_in_ready_0 = io_in_ready & _GEN_80; // @[PaddingDesigns.scala 169:22 158:28]
  assign PencilGroup_1_io_in_ready_1 = io_in_ready & _GEN_81; // @[PaddingDesigns.scala 169:22 158:28]
  assign PencilGroup_1_io_in_valid_0 = io_in_ready & _GEN_76; // @[PaddingDesigns.scala 169:22 156:28]
  assign PencilGroup_1_io_in_valid_1 = io_in_ready & _GEN_77; // @[PaddingDesigns.scala 169:22 156:28]
  assign PencilGroup_1_io_in_data_0_Re = io_in_ready ? _GEN_92 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_1_io_in_data_0_Im = io_in_ready ? _GEN_88 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_1_io_in_data_1_Re = io_in_ready ? _GEN_93 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_1_io_in_data_1_Im = io_in_ready ? _GEN_89 : 32'h0; // @[PaddingDesigns.scala 169:22 159:30]
  assign PencilGroup_1_io_in_mems_0_write = io_in_ready & _GEN_60; // @[PaddingDesigns.scala 169:22 160:36]
  assign PencilGroup_1_io_in_mems_0_read = io_in_ready & _GEN_64; // @[PaddingDesigns.scala 169:22 161:35]
  assign PencilGroup_1_io_in_mems_0_waddr = io_in_ready ? _GEN_68 : 10'h0; // @[PaddingDesigns.scala 169:22 163:36]
  assign PencilGroup_1_io_in_mems_0_raddr = io_in_ready ? _GEN_68 : 10'h0; // @[PaddingDesigns.scala 169:22 162:36]
  assign PencilGroup_1_io_in_mems_1_write = io_in_ready & _GEN_61; // @[PaddingDesigns.scala 169:22 160:36]
  assign PencilGroup_1_io_in_mems_1_read = io_in_ready & _GEN_65; // @[PaddingDesigns.scala 169:22 161:35]
  assign PencilGroup_1_io_in_mems_1_waddr = io_in_ready ? _GEN_69 : 10'h0; // @[PaddingDesigns.scala 169:22 163:36]
  assign PencilGroup_1_io_in_mems_1_raddr = io_in_ready ? _GEN_69 : 10'h0; // @[PaddingDesigns.scala 169:22 162:36]
  always @(posedge clock) begin
    if (_io_out_last_T_1) begin // @[Reg.scala 17:18]
      io_out_data_0_r <= io_in_pgroup_slct_0; // @[Reg.scala 17:22]
    end
    if (_io_out_last_T_1) begin // @[Reg.scala 17:18]
      io_out_data_0_r_1 <= io_in_RAM_slct_0; // @[Reg.scala 17:22]
    end
    if (_io_out_last_T_1) begin // @[Reg.scala 17:18]
      io_out_data_1_r <= io_in_pgroup_slct_1; // @[Reg.scala 17:22]
    end
    if (_io_out_last_T_1) begin // @[Reg.scala 17:18]
      io_out_data_1_r_1 <= io_in_RAM_slct_1; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_out_data_0_r = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  io_out_data_0_r_1 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  io_out_data_1_r = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  io_out_data_1_r_1 = _RAND_3[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SimpleTrnsp_batched_3(
  input         clock,
  input         reset,
  input         io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_data_0_Re,
  input  [31:0] io_in_data_0_Im,
  input  [31:0] io_in_data_1_Re,
  input  [31:0] io_in_data_1_Im,
  output        io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_data_0_Re,
  output [31:0] io_out_data_0_Im,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
`endif // RANDOMIZE_REG_INIT
  wire  SlabGroup_clock; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_io_in_ready; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_io_in_valid; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_in_data_1_Im; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_io_in_write; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_pgroup_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_pgroup_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_RAM_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_io_in_RAM_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [9:0] SlabGroup_io_in_addr_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [9:0] SlabGroup_io_in_addr_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_clock; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_io_in_ready; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_io_in_valid; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_in_data_1_Im; // @[PaddingDesigns.scala 463:39]
  wire  SlabGroup_1_io_in_write; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_pgroup_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_pgroup_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_RAM_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [1:0] SlabGroup_1_io_in_RAM_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [9:0] SlabGroup_1_io_in_addr_slct_0; // @[PaddingDesigns.scala 463:39]
  wire [9:0] SlabGroup_1_io_in_addr_slct_1; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 463:39]
  wire [31:0] SlabGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 463:39]
  reg [7:0] value; // @[Counter.scala 62:40]
  reg [7:0] value_1; // @[Counter.scala 62:40]
  reg  reg_read_out; // @[PaddingDesigns.scala 450:31]
  reg [1:0] value_2; // @[Counter.scala 62:40]
  reg [2:0] value_3; // @[Counter.scala 62:40]
  reg [2:0] value_4; // @[Counter.scala 62:40]
  reg [10:0] reg_in_batch_offst; // @[PaddingDesigns.scala 454:37]
  reg [10:0] reg_out_batch_offst; // @[PaddingDesigns.scala 455:38]
  reg [10:0] reg_out_addr_offst; // @[PaddingDesigns.scala 456:37]
  reg [4:0] value_5; // @[Counter.scala 62:40]
  reg  value_6; // @[Counter.scala 62:40]
  reg [10:0] reg_in_addr_offst; // @[PaddingDesigns.scala 459:36]
  reg [4:0] value_7; // @[Counter.scala 62:40]
  reg  value_8; // @[Counter.scala 62:40]
  reg  WR_mode; // @[PaddingDesigns.scala 462:26]
  wire  _io_out_last_T = ~WR_mode; // @[PaddingDesigns.scala 475:40]
  wire  _io_out_valid_T_1 = reg_read_out & value_2 == 2'h0; // @[PaddingDesigns.scala 477:48]
  reg  io_out_valid_r; // @[Reg.scala 16:16]
  reg  r; // @[Reg.scala 16:16]
  wire [31:0] slabs_0_out_data_0_Im = SlabGroup_io_out_data_0_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_0_Im = SlabGroup_1_io_out_data_0_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_0_out_data_0_Re = SlabGroup_io_out_data_0_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_0_Re = SlabGroup_1_io_out_data_0_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_0_out_data_1_Im = SlabGroup_io_out_data_1_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_1_Im = SlabGroup_1_io_out_data_1_Im; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_0_out_data_1_Re = SlabGroup_io_out_data_1_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire [31:0] slabs_1_out_data_1_Re = SlabGroup_1_io_out_data_1_Re; // @[PaddingDesigns.scala 463:{32,32}]
  wire  _GEN_15 = _io_out_last_T & io_in_ready; // @[PaddingDesigns.scala 466:18 483:{38,38}]
  wire  _GEN_16 = WR_mode & io_in_ready; // @[PaddingDesigns.scala 466:18 483:{38,38}]
  wire  _GEN_19 = _io_out_last_T & io_in_valid; // @[PaddingDesigns.scala 467:18 485:{38,38}]
  wire  _GEN_20 = WR_mode & io_in_valid; // @[PaddingDesigns.scala 467:18 485:{38,38}]
  wire [31:0] _GEN_21 = ~WR_mode ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_22 = WR_mode ? io_in_data_0_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_23 = ~WR_mode ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_24 = WR_mode ? io_in_data_0_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_25 = ~WR_mode ? io_in_data_1_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_26 = WR_mode ? io_in_data_1_Im : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_27 = ~WR_mode ? io_in_data_1_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [31:0] _GEN_28 = WR_mode ? io_in_data_1_Re : 32'h0; // @[PaddingDesigns.scala 469:26 486:{37,37}]
  wire [1:0] _slabs_WR_mode_in_pgroup_slct_0 = {{1'd0}, value_8}; // @[PaddingDesigns.scala 487:{54,54}]
  wire [1:0] _GEN_29 = ~WR_mode ? _slabs_WR_mode_in_pgroup_slct_0 : 2'h0; // @[PaddingDesigns.scala 471:33 487:{54,54}]
  wire [1:0] _GEN_30 = WR_mode ? _slabs_WR_mode_in_pgroup_slct_0 : 2'h0; // @[PaddingDesigns.scala 471:33 487:{54,54}]
  wire [1:0] _GEN_35 = ~WR_mode ? 2'h1 : 2'h0; // @[PaddingDesigns.scala 472:30 488:{41,41}]
  wire [1:0] _GEN_36 = WR_mode ? 2'h1 : 2'h0; // @[PaddingDesigns.scala 472:30 488:{41,41}]
  wire [10:0] _GEN_161 = {{6'd0}, value_7}; // @[PaddingDesigns.scala 489:73]
  wire [10:0] _slabs_in_addr_slct_0_T_1 = reg_in_addr_offst + _GEN_161; // @[PaddingDesigns.scala 489:73]
  wire [10:0] _slabs_in_addr_slct_0_T_3 = _slabs_in_addr_slct_0_T_1 + reg_in_batch_offst; // @[PaddingDesigns.scala 489:93]
  wire [9:0] _GEN_37 = ~WR_mode ? _slabs_in_addr_slct_0_T_3[9:0] : 10'h0; // @[PaddingDesigns.scala 473:31 489:{52,52}]
  wire [9:0] _GEN_38 = WR_mode ? _slabs_in_addr_slct_0_T_3[9:0] : 10'h0; // @[PaddingDesigns.scala 473:31 489:{52,52}]
  wire  wrap = value_3 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_1 = value_3 + 3'h1; // @[Counter.scala 78:24]
  wire  _T_3 = value_1 == 8'hff; // @[PaddingDesigns.scala 494:27]
  wire [7:0] _value_T_3 = value_1 + 8'h1; // @[Counter.scala 78:24]
  wire  wrap_2 = value_7 == 5'h1f; // @[Counter.scala 74:24]
  wire [4:0] _value_T_5 = value_7 + 5'h1; // @[Counter.scala 78:24]
  wire [10:0] _reg_in_addr_offst_T_1 = reg_in_addr_offst + 11'h20; // @[PaddingDesigns.scala 507:54]
  wire [10:0] _GEN_41 = value_8 ? _reg_in_addr_offst_T_1 : reg_in_addr_offst; // @[PaddingDesigns.scala 506:54 507:33 459:36]
  wire  _GEN_42 = wrap_2 ? value_8 + 1'h1 : value_8; // @[PaddingDesigns.scala 504:67 Counter.scala 78:15 62:40]
  wire [10:0] _GEN_43 = wrap_2 ? _GEN_41 : reg_in_addr_offst; // @[PaddingDesigns.scala 459:36 504:67]
  wire  _GEN_46 = value_1 == 8'hff | reg_read_out; // @[PaddingDesigns.scala 494:76 497:24 450:31]
  wire [10:0] _reg_in_batch_offst_T_1 = reg_in_batch_offst + 11'h80; // @[PaddingDesigns.scala 512:50]
  wire  _GEN_53 = wrap ? _GEN_46 : reg_read_out; // @[PaddingDesigns.scala 450:31 492:52]
  wire  _GEN_57 = io_in_ready & io_in_valid & _io_out_last_T; // @[PaddingDesigns.scala 470:18 481:36]
  wire  _GEN_58 = io_in_ready & io_in_valid & WR_mode; // @[PaddingDesigns.scala 470:18 481:36]
  wire  _GEN_59 = io_in_ready & io_in_valid & _GEN_15; // @[PaddingDesigns.scala 466:18 481:36]
  wire  _GEN_60 = io_in_ready & io_in_valid & _GEN_16; // @[PaddingDesigns.scala 466:18 481:36]
  wire [1:0] _GEN_73 = io_in_ready & io_in_valid ? _GEN_29 : 2'h0; // @[PaddingDesigns.scala 471:33 481:36]
  wire [1:0] _GEN_74 = io_in_ready & io_in_valid ? _GEN_30 : 2'h0; // @[PaddingDesigns.scala 471:33 481:36]
  wire [1:0] _GEN_79 = io_in_ready & io_in_valid ? _GEN_35 : 2'h0; // @[PaddingDesigns.scala 472:30 481:36]
  wire [1:0] _GEN_80 = io_in_ready & io_in_valid ? _GEN_36 : 2'h0; // @[PaddingDesigns.scala 472:30 481:36]
  wire [9:0] _GEN_81 = io_in_ready & io_in_valid ? _GEN_37 : 10'h0; // @[PaddingDesigns.scala 473:31 481:36]
  wire [9:0] _GEN_82 = io_in_ready & io_in_valid ? _GEN_38 : 10'h0; // @[PaddingDesigns.scala 473:31 481:36]
  wire  _GEN_89 = io_in_ready & io_in_valid ? _GEN_53 : reg_read_out; // @[PaddingDesigns.scala 450:31 481:36]
  wire  _GEN_93 = ~_io_out_last_T ? 1'h0 : _GEN_57; // @[PaddingDesigns.scala 520:{39,39}]
  wire  _GEN_94 = _io_out_last_T ? 1'h0 : _GEN_58; // @[PaddingDesigns.scala 520:{39,39}]
  wire  _GEN_95 = ~_io_out_last_T ? io_in_ready : _GEN_59; // @[PaddingDesigns.scala 521:{39,39}]
  wire  _GEN_96 = _io_out_last_T ? io_in_ready : _GEN_60; // @[PaddingDesigns.scala 521:{39,39}]
  wire [1:0] _GEN_97 = ~_io_out_last_T ? 2'h0 : _GEN_73; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _GEN_98 = _io_out_last_T ? 2'h0 : _GEN_74; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _GEN_99 = ~_io_out_last_T ? 2'h1 : _GEN_73; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _GEN_100 = _io_out_last_T ? 2'h1 : _GEN_74; // @[PaddingDesigns.scala 522:{45,45}]
  wire [1:0] _slabs_T_10_in_RAM_slct_0 = {{1'd0}, value_6}; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_101 = ~_io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : 2'h0; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_102 = _io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : 2'h0; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_103 = ~_io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : _GEN_79; // @[PaddingDesigns.scala 523:{52,52}]
  wire [1:0] _GEN_104 = _io_out_last_T ? _slabs_T_10_in_RAM_slct_0 : _GEN_80; // @[PaddingDesigns.scala 523:{52,52}]
  wire [10:0] _GEN_163 = {{6'd0}, value_5}; // @[PaddingDesigns.scala 524:75]
  wire [10:0] _slabs_in_addr_slct_0_T_5 = reg_out_addr_offst + _GEN_163; // @[PaddingDesigns.scala 524:75]
  wire [10:0] _slabs_in_addr_slct_0_T_7 = _slabs_in_addr_slct_0_T_5 + reg_out_batch_offst; // @[PaddingDesigns.scala 524:96]
  wire [9:0] _GEN_105 = ~_io_out_last_T ? _slabs_in_addr_slct_0_T_7[9:0] : _GEN_81; // @[PaddingDesigns.scala 524:{53,53}]
  wire [9:0] _GEN_106 = _io_out_last_T ? _slabs_in_addr_slct_0_T_7[9:0] : _GEN_82; // @[PaddingDesigns.scala 524:{53,53}]
  wire  wrap_4 = value_2 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_9 = value_2 + 2'h1; // @[Counter.scala 78:24]
  wire  wrap_5 = value_4 == 3'h7; // @[Counter.scala 74:24]
  wire [2:0] _value_T_11 = value_4 + 3'h1; // @[Counter.scala 78:24]
  wire  _T_16 = io_in_valid & _T_3; // @[PaddingDesigns.scala 533:30]
  wire [7:0] _value_T_13 = value + 8'h1; // @[Counter.scala 78:24]
  wire [4:0] _value_T_17 = value_5 + 5'h1; // @[Counter.scala 78:24]
  wire [4:0] _GEN_110 = value_6 ? _value_T_17 : value_5; // @[PaddingDesigns.scala 547:54 Counter.scala 78:15 62:40]
  wire [10:0] _reg_out_addr_offst_T_1 = reg_out_addr_offst + 11'h20; // @[PaddingDesigns.scala 551:56]
  wire [10:0] _GEN_111 = reg_out_addr_offst == 11'h60 ? 11'h0 : _reg_out_addr_offst_T_1; // @[PaddingDesigns.scala 544:95 545:34 551:34]
  wire  _GEN_112 = reg_out_addr_offst == 11'h60 ? value_6 + 1'h1 : value_6; // @[PaddingDesigns.scala 544:95 Counter.scala 78:15 62:40]
  wire [4:0] _GEN_113 = reg_out_addr_offst == 11'h60 ? _GEN_110 : value_5; // @[PaddingDesigns.scala 544:95 Counter.scala 62:40]
  wire [7:0] _GEN_114 = value == 8'hff ? 8'h0 : _value_T_13; // @[PaddingDesigns.scala 531:79 Counter.scala 99:11 78:15]
  wire  _GEN_115 = value == 8'hff ? _T_16 : _GEN_89; // @[PaddingDesigns.scala 531:79]
  wire [10:0] _GEN_116 = value == 8'hff ? 11'h0 : _GEN_111; // @[PaddingDesigns.scala 531:79 538:32]
  wire [4:0] _GEN_117 = value == 8'hff ? 5'h0 : _GEN_113; // @[PaddingDesigns.scala 531:79 Counter.scala 99:11]
  wire  _GEN_118 = value == 8'hff ? 1'h0 : _GEN_112; // @[PaddingDesigns.scala 531:79 Counter.scala 99:11]
  wire [1:0] _GEN_119 = value == 8'hff ? 2'h0 : _value_T_9; // @[PaddingDesigns.scala 531:79 Counter.scala 99:11 78:15]
  wire [10:0] _reg_out_batch_offst_T_1 = reg_out_batch_offst + 11'h80; // @[PaddingDesigns.scala 555:54]
  SlabGroup_6 SlabGroup ( // @[PaddingDesigns.scala 463:39]
    .clock(SlabGroup_clock),
    .io_in_ready(SlabGroup_io_in_ready),
    .io_in_valid(SlabGroup_io_in_valid),
    .io_in_data_0_Re(SlabGroup_io_in_data_0_Re),
    .io_in_data_0_Im(SlabGroup_io_in_data_0_Im),
    .io_in_data_1_Re(SlabGroup_io_in_data_1_Re),
    .io_in_data_1_Im(SlabGroup_io_in_data_1_Im),
    .io_in_write(SlabGroup_io_in_write),
    .io_in_pgroup_slct_0(SlabGroup_io_in_pgroup_slct_0),
    .io_in_pgroup_slct_1(SlabGroup_io_in_pgroup_slct_1),
    .io_in_RAM_slct_0(SlabGroup_io_in_RAM_slct_0),
    .io_in_RAM_slct_1(SlabGroup_io_in_RAM_slct_1),
    .io_in_addr_slct_0(SlabGroup_io_in_addr_slct_0),
    .io_in_addr_slct_1(SlabGroup_io_in_addr_slct_1),
    .io_out_data_0_Re(SlabGroup_io_out_data_0_Re),
    .io_out_data_0_Im(SlabGroup_io_out_data_0_Im),
    .io_out_data_1_Re(SlabGroup_io_out_data_1_Re),
    .io_out_data_1_Im(SlabGroup_io_out_data_1_Im)
  );
  SlabGroup_6 SlabGroup_1 ( // @[PaddingDesigns.scala 463:39]
    .clock(SlabGroup_1_clock),
    .io_in_ready(SlabGroup_1_io_in_ready),
    .io_in_valid(SlabGroup_1_io_in_valid),
    .io_in_data_0_Re(SlabGroup_1_io_in_data_0_Re),
    .io_in_data_0_Im(SlabGroup_1_io_in_data_0_Im),
    .io_in_data_1_Re(SlabGroup_1_io_in_data_1_Re),
    .io_in_data_1_Im(SlabGroup_1_io_in_data_1_Im),
    .io_in_write(SlabGroup_1_io_in_write),
    .io_in_pgroup_slct_0(SlabGroup_1_io_in_pgroup_slct_0),
    .io_in_pgroup_slct_1(SlabGroup_1_io_in_pgroup_slct_1),
    .io_in_RAM_slct_0(SlabGroup_1_io_in_RAM_slct_0),
    .io_in_RAM_slct_1(SlabGroup_1_io_in_RAM_slct_1),
    .io_in_addr_slct_0(SlabGroup_1_io_in_addr_slct_0),
    .io_in_addr_slct_1(SlabGroup_1_io_in_addr_slct_1),
    .io_out_data_0_Re(SlabGroup_1_io_out_data_0_Re),
    .io_out_data_0_Im(SlabGroup_1_io_out_data_0_Im),
    .io_out_data_1_Re(SlabGroup_1_io_out_data_1_Re),
    .io_out_data_1_Im(SlabGroup_1_io_out_data_1_Im)
  );
  assign io_out_ready = io_in_ready; // @[PaddingDesigns.scala 478:18]
  assign io_out_valid = io_out_valid_r; // @[PaddingDesigns.scala 477:18]
  assign io_out_data_0_Re = r ? slabs_1_out_data_0_Re : slabs_0_out_data_0_Re; // @[PaddingDesigns.scala 479:{17,17}]
  assign io_out_data_0_Im = r ? slabs_1_out_data_0_Im : slabs_0_out_data_0_Im; // @[PaddingDesigns.scala 479:{17,17}]
  assign io_out_data_1_Re = r ? slabs_1_out_data_1_Re : slabs_0_out_data_1_Re; // @[PaddingDesigns.scala 479:{17,17}]
  assign io_out_data_1_Im = r ? slabs_1_out_data_1_Im : slabs_0_out_data_1_Im; // @[PaddingDesigns.scala 479:{17,17}]
  assign SlabGroup_clock = clock;
  assign SlabGroup_io_in_ready = io_in_ready & reg_read_out ? _GEN_95 : _GEN_59; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_valid = io_in_ready & io_in_valid & _GEN_19; // @[PaddingDesigns.scala 467:18 481:36]
  assign SlabGroup_io_in_data_0_Re = io_in_ready & io_in_valid ? _GEN_23 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_data_0_Im = io_in_ready & io_in_valid ? _GEN_21 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_data_1_Re = io_in_ready & io_in_valid ? _GEN_27 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_data_1_Im = io_in_ready & io_in_valid ? _GEN_25 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_io_in_write = io_in_ready & reg_read_out ? _GEN_93 : _GEN_57; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_pgroup_slct_0 = io_in_ready & reg_read_out ? _GEN_97 : _GEN_73; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_pgroup_slct_1 = io_in_ready & reg_read_out ? _GEN_99 : _GEN_73; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_RAM_slct_0 = io_in_ready & reg_read_out ? _GEN_101 : 2'h0; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_RAM_slct_1 = io_in_ready & reg_read_out ? _GEN_103 : _GEN_79; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_addr_slct_0 = io_in_ready & reg_read_out ? _GEN_105 : _GEN_81; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_io_in_addr_slct_1 = io_in_ready & reg_read_out ? _GEN_105 : _GEN_81; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_clock = clock;
  assign SlabGroup_1_io_in_ready = io_in_ready & reg_read_out ? _GEN_96 : _GEN_60; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_valid = io_in_ready & io_in_valid & _GEN_20; // @[PaddingDesigns.scala 467:18 481:36]
  assign SlabGroup_1_io_in_data_0_Re = io_in_ready & io_in_valid ? _GEN_24 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_data_0_Im = io_in_ready & io_in_valid ? _GEN_22 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_data_1_Re = io_in_ready & io_in_valid ? _GEN_28 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_data_1_Im = io_in_ready & io_in_valid ? _GEN_26 : 32'h0; // @[PaddingDesigns.scala 469:26 481:36]
  assign SlabGroup_1_io_in_write = io_in_ready & reg_read_out ? _GEN_94 : _GEN_58; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_pgroup_slct_0 = io_in_ready & reg_read_out ? _GEN_98 : _GEN_74; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_pgroup_slct_1 = io_in_ready & reg_read_out ? _GEN_100 : _GEN_74; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_RAM_slct_0 = io_in_ready & reg_read_out ? _GEN_102 : 2'h0; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_RAM_slct_1 = io_in_ready & reg_read_out ? _GEN_104 : _GEN_80; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_addr_slct_0 = io_in_ready & reg_read_out ? _GEN_106 : _GEN_82; // @[PaddingDesigns.scala 519:37]
  assign SlabGroup_1_io_in_addr_slct_1 = io_in_ready & reg_read_out ? _GEN_106 : _GEN_82; // @[PaddingDesigns.scala 519:37]
  always @(posedge clock) begin
    if (reset) begin // @[Counter.scala 62:40]
      value <= 8'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          value <= _GEN_114;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_1 <= 8'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (wrap) begin // @[PaddingDesigns.scala 492:52]
        if (value_1 == 8'hff) begin // @[PaddingDesigns.scala 494:76]
          value_1 <= 8'h0; // @[Counter.scala 99:11]
        end else begin
          value_1 <= _value_T_3; // @[Counter.scala 78:15]
        end
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 450:31]
      reg_read_out <= 1'h0; // @[PaddingDesigns.scala 450:31]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          reg_read_out <= _GEN_115;
        end else begin
          reg_read_out <= _GEN_89;
        end
      end else begin
        reg_read_out <= _GEN_89;
      end
    end else begin
      reg_read_out <= _GEN_89;
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_2 <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          value_2 <= _GEN_119;
        end else begin
          value_2 <= _value_T_9; // @[Counter.scala 78:15]
        end
      end else begin
        value_2 <= _value_T_9; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_3 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      value_3 <= _value_T_1; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_4 <= 3'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        value_4 <= _value_T_11; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 454:37]
      reg_in_batch_offst <= 11'h0; // @[PaddingDesigns.scala 454:37]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (wrap) begin // @[PaddingDesigns.scala 492:52]
        reg_in_batch_offst <= 11'h0; // @[PaddingDesigns.scala 493:28]
      end else begin
        reg_in_batch_offst <= _reg_in_batch_offst_T_1; // @[PaddingDesigns.scala 512:28]
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 455:38]
      reg_out_batch_offst <= 11'h0; // @[PaddingDesigns.scala 455:38]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          reg_out_batch_offst <= 11'h0; // @[PaddingDesigns.scala 530:31]
        end else begin
          reg_out_batch_offst <= _reg_out_batch_offst_T_1; // @[PaddingDesigns.scala 555:31]
        end
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 456:37]
      reg_out_addr_offst <= 11'h0; // @[PaddingDesigns.scala 456:37]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          reg_out_addr_offst <= _GEN_116;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_5 <= 5'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          value_5 <= _GEN_117;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_6 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & reg_read_out) begin // @[PaddingDesigns.scala 519:37]
      if (wrap_4) begin // @[PaddingDesigns.scala 527:46]
        if (wrap_5) begin // @[PaddingDesigns.scala 529:55]
          value_6 <= _GEN_118;
        end
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 459:36]
      reg_in_addr_offst <= 11'h0; // @[PaddingDesigns.scala 459:36]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (wrap) begin // @[PaddingDesigns.scala 492:52]
        if (value_1 == 8'hff) begin // @[PaddingDesigns.scala 494:76]
          reg_in_addr_offst <= 11'h0; // @[PaddingDesigns.scala 498:29]
        end else begin
          reg_in_addr_offst <= _GEN_43;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_7 <= 5'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (wrap) begin // @[PaddingDesigns.scala 492:52]
        if (value_1 == 8'hff) begin // @[PaddingDesigns.scala 494:76]
          value_7 <= 5'h0; // @[Counter.scala 99:11]
        end else begin
          value_7 <= _value_T_5; // @[Counter.scala 78:15]
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_8 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (wrap) begin // @[PaddingDesigns.scala 492:52]
        if (value_1 == 8'hff) begin // @[PaddingDesigns.scala 494:76]
          value_8 <= 1'h0; // @[Counter.scala 99:11]
        end else begin
          value_8 <= _GEN_42;
        end
      end
    end
    if (reset) begin // @[PaddingDesigns.scala 462:26]
      WR_mode <= 1'h0; // @[PaddingDesigns.scala 462:26]
    end else if (io_in_ready & io_in_valid) begin // @[PaddingDesigns.scala 481:36]
      if (wrap) begin // @[PaddingDesigns.scala 492:52]
        if (value_1 == 8'hff) begin // @[PaddingDesigns.scala 494:76]
          WR_mode <= _io_out_last_T; // @[PaddingDesigns.scala 496:19]
        end
      end
    end
    if (io_in_ready) begin // @[Reg.scala 17:18]
      io_out_valid_r <= _io_out_valid_T_1; // @[Reg.scala 17:22]
    end
    if (io_in_ready) begin // @[Reg.scala 17:18]
      r <= _io_out_last_T; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  value = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  value_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  reg_read_out = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  value_2 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  value_3 = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  value_4 = _RAND_5[2:0];
  _RAND_6 = {1{`RANDOM}};
  reg_in_batch_offst = _RAND_6[10:0];
  _RAND_7 = {1{`RANDOM}};
  reg_out_batch_offst = _RAND_7[10:0];
  _RAND_8 = {1{`RANDOM}};
  reg_out_addr_offst = _RAND_8[10:0];
  _RAND_9 = {1{`RANDOM}};
  value_5 = _RAND_9[4:0];
  _RAND_10 = {1{`RANDOM}};
  value_6 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  reg_in_addr_offst = _RAND_11[10:0];
  _RAND_12 = {1{`RANDOM}};
  value_7 = _RAND_12[4:0];
  _RAND_13 = {1{`RANDOM}};
  value_8 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  WR_mode = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  io_out_valid_r = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  r = _RAND_16[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ComplexToReal(
  input         clock,
  input         reset,
  input  [31:0] io_in_Re,
  input  [31:0] io_in_Im,
  input         io_in_en,
  input         io_in_valid,
  output [31:0] io_out,
  output        io_out_en,
  output        io_out_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
`endif // RANDOMIZE_REG_INIT
  wire  FP_multiplier_bw32_clock; // @[FFTSRDesigns.scala 261:40]
  wire  FP_multiplier_bw32_reset; // @[FFTSRDesigns.scala 261:40]
  wire  FP_multiplier_bw32_io_in_en; // @[FFTSRDesigns.scala 261:40]
  wire [31:0] FP_multiplier_bw32_io_in_a; // @[FFTSRDesigns.scala 261:40]
  wire [31:0] FP_multiplier_bw32_io_in_b; // @[FFTSRDesigns.scala 261:40]
  wire [31:0] FP_multiplier_bw32_io_out_s; // @[FFTSRDesigns.scala 261:40]
  wire  FP_multiplier_bw32_1_clock; // @[FFTSRDesigns.scala 261:40]
  wire  FP_multiplier_bw32_1_reset; // @[FFTSRDesigns.scala 261:40]
  wire  FP_multiplier_bw32_1_io_in_en; // @[FFTSRDesigns.scala 261:40]
  wire [31:0] FP_multiplier_bw32_1_io_in_a; // @[FFTSRDesigns.scala 261:40]
  wire [31:0] FP_multiplier_bw32_1_io_in_b; // @[FFTSRDesigns.scala 261:40]
  wire [31:0] FP_multiplier_bw32_1_io_out_s; // @[FFTSRDesigns.scala 261:40]
  wire  fp_add_clock; // @[FFTSRDesigns.scala 262:24]
  wire  fp_add_reset; // @[FFTSRDesigns.scala 262:24]
  wire  fp_add_io_in_en; // @[FFTSRDesigns.scala 262:24]
  wire [31:0] fp_add_io_in_a; // @[FFTSRDesigns.scala 262:24]
  wire [31:0] fp_add_io_in_b; // @[FFTSRDesigns.scala 262:24]
  wire [31:0] fp_add_io_out_s; // @[FFTSRDesigns.scala 262:24]
  reg  io_out_valid_r; // @[Reg.scala 16:16]
  reg  io_out_valid_r_1; // @[Reg.scala 16:16]
  reg  io_out_valid_r_2; // @[Reg.scala 16:16]
  reg  io_out_valid_r_3; // @[Reg.scala 16:16]
  reg  io_out_valid_r_4; // @[Reg.scala 16:16]
  reg  io_out_valid_r_5; // @[Reg.scala 16:16]
  reg  io_out_valid_r_6; // @[Reg.scala 16:16]
  reg  io_out_valid_r_7; // @[Reg.scala 16:16]
  reg  io_out_valid_r_8; // @[Reg.scala 16:16]
  reg  io_out_valid_r_9; // @[Reg.scala 16:16]
  reg  io_out_valid_r_10; // @[Reg.scala 16:16]
  reg  io_out_valid_r_11; // @[Reg.scala 16:16]
  reg  io_out_valid_r_12; // @[Reg.scala 16:16]
  reg  io_out_valid_r_13; // @[Reg.scala 16:16]
  reg  io_out_valid_r_14; // @[Reg.scala 16:16]
  reg  io_out_valid_r_15; // @[Reg.scala 16:16]
  reg  io_out_valid_r_16; // @[Reg.scala 16:16]
  reg  io_out_valid_r_17; // @[Reg.scala 16:16]
  reg  io_out_valid_r_18; // @[Reg.scala 16:16]
  reg  io_out_valid_r_19; // @[Reg.scala 16:16]
  reg  io_out_valid_r_20; // @[Reg.scala 16:16]
  reg  io_out_valid_r_21; // @[Reg.scala 16:16]
  reg  io_out_valid_r_22; // @[Reg.scala 16:16]
  wire [31:0] _GEN_23 = io_in_valid ? io_in_Re : 32'h0; // @[FFTSRDesigns.scala 273:24 274:29 268:32]
  wire [31:0] _GEN_24 = io_in_valid ? io_in_Im : 32'h0; // @[FFTSRDesigns.scala 273:24 276:29 268:32]
  FP_multiplier_bw32 FP_multiplier_bw32 ( // @[FFTSRDesigns.scala 261:40]
    .clock(FP_multiplier_bw32_clock),
    .reset(FP_multiplier_bw32_reset),
    .io_in_en(FP_multiplier_bw32_io_in_en),
    .io_in_a(FP_multiplier_bw32_io_in_a),
    .io_in_b(FP_multiplier_bw32_io_in_b),
    .io_out_s(FP_multiplier_bw32_io_out_s)
  );
  FP_multiplier_bw32 FP_multiplier_bw32_1 ( // @[FFTSRDesigns.scala 261:40]
    .clock(FP_multiplier_bw32_1_clock),
    .reset(FP_multiplier_bw32_1_reset),
    .io_in_en(FP_multiplier_bw32_1_io_in_en),
    .io_in_a(FP_multiplier_bw32_1_io_in_a),
    .io_in_b(FP_multiplier_bw32_1_io_in_b),
    .io_out_s(FP_multiplier_bw32_1_io_out_s)
  );
  FP_adder_bw32 fp_add ( // @[FFTSRDesigns.scala 262:24]
    .clock(fp_add_clock),
    .reset(fp_add_reset),
    .io_in_en(fp_add_io_in_en),
    .io_in_a(fp_add_io_in_a),
    .io_in_b(fp_add_io_in_b),
    .io_out_s(fp_add_io_out_s)
  );
  assign io_out = fp_add_io_out_s; // @[FFTSRDesigns.scala 270:12]
  assign io_out_en = io_in_en; // @[FFTSRDesigns.scala 263:15]
  assign io_out_valid = io_out_valid_r_22; // @[FFTSRDesigns.scala 271:18]
  assign FP_multiplier_bw32_clock = clock;
  assign FP_multiplier_bw32_reset = reset;
  assign FP_multiplier_bw32_io_in_en = io_in_en; // @[FFTSRDesigns.scala 267:33]
  assign FP_multiplier_bw32_io_in_a = io_in_en ? _GEN_23 : 32'h0; // @[FFTSRDesigns.scala 272:19 268:32]
  assign FP_multiplier_bw32_io_in_b = io_in_en ? _GEN_23 : 32'h0; // @[FFTSRDesigns.scala 272:19 268:32]
  assign FP_multiplier_bw32_1_clock = clock;
  assign FP_multiplier_bw32_1_reset = reset;
  assign FP_multiplier_bw32_1_io_in_en = io_in_en; // @[FFTSRDesigns.scala 267:33]
  assign FP_multiplier_bw32_1_io_in_a = io_in_en ? _GEN_24 : 32'h0; // @[FFTSRDesigns.scala 272:19 268:32]
  assign FP_multiplier_bw32_1_io_in_b = io_in_en ? _GEN_24 : 32'h0; // @[FFTSRDesigns.scala 272:19 268:32]
  assign fp_add_clock = clock;
  assign fp_add_reset = reset;
  assign fp_add_io_in_en = io_in_en; // @[FFTSRDesigns.scala 264:21]
  assign fp_add_io_in_a = FP_multiplier_bw32_io_out_s; // @[FFTSRDesigns.scala 265:20]
  assign fp_add_io_in_b = FP_multiplier_bw32_1_io_out_s; // @[FFTSRDesigns.scala 266:20]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r <= io_in_valid; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_1 <= io_out_valid_r; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_2 <= io_out_valid_r_1; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_3 <= io_out_valid_r_2; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_4 <= io_out_valid_r_3; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_5 <= io_out_valid_r_4; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_6 <= io_out_valid_r_5; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_7 <= io_out_valid_r_6; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_8 <= io_out_valid_r_7; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_9 <= io_out_valid_r_8; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_10 <= io_out_valid_r_9; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_11 <= io_out_valid_r_10; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_12 <= io_out_valid_r_11; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_13 <= io_out_valid_r_12; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_14 <= io_out_valid_r_13; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_15 <= io_out_valid_r_14; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_16 <= io_out_valid_r_15; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_17 <= io_out_valid_r_16; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_18 <= io_out_valid_r_17; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_19 <= io_out_valid_r_18; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_20 <= io_out_valid_r_19; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_21 <= io_out_valid_r_20; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      io_out_valid_r_22 <= io_out_valid_r_21; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_out_valid_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  io_out_valid_r_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  io_out_valid_r_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  io_out_valid_r_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  io_out_valid_r_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  io_out_valid_r_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  io_out_valid_r_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  io_out_valid_r_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  io_out_valid_r_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  io_out_valid_r_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  io_out_valid_r_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  io_out_valid_r_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  io_out_valid_r_12 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  io_out_valid_r_13 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  io_out_valid_r_14 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  io_out_valid_r_15 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  io_out_valid_r_16 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  io_out_valid_r_17 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  io_out_valid_r_18 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  io_out_valid_r_19 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  io_out_valid_r_20 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  io_out_valid_r_21 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  io_out_valid_r_22 = _RAND_22[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module simple_RAM_depth2048_bw32(
  input         clock,
  input  [10:0] io_in_addr,
  input  [31:0] io_in_data,
  input         io_in_en,
  input         io_in_we,
  output [31:0] io_out_data
);
  blk_mem_gen_3 u_blk_mem_gen_3(
    .clka(clock),
    .addra(io_in_addr),
    .dina(io_in_data),
    .ena(io_in_en),
    .wea(io_in_we),
    .douta(io_out_data)
  );
endmodule
module SyncReadMem_Real(
  input         clock,
  input         io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_data,
  input         io_in_we,
  input  [11:0] io_in_addr,
  output [31:0] io_out_data
);
  wire  simple_RAM_depth2048_bw32_clock; // @[FFTSRDesigns.scala 369:22]
  wire [10:0] simple_RAM_depth2048_bw32_io_in_addr; // @[FFTSRDesigns.scala 369:22]
  wire [31:0] simple_RAM_depth2048_bw32_io_in_data; // @[FFTSRDesigns.scala 369:22]
  wire  simple_RAM_depth2048_bw32_io_in_en; // @[FFTSRDesigns.scala 369:22]
  wire  simple_RAM_depth2048_bw32_io_in_we; // @[FFTSRDesigns.scala 369:22]
  wire [31:0] simple_RAM_depth2048_bw32_io_out_data; // @[FFTSRDesigns.scala 369:22]
  simple_RAM_depth2048_bw32 simple_RAM_depth2048_bw32 ( // @[FFTSRDesigns.scala 369:22]
    .clock(simple_RAM_depth2048_bw32_clock),
    .io_in_addr(simple_RAM_depth2048_bw32_io_in_addr),
    .io_in_data(simple_RAM_depth2048_bw32_io_in_data),
    .io_in_en(simple_RAM_depth2048_bw32_io_in_en),
    .io_in_we(simple_RAM_depth2048_bw32_io_in_we),
    .io_out_data(simple_RAM_depth2048_bw32_io_out_data)
  );
  assign io_out_data = simple_RAM_depth2048_bw32_io_out_data; // @[FFTSRDesigns.scala 378:17]
  assign simple_RAM_depth2048_bw32_clock = clock;
  assign simple_RAM_depth2048_bw32_io_in_addr = io_in_addr[10:0]; // @[FFTSRDesigns.scala 370:18]
  assign simple_RAM_depth2048_bw32_io_in_data = io_in_data; // @[FFTSRDesigns.scala 371:18]
  assign simple_RAM_depth2048_bw32_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 373:16]
  assign simple_RAM_depth2048_bw32_io_in_we = io_in_we & io_in_valid; // @[FFTSRDesigns.scala 372:28]
endmodule
module Buffer_FFT_Out(
  input         clock,
  input         reset,
  input         io_in_valid,
  input         io_in_ready,
  input         io_in_read_inc,
  input  [31:0] io_in_data_0,
  input  [31:0] io_in_data_1,
  output        io_out_full,
  output        io_out_valid,
  output [31:0] io_out_data_0,
  output [31:0] io_out_data_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire  SyncReadMem_Real_clock; // @[FFTSRDesigns.scala 418:36]
  wire  SyncReadMem_Real_io_in_ready; // @[FFTSRDesigns.scala 418:36]
  wire  SyncReadMem_Real_io_in_valid; // @[FFTSRDesigns.scala 418:36]
  wire [31:0] SyncReadMem_Real_io_in_data; // @[FFTSRDesigns.scala 418:36]
  wire  SyncReadMem_Real_io_in_we; // @[FFTSRDesigns.scala 418:36]
  wire [11:0] SyncReadMem_Real_io_in_addr; // @[FFTSRDesigns.scala 418:36]
  wire [31:0] SyncReadMem_Real_io_out_data; // @[FFTSRDesigns.scala 418:36]
  wire  SyncReadMem_Real_1_clock; // @[FFTSRDesigns.scala 418:36]
  wire  SyncReadMem_Real_1_io_in_ready; // @[FFTSRDesigns.scala 418:36]
  wire  SyncReadMem_Real_1_io_in_valid; // @[FFTSRDesigns.scala 418:36]
  wire [31:0] SyncReadMem_Real_1_io_in_data; // @[FFTSRDesigns.scala 418:36]
  wire  SyncReadMem_Real_1_io_in_we; // @[FFTSRDesigns.scala 418:36]
  wire [11:0] SyncReadMem_Real_1_io_in_addr; // @[FFTSRDesigns.scala 418:36]
  wire [31:0] SyncReadMem_Real_1_io_out_data; // @[FFTSRDesigns.scala 418:36]
  reg [1:0] value; // @[Counter.scala 62:40]
  reg [10:0] value_1; // @[Counter.scala 62:40]
  reg  ready_for_read; // @[FFTSRDesigns.scala 421:33]
  reg  read_batch; // @[FFTSRDesigns.scala 422:29]
  reg [10:0] value_2; // @[Counter.scala 62:40]
  reg [4:0] value_3; // @[Counter.scala 62:40]
  wire  _io_out_valid_T_2 = ready_for_read & read_batch & value == 2'h0; // @[FFTSRDesigns.scala 427:63]
  reg  io_out_valid_r; // @[Reg.scala 16:16]
  wire  _T_1 = io_in_valid & ~ready_for_read; // @[FFTSRDesigns.scala 434:24]
  wire  wrap = value_2 == 11'h7ff; // @[Counter.scala 74:24]
  wire [10:0] _value_T_1 = value_2 + 11'h1; // @[Counter.scala 78:24]
  wire  _GEN_1 = wrap | ready_for_read; // @[FFTSRDesigns.scala 440:54 441:26 421:33]
  wire  wrap_1 = value == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_3 = value + 2'h1; // @[Counter.scala 78:24]
  wire  wrap_2 = value_1 == 11'h7ff; // @[Counter.scala 74:24]
  wire [10:0] _value_T_5 = value_1 + 11'h1; // @[Counter.scala 78:24]
  wire  wrap_3 = value_3 == 5'h1f; // @[Counter.scala 74:24]
  wire [4:0] _value_T_7 = value_3 + 5'h1; // @[Counter.scala 78:24]
  wire  _GEN_2 = wrap_3 ? 1'h0 : read_batch; // @[FFTSRDesigns.scala 452:82 453:26 422:29]
  wire  _GEN_3 = wrap_2 ? 1'h0 : ready_for_read; // @[FFTSRDesigns.scala 455:61 456:30 421:33]
  wire [10:0] _GEN_4 = wrap_1 ? _value_T_5 : value_1; // @[FFTSRDesigns.scala 449:57 Counter.scala 78:15 62:40]
  wire [4:0] _GEN_5 = wrap_1 ? _value_T_7 : value_3; // @[FFTSRDesigns.scala 449:57 Counter.scala 78:15 62:40]
  wire  _GEN_6 = wrap_1 ? _GEN_2 : read_batch; // @[FFTSRDesigns.scala 422:29 449:57]
  wire  _GEN_7 = wrap_1 ? _GEN_3 : ready_for_read; // @[FFTSRDesigns.scala 421:33 449:57]
  wire [10:0] _GEN_8 = read_batch ? value_1 : 11'h0; // @[FFTSRDesigns.scala 432:27 446:31 447:33]
  wire [1:0] _GEN_9 = read_batch ? _value_T_3 : value; // @[FFTSRDesigns.scala 446:31 Counter.scala 78:15 62:40]
  wire [10:0] _GEN_10 = read_batch ? _GEN_4 : value_1; // @[FFTSRDesigns.scala 446:31 Counter.scala 62:40]
  wire [4:0] _GEN_11 = read_batch ? _GEN_5 : value_3; // @[FFTSRDesigns.scala 446:31 Counter.scala 62:40]
  wire  _GEN_12 = read_batch ? _GEN_6 : read_batch; // @[FFTSRDesigns.scala 422:29 446:31]
  wire  _GEN_13 = read_batch ? _GEN_7 : ready_for_read; // @[FFTSRDesigns.scala 446:31 421:33]
  wire  _GEN_14 = io_in_read_inc & ~read_batch | _GEN_12; // @[FFTSRDesigns.scala 444:43 445:22]
  wire [10:0] _GEN_15 = io_in_read_inc & ~read_batch ? 11'h0 : _GEN_8; // @[FFTSRDesigns.scala 432:27 444:43]
  wire [1:0] _GEN_16 = io_in_read_inc & ~read_batch ? value : _GEN_9; // @[FFTSRDesigns.scala 444:43 Counter.scala 62:40]
  wire [10:0] _GEN_17 = io_in_read_inc & ~read_batch ? value_1 : _GEN_10; // @[FFTSRDesigns.scala 444:43 Counter.scala 62:40]
  wire [4:0] _GEN_18 = io_in_read_inc & ~read_batch ? value_3 : _GEN_11; // @[FFTSRDesigns.scala 444:43 Counter.scala 62:40]
  wire  _GEN_19 = io_in_read_inc & ~read_batch ? ready_for_read : _GEN_13; // @[FFTSRDesigns.scala 421:33 444:43]
  wire [10:0] _GEN_21 = ready_for_read ? _GEN_15 : 11'h0; // @[FFTSRDesigns.scala 432:27 443:33]
  wire  _GEN_27 = io_in_valid & ~ready_for_read & io_in_valid; // @[FFTSRDesigns.scala 428:28 434:42 436:32]
  wire [10:0] _GEN_28 = io_in_valid & ~ready_for_read ? value_2 : _GEN_21; // @[FFTSRDesigns.scala 434:42 437:31]
  wire [31:0] _GEN_30 = io_in_valid & ~ready_for_read ? io_in_data_0 : 32'h0; // @[FFTSRDesigns.scala 431:27 434:42 439:51]
  wire [31:0] _GEN_31 = io_in_valid & ~ready_for_read ? io_in_data_1 : 32'h0; // @[FFTSRDesigns.scala 431:27 434:42 439:51]
  wire [10:0] _GEN_39 = io_in_ready ? _GEN_28 : 11'h0; // @[FFTSRDesigns.scala 433:22 432:27]
  SyncReadMem_Real SyncReadMem_Real ( // @[FFTSRDesigns.scala 418:36]
    .clock(SyncReadMem_Real_clock),
    .io_in_ready(SyncReadMem_Real_io_in_ready),
    .io_in_valid(SyncReadMem_Real_io_in_valid),
    .io_in_data(SyncReadMem_Real_io_in_data),
    .io_in_we(SyncReadMem_Real_io_in_we),
    .io_in_addr(SyncReadMem_Real_io_in_addr),
    .io_out_data(SyncReadMem_Real_io_out_data)
  );
  SyncReadMem_Real SyncReadMem_Real_1 ( // @[FFTSRDesigns.scala 418:36]
    .clock(SyncReadMem_Real_1_clock),
    .io_in_ready(SyncReadMem_Real_1_io_in_ready),
    .io_in_valid(SyncReadMem_Real_1_io_in_valid),
    .io_in_data(SyncReadMem_Real_1_io_in_data),
    .io_in_we(SyncReadMem_Real_1_io_in_we),
    .io_in_addr(SyncReadMem_Real_1_io_in_addr),
    .io_out_data(SyncReadMem_Real_1_io_out_data)
  );
  assign io_out_full = ready_for_read; // @[FFTSRDesigns.scala 425:17]
  assign io_out_valid = io_out_valid_r; // @[FFTSRDesigns.scala 427:18]
  assign io_out_data_0 = SyncReadMem_Real_io_out_data; // @[FFTSRDesigns.scala 426:{27,27}]
  assign io_out_data_1 = SyncReadMem_Real_1_io_out_data; // @[FFTSRDesigns.scala 426:{27,27}]
  assign SyncReadMem_Real_clock = clock;
  assign SyncReadMem_Real_io_in_ready = io_in_ready; // @[FFTSRDesigns.scala 430:28]
  assign SyncReadMem_Real_io_in_valid = io_in_ready & _GEN_27; // @[FFTSRDesigns.scala 433:22 428:28]
  assign SyncReadMem_Real_io_in_data = io_in_ready ? _GEN_30 : 32'h0; // @[FFTSRDesigns.scala 433:22 431:27]
  assign SyncReadMem_Real_io_in_we = io_in_ready & _T_1; // @[FFTSRDesigns.scala 433:22 429:25]
  assign SyncReadMem_Real_io_in_addr = {{1'd0}, _GEN_39};
  assign SyncReadMem_Real_1_clock = clock;
  assign SyncReadMem_Real_1_io_in_ready = io_in_ready; // @[FFTSRDesigns.scala 430:28]
  assign SyncReadMem_Real_1_io_in_valid = io_in_ready & _GEN_27; // @[FFTSRDesigns.scala 433:22 428:28]
  assign SyncReadMem_Real_1_io_in_data = io_in_ready ? _GEN_31 : 32'h0; // @[FFTSRDesigns.scala 433:22 431:27]
  assign SyncReadMem_Real_1_io_in_we = io_in_ready & _T_1; // @[FFTSRDesigns.scala 433:22 429:25]
  assign SyncReadMem_Real_1_io_in_addr = {{1'd0}, _GEN_39};
  always @(posedge clock) begin
    if (reset) begin // @[Counter.scala 62:40]
      value <= 2'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready) begin // @[FFTSRDesigns.scala 433:22]
      if (!(io_in_valid & ~ready_for_read)) begin // @[FFTSRDesigns.scala 434:42]
        if (ready_for_read) begin // @[FFTSRDesigns.scala 443:33]
          value <= _GEN_16;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_1 <= 11'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready) begin // @[FFTSRDesigns.scala 433:22]
      if (!(io_in_valid & ~ready_for_read)) begin // @[FFTSRDesigns.scala 434:42]
        if (ready_for_read) begin // @[FFTSRDesigns.scala 443:33]
          value_1 <= _GEN_17;
        end
      end
    end
    if (reset) begin // @[FFTSRDesigns.scala 421:33]
      ready_for_read <= 1'h0; // @[FFTSRDesigns.scala 421:33]
    end else if (io_in_ready) begin // @[FFTSRDesigns.scala 433:22]
      if (io_in_valid & ~ready_for_read) begin // @[FFTSRDesigns.scala 434:42]
        ready_for_read <= _GEN_1;
      end else if (ready_for_read) begin // @[FFTSRDesigns.scala 443:33]
        ready_for_read <= _GEN_19;
      end
    end
    if (reset) begin // @[FFTSRDesigns.scala 422:29]
      read_batch <= 1'h0; // @[FFTSRDesigns.scala 422:29]
    end else if (io_in_ready) begin // @[FFTSRDesigns.scala 433:22]
      if (!(io_in_valid & ~ready_for_read)) begin // @[FFTSRDesigns.scala 434:42]
        if (ready_for_read) begin // @[FFTSRDesigns.scala 443:33]
          read_batch <= _GEN_14;
        end
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_2 <= 11'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready) begin // @[FFTSRDesigns.scala 433:22]
      if (io_in_valid & ~ready_for_read) begin // @[FFTSRDesigns.scala 434:42]
        value_2 <= _value_T_1; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_3 <= 5'h0; // @[Counter.scala 62:40]
    end else if (io_in_ready) begin // @[FFTSRDesigns.scala 433:22]
      if (!(io_in_valid & ~ready_for_read)) begin // @[FFTSRDesigns.scala 434:42]
        if (ready_for_read) begin // @[FFTSRDesigns.scala 443:33]
          value_3 <= _GEN_18;
        end
      end
    end
    if (io_in_ready) begin // @[Reg.scala 17:18]
      io_out_valid_r <= _io_out_valid_T_2; // @[Reg.scala 17:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  value = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  value_1 = _RAND_1[10:0];
  _RAND_2 = {1{`RANDOM}};
  ready_for_read = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  read_batch = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  value_2 = _RAND_4[10:0];
  _RAND_5 = {1{`RANDOM}};
  value_3 = _RAND_5[4:0];
  _RAND_6 = {1{`RANDOM}};
  io_out_valid_r = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Batched3DFFT8_RealOutv6(
  input         clock,
  input         reset,
  input         io_in_inv,
  input         io_in_ready,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  input         io_in_valid,
  input         io_in_get_tile,
  output        io_out_valid,
  output        io_out_ready,
  output [31:0] io_out_0,
  output [31:0] io_out_1
);
  wire  SimpleTrnsp_batched_clock; // @[FFTSRDesigns.scala 534:38]
  wire  SimpleTrnsp_batched_reset; // @[FFTSRDesigns.scala 534:38]
  wire  SimpleTrnsp_batched_io_in_ready; // @[FFTSRDesigns.scala 534:38]
  wire  SimpleTrnsp_batched_io_in_valid; // @[FFTSRDesigns.scala 534:38]
  wire [31:0] SimpleTrnsp_batched_io_in_data_0_Re; // @[FFTSRDesigns.scala 534:38]
  wire [31:0] SimpleTrnsp_batched_io_in_data_0_Im; // @[FFTSRDesigns.scala 534:38]
  wire [31:0] SimpleTrnsp_batched_io_in_data_1_Re; // @[FFTSRDesigns.scala 534:38]
  wire [31:0] SimpleTrnsp_batched_io_in_data_1_Im; // @[FFTSRDesigns.scala 534:38]
  wire  SimpleTrnsp_batched_io_out_ready; // @[FFTSRDesigns.scala 534:38]
  wire  SimpleTrnsp_batched_io_out_valid; // @[FFTSRDesigns.scala 534:38]
  wire [31:0] SimpleTrnsp_batched_io_out_data_0_Re; // @[FFTSRDesigns.scala 534:38]
  wire [31:0] SimpleTrnsp_batched_io_out_data_0_Im; // @[FFTSRDesigns.scala 534:38]
  wire [31:0] SimpleTrnsp_batched_io_out_data_1_Re; // @[FFTSRDesigns.scala 534:38]
  wire [31:0] SimpleTrnsp_batched_io_out_data_1_Im; // @[FFTSRDesigns.scala 534:38]
  wire  SimpleTrnsp_batched_1_clock; // @[FFTSRDesigns.scala 535:39]
  wire  SimpleTrnsp_batched_1_reset; // @[FFTSRDesigns.scala 535:39]
  wire  SimpleTrnsp_batched_1_io_in_ready; // @[FFTSRDesigns.scala 535:39]
  wire  SimpleTrnsp_batched_1_io_in_valid; // @[FFTSRDesigns.scala 535:39]
  wire [31:0] SimpleTrnsp_batched_1_io_in_data_0_Re; // @[FFTSRDesigns.scala 535:39]
  wire [31:0] SimpleTrnsp_batched_1_io_in_data_0_Im; // @[FFTSRDesigns.scala 535:39]
  wire [31:0] SimpleTrnsp_batched_1_io_in_data_1_Re; // @[FFTSRDesigns.scala 535:39]
  wire [31:0] SimpleTrnsp_batched_1_io_in_data_1_Im; // @[FFTSRDesigns.scala 535:39]
  wire  SimpleTrnsp_batched_1_io_out_ready; // @[FFTSRDesigns.scala 535:39]
  wire  SimpleTrnsp_batched_1_io_out_valid; // @[FFTSRDesigns.scala 535:39]
  wire [31:0] SimpleTrnsp_batched_1_io_out_data_0_Re; // @[FFTSRDesigns.scala 535:39]
  wire [31:0] SimpleTrnsp_batched_1_io_out_data_0_Im; // @[FFTSRDesigns.scala 535:39]
  wire [31:0] SimpleTrnsp_batched_1_io_out_data_1_Re; // @[FFTSRDesigns.scala 535:39]
  wire [31:0] SimpleTrnsp_batched_1_io_out_data_1_Im; // @[FFTSRDesigns.scala 535:39]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_clock; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_reset; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_inv; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_ready; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_0_Re; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_0_Im; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_1_Re; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_1_Im; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_valid; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_valid; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_ready; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_clock; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_reset; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_inv; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_ready; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_0_Re; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_0_Im; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_1_Re; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_1_Im; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_valid; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_valid; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_0_Re; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_0_Im; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_1_Re; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_1_Im; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_ready; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_clock; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_reset; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_inv; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_ready; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_0_Re; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_0_Im; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_1_Re; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_1_Im; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_valid; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_valid; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_0_Re; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_0_Im; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_1_Re; // @[FFTSRDesigns.scala 536:42]
  wire [31:0] FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_1_Im; // @[FFTSRDesigns.scala 536:42]
  wire  FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_ready; // @[FFTSRDesigns.scala 536:42]
  wire  SimpleTrnsp_batched_2_clock; // @[FFTSRDesigns.scala 537:31]
  wire  SimpleTrnsp_batched_2_reset; // @[FFTSRDesigns.scala 537:31]
  wire  SimpleTrnsp_batched_2_io_in_ready; // @[FFTSRDesigns.scala 537:31]
  wire  SimpleTrnsp_batched_2_io_in_valid; // @[FFTSRDesigns.scala 537:31]
  wire [31:0] SimpleTrnsp_batched_2_io_in_data_0_Re; // @[FFTSRDesigns.scala 537:31]
  wire [31:0] SimpleTrnsp_batched_2_io_in_data_0_Im; // @[FFTSRDesigns.scala 537:31]
  wire [31:0] SimpleTrnsp_batched_2_io_in_data_1_Re; // @[FFTSRDesigns.scala 537:31]
  wire [31:0] SimpleTrnsp_batched_2_io_in_data_1_Im; // @[FFTSRDesigns.scala 537:31]
  wire  SimpleTrnsp_batched_2_io_out_ready; // @[FFTSRDesigns.scala 537:31]
  wire  SimpleTrnsp_batched_2_io_out_valid; // @[FFTSRDesigns.scala 537:31]
  wire [31:0] SimpleTrnsp_batched_2_io_out_data_0_Re; // @[FFTSRDesigns.scala 537:31]
  wire [31:0] SimpleTrnsp_batched_2_io_out_data_0_Im; // @[FFTSRDesigns.scala 537:31]
  wire [31:0] SimpleTrnsp_batched_2_io_out_data_1_Re; // @[FFTSRDesigns.scala 537:31]
  wire [31:0] SimpleTrnsp_batched_2_io_out_data_1_Im; // @[FFTSRDesigns.scala 537:31]
  wire  SimpleTrnsp_batched_3_clock; // @[FFTSRDesigns.scala 538:31]
  wire  SimpleTrnsp_batched_3_reset; // @[FFTSRDesigns.scala 538:31]
  wire  SimpleTrnsp_batched_3_io_in_ready; // @[FFTSRDesigns.scala 538:31]
  wire  SimpleTrnsp_batched_3_io_in_valid; // @[FFTSRDesigns.scala 538:31]
  wire [31:0] SimpleTrnsp_batched_3_io_in_data_0_Re; // @[FFTSRDesigns.scala 538:31]
  wire [31:0] SimpleTrnsp_batched_3_io_in_data_0_Im; // @[FFTSRDesigns.scala 538:31]
  wire [31:0] SimpleTrnsp_batched_3_io_in_data_1_Re; // @[FFTSRDesigns.scala 538:31]
  wire [31:0] SimpleTrnsp_batched_3_io_in_data_1_Im; // @[FFTSRDesigns.scala 538:31]
  wire  SimpleTrnsp_batched_3_io_out_ready; // @[FFTSRDesigns.scala 538:31]
  wire  SimpleTrnsp_batched_3_io_out_valid; // @[FFTSRDesigns.scala 538:31]
  wire [31:0] SimpleTrnsp_batched_3_io_out_data_0_Re; // @[FFTSRDesigns.scala 538:31]
  wire [31:0] SimpleTrnsp_batched_3_io_out_data_0_Im; // @[FFTSRDesigns.scala 538:31]
  wire [31:0] SimpleTrnsp_batched_3_io_out_data_1_Re; // @[FFTSRDesigns.scala 538:31]
  wire [31:0] SimpleTrnsp_batched_3_io_out_data_1_Im; // @[FFTSRDesigns.scala 538:31]
  wire  ComplexToReal_clock; // @[FFTSRDesigns.scala 539:45]
  wire  ComplexToReal_reset; // @[FFTSRDesigns.scala 539:45]
  wire [31:0] ComplexToReal_io_in_Re; // @[FFTSRDesigns.scala 539:45]
  wire [31:0] ComplexToReal_io_in_Im; // @[FFTSRDesigns.scala 539:45]
  wire  ComplexToReal_io_in_en; // @[FFTSRDesigns.scala 539:45]
  wire  ComplexToReal_io_in_valid; // @[FFTSRDesigns.scala 539:45]
  wire [31:0] ComplexToReal_io_out; // @[FFTSRDesigns.scala 539:45]
  wire  ComplexToReal_io_out_en; // @[FFTSRDesigns.scala 539:45]
  wire  ComplexToReal_io_out_valid; // @[FFTSRDesigns.scala 539:45]
  wire  ComplexToReal_1_clock; // @[FFTSRDesigns.scala 539:45]
  wire  ComplexToReal_1_reset; // @[FFTSRDesigns.scala 539:45]
  wire [31:0] ComplexToReal_1_io_in_Re; // @[FFTSRDesigns.scala 539:45]
  wire [31:0] ComplexToReal_1_io_in_Im; // @[FFTSRDesigns.scala 539:45]
  wire  ComplexToReal_1_io_in_en; // @[FFTSRDesigns.scala 539:45]
  wire  ComplexToReal_1_io_in_valid; // @[FFTSRDesigns.scala 539:45]
  wire [31:0] ComplexToReal_1_io_out; // @[FFTSRDesigns.scala 539:45]
  wire  ComplexToReal_1_io_out_en; // @[FFTSRDesigns.scala 539:45]
  wire  ComplexToReal_1_io_out_valid; // @[FFTSRDesigns.scala 539:45]
  wire  Buffer_FFT_Out_clock; // @[FFTSRDesigns.scala 540:24]
  wire  Buffer_FFT_Out_reset; // @[FFTSRDesigns.scala 540:24]
  wire  Buffer_FFT_Out_io_in_valid; // @[FFTSRDesigns.scala 540:24]
  wire  Buffer_FFT_Out_io_in_ready; // @[FFTSRDesigns.scala 540:24]
  wire  Buffer_FFT_Out_io_in_read_inc; // @[FFTSRDesigns.scala 540:24]
  wire [31:0] Buffer_FFT_Out_io_in_data_0; // @[FFTSRDesigns.scala 540:24]
  wire [31:0] Buffer_FFT_Out_io_in_data_1; // @[FFTSRDesigns.scala 540:24]
  wire  Buffer_FFT_Out_io_out_full; // @[FFTSRDesigns.scala 540:24]
  wire  Buffer_FFT_Out_io_out_valid; // @[FFTSRDesigns.scala 540:24]
  wire [31:0] Buffer_FFT_Out_io_out_data_0; // @[FFTSRDesigns.scala 540:24]
  wire [31:0] Buffer_FFT_Out_io_out_data_1; // @[FFTSRDesigns.scala 540:24]
  SimpleTrnsp_batched SimpleTrnsp_batched ( // @[FFTSRDesigns.scala 534:38]
    .clock(SimpleTrnsp_batched_clock),
    .reset(SimpleTrnsp_batched_reset),
    .io_in_ready(SimpleTrnsp_batched_io_in_ready),
    .io_in_valid(SimpleTrnsp_batched_io_in_valid),
    .io_in_data_0_Re(SimpleTrnsp_batched_io_in_data_0_Re),
    .io_in_data_0_Im(SimpleTrnsp_batched_io_in_data_0_Im),
    .io_in_data_1_Re(SimpleTrnsp_batched_io_in_data_1_Re),
    .io_in_data_1_Im(SimpleTrnsp_batched_io_in_data_1_Im),
    .io_out_ready(SimpleTrnsp_batched_io_out_ready),
    .io_out_valid(SimpleTrnsp_batched_io_out_valid),
    .io_out_data_0_Re(SimpleTrnsp_batched_io_out_data_0_Re),
    .io_out_data_0_Im(SimpleTrnsp_batched_io_out_data_0_Im),
    .io_out_data_1_Re(SimpleTrnsp_batched_io_out_data_1_Re),
    .io_out_data_1_Im(SimpleTrnsp_batched_io_out_data_1_Im)
  );
  SimpleTrnsp_batched_1 SimpleTrnsp_batched_1 ( // @[FFTSRDesigns.scala 535:39]
    .clock(SimpleTrnsp_batched_1_clock),
    .reset(SimpleTrnsp_batched_1_reset),
    .io_in_ready(SimpleTrnsp_batched_1_io_in_ready),
    .io_in_valid(SimpleTrnsp_batched_1_io_in_valid),
    .io_in_data_0_Re(SimpleTrnsp_batched_1_io_in_data_0_Re),
    .io_in_data_0_Im(SimpleTrnsp_batched_1_io_in_data_0_Im),
    .io_in_data_1_Re(SimpleTrnsp_batched_1_io_in_data_1_Re),
    .io_in_data_1_Im(SimpleTrnsp_batched_1_io_in_data_1_Im),
    .io_out_ready(SimpleTrnsp_batched_1_io_out_ready),
    .io_out_valid(SimpleTrnsp_batched_1_io_out_valid),
    .io_out_data_0_Re(SimpleTrnsp_batched_1_io_out_data_0_Re),
    .io_out_data_0_Im(SimpleTrnsp_batched_1_io_out_data_0_Im),
    .io_out_data_1_Re(SimpleTrnsp_batched_1_io_out_data_1_Re),
    .io_out_data_1_Im(SimpleTrnsp_batched_1_io_out_data_1_Im)
  );
  FFT_SingleRadix_Streaming_N8_r2_w2_bw32 FFT_SingleRadix_Streaming_N8_r2_w2_bw32 ( // @[FFTSRDesigns.scala 536:42]
    .clock(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_clock),
    .reset(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_reset),
    .io_in_inv(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_inv),
    .io_in_ready(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_ready),
    .io_in_0_Re(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_0_Re),
    .io_in_0_Im(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_0_Im),
    .io_in_1_Re(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_1_Re),
    .io_in_1_Im(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_1_Im),
    .io_in_valid(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_valid),
    .io_out_valid(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_valid),
    .io_out_0_Re(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_0_Re),
    .io_out_0_Im(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_0_Im),
    .io_out_1_Re(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_1_Re),
    .io_out_1_Im(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_1_Im),
    .io_out_ready(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_ready)
  );
  FFT_SingleRadix_Streaming_N8_r2_w2_bw32 FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1 ( // @[FFTSRDesigns.scala 536:42]
    .clock(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_clock),
    .reset(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_reset),
    .io_in_inv(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_inv),
    .io_in_ready(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_ready),
    .io_in_0_Re(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_0_Re),
    .io_in_0_Im(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_0_Im),
    .io_in_1_Re(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_1_Re),
    .io_in_1_Im(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_1_Im),
    .io_in_valid(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_valid),
    .io_out_valid(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_valid),
    .io_out_0_Re(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_0_Re),
    .io_out_0_Im(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_0_Im),
    .io_out_1_Re(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_1_Re),
    .io_out_1_Im(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_1_Im),
    .io_out_ready(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_ready)
  );
  FFT_SingleRadix_Streaming_N8_r2_w2_bw32 FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2 ( // @[FFTSRDesigns.scala 536:42]
    .clock(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_clock),
    .reset(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_reset),
    .io_in_inv(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_inv),
    .io_in_ready(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_ready),
    .io_in_0_Re(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_0_Re),
    .io_in_0_Im(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_0_Im),
    .io_in_1_Re(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_1_Re),
    .io_in_1_Im(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_1_Im),
    .io_in_valid(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_valid),
    .io_out_valid(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_valid),
    .io_out_0_Re(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_0_Re),
    .io_out_0_Im(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_0_Im),
    .io_out_1_Re(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_1_Re),
    .io_out_1_Im(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_1_Im),
    .io_out_ready(FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_ready)
  );
  SimpleTrnsp_batched_2 SimpleTrnsp_batched_2 ( // @[FFTSRDesigns.scala 537:31]
    .clock(SimpleTrnsp_batched_2_clock),
    .reset(SimpleTrnsp_batched_2_reset),
    .io_in_ready(SimpleTrnsp_batched_2_io_in_ready),
    .io_in_valid(SimpleTrnsp_batched_2_io_in_valid),
    .io_in_data_0_Re(SimpleTrnsp_batched_2_io_in_data_0_Re),
    .io_in_data_0_Im(SimpleTrnsp_batched_2_io_in_data_0_Im),
    .io_in_data_1_Re(SimpleTrnsp_batched_2_io_in_data_1_Re),
    .io_in_data_1_Im(SimpleTrnsp_batched_2_io_in_data_1_Im),
    .io_out_ready(SimpleTrnsp_batched_2_io_out_ready),
    .io_out_valid(SimpleTrnsp_batched_2_io_out_valid),
    .io_out_data_0_Re(SimpleTrnsp_batched_2_io_out_data_0_Re),
    .io_out_data_0_Im(SimpleTrnsp_batched_2_io_out_data_0_Im),
    .io_out_data_1_Re(SimpleTrnsp_batched_2_io_out_data_1_Re),
    .io_out_data_1_Im(SimpleTrnsp_batched_2_io_out_data_1_Im)
  );
  SimpleTrnsp_batched_3 SimpleTrnsp_batched_3 ( // @[FFTSRDesigns.scala 538:31]
    .clock(SimpleTrnsp_batched_3_clock),
    .reset(SimpleTrnsp_batched_3_reset),
    .io_in_ready(SimpleTrnsp_batched_3_io_in_ready),
    .io_in_valid(SimpleTrnsp_batched_3_io_in_valid),
    .io_in_data_0_Re(SimpleTrnsp_batched_3_io_in_data_0_Re),
    .io_in_data_0_Im(SimpleTrnsp_batched_3_io_in_data_0_Im),
    .io_in_data_1_Re(SimpleTrnsp_batched_3_io_in_data_1_Re),
    .io_in_data_1_Im(SimpleTrnsp_batched_3_io_in_data_1_Im),
    .io_out_ready(SimpleTrnsp_batched_3_io_out_ready),
    .io_out_valid(SimpleTrnsp_batched_3_io_out_valid),
    .io_out_data_0_Re(SimpleTrnsp_batched_3_io_out_data_0_Re),
    .io_out_data_0_Im(SimpleTrnsp_batched_3_io_out_data_0_Im),
    .io_out_data_1_Re(SimpleTrnsp_batched_3_io_out_data_1_Re),
    .io_out_data_1_Im(SimpleTrnsp_batched_3_io_out_data_1_Im)
  );
  ComplexToReal ComplexToReal ( // @[FFTSRDesigns.scala 539:45]
    .clock(ComplexToReal_clock),
    .reset(ComplexToReal_reset),
    .io_in_Re(ComplexToReal_io_in_Re),
    .io_in_Im(ComplexToReal_io_in_Im),
    .io_in_en(ComplexToReal_io_in_en),
    .io_in_valid(ComplexToReal_io_in_valid),
    .io_out(ComplexToReal_io_out),
    .io_out_en(ComplexToReal_io_out_en),
    .io_out_valid(ComplexToReal_io_out_valid)
  );
  ComplexToReal ComplexToReal_1 ( // @[FFTSRDesigns.scala 539:45]
    .clock(ComplexToReal_1_clock),
    .reset(ComplexToReal_1_reset),
    .io_in_Re(ComplexToReal_1_io_in_Re),
    .io_in_Im(ComplexToReal_1_io_in_Im),
    .io_in_en(ComplexToReal_1_io_in_en),
    .io_in_valid(ComplexToReal_1_io_in_valid),
    .io_out(ComplexToReal_1_io_out),
    .io_out_en(ComplexToReal_1_io_out_en),
    .io_out_valid(ComplexToReal_1_io_out_valid)
  );
  Buffer_FFT_Out Buffer_FFT_Out ( // @[FFTSRDesigns.scala 540:24]
    .clock(Buffer_FFT_Out_clock),
    .reset(Buffer_FFT_Out_reset),
    .io_in_valid(Buffer_FFT_Out_io_in_valid),
    .io_in_ready(Buffer_FFT_Out_io_in_ready),
    .io_in_read_inc(Buffer_FFT_Out_io_in_read_inc),
    .io_in_data_0(Buffer_FFT_Out_io_in_data_0),
    .io_in_data_1(Buffer_FFT_Out_io_in_data_1),
    .io_out_full(Buffer_FFT_Out_io_out_full),
    .io_out_valid(Buffer_FFT_Out_io_out_valid),
    .io_out_data_0(Buffer_FFT_Out_io_out_data_0),
    .io_out_data_1(Buffer_FFT_Out_io_out_data_1)
  );
  assign io_out_valid = Buffer_FFT_Out_io_out_valid; // @[FFTSRDesigns.scala 586:18]
  assign io_out_ready = SimpleTrnsp_batched_io_out_ready; // @[FFTSRDesigns.scala 588:18]
  assign io_out_0 = Buffer_FFT_Out_io_out_data_0; // @[FFTSRDesigns.scala 587:12]
  assign io_out_1 = Buffer_FFT_Out_io_out_data_1; // @[FFTSRDesigns.scala 587:12]
  assign SimpleTrnsp_batched_clock = clock;
  assign SimpleTrnsp_batched_reset = reset;
  assign SimpleTrnsp_batched_io_in_ready = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_ready & io_in_ready; // @[FFTSRDesigns.scala 542:62]
  assign SimpleTrnsp_batched_io_in_valid = io_in_valid; // @[FFTSRDesigns.scala 544:35]
  assign SimpleTrnsp_batched_io_in_data_0_Re = io_in_0_Re; // @[FFTSRDesigns.scala 545:34]
  assign SimpleTrnsp_batched_io_in_data_0_Im = io_in_0_Im; // @[FFTSRDesigns.scala 545:34]
  assign SimpleTrnsp_batched_io_in_data_1_Re = io_in_1_Re; // @[FFTSRDesigns.scala 545:34]
  assign SimpleTrnsp_batched_io_in_data_1_Im = io_in_1_Im; // @[FFTSRDesigns.scala 545:34]
  assign SimpleTrnsp_batched_1_clock = clock;
  assign SimpleTrnsp_batched_1_reset = reset;
  assign SimpleTrnsp_batched_1_io_in_ready = ComplexToReal_io_out_en & io_in_ready; // @[FFTSRDesigns.scala 570:63]
  assign SimpleTrnsp_batched_1_io_in_valid = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_valid; // @[FFTSRDesigns.scala 572:36]
  assign SimpleTrnsp_batched_1_io_in_data_0_Re = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_0_Re; // @[FFTSRDesigns.scala 573:35]
  assign SimpleTrnsp_batched_1_io_in_data_0_Im = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_0_Im; // @[FFTSRDesigns.scala 573:35]
  assign SimpleTrnsp_batched_1_io_in_data_1_Re = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_1_Re; // @[FFTSRDesigns.scala 573:35]
  assign SimpleTrnsp_batched_1_io_in_data_1_Im = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_1_Im; // @[FFTSRDesigns.scala 573:35]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_clock = clock;
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_reset = reset;
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_inv = io_in_inv; // @[FFTSRDesigns.scala 547:33]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_ready = SimpleTrnsp_batched_2_io_out_ready & io_in_ready; // @[FFTSRDesigns.scala 548:55]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_0_Re = SimpleTrnsp_batched_io_out_data_0_Re; // @[FFTSRDesigns.scala 550:22]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_0_Im = SimpleTrnsp_batched_io_out_data_0_Im; // @[FFTSRDesigns.scala 550:22]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_1_Re = SimpleTrnsp_batched_io_out_data_1_Re; // @[FFTSRDesigns.scala 550:22]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_1_Im = SimpleTrnsp_batched_io_out_data_1_Im; // @[FFTSRDesigns.scala 550:22]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_in_valid = SimpleTrnsp_batched_io_out_valid; // @[FFTSRDesigns.scala 549:28]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_clock = clock;
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_reset = reset;
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_inv = io_in_inv; // @[FFTSRDesigns.scala 547:33]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_ready = SimpleTrnsp_batched_3_io_out_ready & io_in_ready; // @[FFTSRDesigns.scala 557:55]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_0_Re = SimpleTrnsp_batched_2_io_out_data_0_Re; // @[FFTSRDesigns.scala 559:22]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_0_Im = SimpleTrnsp_batched_2_io_out_data_0_Im; // @[FFTSRDesigns.scala 559:22]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_1_Re = SimpleTrnsp_batched_2_io_out_data_1_Re; // @[FFTSRDesigns.scala 559:22]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_1_Im = SimpleTrnsp_batched_2_io_out_data_1_Im; // @[FFTSRDesigns.scala 559:22]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_in_valid = SimpleTrnsp_batched_2_io_out_valid; // @[FFTSRDesigns.scala 558:28]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_clock = clock;
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_reset = reset;
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_inv = io_in_inv; // @[FFTSRDesigns.scala 547:33]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_ready = SimpleTrnsp_batched_1_io_out_ready & io_in_ready; // @[FFTSRDesigns.scala 566:63]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_0_Re = SimpleTrnsp_batched_3_io_out_data_0_Re; // @[FFTSRDesigns.scala 568:22]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_0_Im = SimpleTrnsp_batched_3_io_out_data_0_Im; // @[FFTSRDesigns.scala 568:22]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_1_Re = SimpleTrnsp_batched_3_io_out_data_1_Re; // @[FFTSRDesigns.scala 568:22]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_1_Im = SimpleTrnsp_batched_3_io_out_data_1_Im; // @[FFTSRDesigns.scala 568:22]
  assign FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_in_valid = SimpleTrnsp_batched_3_io_out_valid; // @[FFTSRDesigns.scala 567:28]
  assign SimpleTrnsp_batched_2_clock = clock;
  assign SimpleTrnsp_batched_2_reset = reset;
  assign SimpleTrnsp_batched_2_io_in_ready = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_ready & io_in_ready; // @[FFTSRDesigns.scala 552:55]
  assign SimpleTrnsp_batched_2_io_in_valid = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_valid; // @[FFTSRDesigns.scala 554:28]
  assign SimpleTrnsp_batched_2_io_in_data_0_Re = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 555:27]
  assign SimpleTrnsp_batched_2_io_in_data_0_Im = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 555:27]
  assign SimpleTrnsp_batched_2_io_in_data_1_Re = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 555:27]
  assign SimpleTrnsp_batched_2_io_in_data_1_Im = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 555:27]
  assign SimpleTrnsp_batched_3_clock = clock;
  assign SimpleTrnsp_batched_3_reset = reset;
  assign SimpleTrnsp_batched_3_io_in_ready = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_2_io_out_ready & io_in_ready; // @[FFTSRDesigns.scala 561:55]
  assign SimpleTrnsp_batched_3_io_in_valid = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_valid; // @[FFTSRDesigns.scala 563:28]
  assign SimpleTrnsp_batched_3_io_in_data_0_Re = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_0_Re; // @[FFTSRDesigns.scala 564:27]
  assign SimpleTrnsp_batched_3_io_in_data_0_Im = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_0_Im; // @[FFTSRDesigns.scala 564:27]
  assign SimpleTrnsp_batched_3_io_in_data_1_Re = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_1_Re; // @[FFTSRDesigns.scala 564:27]
  assign SimpleTrnsp_batched_3_io_in_data_1_Im = FFT_SingleRadix_Streaming_N8_r2_w2_bw32_1_io_out_1_Im; // @[FFTSRDesigns.scala 564:27]
  assign ComplexToReal_clock = clock;
  assign ComplexToReal_reset = reset;
  assign ComplexToReal_io_in_Re = SimpleTrnsp_batched_1_io_out_data_0_Re; // @[FFTSRDesigns.scala 578:27]
  assign ComplexToReal_io_in_Im = SimpleTrnsp_batched_1_io_out_data_0_Im; // @[FFTSRDesigns.scala 578:27]
  assign ComplexToReal_io_in_en = ~Buffer_FFT_Out_io_out_full & io_in_ready; // @[FFTSRDesigns.scala 576:50]
  assign ComplexToReal_io_in_valid = SimpleTrnsp_batched_1_io_out_valid; // @[FFTSRDesigns.scala 577:33]
  assign ComplexToReal_1_clock = clock;
  assign ComplexToReal_1_reset = reset;
  assign ComplexToReal_1_io_in_Re = SimpleTrnsp_batched_1_io_out_data_1_Re; // @[FFTSRDesigns.scala 578:27]
  assign ComplexToReal_1_io_in_Im = SimpleTrnsp_batched_1_io_out_data_1_Im; // @[FFTSRDesigns.scala 578:27]
  assign ComplexToReal_1_io_in_en = ~Buffer_FFT_Out_io_out_full & io_in_ready; // @[FFTSRDesigns.scala 576:50]
  assign ComplexToReal_1_io_in_valid = SimpleTrnsp_batched_1_io_out_valid; // @[FFTSRDesigns.scala 577:33]
  assign Buffer_FFT_Out_clock = clock;
  assign Buffer_FFT_Out_reset = reset;
  assign Buffer_FFT_Out_io_in_valid = ComplexToReal_io_out_valid; // @[FFTSRDesigns.scala 583:21]
  assign Buffer_FFT_Out_io_in_ready = io_in_ready; // @[FFTSRDesigns.scala 582:21]
  assign Buffer_FFT_Out_io_in_read_inc = io_in_get_tile; // @[FFTSRDesigns.scala 584:24]
  assign Buffer_FFT_Out_io_in_data_0 = ComplexToReal_io_out; // @[FFTSRDesigns.scala 579:25]
  assign Buffer_FFT_Out_io_in_data_1 = ComplexToReal_1_io_out; // @[FFTSRDesigns.scala 579:25]
endmodule

