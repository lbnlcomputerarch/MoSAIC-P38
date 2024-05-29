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
// Description : Testbench for the tile memory manager
// File        : tb_tile_mem_mgr.sv
// Notes       : 
//////////////////////////////////////////////////////////////////////////////////////////

//`define TEST2
`define DEL_B 'd7
module tb_tile_mem_mgr();

initial begin
   if ($test$plusargs("vcd")) begin
      $dumpfile("tb_tile_mem_mgr.vcd");
      $dumpvars(6, tb_tile_mem_mgr);
   end
end

`ifdef BOARD_u280
  localparam SYS_CLK_PERIOD = 10000; //For U280
`else
  localparam SYS_CLK_PERIOD =  3332; //For U250
`endif

localparam COL         =  2;
localparam AXI_OUTADR  =  8;
localparam BW          = 32;
localparam BWB         =  4;

localparam [2:0] MGET = 5;

parameter S_AXI_ID_SZ  =  11;
parameter S_AXI_ADR_SZ =  34;  //- ADDRESS
parameter S_AXI_LEN_SZ =   8;  //- LENGTH
parameter S_AXI_SZE_SZ =   3;  //- SIZE
parameter S_AXI_BRT_SZ =   2;  //- BURST
parameter S_AXI_DAT_SZ = 512;  //- DATA
parameter S_AXI_STB_SZ =  64;  //- STROBE
parameter S_AXI_RSP_SZ =   2;  //- RESPONSE
parameter S_AXI_CAC_SZ =   4;  //- RESPONSE
parameter S_AXI_PRT_SZ =   3;  //- RESPONSE
parameter S_AXI_QOS_SZ =   4;  //- RESPONSE

logic     [COL-1:0] stream_out_TVALID;
logic     [COL-1:0] stream_out_TREADY;
logic     [COL-1:0] stream_out_TREADY_t;
logic     [COL-1:0] stream_out_TLAST;
logic  [COL*BW-1:0] stream_out_TDATA;
logic [COL*BWB-1:0] stream_out_TKEEP;

logic     [COL-1:0] stream_in_TVALID;
logic     [COL-1:0] stream_in_TREADY;
logic     [COL-1:0] stream_in_TLAST;
logic  [COL*BW-1:0] stream_in_TDATA;
logic [COL*BWB-1:0] stream_in_TKEEP;


//- AXI bus
logic [AXI_OUTADR-1:0] tile_S_AXI_AWADDR;
logic                  tile_S_AXI_AWVALID;
logic                  tile_S_AXI_AWREADY;
logic         [BW-1:0] tile_S_AXI_WDATA;
logic        [BWB-1:0] tile_S_AXI_WSTRB;
logic                  tile_S_AXI_WVALID;
logic                  tile_S_AXI_WREADY;
logic            [1:0] tile_S_AXI_BRESP;
logic                  tile_S_AXI_BVALID;
logic                  tile_S_AXI_BREADY;
logic [AXI_OUTADR-1:0] tile_S_AXI_ARADDR;
logic                  tile_S_AXI_ARVALID;
logic                  tile_S_AXI_ARREADY;
logic         [BW-1:0] tile_S_AXI_RDATA;
logic            [1:0] tile_S_AXI_RRESP;
logic                  tile_S_AXI_RVALID;
logic                  tile_S_AXI_RREADY;


