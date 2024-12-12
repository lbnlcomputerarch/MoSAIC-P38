 ////////////////////////////////////////////////
// Author      : Patricia, Kylie
// Date        : December 2024
// Description : ASA Decoder for MoSAIC NoC
// File        : asa_noc_dec.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module asa_noc_enc (
  //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_ctrl_rst_low,
   //- Output Interface
	input  logic        stream_out_TREADY,
	output logic        stream_out_TVALID,
	output logic [31:0] stream_out_TDATA,
	output logic [ 3:0] stream_out_TKEEP,
	output logic        stream_out_TLAST,   
   input logic [31:0] header_out,
   input logic        header_out_vld,
   //- Accelerator interface
   input  logic resp_val,
   ASARespMsg resp_msg
);

// state of encoder FSM
logic [2:0] state;
logic [2:0] next_state;

always @(posedge clk_ctrl) begin
   if (~clk_ctrl_rst_low) begin
      state    <= 'h0;
   end else begin
      state    <= next_state;
   end
end


// ASA decoder: ASA output --> Mosaic output
// map ASA output feids to MOSAIC output feilds
// hold output in regester to persist 
always @(*) begin
   next_state = state;

   stream_out_TVALID = 1'b0;
   stream_out_TDATA  =  'h0;
   stream_out_TKEEP  =  'h0;
   stream_out_TLAST  = 1'b0;

   case (state)
      0: begin
         // write upper half address
         if (stream_out_TREADY) begin
            if (resp_val) begin
               stream_out_TVALID = 1'b1;
               stream_out_TKEEP = 'hFFFF;
               stream_out_TDATA = resp_msg.addr[63:32];
               next_state = 1;
            end else if (header_out_vld) begin
               stream_out_TVALID = 1'b1;
               stream_out_TKEEP = 'hFFFF;
               stream_out_TDATA = header_out;
            end
         end 
      end
      1: begin
         // write lower half address 
         if (stream_out_TREADY) begin
            stream_out_TVALID = 1'b1;
            stream_out_TKEEP = 'hFFFF;
            stream_out_TDATA = resp_msg.addr[31:0];
            next_state = 2;
         end 
      end
      2: begin
         // write upper half key 
         if (stream_out_TREADY) begin
            stream_out_TVALID = 1'b1;
            stream_out_TKEEP = 'hFFFF;
            stream_out_TDATA = resp_msg.key[63:32];
            next_state = 3;
         end 
      end
      3: begin
         // write lower half key 
         if (stream_out_TREADY) begin
            stream_out_TVALID = 1'b1;
            stream_out_TKEEP = 'hFFFF;
            stream_out_TDATA = resp_msg.key[31:0];
            next_state = 4;
         end 
      end
      4: begin
         // write upper half data 
         if (stream_out_TREADY) begin
            stream_out_TVALID = 1'b1;
            stream_out_TKEEP = 'hFFFF;
            stream_out_TDATA = resp_msg.data[63:32];
            next_state = 5;
         end 
      end
      5: begin
         // write lower half data
         if (stream_out_TREADY) begin
            stream_out_TVALID = 1'b1;
            stream_out_TKEEP = 'hFFFF;
            stream_out_TDATA = resp_msg.data[31:0];
            next_state = 6;
         end
      end
      6: begin
         // TODO: resolve: is this necissary? Does payload need to be power of 2? --> ASK
         // write dummy payload word 1 
         if (stream_out_TREADY) begin
            stream_out_TVALID = 1'b1;
            stream_out_TKEEP = 'hFFFF;
            stream_out_TDATA = 32'b00000000000000000000000000000000;
            next_state = 7;
         end 
      end
      7: begin
         // write dummy payload word 2 
         if (stream_out_TREADY) begin
            stream_out_TVALID = 1'b1;
            stream_out_TKEEP = 'hFFFF;
            stream_out_TDATA = 32'b00000000000000000000000000000000;
            next_state = 0;
         end 
      end
   endcase
end

endmodule
