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
// Author      : Mario Vega 
// Date        : Jan 29 2024
// Description : Floating Point multiplier 64 bits
// File        : FP_multiplier_64_10cc.v
// Notes       :
//    - Chisel generated 
////////////////////////////////////////////////

module multiplier_bw53(
  input  [52:0]  io_in_a,
  input  [52:0]  io_in_b,
  output [105:0] io_out_s
);
  assign io_out_s = io_in_a * io_in_b; // @[Arithmetic.scala 107:23]
endmodule
module full_subtractor_bw11_mult(
  input  [10:0] io_in_b,
  output [10:0] io_out_s
);
  wire [11:0] _result_T = 11'h3ff - io_in_b; // @[Arithmetic.scala 94:23]
  wire [12:0] _result_T_2 = _result_T - 12'h0; // @[Arithmetic.scala 94:34]
  wire [11:0] result = _result_T_2[11:0]; // @[Arithmetic.scala 93:22 94:12]
  assign io_out_s = result[10:0]; // @[Arithmetic.scala 95:23]
endmodule
module twoscomplement_bw11(
  input  [10:0] io_in,
  output [10:0] io_out
);
  wire [10:0] _x_T = ~io_in; // @[Arithmetic.scala 47:16]
  assign io_out = 11'h1 + _x_T; // @[Arithmetic.scala 47:14]