//- ADDRESS WRITE
logic                    s_axi_awready;
logic                    s_axi_awvalid;
logic [S_AXI_ID_SZ-1:0]  s_axi_awid;
logic [S_AXI_ADR_SZ-1:0] s_axi_awaddr;
logic [S_AXI_LEN_SZ-1:0] s_axi_awlen;
logic [S_AXI_SZE_SZ-1:0] s_axi_awsize;
logic [S_AXI_BRT_SZ-1:0] s_axi_awburst;
logic                    s_axi_awlock;
logic [S_AXI_CAC_SZ-1:0] s_axi_awcache;
logic [S_AXI_PRT_SZ-1:0] s_axi_awprot;
logic [S_AXI_QOS_SZ-1:0] s_axi_awqos;
//- DATA WRITE
logic                    s_axi_wready;
logic                    s_axi_wvalid;
logic                    s_axi_wlast;
logic [S_AXI_DAT_SZ-1:0] s_axi_wdata;
logic [S_AXI_STB_SZ-1:0] s_axi_wstrb;
//- VALID WRITE
logic                    s_axi_bready;
logic                    s_axi_bvalid;
logic [S_AXI_ID_SZ-1:0]  s_axi_bid;
logic [S_AXI_RSP_SZ-1:0] s_axi_bresp;
//- ADDRESS READ
logic                    s_axi_arready;
logic                    s_axi_arvalid;
logic [S_AXI_ID_SZ-1:0]  s_axi_arid;
logic [S_AXI_ADR_SZ-1:0] s_axi_araddr;
logic [S_AXI_LEN_SZ-1:0] s_axi_arlen;
logic [S_AXI_SZE_SZ-1:0] s_axi_arsize;
logic [S_AXI_BRT_SZ-1:0] s_axi_arburst;
logic                    s_axi_arlock;
logic [S_AXI_CAC_SZ-1:0] s_axi_arcache;
logic [S_AXI_PRT_SZ-1:0] s_axi_arprot;
logic [S_AXI_QOS_SZ-1:0] s_axi_arqos;
//- RESPONSE READ
logic                    s_axi_rready;
logic                    s_axi_rvalid;
logic                    s_axi_rlast;
logic [S_AXI_DAT_SZ-1:0] s_axi_rdata;
logic [S_AXI_ID_SZ-1:0]  s_axi_rid;
logic [S_AXI_RSP_SZ-1:0] s_axi_rresp;

logic clk_line;
logic clk_control;
logic clk_memory;
logic clk_line_rst_high;
logic clk_line_rst_low;
logic clk_control_rst_high;
logic clk_control_rst_low;
logic clk_memory_rst_high;
logic clk_memory_rst_low;

logic first_r;
logic first_b;
logic last_b;
logic last_r;
logic [2:0] delay;

logic [5:0] delay1;
logic [5:0] delay_set;

logic [1:0] ctr;
logic [1:0] ctr_b;

always begin 
  #(4000 / 2) clk_line =  0; // 4000ps = 4ns 
  #(4000 / 2) clk_line =  1; 
end

always begin 
  #(8000 / 2) clk_control =  0;  // 8000ps = 8ns
  #(8000 / 2) clk_control =  1; 
end

always begin 
  #(SYS_CLK_PERIOD/2.0 ) clk_memory =  1; 
  #(SYS_CLK_PERIOD/2.0 ) clk_memory =  0; 
end


initial begin 
clk_line_rst_high = 1; 
clk_line_rst_low  = 0; 
#1000000 
clk_line_rst_high = 0; 
clk_line_rst_low = 1; 
end 

initial begin 
clk_control_rst_high = 1; 
clk_control_rst_low = 0; 
#1000000 
clk_control_rst_high = 0; 
clk_control_rst_low = 1; 
end 

initial begin 
clk_memory_rst_high = 1; 
clk_memory_rst_low = 0; 
#1000000 
clk_memory_rst_high = 0; 
clk_memory_rst_low = 1; 
end 

integer f_sr, f_sb;
integer f_or, f_ob;

initial begin
   stream_out_TREADY_t = 'hf;
   f_sr = $fopen("stimulus_right.txt","w");
   f_sb = $fopen("stimulus_bottom.txt","w");
   f_or = $fopen("output_right.txt","w");
   f_ob = $fopen("output_bottom.txt","w");
   #80000000
   $fclose(f_sr);
   $fclose(f_sb);
   $fclose(f_or);
   $fclose(f_ob);
   $finish;
end

always @(posedge clk_line) begin
   if (stream_out_TVALID[0] & stream_out_TREADY[0])
      $fwrite(f_ob,"%b, %b, %x\n", stream_out_TVALID[0], stream_out_TLAST[0], stream_out_TDATA[31:0]);

   if (stream_out_TVALID[1] & stream_out_TREADY[1])
      $fwrite(f_or,"%b, %b, %x\n", stream_out_TVALID[1], stream_out_TLAST[1], stream_out_TDATA[63:32]);
end

