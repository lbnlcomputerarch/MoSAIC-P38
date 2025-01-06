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
// Date        : Oct 23 2023
// Description : Modules to build light weigth NoC.  
// File        : 4x1_local.sv
// Notes       :
//    - Contains modules:
//       grant_out and in_dest
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module grant_out#(
   parameter BW       = 32,
   parameter BWB      = BW/8,
   parameter CHANNELS = 4,
   parameter [2:0] ID = 0
)(
   input  logic               clk_line,
   input  logic               rst,
   //- {4 ports} 
   input  logic         [3:0] stream_in_TVALID,
   input  logic  [(4*BW)-1:0] stream_in_TDATA,
   input  logic [(4*BWB)-1:0] stream_in_TKEEP,
   input  logic  [(4* 1)-1:0] stream_in_TLAST, 
   input  logic  [(4* 3)-1:0] tdest,
   //- 1 port
   output logic     [BW-1:0] stream_out_TDATA,
   output logic    [BWB-1:0] stream_out_TKEEP,
   output logic              stream_out_TLAST,
   output logic              stream_out_TVALID,
   input  logic              stream_out_TREADY,
   //- To in_dest
   output logic        [3:0] grant
);

logic [3:0] request;
logic [3:0] grant_t;
logic [1:0] port;
logic [1:0] next_port;

logic [BW-1:0] tdata_t;
logic    [3:0] tkeep_t;
logic          tlast_t;
logic          tvalid_t;

logic [3:0] next_grant_lock;
logic [3:0] grant_lock;
logic [1:0] state;
logic [1:0] next_state;


assign request[0] = tdest[(3*1)-1:(3*0)] == ID;
assign request[1] = tdest[(3*2)-1:(3*1)] == ID;
assign request[2] = tdest[(3*3)-1:(3*2)] == ID;
assign request[3] = tdest[(3*4)-1:(3*3)] == ID;

always @(*) begin
   case(port)
      'd0:begin
         grant_t[0] =  request[0];
         grant_t[1] = ~request[0] &  request[1];
         grant_t[2] = ~request[0] & ~request[1] &  request[2];
         grant_t[3] = ~request[0] & ~request[1] & ~request[2] & request[3];
       end
       'd1:begin
         grant_t[1] =  request[1];
         grant_t[2] = ~request[1] &  request[2];
         grant_t[3] = ~request[1] & ~request[2] &  request[3];
         grant_t[0] = ~request[1] & ~request[2] & ~request[3] & request[0];
       end
       'd2:begin
         grant_t[2] =  request[2];
         grant_t[3] = ~request[2] &  request[3];
         grant_t[0] = ~request[2] & ~request[3] &  request[0];
         grant_t[1] = ~request[2] & ~request[3] & ~request[0] & request[1];
       end
       'd3:begin
         grant_t[3] =  request[3];
         grant_t[0] = ~request[3] &  request[0];
         grant_t[1] = ~request[3] & ~request[0] &  request[1];
         grant_t[2] = ~request[3] & ~request[0] & ~request[1] & request[2];
       end
  endcase
end

logic flag;
logic next_flag;

logic [BW-1:0] data;
logic [BW-1:0] next_data;

always @(*) begin
   next_state = state;
   next_grant_lock = grant_lock;
   next_port = port;
   next_flag = flag;
   next_data = data;
   case (state)
      0: begin
         if (|request) begin
            next_grant_lock = grant_t;
            next_state = 'h1;
         end else next_grant_lock = 'h0; 
      end
      1: begin
         if (tvalid_t & tlast_t) begin
            if (stream_out_TREADY) begin
               next_state = 'h0;
               next_port = port + 1;
               next_flag = 1'b0;
            end else if (~flag) begin
               next_flag = 1'b1;
               next_data = tdata_t;
            end
         end
      end
   endcase
end

always @(posedge clk_line) begin
   if (~rst) begin
      state <= 1'b0;
      grant_lock <= 'h0;
      port <= 1'b0;
      flag <= 1'b0;
      data <= 'h0;
   end else begin
      state <= next_state;
      grant_lock <= next_grant_lock;
      port <= next_port;
      flag <= next_flag;
      data <= next_data;
   end
