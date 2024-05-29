/////////////////////////////////////////////////////////////////
// Author      : -----
// Date        : April 25 2022
// Description : Start of Processing
// File        : SOP.v
// Notes       : 
//  - From USS by Farzad F. (LBL), and Chris N. (AMD).
//    Legacy block.
////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

module SOP (
   clk_line,
   rst,
   plain_out_start_of_processing
);

input clk_line /* unused */ ;
(* polarity = "high" *) input rst /* unused */ ;
output reg plain_out_start_of_processing /* undriven */ ;

reg [7:0]  cnt;
   
always @(posedge clk_line) begin
   if (rst) begin
      cnt <= 0;
   end else begin
      cnt <= cnt + 8'd1;   // rolls over to give 256 clocks / sop
   end
end

always @(cnt) begin
   if ( cnt == 8'b0 ) plain_out_start_of_processing = 1;
   else               plain_out_start_of_processing = 0;
end

endmodule

