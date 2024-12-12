////////////////////////////////////////////////
// Author      : Patricia, Kylie
// Date        : December 2024
// Description : ASA Decoder for MoSAIC NoC
// File        : asa_noc_dec.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module asa_noc_dec#(
   parameter XY_SZ             =  3
)(
  //---Clock and Reset---//
   input  logic       clk_ctrl,
   input  logic       clk_ctrl_rst_low,
   input  logic [(XY_SZ*2)-1:0] HsrcId,     //- Tile identification
   //---NOC interface---//
   //- Input Interface
	input  logic        stream_in_TVALID,
	input  logic [31:0] stream_in_TDATA,
	input  logic [ 3:0] stream_in_TKEEP,
	input  logic        stream_in_TLAST,
	output logic        stream_in_TREADY,
   output logic        header_out_vld,
   output logic [31:0] header_out,
   output logic        req_val,
   ASAReqMsg           req_msg
);

localparam [2:0] QPUT = 3'd3;
ASAReqMsg  next_req_msg;

// state of encoder FSM
logic [2:0] state;
logic [2:0] next_state;

logic [3:0] pkt_sz_code;
assign pkt_sz_code = 3;    // for 2^3 = 8 words in ASA response payload --> ASK: confirm with Patricia

logic [31:0] header_reg;
logic [31:0] next_header_reg;

//- Like a NoC decoder
always @(posedge clk_ctrl) begin
   if (~clk_ctrl_rst_low) begin
      state     <= 'h0;
      header_reg   <= 'h0;
      req_msg.inst <= ASA_IADD;
      //req_msg.inst <= 'h0;
      // TODO: not sure what to initialize it to, this is the ASA_IADD instr (4'b0000) --> TEST
      req_msg.key  <= 32'h0;
      req_msg.data <= 64'h0;
   end else begin
      header_reg   <= next_header_reg;
      state     <= next_state;
      req_msg <= next_req_msg;
      //req_val_hold <= (req_val || req_val_hold) && ~resp_rdy;  // signal held high for duration of request (while ASA is processing)
   end
end

//- NOC DECODER
always @(*) begin
   next_state = state;
   next_header_reg = header_reg;

   req_val = 1'b0;            // remains low other than case 5
   next_req_msg = req_msg;

   header_out = 'h0;
   header_out_vld = 1'b0;

   case (state)
      0: begin
         //if (stream_out_TREADY) begin //- Assumes the output buffer
                                            //  is ready FIXME
            if (stream_in_TVALID) begin
               next_header_reg = stream_in_TDATA;
               next_state = 'h1;
               header_out = {3'h0,1'b1,QPUT,1'b0,HsrcId,6'h0,pkt_sz_code,2'h0,stream_in_TDATA[23:18]};
               header_out_vld = 1'b1; 
            end
         //end
      end
      1:begin
         // skip filler, grab source tile
         // send output as message que
         //stream_out_TVALID = 1'b1;
         // creating header for response message
         //stream_out_TDATA  = {3'h0,1'b1,QPUT,1'b0,HsrcId,6'h0,pkt_sz_code,2'h0,header_reg[23:18]};   // push header into NoC
         //stream_out_TKEEP  = 'hFFFF;
         next_state = 'h2;
      end
      2: begin
         // get opcode (4 bits)
         if (stream_in_TVALID) begin
            // creating header for output, assumes output goes to same source that it recived input from
            //stream_out_TVALID = 1'b1;
            //stream_out_TDATA  = 'h0;
            //stream_out_TKEEP  = 'hFFFF;
            case (stream_in_TDATA[4:0])
               4'b0000: next_req_msg.inst = ASA_IADD;
               4'b0001: next_req_msg.inst = ASA_TIAD;
               4'b0010: next_req_msg.inst = ASA_MIAD;
               4'b1101: next_req_msg.inst = ASA_GASU;
               4'b1110: next_req_msg.inst = ASA_ALLO;
               4'b1111: next_req_msg.inst = ASA_GATH;
               default: next_req_msg.inst = ASA_IADD;
            endcase
            next_state = 'h3;
         end
      end
      3: begin
         // get key
         if (stream_in_TVALID) begin
            next_req_msg.key = stream_in_TDATA;
            next_state = 'h4;
         end
      end
      4: begin
         // get upper half of data 
         if (stream_in_TVALID) begin
            next_req_msg.data[63:32] = stream_in_TDATA;
            next_state = 'h5;
         end
      end
      5: begin
         // get lower half of data 
         if (stream_in_TVALID) begin
            next_req_msg.data[31:0] = stream_in_TDATA;
            req_val = 1'b1;
            //next_state = 'h6;
            next_state = 'h0;
         end
      end
      /*
      6: begin
         // assert valid signal for ASA accelerator (done, pass input to ASA)
         if (stream_in_TVALID) begin
            next_state = 'h0;
         end
      end
      */
   endcase
end

endmodule