end

assign grant = state == 0 & stream_out_TREADY ? grant_t : 
               state == 1 & stream_out_TREADY & ~flag ? grant_lock : 'h0;

assign tvalid_t = (state == 0 & grant_t[0]) | (state==1 & grant_lock[0]) ? stream_in_TVALID[0] | flag :
                  (state == 0 & grant_t[1]) | (state==1 & grant_lock[1]) ? stream_in_TVALID[1] | flag :
                  (state == 0 & grant_t[2]) | (state==1 & grant_lock[2]) ? stream_in_TVALID[2] | flag :
                  (state == 0 & grant_t[3]) | (state==1 & grant_lock[3]) ? stream_in_TVALID[3] | flag : 'h0;

assign tdata_t =  flag ? data : 
                  (state == 0 & grant_t[0]) | (state==1 & grant_lock[0]) ? stream_in_TDATA[(BW*1)-1:(BW*0)] :
                  (state == 0 & grant_t[1]) | (state==1 & grant_lock[1]) ? stream_in_TDATA[(BW*2)-1:(BW*1)] :
                  (state == 0 & grant_t[2]) | (state==1 & grant_lock[2]) ? stream_in_TDATA[(BW*3)-1:(BW*2)] : 
                  (state == 0 & grant_t[3]) | (state==1 & grant_lock[3]) ? stream_in_TDATA[(BW*4)-1:(BW*3)] : 'h0; 


assign tlast_t =  (state == 0 & grant_t[0]) | (state==1 & grant_lock[0]) ? stream_in_TLAST[0] | flag :
                  (state == 0 & grant_t[1]) | (state==1 & grant_lock[1]) ? stream_in_TLAST[1] | flag :
                  (state == 0 & grant_t[2]) | (state==1 & grant_lock[2]) ? stream_in_TLAST[2] | flag : 
                  (state == 0 & grant_t[3]) | (state==1 & grant_lock[3]) ? stream_in_TLAST[3] | flag : 'h0;

assign tkeep_t =  (state == 0 & grant_t[0]) | (state==1 & grant_lock[0]) ? stream_in_TKEEP[(BWB*1)-1:(BWB*0)] :
                  (state == 0 & grant_t[1]) | (state==1 & grant_lock[1]) ? stream_in_TKEEP[(BWB*2)-1:(BWB*1)] :
                  (state == 0 & grant_t[2]) | (state==1 & grant_lock[2]) ? stream_in_TKEEP[(BWB*3)-1:(BWB*2)] : 
                  (state == 0 & grant_t[3]) | (state==1 & grant_lock[3]) ? stream_in_TKEEP[(BWB*4)-1:(BWB*3)] : 'h0;

always @(posedge clk_line) begin
   if (~rst) begin
      stream_out_TVALID <= 1'b0;
      stream_out_TLAST <= 1'b0;
      stream_out_TKEEP <= 'h0;
      stream_out_TDATA <= 'h0;
   end else if (stream_out_TREADY) begin
      stream_out_TVALID <= tvalid_t;
      stream_out_TLAST <= tlast_t;
      stream_out_TKEEP <= tkeep_t;
      stream_out_TDATA <= tdata_t;
   end
end


endmodule



module in_dest#(
   //- For dispatcher
   parameter DISPATCHER = 0,
   parameter BW  = 32,
   parameter BWB = BW/8,
   parameter END = 0,
   //- For bigger switches
   parameter BIG = 0,
   parameter OFFSET = 0,
   parameter LEVEL  = 0,
   //- 
   parameter XY_SZ = 3
)(
   input  logic             clk_line,
   input  logic             rst,
   input  logic [XY_SZ-1:0] myX,
   input  logic [XY_SZ-1:0] myY,
   //- 
   input  logic             stream_in_TVALID,
   input  logic             stream_in_TLAST,
   input  logic    [BW-1:0] stream_in_TDATA,
   input  logic   [BWB-1:0] stream_in_TKEEP,
   input  logic       [4:0] grant,
   //-
   output  logic            stream_in_TVALID_d,
   output  logic            stream_in_TLAST_d,
   output  logic   [BW-1:0] stream_in_TDATA_d,
   output  logic  [BWB-1:0] stream_in_TKEEP_d,
   //- 
   output logic       [2:0] tdest,
   output logic             stream_in_TREADY
);

