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
// Date        : Jan 2024
// Description : TSQR accelerator
// File        : acc_tsqr.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module acc_tsqr#(
   parameter OFFSET_SZ         = 12,
   parameter XY_SZ             =  3,
   parameter TYPE              = "TSQR",
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

logic in_tsqr_en; // enabling the accelerator
logic next_in_tsqr_en;

logic [3:0] state_in;
logic [3:0] next_state_in;

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


logic [31:0] in_control_reg;
logic [31:0] next_in_control_reg;
logic [2:0] in_dma_mem_ena;
logic [2:0] next_in_dma_mem_ena;
logic [31:0] in_dma_mem_wea;
logic [31:0] next_in_dma_mem_wea;
logic [2:0] in_dma_mem_addra;
logic [2:0] next_in_dma_mem_addra;
logic [255:0] in_dma_mem_dina;
logic [255:0] next_in_dma_mem_dina;

logic [2:0] in_dma_mem_enb;
logic [2:0] next_in_dma_mem_enb;
logic [2:0] in_dma_mem_addrb;
logic [2:0] next_in_dma_mem_addrb;

logic [255:0] out_dma_mem_doutb;
logic out_mem0_fi_c_0;
logic out_mem1_fi_c_0;
logic out_tsqr_fi;

logic out_tsqr_fi_reg;
logic next_out_tsqr_fi_reg;

logic [7:0] matrix_count;
logic [7:0] next_matrix_count;

logic [2:0] ena_select;
logic [7:0] input_pkt_cnt;
logic [7:0] next_input_pkt_cnt;

logic pkt_requested;
logic next_pkt_requested;

logic [2:0] out_index_cnt;
logic [2:0] next_out_index_cnt;

logic [2:0] out_addr_cnt;
logic [2:0] next_out_addr_cnt;

logic [11:0] spad_offst;
logic [11:0] next_spad_offst;

generate

tsqr_mc u_tsqr_mc (.clk          (clk_ctrl         ), // input
                   .rst          (clk_ctrl_rst_high),
	               .tsqr_en      (in_control_reg[31]),
	               .tile_no      (in_control_reg[15:0]),
                   .dma_mem_ena  (in_dma_mem_ena      ),
                   .dma_mem_wea  (in_dma_mem_wea      ),
                   .dma_mem_addra(in_dma_mem_addra    ),
                   .dma_mem_dina (in_dma_mem_dina     ),
                   .dma_mem_enb  (in_dma_mem_enb      ),
                   .dma_mem_addrb(in_dma_mem_addrb    ),
                   .dma_mem_doutb(out_dma_mem_doutb    ),
                   .mem0_fi_c_0  (out_mem0_fi_c_0      ),
                   .mem1_fi_c_0  (out_mem1_fi_c_0      ),
                   .tsqr_fi      (out_tsqr_fi         )); // when tsqr finish


assign ena_select = matrix_count  == 8'h0 ? 3'b100 : matrix_count[0]? 3'b010:3'b001; 

