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
// Description : Instantiate Fast Fourier 
//               Transform (FFT) accelerator
// File        : acc_fft.sv
// Notes       : 
//    - Derived from FP units
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module acc_fft#(
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
logic in_get_tile;
logic next_in_get_tile;
logic out_fft_fulln;
logic [63:0] in_data_0;
logic [63:0] next_in_data_0;
logic [63:0] in_data_1;
logic [63:0] next_in_data_1;
logic [63:0] out_data_0;

logic [2:0] state_in;
logic [2:0] next_state_in;

logic [3:0] state_out;
logic [3:0] next_state_out;

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

logic [11:0] spad_offst;
logic [11:0] next_spad_offst;



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
   Batched3DFFT8_RealOutv6 FFT (
      .clock         (clk_ctrl),
      .reset         (clk_ctrl_rst_high),
      .io_in_inv     (1'b0),
      .io_in_ready   (in_fft_en),
      .io_in_0_Re    (in_data_0[63:32]),
      .io_in_0_Im    (in_data_0[31:0] ),
      .io_in_1_Re    (in_data_1[63:32]),
      .io_in_1_Im    (in_data_1[31:0] ),
      .io_in_valid   (in_valid),
      .io_in_get_tile(in_get_tile),
      .io_out_valid  (out_ready),
      .io_out_ready  (out_fft_fulln),
      .io_out_0      (out_data_0[31:0]),
      .io_out_1      (out_data_0[63:32]));
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
   next_in_data_1 = in_data_1;

   stream_in_TREADY_int = 1'b1;

   if(!out_fft_fulln && in_get_tile && in_fft_en) begin
       next_in_get_tile = 1'b0;
   end else begin
       next_in_get_tile = in_get_tile;
   end


   case (state_in)
      0: begin // so if noc out can receive inputs and header or data buf not near full
         if (stream_out_TREADY_int & ~header_almost_full & ~out_almost_full) begin
            if (stream_in_TVALID_int) begin // we have valid in from noc in
               if(stream_in_TDATA_int[28] == 1'b0) begin
                   next_state_in = 'h7;
               end else if (in_fft_en) begin
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
               header_din = {3'h0,1'b1,MPUT,1'b0,HsrcId,6'h0,pkt_sz_code,2'h0,6'b010_000};
               next_code = 2'b00;
//               next_dest = 6'b010_000;
               next_dest = 6'b010_000;
            end
            next_state_in = 'h2;
         end
      end
      2: begin
         if (stream_in_TVALID_int) begin
            header_wr_en = 1'b1;
//            header_din = 32'b0000_0000_0000_00_010_000_0000_0000_0000; //- Write second part of the header.
            header_din = {20'h0,code,2'h0,dest}; //- Write second part of the header.
            if(stream_in_TDATA_int > 32'h0) begin 
                next_in_data_0[63:32] = stream_in_TDATA_int; // finally get first part of data
            end else begin
                next_in_data_0[63:32] = 32'h0;
            end
            next_state_in = 'h3;
         end
      end
      3: begin
         if (stream_in_TVALID_int) begin
            if(stream_in_TDATA_int > 32'h0) begin 
                next_in_data_0[31:0] = stream_in_TDATA_int; // finally get first part of data
            end else begin
                next_in_data_0[31:0] = 32'h0;
            end
            next_state_in = 'h4;
         end
      end
      4: begin
         if (stream_in_TVALID_int) begin
            if(stream_in_TDATA_int > 32'h0) begin 
                next_in_data_1[63:32] = stream_in_TDATA_int; // finally get first part of data
            end else begin
                next_in_data_1[63:32] = 32'h0;
            end
            next_state_in = 'h5;
         end
      end
      5: begin
         if (stream_in_TVALID_int) begin //- Finish this last one anyway
            next_in_valid = 1'b1;
            if(stream_in_TDATA_int > 32'h0) begin 
                next_in_data_1[31:0] = stream_in_TDATA_int; // finally get first part of data
            end else begin
                next_in_data_1[31:0] = 32'h0;
            end
            if (stream_in_TLAST_int)
               next_state_in = 'h0;
            else
               next_state_in = 'h6;
         end
      end
      6: begin
         if (stream_in_TVALID_int) begin
            if(stream_in_TDATA_int > 32'h0) begin 
                next_in_data_0[63:32] = stream_in_TDATA_int; // finally get first part of data
            end else begin
                next_in_data_0[63:32] = 32'h0;
            end
            next_state_in = 'h3;
         end
      end
      7: begin
         if (stream_in_TVALID_int) begin
            if(stream_in_TDATA_int == 32'h8000_0000) begin
                next_in_fft_en = !in_fft_en;
            end else if(stream_in_TDATA_int == 32'b1 && !in_get_tile) begin
                next_in_get_tile = 1'b1;
            end
            next_state_in = 'h0;
         end
      end
   endcase
end


if (TYPE == "SQRT")
   assign pkt_sz_code = header_reg[11:8];
else
   assign pkt_sz_code = 4'b0110;

endgenerate


//- Like a NoC decoder
always @(posedge clk_ctrl) begin
   if (~clk_ctrl_rst_low) begin
      state_in <= 'h0;
      in_data_0 <= 'h0;
      in_data_1 <= 'h0;
      header_reg <= 'h0;
      code <= 'h0;
      dest <= 'h0;
      in_valid <= 1'b0;
      in_get_tile <= 1'b0;
      in_fft_en <= 1'b0;
   end else begin
      dest <= next_dest;
      code <= next_code;
      header_reg <= next_header_reg;
      state_in  <= next_state_in;
      in_data_0 <= next_in_data_0;
      in_data_1 <= next_in_data_1;
      in_valid <= next_in_valid;
      in_get_tile <= next_in_get_tile;
      in_fft_en <= next_in_fft_en;
   end
end

//- Like a NoC encoder


logic [63:0] out_dout;
logic out_rd_en;

always @(posedge clk_ctrl) begin
   if (~clk_ctrl_rst_low) begin
      state_out    <= 'h0;
      pkt_ctr      <= 'h0;
      spad_offst <= 12'h0;
   end else begin
      state_out    <= next_state_out;
      pkt_ctr      <= next_pkt_ctr;
      spad_offst <= next_spad_offst;
   end
end



always @(*) begin
   next_state_out = state_out;
   next_pkt_ctr = pkt_ctr;
   next_spad_offst = spad_offst;

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
            stream_out_TDATA_int  = {3'h0,1'b1,MPUT,1'b0,HsrcId,6'h0,4'b0110,2'h0,6'b010_000};
            stream_out_TKEEP_int  = 'hFFFF;
            next_pkt_ctr          = 1 << 4'b0110 - 1; // might potentially need to change this
            next_state_out        = 2;
         end
      end
      2: begin
         if (stream_out_TREADY_int) begin
            out_rd_en        = 1'b1;
            stream_out_TVALID_int = 1'b1;
            stream_out_TDATA_int  = {14'h0,6'b010_000,spad_offst};
            stream_out_TKEEP_int  = 'hFFFF;
            next_state_out        = 3;
         end
      end
      3: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[31:0];
            next_state_out = 4;
         end
      end
      4: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = out_dout[63:32];
            next_pkt_ctr = pkt_ctr - 1;
            if (pkt_ctr == 'h1) begin // we have all of our packets
               stream_out_TLAST_int = 1'b1;
               next_state_out = 6;
            end else if (~out_empty) begin
               out_rd_en = 1'b1;
               next_state_out = 3; // keep reading out data
            end else next_state_out = 5;
         end
      end
      5: begin
         if (~out_empty) begin
            out_rd_en = 1'b1;
            next_state_out = 3;
         end
      end
      6: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = {3'h0,1'b0,3'b011,1'b0,6'b001_000,6'h0,4'b0000,2'h0,6'b010_001};
            next_state_out = 7;           
         end
      end
      7: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = 32'b11;
            stream_out_TLAST_int = 1'b1;
            next_state_out = 0;           
            next_spad_offst = spad_offst + 12'h40;
         end
      end
      8: begin
         if (stream_out_TREADY_int) begin
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 'hFFFF;
            stream_out_TDATA_int = 32'h0;
            stream_out_TLAST_int = 1'b1;
            next_state_out = 0;  
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
   .READ_DATA_WIDTH     (64),      // DECIMAL
   .READ_MODE           ("std"),         // String
   .SIM_ASSERT_CHK      (0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
   .USE_ADV_FEATURES    ("070f"), // String
   .WAKEUP_TIME         (0),           // DECIMAL
   .WRITE_DATA_WIDTH    (64),     // DECIMAL
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
