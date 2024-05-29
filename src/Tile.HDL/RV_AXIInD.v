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
// Author      : Chris Neely and Farzad Fatollahi
// Date        : Sept 29 2022
// Description : AXI registers for Tile
// File        : RV_AXIInD.v
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module RV_AXIInD #(
  parameter [31:0] ADDR_WIDTH = 8
) (
  input                     aclk,
  input                     aresetn,

  input                     axil_awvalid,
  input   [ADDR_WIDTH-1:0]  axil_awaddr,
  output                    axil_awready,
  input                     axil_wvalid,
  input   [31:0]            axil_wdata,
  input   [3:0]             axil_wstrb,  // Can be ignored for slave AXI4L
  output                    axil_wready,
  output                    axil_bvalid,
  output  [1:0]             axil_bresp,
  input                     axil_bready,
  input                     axil_arvalid,
  input   [ADDR_WIDTH-1:0]  axil_araddr,
  output                    axil_arready,
  output                    axil_rvalid,
  output  [31:0]            axil_rdata,
  output  [1:0]             axil_rresp,
  input                     axil_rready,

  output                mem_en,
  output                mem_we,
  output  [31:0]        mem_addr,
  output  [31:0]        mem_din,
  input   [31:0]        mem_dout,

  output  [7:0]         rv_control,

  output  [31:0]        tile_coordinates,
  input  [31:0]         rxPacketCount,
  input  [31:0]         rxByteCount
);

localparam  ADDR_STAT = 'h0,
            ADDR_CMND = 'h4,
            ADDR_ADDR = 'h8,
            ADDR_DATA = 'hc;

localparam  OP_WRITE =  32'h1,
            OP_READ =   32'h2,
            OP_STATUS = 32'h3,
            OP_RISCV =  32'h4;

wire                    csrAck, csrStatAck, csrEn;
wire      [7:0]         csrStat, csrComOp;
wire      [31:0]        csrAddr, csrDIn, csrDOut;
wire                    status_flag;

TileRegBlock reg_inst(
  .aresetn(                     aresetn),
  .aclk(                        aclk),

  .awaddr(                      axil_awaddr),
  .awvalid(                     axil_awvalid),
  .awready(                     axil_awready),
  .wdata(                       axil_wdata),
  .wstrb(                       axil_wstrb),
  .wvalid(                      axil_wvalid),
  .wready(                      axil_wready),
  .bready(                      axil_bready),
  .bresp(                       axil_bresp),
  .bvalid(                      axil_bvalid),
  .araddr(                      axil_araddr),
  .arvalid(                     axil_arvalid),
  .arready(                     axil_arready),
  .rready(                      axil_rready),
  .rdata(                       axil_rdata),
  .rresp(                       axil_rresp),
  .rvalid(                      axil_rvalid),

  .csrTileStatus_UpdEn           (csrStatAck),
  .csrTileStatus_UpdData         (csrStat),
  .csrTileCommandOp_SwWrNotify   (csrEn),
  .csrTileCommandOp              (csrComOp),
  .csrTileAddr                   (csrAddr),
  .csrTileData                   (csrDIn),
  .csrTileData_UpdEn             (csrAck),
  .csrTileData_UpdData           (csrDOut),
  .csrTileCoordinates_SwWrNotify ( ),

  .csrTileCoordinates            (tile_coordinates),
  .csrTileRxPacketCount_UpdEn    (1'b1),
  .csrTileRxPacketCount_UpdData  (rxPacketCount),
  .csrTileRxByteCount_UpdEn      (1'b1),
  .csrTileRxByteCount_UpdData    (rxByteCount)		      
);

Register #(
  .Width (8)
) stat_inst (
  .Clock   (aclk),
  .Reset   (~aresetn),
  .Set     (1'b0),
  .Enable  (csrEn | status_flag),
  .In      ((status_flag) ? rv_control : 8'hff),    //32'h12501),
  .Out     (csrStat));

assign status_flag =  (csrComOp == OP_STATUS);

Register #(
  .Width(             1)
) statack_inst (
  .Clock(             aclk),
  .Reset(             ~aresetn),
  .Set(               1'b0),
  .Enable(            1'b1),
  .In(                csrEn),
  .Out(               csrStatAck)
);

Register #(
  .Width(             32)
) addr_inst (
  .Clock(             aclk),
  .Reset(             ~aresetn),
  .Set(               1'b0),
  .Enable(            csrEn),
  .In(                csrAddr),
  .Out(               mem_addr)
);

Register #(
  .Width(             32)
) din_inst (
  .Clock(             aclk),
  .Reset(             ~aresetn),
  .Set(               1'b0),
  .Enable(            csrEn),
  .In(                csrDIn),
  .Out(               mem_din)
);

Register #(
  .Width(             32)
) dout_inst (
  .Clock(             aclk),
  .Reset(             ~aresetn),
  .Set(               1'b0),
  .Enable(            csrEn),
  .In(                mem_dout),
  .Out(               csrDOut)
);

Register #(
  .Width(             1)
) ack_inst (
  .Clock(             aclk),
  .Reset(             ~aresetn),
  .Set(               1'b0),
  .Enable(            1'b1),
  .In(                csrEn && ((csrAddr == ADDR_DATA) || (csrComOp == OP_READ))),
  .Out(               csrAck)
);

assign mem_we =       (csrComOp == OP_WRITE);
assign mem_en =       (csrComOp == OP_WRITE) || (csrComOp == OP_READ);


Register #(
  .Width(             8)
) rv_control_inst (
  .Clock(             aclk),
  .Reset(             ~aresetn),
  .Set(               1'b0),
  .Enable(            csrEn && (csrComOp == OP_RISCV)),
  .In(                csrDIn[7:0]),
  .Out(               rv_control)
);

endmodule // RV_AXIInD