localparam [2:0] LOCAL  = 5;
localparam [2:0] LEFT   = 4;
localparam [2:0] TOP    = 3;
localparam [2:0] RIGHT  = 2;
localparam [2:0] BOTTOM = 1;
localparam [2:0] NULL   = 0;

localparam BUFFER_DATA_SZ = BWB + BW + 1 + 3;

logic [BUFFER_DATA_SZ-1:0] dout;
logic [BUFFER_DATA_SZ-1:0] dout2;

assign stream_in_TREADY = ~full;

logic granted_d;
logic flag;
always @(posedge clk_line)
   granted_d <= granted;

always @(posedge clk_line) begin
   if (~rst) begin
      stream_in_TVALID_d <= 1'b0;
   end else begin
      stream_in_TVALID_d <= ~empty;
   end
end

assign flag = granted_d;

logic [2:0] tdest_n;
assign tdest   = stream_in_TVALID_d ? flag ? dout2[BW+BWB+3:BW+BWB+1] : dout[BW+BWB+3:BW+BWB+1] : 'h0;
assign tdest_n = stream_in_TVALID_d & flag ? dout2[BW+BWB+3:BW+BWB+1] : dout[BW+BWB+3:BW+BWB+1];

assign stream_in_TDATA_d = stream_in_TVALID_d & flag ? dout2[BW-1:0]  : dout[BW-1:0];
assign stream_in_TKEEP_d = stream_in_TVALID_d & flag ? dout2[BW+BWB-1:BW] : dout[BW+BWB-1:BW];
assign stream_in_TLAST_d = stream_in_TVALID_d & flag ? dout2[BW+BWB] : dout[BW+BWB];


logic [2:0] tdest_t;
logic [2:0] next_tdest_r;
logic [2:0] tdest_r;

logic [1:0] state;
logic [1:0] next_state;

logic granted;

generate
   if (DISPATCHER) begin
      assign tdest_t = tdest_r == END+1 ? 'h2 : 
                       tdest_r == 'h0 ? 'h2 :
                       tdest_r == 'h2 ? 'h3 :
                       tdest_r == 'h3 ? 'h4 : 
                       tdest_r == 'h4 ? 'h5 : 'h2;
                       
   end else if (BIG == 1) begin
      if (LEVEL==0) begin
         assign tdest_t = stream_in_TDATA[XY_SZ-1:0] >= myX              ? LOCAL  :
                          stream_in_TDATA[(2*XY_SZ)-1:XY_SZ] == 0+OFFSET ? BOTTOM :
                          stream_in_TDATA[(2*XY_SZ)-1:XY_SZ] == 1+OFFSET ? RIGHT  :
                          stream_in_TDATA[(2*XY_SZ)-1:XY_SZ] == 2+OFFSET ? TOP    : LEFT;
      end else begin
         assign tdest_t = stream_in_TDATA[XY_SZ-1:0] >= myX            ? LOCAL :
                          stream_in_TDATA[(2*XY_SZ)-1:XY_SZ] >= OFFSET ? RIGHT : BOTTOM;
      end      
   end else begin
      assign tdest_t = stream_in_TDATA[XY_SZ-1:0] > myX         ? BOTTOM :
                       stream_in_TDATA[XY_SZ-1:0] < myX         ? TOP    :
                       stream_in_TDATA[(2*XY_SZ)-1:XY_SZ] > myY ? RIGHT  :
                       stream_in_TDATA[(2*XY_SZ)-1:XY_SZ] < myY ? LEFT   : LOCAL;
   end
endgenerate

