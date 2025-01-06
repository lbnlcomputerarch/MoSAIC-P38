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

/////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : April 19 2022
// Description : MoSAIC testbench
// File        : tb_mosaic.sv
// Notes       : 
//  - From USS by Farzad F (LBL) and Chris N (AMD).
//  - Modifications to initialize tiles using for loops
//  - Modifications to use defines for certain include files 
//  - Add testbench for memory controller
////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps
`include "global_defines.sv"

module tb_mosaic;

localparam ROW       = `ROW;
localparam COL       = `COL;
localparam TILES     = ROW*COL;
localparam AXI_TILES = `AXI_TILES;
localparam BW        = `NOC_BW;
localparam BWB       = BW/8;

///////////////////////////
//- Dump file for i-verilog
///////////////////////////

initial begin
   if ($test$plusargs("vcd")) begin
      $dumpfile("tb_mosaic.vcd");
      $dumpvars(6, tb_mosaic);
   end
end

//////////////////////////////////////
//- Declare wires
///////////////////////////////////

logic clk_line;
logic clk_control;
logic clk_line_rst;
logic clk_control_rst;

logic [11:0] control_S_AXI_AWADDR;
logic        control_S_AXI_AWVALID;
logic [31:0] control_S_AXI_WDATA;
logic  [3:0] control_S_AXI_WSTRB;
logic        control_S_AXI_WVALID;
logic        control_S_AXI_BREADY;
logic [11:0] control_S_AXI_ARADDR;
logic        control_S_AXI_ARVALID;
logic        control_S_AXI_RREADY;
logic        control_S_AXI_AWREADY;
logic        control_S_AXI_WREADY;
logic  [1:0] control_S_AXI_BRESP;
logic        control_S_AXI_BVALID;
logic        control_S_AXI_ARREADY;
logic [31:0] control_S_AXI_RDATA;
logic  [1:0] control_S_AXI_RRESP;
logic        control_S_AXI_RVALID;


logic        stream_in_packet_in_TVALID;
logic        stream_in_packet_in_TREADY;
logic [BW-1:0] stream_in_packet_in_TDATA;
logic  [BWB-1:0] stream_in_packet_in_TKEEP;
logic        stream_in_packet_in_TLAST;

logic        stream_out_packet_out_TVALID ;
logic        stream_out_packet_out_TREADY ;
logic [BW-1:0] stream_out_packet_out_TDATA ;
logic  [BWB-1:0] stream_out_packet_out_TKEEP ;
logic        stream_out_packet_out_TLAST ;

logic         notify_in_metadata_in_VALID;
logic [127:0] notify_in_metadata_in_DATA;
logic         notify_out_metadata_out_VALID ;
logic [127:0] notify_out_metadata_out_DATA ;

logic enable_processing;
logic internal_rst_done;
logic fw_done;
logic stim_file;
logic stim_eof;
logic tuple_in_valid;
logic check_eof;
logic tuple_out_valid;
logic packet_out_avail;
logic firstPacketOut;
logic [31:0] idleCount;

logic c0_init_calib_complete;

`ifdef DDR4_CTRL

  ////////////////////////////////////////////
  //- Emulating the memory controller
  ////////////////////////////////////////////

  parameter S_AXI_ID_SZ  = 11;
  parameter S_AXI_ADR_SZ = 34; // ADDRESS
  parameter S_AXI_LEN_SZ = 8;  // LENGTH
  parameter S_AXI_SZE_SZ = 3;  // SIZE
  parameter S_AXI_BRT_SZ = 2;  // BURST
  parameter S_AXI_DAT_SZ = 512;// DATA
  parameter S_AXI_STB_SZ = 64; // STROBE
  parameter S_AXI_RSP_SZ = 2;  // RESPONSE
  parameter S_AXI_CAC_SZ = 4;  // RESPONSE
  parameter S_AXI_PRT_SZ = 3;  // RESPONSE
  parameter S_AXI_QOS_SZ = 4;   // RESPONSE

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

  logic clk_memory;
  logic clk_memory_rst;


  tb_memory_controller tb_memory_controller(
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
    .c0_init_calib_complete (c0_init_calib_complete),
    //- Clock & Reset
    .clk_memory_rst    (clk_memory_rst),
    .clk_memory        (clk_memory)
  );
`else
initial 
  c0_init_calib_complete = 1;
`endif


//////////////////////////////////////
//- Instantiate the DUT
///////////////////////////////////