endmodule
module full_adder_bw11(
  input  [10:0] io_in_a,
  input  [10:0] io_in_b,
  output [10:0] io_out_s,
  output        io_out_c
);
  wire [11:0] _result_T = io_in_a + io_in_b; // @[Arithmetic.scala 79:23]
  wire [12:0] _result_T_1 = {{1'd0}, _result_T}; // @[Arithmetic.scala 79:34]
  wire [11:0] result = _result_T_1[11:0]; // @[Arithmetic.scala 78:22 79:12]
  assign io_out_s = result[10:0]; // @[Arithmetic.scala 80:23]
  assign io_out_c = result[11]; // @[Arithmetic.scala 81:23]
endmodule
module FP_multiplier_64_10cc(
  input         clock,
  input         reset,
  input         in_valid,
  input  [63:0] in_data_0,
  input  [63:0] in_data_1,
  output [63:0] out_data,
  output        out_ready
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [63:0] _RAND_36;
  reg [63:0] _RAND_37;
  reg [127:0] _RAND_38;
  reg [127:0] _RAND_39;
  reg [127:0] _RAND_40;
  reg [127:0] _RAND_41;
  reg [127:0] _RAND_42;
  reg [127:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [63:0] _RAND_57;
  reg [63:0] _RAND_58;
`endif // RANDOMIZE_REG_INIT
  wire [52:0] wfrac_multiplier_io_in_a; // @[WHTDesigns.scala 1439:34]
  wire [52:0] wfrac_multiplier_io_in_b; // @[WHTDesigns.scala 1439:34]
  wire [105:0] wfrac_multiplier_io_out_s; // @[WHTDesigns.scala 1439:34]
  wire [10:0] exp_subber_io_in_b; // @[WHTDesigns.scala 1441:28]
  wire [10:0] exp_subber_io_out_s; // @[WHTDesigns.scala 1441:28]
  wire [10:0] exp_complementN_io_in; // @[WHTDesigns.scala 1443:33]
  wire [10:0] exp_complementN_io_out; // @[WHTDesigns.scala 1443:33]
  wire [10:0] exp_adderN_io_in_a; // @[WHTDesigns.scala 1449:28]
  wire [10:0] exp_adderN_io_in_b; // @[WHTDesigns.scala 1449:28]
  wire [10:0] exp_adderN_io_out_s; // @[WHTDesigns.scala 1449:28]
  wire  exp_adderN_io_out_c; // @[WHTDesigns.scala 1449:28]
  reg [63:0] indsr0; // @[Reg.scala 16:16]
  reg [63:0] indsr1; // @[Reg.scala 16:16]
  reg  out_valid_sr_r; // @[Reg.scala 16:16]
  reg  out_valid_sr_r_1; // @[Reg.scala 16:16]
  reg  out_valid_sr_r_2; // @[Reg.scala 16:16]
  reg  out_valid_sr_r_3; // @[Reg.scala 16:16]
  reg  out_valid_sr_r_4; // @[Reg.scala 16:16]
  reg  out_valid_sr_r_5; // @[Reg.scala 16:16]
  reg  out_valid_sr_r_6; // @[Reg.scala 16:16]
  reg  out_valid_sr_r_7; // @[Reg.scala 16:16]
  reg  out_valid_sr_r_8; // @[Reg.scala 16:16]
  reg  out_valid_sr; // @[Reg.scala 16:16]
  reg  sign_reg_0_0; // @[WHTDesigns.scala 1408:27]
  reg  sign_reg_0_1; // @[WHTDesigns.scala 1408:27]
  reg  sign_reg_1_0; // @[WHTDesigns.scala 1408:27]
  reg  sign_reg_1_1; // @[WHTDesigns.scala 1408:27]
  reg  sign_reg_2_0; // @[WHTDesigns.scala 1408:27]
  reg  sign_reg_2_1; // @[WHTDesigns.scala 1408:27]
  reg  sign_reg_3_0; // @[WHTDesigns.scala 1408:27]
  reg  sign_reg_3_1; // @[WHTDesigns.scala 1408:27]
  reg [10:0] exp_reg_0_0; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_0_1; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_1_0; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_1_1; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_2_0; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_2_1; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_3_0; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_3_1; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_4_0; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_4_1; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_5_0; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_5_1; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_6_0; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_6_1; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_7_0; // @[WHTDesigns.scala 1409:26]
  reg [10:0] exp_reg_7_1; // @[WHTDesigns.scala 1409:26]
  reg [52:0] wfrac_reg_0_0; // @[WHTDesigns.scala 1410:28]
  reg [52:0] wfrac_reg_0_1; // @[WHTDesigns.scala 1410:28]
  reg [105:0] wfrac_multipplier_out_s_reg_0; // @[WHTDesigns.scala 1412:46]
  reg [105:0] wfrac_multipplier_out_s_reg_1; // @[WHTDesigns.scala 1412:46]
  reg [105:0] wfrac_multipplier_out_s_reg_2; // @[WHTDesigns.scala 1412:46]
  reg [105:0] wfrac_multipplier_out_s_reg_3; // @[WHTDesigns.scala 1412:46]
  reg [105:0] wfrac_multipplier_out_s_reg_4; // @[WHTDesigns.scala 1412:46]
  reg [105:0] wfrac_multipplier_out_s_reg_5; // @[WHTDesigns.scala 1412:46]
  reg [10:0] exp_subber_out_s_reg_0; // @[WHTDesigns.scala 1414:39]
  reg [10:0] exp_complementN_out_reg_0; // @[WHTDesigns.scala 1417:42]
  reg [10:0] exp_complementN_out_reg_1; // @[WHTDesigns.scala 1417:42]
  reg [10:0] exp_complementN_out_reg_2; // @[WHTDesigns.scala 1417:42]
  reg  new_sign_reg_0; // @[WHTDesigns.scala 1419:31]
  reg  new_sign_reg_1; // @[WHTDesigns.scala 1419:31]
  reg  new_sign_reg_2; // @[WHTDesigns.scala 1419:31]
  reg  new_sign_reg_3; // @[WHTDesigns.scala 1419:31]
  reg  is_exp1_neg_reg_0; // @[WHTDesigns.scala 1421:34]
  reg  is_exp1_neg_reg_1; // @[WHTDesigns.scala 1421:34]
  reg [10:0] exp_adderN_out_s_reg_0; // @[WHTDesigns.scala 1423:39]
  reg  exp_adderN_out_c_reg_0; // @[WHTDesigns.scala 1424:39]
  reg [10:0] new_exp_reg_0; // @[WHTDesigns.scala 1426:30]
  reg [51:0] new_mant_reg_0; // @[WHTDesigns.scala 1427:31]
  reg [63:0] out_data_reg; // @[WHTDesigns.scala 1429:31]
  wire  _new_exp_reg_0_T_1 = ~exp_adderN_out_c_reg_0; // @[WHTDesigns.scala 1480:51]
  wire  _new_exp_reg_0_T_5 = exp_adderN_out_c_reg_0 | exp_adderN_out_s_reg_0 > 11'h7fe; // @[WHTDesigns.scala 1480:150]
  wire [63:0] _out_data_reg_T_1 = {new_sign_reg_3,new_exp_reg_0,new_mant_reg_0}; // @[WHTDesigns.scala 1491:57]
  wire  sign_0 = indsr0[63]; // @[WHTDesigns.scala 1496:22]
  wire  sign_1 = indsr1[63]; // @[WHTDesigns.scala 1497:22]
  wire [11:0] _T_7 = 12'h800 - 12'h2; // @[WHTDesigns.scala 1500:63]
  wire [11:0] _GEN_20 = {{1'd0}, indsr0[62:52]}; // @[WHTDesigns.scala 1500:35]
  wire [10:0] _GEN_14 = indsr0[62:52] < 11'h1 ? 11'h1 : indsr0[62:52]; // @[WHTDesigns.scala 1502:44 1503:14 1505:14]
  wire [11:0] _GEN_15 = _GEN_20 > _T_7 ? _T_7 : {{1'd0}, _GEN_14}; // @[WHTDesigns.scala 1500:70 1501:14]
  wire [11:0] _GEN_21 = {{1'd0}, indsr1[62:52]}; // @[WHTDesigns.scala 1507:35]
  wire [10:0] _GEN_16 = indsr1[62:52] < 11'h1 ? 11'h1 : indsr1[62:52]; // @[WHTDesigns.scala 1509:44 1510:14 1512:14]
  wire [11:0] _GEN_17 = _GEN_21 > _T_7 ? _T_7 : {{1'd0}, _GEN_16}; // @[WHTDesigns.scala 1507:70 1508:14]
  wire [51:0] frac_0 = indsr0[51:0]; // @[WHTDesigns.scala 1516:22]
  wire [51:0] frac_1 = indsr1[51:0]; // @[WHTDesigns.scala 1517:22]
  wire [52:0] wfrac_0 = {1'h1,frac_0}; // @[WHTDesigns.scala 1520:21]
  wire [52:0] wfrac_1 = {1'h1,frac_1}; // @[WHTDesigns.scala 1521:21]
  wire  new_sign = sign_reg_3_0 ^ sign_reg_3_1; // @[WHTDesigns.scala 1546:32]
  wire  is_exp1_neg_wire = exp_reg_4_1 < 11'h3ff; // @[WHTDesigns.scala 1550:40]
  wire [10:0] _exp_adderN_io_in_a_T_1 = exp_reg_5_0 + 11'h1; // @[WHTDesigns.scala 1557:43]
  wire [10:0] exp_0 = _GEN_15[10:0]; // @[WHTDesigns.scala 1433:19]
  wire [10:0] exp_1 = _GEN_17[10:0]; // @[WHTDesigns.scala 1433:19]
  multiplier_bw53 wfrac_multiplier ( // @[WHTDesigns.scala 1439:34]
    .io_in_a(wfrac_multiplier_io_in_a),
    .io_in_b(wfrac_multiplier_io_in_b),
    .io_out_s(wfrac_multiplier_io_out_s)
  );
  full_subtractor_bw11_mult exp_subber ( // @[WHTDesigns.scala 1441:28]
    .io_in_b(exp_subber_io_in_b),
    .io_out_s(exp_subber_io_out_s)
  );
  twoscomplement_bw11 exp_complementN ( // @[WHTDesigns.scala 1443:33]
    .io_in(exp_complementN_io_in),
    .io_out(exp_complementN_io_out)
  );
  full_adder_bw11 exp_adderN ( // @[WHTDesigns.scala 1449:28]
    .io_in_a(exp_adderN_io_in_a),
    .io_in_b(exp_adderN_io_in_b),
    .io_out_s(exp_adderN_io_out_s),
    .io_out_c(exp_adderN_io_out_c)
  );
  assign out_data = out_data_reg; // @[WHTDesigns.scala 1493:14]
  assign out_ready = out_valid_sr; // @[WHTDesigns.scala 1406:15]
  assign wfrac_multiplier_io_in_a = wfrac_reg_0_0; // @[WHTDesigns.scala 1530:30]
  assign wfrac_multiplier_io_in_b = wfrac_reg_0_1; // @[WHTDesigns.scala 1531:30]
  assign exp_subber_io_in_b = exp_reg_1_1; // @[WHTDesigns.scala 1536:24]
  assign exp_complementN_io_in = exp_subber_out_s_reg_0; // @[WHTDesigns.scala 1542:27]
  assign exp_adderN_io_in_a = wfrac_multipplier_out_s_reg_4[105] ? _exp_adderN_io_in_a_T_1 : exp_reg_5_0; // @[WHTDesigns.scala 1556:76 1557:26 1560:26]
  assign exp_adderN_io_in_b = exp_complementN_out_reg_2; // @[WHTDesigns.scala 1556:76 1558:26 1561:26]
  always @(posedge clock) begin
    indsr0 <= in_data_0; // @[Reg.scala 16:16 17:{18,22}]
    indsr1 <= in_data_1; // @[Reg.scala 16:16 17:{18,22}]
    out_valid_sr_r <= in_valid; // @[Reg.scala 16:16 17:{18,22}]
    out_valid_sr_r_1 <= out_valid_sr_r; // @[Reg.scala 16:16 17:{18,22}]
    out_valid_sr_r_2 <= out_valid_sr_r_1; // @[Reg.scala 16:16 17:{18,22}]
    out_valid_sr_r_3 <= out_valid_sr_r_2; // @[Reg.scala 16:16 17:{18,22}]
    out_valid_sr_r_4 <= out_valid_sr_r_3; // @[Reg.scala 16:16 17:{18,22}]
    out_valid_sr_r_5 <= out_valid_sr_r_4; // @[Reg.scala 16:16 17:{18,22}]
    out_valid_sr_r_6 <= out_valid_sr_r_5; // @[Reg.scala 16:16 17:{18,22}]
    out_valid_sr_r_7 <= out_valid_sr_r_6; // @[Reg.scala 16:16 17:{18,22}]
    out_valid_sr_r_8 <= out_valid_sr_r_7; // @[Reg.scala 16:16 17:{18,22}]
    out_valid_sr <= out_valid_sr_r_8; // @[Reg.scala 16:16 17:{18,22}]
    if (reset) begin // @[WHTDesigns.scala 1408:27]
      sign_reg_0_0 <= 1'h0; // @[WHTDesigns.scala 1408:27]
    end else begin
      sign_reg_0_0 <= sign_0; // @[WHTDesigns.scala 1451:17]
    end
    if (reset) begin // @[WHTDesigns.scala 1408:27]
      sign_reg_0_1 <= 1'h0; // @[WHTDesigns.scala 1408:27]
    end else begin
      sign_reg_0_1 <= sign_1; // @[WHTDesigns.scala 1451:17]
    end
    if (reset) begin // @[WHTDesigns.scala 1408:27]
      sign_reg_1_0 <= 1'h0; // @[WHTDesigns.scala 1408:27]
    end else begin
      sign_reg_1_0 <= sign_reg_0_0; // @[WHTDesigns.scala 1468:23]
    end
    if (reset) begin // @[WHTDesigns.scala 1408:27]
      sign_reg_1_1 <= 1'h0; // @[WHTDesigns.scala 1408:27]
    end else begin
      sign_reg_1_1 <= sign_reg_0_1; // @[WHTDesigns.scala 1468:23]
    end
    if (reset) begin // @[WHTDesigns.scala 1408:27]
      sign_reg_2_0 <= 1'h0; // @[WHTDesigns.scala 1408:27]
    end else begin
      sign_reg_2_0 <= sign_reg_1_0; // @[WHTDesigns.scala 1468:23]
    end
    if (reset) begin // @[WHTDesigns.scala 1408:27]
      sign_reg_2_1 <= 1'h0; // @[WHTDesigns.scala 1408:27]
    end else begin
      sign_reg_2_1 <= sign_reg_1_1; // @[WHTDesigns.scala 1468:23]
    end
    if (reset) begin // @[WHTDesigns.scala 1408:27]
      sign_reg_3_0 <= 1'h0; // @[WHTDesigns.scala 1408:27]
    end else begin
      sign_reg_3_0 <= sign_reg_2_0; // @[WHTDesigns.scala 1468:23]
    end
    if (reset) begin // @[WHTDesigns.scala 1408:27]
      sign_reg_3_1 <= 1'h0; // @[WHTDesigns.scala 1408:27]
    end else begin
      sign_reg_3_1 <= sign_reg_2_1; // @[WHTDesigns.scala 1468:23]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_0_0 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_0_0 <= exp_0; // @[WHTDesigns.scala 1452:16]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_0_1 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_0_1 <= exp_1; // @[WHTDesigns.scala 1452:16]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_1_0 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_1_0 <= exp_reg_0_0; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_1_1 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_1_1 <= exp_reg_0_1; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_2_0 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_2_0 <= exp_reg_1_0; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_2_1 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_2_1 <= exp_reg_1_1; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_3_0 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_3_0 <= exp_reg_2_0; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_3_1 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_3_1 <= exp_reg_2_1; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_4_0 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_4_0 <= exp_reg_3_0; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_4_1 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_4_1 <= exp_reg_3_1; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_5_0 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_5_0 <= exp_reg_4_0; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_5_1 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_5_1 <= exp_reg_4_1; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_6_0 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_6_0 <= exp_reg_5_0; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_6_1 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_6_1 <= exp_reg_5_1; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_7_0 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_7_0 <= exp_reg_6_0; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1409:26]
      exp_reg_7_1 <= 11'h0; // @[WHTDesigns.scala 1409:26]
    end else begin
      exp_reg_7_1 <= exp_reg_6_1; // @[WHTDesigns.scala 1464:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1410:28]
      wfrac_reg_0_0 <= 53'h0; // @[WHTDesigns.scala 1410:28]
    end else begin
      wfrac_reg_0_0 <= wfrac_0; // @[WHTDesigns.scala 1453:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1410:28]
      wfrac_reg_0_1 <= 53'h0; // @[WHTDesigns.scala 1410:28]
    end else begin
      wfrac_reg_0_1 <= wfrac_1; // @[WHTDesigns.scala 1453:18]
    end
    if (reset) begin // @[WHTDesigns.scala 1412:46]
      wfrac_multipplier_out_s_reg_0 <= 106'h0; // @[WHTDesigns.scala 1412:46]
    end else begin
      wfrac_multipplier_out_s_reg_0 <= wfrac_multiplier_io_out_s; // @[WHTDesigns.scala 1454:36]
    end
    if (reset) begin // @[WHTDesigns.scala 1412:46]
      wfrac_multipplier_out_s_reg_1 <= 106'h0; // @[WHTDesigns.scala 1412:46]
    end else begin
      wfrac_multipplier_out_s_reg_1 <= wfrac_multipplier_out_s_reg_0; // @[WHTDesigns.scala 1466:40]
    end
    if (reset) begin // @[WHTDesigns.scala 1412:46]
      wfrac_multipplier_out_s_reg_2 <= 106'h0; // @[WHTDesigns.scala 1412:46]
    end else begin
      wfrac_multipplier_out_s_reg_2 <= wfrac_multipplier_out_s_reg_1; // @[WHTDesigns.scala 1466:40]
    end
    if (reset) begin // @[WHTDesigns.scala 1412:46]
      wfrac_multipplier_out_s_reg_3 <= 106'h0; // @[WHTDesigns.scala 1412:46]
    end else begin
      wfrac_multipplier_out_s_reg_3 <= wfrac_multipplier_out_s_reg_2; // @[WHTDesigns.scala 1466:40]
    end
    if (reset) begin // @[WHTDesigns.scala 1412:46]
      wfrac_multipplier_out_s_reg_4 <= 106'h0; // @[WHTDesigns.scala 1412:46]
    end else begin
      wfrac_multipplier_out_s_reg_4 <= wfrac_multipplier_out_s_reg_3; // @[WHTDesigns.scala 1466:40]
    end
    if (reset) begin // @[WHTDesigns.scala 1412:46]
      wfrac_multipplier_out_s_reg_5 <= 106'h0; // @[WHTDesigns.scala 1412:46]
    end else begin
      wfrac_multipplier_out_s_reg_5 <= wfrac_multipplier_out_s_reg_4; // @[WHTDesigns.scala 1466:40]
    end
    if (reset) begin // @[WHTDesigns.scala 1414:39]
      exp_subber_out_s_reg_0 <= 11'h0; // @[WHTDesigns.scala 1414:39]
    end else begin
      exp_subber_out_s_reg_0 <= exp_subber_io_out_s; // @[WHTDesigns.scala 1455:29]
    end
    if (reset) begin // @[WHTDesigns.scala 1417:42]
      exp_complementN_out_reg_0 <= 11'h0; // @[WHTDesigns.scala 1417:42]
    end else begin
      exp_complementN_out_reg_0 <= exp_complementN_io_out; // @[WHTDesigns.scala 1457:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1417:42]
      exp_complementN_out_reg_1 <= 11'h0; // @[WHTDesigns.scala 1417:42]
    end else begin
      exp_complementN_out_reg_1 <= exp_complementN_out_reg_0; // @[WHTDesigns.scala 1471:40]
    end
    if (reset) begin // @[WHTDesigns.scala 1417:42]
      exp_complementN_out_reg_2 <= 11'h0; // @[WHTDesigns.scala 1417:42]
    end else begin
      exp_complementN_out_reg_2 <= exp_complementN_out_reg_1; // @[WHTDesigns.scala 1471:40]
    end
    if (reset) begin // @[WHTDesigns.scala 1419:31]
      new_sign_reg_0 <= 1'h0; // @[WHTDesigns.scala 1419:31]
    end else begin
      new_sign_reg_0 <= new_sign; // @[WHTDesigns.scala 1458:21]
    end
    if (reset) begin // @[WHTDesigns.scala 1419:31]
      new_sign_reg_1 <= 1'h0; // @[WHTDesigns.scala 1419:31]
    end else begin
      new_sign_reg_1 <= new_sign_reg_0; // @[WHTDesigns.scala 1469:27]
    end
    if (reset) begin // @[WHTDesigns.scala 1419:31]
      new_sign_reg_2 <= 1'h0; // @[WHTDesigns.scala 1419:31]
    end else begin
      new_sign_reg_2 <= new_sign_reg_1; // @[WHTDesigns.scala 1469:27]
    end
    if (reset) begin // @[WHTDesigns.scala 1419:31]
      new_sign_reg_3 <= 1'h0; // @[WHTDesigns.scala 1419:31]
    end else begin
      new_sign_reg_3 <= new_sign_reg_2; // @[WHTDesigns.scala 1469:27]
    end
    if (reset) begin // @[WHTDesigns.scala 1421:34]
      is_exp1_neg_reg_0 <= 1'h0; // @[WHTDesigns.scala 1421:34]
    end else begin
      is_exp1_neg_reg_0 <= is_exp1_neg_wire; // @[WHTDesigns.scala 1459:24]
    end
    if (reset) begin // @[WHTDesigns.scala 1421:34]
      is_exp1_neg_reg_1 <= 1'h0; // @[WHTDesigns.scala 1421:34]
    end else begin
      is_exp1_neg_reg_1 <= is_exp1_neg_reg_0; // @[WHTDesigns.scala 1473:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1423:39]
      exp_adderN_out_s_reg_0 <= 11'h0; // @[WHTDesigns.scala 1423:39]
    end else begin
      exp_adderN_out_s_reg_0 <= exp_adderN_io_out_s; // @[WHTDesigns.scala 1460:29]
    end
    if (reset) begin // @[WHTDesigns.scala 1424:39]
      exp_adderN_out_c_reg_0 <= 1'h0; // @[WHTDesigns.scala 1424:39]
    end else begin
      exp_adderN_out_c_reg_0 <= exp_adderN_io_out_c; // @[WHTDesigns.scala 1461:29]
    end
    if (reset) begin // @[WHTDesigns.scala 1426:30]
      new_exp_reg_0 <= 11'h0; // @[WHTDesigns.scala 1426:30]
    end else if (is_exp1_neg_reg_1) begin // @[WHTDesigns.scala 1480:26]
      if (~exp_adderN_out_c_reg_0) begin // @[WHTDesigns.scala 1480:50]
        new_exp_reg_0 <= 11'h1;
      end else begin
        new_exp_reg_0 <= exp_adderN_out_s_reg_0;
      end
    end else if (exp_adderN_out_c_reg_0 | exp_adderN_out_s_reg_0 > 11'h7fe) begin // @[WHTDesigns.scala 1480:118]
      new_exp_reg_0 <= 11'h7fe;
    end else begin
      new_exp_reg_0 <= exp_adderN_out_s_reg_0;
    end
    if (reset) begin // @[WHTDesigns.scala 1427:31]
      new_mant_reg_0 <= 52'h0; // @[WHTDesigns.scala 1427:31]
    end else if (wfrac_multipplier_out_s_reg_5[105]) begin // @[WHTDesigns.scala 1482:76]
      if (is_exp1_neg_reg_1) begin // @[WHTDesigns.scala 1483:29]
        if (_new_exp_reg_0_T_1) begin // @[WHTDesigns.scala 1483:53]
          new_mant_reg_0 <= 52'h0;
        end else begin
          new_mant_reg_0 <= wfrac_multipplier_out_s_reg_5[104:53];
        end
      end else if (_new_exp_reg_0_T_5) begin // @[WHTDesigns.scala 1483:168]
        new_mant_reg_0 <= 52'hfffffffffffff;
      end else begin
        new_mant_reg_0 <= wfrac_multipplier_out_s_reg_5[104:53];
      end
    end else if (is_exp1_neg_reg_1) begin // @[WHTDesigns.scala 1485:29]
      if (_new_exp_reg_0_T_1) begin // @[WHTDesigns.scala 1485:53]
        new_mant_reg_0 <= 52'h0;
      end else begin
        new_mant_reg_0 <= wfrac_multipplier_out_s_reg_5[103:52];
      end
    end else if (_new_exp_reg_0_T_5) begin // @[WHTDesigns.scala 1485:164]
      new_mant_reg_0 <= 52'hfffffffffffff;
    end else begin
      new_mant_reg_0 <= wfrac_multipplier_out_s_reg_5[103:52];
    end
    if (reset) begin // @[WHTDesigns.scala 1429:31]
      out_data_reg <= 64'h0; // @[WHTDesigns.scala 1429:31]
    end else if (exp_reg_7_0 == 11'h0 | exp_reg_7_1 == 11'h0) begin // @[WHTDesigns.scala 1488:58]
      out_data_reg <= 64'h0; // @[WHTDesigns.scala 1489:20]
    end else begin
      out_data_reg <= _out_data_reg_T_1; // @[WHTDesigns.scala 1491:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  indsr0 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  indsr1 = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  out_valid_sr_r = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  out_valid_sr_r_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  out_valid_sr_r_2 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  out_valid_sr_r_3 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  out_valid_sr_r_4 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  out_valid_sr_r_5 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  out_valid_sr_r_6 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  out_valid_sr_r_7 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  out_valid_sr_r_8 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  out_valid_sr = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sign_reg_0_0 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  sign_reg_0_1 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sign_reg_1_0 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  sign_reg_1_1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  sign_reg_2_0 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sign_reg_2_1 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  sign_reg_3_0 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  sign_reg_3_1 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  exp_reg_0_0 = _RAND_20[10:0];
  _RAND_21 = {1{`RANDOM}};
  exp_reg_0_1 = _RAND_21[10:0];
  _RAND_22 = {1{`RANDOM}};
  exp_reg_1_0 = _RAND_22[10:0];
  _RAND_23 = {1{`RANDOM}};
  exp_reg_1_1 = _RAND_23[10:0];
  _RAND_24 = {1{`RANDOM}};
  exp_reg_2_0 = _RAND_24[10:0];
  _RAND_25 = {1{`RANDOM}};
  exp_reg_2_1 = _RAND_25[10:0];
  _RAND_26 = {1{`RANDOM}};
  exp_reg_3_0 = _RAND_26[10:0];
  _RAND_27 = {1{`RANDOM}};
  exp_reg_3_1 = _RAND_27[10:0];
  _RAND_28 = {1{`RANDOM}};
  exp_reg_4_0 = _RAND_28[10:0];
  _RAND_29 = {1{`RANDOM}};
  exp_reg_4_1 = _RAND_29[10:0];
  _RAND_30 = {1{`RANDOM}};
  exp_reg_5_0 = _RAND_30[10:0];
  _RAND_31 = {1{`RANDOM}};
  exp_reg_5_1 = _RAND_31[10:0];
  _RAND_32 = {1{`RANDOM}};
  exp_reg_6_0 = _RAND_32[10:0];
  _RAND_33 = {1{`RANDOM}};
  exp_reg_6_1 = _RAND_33[10:0];
  _RAND_34 = {1{`RANDOM}};
  exp_reg_7_0 = _RAND_34[10:0];
  _RAND_35 = {1{`RANDOM}};
  exp_reg_7_1 = _RAND_35[10:0];
  _RAND_36 = {2{`RANDOM}};
  wfrac_reg_0_0 = _RAND_36[52:0];
  _RAND_37 = {2{`RANDOM}};
  wfrac_reg_0_1 = _RAND_37[52:0];
  _RAND_38 = {4{`RANDOM}};
  wfrac_multipplier_out_s_reg_0 = _RAND_38[105:0];
  _RAND_39 = {4{`RANDOM}};
  wfrac_multipplier_out_s_reg_1 = _RAND_39[105:0];
  _RAND_40 = {4{`RANDOM}};
  wfrac_multipplier_out_s_reg_2 = _RAND_40[105:0];
  _RAND_41 = {4{`RANDOM}};
  wfrac_multipplier_out_s_reg_3 = _RAND_41[105:0];
  _RAND_42 = {4{`RANDOM}};
  wfrac_multipplier_out_s_reg_4 = _RAND_42[105:0];
  _RAND_43 = {4{`RANDOM}};
  wfrac_multipplier_out_s_reg_5 = _RAND_43[105:0];
  _RAND_44 = {1{`RANDOM}};
  exp_subber_out_s_reg_0 = _RAND_44[10:0];
  _RAND_45 = {1{`RANDOM}};
  exp_complementN_out_reg_0 = _RAND_45[10:0];
  _RAND_46 = {1{`RANDOM}};
  exp_complementN_out_reg_1 = _RAND_46[10:0];
  _RAND_47 = {1{`RANDOM}};
  exp_complementN_out_reg_2 = _RAND_47[10:0];
  _RAND_48 = {1{`RANDOM}};
  new_sign_reg_0 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  new_sign_reg_1 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  new_sign_reg_2 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  new_sign_reg_3 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  is_exp1_neg_reg_0 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  is_exp1_neg_reg_1 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  exp_adderN_out_s_reg_0 = _RAND_54[10:0];
  _RAND_55 = {1{`RANDOM}};
  exp_adderN_out_c_reg_0 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  new_exp_reg_0 = _RAND_56[10:0];
  _RAND_57 = {2{`RANDOM}};
  new_mant_reg_0 = _RAND_57[51:0];
  _RAND_58 = {2{`RANDOM}};
  out_data_reg = _RAND_58[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

