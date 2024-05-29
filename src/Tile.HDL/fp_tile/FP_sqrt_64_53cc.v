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
// Description : Floating Point squared root 64 bits
// File        : FP_sqrt_64_53cc.v
// Notes       :
//    - Chisel generated 
////////////////////////////////////////////////

module multiplier_bw53_sqrt(
  input  [52:0]  io_in_a,
  input  [52:0]  io_in_b,
  output [105:0] io_out_s
);
  assign io_out_s = io_in_a * io_in_b; // @[Arithmetic.scala 107:23]
endmodule
module full_subtractor_bw11_sqrt(
  input  [10:0] io_in_a,
  input  [10:0] io_in_b,
  output [10:0] io_out_s,
  output        io_out_c
);
  wire [11:0] _result_T = io_in_a - io_in_b; // @[Arithmetic.scala 94:23]
  wire [12:0] _result_T_2 = _result_T - 12'h0; // @[Arithmetic.scala 94:34]
  wire [11:0] result = _result_T_2[11:0]; // @[Arithmetic.scala 93:22 94:12]
  assign io_out_s = result[10:0]; // @[Arithmetic.scala 95:23]
  assign io_out_c = result[11]; // @[Arithmetic.scala 96:23]
endmodule
module twoscomplement_bw11_sqrt(
  input  [10:0] io_in,
  output [10:0] io_out
);
  wire [10:0] _x_T = ~io_in; // @[Arithmetic.scala 47:16]
  assign io_out = 11'h1 + _x_T; // @[Arithmetic.scala 47:14]