mosaic mosaic (
   .stream_in_packet_in_TVALID   (stream_in_packet_in_TVALID),
   .stream_in_packet_in_TREADY   (stream_in_packet_in_TREADY),
   .stream_in_packet_in_TDATA    (stream_in_packet_in_TDATA),
   .stream_in_packet_in_TKEEP    (stream_in_packet_in_TKEEP),
   .stream_in_packet_in_TLAST    (stream_in_packet_in_TLAST),
   .notify_in_metadata_in_VALID  (notify_in_metadata_in_VALID),
   .notify_in_metadata_in_DATA   (notify_in_metadata_in_DATA),
   .control_S_AXI_AWADDR         (control_S_AXI_AWADDR),
   .control_S_AXI_AWVALID        (control_S_AXI_AWVALID),
   .control_S_AXI_AWREADY        (control_S_AXI_AWREADY),
   .control_S_AXI_WDATA          (control_S_AXI_WDATA),
   .control_S_AXI_WSTRB          (control_S_AXI_WSTRB),
   .control_S_AXI_WVALID         (control_S_AXI_WVALID),
   .control_S_AXI_WREADY         (control_S_AXI_WREADY),
   .control_S_AXI_BRESP          (control_S_AXI_BRESP),
   .control_S_AXI_BVALID         (control_S_AXI_BVALID),
   .control_S_AXI_BREADY         (control_S_AXI_BREADY),
   .control_S_AXI_ARADDR         (control_S_AXI_ARADDR),
   .control_S_AXI_ARVALID        (control_S_AXI_ARVALID),
   .control_S_AXI_ARREADY        (control_S_AXI_ARREADY),
   .control_S_AXI_RDATA          (control_S_AXI_RDATA),
   .control_S_AXI_RRESP          (control_S_AXI_RRESP),
   .control_S_AXI_RVALID         (control_S_AXI_RVALID),
   .control_S_AXI_RREADY         (control_S_AXI_RREADY),
   .enable_processing            (enable_processing),
   .stream_out_packet_out_TVALID (stream_out_packet_out_TVALID),
   .stream_out_packet_out_TREADY (stream_out_packet_out_TREADY),
   .stream_out_packet_out_TDATA  (stream_out_packet_out_TDATA),
   .stream_out_packet_out_TKEEP  (stream_out_packet_out_TKEEP),
   .stream_out_packet_out_TLAST  (stream_out_packet_out_TLAST),
    //- MEMORY CONTROLLER
   `ifdef DDR4_CTRL
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
    .clk_memory_rst    (clk_memory_rst),
    .clk_memory        (clk_memory),
  `endif
   .notify_out_metadata_out_VALID (notify_out_metadata_out_VALID ),
   .notify_out_metadata_out_DATA  (notify_out_metadata_out_DATA ),
   .clk_line_rst                  (clk_line_rst),
   .clk_line                      (clk_line),
   .clk_control_rst               (clk_control_rst),
   .clk_control                   (clk_control),
   .internal_rst_done             (internal_rst_done)
);


////////////////////////////////////////////
//- Drive packets in, emulating ethernet port
////////////////////////////////////////////

assign stream_out_packet_out_TREADY = 1'd1;
assign enable_processing = 1'd1;

TB_System_Stim TB_System_Stim_i (
   .notify_in_metadata_in        (notify_in_metadata_in_DATA),
   .clk_n                        (clk_line),
   .rst                          (clk_line_rst),
   .fw_done                      (fw_done),
   .file_done                    (stim_file),
   .stim_eof                     (stim_eof),
   .tuple_in_valid               (tuple_in_valid),
   .stream_in_packet_in_TREADY   (stream_in_packet_in_TREADY),
   .stream_in_packet_in_TVALID   (stream_in_packet_in_TVALID),
   .stream_in_packet_in_TLAST    (stream_in_packet_in_TLAST),
   .stream_in_packet_in_TKEEP    (stream_in_packet_in_TKEEP),
   .stream_in_packet_in_TDATA    (stream_in_packet_in_TDATA));

assign notify_in_metadata_in_VALID = tuple_in_valid;

////////////////////////////////////////////
//- Clocks and resets
////////////////////////////////////////////

always begin 
  #(4000 / 2) clk_line =  0;     // 4000ps = 4ns 
  #(4000 / 2) clk_line =  1; 
end

always begin 
  #(8000 / 2) clk_control =  0;  // 8000ps = 8ns
  #(8000 / 2) clk_control =  1; 
end

initial begin 
clk_line_rst = 1; 
#1000000 clk_line_rst = 0; 
end 

initial begin 
clk_control_rst = 1; 
#1000000 clk_control_rst = 0; 
end 

