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
//----------------------------------------------------------------------------


//----------------------------------------------------------------------------
// File name: S_RESETTER_line.v
// File created: 2020/06/25 13:50:47
// Created by: Xilinx SDNet Compiler version 2018.2, build 2896220

//----------------------------------------------------------------------------

/////////////////////////////////////////////////////////////////
// Author      : --
// Date        : April 25 2022
// Description : Generates active high and low resets
// File        : S_RESETTER_line.sv
// Notes       : 
//  - Taken from USS created by Farzad F. (LBL), and
//    Chris N. (AMD). TBD add the link to the original USS
////////////////////////////////////////////////////////////////

`timescale 1 ns / 100 ps

module S_RESETTER_line (


     reset_out_active_high, 
     reset_out_active_low, 
     init_done, 

     clk, 
     rst 

);

//-------------------------------------------------------------
// I/O
//-------------------------------------------------------------
 output		reset_out_active_high ;
 output		reset_out_active_low ;
 output	reg	init_done ;
 input		clk ;
 input		rst ;






//-------------------------------------------------------------
// Signals
//-------------------------------------------------------------
 reg	reset_high_i1;	 initial reset_high_i1 = 1'b0 ;
 reg	reset_high_i2;	 initial reset_high_i2 = 1'b0 ;
 reg [4:0] assertion_cntr;	 initial assertion_cntr = 5'b00000 ;
 reg [6:0] wait_cntr;	 initial wait_cntr = 7'b0000000 ;
 wire	reset_high_i2a ;
 reg	reset_high_i3;	 initial reset_high_i3 = 1'b1 ;
 reg	reset_low_i3;	 initial reset_low_i3 = 1'b0 ;
 reg	reset_high_i4;	 initial reset_high_i4 = 1'b1 ;
 reg	reset_low_i4;	 initial reset_low_i4 = 1'b0 ;
 wire [4:0] assertion_cnt_plus ;
 wire [6:0] wait_cnt_plus ;
 wire	assertion_cntr_greater_than_zero ;
 wire	rst_or_rst_high_i2 ;
 wire	rst_or_assertion_cntr ;
 wire	assertion_cntEn ;
 wire	assertion_rstEn ;
 wire	wait_cntEn ;
 wire	wait_rstEn ;
 wire	logic_one ;
 wire	logic_zero ;
 wire	reset_low_i2a ;
 wire	init_done_i ;
 wire	clockgen_locked_i ;


//-------------------------------------------------------------
// Signal Assignments 
//-------------------------------------------------------------
 assign assertion_cnt_plus = 
	assertion_cntr + 1 ;
 assign wait_cnt_plus = 
	wait_cntr + 1 ;
 assign assertion_cntr_greater_than_zero = (
	((assertion_cntr > 5'b00000))?1'b1:
	0)  ;
 assign rst_or_rst_high_i2 = 
	rst | reset_high_i2 ;
 assign rst_or_assertion_cntr = 
	rst_or_rst_high_i2 | assertion_cntr_greater_than_zero ;
 assign assertion_cntEn = (
	((reset_high_i2 == 1'b1) && (clockgen_locked_i == 1'b1) && (assertion_cntr == 5'b00000))?1'b1:
	((assertion_cntr != 5'b00000) && (reset_high_i2 != 1'b1))?1'b1:
	0)  ;
 assign assertion_rstEn = (
	((reset_high_i1 == 1'b1))?1'b1:
	0)  ;
 assign wait_cntEn = (
	((assertion_cntr == 5'b01111) && (reset_high_i2 != 1'b1) && (clockgen_locked_i == 1'b1))?1'b1:
	((wait_cntr != 7'b0000000) && (wait_cntr != 7'b0111111) && (reset_high_i2 != 1'b1) && (clockgen_locked_i == 1'b1))?1'b1:
	0)  ;
 assign wait_rstEn = (
	((wait_cntr == 7'b0111111))?1'b1:
	0)  ;
 assign logic_one = 
	1'b1 ;
 assign logic_zero = 
	1'b0 ;
 assign reset_low_i2a = 
	 ~(reset_high_i2a) ;
 assign init_done_i = (
	((wait_cntr == 7'b0111111))?1'b1:
	0)  ;
 assign clockgen_locked_i = 
	1'b1 ;
 assign reset_out_active_high 	= reset_high_i4 ;
 assign reset_out_active_low 	= reset_low_i4 ;


//-------------------------------------------------------------
// Select  
//-------------------------------------------------------------

assign reset_high_i2a = (
	((rst_or_assertion_cntr == 1'b1) && (assertion_cntr < 5'b10000))?logic_one :
1'b0) ;



//-------------------------------------------------------------
// Flops 
//-------------------------------------------------------------

always @(posedge clk)
begin
		reset_high_i1 <= rst ;
		reset_high_i2 <= reset_high_i1 ;
	if (assertion_rstEn) 
	begin 
	  assertion_cntr <= 5'b00000 ;
	 end 
	else 
	begin 
		if (assertion_cntEn) 
		begin 
			assertion_cntr <= assertion_cnt_plus ;
		end 
	end 
	if (assertion_rstEn) 
	begin 
	  wait_cntr <= 7'b0000000 ;
	 end 
	else 
	begin 
		if (wait_cntEn) 
		begin 
			wait_cntr <= wait_cnt_plus ;
		end 
	end 
	if (rst) 
	begin 
	  reset_high_i3 <= 1'b1 ;
	 end 
	else 
	begin 
			reset_high_i3 <= reset_high_i2a ;
	end 
	if (rst) 
	begin 
	  reset_low_i3 <= 1'b0 ;
	 end 
	else 
	begin 
			reset_low_i3 <= reset_low_i2a ;
	end 
	if (rst) 
	begin 
	  reset_high_i4 <= 1'b1 ;
	 end 
	else 
	begin 
			reset_high_i4 <= reset_high_i3 ;
	end 
	if (rst) 
	begin 
	  reset_low_i4 <= 1'b0 ;
	 end 
	else 
	begin 
			reset_low_i4 <= reset_low_i3 ;
	end 
		init_done <= init_done_i ;
end

endmodule 
