////////////////////////////////////////////////
// Author      : Mario 
// Date        : 2024
// Description : Accelerator with FFT
// File        : acc_fft_sw32.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module acc_fft_sw32#(
   parameter OFFSET_SZ         = 12,
   parameter XY_SZ             =  3,
   parameter TYPE              = "FFT",
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
	output logic        stream_out_TLAST,
  //- AXI memory interface
	input  logic        mem_valid_axi,
	input  logic [31:0] mem_addr_axi,
	input  logic [31:0] mem_wdata_axi,
	input  logic        mem_wstrb_axi,
	output logic [31:0] mem_rdata_axi,
	input  logic  [7:0] rvControl
);

localparam [2:0] QPUT = 3'd3;
localparam [2:0] MPUT = 3'd4;
localparam FIFO_WRITE_DEPTH = 65536;
localparam COUNT_WIDTH = 16;
localparam PROG_FULL_THRESH = 5;
localparam FFT_streamingwidth = 32;

logic [COUNT_WIDTH-1:0] header_rd_data_count;
logic [COUNT_WIDTH-1:0] header_wr_data_count;
logic [COUNT_WIDTH-1:0] out_rd_data_count;
logic [COUNT_WIDTH-1:0] out_wr_data_count;

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

logic rvRstN;
assign rvRstN = rvControl[0]; //1'b0;

logic in_fft_en;
logic next_in_fft_en;
logic in_valid;
logic next_in_valid;
logic out_ready;
logic [64*FFT_streamingwidth-1:0] in_data_0;
logic [64*FFT_streamingwidth-1:0] next_in_data_0;
//logic [63:0] in_data_1;
//logic [63:0] next_in_data_1;
logic [64*FFT_streamingwidth-1:0] out_data_0;
//logic [63:0] out_data_1;

logic [9:0] state_in;
logic [9:0] next_state_in;

logic [9:0] state_out;
logic [9:0] next_state_out;

logic [7:0] next_pkt_ctr;
logic [7:0] pkt_ctr;

logic [3:0] pkt_sz_code;

logic header_rd_en;
logic header_wr_en;
logic [31:0] header_dout;
logic [31:0] header_din;
logic [31:0] header_reg;
logic [31:0] next_header_reg;
logic [1:0] next_code;
logic [1:0] code;


logic header_empty;
logic header_full;

logic [5:0] next_dest;
logic [5:0] dest;

logic out_empty;
logic out_full;


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

//////////////////////////////
// FP accelerator
//////////////////////////////

