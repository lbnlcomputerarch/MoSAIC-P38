////////////////////////////////////////////////
// Author      : Patricia, Kylie
// Date        : 2024
// Description : ASA accelerator
// File        : acc_asa.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps
import asa_types::*;

module acc_asa#(
   parameter OFFSET_SZ         = 12,
   parameter XY_SZ             =  3,
   parameter NOC_BUFFER_ADDR_W =  8
)(
  //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_line,
   input  logic       clk_ctrl_rst_low,
   input  logic       clk_line_rst_low,
   input  logic       clk_ctrl_rst_high,
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
	output logic        stream_out_TLAST
);


//- MoSAIC Interfaces
logic        stream_in_TVALID_int;
logic [31:0] stream_in_TDATA_int;
logic [ 3:0] stream_in_TKEEP_int;
logic        stream_in_TLAST_int;
logic        stream_in_TREADY_int;

logic        stream_out_TVALID_int;
logic [31:0] stream_out_TDATA_int;
logic [ 3:0] stream_out_TKEEP_int;
logic        stream_out_TLAST_int;
logic        stream_out_TREADY_int;

//-  ASA interfaces
logic req_val;
ASAReqMsg  req_msg;
ASAReqMsg  next_req_msg;
logic resp_val;
logic resp_rdy;
ASARespMsg resp_msg;

//- Decoder/Encoder wires
logic header_out_vld;
logic [31:0] header_out;

noc_buffer_in#(
   .ADDR_W (NOC_BUFFER_ADDR_W)
) noc_buffer(
   .clk_in            (clk_line),
   .clk_in_rst_high   (clk_line_rst_high),
   .clk_in_rst_low    (clk_line_rst_low),
   .clk_out           (clk_ctrl),
   .clk_out_rst_low   (clk_ctrl_rst_low),
   .stream_in_TVALID  (stream_in_TVALID),
   .stream_in_TDATA   (stream_in_TDATA),
   .stream_in_TKEEP   (stream_in_TKEEP),
   .stream_in_TLAST   (stream_in_TLAST),
   .stream_in_TREADY  (stream_in_TREADY),
   .stream_out_TVALID (stream_in_TVALID_int),
   .stream_out_TDATA  (stream_in_TDATA_int),
   .stream_out_TKEEP  (stream_in_TKEEP_int),
   .stream_out_TLAST  (stream_in_TLAST_int),
   .stream_out_TREADY (stream_in_TREADY_int)
);

asa_noc_dec#(
   .XY_SZ     (XY_SZ)
) asa_noc_dec (
   //- Clock and reset
   .clk_ctrl          (clk_ctrl),
   .clk_ctrl_rst_low  (clk_ctrl_rst_low),
   //- Tile identification
   .HsrcId            (HsrcId),
   //- NOC interface
   //- Input Interface: Switch writing to the memory manager
	.stream_in_TVALID  (stream_in_TVALID_int),
	.stream_in_TDATA   (stream_in_TDATA_int),
	.stream_in_TKEEP   (stream_in_TKEEP_int),
	.stream_in_TLAST   (stream_in_TLAST_int),
	.stream_in_TREADY  (stream_in_TREADY_int),
   .header_out        (header_out),
   .header_out_vld    (header_out_vld),
   .req_val           (req_val),
   .req_msg           (req_msg)
);

logic req_val_reg;
always @(posedge clk_ctrl) begin
   if (~clk_ctrl_rst_low) req_val_reg <= 1'b0;
   else if (req_val) req_val_reg <= 1'b1;
end


asa_noc_enc asa_noc_enc(
   //- Clock and reset
   .clk_ctrl          (clk_ctrl),
   .clk_ctrl_rst_low  (clk_ctrl_rst_low),
   //- NOC interface
	.stream_out_TVALID  (stream_out_TVALID_int),
	.stream_out_TDATA   (stream_out_TDATA_int),
	.stream_out_TKEEP   (stream_out_TKEEP_int),
	.stream_out_TLAST   (stream_out_TLAST_int),
	.stream_out_TREADY  (stream_out_TREADY_int),
   .header_out        (header_out),
   .header_out_vld    (header_out_vld),
   .resp_val           (resp_val),
   .resp_msg           (resp_msg)
);

////////////////////////////
// Instantiate Accelerator
////////////////////////////

ASA asa (
   .clk           (clk_ctrl),
   .reset         (clk_ctrl_rst_high),
   .asa_req_val   (req_val_reg), 
   .asa_req_rdy   (req_rdy),  //- Output from acc
   .asa_req_msg   (req_msg),
   .asa_resp_val  (resp_val),
   .asa_resp_rdy  (resp_rdy), //- Input to acc
   .asa_resp_msg  (resp_msg)
);

assign stream_in_TREADY_int = req_rdy;    // Kylie says is a bug
assign resp_rdy = stream_out_TREADY_int;  // Mosaic ready to recive output from ASA

noc_buffer_out#(
   .ADDR_W (NOC_BUFFER_ADDR_W)
) noc_buffer_out(
   .clk_in            (clk_ctrl),
   .clk_in_rst_low    (clk_ctrl_rst_low),
   .clk_in_rst_high   (clk_ctrl_rst_high),
   .clk_out           (clk_line),
   .clk_out_rst_low   (clk_line_rst_low),
   .stream_in_TVALID  (stream_out_TVALID_int),
   .stream_in_TDATA   (stream_out_TDATA_int),
   .stream_in_TKEEP   (stream_out_TKEEP_int),
   .stream_in_TLAST   (stream_out_TLAST_int),
   .stream_in_TREADY  (stream_out_TREADY_int), //- Output
   .stream_out_TVALID (stream_out_TVALID),
   .stream_out_TDATA  (stream_out_TDATA),
   .stream_out_TKEEP  (stream_out_TKEEP),
   .stream_out_TLAST  (stream_out_TLAST),
   .stream_out_TREADY (stream_out_TREADY) //- Input
);


endmodule

