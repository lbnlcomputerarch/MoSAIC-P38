///////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : April 2022
// Description : Place holder for vivado IP
// File        : fifo_generator_0.sv
// Notes       : 
//  - Move this file to ../models once we have the ip
//    ready!!!!!
////////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module fifo_generator_0(
   input logic srst,         // input wire srst
   input logic wr_clk,       // input wire wr_clk
   input logic rd_clk,       // input wire rd_clk
   input logic [36:0] din,          // input wire [36 : 0] din
   input logic wr_en,        // input wire wr_en
   input logic rd_en,        // input wire rd_en
   output logic [36:0] dout,         // output wire [36 : 0] dout
   output logic full,         // output wire full
   output logic empty,        // output wire empty
   output logic wr_rst_busy,  // output wire wr_rst_busy
   output logic rd_rst_busy   // output wire rd_rst_busy
);

localparam FIFO_WRITE_DEPTH = 256;
localparam WRITE_DATA_WIDTH = 37; 
localparam ADDR_W = 8;

logic  [WRITE_DATA_WIDTH-1:0]  mem [0:FIFO_WRITE_DEPTH-1];
logic  [ADDR_W-1:0] addra;
logic  [ADDR_W-1:0] addra_sync;
logic  [ADDR_W-1:0] addrb;
logic  [ADDR_W-1:0] addrb_sync;

always @(posedge wr_clk)
   if (srst) addra <= 'h0;
   else if (wr_en) addra <= addra + 'h1;

always @(posedge rd_clk)
   if (srst) addrb <= 'h0;
   else if (rd_en) addrb <= addrb + 'h1;
  
always @(posedge wr_clk)
   if (wr_en) mem[addra] <= din;

always @(posedge rd_clk) begin
   if (srst) dout <= 'h0;
   else if (rd_en) dout <= mem[addrb];
end


assign empty = addra_sync >= addrb ? addra_sync - addrb == 0 : addra_sync + FIFO_WRITE_DEPTH - addrb <= 1;
assign full = addra > addrb_sync ? addra - addrb_sync == FIFO_WRITE_DEPTH - 1 : addrb_sync - addra == 'h1; 

//assign empty = addra_sync >= addrb ? addra_sync - addrb == 0 : addra_sync + FIFO_WRITE_DEPTH - addrb <= 1;
//assign full = addra_sync > addrb ? addra_sync - addrb == FIFO_WRITE_DEPTH - 1 : addrb - addra_sync == 'h1; 

//assign empty = addra >= addrb_sync ? addra - addrb_sync == 0 : addra + FIFO_WRITE_DEPTH - addrb_sync <= 1;
//assign full = addra > addrb_sync ? addra - addrb_sync == FIFO_WRITE_DEPTH - 1 : addrb_sync - addra == 'h1; 

xpm_cdc_array_single#(
   .WIDTH(ADDR_W),
   .SIM_ASSERT_CHK(0) //- FIXME!!
) cdc_sync1 (
   // Module ports
   .src_clk  (wr_clk),
   .src_in   (addra),
   .dest_clk (rd_clk),
   .dest_out (addra_sync));

    
xpm_cdc_array_single#(
   .WIDTH(ADDR_W),
   .SIM_ASSERT_CHK(0) //- FIXME!!
) cdc_sync2 (
   // Module ports
   .src_clk  (rd_clk),
   .src_in   (addrb),
   .dest_clk (wr_clk),
   .dest_out (addrb_sync));

endmodule