generate
if (TYPE == "FFT") begin
   FFT32w32 FFT (
      .clock         (clk_ctrl),
      .reset         (clk_ctrl_rst_high),
      .io_in_inv     (1'b0),
      .io_in_ready   (in_fft_en),
      .io_in_0_Re    (in_data_0[32*2-1:32*1]                                        ),
      .io_in_0_Im    (in_data_0[32*1-1:32*0]                                        ),
      .io_in_1_Re    (in_data_0[32*4-1:32*3]                                        ),
      .io_in_1_Im    (in_data_0[32*3-1:32*2]                                        ),
      .io_in_2_Re    (in_data_0[32*6-1:32*5]                                        ),
      .io_in_2_Im    (in_data_0[32*5-1:32*4]                                        ),
      .io_in_3_Re    (in_data_0[32*8-1:32*7]                                        ),
      .io_in_3_Im    (in_data_0[32*7-1:32*6]                                        ),
      .io_in_4_Re    (in_data_0[32*8+32*2-1:32*8+32*1]                              ),
      .io_in_4_Im    (in_data_0[32*8+32*1-1:32*8+32*0]                              ),
      .io_in_5_Re    (in_data_0[32*8+32*4-1:32*8+32*3]                              ),
      .io_in_5_Im    (in_data_0[32*8+32*3-1:32*8+32*2]                              ),
      .io_in_6_Re    (in_data_0[32*8+32*6-1:32*8+32*5]                              ),
      .io_in_6_Im    (in_data_0[32*8+32*5-1:32*8+32*4]                              ),
      .io_in_7_Re    (in_data_0[32*8+32*8-1:32*8+32*7]                              ),
      .io_in_7_Im    (in_data_0[32*8+32*7-1:32*8+32*6]                              ),
      .io_in_8_Re    (in_data_0[32*16+32*2-1:32*16+32*1]                            ),
      .io_in_8_Im    (in_data_0[32*16+32*1-1:32*16+32*0]                            ),
      .io_in_9_Re    (in_data_0[32*16+32*4-1:32*16+32*3]                            ),
      .io_in_9_Im    (in_data_0[32*16+32*3-1:32*16+32*2]                            ),
      .io_in_10_Re   (in_data_0[32*16+32*6-1:32*16+32*5]                            ),
      .io_in_10_Im   (in_data_0[32*16+32*5-1:32*16+32*4]                            ),
      .io_in_11_Re   (in_data_0[32*16+32*8-1:32*16+32*7]                            ),
      .io_in_11_Im   (in_data_0[32*16+32*7-1:32*16+32*6]                            ),
      .io_in_12_Re   (in_data_0[32*16+32*8+32*2-1:32*16+32*8+32*1]                  ),
      .io_in_12_Im   (in_data_0[32*16+32*8+32*1-1:32*16+32*8+32*0]                  ),
      .io_in_13_Re   (in_data_0[32*16+32*8+32*4-1:32*16+32*8+32*3]                  ),
      .io_in_13_Im   (in_data_0[32*16+32*8+32*3-1:32*16+32*8+32*2]                  ),
      .io_in_14_Re   (in_data_0[32*16+32*8+32*6-1:32*16+32*8+32*5]                  ),
      .io_in_14_Im   (in_data_0[32*16+32*8+32*5-1:32*16+32*8+32*4]                  ),
      .io_in_15_Re   (in_data_0[32*16+32*8+32*8-1:32*16+32*8+32*7]                  ),
      .io_in_15_Im   (in_data_0[32*16+32*8+32*7-1:32*16+32*8+32*6]                  ),
      .io_in_16_Re   (in_data_0[32*32+32*2-1:32*32+32*1]                            ),
      .io_in_16_Im   (in_data_0[32*32+32*1-1:32*32+32*0]                            ),
      .io_in_17_Re   (in_data_0[32*32+32*4-1:32*32+32*3]                            ),
      .io_in_17_Im   (in_data_0[32*32+32*3-1:32*32+32*2]                            ),
      .io_in_18_Re   (in_data_0[32*32+32*6-1:32*32+32*5]                            ),
      .io_in_18_Im   (in_data_0[32*32+32*5-1:32*32+32*4]                            ),
      .io_in_19_Re   (in_data_0[32*32+32*8-1:32*32+32*7]                            ),
      .io_in_19_Im   (in_data_0[32*32+32*7-1:32*32+32*6]                            ),
      .io_in_20_Re   (in_data_0[32*32+32*8+32*2-1:32*32+32*8+32*1]                  ),
      .io_in_20_Im   (in_data_0[32*32+32*8+32*1-1:32*32+32*8+32*0]                  ),
      .io_in_21_Re   (in_data_0[32*32+32*8+32*4-1:32*32+32*8+32*3]                  ),
      .io_in_21_Im   (in_data_0[32*32+32*8+32*3-1:32*32+32*8+32*2]                  ),
      .io_in_22_Re   (in_data_0[32*32+32*8+32*6-1:32*32+32*8+32*5]                  ),
      .io_in_22_Im   (in_data_0[32*32+32*8+32*5-1:32*32+32*8+32*4]                  ),
      .io_in_23_Re   (in_data_0[32*32+32*8+32*8-1:32*32+32*8+32*7]                  ),
      .io_in_23_Im   (in_data_0[32*32+32*8+32*7-1:32*32+32*8+32*6]                  ),
      .io_in_24_Re   (in_data_0[32*32+32*16+32*2-1:32*32+32*16+32*1]                ),
      .io_in_24_Im   (in_data_0[32*32+32*16+32*1-1:32*32+32*16+32*0]                ),
      .io_in_25_Re   (in_data_0[32*32+32*16+32*4-1:32*32+32*16+32*3]                ),
      .io_in_25_Im   (in_data_0[32*32+32*16+32*3-1:32*32+32*16+32*2]                ),
      .io_in_26_Re   (in_data_0[32*32+32*16+32*6-1:32*32+32*16+32*5]                ),
      .io_in_26_Im   (in_data_0[32*32+32*16+32*5-1:32*32+32*16+32*4]                ),
      .io_in_27_Re   (in_data_0[32*32+32*16+32*8-1:32*32+32*16+32*7]                ),
      .io_in_27_Im   (in_data_0[32*32+32*16+32*7-1:32*32+32*16+32*6]                ),
      .io_in_28_Re   (in_data_0[32*32+32*16+32*8+32*2-1:32*32+32*16+32*8+32*1]      ),
      .io_in_28_Im   (in_data_0[32*32+32*16+32*8+32*1-1:32*32+32*16+32*8+32*0]      ),
      .io_in_29_Re   (in_data_0[32*32+32*16+32*8+32*4-1:32*32+32*16+32*8+32*3]      ),
      .io_in_29_Im   (in_data_0[32*32+32*16+32*8+32*3-1:32*32+32*16+32*8+32*2]      ),
      .io_in_30_Re   (in_data_0[32*32+32*16+32*8+32*6-1:32*32+32*16+32*8+32*5]      ),
      .io_in_30_Im   (in_data_0[32*32+32*16+32*8+32*5-1:32*32+32*16+32*8+32*4]      ),
      .io_in_31_Re   (in_data_0[32*32+32*16+32*8+32*8-1:32*32+32*16+32*8+32*7]      ),
      .io_in_31_Im   (in_data_0[32*32+32*16+32*8+32*7-1:32*32+32*16+32*8+32*6]      ),
      .io_in_valid   (in_valid),
      .io_out_valid  (out_ready),
      .io_out_0_Re      (out_data_0[32*2-1:32*1]                                               ),
      .io_out_0_Im      (out_data_0[32*1-1:32*0]                                               ),
      .io_out_1_Re      (out_data_0[32*4-1:32*3]                                               ),
      .io_out_1_Im      (out_data_0[32*3-1:32*2]                                               ),
      .io_out_2_Re      (out_data_0[32*6-1:32*5]                                               ),
      .io_out_2_Im      (out_data_0[32*5-1:32*4]                                               ),
      .io_out_3_Re      (out_data_0[32*8-1:32*7]                                               ),
      .io_out_3_Im      (out_data_0[32*7-1:32*6]                                               ),
      .io_out_4_Re      (out_data_0[32*8+32*2-1:32*8+32*1]                                     ),
      .io_out_4_Im      (out_data_0[32*8+32*1-1:32*8+32*0]                                     ),
      .io_out_5_Re      (out_data_0[32*8+32*4-1:32*8+32*3]                                     ),
      .io_out_5_Im      (out_data_0[32*8+32*3-1:32*8+32*2]                                     ),
      .io_out_6_Re      (out_data_0[32*8+32*6-1:32*8+32*5]                                     ),
      .io_out_6_Im      (out_data_0[32*8+32*5-1:32*8+32*4]                                     ),
      .io_out_7_Re      (out_data_0[32*8+32*8-1:32*8+32*7]                                     ),
      .io_out_7_Im      (out_data_0[32*8+32*7-1:32*8+32*6]                                     ),
      .io_out_8_Re      (out_data_0[32*16+32*2-1:32*16+32*1]                                   ),
      .io_out_8_Im      (out_data_0[32*16+32*1-1:32*16+32*0]                                   ),
      .io_out_9_Re      (out_data_0[32*16+32*4-1:32*16+32*3]                                   ),
      .io_out_9_Im      (out_data_0[32*16+32*3-1:32*16+32*2]                                   ),
      .io_out_10_Re     (out_data_0[32*16+32*6-1:32*16+32*5]                                   ),
      .io_out_10_Im     (out_data_0[32*16+32*5-1:32*16+32*4]                                   ),
      .io_out_11_Re     (out_data_0[32*16+32*8-1:32*16+32*7]                                   ),
      .io_out_11_Im     (out_data_0[32*16+32*7-1:32*16+32*6]                                   ),
      .io_out_12_Re     (out_data_0[32*16+32*8+32*2-1:32*16+32*8+32*1]                         ),
      .io_out_12_Im     (out_data_0[32*16+32*8+32*1-1:32*16+32*8+32*0]                         ),
      .io_out_13_Re     (out_data_0[32*16+32*8+32*4-1:32*16+32*8+32*3]                         ),
      .io_out_13_Im     (out_data_0[32*16+32*8+32*3-1:32*16+32*8+32*2]                         ),
      .io_out_14_Re     (out_data_0[32*16+32*8+32*6-1:32*16+32*8+32*5]                         ),
      .io_out_14_Im     (out_data_0[32*16+32*8+32*5-1:32*16+32*8+32*4]                         ),
      .io_out_15_Re     (out_data_0[32*16+32*8+32*8-1:32*16+32*8+32*7]                         ),
      .io_out_15_Im     (out_data_0[32*16+32*8+32*7-1:32*16+32*8+32*6]                         ),
      .io_out_16_Re     (out_data_0[32*32+32*2-1:32*32+32*1]                                   ),
      .io_out_16_Im     (out_data_0[32*32+32*1-1:32*32+32*0]                                   ),
      .io_out_17_Re     (out_data_0[32*32+32*4-1:32*32+32*3]                                   ),
      .io_out_17_Im     (out_data_0[32*32+32*3-1:32*32+32*2]                                   ),
      .io_out_18_Re     (out_data_0[32*32+32*6-1:32*32+32*5]                                   ),
      .io_out_18_Im     (out_data_0[32*32+32*5-1:32*32+32*4]                                   ),
      .io_out_19_Re     (out_data_0[32*32+32*8-1:32*32+32*7]                                   ),
      .io_out_19_Im     (out_data_0[32*32+32*7-1:32*32+32*6]                                   ),
      .io_out_20_Re     (out_data_0[32*32+32*8+32*2-1:32*32+32*8+32*1]                         ),
      .io_out_20_Im     (out_data_0[32*32+32*8+32*1-1:32*32+32*8+32*0]                         ),
      .io_out_21_Re     (out_data_0[32*32+32*8+32*4-1:32*32+32*8+32*3]                         ),
      .io_out_21_Im     (out_data_0[32*32+32*8+32*3-1:32*32+32*8+32*2]                         ),
      .io_out_22_Re     (out_data_0[32*32+32*8+32*6-1:32*32+32*8+32*5]                         ),
      .io_out_22_Im     (out_data_0[32*32+32*8+32*5-1:32*32+32*8+32*4]                         ),
      .io_out_23_Re     (out_data_0[32*32+32*8+32*8-1:32*32+32*8+32*7]                         ),
      .io_out_23_Im     (out_data_0[32*32+32*8+32*7-1:32*32+32*8+32*6]                         ),
      .io_out_24_Re     (out_data_0[32*32+32*16+32*2-1:32*32+32*16+32*1]                       ),
      .io_out_24_Im     (out_data_0[32*32+32*16+32*1-1:32*32+32*16+32*0]                       ),
      .io_out_25_Re     (out_data_0[32*32+32*16+32*4-1:32*32+32*16+32*3]                       ),
      .io_out_25_Im     (out_data_0[32*32+32*16+32*3-1:32*32+32*16+32*2]                       ),
      .io_out_26_Re     (out_data_0[32*32+32*16+32*6-1:32*32+32*16+32*5]                       ),
      .io_out_26_Im     (out_data_0[32*32+32*16+32*5-1:32*32+32*16+32*4]                       ),
      .io_out_27_Re     (out_data_0[32*32+32*16+32*8-1:32*32+32*16+32*7]                       ),
      .io_out_27_Im     (out_data_0[32*32+32*16+32*7-1:32*32+32*16+32*6]                       ),
      .io_out_28_Re     (out_data_0[32*32+32*16+32*8+32*2-1:32*32+32*16+32*8+32*1]             ),
      .io_out_28_Im     (out_data_0[32*32+32*16+32*8+32*1-1:32*32+32*16+32*8+32*0]             ),
      .io_out_29_Re     (out_data_0[32*32+32*16+32*8+32*4-1:32*32+32*16+32*8+32*3]             ),
      .io_out_29_Im     (out_data_0[32*32+32*16+32*8+32*3-1:32*32+32*16+32*8+32*2]             ),
      .io_out_30_Re     (out_data_0[32*32+32*16+32*8+32*6-1:32*32+32*16+32*8+32*5]             ),
      .io_out_30_Im     (out_data_0[32*32+32*16+32*8+32*5-1:32*32+32*16+32*8+32*4]             ),
      .io_out_31_Re     (out_data_0[32*32+32*16+32*8+32*8-1:32*32+32*16+32*8+32*7]             ),
      .io_out_31_Im     (out_data_0[32*32+32*16+32*8+32*7-1:32*32+32*16+32*8+32*6]             )


      );
end

logic out_almost_full;
logic header_almost_full;

always @(*) begin
   next_in_fft_en = in_fft_en;
   next_state_in = state_in;
   next_header_reg = header_reg;
   next_code = code;
   next_dest = dest;

   header_wr_en = 1'b0;
   header_din = 'h0;

   // in_valid = 1'b0;
   next_in_valid = 1'b0;
   next_in_data_0 = in_data_0;
//   next_in_data_1 = in_data_1;

   stream_in_TREADY_int = 1'b1;

   case (state_in)
      0: begin // so if noc out can receive inputs and header or data buf not near full
         if (stream_out_TREADY_int & ~header_almost_full & ~out_almost_full) begin
            if (stream_in_TVALID_int) begin // we have valid in from noc in
               if(stream_in_TDATA_int[28] == 1'b0) begin // if short packet
                   next_state_in = 'h43;
               end else if (in_fft_en) begin // else if long packet
                   next_header_reg = stream_in_TDATA_int; // it is the first part of header
                   next_state_in = 'h1;
               end
            end
         end else stream_in_TREADY_int = 1'b0;
      end
      1:begin //- Second part of the header
         //31,30,29,28 - 27,26,25,24 - 23,22,21,20 - 19,18,17,16 - 15,14,13,12
         //11,10,9,8   -  7,6,5,4    -  3,2,1,0
         if (stream_in_TVALID_int) begin // modify for short packet
            header_wr_en = 1'b1;
            if (stream_in_TDATA_int[9:8] == 2'b01) begin //- Forward // if we have an MPUT
               header_din = {3'h0,1'b1,MPUT,1'b0,HsrcId,6'h0,pkt_sz_code,2'h0,stream_in_TDATA_int[5:0]};
               next_code = 2'b10;
               next_dest = header_reg[23:18]; // we send back to the source
//               next_dest = header_reg[23:18]; // we send back to the source
            end else if (stream_in_TDATA_int[9:8] == 2'b10) begin //- Final send to pico // QPUT handling
               header_din = {3'h0,1'b1,QPUT,1'b0,HsrcId,6'h0,pkt_sz_code,2'h0,stream_in_TDATA_int[5:0]};
               next_code = 2'b00;
               next_dest = 'h0;
            end else begin //- Default: send back to pico // Loops
//               header_din = 32'b000_1_100_0_001_001_000000_0110_00_010_000;
               header_din = {3'h0,1'b1,MPUT,1'b0,HsrcId,6'h0,pkt_sz_code,2'h0,6'b000_000};
               next_code = 2'b00;
//               next_dest = 6'b010_000;
               next_dest = 6'b000_000;
            end
            next_state_in = 'h2;
         end
      end
      2: begin
         if (stream_in_TVALID_int) begin
            header_wr_en = 1'b1;
//            header_din = 32'b0000_0000_0000_00_010_000_0000_0000_0000; //- Write second part of the header.
            header_din = {20'h0,code,2'h0,dest}; //- Write second part of the header.
            next_in_data_0[32*2-1:32*1] = stream_in_TDATA_int; // finally get first part of data
            next_state_in = 'h3;
         end
      end
      3: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*1-1:32*0] = stream_in_TDATA_int;
            next_state_in = 'h4;
         end
      end
      4: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*4-1:32*3] = stream_in_TDATA_int;
            next_state_in = 'h5;
         end
      end
      5: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*3-1:32*2] = stream_in_TDATA_int;
            next_state_in = 'h6;
         end
      end
      6: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*6-1:32*5] = stream_in_TDATA_int;
            next_state_in = 'h7;
         end
      end
      7: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*5-1:32*4] = stream_in_TDATA_int;
            next_state_in = 'h8;
         end
      end
      8: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*8-1:32*7] = stream_in_TDATA_int;
            next_state_in = 'h9;
         end
      end
      9: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*7-1:32*6] = stream_in_TDATA_int;
            next_state_in = 'ha;
         end
      end
      10: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*10-1:32*9] = stream_in_TDATA_int;
            next_state_in = 'hb;
         end
      end
      11: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*9-1:32*8] = stream_in_TDATA_int;
            next_state_in = 'hc;
         end
      end
      12: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*12-1:32*11] = stream_in_TDATA_int;
            next_state_in = 'hd;
         end
      end
      13: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*11-1:32*10] = stream_in_TDATA_int;
            next_state_in = 'he;
         end
      end
      14: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*14-1:32*13] = stream_in_TDATA_int;
            next_state_in = 'hf;
         end
      end
      15: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*13-1:32*12] = stream_in_TDATA_int;
            next_state_in = 'h10;
         end
      end
      16: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*16-1:32*15] = stream_in_TDATA_int;
            next_state_in = 'h11;
         end
      end
      17: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*15-1:32*14] = stream_in_TDATA_int;
            next_state_in = 'h12;
         end
      end
      18: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*18-1:32*17] = stream_in_TDATA_int;
            next_state_in = 'h13;
         end
      end
      19: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*17-1:32*16] = stream_in_TDATA_int;
            next_state_in = 'h14;
         end
      end
      20: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*20-1:32*19] = stream_in_TDATA_int;
            next_state_in = 'h15;
         end
      end
      21: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*19-1:32*18] = stream_in_TDATA_int;
            next_state_in = 'h16;
         end
      end
      22: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*22-1:32*21] = stream_in_TDATA_int;
            next_state_in = 'h17;
         end
      end
      23: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*21-1:32*20] = stream_in_TDATA_int;
            next_state_in = 'h18;
         end
      end
      24: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*24-1:32*23] = stream_in_TDATA_int;
            next_state_in = 'h19;
         end
      end
      25: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*23-1:32*22] = stream_in_TDATA_int;
            next_state_in = 'h1a;
         end
      end
      26: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*26-1:32*25] = stream_in_TDATA_int;
            next_state_in = 'h1b;
         end
      end
      27: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*25-1:32*24] = stream_in_TDATA_int;
            next_state_in = 'h1c;
         end
      end
      28: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*28-1:32*27] = stream_in_TDATA_int;
            next_state_in = 'h1d;
         end
      end
      29: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*27-1:32*26] = stream_in_TDATA_int;
            next_state_in = 'h1e;
         end
      end
      30: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*30-1:32*29] = stream_in_TDATA_int;
            next_state_in = 'h1f;
         end
      end
      31: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*29-1:32*28] = stream_in_TDATA_int;
            next_state_in = 'h20;
         end
      end
      32: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*32-1:32*31] = stream_in_TDATA_int;
            next_state_in = 'h21;
         end
      end
      33: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*31-1:32*30] = stream_in_TDATA_int;
            next_state_in = 'h22;
         end
      end
      34: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*34-1:32*33] = stream_in_TDATA_int;
            next_state_in = 'h23;
         end
      end
      35: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*33-1:32*32] = stream_in_TDATA_int;
            next_state_in = 'h24;
         end
      end
      36: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*36-1:32*35] = stream_in_TDATA_int;
            next_state_in = 'h25;
         end
      end
      37: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*35-1:32*34] = stream_in_TDATA_int;
            next_state_in = 'h26;
         end
      end
      38: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*38-1:32*37] = stream_in_TDATA_int;
            next_state_in = 'h27;
         end
      end
      39: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*37-1:32*36] = stream_in_TDATA_int;
            next_state_in = 'h28;
         end
      end
      40: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*40-1:32*39] = stream_in_TDATA_int;
            next_state_in = 'h29;
         end
      end
      41: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*39-1:32*38] = stream_in_TDATA_int;
            next_state_in = 'h2a;
         end
      end
      42: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*42-1:32*41] = stream_in_TDATA_int;
            next_state_in = 'h2b;
         end
      end
      43: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*41-1:32*40] = stream_in_TDATA_int;
            next_state_in = 'h2c;
         end
      end
      44: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*44-1:32*43] = stream_in_TDATA_int;
            next_state_in = 'h2d;
         end
      end
      45: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*43-1:32*42] = stream_in_TDATA_int;
            next_state_in = 'h2e;
         end
      end
      46: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*46-1:32*45] = stream_in_TDATA_int;
            next_state_in = 'h2f;
         end
      end
      47: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*45-1:32*44] = stream_in_TDATA_int;
            next_state_in = 'h30;
         end
      end
      48: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*48-1:32*47] = stream_in_TDATA_int;
            next_state_in = 'h31;
         end
      end
      49: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*47-1:32*46] = stream_in_TDATA_int;
            next_state_in = 'h32;
         end
      end
      50: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*50-1:32*49] = stream_in_TDATA_int;
            next_state_in = 'h33;
         end
      end
      51: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*49-1:32*48] = stream_in_TDATA_int;
            next_state_in = 'h34;
         end
      end
      52: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*52-1:32*51] = stream_in_TDATA_int;
            next_state_in = 'h35;
         end
      end
      53: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*51-1:32*50] = stream_in_TDATA_int;
            next_state_in = 'h36;
         end
      end
      54: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*54-1:32*53] = stream_in_TDATA_int;
            next_state_in = 'h37;
         end
      end
      55: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*53-1:32*52] = stream_in_TDATA_int;
            next_state_in = 'h38;
         end
      end
      56: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*56-1:32*55] = stream_in_TDATA_int;
            next_state_in = 'h39;
         end
      end
      57: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*55-1:32*54] = stream_in_TDATA_int;
            next_state_in = 'h3a;
         end
      end
      58: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*58-1:32*57] = stream_in_TDATA_int;
            next_state_in = 'h3b;
         end
      end
      59: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*57-1:32*56] = stream_in_TDATA_int;
            next_state_in = 'h3c;
         end
      end
      60: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*60-1:32*59] = stream_in_TDATA_int;
            next_state_in = 'h3d;
         end
      end
      61: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*59-1:32*58] = stream_in_TDATA_int;
            next_state_in = 'h3e;
         end
      end
      62: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*62-1:32*61] = stream_in_TDATA_int;
            next_state_in = 'h3f;
         end
      end
      63: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*61-1:32*60] = stream_in_TDATA_int;
            next_state_in = 'h40;
         end
      end
      64: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*64-1:32*63] = stream_in_TDATA_int;
            next_state_in = 'h41;
         end
      end
      65: begin
         if (stream_in_TVALID_int) begin //- Finish this last one anyway
            next_in_valid = 1'b1;
            next_in_data_0[32*63-1:32*62] = stream_in_TDATA_int;
            if (stream_in_TLAST_int)
               next_state_in = 'h0;
            else
               next_state_in = 'h42;
         end
      end
      66: begin
         if (stream_in_TVALID_int) begin
            next_in_data_0[32*2-1:32*1] = stream_in_TDATA_int;
            next_state_in = 'h3;
         end
      end
      67: begin
         if (stream_in_TVALID_int) begin
            if(stream_in_TDATA_int == 32'h8000_0000) begin // enable the fft
                next_in_fft_en = !in_fft_en;
            end
            next_state_in = 'h0;
         end
      end
   endcase
end


if (TYPE == "SQRT")
   assign pkt_sz_code = header_reg[11:8];
else
   assign pkt_sz_code = header_reg[11:8]; // depnds on desired packet size output

endgenerate


//- Like a NoC decoder
always @(posedge clk_ctrl) begin
   if (~clk_ctrl_rst_low) begin
      state_in <= 'h0;
      in_data_0 <= 'h0;
//      in_data_1 <= 'h0;
      header_reg <= 'h0;
      code <= 'h0;
      dest <= 'h0;
      in_valid <= 1'b0;
      in_fft_en <= 1'b0;
   end else begin
      dest <= next_dest;
      code <= next_code;
      header_reg <= next_header_reg;
      state_in  <= next_state_in;
      in_data_0 <= next_in_data_0;
//      in_data_1 <= next_in_data_1;
      in_valid <= next_in_valid;
      in_fft_en <= next_in_fft_en;
   end
end

//- Like a NoC encoder


logic [64*FFT_streamingwidth-1:0] out_dout;
logic out_rd_en;

always @(posedge clk_ctrl) begin
   if (~clk_ctrl_rst_low) begin
      state_out    <= 'h0;
      pkt_ctr      <= 'h0;
   end else begin
      state_out    <= next_state_out;
      pkt_ctr      <= next_pkt_ctr;
   end
end



always @(*) begin
   next_state_out = state_out;
   next_pkt_ctr = pkt_ctr;

   header_rd_en = 1'b0;
   out_rd_en = 1'b0;

   stream_out_TVALID_int = 1'b0;
   stream_out_TDATA_int  =  'h0;
   stream_out_TKEEP_int  =  'h0;
   stream_out_TLAST_int  = 1'b0;

   case (state_out)
      0: begin
         if (stream_out_TREADY_int) begin
            if (~out_empty) begin
               header_rd_en   = 1'b1;
               next_state_out = 1;
            end
         end
      end
      1: begin
         if (stream_out_TREADY_int) begin
            header_rd_en   = 1'b1;
            stream_out_TVALID_int = 1'b1;
            stream_out_TDATA_int  = header_dout;
            stream_out_TKEEP_int  = 'hFFFF;
            next_pkt_ctr          = 1 << header_dout[11:8] - 6;
            next_state_out        = 2;
         end
      end
      2: begin
         if (stream_out_TREADY_int) begin
            out_rd_en        = 1'b1;
            stream_out_TVALID_int = 1'b1;
            stream_out_TDATA_int  = header_dout;
            stream_out_TKEEP_int  = 'hFFFF;
            next_state_out        = 3;
         end
      end
      3: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*1-1:32*0];
            next_state_out = 4;
         end
      end
      4: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*2-1:32*1];
            next_state_out = 5;
         end
      end
      5: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*3-1:32*2];
            next_state_out = 6;
         end
      end
      6: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*4-1:32*3];
            next_state_out = 7;
         end
      end
      7: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*5-1:32*4];
            next_state_out = 8;
         end
      end
      8: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*6-1:32*5];
            next_state_out = 9;
         end
      end
      9: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*7-1:32*6];
            next_state_out = 10;
         end
      end
      10: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*8-1:32*7];
            next_state_out = 11;
         end
      end
      11: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*9-1:32*8];
            next_state_out = 12;
         end
      end
      12: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*10-1:32*9];
            next_state_out = 13;
         end
      end
      13: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*11-1:32*10];
            next_state_out = 14;
         end
      end
      14: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*12-1:32*11];
            next_state_out = 15;
         end
      end
      15: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*13-1:32*12];
            next_state_out = 16;
         end
      end
      16: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*14-1:32*13];
            next_state_out = 17;
         end
      end
      17: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*15-1:32*14];
            next_state_out = 18;
         end
      end
      18: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*16-1:32*15];
            next_state_out = 19;
         end
      end
      19: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*17-1:32*16];
            next_state_out = 20;
         end
      end
      20: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*18-1:32*17];
            next_state_out = 21;
         end
      end
      21: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*19-1:32*18];
            next_state_out = 22;
         end
      end
      22: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*20-1:32*19];
            next_state_out = 23;
         end
      end
      23: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*21-1:32*20];
            next_state_out = 24;
         end
      end
      24: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*22-1:32*21];
            next_state_out = 25;
         end
      end
      25: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*23-1:32*22];
            next_state_out = 26;
         end
      end
      26: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*24-1:32*23];
            next_state_out = 27;
         end
      end
      27: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*25-1:32*24];
            next_state_out = 28;
         end
      end
      28: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*26-1:32*25];
            next_state_out = 29;
         end
      end
      29: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*27-1:32*26];
            next_state_out = 30;
         end
      end
      30: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*28-1:32*27];
            next_state_out = 31;
         end
      end
      31: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*29-1:32*28];
            next_state_out = 32;
         end
      end
      32: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*30-1:32*29];
            next_state_out = 33;
         end
      end
      33: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*31-1:32*30];
            next_state_out = 34;
         end
      end
      34: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*32-1:32*31];
            next_state_out = 35;
         end
      end
      35: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*31-1:32*30];
            next_state_out = 36;
         end
      end
      36: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*32-1:32*31];
            next_state_out = 37;
         end
      end
      37: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*33-1:32*32];
            next_state_out = 38;
         end
      end
      38: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*34-1:32*33];
            next_state_out = 39;
         end
      end
      39: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*35-1:32*34];
            next_state_out = 40;
         end
      end
      40: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*36-1:32*35];
            next_state_out = 41;
         end
      end
      41: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*37-1:32*36];
            next_state_out = 42;
         end
      end
      42: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*38-1:32*37];
            next_state_out = 43;
         end
      end
      43: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*39-1:32*38];
            next_state_out = 44;
         end
      end
      44: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*40-1:32*39];
            next_state_out = 45;
         end
      end
      45: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*41-1:32*40];
            next_state_out = 46;
         end
      end
      46: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*42-1:32*41];
            next_state_out = 47;
         end
      end
      47: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*43-1:32*42];
            next_state_out = 48;
         end
      end
      48: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*44-1:32*43];
            next_state_out = 49;
         end
      end
      49: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*45-1:32*44];
            next_state_out = 50;
         end
      end
      50: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*46-1:32*45];
            next_state_out = 51;
         end
      end
      51: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*47-1:32*46];
            next_state_out = 52;
         end
      end
      52: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*48-1:32*47];
            next_state_out = 53;
         end
      end
      53: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*49-1:32*48];
            next_state_out = 54;
         end
      end
      54: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*50-1:32*49];
            next_state_out = 55;
         end
      end
      55: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*51-1:32*50];
            next_state_out = 56;
         end
      end
      56: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*52-1:32*51];
            next_state_out = 57;
         end
      end
      57: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*53-1:32*52];
            next_state_out = 58;
         end
      end
      58: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*54-1:32*53];
            next_state_out = 59;
         end
      end
      59: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*55-1:32*54];
            next_state_out = 60;
         end
      end
      60: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*56-1:32*55];
            next_state_out = 61;
         end
      end
      61: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*57-1:32*56];
            next_state_out = 62;
         end
      end
      62: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*58-1:32*57];
            next_state_out = 63;
         end
      end
      63: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*59-1:32*58];
            next_state_out = 64;
         end
      end
      64: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*60-1:32*59];
            next_state_out = 65;
         end
      end
      65: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*61-1:32*60];
            next_state_out = 66;
         end
      end
      66: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*62-1:32*61];
            next_state_out = 67;
         end
      end
      67: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*63-1:32*62];
            next_state_out = 68;
         end
      end
      68: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[32*64-1:32*63];
            next_pkt_ctr = pkt_ctr - 1;
            if (pkt_ctr == 'h1) begin // we have all of our packets
               stream_out_TLAST_int = 1'b1;
               next_state_out = 0;
            end else if (~out_empty) begin
               out_rd_en = 1'b1;
               next_state_out = 3; // keep reading out data
            end else next_state_out = 69;
         end
      end
      69: begin
         if (~out_empty) begin
            out_rd_en = 1'b1;
            next_state_out = 3;
         end
      end
   endcase
end

//- FIXME: This fifos are too big
xpm_fifo_sync #(
   .CASCADE_HEIGHT      (0),        // DECIMAL
   .DOUT_RESET_VALUE    ("0"),    // String
   .ECC_MODE            ("no_ecc"),       // String
   .FIFO_MEMORY_TYPE    ("auto"), // String
   .FIFO_READ_LATENCY   (1),     // DECIMAL
   .FIFO_WRITE_DEPTH    (FIFO_WRITE_DEPTH),   // DECIMAL
   .FULL_RESET_VALUE    (0),      // DECIMAL
   .PROG_EMPTY_THRESH   (),    // DECIMAL
   .PROG_FULL_THRESH    (PROG_FULL_THRESH),     // DECIMAL
   .RD_DATA_COUNT_WIDTH (COUNT_WIDTH),   // DECIMAL
   .READ_DATA_WIDTH     (32),      // DECIMAL
   .READ_MODE           ("std"),         // String
   .SIM_ASSERT_CHK      (0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
   .USE_ADV_FEATURES    ("070f"), // String
   .WAKEUP_TIME         (0),           // DECIMAL
   .WRITE_DATA_WIDTH    (32),     // DECIMAL
   .WR_DATA_COUNT_WIDTH (COUNT_WIDTH)    // DECIMAL
) xpm_fifo_sync_header (
   .almost_empty  (),
   .almost_full   (header_almost_full),
   .data_valid    (),
   .dbiterr       (),
   .dout          (header_dout),
   .empty         (header_empty),
   .full          (header_full),
   .overflow      (),
   .prog_empty    (),
   .prog_full     (),
   .rd_data_count (header_rd_data_count),
   .rd_rst_busy   (),
   .sbiterr       (),
   .underflow     (),
   .wr_ack        (),
   .wr_data_count (header_wr_data_count),
   .wr_rst_busy   (),
   .din           (header_din),
   .injectdbiterr (1'b0),
   .injectsbiterr (1'b0),
   .rd_en         (header_rd_en),
   .rst           (clk_ctrl_rst_high),
   .sleep         (1'b0),
   .wr_clk        (clk_ctrl),
   .wr_en         (header_wr_en)
);

xpm_fifo_sync #(
   .CASCADE_HEIGHT      (0),        // DECIMAL
   .DOUT_RESET_VALUE    ("0"),    // String
   .ECC_MODE            ("no_ecc"),       // String
   .FIFO_MEMORY_TYPE    ("auto"), // String
   .FIFO_READ_LATENCY   (1),     // DECIMAL
   .FIFO_WRITE_DEPTH    (FIFO_WRITE_DEPTH),   // DECIMAL
   .FULL_RESET_VALUE    (0),      // DECIMAL
   .PROG_EMPTY_THRESH   (),    // DECIMAL
   .PROG_FULL_THRESH    (PROG_FULL_THRESH),     // DECIMAL
   .RD_DATA_COUNT_WIDTH (COUNT_WIDTH),   // DECIMAL
   .READ_DATA_WIDTH     (64*FFT_streamingwidth),      // DECIMAL
   .READ_MODE           ("std"),         // String
   .SIM_ASSERT_CHK      (0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
   .USE_ADV_FEATURES    ("070f"), // String
   .WAKEUP_TIME         (0),           // DECIMAL
   .WRITE_DATA_WIDTH    (64*FFT_streamingwidth),     // DECIMAL
   .WR_DATA_COUNT_WIDTH (COUNT_WIDTH)    // DECIMAL
) xpm_fifo_sync_output (
   .almost_empty  (),
   .almost_full   (out_almost_full),
   .data_valid    (),
   .dbiterr       (),
   .dout          (out_dout),
   .empty         (out_empty),
   .full          (out_full),
   .overflow      (),
   .prog_empty    (),
   .prog_full     (),
   .rd_data_count (out_rd_data_count),
   .rd_rst_busy   (),
   .sbiterr       (),
   .underflow     (),
   .wr_ack        (),
   .wr_data_count (out_wr_data_count),
   .wr_rst_busy   (),
   .din           (out_data_0),
   .injectdbiterr (1'b0),
   .injectsbiterr (1'b0),
   .rd_en         (out_rd_en),
   .rst           (clk_ctrl_rst_high),
   .sleep         (1'b0),
   .wr_clk        (clk_ctrl),
   .wr_en         (out_ready)
);


//////////////////////////////
// Buffer NoC data
//////////////////////////////

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