endmodule
module full_adder_bw11_sqrt(
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
module FP_multiplier_64_10cc_sqrt(
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
  wire [10:0] exp_subber_io_in_a; // @[WHTDesigns.scala 1441:28]
  wire [10:0] exp_subber_io_in_b; // @[WHTDesigns.scala 1441:28]
  wire [10:0] exp_subber_io_out_s; // @[WHTDesigns.scala 1441:28]
  wire  exp_subber_io_out_c; // @[WHTDesigns.scala 1441:28]
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
  multiplier_bw53_sqrt wfrac_multiplier ( // @[WHTDesigns.scala 1439:34]
    .io_in_a(wfrac_multiplier_io_in_a),
    .io_in_b(wfrac_multiplier_io_in_b),
    .io_out_s(wfrac_multiplier_io_out_s)
  );
  full_subtractor_bw11_sqrt exp_subber ( // @[WHTDesigns.scala 1441:28]
    .io_in_a(exp_subber_io_in_a),
    .io_in_b(exp_subber_io_in_b),
    .io_out_s(exp_subber_io_out_s),
    .io_out_c(exp_subber_io_out_c)
  );
  twoscomplement_bw11_sqrt exp_complementN ( // @[WHTDesigns.scala 1443:33]
    .io_in(exp_complementN_io_in),
    .io_out(exp_complementN_io_out)
  );
  full_adder_bw11_sqrt exp_adderN ( // @[WHTDesigns.scala 1449:28]
    .io_in_a(exp_adderN_io_in_a),
    .io_in_b(exp_adderN_io_in_b),
    .io_out_s(exp_adderN_io_out_s),
    .io_out_c(exp_adderN_io_out_c)
  );
  assign out_data = out_data_reg; // @[WHTDesigns.scala 1493:14]
  assign out_ready = out_valid_sr; // @[WHTDesigns.scala 1406:15]
  assign wfrac_multiplier_io_in_a = wfrac_reg_0_0; // @[WHTDesigns.scala 1530:30]
  assign wfrac_multiplier_io_in_b = wfrac_reg_0_1; // @[WHTDesigns.scala 1531:30]
  assign exp_subber_io_in_a = 11'h3ff; // @[WHTDesigns.scala 1535:24]
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
module full_adder_bw53_sqrt(
  input  [52:0] io_in_a,
  input  [52:0] io_in_b,
  output [52:0] io_out_s,
  output        io_out_c
);
  wire [53:0] _result_T = io_in_a + io_in_b; // @[Arithmetic.scala 79:23]
  wire [54:0] _result_T_1 = {{1'd0}, _result_T}; // @[Arithmetic.scala 79:34]
  wire [53:0] result = _result_T_1[53:0]; // @[Arithmetic.scala 78:22 79:12]
  assign io_out_s = result[52:0]; // @[Arithmetic.scala 80:23]
  assign io_out_c = result[53]; // @[Arithmetic.scala 81:23]
endmodule
module FP_adder_64_13cc_sqrt(
  input         clock,
  input         reset,
  input         in_valid,
  input  [63:0] in_data_1,
  output [63:0] out_data,
  output        out_ready
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
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
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
  reg [63:0] _RAND_32;
  reg [63:0] _RAND_33;
  reg [63:0] _RAND_34;
  reg [63:0] _RAND_35;
  reg [63:0] _RAND_36;
  reg [63:0] _RAND_37;
  reg [63:0] _RAND_38;
  reg [63:0] _RAND_39;
  reg [63:0] _RAND_40;
  reg [63:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [63:0] _RAND_46;
  reg [63:0] _RAND_47;
  reg [63:0] _RAND_48;
  reg [63:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [63:0] _RAND_58;
  reg [63:0] _RAND_59;
  reg [63:0] _RAND_60;
  reg [63:0] _RAND_61;
  reg [63:0] _RAND_62;
  reg [63:0] _RAND_63;
  reg [63:0] _RAND_64;
  reg [63:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [63:0] _RAND_82;
  reg [63:0] _RAND_83;
  reg [63:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [63:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [63:0] _RAND_104;
  reg [63:0] _RAND_105;
  reg [63:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [63:0] _RAND_109;
  reg [63:0] _RAND_110;
  reg [63:0] _RAND_111;
  reg [63:0] _RAND_112;
  reg [63:0] _RAND_113;
  reg [63:0] _RAND_114;
  reg [63:0] _RAND_115;
  reg [63:0] _RAND_116;
  reg [63:0] _RAND_117;
  reg [63:0] _RAND_118;
  reg [63:0] _RAND_119;
  reg [63:0] _RAND_120;
  reg [63:0] _RAND_121;
  reg [63:0] _RAND_122;
  reg [63:0] _RAND_123;
  reg [63:0] _RAND_124;
  reg [63:0] _RAND_125;
  reg [63:0] _RAND_126;
  reg [63:0] _RAND_127;
  reg [63:0] _RAND_128;
  reg [63:0] _RAND_129;
  reg [63:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [63:0] _RAND_134;
  reg [63:0] _RAND_135;
  reg [63:0] _RAND_136;
  reg [63:0] _RAND_137;
`endif // RANDOMIZE_REG_INIT
  wire [10:0] exp_subber_io_in_a; // @[WHTDesigns.scala 552:28]
  wire [10:0] exp_subber_io_in_b; // @[WHTDesigns.scala 552:28]
  wire [10:0] exp_subber_io_out_s; // @[WHTDesigns.scala 552:28]
  wire  exp_subber_io_out_c; // @[WHTDesigns.scala 552:28]
  wire [52:0] wfrac_adder_io_in_a; // @[WHTDesigns.scala 558:29]
  wire [52:0] wfrac_adder_io_in_b; // @[WHTDesigns.scala 558:29]
  wire [52:0] wfrac_adder_io_out_s; // @[WHTDesigns.scala 558:29]
  wire  wfrac_adder_io_out_c; // @[WHTDesigns.scala 558:29]
  wire [10:0] exp_subber2_io_in_a; // @[WHTDesigns.scala 620:29]
  wire [10:0] exp_subber2_io_in_b; // @[WHTDesigns.scala 620:29]
  wire [10:0] exp_subber2_io_out_s; // @[WHTDesigns.scala 620:29]
  wire  exp_subber2_io_out_c; // @[WHTDesigns.scala 620:29]
  wire  sign_1 = in_data_1[63]; // @[WHTDesigns.scala 479:25]
  wire [11:0] _T_2 = 12'h800 - 12'h2; // @[WHTDesigns.scala 482:66]
  wire [11:0] _GEN_1 = 12'h3ff > _T_2 ? _T_2 : 12'h3ff; // @[WHTDesigns.scala 482:73 483:14]
  wire [11:0] _GEN_44 = {{1'd0}, in_data_1[62:52]}; // @[WHTDesigns.scala 489:38]
  wire [10:0] _GEN_2 = in_data_1[62:52] < 11'h1 ? 11'h1 : in_data_1[62:52]; // @[WHTDesigns.scala 491:47 492:14 494:14]
  wire [11:0] _GEN_3 = _GEN_44 > _T_2 ? _T_2 : {{1'd0}, _GEN_2}; // @[WHTDesigns.scala 489:73 490:14]
  wire [51:0] frac_1 = in_data_1[51:0]; // @[WHTDesigns.scala 500:25]
  wire [52:0] wfrac_1 = {1'h1,frac_1}; // @[WHTDesigns.scala 505:21]
  reg  out_ready_reg_r; // @[Reg.scala 16:16]
  reg  out_ready_reg_r_1; // @[Reg.scala 16:16]
  reg  out_ready_reg_r_2; // @[Reg.scala 16:16]
  reg  out_ready_reg_r_3; // @[Reg.scala 16:16]
  reg  out_ready_reg_r_4; // @[Reg.scala 16:16]
  reg  out_ready_reg_r_5; // @[Reg.scala 16:16]
  reg  out_ready_reg_r_6; // @[Reg.scala 16:16]
  reg  out_ready_reg_r_7; // @[Reg.scala 16:16]
  reg  out_ready_reg_r_8; // @[Reg.scala 16:16]
  reg  out_ready_reg_r_9; // @[Reg.scala 16:16]
  reg  out_ready_reg_r_10; // @[Reg.scala 16:16]
  reg  out_ready_reg_r_11; // @[Reg.scala 16:16]
  reg  out_ready_reg; // @[Reg.scala 16:16]
  reg  sign_reg_0_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_1_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_2_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_3_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_4_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_5_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_6_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_7_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_8_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_9_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_10_1; // @[WHTDesigns.scala 510:28]
  reg [10:0] exp_reg_0_0; // @[WHTDesigns.scala 511:28]
  reg [10:0] exp_reg_0_1; // @[WHTDesigns.scala 511:28]
  reg [10:0] exp_reg_1_0; // @[WHTDesigns.scala 511:28]
  reg [10:0] exp_reg_1_1; // @[WHTDesigns.scala 511:28]
  reg [10:0] exp_reg_2_0; // @[WHTDesigns.scala 511:28]
  reg [10:0] exp_reg_2_1; // @[WHTDesigns.scala 511:28]
  reg [51:0] frac_reg_0_0; // @[WHTDesigns.scala 512:28]
  reg [51:0] frac_reg_0_1; // @[WHTDesigns.scala 512:28]
  reg [51:0] frac_reg_1_0; // @[WHTDesigns.scala 512:28]
  reg [51:0] frac_reg_1_1; // @[WHTDesigns.scala 512:28]
  reg [51:0] frac_reg_2_0; // @[WHTDesigns.scala 512:28]
  reg [51:0] frac_reg_2_1; // @[WHTDesigns.scala 512:28]
  reg [52:0] wfrac_reg_0_0; // @[WHTDesigns.scala 513:28]
  reg [52:0] wfrac_reg_0_1; // @[WHTDesigns.scala 513:28]
  reg [52:0] wfrac_reg_1_0; // @[WHTDesigns.scala 513:28]
  reg [52:0] wfrac_reg_1_1; // @[WHTDesigns.scala 513:28]
  reg [52:0] wfrac_reg_2_0; // @[WHTDesigns.scala 513:28]
  reg [52:0] wfrac_reg_2_1; // @[WHTDesigns.scala 513:28]
  reg [10:0] exp_subber_out_s_reg_0; // @[WHTDesigns.scala 515:39]
  reg [10:0] exp_subber_out_s_reg_1; // @[WHTDesigns.scala 515:39]
  reg  exp_subber_out_c_reg_0; // @[WHTDesigns.scala 516:39]
  reg  exp_subber_out_c_reg_1; // @[WHTDesigns.scala 516:39]
  reg [52:0] temp_wfrac_add_in_reg_0_0; // @[WHTDesigns.scala 518:40]
  reg [52:0] temp_wfrac_add_in_reg_0_1; // @[WHTDesigns.scala 518:40]
  reg [52:0] temp_wfrac_add_in_reg_1_0; // @[WHTDesigns.scala 518:40]
  reg [52:0] temp_wfrac_add_in_reg_1_1; // @[WHTDesigns.scala 518:40]
  reg  ref_sign_reg_0; // @[WHTDesigns.scala 520:34]
  reg  ref_sign_reg_1; // @[WHTDesigns.scala 520:34]
  reg  ref_sign_reg_2; // @[WHTDesigns.scala 520:34]
  reg  ref_sign_reg_3; // @[WHTDesigns.scala 520:34]
  reg  ref_sign_reg_4; // @[WHTDesigns.scala 520:34]
  reg  ref_sign_reg_5; // @[WHTDesigns.scala 520:34]
  reg  ref_sign_reg_6; // @[WHTDesigns.scala 520:34]
  reg  ref_sign_reg_7; // @[WHTDesigns.scala 520:34]
  reg [51:0] ref_frac_reg_0; // @[WHTDesigns.scala 521:31]
  reg [51:0] ref_frac_reg_1; // @[WHTDesigns.scala 521:31]
  reg [51:0] ref_frac_reg_2; // @[WHTDesigns.scala 521:31]
  reg [51:0] ref_frac_reg_3; // @[WHTDesigns.scala 521:31]
  reg [51:0] ref_frac_reg_4; // @[WHTDesigns.scala 521:31]
  reg [51:0] ref_frac_reg_5; // @[WHTDesigns.scala 521:31]
  reg [51:0] ref_frac_reg_6; // @[WHTDesigns.scala 521:31]
  reg [51:0] ref_frac_reg_7; // @[WHTDesigns.scala 521:31]
  reg [10:0] ref_exp_reg_0; // @[WHTDesigns.scala 522:31]
  reg [10:0] ref_exp_reg_1; // @[WHTDesigns.scala 522:31]
  reg [10:0] ref_exp_reg_2; // @[WHTDesigns.scala 522:31]
  reg [10:0] ref_exp_reg_3; // @[WHTDesigns.scala 522:31]
  reg [10:0] ref_exp_reg_4; // @[WHTDesigns.scala 522:31]
  reg [10:0] ref_exp_reg_5; // @[WHTDesigns.scala 522:31]
  reg [10:0] ref_exp_reg_6; // @[WHTDesigns.scala 522:31]
  reg [10:0] ref_exp_reg_7; // @[WHTDesigns.scala 522:31]
  reg [10:0] sub_exp_reg_0; // @[WHTDesigns.scala 523:31]
  reg [10:0] sub_exp_reg_1; // @[WHTDesigns.scala 523:31]
  reg [10:0] sub_exp_reg_2; // @[WHTDesigns.scala 523:31]
  reg [10:0] sub_exp_reg_3; // @[WHTDesigns.scala 523:31]
  reg [10:0] sub_exp_reg_4; // @[WHTDesigns.scala 523:31]
  reg [10:0] sub_exp_reg_5; // @[WHTDesigns.scala 523:31]
  reg [10:0] sub_exp_reg_6; // @[WHTDesigns.scala 523:31]
  reg [10:0] sub_exp_reg_7; // @[WHTDesigns.scala 523:31]
  reg [52:0] wfrac_adder_io_out_s_reg_0; // @[WHTDesigns.scala 525:43]
  reg [52:0] wfrac_adder_io_out_s_reg_1; // @[WHTDesigns.scala 525:43]
  reg [52:0] wfrac_adder_io_out_s_reg_2; // @[WHTDesigns.scala 525:43]
  reg  wfrac_adder_io_out_c_reg_0; // @[WHTDesigns.scala 526:43]
  reg  new_sign_reg_0; // @[WHTDesigns.scala 528:38]
  reg  new_sign_reg_1; // @[WHTDesigns.scala 528:38]
  reg  new_sign_reg_2; // @[WHTDesigns.scala 528:38]
  reg  new_sign_reg_3; // @[WHTDesigns.scala 528:38]
  reg  new_sign_reg_4; // @[WHTDesigns.scala 528:38]
  reg  new_sign_reg_5; // @[WHTDesigns.scala 528:38]
  reg [51:0] new_frac_reg_0; // @[WHTDesigns.scala 529:31]
  reg [10:0] new_exp_reg_0; // @[WHTDesigns.scala 530:31]
  reg  NoChange_reg_0; // @[WHTDesigns.scala 531:31]
  reg  NoChange_reg_1; // @[WHTDesigns.scala 531:31]
  reg  NoChange_reg_2; // @[WHTDesigns.scala 531:31]
  reg  NoChange_reg_3; // @[WHTDesigns.scala 531:31]
  reg  NoChange_reg_4; // @[WHTDesigns.scala 531:31]
  reg  ShiftDir_reg_0; // @[WHTDesigns.scala 532:31]
  reg  ShiftDir_reg_1; // @[WHTDesigns.scala 532:31]
  reg  ShiftDir_reg_2; // @[WHTDesigns.scala 532:31]
  reg  ShiftDir_reg_3; // @[WHTDesigns.scala 532:31]
  reg  ShiftDir_reg_4; // @[WHTDesigns.scala 532:31]
  reg [52:0] wfrac_adder_result_reg_0; // @[WHTDesigns.scala 534:41]
  reg [52:0] wfrac_adder_result_reg_1; // @[WHTDesigns.scala 534:41]
  reg [52:0] wfrac_adder_result_reg_2; // @[WHTDesigns.scala 534:41]
  reg [6:0] leadingOneDet_reg_0; // @[WHTDesigns.scala 536:36]
  reg [6:0] leadingOneDet_reg_1; // @[WHTDesigns.scala 536:36]
  reg [63:0] in_data_0_reg_0; // @[WHTDesigns.scala 538:32]
  reg [63:0] in_data_0_reg_1; // @[WHTDesigns.scala 538:32]
  reg [63:0] in_data_0_reg_2; // @[WHTDesigns.scala 538:32]
  reg [63:0] in_data_0_reg_3; // @[WHTDesigns.scala 538:32]
  reg [63:0] in_data_0_reg_4; // @[WHTDesigns.scala 538:32]
  reg [63:0] in_data_0_reg_5; // @[WHTDesigns.scala 538:32]
  reg [63:0] in_data_0_reg_6; // @[WHTDesigns.scala 538:32]
  reg [63:0] in_data_0_reg_7; // @[WHTDesigns.scala 538:32]
  reg [63:0] in_data_0_reg_8; // @[WHTDesigns.scala 538:32]
  reg [63:0] in_data_0_reg_9; // @[WHTDesigns.scala 538:32]
  reg [63:0] in_data_0_reg_10; // @[WHTDesigns.scala 538:32]
  reg [63:0] in_data_1_reg_0; // @[WHTDesigns.scala 539:32]
  reg [63:0] in_data_1_reg_1; // @[WHTDesigns.scala 539:32]
  reg [63:0] in_data_1_reg_2; // @[WHTDesigns.scala 539:32]
  reg [63:0] in_data_1_reg_3; // @[WHTDesigns.scala 539:32]
  reg [63:0] in_data_1_reg_4; // @[WHTDesigns.scala 539:32]
  reg [63:0] in_data_1_reg_5; // @[WHTDesigns.scala 539:32]
  reg [63:0] in_data_1_reg_6; // @[WHTDesigns.scala 539:32]
  reg [63:0] in_data_1_reg_7; // @[WHTDesigns.scala 539:32]
  reg [63:0] in_data_1_reg_8; // @[WHTDesigns.scala 539:32]
  reg [63:0] in_data_1_reg_9; // @[WHTDesigns.scala 539:32]
  reg [63:0] in_data_1_reg_10; // @[WHTDesigns.scala 539:32]
  reg [10:0] exp_subber2_out_s_reg_0; // @[WHTDesigns.scala 541:40]
  reg  exp_subber2_out_c_reg_0; // @[WHTDesigns.scala 542:40]
  reg [10:0] cmpl_exp_subber_out_s_reg_0; // @[WHTDesigns.scala 563:44]
  wire [10:0] _cmpl_exp_subber_out_s_reg_0_T = ~exp_subber_out_s_reg_0; // @[WHTDesigns.scala 565:45]
  wire [10:0] _cmpl_exp_subber_out_s_reg_0_T_2 = 11'h1 + _cmpl_exp_subber_out_s_reg_0_T; // @[WHTDesigns.scala 565:43]
  wire [52:0] _wire_temp_wfrac_add_in_0_T = wfrac_reg_2_0 >> cmpl_exp_subber_out_s_reg_0; // @[WHTDesigns.scala 573:52]
  wire [52:0] _wire_temp_wfrac_add_in_1_T = wfrac_reg_2_1 >> exp_subber_out_s_reg_1; // @[WHTDesigns.scala 581:52]
  wire  ref_sign = exp_subber_out_c_reg_1 & sign_reg_2_1; // @[WHTDesigns.scala 568:43 571:16 578:16]
  reg [52:0] cmpl_temp_wfrac_add_in_reg_0_0; // @[WHTDesigns.scala 584:45]
  reg [52:0] cmpl_temp_wfrac_add_in_reg_0_1; // @[WHTDesigns.scala 584:45]
  wire [52:0] _cmpl_temp_wfrac_add_in_reg_0_0_T = ~temp_wfrac_add_in_reg_0_0; // @[WHTDesigns.scala 586:49]
  wire [52:0] _cmpl_temp_wfrac_add_in_reg_0_0_T_2 = 53'h1 + _cmpl_temp_wfrac_add_in_reg_0_0_T; // @[WHTDesigns.scala 586:47]
  wire [52:0] _cmpl_temp_wfrac_add_in_reg_0_1_T = ~temp_wfrac_add_in_reg_0_1; // @[WHTDesigns.scala 587:49]
  wire [52:0] _cmpl_temp_wfrac_add_in_reg_0_1_T_2 = 53'h1 + _cmpl_temp_wfrac_add_in_reg_0_1_T; // @[WHTDesigns.scala 587:47]
  wire [1:0] _wfrac_adder_io_in_a_T = {sign_reg_4_1,1'h0}; // @[WHTDesigns.scala 590:44]
  wire  _new_sign_T = ~wfrac_adder_io_out_c_reg_0; // @[WHTDesigns.scala 597:18]
  wire  new_sign = ~wfrac_adder_io_out_c_reg_0 & sign_reg_5_1; // @[WHTDesigns.scala 597:47]
  wire  ShiftDir = _new_sign_T | sign_reg_5_1; // @[WHTDesigns.scala 604:48]
  wire  NoChange = _new_sign_T & ~wfrac_adder_io_out_s_reg_0[52] | _new_sign_T & ~sign_reg_5_1 |
    wfrac_adder_io_out_c_reg_0 & wfrac_adder_io_out_s_reg_0[52] & sign_reg_5_1; // @[WHTDesigns.scala 606:159]
  reg [52:0] cmpl_wfrac_adder_io_out_s_reg_0; // @[WHTDesigns.scala 609:48]
  wire [52:0] _cmpl_wfrac_adder_io_out_s_reg_0_T = ~wfrac_adder_io_out_s_reg_1; // @[WHTDesigns.scala 612:49]
  wire [52:0] _cmpl_wfrac_adder_io_out_s_reg_0_T_2 = 53'h1 + _cmpl_wfrac_adder_io_out_s_reg_0_T; // @[WHTDesigns.scala 612:47]
  wire [1:0] _wfrac_adder_result_T = {sign_reg_7_1,1'h0}; // @[WHTDesigns.scala 616:62]
  wire [1:0] _leadingOneDet_T_54 = wfrac_adder_result_reg_0[2] ? 2'h2 : {{1'd0}, wfrac_adder_result_reg_0[1]}; // @[WHTDesigns.scala 619:79]
  wire [1:0] _leadingOneDet_T_55 = wfrac_adder_result_reg_0[3] ? 2'h3 : _leadingOneDet_T_54; // @[WHTDesigns.scala 619:79]
  wire [2:0] _leadingOneDet_T_56 = wfrac_adder_result_reg_0[4] ? 3'h4 : {{1'd0}, _leadingOneDet_T_55}; // @[WHTDesigns.scala 619:79]
  wire [2:0] _leadingOneDet_T_57 = wfrac_adder_result_reg_0[5] ? 3'h5 : _leadingOneDet_T_56; // @[WHTDesigns.scala 619:79]
  wire [2:0] _leadingOneDet_T_58 = wfrac_adder_result_reg_0[6] ? 3'h6 : _leadingOneDet_T_57; // @[WHTDesigns.scala 619:79]
  wire [2:0] _leadingOneDet_T_59 = wfrac_adder_result_reg_0[7] ? 3'h7 : _leadingOneDet_T_58; // @[WHTDesigns.scala 619:79]
  wire [3:0] _leadingOneDet_T_60 = wfrac_adder_result_reg_0[8] ? 4'h8 : {{1'd0}, _leadingOneDet_T_59}; // @[WHTDesigns.scala 619:79]
  wire [3:0] _leadingOneDet_T_61 = wfrac_adder_result_reg_0[9] ? 4'h9 : _leadingOneDet_T_60; // @[WHTDesigns.scala 619:79]
  wire [3:0] _leadingOneDet_T_62 = wfrac_adder_result_reg_0[10] ? 4'ha : _leadingOneDet_T_61; // @[WHTDesigns.scala 619:79]
  wire [3:0] _leadingOneDet_T_63 = wfrac_adder_result_reg_0[11] ? 4'hb : _leadingOneDet_T_62; // @[WHTDesigns.scala 619:79]
  wire [3:0] _leadingOneDet_T_64 = wfrac_adder_result_reg_0[12] ? 4'hc : _leadingOneDet_T_63; // @[WHTDesigns.scala 619:79]
  wire [3:0] _leadingOneDet_T_65 = wfrac_adder_result_reg_0[13] ? 4'hd : _leadingOneDet_T_64; // @[WHTDesigns.scala 619:79]
  wire [3:0] _leadingOneDet_T_66 = wfrac_adder_result_reg_0[14] ? 4'he : _leadingOneDet_T_65; // @[WHTDesigns.scala 619:79]
  wire [3:0] _leadingOneDet_T_67 = wfrac_adder_result_reg_0[15] ? 4'hf : _leadingOneDet_T_66; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_68 = wfrac_adder_result_reg_0[16] ? 5'h10 : {{1'd0}, _leadingOneDet_T_67}; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_69 = wfrac_adder_result_reg_0[17] ? 5'h11 : _leadingOneDet_T_68; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_70 = wfrac_adder_result_reg_0[18] ? 5'h12 : _leadingOneDet_T_69; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_71 = wfrac_adder_result_reg_0[19] ? 5'h13 : _leadingOneDet_T_70; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_72 = wfrac_adder_result_reg_0[20] ? 5'h14 : _leadingOneDet_T_71; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_73 = wfrac_adder_result_reg_0[21] ? 5'h15 : _leadingOneDet_T_72; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_74 = wfrac_adder_result_reg_0[22] ? 5'h16 : _leadingOneDet_T_73; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_75 = wfrac_adder_result_reg_0[23] ? 5'h17 : _leadingOneDet_T_74; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_76 = wfrac_adder_result_reg_0[24] ? 5'h18 : _leadingOneDet_T_75; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_77 = wfrac_adder_result_reg_0[25] ? 5'h19 : _leadingOneDet_T_76; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_78 = wfrac_adder_result_reg_0[26] ? 5'h1a : _leadingOneDet_T_77; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_79 = wfrac_adder_result_reg_0[27] ? 5'h1b : _leadingOneDet_T_78; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_80 = wfrac_adder_result_reg_0[28] ? 5'h1c : _leadingOneDet_T_79; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_81 = wfrac_adder_result_reg_0[29] ? 5'h1d : _leadingOneDet_T_80; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_82 = wfrac_adder_result_reg_0[30] ? 5'h1e : _leadingOneDet_T_81; // @[WHTDesigns.scala 619:79]
  wire [4:0] _leadingOneDet_T_83 = wfrac_adder_result_reg_0[31] ? 5'h1f : _leadingOneDet_T_82; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_84 = wfrac_adder_result_reg_0[32] ? 6'h20 : {{1'd0}, _leadingOneDet_T_83}; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_85 = wfrac_adder_result_reg_0[33] ? 6'h21 : _leadingOneDet_T_84; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_86 = wfrac_adder_result_reg_0[34] ? 6'h22 : _leadingOneDet_T_85; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_87 = wfrac_adder_result_reg_0[35] ? 6'h23 : _leadingOneDet_T_86; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_88 = wfrac_adder_result_reg_0[36] ? 6'h24 : _leadingOneDet_T_87; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_89 = wfrac_adder_result_reg_0[37] ? 6'h25 : _leadingOneDet_T_88; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_90 = wfrac_adder_result_reg_0[38] ? 6'h26 : _leadingOneDet_T_89; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_91 = wfrac_adder_result_reg_0[39] ? 6'h27 : _leadingOneDet_T_90; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_92 = wfrac_adder_result_reg_0[40] ? 6'h28 : _leadingOneDet_T_91; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_93 = wfrac_adder_result_reg_0[41] ? 6'h29 : _leadingOneDet_T_92; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_94 = wfrac_adder_result_reg_0[42] ? 6'h2a : _leadingOneDet_T_93; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_95 = wfrac_adder_result_reg_0[43] ? 6'h2b : _leadingOneDet_T_94; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_96 = wfrac_adder_result_reg_0[44] ? 6'h2c : _leadingOneDet_T_95; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_97 = wfrac_adder_result_reg_0[45] ? 6'h2d : _leadingOneDet_T_96; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_98 = wfrac_adder_result_reg_0[46] ? 6'h2e : _leadingOneDet_T_97; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_99 = wfrac_adder_result_reg_0[47] ? 6'h2f : _leadingOneDet_T_98; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_100 = wfrac_adder_result_reg_0[48] ? 6'h30 : _leadingOneDet_T_99; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_101 = wfrac_adder_result_reg_0[49] ? 6'h31 : _leadingOneDet_T_100; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_102 = wfrac_adder_result_reg_0[50] ? 6'h32 : _leadingOneDet_T_101; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_103 = wfrac_adder_result_reg_0[51] ? 6'h33 : _leadingOneDet_T_102; // @[WHTDesigns.scala 619:79]
  wire [5:0] _leadingOneDet_T_104 = wfrac_adder_result_reg_0[52] ? 6'h34 : _leadingOneDet_T_103; // @[WHTDesigns.scala 619:79]
  wire [6:0] leadingOneDet = _leadingOneDet_T_104 + 6'h1; // @[WHTDesigns.scala 619:86]
  wire [6:0] _exp_subber2_io_in_b_T_1 = 7'h35 - leadingOneDet_reg_0; // @[WHTDesigns.scala 622:46]
  reg [63:0] reg_out_s; // @[WHTDesigns.scala 693:28]
  wire [11:0] _GEN_45 = {{1'd0}, ref_exp_reg_7}; // @[WHTDesigns.scala 710:29]
  wire [52:0] _new_frac_reg_0_T_2 = 53'h10000000000000 - 53'h1; // @[WHTDesigns.scala 712:56]
  wire [10:0] _new_exp_reg_0_T_3 = ref_exp_reg_7 + 11'h1; // @[WHTDesigns.scala 714:44]
  wire [11:0] _GEN_23 = _GEN_45 == _T_2 ? _T_2 : {{1'd0}, _new_exp_reg_0_T_3}; // @[WHTDesigns.scala 710:66 711:26 714:26]
  wire [52:0] _GEN_24 = _GEN_45 == _T_2 ? _new_frac_reg_0_T_2 : {{1'd0}, wfrac_adder_result_reg_2[52:1]}; // @[WHTDesigns.scala 710:66 712:27 715:27]
  wire [6:0] _new_frac_reg_0_T_6 = 7'h35 - leadingOneDet_reg_1; // @[WHTDesigns.scala 728:96]
  wire [178:0] _GEN_0 = {{127'd0}, wfrac_adder_result_reg_2[51:0]}; // @[WHTDesigns.scala 728:75]
  wire [178:0] _new_frac_reg_0_T_7 = _GEN_0 << _new_frac_reg_0_T_6; // @[WHTDesigns.scala 728:75]
  wire [10:0] _GEN_25 = exp_subber2_out_c_reg_0 ? 11'h1 : exp_subber2_out_s_reg_0; // @[WHTDesigns.scala 723:50 724:28 727:28]
  wire [178:0] _GEN_26 = exp_subber2_out_c_reg_0 ? 179'h0 : _new_frac_reg_0_T_7; // @[WHTDesigns.scala 723:50 725:29 728:29]
  wire [10:0] _GEN_27 = leadingOneDet_reg_1 == 7'h1 & wfrac_adder_result_reg_2 == 53'h0 & (sign_reg_10_1 &
    in_data_0_reg_10[62:0] == in_data_1_reg_10[62:0]) ? 11'h0 : _GEN_25; // @[WHTDesigns.scala 719:197 720:26]
  wire [178:0] _GEN_28 = leadingOneDet_reg_1 == 7'h1 & wfrac_adder_result_reg_2 == 53'h0 & (sign_reg_10_1 &
    in_data_0_reg_10[62:0] == in_data_1_reg_10[62:0]) ? 179'h0 : _GEN_26; // @[WHTDesigns.scala 719:197 721:27]
  wire  _GEN_29 = ShiftDir_reg_4 ? new_sign_reg_4 : new_sign_reg_5; // @[WHTDesigns.scala 717:43 718:25 528:38]
  wire [10:0] _GEN_30 = ShiftDir_reg_4 ? _GEN_27 : new_exp_reg_0; // @[WHTDesigns.scala 530:31 717:43]
  wire [178:0] _GEN_31 = ShiftDir_reg_4 ? _GEN_28 : {{127'd0}, new_frac_reg_0}; // @[WHTDesigns.scala 529:31 717:43]
  wire  _GEN_32 = ~ShiftDir_reg_4 ? new_sign_reg_4 : _GEN_29; // @[WHTDesigns.scala 708:43 709:25]
  wire [11:0] _GEN_33 = ~ShiftDir_reg_4 ? _GEN_23 : {{1'd0}, _GEN_30}; // @[WHTDesigns.scala 708:43]
  wire [178:0] _GEN_34 = ~ShiftDir_reg_4 ? {{126'd0}, _GEN_24} : _GEN_31; // @[WHTDesigns.scala 708:43]
  wire [11:0] _GEN_36 = NoChange_reg_4 ? {{1'd0}, ref_exp_reg_7} : _GEN_33; // @[WHTDesigns.scala 704:43 706:24]
  wire [178:0] _GEN_37 = NoChange_reg_4 ? {{127'd0}, wfrac_adder_result_reg_2[51:0]} : _GEN_34; // @[WHTDesigns.scala 704:43 707:25]
  wire [178:0] _GEN_39 = sub_exp_reg_7 >= 11'h34 ? {{127'd0}, ref_frac_reg_7} : _GEN_37; // @[WHTDesigns.scala 700:48 702:25]
  wire [11:0] _GEN_40 = sub_exp_reg_7 >= 11'h34 ? {{1'd0}, ref_exp_reg_7} : _GEN_36; // @[WHTDesigns.scala 700:48 703:24]
  wire [11:0] _GEN_42 = in_data_0_reg_10[62:0] == 63'h0 & in_data_1_reg_10[62:0] == 63'h0 ? 12'h0 : _GEN_40; // @[WHTDesigns.scala 696:90 698:24]
  wire [178:0] _GEN_43 = in_data_0_reg_10[62:0] == 63'h0 & in_data_1_reg_10[62:0] == 63'h0 ? 179'h0 : _GEN_39; // @[WHTDesigns.scala 696:90 699:25]
  wire [63:0] _reg_out_s_T_1 = {new_sign_reg_5,new_exp_reg_0,new_frac_reg_0}; // @[WHTDesigns.scala 732:54]
  wire [10:0] exp_0 = _GEN_1[10:0]; // @[WHTDesigns.scala 480:19]
  wire [10:0] exp_1 = _GEN_3[10:0]; // @[WHTDesigns.scala 480:19]
  wire [178:0] _GEN_46 = reset ? 179'h0 : _GEN_43; // @[WHTDesigns.scala 529:{31,31}]
  wire [11:0] _GEN_47 = reset ? 12'h0 : _GEN_42; // @[WHTDesigns.scala 530:{31,31}]
  full_subtractor_bw11_sqrt exp_subber ( // @[WHTDesigns.scala 552:28]
    .io_in_a(exp_subber_io_in_a),
    .io_in_b(exp_subber_io_in_b),
    .io_out_s(exp_subber_io_out_s),
    .io_out_c(exp_subber_io_out_c)
  );
  full_adder_bw53_sqrt wfrac_adder ( // @[WHTDesigns.scala 558:29]
    .io_in_a(wfrac_adder_io_in_a),
    .io_in_b(wfrac_adder_io_in_b),
    .io_out_s(wfrac_adder_io_out_s),
    .io_out_c(wfrac_adder_io_out_c)
  );
  full_subtractor_bw11_sqrt exp_subber2 ( // @[WHTDesigns.scala 620:29]
    .io_in_a(exp_subber2_io_in_a),
    .io_in_b(exp_subber2_io_in_b),
    .io_out_s(exp_subber2_io_out_s),
    .io_out_c(exp_subber2_io_out_c)
  );
  assign out_data = reg_out_s; // @[WHTDesigns.scala 694:14]
  assign out_ready = out_ready_reg; // @[WHTDesigns.scala 508:15]
  assign exp_subber_io_in_a = exp_reg_0_0; // @[WHTDesigns.scala 553:24]
  assign exp_subber_io_in_b = exp_reg_0_1; // @[WHTDesigns.scala 554:24]
  assign wfrac_adder_io_in_a = _wfrac_adder_io_in_a_T == 2'h1 ? cmpl_temp_wfrac_add_in_reg_0_0 :
    temp_wfrac_add_in_reg_1_0; // @[WHTDesigns.scala 590:31]
  assign wfrac_adder_io_in_b = _wfrac_adder_io_in_a_T == 2'h2 ? cmpl_temp_wfrac_add_in_reg_0_1 :
    temp_wfrac_add_in_reg_1_1; // @[WHTDesigns.scala 591:31]
  assign exp_subber2_io_in_a = ref_exp_reg_6; // @[WHTDesigns.scala 621:25]
  assign exp_subber2_io_in_b = {{4'd0}, _exp_subber2_io_in_b_T_1}; // @[WHTDesigns.scala 622:25]
  always @(posedge clock) begin
    out_ready_reg_r <= in_valid; // @[Reg.scala 16:16 17:{18,22}]
    out_ready_reg_r_1 <= out_ready_reg_r; // @[Reg.scala 16:16 17:{18,22}]
    out_ready_reg_r_2 <= out_ready_reg_r_1; // @[Reg.scala 16:16 17:{18,22}]
    out_ready_reg_r_3 <= out_ready_reg_r_2; // @[Reg.scala 16:16 17:{18,22}]
    out_ready_reg_r_4 <= out_ready_reg_r_3; // @[Reg.scala 16:16 17:{18,22}]
    out_ready_reg_r_5 <= out_ready_reg_r_4; // @[Reg.scala 16:16 17:{18,22}]
    out_ready_reg_r_6 <= out_ready_reg_r_5; // @[Reg.scala 16:16 17:{18,22}]
    out_ready_reg_r_7 <= out_ready_reg_r_6; // @[Reg.scala 16:16 17:{18,22}]
    out_ready_reg_r_8 <= out_ready_reg_r_7; // @[Reg.scala 16:16 17:{18,22}]
    out_ready_reg_r_9 <= out_ready_reg_r_8; // @[Reg.scala 16:16 17:{18,22}]
    out_ready_reg_r_10 <= out_ready_reg_r_9; // @[Reg.scala 16:16 17:{18,22}]
    out_ready_reg_r_11 <= out_ready_reg_r_10; // @[Reg.scala 16:16 17:{18,22}]
    out_ready_reg <= out_ready_reg_r_11; // @[Reg.scala 16:16 17:{18,22}]
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_0_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_0_1 <= sign_1; // @[WHTDesigns.scala 630:19]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_1_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_1_1 <= sign_reg_0_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_2_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_2_1 <= sign_reg_1_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_3_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_3_1 <= sign_reg_2_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_4_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_4_1 <= sign_reg_3_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_5_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_5_1 <= sign_reg_4_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_6_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_6_1 <= sign_reg_5_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_7_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_7_1 <= sign_reg_6_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_8_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_8_1 <= sign_reg_7_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_9_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_9_1 <= sign_reg_8_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_10_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_10_1 <= sign_reg_9_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 511:28]
      exp_reg_0_0 <= 11'h0; // @[WHTDesigns.scala 511:28]
    end else begin
      exp_reg_0_0 <= exp_0; // @[WHTDesigns.scala 631:18]
    end
    if (reset) begin // @[WHTDesigns.scala 511:28]
      exp_reg_0_1 <= 11'h0; // @[WHTDesigns.scala 511:28]
    end else begin
      exp_reg_0_1 <= exp_1; // @[WHTDesigns.scala 631:18]
    end
    if (reset) begin // @[WHTDesigns.scala 511:28]
      exp_reg_1_0 <= 11'h0; // @[WHTDesigns.scala 511:28]
    end else begin
      exp_reg_1_0 <= exp_reg_0_0; // @[WHTDesigns.scala 681:22]
    end
    if (reset) begin // @[WHTDesigns.scala 511:28]
      exp_reg_1_1 <= 11'h0; // @[WHTDesigns.scala 511:28]
    end else begin
      exp_reg_1_1 <= exp_reg_0_1; // @[WHTDesigns.scala 681:22]
    end
    if (reset) begin // @[WHTDesigns.scala 511:28]
      exp_reg_2_0 <= 11'h0; // @[WHTDesigns.scala 511:28]
    end else begin
      exp_reg_2_0 <= exp_reg_1_0; // @[WHTDesigns.scala 681:22]
    end
    if (reset) begin // @[WHTDesigns.scala 511:28]
      exp_reg_2_1 <= 11'h0; // @[WHTDesigns.scala 511:28]
    end else begin
      exp_reg_2_1 <= exp_reg_1_1; // @[WHTDesigns.scala 681:22]
    end
    if (reset) begin // @[WHTDesigns.scala 512:28]
      frac_reg_0_0 <= 52'h0; // @[WHTDesigns.scala 512:28]
    end else begin
      frac_reg_0_0 <= 52'h8000000000000; // @[WHTDesigns.scala 632:19]
    end
    if (reset) begin // @[WHTDesigns.scala 512:28]
      frac_reg_0_1 <= 52'h0; // @[WHTDesigns.scala 512:28]
    end else begin
      frac_reg_0_1 <= frac_1; // @[WHTDesigns.scala 632:19]
    end
    if (reset) begin // @[WHTDesigns.scala 512:28]
      frac_reg_1_0 <= 52'h0; // @[WHTDesigns.scala 512:28]
    end else begin
      frac_reg_1_0 <= frac_reg_0_0; // @[WHTDesigns.scala 682:23]
    end
    if (reset) begin // @[WHTDesigns.scala 512:28]
      frac_reg_1_1 <= 52'h0; // @[WHTDesigns.scala 512:28]
    end else begin
      frac_reg_1_1 <= frac_reg_0_1; // @[WHTDesigns.scala 682:23]
    end
    if (reset) begin // @[WHTDesigns.scala 512:28]
      frac_reg_2_0 <= 52'h0; // @[WHTDesigns.scala 512:28]
    end else begin
      frac_reg_2_0 <= frac_reg_1_0; // @[WHTDesigns.scala 682:23]
    end
    if (reset) begin // @[WHTDesigns.scala 512:28]
      frac_reg_2_1 <= 52'h0; // @[WHTDesigns.scala 512:28]
    end else begin
      frac_reg_2_1 <= frac_reg_1_1; // @[WHTDesigns.scala 682:23]
    end
    if (reset) begin // @[WHTDesigns.scala 513:28]
      wfrac_reg_0_0 <= 53'h0; // @[WHTDesigns.scala 513:28]
    end else begin
      wfrac_reg_0_0 <= 53'h18000000000000; // @[WHTDesigns.scala 633:20]
    end
    if (reset) begin // @[WHTDesigns.scala 513:28]
      wfrac_reg_0_1 <= 53'h0; // @[WHTDesigns.scala 513:28]
    end else begin
      wfrac_reg_0_1 <= wfrac_1; // @[WHTDesigns.scala 633:20]
    end
    if (reset) begin // @[WHTDesigns.scala 513:28]
      wfrac_reg_1_0 <= 53'h0; // @[WHTDesigns.scala 513:28]
    end else begin
      wfrac_reg_1_0 <= wfrac_reg_0_0; // @[WHTDesigns.scala 683:24]
    end
    if (reset) begin // @[WHTDesigns.scala 513:28]
      wfrac_reg_1_1 <= 53'h0; // @[WHTDesigns.scala 513:28]
    end else begin
      wfrac_reg_1_1 <= wfrac_reg_0_1; // @[WHTDesigns.scala 683:24]
    end
    if (reset) begin // @[WHTDesigns.scala 513:28]
      wfrac_reg_2_0 <= 53'h0; // @[WHTDesigns.scala 513:28]
    end else begin
      wfrac_reg_2_0 <= wfrac_reg_1_0; // @[WHTDesigns.scala 683:24]
    end
    if (reset) begin // @[WHTDesigns.scala 513:28]
      wfrac_reg_2_1 <= 53'h0; // @[WHTDesigns.scala 513:28]
    end else begin
      wfrac_reg_2_1 <= wfrac_reg_1_1; // @[WHTDesigns.scala 683:24]
    end
    if (reset) begin // @[WHTDesigns.scala 515:39]
      exp_subber_out_s_reg_0 <= 11'h0; // @[WHTDesigns.scala 515:39]
    end else begin
      exp_subber_out_s_reg_0 <= exp_subber_io_out_s; // @[WHTDesigns.scala 635:31]
    end
    if (reset) begin // @[WHTDesigns.scala 515:39]
      exp_subber_out_s_reg_1 <= 11'h0; // @[WHTDesigns.scala 515:39]
    end else begin
      exp_subber_out_s_reg_1 <= exp_subber_out_s_reg_0; // @[WHTDesigns.scala 686:35]
    end
    if (reset) begin // @[WHTDesigns.scala 516:39]
      exp_subber_out_c_reg_0 <= 1'h0; // @[WHTDesigns.scala 516:39]
    end else begin
      exp_subber_out_c_reg_0 <= exp_subber_io_out_c; // @[WHTDesigns.scala 636:31]
    end
    if (reset) begin // @[WHTDesigns.scala 516:39]
      exp_subber_out_c_reg_1 <= 1'h0; // @[WHTDesigns.scala 516:39]
    end else begin
      exp_subber_out_c_reg_1 <= exp_subber_out_c_reg_0; // @[WHTDesigns.scala 687:35]
    end
    if (reset) begin // @[WHTDesigns.scala 518:40]
      temp_wfrac_add_in_reg_0_0 <= 53'h0; // @[WHTDesigns.scala 518:40]
    end else if (exp_subber_out_c_reg_1) begin // @[WHTDesigns.scala 568:43]
      temp_wfrac_add_in_reg_0_0 <= _wire_temp_wfrac_add_in_0_T; // @[WHTDesigns.scala 573:33]
    end else begin
      temp_wfrac_add_in_reg_0_0 <= wfrac_reg_2_0; // @[WHTDesigns.scala 580:33]
    end
    if (reset) begin // @[WHTDesigns.scala 518:40]
      temp_wfrac_add_in_reg_0_1 <= 53'h0; // @[WHTDesigns.scala 518:40]
    end else if (exp_subber_out_c_reg_1) begin // @[WHTDesigns.scala 568:43]
      temp_wfrac_add_in_reg_0_1 <= wfrac_reg_2_1; // @[WHTDesigns.scala 574:33]
    end else begin
      temp_wfrac_add_in_reg_0_1 <= _wire_temp_wfrac_add_in_1_T; // @[WHTDesigns.scala 581:33]
    end
    if (reset) begin // @[WHTDesigns.scala 518:40]
      temp_wfrac_add_in_reg_1_0 <= 53'h0; // @[WHTDesigns.scala 518:40]
    end else begin
      temp_wfrac_add_in_reg_1_0 <= temp_wfrac_add_in_reg_0_0; // @[WHTDesigns.scala 689:36]
    end
    if (reset) begin // @[WHTDesigns.scala 518:40]
      temp_wfrac_add_in_reg_1_1 <= 53'h0; // @[WHTDesigns.scala 518:40]
    end else begin
      temp_wfrac_add_in_reg_1_1 <= temp_wfrac_add_in_reg_0_1; // @[WHTDesigns.scala 689:36]
    end
    if (reset) begin // @[WHTDesigns.scala 520:34]
      ref_sign_reg_0 <= 1'h0; // @[WHTDesigns.scala 520:34]
    end else begin
      ref_sign_reg_0 <= ref_sign; // @[WHTDesigns.scala 638:23]
    end
    if (reset) begin // @[WHTDesigns.scala 520:34]
      ref_sign_reg_1 <= 1'h0; // @[WHTDesigns.scala 520:34]
    end else begin
      ref_sign_reg_1 <= ref_sign_reg_0; // @[WHTDesigns.scala 668:27]
    end
    if (reset) begin // @[WHTDesigns.scala 520:34]
      ref_sign_reg_2 <= 1'h0; // @[WHTDesigns.scala 520:34]
    end else begin
      ref_sign_reg_2 <= ref_sign_reg_1; // @[WHTDesigns.scala 668:27]
    end
    if (reset) begin // @[WHTDesigns.scala 520:34]
      ref_sign_reg_3 <= 1'h0; // @[WHTDesigns.scala 520:34]
    end else begin
      ref_sign_reg_3 <= ref_sign_reg_2; // @[WHTDesigns.scala 668:27]
    end
    if (reset) begin // @[WHTDesigns.scala 520:34]
      ref_sign_reg_4 <= 1'h0; // @[WHTDesigns.scala 520:34]
    end else begin
      ref_sign_reg_4 <= ref_sign_reg_3; // @[WHTDesigns.scala 668:27]
    end
    if (reset) begin // @[WHTDesigns.scala 520:34]
      ref_sign_reg_5 <= 1'h0; // @[WHTDesigns.scala 520:34]
    end else begin
      ref_sign_reg_5 <= ref_sign_reg_4; // @[WHTDesigns.scala 668:27]
    end
    if (reset) begin // @[WHTDesigns.scala 520:34]
      ref_sign_reg_6 <= 1'h0; // @[WHTDesigns.scala 520:34]
    end else begin
      ref_sign_reg_6 <= ref_sign_reg_5; // @[WHTDesigns.scala 668:27]
    end
    if (reset) begin // @[WHTDesigns.scala 520:34]
      ref_sign_reg_7 <= 1'h0; // @[WHTDesigns.scala 520:34]
    end else begin
      ref_sign_reg_7 <= ref_sign_reg_6; // @[WHTDesigns.scala 668:27]
    end
    if (reset) begin // @[WHTDesigns.scala 521:31]
      ref_frac_reg_0 <= 52'h0; // @[WHTDesigns.scala 521:31]
    end else if (exp_subber_out_c_reg_1) begin // @[WHTDesigns.scala 568:43]
      ref_frac_reg_0 <= frac_reg_2_1; // @[WHTDesigns.scala 572:16]
    end else begin
      ref_frac_reg_0 <= frac_reg_2_0; // @[WHTDesigns.scala 579:16]
    end
    if (reset) begin // @[WHTDesigns.scala 521:31]
      ref_frac_reg_1 <= 52'h0; // @[WHTDesigns.scala 521:31]
    end else begin
      ref_frac_reg_1 <= ref_frac_reg_0; // @[WHTDesigns.scala 669:27]
    end
    if (reset) begin // @[WHTDesigns.scala 521:31]
      ref_frac_reg_2 <= 52'h0; // @[WHTDesigns.scala 521:31]
    end else begin
      ref_frac_reg_2 <= ref_frac_reg_1; // @[WHTDesigns.scala 669:27]
    end
    if (reset) begin // @[WHTDesigns.scala 521:31]
      ref_frac_reg_3 <= 52'h0; // @[WHTDesigns.scala 521:31]
    end else begin
      ref_frac_reg_3 <= ref_frac_reg_2; // @[WHTDesigns.scala 669:27]
    end
    if (reset) begin // @[WHTDesigns.scala 521:31]
      ref_frac_reg_4 <= 52'h0; // @[WHTDesigns.scala 521:31]
    end else begin
      ref_frac_reg_4 <= ref_frac_reg_3; // @[WHTDesigns.scala 669:27]
    end
    if (reset) begin // @[WHTDesigns.scala 521:31]
      ref_frac_reg_5 <= 52'h0; // @[WHTDesigns.scala 521:31]
    end else begin
      ref_frac_reg_5 <= ref_frac_reg_4; // @[WHTDesigns.scala 669:27]
    end
    if (reset) begin // @[WHTDesigns.scala 521:31]
      ref_frac_reg_6 <= 52'h0; // @[WHTDesigns.scala 521:31]
    end else begin
      ref_frac_reg_6 <= ref_frac_reg_5; // @[WHTDesigns.scala 669:27]
    end
    if (reset) begin // @[WHTDesigns.scala 521:31]
      ref_frac_reg_7 <= 52'h0; // @[WHTDesigns.scala 521:31]
    end else begin
      ref_frac_reg_7 <= ref_frac_reg_6; // @[WHTDesigns.scala 669:27]
    end
    if (reset) begin // @[WHTDesigns.scala 522:31]
      ref_exp_reg_0 <= 11'h0; // @[WHTDesigns.scala 522:31]
    end else if (exp_subber_out_c_reg_1) begin // @[WHTDesigns.scala 568:43]
      ref_exp_reg_0 <= exp_reg_2_1; // @[WHTDesigns.scala 569:15]
    end else begin
      ref_exp_reg_0 <= exp_reg_2_0; // @[WHTDesigns.scala 576:15]
    end
    if (reset) begin // @[WHTDesigns.scala 522:31]
      ref_exp_reg_1 <= 11'h0; // @[WHTDesigns.scala 522:31]
    end else begin
      ref_exp_reg_1 <= ref_exp_reg_0; // @[WHTDesigns.scala 670:26]
    end
    if (reset) begin // @[WHTDesigns.scala 522:31]
      ref_exp_reg_2 <= 11'h0; // @[WHTDesigns.scala 522:31]
    end else begin
      ref_exp_reg_2 <= ref_exp_reg_1; // @[WHTDesigns.scala 670:26]
    end
    if (reset) begin // @[WHTDesigns.scala 522:31]
      ref_exp_reg_3 <= 11'h0; // @[WHTDesigns.scala 522:31]
    end else begin
      ref_exp_reg_3 <= ref_exp_reg_2; // @[WHTDesigns.scala 670:26]
    end
    if (reset) begin // @[WHTDesigns.scala 522:31]
      ref_exp_reg_4 <= 11'h0; // @[WHTDesigns.scala 522:31]
    end else begin
      ref_exp_reg_4 <= ref_exp_reg_3; // @[WHTDesigns.scala 670:26]
    end
    if (reset) begin // @[WHTDesigns.scala 522:31]
      ref_exp_reg_5 <= 11'h0; // @[WHTDesigns.scala 522:31]
    end else begin
      ref_exp_reg_5 <= ref_exp_reg_4; // @[WHTDesigns.scala 670:26]
    end
    if (reset) begin // @[WHTDesigns.scala 522:31]
      ref_exp_reg_6 <= 11'h0; // @[WHTDesigns.scala 522:31]
    end else begin
      ref_exp_reg_6 <= ref_exp_reg_5; // @[WHTDesigns.scala 670:26]
    end
    if (reset) begin // @[WHTDesigns.scala 522:31]
      ref_exp_reg_7 <= 11'h0; // @[WHTDesigns.scala 522:31]
    end else begin
      ref_exp_reg_7 <= ref_exp_reg_6; // @[WHTDesigns.scala 670:26]
    end
    if (reset) begin // @[WHTDesigns.scala 523:31]
      sub_exp_reg_0 <= 11'h0; // @[WHTDesigns.scala 523:31]
    end else if (exp_subber_out_c_reg_1) begin // @[WHTDesigns.scala 568:43]
      sub_exp_reg_0 <= cmpl_exp_subber_out_s_reg_0; // @[WHTDesigns.scala 570:15]
    end else begin
      sub_exp_reg_0 <= exp_subber_out_s_reg_1; // @[WHTDesigns.scala 577:15]
    end
    if (reset) begin // @[WHTDesigns.scala 523:31]
      sub_exp_reg_1 <= 11'h0; // @[WHTDesigns.scala 523:31]
    end else begin
      sub_exp_reg_1 <= sub_exp_reg_0; // @[WHTDesigns.scala 671:26]
    end
    if (reset) begin // @[WHTDesigns.scala 523:31]
      sub_exp_reg_2 <= 11'h0; // @[WHTDesigns.scala 523:31]
    end else begin
      sub_exp_reg_2 <= sub_exp_reg_1; // @[WHTDesigns.scala 671:26]
    end
    if (reset) begin // @[WHTDesigns.scala 523:31]
      sub_exp_reg_3 <= 11'h0; // @[WHTDesigns.scala 523:31]
    end else begin
      sub_exp_reg_3 <= sub_exp_reg_2; // @[WHTDesigns.scala 671:26]
    end
    if (reset) begin // @[WHTDesigns.scala 523:31]
      sub_exp_reg_4 <= 11'h0; // @[WHTDesigns.scala 523:31]
    end else begin
      sub_exp_reg_4 <= sub_exp_reg_3; // @[WHTDesigns.scala 671:26]
    end
    if (reset) begin // @[WHTDesigns.scala 523:31]
      sub_exp_reg_5 <= 11'h0; // @[WHTDesigns.scala 523:31]
    end else begin
      sub_exp_reg_5 <= sub_exp_reg_4; // @[WHTDesigns.scala 671:26]
    end
    if (reset) begin // @[WHTDesigns.scala 523:31]
      sub_exp_reg_6 <= 11'h0; // @[WHTDesigns.scala 523:31]
    end else begin
      sub_exp_reg_6 <= sub_exp_reg_5; // @[WHTDesigns.scala 671:26]
    end
    if (reset) begin // @[WHTDesigns.scala 523:31]
      sub_exp_reg_7 <= 11'h0; // @[WHTDesigns.scala 523:31]
    end else begin
      sub_exp_reg_7 <= sub_exp_reg_6; // @[WHTDesigns.scala 671:26]
    end
    if (reset) begin // @[WHTDesigns.scala 525:43]
      wfrac_adder_io_out_s_reg_0 <= 53'h0; // @[WHTDesigns.scala 525:43]
    end else begin
      wfrac_adder_io_out_s_reg_0 <= wfrac_adder_io_out_s; // @[WHTDesigns.scala 651:35]
    end
    if (reset) begin // @[WHTDesigns.scala 525:43]
      wfrac_adder_io_out_s_reg_1 <= 53'h0; // @[WHTDesigns.scala 525:43]
    end else begin
      wfrac_adder_io_out_s_reg_1 <= wfrac_adder_io_out_s_reg_0; // @[WHTDesigns.scala 680:39]
    end
    if (reset) begin // @[WHTDesigns.scala 525:43]
      wfrac_adder_io_out_s_reg_2 <= 53'h0; // @[WHTDesigns.scala 525:43]
    end else begin
      wfrac_adder_io_out_s_reg_2 <= wfrac_adder_io_out_s_reg_1; // @[WHTDesigns.scala 680:39]
    end
    if (reset) begin // @[WHTDesigns.scala 526:43]
      wfrac_adder_io_out_c_reg_0 <= 1'h0; // @[WHTDesigns.scala 526:43]
    end else begin
      wfrac_adder_io_out_c_reg_0 <= wfrac_adder_io_out_c; // @[WHTDesigns.scala 652:35]
    end
    if (reset) begin // @[WHTDesigns.scala 528:38]
      new_sign_reg_0 <= 1'h0; // @[WHTDesigns.scala 528:38]
    end else begin
      new_sign_reg_0 <= new_sign; // @[WHTDesigns.scala 645:23]
    end
    if (reset) begin // @[WHTDesigns.scala 528:38]
      new_sign_reg_1 <= 1'h0; // @[WHTDesigns.scala 528:38]
    end else begin
      new_sign_reg_1 <= new_sign_reg_0; // @[WHTDesigns.scala 676:27]
    end
    if (reset) begin // @[WHTDesigns.scala 528:38]
      new_sign_reg_2 <= 1'h0; // @[WHTDesigns.scala 528:38]
    end else begin
      new_sign_reg_2 <= new_sign_reg_1; // @[WHTDesigns.scala 676:27]
    end
    if (reset) begin // @[WHTDesigns.scala 528:38]
      new_sign_reg_3 <= 1'h0; // @[WHTDesigns.scala 528:38]
    end else begin
      new_sign_reg_3 <= new_sign_reg_2; // @[WHTDesigns.scala 676:27]
    end
    if (reset) begin // @[WHTDesigns.scala 528:38]
      new_sign_reg_4 <= 1'h0; // @[WHTDesigns.scala 528:38]
    end else begin
      new_sign_reg_4 <= new_sign_reg_3; // @[WHTDesigns.scala 676:27]
    end
    if (reset) begin // @[WHTDesigns.scala 528:38]
      new_sign_reg_5 <= 1'h0; // @[WHTDesigns.scala 528:38]
    end else if (in_data_0_reg_10[62:0] == 63'h0 & in_data_1_reg_10[62:0] == 63'h0) begin // @[WHTDesigns.scala 696:90]
      new_sign_reg_5 <= 1'h0; // @[WHTDesigns.scala 697:25]
    end else if (sub_exp_reg_7 >= 11'h34) begin // @[WHTDesigns.scala 700:48]
      new_sign_reg_5 <= ref_sign_reg_7; // @[WHTDesigns.scala 701:25]
    end else if (NoChange_reg_4) begin // @[WHTDesigns.scala 704:43]
      new_sign_reg_5 <= new_sign_reg_4; // @[WHTDesigns.scala 705:25]
    end else begin
      new_sign_reg_5 <= _GEN_32;
    end
    new_frac_reg_0 <= _GEN_46[51:0]; // @[WHTDesigns.scala 529:{31,31}]
    new_exp_reg_0 <= _GEN_47[10:0]; // @[WHTDesigns.scala 530:{31,31}]
    if (reset) begin // @[WHTDesigns.scala 531:31]
      NoChange_reg_0 <= 1'h0; // @[WHTDesigns.scala 531:31]
    end else begin
      NoChange_reg_0 <= NoChange; // @[WHTDesigns.scala 648:23]
    end
    if (reset) begin // @[WHTDesigns.scala 531:31]
      NoChange_reg_1 <= 1'h0; // @[WHTDesigns.scala 531:31]
    end else begin
      NoChange_reg_1 <= NoChange_reg_0; // @[WHTDesigns.scala 674:27]
    end
    if (reset) begin // @[WHTDesigns.scala 531:31]
      NoChange_reg_2 <= 1'h0; // @[WHTDesigns.scala 531:31]
    end else begin
      NoChange_reg_2 <= NoChange_reg_1; // @[WHTDesigns.scala 674:27]
    end
    if (reset) begin // @[WHTDesigns.scala 531:31]
      NoChange_reg_3 <= 1'h0; // @[WHTDesigns.scala 531:31]
    end else begin
      NoChange_reg_3 <= NoChange_reg_2; // @[WHTDesigns.scala 674:27]
    end
    if (reset) begin // @[WHTDesigns.scala 531:31]
      NoChange_reg_4 <= 1'h0; // @[WHTDesigns.scala 531:31]
    end else begin
      NoChange_reg_4 <= NoChange_reg_3; // @[WHTDesigns.scala 674:27]
    end
    if (reset) begin // @[WHTDesigns.scala 532:31]
      ShiftDir_reg_0 <= 1'h0; // @[WHTDesigns.scala 532:31]
    end else begin
      ShiftDir_reg_0 <= ShiftDir; // @[WHTDesigns.scala 649:23]
    end
    if (reset) begin // @[WHTDesigns.scala 532:31]
      ShiftDir_reg_1 <= 1'h0; // @[WHTDesigns.scala 532:31]
    end else begin
      ShiftDir_reg_1 <= ShiftDir_reg_0; // @[WHTDesigns.scala 675:27]
    end
    if (reset) begin // @[WHTDesigns.scala 532:31]
      ShiftDir_reg_2 <= 1'h0; // @[WHTDesigns.scala 532:31]
    end else begin
      ShiftDir_reg_2 <= ShiftDir_reg_1; // @[WHTDesigns.scala 675:27]
    end
    if (reset) begin // @[WHTDesigns.scala 532:31]
      ShiftDir_reg_3 <= 1'h0; // @[WHTDesigns.scala 532:31]
    end else begin
      ShiftDir_reg_3 <= ShiftDir_reg_2; // @[WHTDesigns.scala 675:27]
    end
    if (reset) begin // @[WHTDesigns.scala 532:31]
      ShiftDir_reg_4 <= 1'h0; // @[WHTDesigns.scala 532:31]
    end else begin
      ShiftDir_reg_4 <= ShiftDir_reg_3; // @[WHTDesigns.scala 675:27]
    end
    if (reset) begin // @[WHTDesigns.scala 534:41]
      wfrac_adder_result_reg_0 <= 53'h0; // @[WHTDesigns.scala 534:41]
    end else if (new_sign_reg_1 & ^_wfrac_adder_result_T) begin // @[WHTDesigns.scala 616:30]
      wfrac_adder_result_reg_0 <= cmpl_wfrac_adder_io_out_s_reg_0;
    end else begin
      wfrac_adder_result_reg_0 <= wfrac_adder_io_out_s_reg_2;
    end
    if (reset) begin // @[WHTDesigns.scala 534:41]
      wfrac_adder_result_reg_1 <= 53'h0; // @[WHTDesigns.scala 534:41]
    end else begin
      wfrac_adder_result_reg_1 <= wfrac_adder_result_reg_0; // @[WHTDesigns.scala 679:37]
    end
    if (reset) begin // @[WHTDesigns.scala 534:41]
      wfrac_adder_result_reg_2 <= 53'h0; // @[WHTDesigns.scala 534:41]
    end else begin
      wfrac_adder_result_reg_2 <= wfrac_adder_result_reg_1; // @[WHTDesigns.scala 679:37]
    end
    if (reset) begin // @[WHTDesigns.scala 536:36]
      leadingOneDet_reg_0 <= 7'h0; // @[WHTDesigns.scala 536:36]
    end else begin
      leadingOneDet_reg_0 <= leadingOneDet; // @[WHTDesigns.scala 656:28]
    end
    if (reset) begin // @[WHTDesigns.scala 536:36]
      leadingOneDet_reg_1 <= 7'h0; // @[WHTDesigns.scala 536:36]
    end else begin
      leadingOneDet_reg_1 <= leadingOneDet_reg_0; // @[WHTDesigns.scala 688:32]
    end
    if (reset) begin // @[WHTDesigns.scala 538:32]
      in_data_0_reg_0 <= 64'h0; // @[WHTDesigns.scala 538:32]
    end else begin
      in_data_0_reg_0 <= 64'h3ff8000000000000; // @[WHTDesigns.scala 627:24]
    end
    if (reset) begin // @[WHTDesigns.scala 538:32]
      in_data_0_reg_1 <= 64'h0; // @[WHTDesigns.scala 538:32]
    end else begin
      in_data_0_reg_1 <= in_data_0_reg_0; // @[WHTDesigns.scala 664:28]
    end
    if (reset) begin // @[WHTDesigns.scala 538:32]
      in_data_0_reg_2 <= 64'h0; // @[WHTDesigns.scala 538:32]
    end else begin
      in_data_0_reg_2 <= in_data_0_reg_1; // @[WHTDesigns.scala 664:28]
    end
    if (reset) begin // @[WHTDesigns.scala 538:32]
      in_data_0_reg_3 <= 64'h0; // @[WHTDesigns.scala 538:32]
    end else begin
      in_data_0_reg_3 <= in_data_0_reg_2; // @[WHTDesigns.scala 664:28]
    end
    if (reset) begin // @[WHTDesigns.scala 538:32]
      in_data_0_reg_4 <= 64'h0; // @[WHTDesigns.scala 538:32]
    end else begin
      in_data_0_reg_4 <= in_data_0_reg_3; // @[WHTDesigns.scala 664:28]
    end
    if (reset) begin // @[WHTDesigns.scala 538:32]
      in_data_0_reg_5 <= 64'h0; // @[WHTDesigns.scala 538:32]
    end else begin
      in_data_0_reg_5 <= in_data_0_reg_4; // @[WHTDesigns.scala 664:28]
    end
    if (reset) begin // @[WHTDesigns.scala 538:32]
      in_data_0_reg_6 <= 64'h0; // @[WHTDesigns.scala 538:32]
    end else begin
      in_data_0_reg_6 <= in_data_0_reg_5; // @[WHTDesigns.scala 664:28]
    end
    if (reset) begin // @[WHTDesigns.scala 538:32]
      in_data_0_reg_7 <= 64'h0; // @[WHTDesigns.scala 538:32]
    end else begin
      in_data_0_reg_7 <= in_data_0_reg_6; // @[WHTDesigns.scala 664:28]
    end
    if (reset) begin // @[WHTDesigns.scala 538:32]
      in_data_0_reg_8 <= 64'h0; // @[WHTDesigns.scala 538:32]
    end else begin
      in_data_0_reg_8 <= in_data_0_reg_7; // @[WHTDesigns.scala 664:28]
    end
    if (reset) begin // @[WHTDesigns.scala 538:32]
      in_data_0_reg_9 <= 64'h0; // @[WHTDesigns.scala 538:32]
    end else begin
      in_data_0_reg_9 <= in_data_0_reg_8; // @[WHTDesigns.scala 664:28]
    end
    if (reset) begin // @[WHTDesigns.scala 538:32]
      in_data_0_reg_10 <= 64'h0; // @[WHTDesigns.scala 538:32]
    end else begin
      in_data_0_reg_10 <= in_data_0_reg_9; // @[WHTDesigns.scala 664:28]
    end
    if (reset) begin // @[WHTDesigns.scala 539:32]
      in_data_1_reg_0 <= 64'h0; // @[WHTDesigns.scala 539:32]
    end else begin
      in_data_1_reg_0 <= in_data_1; // @[WHTDesigns.scala 628:24]
    end
    if (reset) begin // @[WHTDesigns.scala 539:32]
      in_data_1_reg_1 <= 64'h0; // @[WHTDesigns.scala 539:32]
    end else begin
      in_data_1_reg_1 <= in_data_1_reg_0; // @[WHTDesigns.scala 665:28]
    end
    if (reset) begin // @[WHTDesigns.scala 539:32]
      in_data_1_reg_2 <= 64'h0; // @[WHTDesigns.scala 539:32]
    end else begin
      in_data_1_reg_2 <= in_data_1_reg_1; // @[WHTDesigns.scala 665:28]
    end
    if (reset) begin // @[WHTDesigns.scala 539:32]
      in_data_1_reg_3 <= 64'h0; // @[WHTDesigns.scala 539:32]
    end else begin
      in_data_1_reg_3 <= in_data_1_reg_2; // @[WHTDesigns.scala 665:28]
    end
    if (reset) begin // @[WHTDesigns.scala 539:32]
      in_data_1_reg_4 <= 64'h0; // @[WHTDesigns.scala 539:32]
    end else begin
      in_data_1_reg_4 <= in_data_1_reg_3; // @[WHTDesigns.scala 665:28]
    end
    if (reset) begin // @[WHTDesigns.scala 539:32]
      in_data_1_reg_5 <= 64'h0; // @[WHTDesigns.scala 539:32]
    end else begin
      in_data_1_reg_5 <= in_data_1_reg_4; // @[WHTDesigns.scala 665:28]
    end
    if (reset) begin // @[WHTDesigns.scala 539:32]
      in_data_1_reg_6 <= 64'h0; // @[WHTDesigns.scala 539:32]
    end else begin
      in_data_1_reg_6 <= in_data_1_reg_5; // @[WHTDesigns.scala 665:28]
    end
    if (reset) begin // @[WHTDesigns.scala 539:32]
      in_data_1_reg_7 <= 64'h0; // @[WHTDesigns.scala 539:32]
    end else begin
      in_data_1_reg_7 <= in_data_1_reg_6; // @[WHTDesigns.scala 665:28]
    end
    if (reset) begin // @[WHTDesigns.scala 539:32]
      in_data_1_reg_8 <= 64'h0; // @[WHTDesigns.scala 539:32]
    end else begin
      in_data_1_reg_8 <= in_data_1_reg_7; // @[WHTDesigns.scala 665:28]
    end
    if (reset) begin // @[WHTDesigns.scala 539:32]
      in_data_1_reg_9 <= 64'h0; // @[WHTDesigns.scala 539:32]
    end else begin
      in_data_1_reg_9 <= in_data_1_reg_8; // @[WHTDesigns.scala 665:28]
    end
    if (reset) begin // @[WHTDesigns.scala 539:32]
      in_data_1_reg_10 <= 64'h0; // @[WHTDesigns.scala 539:32]
    end else begin
      in_data_1_reg_10 <= in_data_1_reg_9; // @[WHTDesigns.scala 665:28]
    end
    if (reset) begin // @[WHTDesigns.scala 541:40]
      exp_subber2_out_s_reg_0 <= 11'h0; // @[WHTDesigns.scala 541:40]
    end else begin
      exp_subber2_out_s_reg_0 <= exp_subber2_io_out_s; // @[WHTDesigns.scala 658:32]
    end
    if (reset) begin // @[WHTDesigns.scala 542:40]
      exp_subber2_out_c_reg_0 <= 1'h0; // @[WHTDesigns.scala 542:40]
    end else begin
      exp_subber2_out_c_reg_0 <= exp_subber2_io_out_c; // @[WHTDesigns.scala 659:32]
    end
    if (reset) begin // @[WHTDesigns.scala 563:44]
      cmpl_exp_subber_out_s_reg_0 <= 11'h0; // @[WHTDesigns.scala 563:44]
    end else begin
      cmpl_exp_subber_out_s_reg_0 <= _cmpl_exp_subber_out_s_reg_0_T_2; // @[WHTDesigns.scala 565:36]
    end
    if (reset) begin // @[WHTDesigns.scala 584:45]
      cmpl_temp_wfrac_add_in_reg_0_0 <= 53'h0; // @[WHTDesigns.scala 584:45]
    end else begin
      cmpl_temp_wfrac_add_in_reg_0_0 <= _cmpl_temp_wfrac_add_in_reg_0_0_T_2; // @[WHTDesigns.scala 586:40]
    end
    if (reset) begin // @[WHTDesigns.scala 584:45]
      cmpl_temp_wfrac_add_in_reg_0_1 <= 53'h0; // @[WHTDesigns.scala 584:45]
    end else begin
      cmpl_temp_wfrac_add_in_reg_0_1 <= _cmpl_temp_wfrac_add_in_reg_0_1_T_2; // @[WHTDesigns.scala 587:40]
    end
    if (reset) begin // @[WHTDesigns.scala 609:48]
      cmpl_wfrac_adder_io_out_s_reg_0 <= 53'h0; // @[WHTDesigns.scala 609:48]
    end else begin
      cmpl_wfrac_adder_io_out_s_reg_0 <= _cmpl_wfrac_adder_io_out_s_reg_0_T_2; // @[WHTDesigns.scala 612:40]
    end
    if (reset) begin // @[WHTDesigns.scala 693:28]
      reg_out_s <= 64'h0; // @[WHTDesigns.scala 693:28]
    end else begin
      reg_out_s <= _reg_out_s_T_1; // @[WHTDesigns.scala 732:17]
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
  _RAND_0 = {1{`RANDOM}};
  out_ready_reg_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  out_ready_reg_r_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  out_ready_reg_r_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  out_ready_reg_r_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  out_ready_reg_r_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  out_ready_reg_r_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  out_ready_reg_r_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  out_ready_reg_r_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  out_ready_reg_r_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  out_ready_reg_r_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  out_ready_reg_r_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  out_ready_reg_r_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  out_ready_reg = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  sign_reg_0_1 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sign_reg_1_1 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  sign_reg_2_1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  sign_reg_3_1 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sign_reg_4_1 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  sign_reg_5_1 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  sign_reg_6_1 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  sign_reg_7_1 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  sign_reg_8_1 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  sign_reg_9_1 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  sign_reg_10_1 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  exp_reg_0_0 = _RAND_24[10:0];
  _RAND_25 = {1{`RANDOM}};
  exp_reg_0_1 = _RAND_25[10:0];
  _RAND_26 = {1{`RANDOM}};
  exp_reg_1_0 = _RAND_26[10:0];
  _RAND_27 = {1{`RANDOM}};
  exp_reg_1_1 = _RAND_27[10:0];
  _RAND_28 = {1{`RANDOM}};
  exp_reg_2_0 = _RAND_28[10:0];
  _RAND_29 = {1{`RANDOM}};
  exp_reg_2_1 = _RAND_29[10:0];
  _RAND_30 = {2{`RANDOM}};
  frac_reg_0_0 = _RAND_30[51:0];
  _RAND_31 = {2{`RANDOM}};
  frac_reg_0_1 = _RAND_31[51:0];
  _RAND_32 = {2{`RANDOM}};
  frac_reg_1_0 = _RAND_32[51:0];
  _RAND_33 = {2{`RANDOM}};
  frac_reg_1_1 = _RAND_33[51:0];
  _RAND_34 = {2{`RANDOM}};
  frac_reg_2_0 = _RAND_34[51:0];
  _RAND_35 = {2{`RANDOM}};
  frac_reg_2_1 = _RAND_35[51:0];
  _RAND_36 = {2{`RANDOM}};
  wfrac_reg_0_0 = _RAND_36[52:0];
  _RAND_37 = {2{`RANDOM}};
  wfrac_reg_0_1 = _RAND_37[52:0];
  _RAND_38 = {2{`RANDOM}};
  wfrac_reg_1_0 = _RAND_38[52:0];
  _RAND_39 = {2{`RANDOM}};
  wfrac_reg_1_1 = _RAND_39[52:0];
  _RAND_40 = {2{`RANDOM}};
  wfrac_reg_2_0 = _RAND_40[52:0];
  _RAND_41 = {2{`RANDOM}};
  wfrac_reg_2_1 = _RAND_41[52:0];
  _RAND_42 = {1{`RANDOM}};
  exp_subber_out_s_reg_0 = _RAND_42[10:0];
  _RAND_43 = {1{`RANDOM}};
  exp_subber_out_s_reg_1 = _RAND_43[10:0];
  _RAND_44 = {1{`RANDOM}};
  exp_subber_out_c_reg_0 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  exp_subber_out_c_reg_1 = _RAND_45[0:0];
  _RAND_46 = {2{`RANDOM}};
  temp_wfrac_add_in_reg_0_0 = _RAND_46[52:0];
  _RAND_47 = {2{`RANDOM}};
  temp_wfrac_add_in_reg_0_1 = _RAND_47[52:0];
  _RAND_48 = {2{`RANDOM}};
  temp_wfrac_add_in_reg_1_0 = _RAND_48[52:0];
  _RAND_49 = {2{`RANDOM}};
  temp_wfrac_add_in_reg_1_1 = _RAND_49[52:0];
  _RAND_50 = {1{`RANDOM}};
  ref_sign_reg_0 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  ref_sign_reg_1 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  ref_sign_reg_2 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  ref_sign_reg_3 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  ref_sign_reg_4 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  ref_sign_reg_5 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  ref_sign_reg_6 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  ref_sign_reg_7 = _RAND_57[0:0];
  _RAND_58 = {2{`RANDOM}};
  ref_frac_reg_0 = _RAND_58[51:0];
  _RAND_59 = {2{`RANDOM}};
  ref_frac_reg_1 = _RAND_59[51:0];
  _RAND_60 = {2{`RANDOM}};
  ref_frac_reg_2 = _RAND_60[51:0];
  _RAND_61 = {2{`RANDOM}};
  ref_frac_reg_3 = _RAND_61[51:0];
  _RAND_62 = {2{`RANDOM}};
  ref_frac_reg_4 = _RAND_62[51:0];
  _RAND_63 = {2{`RANDOM}};
  ref_frac_reg_5 = _RAND_63[51:0];
  _RAND_64 = {2{`RANDOM}};
  ref_frac_reg_6 = _RAND_64[51:0];
  _RAND_65 = {2{`RANDOM}};
  ref_frac_reg_7 = _RAND_65[51:0];
  _RAND_66 = {1{`RANDOM}};
  ref_exp_reg_0 = _RAND_66[10:0];
  _RAND_67 = {1{`RANDOM}};
  ref_exp_reg_1 = _RAND_67[10:0];
  _RAND_68 = {1{`RANDOM}};
  ref_exp_reg_2 = _RAND_68[10:0];
  _RAND_69 = {1{`RANDOM}};
  ref_exp_reg_3 = _RAND_69[10:0];
  _RAND_70 = {1{`RANDOM}};
  ref_exp_reg_4 = _RAND_70[10:0];
  _RAND_71 = {1{`RANDOM}};
  ref_exp_reg_5 = _RAND_71[10:0];
  _RAND_72 = {1{`RANDOM}};
  ref_exp_reg_6 = _RAND_72[10:0];
  _RAND_73 = {1{`RANDOM}};
  ref_exp_reg_7 = _RAND_73[10:0];
  _RAND_74 = {1{`RANDOM}};
  sub_exp_reg_0 = _RAND_74[10:0];
  _RAND_75 = {1{`RANDOM}};
  sub_exp_reg_1 = _RAND_75[10:0];
  _RAND_76 = {1{`RANDOM}};
  sub_exp_reg_2 = _RAND_76[10:0];
  _RAND_77 = {1{`RANDOM}};
  sub_exp_reg_3 = _RAND_77[10:0];
  _RAND_78 = {1{`RANDOM}};
  sub_exp_reg_4 = _RAND_78[10:0];
  _RAND_79 = {1{`RANDOM}};
  sub_exp_reg_5 = _RAND_79[10:0];
  _RAND_80 = {1{`RANDOM}};
  sub_exp_reg_6 = _RAND_80[10:0];
  _RAND_81 = {1{`RANDOM}};
  sub_exp_reg_7 = _RAND_81[10:0];
  _RAND_82 = {2{`RANDOM}};
  wfrac_adder_io_out_s_reg_0 = _RAND_82[52:0];
  _RAND_83 = {2{`RANDOM}};
  wfrac_adder_io_out_s_reg_1 = _RAND_83[52:0];
  _RAND_84 = {2{`RANDOM}};
  wfrac_adder_io_out_s_reg_2 = _RAND_84[52:0];
  _RAND_85 = {1{`RANDOM}};
  wfrac_adder_io_out_c_reg_0 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  new_sign_reg_0 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  new_sign_reg_1 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  new_sign_reg_2 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  new_sign_reg_3 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  new_sign_reg_4 = _RAND_90[0:0];
  _RAND_91 = {1{`RANDOM}};
  new_sign_reg_5 = _RAND_91[0:0];
  _RAND_92 = {2{`RANDOM}};
  new_frac_reg_0 = _RAND_92[51:0];
  _RAND_93 = {1{`RANDOM}};
  new_exp_reg_0 = _RAND_93[10:0];
  _RAND_94 = {1{`RANDOM}};
  NoChange_reg_0 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  NoChange_reg_1 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  NoChange_reg_2 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  NoChange_reg_3 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  NoChange_reg_4 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  ShiftDir_reg_0 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  ShiftDir_reg_1 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  ShiftDir_reg_2 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  ShiftDir_reg_3 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  ShiftDir_reg_4 = _RAND_103[0:0];
  _RAND_104 = {2{`RANDOM}};
  wfrac_adder_result_reg_0 = _RAND_104[52:0];
  _RAND_105 = {2{`RANDOM}};
  wfrac_adder_result_reg_1 = _RAND_105[52:0];
  _RAND_106 = {2{`RANDOM}};
  wfrac_adder_result_reg_2 = _RAND_106[52:0];
  _RAND_107 = {1{`RANDOM}};
  leadingOneDet_reg_0 = _RAND_107[6:0];
  _RAND_108 = {1{`RANDOM}};
  leadingOneDet_reg_1 = _RAND_108[6:0];
  _RAND_109 = {2{`RANDOM}};
  in_data_0_reg_0 = _RAND_109[63:0];
  _RAND_110 = {2{`RANDOM}};
  in_data_0_reg_1 = _RAND_110[63:0];
  _RAND_111 = {2{`RANDOM}};
  in_data_0_reg_2 = _RAND_111[63:0];
  _RAND_112 = {2{`RANDOM}};
  in_data_0_reg_3 = _RAND_112[63:0];
  _RAND_113 = {2{`RANDOM}};
  in_data_0_reg_4 = _RAND_113[63:0];
  _RAND_114 = {2{`RANDOM}};
  in_data_0_reg_5 = _RAND_114[63:0];
  _RAND_115 = {2{`RANDOM}};
  in_data_0_reg_6 = _RAND_115[63:0];
  _RAND_116 = {2{`RANDOM}};
  in_data_0_reg_7 = _RAND_116[63:0];
  _RAND_117 = {2{`RANDOM}};
  in_data_0_reg_8 = _RAND_117[63:0];
  _RAND_118 = {2{`RANDOM}};
  in_data_0_reg_9 = _RAND_118[63:0];
  _RAND_119 = {2{`RANDOM}};
  in_data_0_reg_10 = _RAND_119[63:0];
  _RAND_120 = {2{`RANDOM}};
  in_data_1_reg_0 = _RAND_120[63:0];
  _RAND_121 = {2{`RANDOM}};
  in_data_1_reg_1 = _RAND_121[63:0];
  _RAND_122 = {2{`RANDOM}};
  in_data_1_reg_2 = _RAND_122[63:0];
  _RAND_123 = {2{`RANDOM}};
  in_data_1_reg_3 = _RAND_123[63:0];
  _RAND_124 = {2{`RANDOM}};
  in_data_1_reg_4 = _RAND_124[63:0];
  _RAND_125 = {2{`RANDOM}};
  in_data_1_reg_5 = _RAND_125[63:0];
  _RAND_126 = {2{`RANDOM}};
  in_data_1_reg_6 = _RAND_126[63:0];
  _RAND_127 = {2{`RANDOM}};
  in_data_1_reg_7 = _RAND_127[63:0];
  _RAND_128 = {2{`RANDOM}};
  in_data_1_reg_8 = _RAND_128[63:0];
  _RAND_129 = {2{`RANDOM}};
  in_data_1_reg_9 = _RAND_129[63:0];
  _RAND_130 = {2{`RANDOM}};
  in_data_1_reg_10 = _RAND_130[63:0];
  _RAND_131 = {1{`RANDOM}};
  exp_subber2_out_s_reg_0 = _RAND_131[10:0];
  _RAND_132 = {1{`RANDOM}};
  exp_subber2_out_c_reg_0 = _RAND_132[0:0];
  _RAND_133 = {1{`RANDOM}};
  cmpl_exp_subber_out_s_reg_0 = _RAND_133[10:0];
  _RAND_134 = {2{`RANDOM}};
  cmpl_temp_wfrac_add_in_reg_0_0 = _RAND_134[52:0];
  _RAND_135 = {2{`RANDOM}};
  cmpl_temp_wfrac_add_in_reg_0_1 = _RAND_135[52:0];
  _RAND_136 = {2{`RANDOM}};
  cmpl_wfrac_adder_io_out_s_reg_0 = _RAND_136[52:0];
  _RAND_137 = {2{`RANDOM}};
  reg_out_s = _RAND_137[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FP_subtractor_64_13cc(
  input         clock,
  input         reset,
  input         in_valid,
  input  [63:0] in_data_1,
  output [63:0] out_data,
  output        out_ready
);
  wire  fp_adder_clock; // @[WHTDesigns.scala 1368:26]
  wire  fp_adder_reset; // @[WHTDesigns.scala 1368:26]
  wire  fp_adder_in_valid; // @[WHTDesigns.scala 1368:26]
  wire [63:0] fp_adder_in_data_1; // @[WHTDesigns.scala 1368:26]
  wire [63:0] fp_adder_out_data; // @[WHTDesigns.scala 1368:26]
  wire  fp_adder_out_ready; // @[WHTDesigns.scala 1368:26]
  wire  _fp_adder_in_data_1_T_1 = ~in_data_1[63]; // @[WHTDesigns.scala 1371:28]
  FP_adder_64_13cc_sqrt fp_adder ( // @[WHTDesigns.scala 1368:26]
    .clock(fp_adder_clock),
    .reset(fp_adder_reset),
    .in_valid(fp_adder_in_valid),
    .in_data_1(fp_adder_in_data_1),
    .out_data(fp_adder_out_data),
    .out_ready(fp_adder_out_ready)
  );
  assign out_data = fp_adder_out_data; // @[WHTDesigns.scala 1373:14]
  assign out_ready = fp_adder_out_ready; // @[WHTDesigns.scala 1372:15]
  assign fp_adder_clock = clock;
  assign fp_adder_reset = reset;
  assign fp_adder_in_valid = in_valid; // @[WHTDesigns.scala 1369:23]
  assign fp_adder_in_data_1 = {_fp_adder_in_data_1_T_1,in_data_1[62:0]}; // @[WHTDesigns.scala 1371:45]
endmodule
module FP_sqrt_64(
  input         clock,
  input         reset,
  input         in_valid,
  input  [63:0] in_data,
  output [63:0] out_data,
  output        out_ready
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [63:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [63:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [63:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [63:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
  reg [63:0] _RAND_32;
  reg [63:0] _RAND_33;
  reg [63:0] _RAND_34;
  reg [63:0] _RAND_35;
  reg [63:0] _RAND_36;
  reg [63:0] _RAND_37;
  reg [63:0] _RAND_38;
  reg [63:0] _RAND_39;
  reg [63:0] _RAND_40;
  reg [63:0] _RAND_41;
  reg [63:0] _RAND_42;
  reg [63:0] _RAND_43;
  reg [63:0] _RAND_44;
  reg [63:0] _RAND_45;
  reg [63:0] _RAND_46;
  reg [63:0] _RAND_47;
  reg [63:0] _RAND_48;
  reg [63:0] _RAND_49;
  reg [63:0] _RAND_50;
  reg [63:0] _RAND_51;
  reg [63:0] _RAND_52;
  reg [63:0] _RAND_53;
  reg [63:0] _RAND_54;
  reg [63:0] _RAND_55;
  reg [63:0] _RAND_56;
  reg [63:0] _RAND_57;
  reg [63:0] _RAND_58;
  reg [63:0] _RAND_59;
  reg [63:0] _RAND_60;
  reg [63:0] _RAND_61;
  reg [63:0] _RAND_62;
  reg [63:0] _RAND_63;
  reg [63:0] _RAND_64;
  reg [63:0] _RAND_65;
  reg [63:0] _RAND_66;
  reg [63:0] _RAND_67;
  reg [63:0] _RAND_68;
  reg [63:0] _RAND_69;
  reg [63:0] _RAND_70;
  reg [63:0] _RAND_71;
  reg [63:0] _RAND_72;
  reg [63:0] _RAND_73;
  reg [63:0] _RAND_74;
  reg [63:0] _RAND_75;
`endif // RANDOMIZE_REG_INIT
  wire  multipliers_0_0_clock; // @[WHTDesigns.scala 1982:65]
  wire  multipliers_0_0_reset; // @[WHTDesigns.scala 1982:65]
  wire  multipliers_0_0_in_valid; // @[WHTDesigns.scala 1982:65]
  wire [63:0] multipliers_0_0_in_data_0; // @[WHTDesigns.scala 1982:65]
  wire [63:0] multipliers_0_0_in_data_1; // @[WHTDesigns.scala 1982:65]
  wire [63:0] multipliers_0_0_out_data; // @[WHTDesigns.scala 1982:65]
  wire  multipliers_0_0_out_ready; // @[WHTDesigns.scala 1982:65]
  wire  multipliers_0_1_clock; // @[WHTDesigns.scala 1982:65]
  wire  multipliers_0_1_reset; // @[WHTDesigns.scala 1982:65]
  wire  multipliers_0_1_in_valid; // @[WHTDesigns.scala 1982:65]
  wire [63:0] multipliers_0_1_in_data_0; // @[WHTDesigns.scala 1982:65]
  wire [63:0] multipliers_0_1_in_data_1; // @[WHTDesigns.scala 1982:65]
  wire [63:0] multipliers_0_1_out_data; // @[WHTDesigns.scala 1982:65]
  wire  multipliers_0_1_out_ready; // @[WHTDesigns.scala 1982:65]
  wire  multipliers_0_2_clock; // @[WHTDesigns.scala 1982:65]
  wire  multipliers_0_2_reset; // @[WHTDesigns.scala 1982:65]
  wire  multipliers_0_2_in_valid; // @[WHTDesigns.scala 1982:65]
  wire [63:0] multipliers_0_2_in_data_0; // @[WHTDesigns.scala 1982:65]
  wire [63:0] multipliers_0_2_in_data_1; // @[WHTDesigns.scala 1982:65]
  wire [63:0] multipliers_0_2_out_data; // @[WHTDesigns.scala 1982:65]
  wire  multipliers_0_2_out_ready; // @[WHTDesigns.scala 1982:65]
  wire  subtractors_0_clock; // @[WHTDesigns.scala 1983:50]
  wire  subtractors_0_reset; // @[WHTDesigns.scala 1983:50]
  wire  subtractors_0_in_valid; // @[WHTDesigns.scala 1983:50]
  wire [63:0] subtractors_0_in_data_1; // @[WHTDesigns.scala 1983:50]
  wire [63:0] subtractors_0_out_data; // @[WHTDesigns.scala 1983:50]
  wire  subtractors_0_out_ready; // @[WHTDesigns.scala 1983:50]
  wire  multiplier4_clock; // @[WHTDesigns.scala 2056:29]
  wire  multiplier4_reset; // @[WHTDesigns.scala 2056:29]
  wire  multiplier4_in_valid; // @[WHTDesigns.scala 2056:29]
  wire [63:0] multiplier4_in_data_0; // @[WHTDesigns.scala 2056:29]
  wire [63:0] multiplier4_in_data_1; // @[WHTDesigns.scala 2056:29]
  wire [63:0] multiplier4_out_data; // @[WHTDesigns.scala 2056:29]
  wire  multiplier4_out_ready; // @[WHTDesigns.scala 2056:29]
  wire [62:0] _number_T_1 = {{1'd0}, in_data[62:1]}; // @[WHTDesigns.scala 1966:36]
  wire [62:0] _GEN_0 = in_data[62:0] > 63'h7fde8f165f9c4a36 ? 63'h3fef478b2fce251b : _number_T_1; // @[WHTDesigns.scala 1963:46 1964:14 1966:14]
  wire [63:0] number = {{1'd0}, _GEN_0}; // @[WHTDesigns.scala 1960:22]
  wire [63:0] result = 64'h5fe6eb50c7b537a9 - number; // @[WHTDesigns.scala 1973:25]
  reg [63:0] x_n_0; // @[WHTDesigns.scala 1975:22]
  reg [63:0] x_n_1; // @[WHTDesigns.scala 1975:22]
  reg [63:0] x_n_2; // @[WHTDesigns.scala 1975:22]
  reg [63:0] a_2_0; // @[WHTDesigns.scala 1976:22]
  reg [63:0] a_2_1; // @[WHTDesigns.scala 1976:22]
  reg [63:0] a_2_2; // @[WHTDesigns.scala 1976:22]
  reg [63:0] a_2_3; // @[WHTDesigns.scala 1976:22]
  reg [63:0] stage1_regs_0_0_0; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_0_1; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_0_2; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_0_3; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_0_4; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_0_5; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_0_6; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_0_7; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_0_8; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_1_0; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_1_1; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_1_2; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_1_3; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_1_4; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_1_5; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_1_6; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_1_7; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage1_regs_0_1_8; // @[WHTDesigns.scala 1977:30]
  reg [63:0] stage2_regs_0_0_0; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_0_1; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_0_2; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_0_3; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_0_4; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_0_5; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_0_6; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_0_7; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_0_8; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_1_0; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_1_1; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_1_2; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_1_3; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_1_4; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_1_5; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_1_6; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_1_7; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage2_regs_0_1_8; // @[WHTDesigns.scala 1978:30]
  reg [63:0] stage3_regs_0_0_0; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_0_1; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_0_2; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_0_3; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_0_4; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_0_5; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_0_6; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_0_7; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_0_8; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_0_9; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_0_10; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_0_11; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_1_0; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_1_1; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_1_2; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_1_3; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_1_4; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_1_5; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_1_6; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_1_7; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_1_8; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_1_9; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_1_10; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage3_regs_0_1_11; // @[WHTDesigns.scala 1979:30]
  reg [63:0] stage4_regs_0_1_0; // @[WHTDesigns.scala 1980:30]
  reg [63:0] stage4_regs_0_1_1; // @[WHTDesigns.scala 1980:30]
  reg [63:0] stage4_regs_0_1_2; // @[WHTDesigns.scala 1980:30]
  reg [63:0] stage4_regs_0_1_3; // @[WHTDesigns.scala 1980:30]
  reg [63:0] stage4_regs_0_1_4; // @[WHTDesigns.scala 1980:30]
  reg [63:0] stage4_regs_0_1_5; // @[WHTDesigns.scala 1980:30]
  reg [63:0] stage4_regs_0_1_6; // @[WHTDesigns.scala 1980:30]
  reg [63:0] stage4_regs_0_1_7; // @[WHTDesigns.scala 1980:30]
  reg [63:0] stage4_regs_0_1_8; // @[WHTDesigns.scala 1980:30]
  wire [10:0] _a_2_0_T_3 = in_data[62:52] - 11'h1; // @[WHTDesigns.scala 2005:75]
  wire [63:0] _a_2_0_T_6 = {in_data[63],_a_2_0_T_3,in_data[51:0]}; // @[WHTDesigns.scala 2005:82]
  wire [10:0] _restore_a_T_3 = stage4_regs_0_1_8[62:52] + 11'h1; // @[WHTDesigns.scala 2055:106]
  wire [11:0] _restore_a_T_4 = {stage4_regs_0_1_8[63],_restore_a_T_3}; // @[WHTDesigns.scala 2055:55]
  FP_multiplier_64_10cc_sqrt multipliers_0_0 ( // @[WHTDesigns.scala 1982:65]
    .clock(multipliers_0_0_clock),
    .reset(multipliers_0_0_reset),
    .in_valid(multipliers_0_0_in_valid),
    .in_data_0(multipliers_0_0_in_data_0),
    .in_data_1(multipliers_0_0_in_data_1),
    .out_data(multipliers_0_0_out_data),
    .out_ready(multipliers_0_0_out_ready)
  );
  FP_multiplier_64_10cc_sqrt multipliers_0_1 ( // @[WHTDesigns.scala 1982:65]
    .clock(multipliers_0_1_clock),
    .reset(multipliers_0_1_reset),
    .in_valid(multipliers_0_1_in_valid),
    .in_data_0(multipliers_0_1_in_data_0),
    .in_data_1(multipliers_0_1_in_data_1),
    .out_data(multipliers_0_1_out_data),
    .out_ready(multipliers_0_1_out_ready)
  );
  FP_multiplier_64_10cc_sqrt multipliers_0_2 ( // @[WHTDesigns.scala 1982:65]
    .clock(multipliers_0_2_clock),
    .reset(multipliers_0_2_reset),
    .in_valid(multipliers_0_2_in_valid),
    .in_data_0(multipliers_0_2_in_data_0),
    .in_data_1(multipliers_0_2_in_data_1),
    .out_data(multipliers_0_2_out_data),
    .out_ready(multipliers_0_2_out_ready)
  );
  FP_subtractor_64_13cc subtractors_0 ( // @[WHTDesigns.scala 1983:50]
    .clock(subtractors_0_clock),
    .reset(subtractors_0_reset),
    .in_valid(subtractors_0_in_valid),
    .in_data_1(subtractors_0_in_data_1),
    .out_data(subtractors_0_out_data),
    .out_ready(subtractors_0_out_ready)
  );
  FP_multiplier_64_10cc_sqrt multiplier4 ( // @[WHTDesigns.scala 2056:29]
    .clock(multiplier4_clock),
    .reset(multiplier4_reset),
    .in_valid(multiplier4_in_valid),
    .in_data_0(multiplier4_in_data_0),
    .in_data_1(multiplier4_in_data_1),
    .out_data(multiplier4_out_data),
    .out_ready(multiplier4_out_ready)
  );
  assign out_data = {{1'd0}, multiplier4_out_data[62:0]}; // @[WHTDesigns.scala 2061:14]
  assign out_ready = multiplier4_out_ready; // @[WHTDesigns.scala 2060:15]
  assign multipliers_0_0_clock = clock;
  assign multipliers_0_0_reset = reset;
  assign multipliers_0_0_in_valid = in_valid; // @[WHTDesigns.scala 2011:40]
  assign multipliers_0_0_in_data_0 = {1'h0,result[62:0]}; // @[WHTDesigns.scala 2009:53]
  assign multipliers_0_0_in_data_1 = {1'h0,result[62:0]}; // @[WHTDesigns.scala 2010:53]
  assign multipliers_0_1_clock = clock;
  assign multipliers_0_1_reset = reset;
  assign multipliers_0_1_in_valid = multipliers_0_0_out_ready; // @[WHTDesigns.scala 2026:38]
  assign multipliers_0_1_in_data_0 = multipliers_0_0_out_data; // @[WHTDesigns.scala 2024:39]
  assign multipliers_0_1_in_data_1 = {1'h0,stage1_regs_0_1_8[62:0]}; // @[WHTDesigns.scala 2025:51]
  assign multipliers_0_2_clock = clock;
  assign multipliers_0_2_reset = reset;
  assign multipliers_0_2_in_valid = subtractors_0_out_ready; // @[WHTDesigns.scala 2046:38]
  assign multipliers_0_2_in_data_0 = {1'h0,stage3_regs_0_0_11[62:0]}; // @[WHTDesigns.scala 2044:51]
  assign multipliers_0_2_in_data_1 = subtractors_0_out_data; // @[WHTDesigns.scala 2045:39]
  assign subtractors_0_clock = clock;
  assign subtractors_0_reset = reset;
  assign subtractors_0_in_valid = multipliers_0_1_out_ready; // @[WHTDesigns.scala 2036:35]
  assign subtractors_0_in_data_1 = multipliers_0_1_out_data; // @[WHTDesigns.scala 2035:36]
  assign multiplier4_clock = clock;
  assign multiplier4_reset = reset;
  assign multiplier4_in_valid = multipliers_0_2_out_ready; // @[WHTDesigns.scala 2057:26]
  assign multiplier4_in_data_0 = {1'h0,multipliers_0_2_out_data[62:0]}; // @[WHTDesigns.scala 2058:39]
  assign multiplier4_in_data_1 = {_restore_a_T_4,stage4_regs_0_1_8[51:0]}; // @[WHTDesigns.scala 2055:113]
  always @(posedge clock) begin
    if (reset) begin // @[WHTDesigns.scala 1975:22]
      x_n_0 <= 64'h0; // @[WHTDesigns.scala 1975:22]
    end else begin
      x_n_0 <= result; // @[WHTDesigns.scala 2004:26]
    end
    if (reset) begin // @[WHTDesigns.scala 1975:22]
      x_n_1 <= 64'h0; // @[WHTDesigns.scala 1975:22]
    end else begin
      x_n_1 <= stage1_regs_0_0_8; // @[WHTDesigns.scala 2029:28]
    end
    if (reset) begin // @[WHTDesigns.scala 1975:22]
      x_n_2 <= 64'h0; // @[WHTDesigns.scala 1975:22]
    end else begin
      x_n_2 <= stage2_regs_0_0_8; // @[WHTDesigns.scala 2039:28]
    end
    if (reset) begin // @[WHTDesigns.scala 1976:22]
      a_2_0 <= 64'h0; // @[WHTDesigns.scala 1976:22]
    end else begin
      a_2_0 <= _a_2_0_T_6; // @[WHTDesigns.scala 2005:26]
    end
    if (reset) begin // @[WHTDesigns.scala 1976:22]
      a_2_1 <= 64'h0; // @[WHTDesigns.scala 1976:22]
    end else begin
      a_2_1 <= stage1_regs_0_1_8; // @[WHTDesigns.scala 2028:28]
    end
    if (reset) begin // @[WHTDesigns.scala 1976:22]
      a_2_2 <= 64'h0; // @[WHTDesigns.scala 1976:22]
    end else begin
      a_2_2 <= stage2_regs_0_1_8; // @[WHTDesigns.scala 2038:28]
    end
    if (reset) begin // @[WHTDesigns.scala 1976:22]
      a_2_3 <= 64'h0; // @[WHTDesigns.scala 1976:22]
    end else begin
      a_2_3 <= stage3_regs_0_1_11; // @[WHTDesigns.scala 2048:28]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_0_0 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_0_0 <= x_n_0; // @[WHTDesigns.scala 2006:36]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_0_1 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_0_1 <= stage1_regs_0_0_0; // @[WHTDesigns.scala 1992:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_0_2 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_0_2 <= stage1_regs_0_0_1; // @[WHTDesigns.scala 1992:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_0_3 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_0_3 <= stage1_regs_0_0_2; // @[WHTDesigns.scala 1992:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_0_4 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_0_4 <= stage1_regs_0_0_3; // @[WHTDesigns.scala 1992:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_0_5 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_0_5 <= stage1_regs_0_0_4; // @[WHTDesigns.scala 1992:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_0_6 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_0_6 <= stage1_regs_0_0_5; // @[WHTDesigns.scala 1992:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_0_7 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_0_7 <= stage1_regs_0_0_6; // @[WHTDesigns.scala 1992:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_0_8 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_0_8 <= stage1_regs_0_0_7; // @[WHTDesigns.scala 1992:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_1_0 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_1_0 <= a_2_0; // @[WHTDesigns.scala 2007:36]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_1_1 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_1_1 <= stage1_regs_0_1_0; // @[WHTDesigns.scala 1993:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_1_2 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_1_2 <= stage1_regs_0_1_1; // @[WHTDesigns.scala 1993:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_1_3 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_1_3 <= stage1_regs_0_1_2; // @[WHTDesigns.scala 1993:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_1_4 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_1_4 <= stage1_regs_0_1_3; // @[WHTDesigns.scala 1993:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_1_5 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_1_5 <= stage1_regs_0_1_4; // @[WHTDesigns.scala 1993:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_1_6 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_1_6 <= stage1_regs_0_1_5; // @[WHTDesigns.scala 1993:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_1_7 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_1_7 <= stage1_regs_0_1_6; // @[WHTDesigns.scala 1993:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1977:30]
      stage1_regs_0_1_8 <= 64'h0; // @[WHTDesigns.scala 1977:30]
    end else begin
      stage1_regs_0_1_8 <= stage1_regs_0_1_7; // @[WHTDesigns.scala 1993:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_0_0 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_0_0 <= x_n_1; // @[WHTDesigns.scala 2030:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_0_1 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_0_1 <= stage2_regs_0_0_0; // @[WHTDesigns.scala 1994:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_0_2 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_0_2 <= stage2_regs_0_0_1; // @[WHTDesigns.scala 1994:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_0_3 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_0_3 <= stage2_regs_0_0_2; // @[WHTDesigns.scala 1994:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_0_4 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_0_4 <= stage2_regs_0_0_3; // @[WHTDesigns.scala 1994:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_0_5 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_0_5 <= stage2_regs_0_0_4; // @[WHTDesigns.scala 1994:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_0_6 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_0_6 <= stage2_regs_0_0_5; // @[WHTDesigns.scala 1994:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_0_7 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_0_7 <= stage2_regs_0_0_6; // @[WHTDesigns.scala 1994:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_0_8 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_0_8 <= stage2_regs_0_0_7; // @[WHTDesigns.scala 1994:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_1_0 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_1_0 <= a_2_1; // @[WHTDesigns.scala 2031:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_1_1 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_1_1 <= stage2_regs_0_1_0; // @[WHTDesigns.scala 1995:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_1_2 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_1_2 <= stage2_regs_0_1_1; // @[WHTDesigns.scala 1995:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_1_3 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_1_3 <= stage2_regs_0_1_2; // @[WHTDesigns.scala 1995:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_1_4 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_1_4 <= stage2_regs_0_1_3; // @[WHTDesigns.scala 1995:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_1_5 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_1_5 <= stage2_regs_0_1_4; // @[WHTDesigns.scala 1995:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_1_6 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_1_6 <= stage2_regs_0_1_5; // @[WHTDesigns.scala 1995:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_1_7 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_1_7 <= stage2_regs_0_1_6; // @[WHTDesigns.scala 1995:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1978:30]
      stage2_regs_0_1_8 <= 64'h0; // @[WHTDesigns.scala 1978:30]
    end else begin
      stage2_regs_0_1_8 <= stage2_regs_0_1_7; // @[WHTDesigns.scala 1995:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_0_0 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_0_0 <= x_n_2; // @[WHTDesigns.scala 2040:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_0_1 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_0_1 <= stage3_regs_0_0_0; // @[WHTDesigns.scala 1989:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_0_2 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_0_2 <= stage3_regs_0_0_1; // @[WHTDesigns.scala 1989:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_0_3 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_0_3 <= stage3_regs_0_0_2; // @[WHTDesigns.scala 1989:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_0_4 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_0_4 <= stage3_regs_0_0_3; // @[WHTDesigns.scala 1989:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_0_5 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_0_5 <= stage3_regs_0_0_4; // @[WHTDesigns.scala 1989:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_0_6 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_0_6 <= stage3_regs_0_0_5; // @[WHTDesigns.scala 1989:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_0_7 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_0_7 <= stage3_regs_0_0_6; // @[WHTDesigns.scala 1989:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_0_8 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_0_8 <= stage3_regs_0_0_7; // @[WHTDesigns.scala 1989:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_0_9 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_0_9 <= stage3_regs_0_0_8; // @[WHTDesigns.scala 1989:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_0_10 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_0_10 <= stage3_regs_0_0_9; // @[WHTDesigns.scala 1989:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_0_11 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_0_11 <= stage3_regs_0_0_10; // @[WHTDesigns.scala 1989:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_1_0 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_1_0 <= a_2_2; // @[WHTDesigns.scala 2041:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_1_1 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_1_1 <= stage3_regs_0_1_0; // @[WHTDesigns.scala 1990:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_1_2 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_1_2 <= stage3_regs_0_1_1; // @[WHTDesigns.scala 1990:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_1_3 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_1_3 <= stage3_regs_0_1_2; // @[WHTDesigns.scala 1990:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_1_4 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_1_4 <= stage3_regs_0_1_3; // @[WHTDesigns.scala 1990:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_1_5 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_1_5 <= stage3_regs_0_1_4; // @[WHTDesigns.scala 1990:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_1_6 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_1_6 <= stage3_regs_0_1_5; // @[WHTDesigns.scala 1990:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_1_7 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_1_7 <= stage3_regs_0_1_6; // @[WHTDesigns.scala 1990:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_1_8 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_1_8 <= stage3_regs_0_1_7; // @[WHTDesigns.scala 1990:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_1_9 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_1_9 <= stage3_regs_0_1_8; // @[WHTDesigns.scala 1990:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_1_10 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_1_10 <= stage3_regs_0_1_9; // @[WHTDesigns.scala 1990:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1979:30]
      stage3_regs_0_1_11 <= 64'h0; // @[WHTDesigns.scala 1979:30]
    end else begin
      stage3_regs_0_1_11 <= stage3_regs_0_1_10; // @[WHTDesigns.scala 1990:32]
    end
    if (reset) begin // @[WHTDesigns.scala 1980:30]
      stage4_regs_0_1_0 <= 64'h0; // @[WHTDesigns.scala 1980:30]
    end else begin
      stage4_regs_0_1_0 <= a_2_3; // @[WHTDesigns.scala 2049:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1980:30]
      stage4_regs_0_1_1 <= 64'h0; // @[WHTDesigns.scala 1980:30]
    end else begin
      stage4_regs_0_1_1 <= stage4_regs_0_1_0; // @[WHTDesigns.scala 1996:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1980:30]
      stage4_regs_0_1_2 <= 64'h0; // @[WHTDesigns.scala 1980:30]
    end else begin
      stage4_regs_0_1_2 <= stage4_regs_0_1_1; // @[WHTDesigns.scala 1996:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1980:30]
      stage4_regs_0_1_3 <= 64'h0; // @[WHTDesigns.scala 1980:30]
    end else begin
      stage4_regs_0_1_3 <= stage4_regs_0_1_2; // @[WHTDesigns.scala 1996:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1980:30]
      stage4_regs_0_1_4 <= 64'h0; // @[WHTDesigns.scala 1980:30]
    end else begin
      stage4_regs_0_1_4 <= stage4_regs_0_1_3; // @[WHTDesigns.scala 1996:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1980:30]
      stage4_regs_0_1_5 <= 64'h0; // @[WHTDesigns.scala 1980:30]
    end else begin
      stage4_regs_0_1_5 <= stage4_regs_0_1_4; // @[WHTDesigns.scala 1996:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1980:30]
      stage4_regs_0_1_6 <= 64'h0; // @[WHTDesigns.scala 1980:30]
    end else begin
      stage4_regs_0_1_6 <= stage4_regs_0_1_5; // @[WHTDesigns.scala 1996:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1980:30]
      stage4_regs_0_1_7 <= 64'h0; // @[WHTDesigns.scala 1980:30]
    end else begin
      stage4_regs_0_1_7 <= stage4_regs_0_1_6; // @[WHTDesigns.scala 1996:34]
    end
    if (reset) begin // @[WHTDesigns.scala 1980:30]
      stage4_regs_0_1_8 <= 64'h0; // @[WHTDesigns.scala 1980:30]
    end else begin
      stage4_regs_0_1_8 <= stage4_regs_0_1_7; // @[WHTDesigns.scala 1996:34]
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
  x_n_0 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  x_n_1 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  x_n_2 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  a_2_0 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  a_2_1 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  a_2_2 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  a_2_3 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  stage1_regs_0_0_0 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  stage1_regs_0_0_1 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  stage1_regs_0_0_2 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  stage1_regs_0_0_3 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  stage1_regs_0_0_4 = _RAND_11[63:0];
  _RAND_12 = {2{`RANDOM}};
  stage1_regs_0_0_5 = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  stage1_regs_0_0_6 = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  stage1_regs_0_0_7 = _RAND_14[63:0];
  _RAND_15 = {2{`RANDOM}};
  stage1_regs_0_0_8 = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  stage1_regs_0_1_0 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  stage1_regs_0_1_1 = _RAND_17[63:0];
  _RAND_18 = {2{`RANDOM}};
  stage1_regs_0_1_2 = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  stage1_regs_0_1_3 = _RAND_19[63:0];
  _RAND_20 = {2{`RANDOM}};
  stage1_regs_0_1_4 = _RAND_20[63:0];
  _RAND_21 = {2{`RANDOM}};
  stage1_regs_0_1_5 = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  stage1_regs_0_1_6 = _RAND_22[63:0];
  _RAND_23 = {2{`RANDOM}};
  stage1_regs_0_1_7 = _RAND_23[63:0];
  _RAND_24 = {2{`RANDOM}};
  stage1_regs_0_1_8 = _RAND_24[63:0];
  _RAND_25 = {2{`RANDOM}};
  stage2_regs_0_0_0 = _RAND_25[63:0];
  _RAND_26 = {2{`RANDOM}};
  stage2_regs_0_0_1 = _RAND_26[63:0];
  _RAND_27 = {2{`RANDOM}};
  stage2_regs_0_0_2 = _RAND_27[63:0];
  _RAND_28 = {2{`RANDOM}};
  stage2_regs_0_0_3 = _RAND_28[63:0];
  _RAND_29 = {2{`RANDOM}};
  stage2_regs_0_0_4 = _RAND_29[63:0];
  _RAND_30 = {2{`RANDOM}};
  stage2_regs_0_0_5 = _RAND_30[63:0];
  _RAND_31 = {2{`RANDOM}};
  stage2_regs_0_0_6 = _RAND_31[63:0];
  _RAND_32 = {2{`RANDOM}};
  stage2_regs_0_0_7 = _RAND_32[63:0];
  _RAND_33 = {2{`RANDOM}};
  stage2_regs_0_0_8 = _RAND_33[63:0];
  _RAND_34 = {2{`RANDOM}};
  stage2_regs_0_1_0 = _RAND_34[63:0];
  _RAND_35 = {2{`RANDOM}};
  stage2_regs_0_1_1 = _RAND_35[63:0];
  _RAND_36 = {2{`RANDOM}};
  stage2_regs_0_1_2 = _RAND_36[63:0];
  _RAND_37 = {2{`RANDOM}};
  stage2_regs_0_1_3 = _RAND_37[63:0];
  _RAND_38 = {2{`RANDOM}};
  stage2_regs_0_1_4 = _RAND_38[63:0];
  _RAND_39 = {2{`RANDOM}};
  stage2_regs_0_1_5 = _RAND_39[63:0];
  _RAND_40 = {2{`RANDOM}};
  stage2_regs_0_1_6 = _RAND_40[63:0];
  _RAND_41 = {2{`RANDOM}};
  stage2_regs_0_1_7 = _RAND_41[63:0];
  _RAND_42 = {2{`RANDOM}};
  stage2_regs_0_1_8 = _RAND_42[63:0];
  _RAND_43 = {2{`RANDOM}};
  stage3_regs_0_0_0 = _RAND_43[63:0];
  _RAND_44 = {2{`RANDOM}};
  stage3_regs_0_0_1 = _RAND_44[63:0];
  _RAND_45 = {2{`RANDOM}};
  stage3_regs_0_0_2 = _RAND_45[63:0];
  _RAND_46 = {2{`RANDOM}};
  stage3_regs_0_0_3 = _RAND_46[63:0];
  _RAND_47 = {2{`RANDOM}};
  stage3_regs_0_0_4 = _RAND_47[63:0];
  _RAND_48 = {2{`RANDOM}};
  stage3_regs_0_0_5 = _RAND_48[63:0];
  _RAND_49 = {2{`RANDOM}};
  stage3_regs_0_0_6 = _RAND_49[63:0];
  _RAND_50 = {2{`RANDOM}};
  stage3_regs_0_0_7 = _RAND_50[63:0];
  _RAND_51 = {2{`RANDOM}};
  stage3_regs_0_0_8 = _RAND_51[63:0];
  _RAND_52 = {2{`RANDOM}};
  stage3_regs_0_0_9 = _RAND_52[63:0];
  _RAND_53 = {2{`RANDOM}};
  stage3_regs_0_0_10 = _RAND_53[63:0];
  _RAND_54 = {2{`RANDOM}};
  stage3_regs_0_0_11 = _RAND_54[63:0];
  _RAND_55 = {2{`RANDOM}};
  stage3_regs_0_1_0 = _RAND_55[63:0];
  _RAND_56 = {2{`RANDOM}};
  stage3_regs_0_1_1 = _RAND_56[63:0];
  _RAND_57 = {2{`RANDOM}};
  stage3_regs_0_1_2 = _RAND_57[63:0];
  _RAND_58 = {2{`RANDOM}};
  stage3_regs_0_1_3 = _RAND_58[63:0];
  _RAND_59 = {2{`RANDOM}};
  stage3_regs_0_1_4 = _RAND_59[63:0];
  _RAND_60 = {2{`RANDOM}};
  stage3_regs_0_1_5 = _RAND_60[63:0];
  _RAND_61 = {2{`RANDOM}};
  stage3_regs_0_1_6 = _RAND_61[63:0];
  _RAND_62 = {2{`RANDOM}};
  stage3_regs_0_1_7 = _RAND_62[63:0];
  _RAND_63 = {2{`RANDOM}};
  stage3_regs_0_1_8 = _RAND_63[63:0];
  _RAND_64 = {2{`RANDOM}};
  stage3_regs_0_1_9 = _RAND_64[63:0];
  _RAND_65 = {2{`RANDOM}};
  stage3_regs_0_1_10 = _RAND_65[63:0];
  _RAND_66 = {2{`RANDOM}};
  stage3_regs_0_1_11 = _RAND_66[63:0];
  _RAND_67 = {2{`RANDOM}};
  stage4_regs_0_1_0 = _RAND_67[63:0];
  _RAND_68 = {2{`RANDOM}};
  stage4_regs_0_1_1 = _RAND_68[63:0];
  _RAND_69 = {2{`RANDOM}};
  stage4_regs_0_1_2 = _RAND_69[63:0];
  _RAND_70 = {2{`RANDOM}};
  stage4_regs_0_1_3 = _RAND_70[63:0];
  _RAND_71 = {2{`RANDOM}};
  stage4_regs_0_1_4 = _RAND_71[63:0];
  _RAND_72 = {2{`RANDOM}};
  stage4_regs_0_1_5 = _RAND_72[63:0];
  _RAND_73 = {2{`RANDOM}};
  stage4_regs_0_1_6 = _RAND_73[63:0];
  _RAND_74 = {2{`RANDOM}};
  stage4_regs_0_1_7 = _RAND_74[63:0];
  _RAND_75 = {2{`RANDOM}};
  stage4_regs_0_1_8 = _RAND_75[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

