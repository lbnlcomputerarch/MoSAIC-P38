//----------------------------------------------------------------------------
//   This file is owned and controlled by Xilinx and must be used solely    //
//   for design, simulation, implementation and creation of design files    //
//   limited to Xilinx devices or technologies. Use with non-Xilinx         //
//   devices or technologies is expressly prohibited and immediately        //
//   terminates your license.                                               //
//                                                                          //
//   XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" SOLELY   //
//   FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY   //
//   PROVIDING THIS DESIGN, CODE, OR INFORMATION AS ONE POSSIBLE            //
//   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR STANDARD, XILINX IS     //
//   MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION IS FREE FROM ANY     //
//   CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE FOR OBTAINING ANY      //
//   RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY      //
//   DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE  //
//   IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         //
//   REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        //
//   INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A  //
//   PARTICULAR PURPOSE.                                                    //
//                                                                          //
//   Xilinx products are not intended for use in life support appliances,   //
//   devices, or systems.  Use in such applications are expressly           //
//   prohibited.                                                            //
//                                                                          //
//   (c) Copyright 1995-2015 Xilinx, Inc.                                   //
//   All rights reserved.                                                   //
//----------------------------------------------------------------------------
// Xilinx SDNet Compiler version 2018.2, build 2896220
//----------------------------------------------------------------------------
/*
Stimulus Generation Module
*/

/////////////////////////////////////////////////////////////////
// Author      : Patricia Gonzalez-Guerrero
// Date        : April 25 2022
// Description : Distributes packets among tiles in column 0
// File        : Dispatcher.sv
// Notes       : 
//  - From USS created by Farzad F. (LBL) and Chris N. (AMD) 
////////////////////////////////////////////////////////////////


`timescale 1 ps / 1 ps
`include "global_defines.sv"

module TB_System_Stim (
	file_done,
	fw_done,
	rst,
	clk_n,
	stim_eof,
	tuple_in_valid,
	notify_in_metadata_in,
	stream_in_packet_in_TREADY,
	stream_in_packet_in_TVALID,
	stream_in_packet_in_TLAST,
	stream_in_packet_in_TKEEP,
	stream_in_packet_in_TDATA
);

input file_done ;
input fw_done ;
input rst ;
input clk_n ;
output stim_eof ;
output tuple_in_valid ;
output [127:0] notify_in_metadata_in ;
input stream_in_packet_in_TREADY ;
output stream_in_packet_in_TVALID ;
output stream_in_packet_in_TLAST ;
output [3:0] stream_in_packet_in_TKEEP ;
output [31:0] stream_in_packet_in_TDATA ;

reg [31:0] fd_tup ;
reg [31:0] fd_pkt ;
reg stim_eof ;
reg tuple_in_valid ;
reg [127:0] notify_in_metadata_in ;
reg stream_in_packet_in_TVALID ;
reg stream_in_packet_in_TLAST ;
reg [3:0] stream_in_packet_in_TKEEP ;
reg [31:0] stream_in_packet_in_TDATA ;
reg SOP ;


reg [1023:0] file1;

initial begin
    file1 = `PACKET_FILE;
end

always @( posedge file_done ) begin
  	fd_pkt <= $fopen(`PACKET_FILE, "r");
    /*
    if (fd_pkt) begin
	    $display( "file OPENED successfully at time %g", $time);
	  end else begin
	    $display( "could NOT OPEN FILE (got fd = %d)! Terminatinig at time %g", fd_pkt, $time);
	    $finish;
    end
    */
	  //fd_tup <= $fopen("Tuple_in.txt", "r") ;
end

always @( posedge clk_n ) begin
   tuple_in_valid <= 0 ;
	if ( rst ) begin
	   SOP <= 1 ;
		stim_eof <= 0 ;
		stream_in_packet_in_TLAST <= 0 ;
		stream_in_packet_in_TKEEP <= 0 ;
		stream_in_packet_in_TVALID <= 0 ;
		stream_in_packet_in_TDATA <= 0 ;
	end else  begin
		if ( ( ( stream_in_packet_in_TREADY && fw_done ) && ~stim_eof ) ) begin
		   if ( 32'h4 != $fscanf(fd_pkt, "%x %x %x %x",stream_in_packet_in_TVALID, stream_in_packet_in_TLAST, stream_in_packet_in_TKEEP, stream_in_packet_in_TDATA) ) begin
				stim_eof <= 1 ;
				$display("[%0t]  INFO: finished packet stimulus file", $time);
				stream_in_packet_in_TLAST <= 0 ;
				stream_in_packet_in_TKEEP <= 0 ;
				stream_in_packet_in_TVALID <= 0 ;
				stream_in_packet_in_TDATA <= 0 ;
			end
		end 
	end
end

endmodule

// machine-generated file - do NOT modify by hand !
// File created on 2020/06/25 13:50:48
// by Barista HDL generation library, version TRUNK @ 1007984

