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

/////////////////////////////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : 2023
// Description : Testbench for NoC component
// File        : tb_in_dest.v
// Notes       : 
//////////////////////////////////////////////////////////////////////////////////////////

module tb_in_dest;

initial begin
   if ($test$plusargs("vcd")) begin
      $dumpfile("tb_in_dest.vcd");
      $dumpvars(4, tb_in_dest);
   end
end

localparam BW  = 32;
localparam BWB =  4;

logic clk_line;
logic rst;
logic rst_a;

logic [2:0] myX, myY;

logic       [3:0] stream_in_TVALID;
logic  [4*BW-1:0] stream_in_TDATA;
logic  [4*BW-1:0] stream_in_TDATA_r;
logic [4*BWB-1:0] stream_in_TKEEP;
logic       [3:0] stream_in_TLAST;
logic       [3:0] stream_in_TREADY;

logic       [3:0] stream_out_TREADY;
logic       [3:0] stream_out_TVALID;
logic  [4*BW-1:0] stream_out_TDATA;
logic [4*BWB-1:0] stream_out_TKEEP;
logic       [3:0] stream_out_TLAST;
logic       [3:0] stream_out_TREADY_t; //- Input

logic           stream_out_local_TVALID;
logic           stream_out_local_TLAST;
logic  [BW-1:0] stream_out_local_TDATA;
logic [BWB-1:0] stream_out_local_TKEEP;
logic           stream_out_local_TREADY;
logic           stream_out_local_TREADY_t; //- Input

logic           stream_in_local_TVALID;
logic           stream_in_local_TLAST;
logic  [BW-1:0] stream_in_local_TDATA;
logic [BWB-1:0] stream_in_local_TKEEP;
logic           stream_in_local_TREADY; 


tile_noc tile_noc (
   .HsrcId                      ({myY,myX}),
   .stream_in_TVALID            (stream_in_TVALID),
   .stream_in_TREADY            (stream_in_TREADY),
   .stream_in_TDATA             (stream_in_TDATA),
   .stream_in_TKEEP             (stream_in_TKEEP),
   .stream_in_TLAST             (stream_in_TLAST),
   .stream_out_TVALID           (stream_out_TVALID),
   .stream_out_TREADY           (stream_out_TREADY),
   .stream_out_TDATA            (stream_out_TDATA),
   .stream_out_TKEEP            (stream_out_TKEEP),
   .stream_out_TLAST            (stream_out_TLAST),
   .stream_out_local_out_TVALID (stream_out_local_TVALID),
   .stream_out_local_out_TREADY (stream_out_local_TREADY),
   .stream_out_local_out_TDATA  (stream_out_local_TDATA),
   .stream_out_local_out_TKEEP  (stream_out_local_TKEEP),
   .stream_out_local_out_TLAST  (stream_out_local_TLAST),
   .stream_in_local_in_TVALID   (stream_in_local_TVALID),
   .stream_in_local_in_TREADY   (stream_in_local_TREADY),
   .stream_in_local_in_TDATA    (stream_in_local_TDATA),
   .stream_in_local_in_TKEEP    (stream_in_local_TKEEP),
   .stream_in_local_in_TLAST    (stream_in_local_TLAST),
   .clk_line                    (clk_line ),
   //.clk_line_rst_high           (rst) //,
   .clk_line_rst_low            (rst)
);


assign myX = 3;
assign myY = 3;

always begin 
  #5 clk_line =  0; 
  #5 clk_line =  1; 
end

integer f_sr, f_sb, f_st, f_sl, f_sloc;
integer f_or, f_ob, f_ol, f_ot, f_oloc;

initial begin 
    stream_out_TREADY_t = 'hf;
    stream_out_local_TREADY_t = 1'b1;

    rst_a = 1;
#10 rst_a = 0; 
#20 rst_a = 1;
#9000 
$fclose(f_sr);
$fclose(f_sb);
$fclose(f_st);
$fclose(f_sl);
$fclose(f_sloc);
$fclose(f_or);
$fclose(f_ob);
$fclose(f_ot);
$fclose(f_ol);
$fclose(f_oloc);
$finish;
end 

always begin
   #10 
   stream_out_TREADY_t = $random;
   stream_out_local_TREADY_t = $random;
end


logic first;

