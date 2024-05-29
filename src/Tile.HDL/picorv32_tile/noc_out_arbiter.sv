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
// Date        : Sept 29 2022
// Description : Arbitrated among all the NoC 
//               requesters in the Tile
// File        : noc_out_arbiter.sv
////////////////////////////////////////////////

`timescale 1 ps/ 1 ps

module noc_out_arbiter(
   input  logic        clk_line,
   input  logic        clk_line_rst_low,
   output logic        stream_in_pcpi_TREADY,
   input  logic        stream_in_pcpi_TVALID,
   input  logic [31:0] stream_in_pcpi_TDATA,
   input  logic [ 3:0] stream_in_pcpi_TKEEP,
   input  logic        stream_in_pcpi_TLAST,

   output logic        stream_in_mem_TREADY,
   input  logic        stream_in_mem_TVALID,
   input  logic [31:0] stream_in_mem_TDATA,
   input  logic [ 3:0] stream_in_mem_TKEEP,
   input  logic        stream_in_mem_TLAST,

   output logic        stream_in_spy_TREADY,
   input  logic        stream_in_spy_TVALID,
   input  logic [31:0] stream_in_spy_TDATA,
   input  logic [ 3:0] stream_in_spy_TKEEP,
   input  logic        stream_in_spy_TLAST,
 
   output logic        stream_in_noc_TREADY,
   input  logic        stream_in_noc_TVALID,
   input  logic [31:0] stream_in_noc_TDATA,
   input  logic [ 3:0] stream_in_noc_TKEEP,
   input  logic        stream_in_noc_TLAST,

   input  logic        stream_out_TREADY,
   output logic        stream_out_TVALID,
   output logic [31:0] stream_out_TDATA,
   output logic [ 3:0] stream_out_TKEEP,
   output logic        stream_out_TLAST
);

/***************************
* Local parameters for FSMs
****************************/

//- State machine state3
localparam [2:0] NOC_IDLE      = 3'd0;
localparam [2:0] NOC_DATA      = 3'd1;

logic noc_valid;
logic spy_valid;
logic mem_valid;
logic pcpi_valid;

logic next_noc_valid;
logic next_spy_valid;
logic next_mem_valid;
logic next_pcpi_valid;


logic [1:0] currentState3;
logic [1:0] nextState3;

logic tvalid;

assign tvalid = stream_in_noc_TVALID || stream_in_spy_TVALID ||
                stream_in_mem_TVALID || stream_in_pcpi_TVALID;

always @(posedge clk_line or negedge clk_line_rst_low) begin
   if (~clk_line_rst_low) begin 
      currentState3 <= NOC_IDLE;
      noc_valid <= 1'b0;
      spy_valid <= 1'b0;
      mem_valid <= 1'b0;
      pcpi_valid <= 1'b0;
   end else begin
      currentState3 <= nextState3;
      noc_valid <= next_noc_valid;
      spy_valid <= next_spy_valid;
      mem_valid <= next_mem_valid;
      pcpi_valid <= next_pcpi_valid;
   end
end

always @( * ) begin
   //- State
   nextState3 = currentState3;

   stream_in_noc_TREADY  = 1'b1;
   stream_in_spy_TREADY  = 1'b1;
   stream_in_mem_TREADY  = 1'b1;
   stream_in_pcpi_TREADY = 1'b1;

   stream_out_TDATA  = 'h0;
   stream_out_TVALID = 1'b0;
   stream_out_TLAST  = 1'b0;

   next_noc_valid  = noc_valid;
   next_spy_valid  = spy_valid;
   next_mem_valid  = mem_valid;
   next_pcpi_valid = pcpi_valid;

   case (currentState3)
      NOC_IDLE: begin //0
         if (stream_out_TREADY) begin
           if (stream_in_noc_TVALID) begin //- NOC got a GET/LOAD/STORE must send data or ACK
              stream_out_TDATA  = stream_in_noc_TDATA;
              stream_out_TVALID = stream_in_noc_TVALID;
              stream_out_TLAST  = 1'b0;
              stream_in_noc_TREADY = 1'b1;
              stream_in_spy_TREADY = 1'b0;
              stream_in_mem_TREADY = 1'b0;
              stream_in_pcpi_TREADY = 1'b0;
              next_noc_valid = 1;
           end else if (stream_in_spy_TVALID) begin //- There is sthg from the MM
              stream_out_TDATA  = stream_in_spy_TDATA;
              stream_out_TVALID = stream_in_spy_TVALID;
              stream_out_TLAST  = 1'b0;
              stream_in_noc_TREADY = 1'b0;
              stream_in_spy_TREADY = 1'b1;
              stream_in_mem_TREADY = 1'b0;
              stream_in_pcpi_TREADY = 1'b0;
              next_spy_valid = 1;
           end else if (stream_in_mem_TVALID) begin  
              stream_out_TDATA  = stream_in_mem_TDATA;
              stream_out_TVALID = stream_in_mem_TVALID;
              stream_out_TLAST  = 1'b0;
              stream_in_noc_TREADY = 1'b0;
              stream_in_spy_TREADY = 1'b0;
              stream_in_mem_TREADY = 1'b1;
              stream_in_pcpi_TREADY = 1'b0;
              next_mem_valid = 1;
           end else if (stream_in_pcpi_TVALID) begin  //- There is sthg from the QM
              stream_out_TDATA  = stream_in_pcpi_TDATA;
              stream_out_TVALID = stream_in_pcpi_TVALID;
              stream_out_TLAST  = 1'b0;
              stream_in_noc_TREADY  = 1'b0;
              stream_in_spy_TREADY  = 1'b0;
              stream_in_mem_TREADY  = 1'b0;
              stream_in_pcpi_TREADY = 1'b1;
              next_pcpi_valid = 1;
           end
           if (tvalid)
              nextState3 = NOC_DATA;
              
         end else begin
            stream_in_noc_TREADY  = 1'b0;
            stream_in_spy_TREADY  = 1'b0;
            stream_in_mem_TREADY  = 1'b0;
            stream_in_pcpi_TREADY = 1'b0;
         end
      end
      NOC_DATA: begin //1
         //if (stream_out_TREADY) begin
           if (noc_valid) begin //- NOC got a GET/LOAD/STORE must send data or ACK
              stream_out_TDATA  = stream_in_noc_TDATA;
              stream_out_TVALID = stream_in_noc_TVALID;
              stream_out_TLAST  = stream_in_noc_TLAST;

              stream_in_noc_TREADY = stream_out_TREADY;
              stream_in_spy_TREADY = 1'b0;
              stream_in_mem_TREADY = 1'b0;
              stream_in_pcpi_TREADY = 1'b0;

              if (stream_in_noc_TLAST & stream_out_TREADY) begin
                 nextState3 = NOC_IDLE;
                 next_noc_valid = 1'b0;
              end

           end else if (spy_valid) begin //- There is sthg from the MM

              stream_out_TDATA  = stream_in_spy_TDATA;
              stream_out_TVALID = stream_in_spy_TVALID;
              stream_out_TLAST  = stream_in_spy_TLAST;

              stream_in_noc_TREADY = 1'b0;
              stream_in_spy_TREADY = stream_out_TREADY;
              stream_in_mem_TREADY = 1'b0;
              stream_in_pcpi_TREADY = 1'b0;

              if (stream_in_spy_TLAST & stream_out_TREADY) begin
                 nextState3 = NOC_IDLE;
                 next_spy_valid = 1'b0;
              end

           end else if (mem_valid) begin  
              stream_out_TDATA  = stream_in_mem_TDATA;
              stream_out_TVALID = stream_in_mem_TVALID;
              stream_out_TLAST  = stream_in_mem_TLAST;

              stream_in_noc_TREADY = 1'b0;
              stream_in_spy_TREADY = 1'b0;
              stream_in_mem_TREADY = stream_out_TREADY;
              stream_in_pcpi_TREADY = 1'b0;

              if (stream_in_mem_TLAST & stream_out_TREADY) begin
                 nextState3 = NOC_IDLE;
                 next_mem_valid = 1'b0;
              end
           end else if (pcpi_valid) begin  //- There is sthg from the QM
              stream_out_TDATA  = stream_in_pcpi_TDATA;
              stream_out_TVALID = stream_in_pcpi_TVALID;
              stream_out_TLAST  = stream_in_pcpi_TLAST;
              stream_in_noc_TREADY  = 1'b0;
              stream_in_spy_TREADY  = 1'b0;
              stream_in_mem_TREADY  = 1'b0;
              stream_in_pcpi_TREADY = stream_out_TREADY;

              if (stream_in_pcpi_TLAST & stream_out_TREADY) begin
                 nextState3 = NOC_IDLE;
                 next_pcpi_valid = 1'b0;
              end
           end
     end
    
   endcase
end

assign stream_out_TKEEP = 4'b1111;

endmodule



