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
// //----------------------------------------------------------------------------
/*

*/

`timescale 1 ps / 1 ps

module TileRegBlock (
	aresetn,
	aclk,
	awaddr,
	awvalid,
	awready,
	wdata,
	wstrb,
	wvalid,
	wready,
	bready,
	bresp,
	bvalid,
	araddr,
	arvalid,
	arready,
	rready,
	rdata,
	rresp,
	rvalid,
	csrTileStatus_UpdEn,
	csrTileStatus_UpdData,
	csrTileCommandOp_SwWrNotify,
	csrTileCommandOp,
	csrTileAddr,
	csrTileData,
	csrTileData_UpdEn,
	csrTileData_UpdData,
	csrTileCoordinates_SwWrNotify,
	csrTileCoordinates,
	csrTileRxPacketCount_UpdEn,
	csrTileRxPacketCount_UpdData,
	csrTileRxByteCount_UpdEn,
	csrTileRxByteCount_UpdData
);

input aresetn ;
input aclk ;
input [7:0] awaddr ;
input awvalid ;
output awready ;
input [31:0] wdata ;
input [3:0] wstrb /* unused */ ;
input wvalid ;
output wready ;
input bready ;
output [1:0] bresp ;
output bvalid ;
input [7:0] araddr ;
input arvalid ;
output arready ;
input rready ;
output [31:0] rdata ;
output [1:0] rresp ;
output rvalid ;
input csrTileStatus_UpdEn ;
input [7:0] csrTileStatus_UpdData ;
output csrTileCommandOp_SwWrNotify ;
output [7:0] csrTileCommandOp ;
//FIXME LPGG
//output [7:0] csrTileAddr ;
output [31:0] csrTileAddr ;

output [31:0] csrTileData ;
input csrTileData_UpdEn ;
input [31:0] csrTileData_UpdData ;
output csrTileCoordinates_SwWrNotify ;
output [31:0] csrTileCoordinates ;
input csrTileRxPacketCount_UpdEn ;
input [31:0] csrTileRxPacketCount_UpdData ;
input csrTileRxByteCount_UpdEn ;
input [31:0] csrTileRxByteCount_UpdData ;

reg awready ;
reg wready ;
wire [1:0] bresp ;
reg bvalid ;
reg arready ;
reg [31:0] rdata ;
wire [1:0] rresp ;
reg rvalid ;
reg csrTileCommandOp_SwWrNotify ;
wire [7:0] csrTileCommandOp ;
wire [31:0] csrTileAddr ;
wire [31:0] csrTileData ;
reg csrTileCoordinates_SwWrNotify ;
wire [31:0] csrTileCoordinates ;
wire wren_pulse ;
(* KEEP = "TRUE" *) reg wren_d1 ;
(* KEEP = "TRUE" *) reg wren_d2 ;
(* KEEP = "TRUE" *) reg wren_d3 ;
(* KEEP = "TRUE" *) reg rden_d1 ;
(* KEEP = "TRUE" *) reg rden_d2 ;
wire addrDecode_Command ;
wire addrDecode_Addr ;
wire addrDecode_Data ;
wire addrDecode_Coordinates ;
reg [7:0] Status_ ;
reg [31:0] readData_Status ;
reg [7:0] Command_Op ;
reg [31:0] readData_Command ;
reg [31:0] Addr_ ;
reg [31:0] readData_Addr ;
reg [31:0] Data_ ;
reg [31:0] readData_Data ;
reg [31:0] Coordinates_ ;
reg [31:0] readData_Coordinates ;
reg [31:0] RxPacketCount_ ;
reg [31:0] readData_RxPacketCount ;
reg [31:0] RxByteCount_ ;
reg [31:0] readData_RxByteCount ;
reg wack_i ;
(* KEEP = "TRUE" *) reg wack_r ;
(* KEEP = "TRUE" *) reg wack_r1 ;
reg rack_i ;
(* KEEP = "TRUE" *) reg rack_r ;
(* KEEP = "TRUE" *) reg rack_r1 ;

assign bresp = 2'd0 ;

assign rresp = 2'd0 ;

always @( posedge aclk ) begin
	wren_d1 <= ( awvalid & wvalid ) ;
end

always @( posedge aclk ) begin
	wren_d2 <= wren_d1 ;
end

always @( posedge aclk ) begin
	wren_d3 <= wren_d2 ;
end

assign wren_pulse = ( wren_d2 & ~wren_d3 ) ;

always @( posedge aclk ) begin
	rden_d1 <= arvalid ;
end

always @( posedge aclk ) begin
	rden_d2 <= rden_d1 ;
end

assign addrDecode_Command = ( awaddr == 4 ) ;

assign addrDecode_Addr = ( awaddr == 8 ) ;

assign addrDecode_Data = ( awaddr == 12 ) ;

assign addrDecode_Coordinates = ( awaddr == 16 ) ;

always @( posedge aclk ) begin
	if ( ~aresetn ) begin
		Status_ <= 8'd0 ;
	end
	else  begin
		if ( csrTileStatus_UpdEn ) begin
			Status_ <= csrTileStatus_UpdData ;
		end
	end
end

always @* begin
	readData_Status = 32'h0 ;
	readData_Status[7:0] = Status_ ;
end

always @( posedge aclk ) begin
	csrTileCommandOp_SwWrNotify <= ( wren_pulse & addrDecode_Command ) ;
end

always @( posedge aclk ) begin
	if ( ~aresetn ) begin
		Command_Op <= 8'd0 ;
	end
	else  begin
		if ( ( wren_pulse & addrDecode_Command ) ) begin
			Command_Op <= wdata[7:0] ;
		end
	end
end

assign csrTileCommandOp = Command_Op ;

always @* begin
	readData_Command = 32'h0 ;
	readData_Command[7:0] = Command_Op ;
end

always @( posedge aclk ) begin
	if ( ~aresetn ) begin
		Addr_ <= 32'h0 ;
	end
	else  begin
		if ( ( wren_pulse & addrDecode_Addr ) ) begin
			Addr_ <= wdata[31:0] ;
		end
	end
end

assign csrTileAddr = Addr_ ;

always @* begin
	readData_Addr = 32'h0 ;
	readData_Addr[31:0] = Addr_ ;
end

always @( posedge aclk ) begin
	if ( ~aresetn ) begin
		Data_ <= 32'h0 ;
	end
	else  begin
		if ( ( wren_pulse & addrDecode_Data ) ) begin
			Data_ <= wdata[31:0] ;
		end
		if ( csrTileData_UpdEn ) begin
			Data_ <= csrTileData_UpdData ;
		end
	end
end

assign csrTileData = Data_ ;

always @* begin
	readData_Data = 32'h0 ;
	readData_Data[31:0] = Data_ ;
end

always @( posedge aclk ) begin
	csrTileCoordinates_SwWrNotify <= ( wren_pulse & addrDecode_Coordinates ) ;
end

always @( posedge aclk ) begin
	if ( ~aresetn ) begin
		Coordinates_ <= 32'h0 ;
	end
	else  begin
		if ( ( wren_pulse & addrDecode_Coordinates ) ) begin
			Coordinates_ <= wdata[31:0] ;
		end
	end
end

assign csrTileCoordinates = Coordinates_ ;

always @* begin
	readData_Coordinates = 32'h0 ;
	readData_Coordinates[31:0] = Coordinates_ ;
end

always @( posedge aclk ) begin
	if ( ~aresetn ) begin
		RxPacketCount_ <= 32'h0 ;
	end
	else  begin
		if ( csrTileRxPacketCount_UpdEn ) begin
			RxPacketCount_ <= csrTileRxPacketCount_UpdData ;
		end
	end
end

always @* begin
	readData_RxPacketCount = 32'h0 ;
	readData_RxPacketCount[31:0] = RxPacketCount_ ;
end

always @( posedge aclk ) begin
	if ( ~aresetn ) begin
		RxByteCount_ <= 32'h0 ;
	end
	else  begin
		if ( csrTileRxByteCount_UpdEn ) begin
			RxByteCount_ <= csrTileRxByteCount_UpdData ;
		end
	end
end

always @* begin
	readData_RxByteCount = 32'h0 ;
	readData_RxByteCount[31:0] = RxByteCount_ ;
end

always @( posedge aclk ) begin
	if ( ( ~aresetn || ~wren_d2 ) ) begin
		wack_i <= 0 ;
	end
	else  begin
		if ( wren_d2 ) begin
			case ( awaddr )
				default : begin
					wack_i <= 1'd1 ;
				end
			endcase
		end
	end
end

always @( posedge aclk ) begin
	wack_r <= wack_i ;
end

always @( posedge aclk ) begin
	wack_r1 <= wack_r ;
end

always @( posedge aclk ) begin
	if ( ( ~aresetn || ~rden_d2 ) ) begin
		rack_i <= 0 ;
	end
	else  begin
		if ( rden_d2 ) begin
			case ( araddr )
				default : begin
					rack_i <= 1'd1 ;
				end
			endcase
		end
	end
end

always @( posedge aclk ) begin
	rack_r <= rack_i ;
end

always @( posedge aclk ) begin
	rack_r1 <= rack_r ;
end

always @( posedge aclk ) begin
	if ( ~aresetn ) begin
		awready <= 1'd0 ;
		wready <= 1'd0 ;
		bvalid <= 1'd0 ;
	end
	else  begin
		if ( ( ( ( awvalid & wvalid ) & wack_r ) & ~wack_r1 ) ) begin
			awready <= 1'd1 ;
			wready <= 1'd1 ;
		end
		else  begin
			awready <= 1'd0 ;
			wready <= 1'd0 ;
		end
		if ( ( ( ( ( awvalid & wvalid ) & ~bvalid ) & awready ) & wready ) ) begin
			bvalid <= 1'd1 ;
		end
		else  begin
			if ( bready ) begin
				bvalid <= 1'd0 ;
			end
		end
	end
end

always @( posedge aclk ) begin
	if ( ~aresetn ) begin
		arready <= 1'd0 ;
		rvalid <= 1'd0 ;
	end
	else  begin
		if ( ( ( arvalid & rack_r ) & ~rack_r1 ) ) begin
			arready <= 1'd1 ;
		end
		else  begin
			arready <= 1'd0 ;
		end
		if ( ( arvalid & arready ) ) begin
			rvalid <= 1'd1 ;
		end
		else  begin
			if ( rready ) begin
				rvalid <= 1'd0 ;
			end
		end
	end
end

always @( posedge aclk ) begin
	if ( ~aresetn ) begin
		rdata <= 32'h0 ;
	end
	else  begin
		if ( ( rack_i & ~rack_r ) ) begin
			case ( araddr )
				0 : begin
					rdata <= readData_Status ;
				end
				4 : begin
					rdata <= readData_Command ;
				end
				8 : begin
					rdata <= readData_Addr ;
				end
				12 : begin
					rdata <= readData_Data ;
				end
				16 : begin
					rdata <= readData_Coordinates ;
				end
				20 : begin
					rdata <= readData_RxPacketCount ;
				end
				24 : begin
					rdata <= readData_RxByteCount ;
				end
				default : begin
					rdata <= 32'h0 ;
				end
			endcase
		end
	end
end


endmodule

// machine-generated file - do NOT modify by hand !
// File created on 2020/06/28 16:43:16
// by Barista HDL generation library, version TRUNK @ 1007984