always @(*) begin
   next_state = state;
   next_tdest_r = tdest_r;
   case (state)
      0: begin
         if (stream_in_TVALID) begin
            if (~stream_in_TLAST) begin
               if (stream_in_TREADY) begin
                  next_tdest_r = tdest_t;
                  next_state = 'h1;
               end 
            end 
         end 
      end
      1: begin
         if (stream_in_TVALID & stream_in_TLAST & stream_in_TREADY) begin
            next_state = 'h0;
         end
      end
   endcase
end

always @(posedge clk_line) begin
   if (~rst) begin
      state <= 1'b0;
      tdest_r <= 1'b0;
   end else begin
      state <= next_state;
      tdest_r <= next_tdest_r;
   end
end

assign granted = tdest_n == LEFT  & grant[3] | tdest_n == TOP    & grant[2] |
                 tdest_n == RIGHT & grant[1] | tdest_n == BOTTOM & grant[0] |
                 tdest_n == LOCAL & grant[4];

buffer_0#(
   .DATA_SZ (BUFFER_DATA_SZ)
) buffer_0(
   .clk     (clk_line),
   .rst     (rst),
   .wr_en   (stream_in_TVALID & ~full),
   .rd_en   (granted),
   .flush   (~stream_in_TVALID & ~stream_in_TVALID_d & empty),
   .dout    (dout),
   .din     ({next_tdest_r,stream_in_TLAST,stream_in_TKEEP,stream_in_TDATA}),
   .dout2   (dout2),
   .full    (full),
   .empty   (empty)
);

endmodule

module buffer_0#(
   parameter DATA_SZ = 40
) (
   input  logic               clk,
   input  logic               rst,
   input  logic               wr_en,
   input  logic               rd_en,
   input  logic               flush,
   input  logic [DATA_SZ-1:0] din,
   output logic [DATA_SZ-1:0] dout,
   output logic [DATA_SZ-1:0] dout2,
   output logic full,
   output logic empty
);

logic [DATA_SZ-1:0] buffer_0;
logic [DATA_SZ-1:0] buffer_1;
logic [DATA_SZ-1:0] buffer_2;
logic [DATA_SZ-1:0] buffer_3;


logic [1:0] wr_addr;
logic [1:0] rd_addr_next;
logic [1:0] rd_addr;

assign rd_addr_next = rd_addr + 1;
logic almost_empty;

always @(posedge clk) begin
   if (~rst) begin
      wr_addr <= 'h0;
      rd_addr <= 'h0;
   end else begin
      if (wr_en)
         wr_addr <= wr_addr + 1;

      if (rd_en) begin
         rd_addr <= rd_addr_next;
      end 
      else if (flush)
         rd_addr <= wr_addr;
   end
end

always @(posedge clk) begin
   if (~rst) begin
      buffer_0 <= 'h0;
      buffer_1 <= 'h0;
      buffer_2 <= 'h0;
      buffer_3 <= 'h0;
   end else if (wr_en) begin
      if      (wr_addr == 0) buffer_0 <= din;
      else if (wr_addr == 1) buffer_1 <= din;
      else if (wr_addr == 2) buffer_2 <= din;
      else if (wr_addr == 3) buffer_3 <= din;
   end
end

always @(posedge clk) begin
   if (~rst)
      dout <= 'h0;
   else begin
      if (rd_addr == 0) dout <= buffer_0;
      else if (rd_addr == 1) dout <= buffer_1;
      else if (rd_addr == 2) dout <= buffer_2;
      else if (rd_addr == 3) dout <= buffer_3;
   end
end

always @(posedge clk) begin
   if (~rst)
      dout2 <= 'h0;
   else begin
      if (rd_addr_next == 0) dout2 <= buffer_0;
      else if (rd_addr_next == 1) dout2 <= buffer_1;
      else if (rd_addr_next == 2) dout2 <= buffer_2;
      else if (rd_addr_next == 3) dout2 <= buffer_3;
   end
end

assign full = wr_addr > rd_addr ? wr_addr - rd_addr == 'h3 : rd_addr - wr_addr == 'h1;
assign empty = wr_addr >= rd_addr ? wr_addr - rd_addr <= 1 : wr_addr + 'h4 - rd_addr <= 1;

endmodule