always @(*) begin
   next_in_tsqr_en = in_tsqr_en;
   
   next_spad_offst = spad_offst;
   
   if(out_tsqr_fi) begin
    next_out_tsqr_fi_reg = 1'b1;
   end else begin 
    next_out_tsqr_fi_reg = out_tsqr_fi_reg;
   end
   
   next_in_control_reg[15:0] = 16'h40;
   next_in_control_reg[30:16] = 15'b0;
   next_in_control_reg[31] = in_control_reg[31];
    if(state_in != 'h2 & (out_tsqr_fi| out_tsqr_fi_reg| matrix_count < 8'h2 | (out_mem0_fi_c_0 )|(out_mem1_fi_c_0)))begin
        next_in_control_reg[31] = 1'b0;
    end
    

   next_in_dma_mem_ena = 3'b0;
   next_in_dma_mem_wea = 32'b0;
   next_in_dma_mem_addra = 3'b0;
   next_in_dma_mem_dina = 256'b0;
   
   next_in_dma_mem_enb = in_dma_mem_enb;
   next_in_dma_mem_addrb = in_dma_mem_addrb;
   
   next_input_pkt_cnt = input_pkt_cnt;
   next_matrix_count = matrix_count;
   
   next_out_index_cnt = out_index_cnt;
   
   next_out_addr_cnt = out_addr_cnt;
   
   next_pkt_requested = pkt_requested;
   
   next_state_in = state_in;

   stream_in_TREADY_int = 1'b1;
   
   stream_out_TDATA_int = 32'h0; //sendshort pkt request to fft
    stream_out_TKEEP_int = 4'h0;
    stream_out_TVALID_int = 1'b0;
    stream_out_TLAST_int = 1'b0;
   
   case (state_in) // single fsm for all cases 
      0: begin 
         if (stream_out_TREADY_int) begin
            if (stream_in_TVALID_int) begin // we have valid in from noc in
               if(stream_in_TDATA_int[28] == 1'b0 & (stream_in_TDATA_int[23:18] == 6'b000_000 | stream_in_TDATA_int[23:18] == 6'b001_000)) begin // we receive a short packet
                   next_state_in = 'ha; // go to state 7 to examine content of short packet
               end else if (in_tsqr_en & !out_tsqr_fi_reg & pkt_requested) begin //we can receive long packet
                   next_state_in = 'h1; //if long packet arrives
               end
            end else if (in_tsqr_en & out_tsqr_fi_reg) begin // finished processing // ready for output
                next_state_in = 'h5;        
            end else begin // not finished and still need data
                if(in_tsqr_en & !out_tsqr_fi_reg & (((out_mem0_fi_c_0 )|(out_mem1_fi_c_0) | matrix_count < 8'h2) & matrix_count< 8'h40) & !pkt_requested) begin
                    next_state_in = 'h3;
                end
            end
         end else stream_in_TREADY_int = 1'b0;
      end
      1:begin 
         if (stream_in_TVALID_int) begin 
            next_state_in = 'h2;
         end
      end
      2: begin
         if (stream_in_TVALID_int) begin
            next_in_dma_mem_ena = ena_select;
            next_in_dma_mem_wea = (32'hffffffff)&(32'hf<<(28-(4*(input_pkt_cnt%8))));
            next_in_dma_mem_addra = input_pkt_cnt>>3;
            if(stream_in_TDATA_int > 32'h0) begin 
                next_in_dma_mem_dina = stream_in_TDATA_int << (224-((input_pkt_cnt%8)*32));// finally get first part of data
            end else begin
                next_in_dma_mem_dina = 32'h0 << (224-((input_pkt_cnt%8)*32));
            end
            
            if(stream_in_TLAST_int) begin // we have received all input packets
                next_input_pkt_cnt = 8'h0;
                next_matrix_count = matrix_count + 8'h1;
                next_state_in = 'h0; // successfully received matrix
                next_pkt_requested = 1'b0;
                if(matrix_count + 8'h1 > 8'h1) begin
                    next_in_control_reg[31] = 1'b1 & in_tsqr_en;
                end
            end else begin
                next_input_pkt_cnt = input_pkt_cnt + 8'h1;
            end
         end
      end
      3: begin
         if (stream_out_TREADY_int) begin // will proceed to send pkt request
            stream_out_TDATA_int = 32'b000_0_011_0_010_001_000000_0000_00_001_000; //sendshort pkt request to fft
            stream_out_TKEEP_int = 4'hf;
            stream_out_TVALID_int = 1'b1;
            next_state_in = 'h4;
         end
      end
      4: begin
         if (stream_out_TREADY_int) begin // will proceed to send pkt request
            stream_out_TDATA_int = 32'h00000001; //sendshort pkt request to fft
            stream_out_TKEEP_int = 4'hf;
            stream_out_TVALID_int = 1'b1;
            stream_out_TLAST_int = 1'b1;
            next_state_in = 'h0;
            next_pkt_requested = 1'b1;
         end
      end
      5: begin
        next_in_dma_mem_enb = 3'b100;
         if (stream_out_TREADY_int) begin // will proceed to send pkt request
            stream_out_TDATA_int = 32'b000_1_100_0_010_001_000000_0110_00_001_001; //preparing long packet output
            stream_out_TKEEP_int = 4'hf;
            stream_out_TVALID_int = 1'b1;
            next_state_in = 'h6;
         end
      end
      6: begin
         if (stream_out_TREADY_int) begin // will proceed to send pkt request
            stream_out_TDATA_int = 32'b0000_0000_0000_00_001_001_0000_0000_0000; //preparing long packet output
            stream_out_TKEEP_int = 4'hf;
            stream_out_TVALID_int = 1'b1;
            next_state_in = 'h7;
         end
      end
      7: begin
         if (stream_out_TREADY_int) begin // will proceed to send pkt request
            stream_out_TDATA_int = (out_dma_mem_doutb>>(224-(out_index_cnt*32)));
            stream_out_TVALID_int = 1'b1;
            stream_out_TKEEP_int = 4'hf;
            if(out_index_cnt == 3'h7) begin
                if(out_addr_cnt == 3'h7) begin
                    stream_out_TLAST_int = 1'b1;
                    next_out_index_cnt = 3'h0;
                    next_out_addr_cnt = 3'h0;
                    next_in_dma_mem_enb = 3'b000;
                    next_in_dma_mem_addrb = 3'b000;
                    next_out_tsqr_fi_reg = 1'b0;
                    next_state_in = 'h0;
                end else begin
                    next_out_index_cnt = 3'h0;
                    next_out_addr_cnt = out_addr_cnt + 3'h1;
                    next_in_dma_mem_addrb = out_addr_cnt + 3'h1;
                    next_state_in = 'h8;
                end
            end else begin
                next_out_index_cnt = out_index_cnt + 3'h1;
            end
         end
      end
      8: begin
            next_state_in = 'h9;
      end
      9: begin
            next_state_in = 'h7;
      end
      10: begin
        if(stream_in_TVALID_int) begin
            if(stream_in_TDATA_int == 32'h8000_0000) begin
                next_in_tsqr_en = !in_tsqr_en;
                next_state_in = 'h0;
            end else if (stream_in_TDATA_int == 32'b11 & pkt_requested) begin
                next_state_in = 'hb;
            end else begin
                next_state_in = 'h0;
            end 
            
        end
      end
      11: begin
         if (stream_out_TREADY_int) begin // will proceed to send pkt request
            stream_out_TDATA_int = {3'h0,1'b1,3'b101,1'b0,6'b010_001,2'b0,4'b0110,4'b0001,2'h0,6'b010_000}; //sendshort pkt request to fft
            stream_out_TKEEP_int = 4'hf;
            stream_out_TVALID_int = 1'b1;
            next_state_in = 'hc;
         end
      end
      12: begin
         if (stream_out_TREADY_int) begin // will proceed to send pkt request
            stream_out_TDATA_int = {14'h0,6'b010_000,spad_offst}; //sendshort pkt request to fft
            stream_out_TKEEP_int = 4'hf;
            stream_out_TVALID_int = 1'b1;
            next_state_in = 'hd;
         end
      end
      13: begin
         if (stream_out_TREADY_int) begin // will proceed to send pkt request
            stream_out_TDATA_int = {14'h0,6'b010_001,12'b0}; //sendshort pkt request to fft
            stream_out_TKEEP_int = 4'hf;
            stream_out_TVALID_int = 1'b1;
            next_state_in = 'he;
         end
      end
      14: begin
         if (stream_out_TREADY_int) begin // will proceed to send pkt request
            stream_out_TDATA_int = 32'b0; //sendshort pkt request to fft
            stream_out_TKEEP_int = 4'hf;
            stream_out_TVALID_int = 1'b1;
            stream_out_TLAST_int = 1'b1;
            next_spad_offst = spad_offst + 12'h40;
            next_state_in = 'h0;
         end
      end
   endcase
end

endgenerate


//- Like a NoC decoder
always @(posedge clk_ctrl) begin
   if (~clk_ctrl_rst_low) begin
      state_in <= 'h0;
      in_tsqr_en <= 1'b0;
     
      in_control_reg <= 32'b0;
      in_dma_mem_ena <= 3'b0;
      in_dma_mem_wea <= 32'b0;
      in_dma_mem_addra <= 3'b0;
      in_dma_mem_dina <= 256'b0;
      out_tsqr_fi_reg <= 1'b0;
      
      input_pkt_cnt <= 8'h0;
      matrix_count <= 8'h0;
      out_addr_cnt <= 3'h0;
      out_index_cnt <= 3'h0;
      pkt_requested <= 1'b0;
      in_dma_mem_addrb <= 3'b0;
      in_dma_mem_enb <= 3'b000;
      
      spad_offst <= 12'b0;
   end else begin
      state_in  <= next_state_in;
      in_tsqr_en <= next_in_tsqr_en;
      
      in_control_reg <= next_in_control_reg;
      in_dma_mem_ena <= next_in_dma_mem_ena;
      in_dma_mem_wea <= next_in_dma_mem_wea;
      in_dma_mem_addra <= next_in_dma_mem_addra;
      in_dma_mem_dina <= next_in_dma_mem_dina;
      out_tsqr_fi_reg <= next_out_tsqr_fi_reg;
      
      input_pkt_cnt <= next_input_pkt_cnt;
      matrix_count <= next_matrix_count;
      
      pkt_requested <= next_pkt_requested;
      out_addr_cnt <= next_out_addr_cnt;
      out_index_cnt <= next_out_index_cnt;
      in_dma_mem_addrb <= next_in_dma_mem_addrb;
      in_dma_mem_enb <= next_in_dma_mem_enb;
      
      spad_offst <= next_spad_offst;
   end
end


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