always begin
   #10 
   stream_out_TREADY_t= $random;
end

always @(posedge clk_line)
   stream_out_TREADY <= stream_out_TREADY_t;

//assign stream_out_mem_mgr_TREADY = 2'b11;

assign tile_S_AXI_AWADDR  = 'h0;
assign tile_S_AXI_AWVALID = 1'b0;
assign tile_S_AXI_WDATA   = 'h0;
assign tile_S_AXI_WSTRB   = 'h0;
assign tile_S_AXI_WVALID  = 1'b0;
assign tile_S_AXI_BREADY  = 1'b1;
assign tile_S_AXI_ARADDR  = 'h0;
assign tile_S_AXI_ARVALID = 1'b0;
assign tile_S_AXI_RREADY  = 1'b1;

logic [7:0] pkt_b;
logic [7:0] pkt_r;

always @(posedge clk_line) begin
   if (~clk_line_rst_low) begin
      first_r               <= 1'b0;
      first_b               <= 1'b0;
      stream_in_TVALID      <= 'h0;
      stream_in_TDATA       <= 'h0;
      stream_in_TLAST       <= 'h0;
      stream_in_TKEEP       <= 'h0;
      last_r <= 1'b0;
      last_b <= 1'b0;
      `ifdef TEST2
      delay <= 'h0;
      `else
      delay <= `DEL_B;
      `endif
      ctr   <= 'h0;
      ctr_b <= 'h0;
      pkt_b <= 'h0;
      pkt_r <= 'h0;
      
   end else begin

      //- Bottom
      if (stream_in_TREADY[0]) begin
         if (stream_in_TVALID[0])
            $fwrite(f_sb,"%b, %b, %x\n", stream_in_TVALID[0], stream_in_TLAST[0], stream_in_TDATA[31:0]);
         if (pkt_b<50) begin
            `ifndef TEST2
            stream_in_TVALID[0]    <= 1'b1;
            ctr_b <= ctr_b + 1;
            `endif
            if (~first_b | stream_in_TLAST[0]) begin //- First packet
               if (delay == `DEL_B) begin
                  `ifdef TEST2
                  stream_in_TVALID[0]    <= 1'b1;
                  delay <= 0;
                  ctr_b <= ctr_b + 1;
                  `endif
                  stream_in_TLAST[0]     <= 1'b0;
                  stream_in_TDATA[7:0]   <= 8'b00000010; //- XY coord
                  stream_in_TDATA[11:8]  <= 4'h2; //- In  packet size
                  stream_in_TDATA[15:12] <= 4'h4; //- Out packet size
                  stream_in_TDATA[17:16] <= 'h0;  //- Unused
                  stream_in_TDATA[23:18] <= 'h0;  //- Source coordinates
                  stream_in_TDATA[24]    <= 1'b0; //- Unused
                  stream_in_TDATA[27:25] <= MGET; //- Long packet
                  stream_in_TDATA[28]    <= 1'b1; //- Long packet
                  stream_in_TDATA[31:29] <= 'h0;  //- Unused
                  first_b                <= 1'b1;
               end else begin
                  `ifdef TEST2
                  stream_in_TVALID[0]   <= 1'b0;
                  //stream_in_TLAST[0]    <= 1'b0;
                  stream_in_TDATA[31:0] <=  'h0;
                  delay <= delay + 1;
                  `endif
               end
            end else begin
               ctr_b <= ctr_b + 1;
               stream_in_TDATA[31:0] <= $random;
               if (ctr_b == 3) begin
                  stream_in_TLAST[0] <= 1'b1;
                  pkt_b <= pkt_b + 1;
               end else begin
                  `ifdef TEST2
                  stream_in_TVALID[0] <= 1'b1;
                  `endif
                  stream_in_TLAST[0]  <= 1'b0;
               end
            end
         end else begin
            stream_in_TVALID[0]   <= 1'b0;
            stream_in_TDATA[31:0] <= 'h0;
            stream_in_TLAST[0] <= 1'b0;
         end
      end

      //-Right
      if (stream_in_TREADY[1]) begin
         if (stream_in_TVALID[1])
            $fwrite(f_sr,"%b, %b, %x\n", stream_in_TVALID[1], stream_in_TLAST[1], stream_in_TDATA[63:32]);
         if (pkt_r<50) begin
            stream_in_TVALID[1]     <= 1'b1;
            ctr <= ctr + 1;
            if (~first_r | stream_in_TLAST[1]) begin //- First packet
               first_r                <= 1'b1;
               stream_in_TLAST[1]     <= 1'b0;
               stream_in_TDATA[39:32]   <= 8'b00000010; //- XY coord
               stream_in_TDATA[43:40]  <= 4'h2; //- In  packet size
               stream_in_TDATA[47:44] <= 4'h4; //- Out packet size
               stream_in_TDATA[49:48] <= 'h0;  //- Unused
               stream_in_TDATA[55:50] <= 'h0;  //- Source coordinates
               stream_in_TDATA[56]    <= 1'b0; //- Unused
               stream_in_TDATA[59:57] <= MGET; //- Long packet
               stream_in_TDATA[60]    <= 1'b1; //- Long packet
               stream_in_TDATA[63:61] <= 'h0;  //- Unused
            end else begin
               stream_in_TDATA[63:32] <= $random;
   
               if (ctr == 3) begin
                  stream_in_TLAST[1] <= 1'b1;
                  pkt_r <= pkt_r +1;
               end else
                  stream_in_TLAST[1] <= 1'b0;
            end
         end else begin
            stream_in_TVALID[1]    <= 1'b0;
            stream_in_TDATA[63:32] <= 'h0;
            stream_in_TLAST[1]     <= 1'b0;
         end
      end
   end
end

logic [31:0] s_axi_arvalid_reg;

always @(posedge clk_memory) begin
   if (clk_memory_rst_high) begin
      s_axi_rvalid <= 1'b0;
      s_axi_rlast  <= 1'b0;
      s_axi_rdata  <= 'h0;
      s_axi_rid    <= 'h0;
      s_axi_rresp  <= 'h0;
      delay1        <= 'h0; 
      delay_set    <= $random;
      s_axi_arvalid_reg <= 1'b0;
   end else begin
      if (s_axi_arvalid & s_axi_rready)
         s_axi_arvalid_reg <= 1'b1;
      else if (delay1 == delay_set) begin
            s_axi_rvalid <= 1'b1;
            s_axi_rdata  <= {16{$random}};
            s_axi_rid    <= s_axi_arid;
            s_axi_rlast  <= 1'b1;
            delay1 <= 'h0;
            delay_set <= $random;
            s_axi_arvalid_reg <= 1'b0;
      end else begin 
         if (s_axi_arvalid_reg) delay1 <= delay1 + 1;
         s_axi_rvalid <= 1'b0;
         s_axi_rdata  <= 'h0;
         s_axi_rid    <= 'h0;
         s_axi_rlast  <= 1'b0;
      end        

      if (s_axi_wvalid & s_axi_bready) begin
         if (delay1 == delay_set) begin
           s_axi_bvalid <= 1'b1;
           s_axi_bresp  <= $random;
           s_axi_bid    <= s_axi_awid;
           delay1        <= 'h10;  
         end else delay1 <= delay1 + 1;
      end else begin
        s_axi_bvalid <= 1'b0;
        s_axi_bid    <= 'h0;
        s_axi_bresp  <= 'h0;
      end 
   end
end

assign s_axi_arready = 1'b1;
assign s_axi_awready = 1'b1;
assign s_axi_wready = 1'b1;


Tile_mem_mgr#(
    .AXI_ADDR (AXI_OUTADR),
    .COL      (COL)
  ) tile_mem_mgr_inst(
   .stream_in_TVALID        (stream_in_TVALID),
   .stream_in_TREADY        (stream_in_TREADY),
   .stream_in_TDATA         (stream_in_TDATA),
   .stream_in_TKEEP         (stream_in_TKEEP),
   .stream_in_TLAST         (stream_in_TLAST),
   .stream_out_TVALID       (stream_out_TVALID),
   .stream_out_TREADY       (stream_out_TREADY),
   .stream_out_TDATA        (stream_out_TDATA),
   .stream_out_TKEEP        (stream_out_TKEEP),
   .stream_out_TLAST        (stream_out_TLAST),
   //- AXI bus
   .control_S_AXI_AWADDR     (tile_S_AXI_AWADDR), 
   .control_S_AXI_AWVALID    (tile_S_AXI_AWVALID),
   .control_S_AXI_AWREADY    (tile_S_AXI_AWREADY),
   .control_S_AXI_WDATA      (tile_S_AXI_WDATA),
   .control_S_AXI_WSTRB      (tile_S_AXI_WSTRB),
   .control_S_AXI_WVALID     (tile_S_AXI_WVALID),
   .control_S_AXI_WREADY     (tile_S_AXI_WREADY),
   .control_S_AXI_BRESP      (tile_S_AXI_BRESP),
   .control_S_AXI_BVALID     (tile_S_AXI_BVALID),
   .control_S_AXI_BREADY     (tile_S_AXI_BREADY),
   .control_S_AXI_ARADDR     (tile_S_AXI_ARADDR),
   .control_S_AXI_ARVALID    (tile_S_AXI_ARVALID),
   .control_S_AXI_ARREADY    (tile_S_AXI_ARREADY),
   .control_S_AXI_RDATA      (tile_S_AXI_RDATA),
   .control_S_AXI_RRESP      (tile_S_AXI_RRESP),
   .control_S_AXI_RVALID     (tile_S_AXI_RVALID),
   .control_S_AXI_RREADY     (tile_S_AXI_RREADY),
   //- MEMORY CONTROLLER
   //- ADDRESS WRITE
   .s_axi_awready      (s_axi_awready),
   .s_axi_awvalid      (s_axi_awvalid),
   .s_axi_awid         (s_axi_awid),
   .s_axi_awaddr       (s_axi_awaddr),
   .s_axi_awlen        (s_axi_awlen),
   .s_axi_awsize       (s_axi_awsize),
   .s_axi_awburst      (s_axi_awburst),
   .s_axi_awlock       (s_axi_awlock),
   .s_axi_awcache      (s_axi_awcache),
   .s_axi_awprot       (s_axi_awprot),
   .s_axi_awqos        (s_axi_awqos),
  //- DATA WRITE
   .s_axi_wready      (s_axi_wready),
   .s_axi_wvalid      (s_axi_wvalid),
   .s_axi_wlast       (s_axi_wlast),
   .s_axi_wdata       (s_axi_wdata),
   .s_axi_wstrb       (s_axi_wstrb),
  //- VALID WRITE
   .s_axi_bready      (s_axi_bready),
   .s_axi_bvalid      (s_axi_bvalid),
   .s_axi_bid         (s_axi_bid),
   .s_axi_bresp       (s_axi_bresp),
  //- ADDRESS READ
   .s_axi_arready     (s_axi_arready),
   .s_axi_arvalid     (s_axi_arvalid),
   .s_axi_arid        (s_axi_arid),
   .s_axi_araddr      (s_axi_araddr),
   .s_axi_arlen       (s_axi_arlen),
   .s_axi_arsize      (s_axi_arsize),
   .s_axi_arburst     (s_axi_arburst),
   .s_axi_arlock      (s_axi_arlock),
   .s_axi_arcache     (s_axi_arcache),
   .s_axi_arprot      (s_axi_arprot),
   .s_axi_arqos       (s_axi_arqos),
  //- RESPONSE READ
   .s_axi_rready      (s_axi_rready),
   .s_axi_rvalid      (s_axi_rvalid),
   .s_axi_rlast       (s_axi_rlast),
   .s_axi_rdata       (s_axi_rdata),
   .s_axi_rid         (s_axi_rid),
   .s_axi_rresp       (s_axi_rresp),
  //- Clock and reset
   .clk_memory           (clk_memory),
   .clk_memory_rst_high  (clk_memory_rst_high),
   .clk_memory_rst_low   (clk_memory_rst_low),  
   .clk_control           (clk_control),
   .clk_control_rst_low  (clk_control_rst_low),
   .clk_control_rst_high (clk_control_rst_high),
   .clk_line             (clk_line),
   .clk_line_rst_high    (clk_line_rst_high),
   .clk_line_rst_low     (clk_line_rst_low));


endmodule