`define TEST1  //- Single port (bottom) stream in 30 packets, rest and do it again
`define TEST3  //- Add to test1 all the other ports at the same time.
`define TEST2  // Randomly set TREADY low

`define DEL_B 0
`define DEL_R 0


//- Sync.
always @(posedge clk_line)
   rst <= rst_a;

always @(posedge clk_line) begin
   if (~rst) begin
      stream_out_TREADY <= 4'hF;
      stream_out_local_TREADY <= 1'b1;
   end else begin
   `ifdef TEST2
      stream_out_TREADY <= stream_out_TREADY_t;
      stream_out_local_TREADY <= stream_out_local_TREADY_t;
   `endif
   end
end

logic [5:0] dest_b;
logic [5:0] dest_r;
logic [5:0] dest_t;
logic [5:0] dest_l;
logic [5:0] dest_loc;

logic [7:0] ctr_b;

logic last_r;
logic last_b;
logic last_l;
logic last_t;
logic last_loc;

logic [4:0] delay;
logic [4:0] delay_r;
logic first_b;
logic first_r;


`ifdef TEST1
always @(posedge clk_line) begin
   if (~rst) begin
      first                 <= 1'b0;
      first_b               <= 1'b0;
      first_r               <= 1'b0;
      stream_in_TVALID      <= 'h0;
      stream_in_TDATA       <= 'h0;
      stream_in_TLAST       <= 'h0;
      stream_in_TKEEP       <= 'h0;
      stream_in_local_TVALID <= 1'b0;
      stream_in_local_TLAST  <= 1'b0;
      stream_in_local_TDATA  <= 1'b0;
      stream_in_local_TKEEP  <= 4'h0;
      dest_b                 <= 'h0; //- To tile 00
      dest_r                 <= 'h0; //- To tile 00
      dest_t                 <= 'h3; //- To tile 00
      dest_l                 <= 'h0; //- To tile 00
      dest_loc               <= 'h0; //- To tile 00
      last_r <= 1'b0;
      last_b <= 1'b0;
      last_l <= 1'b0;
      last_t <= 1'b0;
      last_loc <= 1'b0;
      delay <= 'h0;
      delay_r <= 'h0;
   end else begin

      //- Bottom
      if (stream_in_TREADY[0]) begin
         $fwrite(f_sb,"%b, %b, %x\n", stream_in_TVALID[0], stream_in_TLAST[0], stream_in_TDATA[31:0]);
         if (dest_b < 59) begin 
            stream_in_TVALID[0] <= 1'b1;
            stream_in_TDATA[31:6] <= $random;
            if (~first_b) begin //- First packet
               stream_in_TLAST[0] <= 1'b0;
               first_b <= 1'b1;
               stream_in_TDATA[5:0]  <= dest_b;
               delay <= 'h0;
            end else if (stream_in_TLAST[0]) begin
               stream_in_TLAST[0] <= 1'b0;
               if ( dest_b[2:0] == myX) begin
                  stream_in_TDATA[5:0]  <= dest_b + 5;
                  dest_b <= dest_b+5;
               end else begin
                  stream_in_TDATA[5:0]  <= dest_b + 1;
                  dest_b <= dest_b+1;
               end
            end else begin
               stream_in_TDATA[5:0] <= $random;
               stream_in_TLAST[0] <= $random;
            end 
         end else if (~last_b)begin
            stream_in_TVALID[0] <= 1'b1;
            stream_in_TDATA[31:0] <= $random;
            stream_in_TLAST[0] <= 1'b1;
            last_b <= 1'b1;
         end else begin
            stream_in_TVALID[0] <= 1'b0;
            stream_in_TDATA[31:0] <= 'h0;
            stream_in_TLAST[0] <= 1'b0;
            delay <= delay + 1;
            if (delay==`DEL_B) begin
               first_b <= 1'b0;
               dest_b <= 'h0;
               last_b <= 1'b0;
            end
         end
      end

   `ifdef TEST3

      //- Right
      if (stream_in_TREADY[1]) begin
         $fwrite(f_sr,"%b, %b, %x\n", stream_in_TVALID[1], stream_in_TLAST[1], stream_in_TDATA[63:32]);
         if (dest_r < 63) begin 
            stream_in_TVALID[1] <= 1'b1;
            stream_in_TDATA[63:38] <= $random;
            if (~first_r) begin //- First packet
               stream_in_TLAST[1] <= 1'b0;
               stream_in_TDATA[37:32]  <= dest_r;
               first_r <= 1'b1;
               delay_r <= 'h0;
            end else if (stream_in_TLAST[1]) begin
               stream_in_TLAST[1] <= 1'b0;
               if ( dest_r[5:3] > myY & dest_r[2:0] == myX-1 ) begin
                  stream_in_TDATA[37:32]  <= dest_r + 2;
                  dest_r <= dest_r+2;
               end else begin
                  stream_in_TDATA[37:32]  <= dest_r + 1;
                  dest_r <= dest_r+1;
               end
            end else begin
               stream_in_TDATA[37:32] <= $random;
               stream_in_TLAST[1] <= $random;
            end
         end else if (~last_r)  begin
            stream_in_TVALID[1] <= 1'b1;
            stream_in_TDATA[63:32] <= $random;
            stream_in_TLAST[1] <= 1'b1;
            last_r <= 1'b1;
         end else begin
            stream_in_TVALID[1] <= 1'b0;
            stream_in_TDATA[63:32] <= 'h0;
            stream_in_TLAST[1] <= 1'b0;
            delay_r <= delay_r + 1;
            if (delay_r==`DEL_R) begin
               first_r <= 1'b0;
               dest_r <= 'h0;
               last_r <= 1'b0;
            end
         end
      end

      
      //- Top
      if (stream_in_TREADY[2]) begin
         if (dest_t<63) begin
            $fwrite(f_st,"%b, %b, %x\n", stream_in_TVALID[2], stream_in_TLAST[2], stream_in_TDATA[95:64]);
            stream_in_TVALID[2] <= 1'b1;
            stream_in_TDATA[95:70] <= $random;
            if (~first) begin //- First packet
               stream_in_TLAST[2] <= 1'b0;
               stream_in_TDATA[69:64]  <= dest_t;
               first <= 1'b1;
            end else if (stream_in_TLAST[2]) begin
               stream_in_TLAST[2] <= 1'b0;
               if ( dest_t[2:0] == 7 ) begin
                  stream_in_TDATA[69:64]  <= dest_t + 4;
                  dest_t <= dest_t+4;
               end else begin
                  stream_in_TDATA[69:64]  <= dest_t + 1;
                  dest_t <= dest_t+1;
               end
            end else begin
               stream_in_TDATA[69:64] <= $random;
               stream_in_TLAST[2] <= $random;
            end
         end else if (~last_t) begin
            stream_in_TVALID[2] <= 1'b1;
            stream_in_TDATA[95:64] <= $random;
            stream_in_TLAST[2] <= 1'b1;
            last_t <= 1'b1;
         end else begin
            stream_in_TVALID[2] <= 1'b0;
            stream_in_TDATA[95:64] <= 'h0;
            stream_in_TLAST[2] <= 1'b0;
         end
      end
   
      //- left
      if (stream_in_TREADY[3]) begin
         if (dest_l < 63) begin
            $fwrite(f_sl,"%b, %b, %x\n", stream_in_TVALID[3], stream_in_TLAST[3], stream_in_TDATA[127:96]);
            stream_in_TVALID[3] <= 1'b1;
            stream_in_TDATA[127:102] <= $random;
            if (~first) begin //- First packet
               stream_in_TLAST[3] <= 1'b0;
               stream_in_TDATA[101:96]  <= dest_l;
            end else if (stream_in_TLAST[3]) begin
               stream_in_TLAST[3] <= 1'b0;
               if ( dest_l[5:3] < myY & dest_l[2:0] == myX-1 ) begin
                  stream_in_TDATA[101:96]  <= dest_l + 2;
                  dest_l <= dest_l+2;
               end else begin
                  stream_in_TDATA[101:96]  <= dest_l + 1;
                  dest_l <= dest_l+1;
               end
            end else begin
               stream_in_TDATA[127:96] <= $random;
               stream_in_TLAST[3] <= $random;
            end 
         end else if (~last_l) begin
            stream_in_TVALID[3] <= 1'b1;
            stream_in_TDATA[95:64] <= $random;
            stream_in_TLAST[3] <= 1'b1;
            last_l <= 1'b1;
         end else begin
            stream_in_TVALID[3] <= 1'b0;
            stream_in_TDATA[127:96] <= 'h0;
            stream_in_TLAST[3] <= 1'b0;
         end
      end

      
      //- local
      if (stream_in_local_TREADY) begin
         if (dest_loc < 63) begin
            $fwrite(f_sloc,"%b, %b, %x\n", stream_in_local_TVALID, stream_in_local_TLAST, stream_in_local_TDATA);
            stream_in_local_TVALID <= 1'b1;
            stream_in_local_TDATA <= $random;
            if (~first) begin //- First packet
               stream_in_local_TLAST <= 1'b0;
               stream_in_local_TDATA  <= dest_loc;
            end else if (stream_in_local_TLAST) begin
               stream_in_local_TLAST <= 1'b0;
               if ( dest_loc == 26 ) begin
                  stream_in_local_TDATA  <= dest_loc + 2;
                  dest_loc <= dest_loc + 2;
               end else begin
                  stream_in_local_TDATA  <= dest_loc + 1;
                  dest_loc <= dest_loc + 1;
               end
            end else begin
               stream_in_local_TDATA <= $random;
               stream_in_local_TLAST <= $random;
            end
         end else if (~last_loc) begin
            stream_in_local_TVALID <= 1'b1;
            stream_in_local_TDATA <= $random;
            stream_in_local_TLAST <= 1'b1;
            last_loc <= 1'b1;
         end else begin
            stream_in_local_TVALID <= 1'b0;
            stream_in_local_TDATA <= 'h0;
            stream_in_local_TLAST <= 1'b0;
         end
      end
   `endif
   end
end
`else 
   always @(posedge clk_line) begin
   if (~rst) begin
      first                 <= 1'b0;
      first_b               <= 1'b0;
      stream_in_TVALID      <= 'h0;
      stream_in_TDATA       <= 'h0;
      stream_in_TLAST       <= 'h0;
      stream_in_TKEEP       <= 'h0;
      stream_in_local_TVALID <= 1'b0;
      stream_in_local_TLAST  <= 1'b0;
      stream_in_local_TDATA  <= 1'b0;
      stream_in_local_TKEEP  <= 4'h0;
      dest_b                 <= 'h0; //- To tile 00
      dest_r                 <= 'h0; //- To tile 00
      dest_t                 <= 'h3; //- To tile 00
      dest_l                 <= 'h0; //- To tile 00
      dest_loc               <= 'h0; //- To tile 00
      last_r <= 1'b0;
      last_b <= 1'b0;
      last_l <= 1'b0;
      last_t <= 1'b0;
      last_loc <= 1'b0;
      delay <= 'h0;
   end else begin

      //- Bottom
      if (stream_in_TREADY[0]) begin
         $fwrite(f_sb,"%b, %b, %x\n", stream_in_TVALID[0], stream_in_TLAST[0], stream_in_TDATA[31:0]);
         if (dest_b < 59) begin 
            if (~stream_in_TVALID[0]) begin
               delay <= delay + 1;
               if (delay == 15) begin
                  stream_in_TVALID[0] <= 1'b1;
                  stream_in_TDATA[31:6] <= $random;
                  stream_in_TDATA[5:0] <= dest_b;
               end
            end else if (stream_in_TVALID[0]) begin
               if (~stream_in_TLAST[0]) begin
                  stream_in_TLAST[0] <= 1'b1;
                  stream_in_TDATA[31:0] <= $random;
               end else begin
                  if ( dest_b[2:0] == myX) begin
                     stream_in_TDATA[5:0]  <= dest_b + 5;
                     dest_b <= dest_b+5;
                  end else begin
                     stream_in_TDATA[5:0]  <= dest_b + 1;
                     dest_b <= dest_b+1;
                  end

                  stream_in_TLAST[0] <= 1'b0;
                  stream_in_TVALID[0] <= 1'b0;
                  stream_in_TDATA[31:0] <= 'h0;
               end
            end
         end
      end
   end
end

`endif

always @(posedge clk_line) begin
   if (stream_out_TVALID[0] & stream_out_TREADY[0])
      $fwrite(f_ob,"%b, %b, %x\n", stream_out_TVALID[0], stream_out_TLAST[0], stream_out_TDATA[31:0]);

   if (stream_out_TVALID[1] & stream_out_TREADY[1])
      $fwrite(f_or,"%b, %b, %x\n", stream_out_TVALID[1], stream_out_TLAST[1], stream_out_TDATA[63:32]);

   if (stream_out_TVALID[2] & stream_out_TREADY[2])
      $fwrite(f_ot,"%b, %b, %x\n", stream_out_TVALID[2], stream_out_TLAST[2], stream_out_TDATA[95:64]);
   
   if (stream_out_TVALID[3] & stream_out_TREADY[3])
      $fwrite(f_ol,"%b, %b, %x\n", stream_out_TVALID[3], stream_out_TLAST[3], stream_out_TDATA[127:96]);

   if (stream_out_local_TVALID & stream_out_local_TREADY)
      $fwrite(f_oloc,"%b, %b, %x\n", stream_out_local_TVALID, stream_out_local_TLAST, stream_out_local_TDATA);
end

always @(posedge clk_line) begin
   if (~rst) begin
      ctr_b <= 'h0;
   end else begin
      if (stream_in_TVALID[0] & stream_in_TREADY[0] & stream_in_TLAST[0])
         ctr_b <= ctr_b + 1;
   end
end


initial begin
  f_sr = $fopen("stimulus_right.txt","w");
  f_sb = $fopen("stimulus_bottom.txt","w");
  f_st = $fopen("stimulus_top.txt","w");
  f_sl = $fopen("stimulus_left.txt","w");
  f_sloc = $fopen("stimulus_local.txt","w");

  f_or = $fopen("output_right.txt","w");
  f_ob = $fopen("output_bottom.txt","w");
  f_ol = $fopen("output_left.txt","w");
  f_ot = $fopen("output_top.txt","w");
  f_oloc = $fopen("output_local.txt","w");
end


endmodule