integer i;

////////////////////////////////////////////
//- Drive signals in initial
////////////////////////////////////////////

logic check_done;
logic sim_done;

initial begin

    fw_done             = 0;
    stim_file           = 1; //- Disble packets comming from file

    sim_done   = 0;
    check_done = 0;

    wait(internal_rst_done);

    #10000
    coordinates_init();

    #10000
    initialize_memory_AXI();
    
    #10000
    set_pico();
    
    wait(c0_init_calib_complete);
    
    $display( "Injecting Packets through dispatcher %g", $time);
    #10000 fw_done = 1;

    for (i=0; i<`SIM_LOOP; i=i+1) begin
      #500000 $display( "Watchdog timeout %g", $time);
    end
    #500000 $display( "Simulation done %g", $time);

    sim_done = 1;

    #500000 $display("Killing simulation %g", $time);
    
    wait(check_done);
    $finish;
end

`include "checker.vh"

////////////////////////////////////////////
//- Tasks and interfaces with DPI-C
//  It does not work for i-verilog 
////////////////////////////////////////////

reg [1:0] read_resp;
reg [1:0] bresp;

//- Uncomment if using C
//import "DPI-C" context task test_from_dpi();
//export "DPI-C" task SV_read_control_mytable;
//export "DPI-C" task SV_write_control_mytable;

////////////////////////////////////////////
//- Task 1) SV_write_control_mytable
////////////////////////////////////////////
task SV_write_control_mytable (
   input  integer  addr,
   input  integer  data
);
integer rWrittenData;
$display("[%m AXI] SV_write_control_mytable()- start: writing 0x%X to address 0x%X", data, addr);
axi4_lite_master_write_request_control_mytable(addr,data);
$display("[%m AXI] SV_write_control_mytable()- wrote: 0x%X to address 0x%X", data, addr);
axi4_lite_master_read_request_control_mytable(addr, rWrittenData);
$display("[%m AXI] SV_write_control_mytable()- readback: 0x%X", rWrittenData);
$display("[%m AXI] SV_write_control_mytable()- done");
endtask

////////////////////////////////////////////
//- Task 2) SV_read_control_mytable
////////////////////////////////////////////
task SV_read_control_mytable(
   input  integer addr,
   output integer data
);
$display("[%m - AXI] SV_read_control_mytable()- start: reading from address 0x%X", addr);
axi4_lite_master_read_request_control_mytable(addr,data);
$display("[%m - AXI] SV_read_control_mytable()- done: 0x%X", data);
endtask

////////////////////////////////////////////
//- Task 3) axi4_lite_master_write_request_control_mytable 
////////////////////////////////////////////
task  axi4_lite_master_write_request_control_mytable(input integer addr,input integer data);
    $display("[%m AXI] - addr: 0x%x | data: 0x%x", addr, data);
    @ (posedge clk_control);
        control_S_AXI_AWADDR  <= addr;
        control_S_AXI_AWVALID <= 1'b1;
        control_S_AXI_WDATA   <= data;
        control_S_AXI_WVALID  <= 1'b1;
        control_S_AXI_WSTRB   <= '1;
        $display("[%m AXI] - axi4_lite_master_write_request_control_mytable");
        fork
            begin
                $display("[%m AXI] B - AWADDR: 0x%X | AWVALID: 0x%x | AWREADY: 0x%x", control_S_AXI_AWADDR, control_S_AXI_AWVALID, control_S_AXI_AWREADY);
                wait(control_S_AXI_AWREADY);
                $display("[%m AXI] A - AWADDR: 0x%X | AWVALID: 0x%x | AWREADY: 0x%x", control_S_AXI_AWADDR, control_S_AXI_AWVALID, control_S_AXI_AWREADY);
                @ (posedge clk_control);
                control_S_AXI_AWVALID <= 1'b0;
            end
            begin
                wait(control_S_AXI_WREADY);
                $display("[%m AXI]   -  WDATA: 0x%X |  WVALID: 0x%x |  WREADY: 0x%x", control_S_AXI_WDATA, control_S_AXI_WVALID, control_S_AXI_WREADY);
                @ (posedge clk_control);
                control_S_AXI_WVALID <= 1'b0;
                control_S_AXI_BREADY <= 1'b1;
                wait(control_S_AXI_BVALID);
                bresp  <= control_S_AXI_BRESP;
                @ (posedge clk_control);
                control_S_AXI_BREADY <= 1'b0;
                wait(~control_S_AXI_BVALID);
            end
        join
endtask: axi4_lite_master_write_request_control_mytable

////////////////////////////////////////////
//- Task 4) axi4_lite_master_read_request_control_mytable 
////////////////////////////////////////////
task  axi4_lite_master_read_request_control_mytable(input integer addr,output integer data);
    @ (posedge clk_control);
        control_S_AXI_ARADDR  <= addr;
        control_S_AXI_ARVALID <= 1'b1;
        control_S_AXI_RREADY <= 1'b1;
        begin
            wait(control_S_AXI_RVALID);
            read_resp  <= control_S_AXI_RRESP;
            data  <= control_S_AXI_RDATA;
            @ (posedge clk_control);
            control_S_AXI_ARVALID    <= 1'b0;
            wait(~control_S_AXI_RVALID);
        end
endtask: axi4_lite_master_read_request_control_mytable

////////////////////////////////////////////
//- Task 5) update_from_file
////////////////////////////////////////////
task update_from_file(input string file_name);
    integer fileid;
    integer count;
    //string  line; LPGG
    reg [32*8-1:0] line;
    integer index;
    string key[];
    int address[];
    string value[];
    string temp_key;
    int temp_address;
    string temp_value;

    fileid = $fopen(file_name, "r");
    if (fileid == 0) begin
        $display($sformatf("failed to open %s file",file_name));
        $finish;
    end
    index = 0;
    while(!$feof(fileid)) begin
        if($fgets(line, fileid)) begin
            if (line[0] != "#") begin //not a commented line
                //count = $sscanf(line, "%s %s", temp_key,temp_value); LPGG
                //FIXME
                if (count != 2) begin
                    $display("error in %s:%d : invalid format of string %s, expected key(hex) value(hex)\n", file_name, index, line);
                    $finish;
                end
                index = index + 1;
            end
        end
    end
    $fclose(fileid);
    key = new[index];
    value = new[index];

    index = 0;
    fileid = $fopen(file_name, "r");
    while(!$feof(fileid)) begin
        if($fgets(line, fileid)) begin
            if (line[0] != "#") begin //not a commented line
                //count = $sscanf(line, "%s %s", key[index],value[index]);
                //LPGG FIXME
                index = index + 1;            
            end
        end
    end
    $fclose(fileid);
    for (int i=0;i <index;i++)  begin
        $display("CAM UPDATE %d: KEY(hex) = %s VALUE(hex) = %s",i,key[i],value[i]);
        // call some function from user.c, for example:
        //CAM_WriteEntry (0, key[i], value[i], 0);
    end
endtask :  update_from_file

////////////////////////////////////////////
//- Task 6) coordinates_init()
////////////////////////////////////////////
task coordinates_init;

   integer addr;
   integer data;

   integer coord_addr_a [0:AXI_TILES-1];
   integer coord_data_a [0:AXI_TILES-1];

   $readmemh(`COORD_ADR, coord_addr_a);
   $readmemb(`DATA_ADR, coord_data_a);

   for (i=0; i<TILES; i=i+1) begin
      addr = coord_addr_a[i];
      data = coord_data_a[i];
      $display("[%m AXI] READ from tile reg addr %d: = VALUE(hex) = %x",addr,data);
      SV_write_control_mytable(addr, data);
   end

   `ifdef DDR4_CTRL
      addr = coord_addr_a[TILES];
      data = coord_data_a[TILES];
      $display("[%m AXI] READ from tile reg addr %d: = VALUE(hex) = %x",addr,data);
      SV_write_control_mytable(addr, data);
   `endif

endtask

////////////////////////////////////////////
//- Task 7) set_pico()
////////////////////////////////////////////
task set_pico;

   integer addr;
   integer data;

   integer coord_addr_a [0:TILES];

   $readmemh(`COORD1_ADR, coord_addr_a);

   `ifdef DDR4_CTRL
      initialize_tile_AXI(coord_addr_a[TILES]);
   `endif

   for (i=0; i<TILES; i=i+1) begin
      addr = coord_addr_a[i];
      initialize_tile_AXI(addr);
   end


endtask

////////////////////////////////////////////
//- Task 8) initialize_tile_AXI
////////////////////////////////////////////
task initialize_tile_AXI(input integer mask);
  integer addr;
  integer data;

  addr = 32'h0000000C | mask;
  data = 32'h0001;
  $display("[%m AXI] WRITE to tile reg addr %d: = VALUE(hex) = %x",addr,data);
  SV_write_control_mytable(addr, data);

  addr = 32'h00000004 | mask;
  data = 32'h0004;
  $display("[%m AXI] WRITE to tile reg addr %d: = VALUE(hex) = %x",addr,data);
  SV_write_control_mytable(addr, data);
endtask : initialize_tile_AXI

////////////////////////////////////////////
//- Task 9) initialize_mem_tile_AXI
////////////////////////////////////////////
task initialize_mem_tile_AXI(input string file_name, input integer mask);
   integer addr;
   integer data;
   integer fileid;
   integer count;
   integer index;

   reg [(4*18)-1:0] line;

   //- Open file for reading or finish if can't 
   fileid = $fopen(file_name, "r");
   if (fileid == 0) begin
      $display($sformatf("failed to open %s file",file_name));
      $finish;
   end

   //- Go through the file, pushing each word through AXI
   index = 'h000000;
 
   while(!$feof(fileid)) begin
      if($fgets(line, fileid)) begin
         /*
         $display("INFO: THE LINE %s", line);
         $display("INFO: LINE[7:0] %s", line[7:0]);
         $display("INFO: LINE[15:8] %s", line[15:8]);
         $display("INFO: LINE[23:16] %s", line[23:16]);
         $display("INFO: LINE[31:24] %s", line[31:24]);
         $display("INFO: LINE[39:32] %s", line[39:32]);
         $display("INFO: LINE[47:40] %s", line[47:40]);
         $display("INFO: LINE[55:48] %s", line[55:48]);
         $display("INFO: LINE[63:56] %s", line[63:56]);
         $display("INFO: LINE[71:64] %s", line[71:64]);
         $display("INFO: LINE[71:64] %d", line[71:64]);
         */
         if (line[71:64] == 0) begin
            count = $sscanf(line, "%x", data);
            $display("INFO: Ignore empty line: %x", data);
         end else if (line[71:64] == 64) begin
            line[71:64] = 48;
            count = $sscanf(line, "%x", index);
            $display("INFO: SSCANF RESULT for address LOOKATME: %x",index);
            $display("INFO: DONE getting address %d. Do not send AXI data", index);
         end else if (line[71:64] != 35) begin //not a commented line
            addr = 32'h00000008 | mask;
            data = index;
            $display("[%m AXI] WRITE to tile reg addr %d: = VALUE(hex) = %x",addr,data);
            SV_write_control_mytable(addr, data);
            count = $sscanf(line, "%x", data);
            $display("INFO: SSCANF RESULT: %x",data);
            addr = 32'h0000000C | mask;
            $display("[%m AXI] WRITE to tile reg addr %d: = VALUE(hex) = %x",addr,data);
            SV_write_control_mytable(addr,data);
            addr = 32'h00000004 | mask;
            data = 32'h0001; //OP_WRITE
            $display("[%m AXI] WRITE to tile reg addr %d: = VALUE(hex) = %x",addr,data);
            SV_write_control_mytable(addr, data);
            $display("INFO: DONE WRITING MEMORY LINE %d", index);
            index = index+1;
         end 
      end
   end

  //- LPGG May 8th 2023
  addr = 32'h00000004 | mask;
  data = 32'h0000; //Reset the OP
  $display("[%m AXI] WRITE to tile reg addr %d: = VALUE(hex) = %x",addr,data);
  SV_write_control_mytable(addr, data);
endtask : initialize_mem_tile_AXI

////////////////////////////////////////////
//- Task 10) initialize_memory_AXI
////////////////////////////////////////////
task initialize_memory_AXI;
   `include `LOAD_PICO_FW
endtask : initialize_memory_AXI

////////////////////////////////////////////
//- Task 11) read_memory_AXI
////////////////////////////////////////////
task read_memory_AXI;
   /* FIXME: Not sure how to get the data in the AXI bus */
   integer data;
   integer addr;
   integer ma;
   integer mask = 32'h00000300;

   for (ma=0; ma<20; ma=ma+1) begin
      //- Write address
      addr = 32'h00000008 | mask;
      data = ma;
      $display("[%m AXI] WRITE to tile reg addr %d: = VALUE(hex) = %x",addr,data);
      SV_write_control_mytable(addr, data);

      addr = 32'h00000004 | mask;
      data = 32'h00000002; //OP_READ
      $display("[%m AXI] WRITE to tile reg addr %d: = VALUE(hex) = %x",addr,data);
      SV_write_control_mytable(addr, data);

      addr = 32'h0000000C | mask;
      SV_read_control_mytable(addr, data);
      $display("INFO: DONE READING MEMORY LINE %d", ma);
   end 
   check_done = 1;
endtask

endmodule

