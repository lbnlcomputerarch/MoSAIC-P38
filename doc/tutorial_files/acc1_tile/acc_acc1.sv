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
// Date        : Jun 22 2023
// Description : dummy 
// File        : acc_acc1.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module acc_acc1#(
   parameter OFFSET_SZ         = 12,
   parameter XY_SZ             =  4,
   parameter NOC_BUFFER_ADDR_W =  8
)(
  //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_line,
   input  logic       clk_ctrl_rst_low,
   input  logic       clk_line_rst_low,
   input  logic       clk_line_rst_high, 
   input  logic [(XY_SZ*2)-1:0] HsrcId,     //- Tile identification
   //---NOC interface---//
   //- Input Interface
	input  logic        stream_in_TVALID,
	input  logic [31:0] stream_in_TDATA,
	input  logic [ 3:0] stream_in_TKEEP, 
	input  logic        stream_in_TLAST,
	output logic        stream_in_TREADY,  
   //- Output Interface
	input  logic        stream_out_TREADY,
	output logic        stream_out_TVALID,
	output logic [31:0] stream_out_TDATA,
	output logic [ 3:0] stream_out_TKEEP,
	output logic        stream_out_TLAST,
  //- AXI memory interface 
	input  logic        mem_valid_axi,
	input  logic [31:0] mem_addr_axi,
	input  logic [31:0] mem_wdata_axi, 
	input  logic        mem_wstrb_axi, 
	output logic [31:0] mem_rdata_axi
);

/***************************
* Local parameters for FSMs
****************************/

//- State machine state1
localparam [3:0] IDLE       = 4'd0; //
localparam [3:0] WAIT_SEND  = 4'd6; //

//- State machine state3
localparam [2:0] NOC_IDLE      = 3'd0;
localparam [2:0] NOC_DATA      = 3'd1;


logic        in_mfifoA_en;
logic [2:0]  in_mfifoA_addr;
logic [36:0] in_mfifoA_dout;

logic        in_mfifoB_en;
logic [2:0]  in_mfifoB_addr;
logic [36:0] in_mfifoB_din;
logic [36:0] in_mfifoB_dout;

logic in_mfifo_empty;
logic in_mfifo_full;

logic        stream_in_TVALID_int;
logic [31:0] stream_in_TDATA_int;
logic [ 3:0] stream_in_TKEEP_int; 
logic        stream_in_TLAST_int;
logic        stream_in_TREADY_int; 

//- FSMs
logic [3:0] currentState1; //- NoC input 
logic [2:0] currentState3; //- NoC Output
logic [3:0] nextState1;
logic [1:0] nextState3;

logic noc_send;

logic [31:0] noc_header_in;
logic [31:0] next_noc_header_in;
logic [31:0] noc_data_in;
logic [31:0] next_noc_data_in;

logic [31:0] noc_out_header;
logic [31:0] noc_out_payload;

logic      [XY_SZ-1:0] noc_out_x_dest;
logic      [XY_SZ-1:0] noc_out_y_dest;

//////////////////////////////
// Buffer NoC data
//////////////////////////////


noc_buffer_in noc_buffer_inst(
   .clk_ctrl             (clk_line),
   .clk_line             (clk_line),
   .clk_ctrl_rst_low     (clk_line_rst_low),
   .clk_line_rst_low     (clk_line_rst_low),
   .clk_line_rst_high    (clk_line_rst_high),
   .stream_in_TVALID     (stream_in_TVALID),
   .stream_in_TDATA      (stream_in_TDATA),
   .stream_in_TKEEP      (stream_in_TKEEP),
   .stream_in_TLAST      (stream_in_TLAST),
   .stream_in_TREADY     (stream_in_TREADY),
   .stream_in_TVALID_int (stream_in_TVALID_int),
   .stream_in_TDATA_int  (stream_in_TDATA_int),
   .stream_in_TKEEP_int  (stream_in_TKEEP_int),
   .stream_in_TLAST_int  (stream_in_TLAST_int),
   .stream_in_TREADY_int  (stream_in_TREADY_int)
);

//////////////////////////////
// ACC logic
//////////////////////////////

assign stream_in_TREADY_int = 1'b1; 

endmodule

