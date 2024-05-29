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
// Description : Floating Point Adder 64 bits
// File        : FP_adder_64_13cc.v
// Notes       :
//    - Chisel generated 
////////////////////////////////////////////////

module full_subtractor_bw11(
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
module full_adder_bw53(
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
module FP_adder_64_13cc(
  input         clock,
  input         reset,
  input         in_valid,
  input  [63:0] in_data_0,
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
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
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
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [63:0] _RAND_57;
  reg [63:0] _RAND_58;
  reg [63:0] _RAND_59;
  reg [63:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [63:0] _RAND_69;
  reg [63:0] _RAND_70;
  reg [63:0] _RAND_71;
  reg [63:0] _RAND_72;
  reg [63:0] _RAND_73;
  reg [63:0] _RAND_74;
  reg [63:0] _RAND_75;
  reg [63:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [63:0] _RAND_93;
  reg [63:0] _RAND_94;
  reg [63:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [63:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [63:0] _RAND_115;
  reg [63:0] _RAND_116;
  reg [63:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
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
  reg [63:0] _RAND_131;
  reg [63:0] _RAND_132;
  reg [63:0] _RAND_133;
  reg [63:0] _RAND_134;
  reg [63:0] _RAND_135;
  reg [63:0] _RAND_136;
  reg [63:0] _RAND_137;
  reg [63:0] _RAND_138;
  reg [63:0] _RAND_139;
  reg [63:0] _RAND_140;
  reg [63:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
  reg [31:0] _RAND_144;
  reg [63:0] _RAND_145;
  reg [63:0] _RAND_146;
  reg [63:0] _RAND_147;
  reg [63:0] _RAND_148;
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
  wire  sign_0 = in_data_0[63]; // @[WHTDesigns.scala 478:25]
  wire  sign_1 = in_data_1[63]; // @[WHTDesigns.scala 479:25]
  wire [11:0] _T_2 = 12'h800 - 12'h2; // @[WHTDesigns.scala 482:66]
  wire [11:0] _GEN_44 = {{1'd0}, in_data_0[62:52]}; // @[WHTDesigns.scala 482:38]
  wire [10:0] _GEN_0 = in_data_0[62:52] < 11'h1 ? 11'h1 : in_data_0[62:52]; // @[WHTDesigns.scala 484:48 485:14 487:14]
  wire [11:0] _GEN_1 = _GEN_44 > _T_2 ? _T_2 : {{1'd0}, _GEN_0}; // @[WHTDesigns.scala 482:73 483:14]
  wire [11:0] _GEN_45 = {{1'd0}, in_data_1[62:52]}; // @[WHTDesigns.scala 489:38]
  wire [10:0] _GEN_2 = in_data_1[62:52] < 11'h1 ? 11'h1 : in_data_1[62:52]; // @[WHTDesigns.scala 491:47 492:14 494:14]
  wire [11:0] _GEN_3 = _GEN_45 > _T_2 ? _T_2 : {{1'd0}, _GEN_2}; // @[WHTDesigns.scala 489:73 490:14]
  wire [51:0] frac_0 = in_data_0[51:0]; // @[WHTDesigns.scala 499:25]
  wire [51:0] frac_1 = in_data_1[51:0]; // @[WHTDesigns.scala 500:25]
  wire [52:0] wfrac_0 = {1'h1,frac_0}; // @[WHTDesigns.scala 504:21]
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
  reg  sign_reg_0_0; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_0_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_1_0; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_1_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_2_0; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_2_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_3_0; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_3_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_4_0; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_4_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_5_0; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_5_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_6_0; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_6_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_7_0; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_7_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_8_0; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_8_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_9_0; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_9_1; // @[WHTDesigns.scala 510:28]
  reg  sign_reg_10_0; // @[WHTDesigns.scala 510:28]
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
  reg [52:0] cmpl_temp_wfrac_add_in_reg_0_0; // @[WHTDesigns.scala 584:45]
  reg [52:0] cmpl_temp_wfrac_add_in_reg_0_1; // @[WHTDesigns.scala 584:45]
  wire [52:0] _cmpl_temp_wfrac_add_in_reg_0_0_T = ~temp_wfrac_add_in_reg_0_0; // @[WHTDesigns.scala 586:49]
  wire [52:0] _cmpl_temp_wfrac_add_in_reg_0_0_T_2 = 53'h1 + _cmpl_temp_wfrac_add_in_reg_0_0_T; // @[WHTDesigns.scala 586:47]
  wire [52:0] _cmpl_temp_wfrac_add_in_reg_0_1_T = ~temp_wfrac_add_in_reg_0_1; // @[WHTDesigns.scala 587:49]
  wire [52:0] _cmpl_temp_wfrac_add_in_reg_0_1_T_2 = 53'h1 + _cmpl_temp_wfrac_add_in_reg_0_1_T; // @[WHTDesigns.scala 587:47]
  wire [1:0] _wfrac_adder_io_in_a_T = {sign_reg_4_1,sign_reg_4_0}; // @[WHTDesigns.scala 590:44]
  wire  _new_sign_T = ~wfrac_adder_io_out_c_reg_0; // @[WHTDesigns.scala 597:18]
  wire  new_sign = ~wfrac_adder_io_out_c_reg_0 & (sign_reg_5_0 | sign_reg_5_1) | sign_reg_5_0 & sign_reg_5_1; // @[WHTDesigns.scala 597:84]
  wire  _ShiftDir_T_1 = sign_reg_5_0 ^ sign_reg_5_1; // @[WHTDesigns.scala 604:66]
  wire  ShiftDir = _new_sign_T | sign_reg_5_0 ^ sign_reg_5_1; // @[WHTDesigns.scala 604:48]
  wire  NoChange = _new_sign_T & ~wfrac_adder_io_out_s_reg_0[52] | _new_sign_T & ~_ShiftDir_T_1 |
    wfrac_adder_io_out_c_reg_0 & wfrac_adder_io_out_s_reg_0[52] & _ShiftDir_T_1; // @[WHTDesigns.scala 606:159]
  reg [52:0] cmpl_wfrac_adder_io_out_s_reg_0; // @[WHTDesigns.scala 609:48]
  wire [52:0] _cmpl_wfrac_adder_io_out_s_reg_0_T = ~wfrac_adder_io_out_s_reg_1; // @[WHTDesigns.scala 612:49]
  wire [52:0] _cmpl_wfrac_adder_io_out_s_reg_0_T_2 = 53'h1 + _cmpl_wfrac_adder_io_out_s_reg_0_T; // @[WHTDesigns.scala 612:47]
  wire [1:0] _wfrac_adder_result_T = {sign_reg_7_1,sign_reg_7_0}; // @[WHTDesigns.scala 616:62]
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
  wire [11:0] _GEN_46 = {{1'd0}, ref_exp_reg_7}; // @[WHTDesigns.scala 710:29]
  wire [52:0] _new_frac_reg_0_T_2 = 53'h10000000000000 - 53'h1; // @[WHTDesigns.scala 712:56]
  wire [10:0] _new_exp_reg_0_T_3 = ref_exp_reg_7 + 11'h1; // @[WHTDesigns.scala 714:44]
  wire [11:0] _GEN_23 = _GEN_46 == _T_2 ? _T_2 : {{1'd0}, _new_exp_reg_0_T_3}; // @[WHTDesigns.scala 710:66 711:26 714:26]
  wire [52:0] _GEN_24 = _GEN_46 == _T_2 ? _new_frac_reg_0_T_2 : {{1'd0}, wfrac_adder_result_reg_2[52:1]}; // @[WHTDesigns.scala 710:66 712:27 715:27]
  wire [6:0] _new_frac_reg_0_T_6 = 7'h35 - leadingOneDet_reg_1; // @[WHTDesigns.scala 728:96]
  wire [178:0] _GEN_4 = {{127'd0}, wfrac_adder_result_reg_2[51:0]}; // @[WHTDesigns.scala 728:75]
  wire [178:0] _new_frac_reg_0_T_7 = _GEN_4 << _new_frac_reg_0_T_6; // @[WHTDesigns.scala 728:75]
  wire [10:0] _GEN_25 = exp_subber2_out_c_reg_0 ? 11'h1 : exp_subber2_out_s_reg_0; // @[WHTDesigns.scala 723:50 724:28 727:28]
  wire [178:0] _GEN_26 = exp_subber2_out_c_reg_0 ? 179'h0 : _new_frac_reg_0_T_7; // @[WHTDesigns.scala 723:50 725:29 728:29]
  wire [10:0] _GEN_27 = leadingOneDet_reg_1 == 7'h1 & wfrac_adder_result_reg_2 == 53'h0 & ((sign_reg_10_0 ^
    sign_reg_10_1) & in_data_0_reg_10[62:0] == in_data_1_reg_10[62:0]) ? 11'h0 : _GEN_25; // @[WHTDesigns.scala 719:197 720:26]
  wire [178:0] _GEN_28 = leadingOneDet_reg_1 == 7'h1 & wfrac_adder_result_reg_2 == 53'h0 & ((sign_reg_10_0 ^
    sign_reg_10_1) & in_data_0_reg_10[62:0] == in_data_1_reg_10[62:0]) ? 179'h0 : _GEN_26; // @[WHTDesigns.scala 719:197 721:27]
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
  wire [178:0] _GEN_47 = reset ? 179'h0 : _GEN_43; // @[WHTDesigns.scala 529:{31,31}]
  wire [11:0] _GEN_48 = reset ? 12'h0 : _GEN_42; // @[WHTDesigns.scala 530:{31,31}]
  full_subtractor_bw11 exp_subber ( // @[WHTDesigns.scala 552:28]
    .io_in_a(exp_subber_io_in_a),
    .io_in_b(exp_subber_io_in_b),
    .io_out_s(exp_subber_io_out_s),
    .io_out_c(exp_subber_io_out_c)
  );
  full_adder_bw53 wfrac_adder ( // @[WHTDesigns.scala 558:29]
    .io_in_a(wfrac_adder_io_in_a),
    .io_in_b(wfrac_adder_io_in_b),
    .io_out_s(wfrac_adder_io_out_s),
    .io_out_c(wfrac_adder_io_out_c)
  );
  full_subtractor_bw11 exp_subber2 ( // @[WHTDesigns.scala 620:29]
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
      sign_reg_0_0 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_0_0 <= sign_0; // @[WHTDesigns.scala 630:19]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_0_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_0_1 <= sign_1; // @[WHTDesigns.scala 630:19]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_1_0 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_1_0 <= sign_reg_0_0; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_1_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_1_1 <= sign_reg_0_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_2_0 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_2_0 <= sign_reg_1_0; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_2_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_2_1 <= sign_reg_1_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_3_0 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_3_0 <= sign_reg_2_0; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_3_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_3_1 <= sign_reg_2_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_4_0 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_4_0 <= sign_reg_3_0; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_4_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_4_1 <= sign_reg_3_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_5_0 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_5_0 <= sign_reg_4_0; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_5_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_5_1 <= sign_reg_4_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_6_0 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_6_0 <= sign_reg_5_0; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_6_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_6_1 <= sign_reg_5_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_7_0 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_7_0 <= sign_reg_6_0; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_7_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_7_1 <= sign_reg_6_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_8_0 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_8_0 <= sign_reg_7_0; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_8_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_8_1 <= sign_reg_7_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_9_0 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_9_0 <= sign_reg_8_0; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_9_1 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_9_1 <= sign_reg_8_1; // @[WHTDesigns.scala 663:23]
    end
    if (reset) begin // @[WHTDesigns.scala 510:28]
      sign_reg_10_0 <= 1'h0; // @[WHTDesigns.scala 510:28]
    end else begin
      sign_reg_10_0 <= sign_reg_9_0; // @[WHTDesigns.scala 663:23]
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
      frac_reg_0_0 <= frac_0; // @[WHTDesigns.scala 632:19]
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
      wfrac_reg_0_0 <= wfrac_0; // @[WHTDesigns.scala 633:20]
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
    end else if (exp_subber_out_c_reg_1) begin // @[WHTDesigns.scala 568:43]
      ref_sign_reg_0 <= sign_reg_2_1; // @[WHTDesigns.scala 571:16]
    end else begin
      ref_sign_reg_0 <= sign_reg_2_0; // @[WHTDesigns.scala 578:16]
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
    new_frac_reg_0 <= _GEN_47[51:0]; // @[WHTDesigns.scala 529:{31,31}]
    new_exp_reg_0 <= _GEN_48[10:0]; // @[WHTDesigns.scala 530:{31,31}]
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
      in_data_0_reg_0 <= in_data_0; // @[WHTDesigns.scala 627:24]
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
  sign_reg_0_0 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sign_reg_0_1 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  sign_reg_1_0 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  sign_reg_1_1 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sign_reg_2_0 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  sign_reg_2_1 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  sign_reg_3_0 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  sign_reg_3_1 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  sign_reg_4_0 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  sign_reg_4_1 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  sign_reg_5_0 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  sign_reg_5_1 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  sign_reg_6_0 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  sign_reg_6_1 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  sign_reg_7_0 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  sign_reg_7_1 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  sign_reg_8_0 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  sign_reg_8_1 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  sign_reg_9_0 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  sign_reg_9_1 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  sign_reg_10_0 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  sign_reg_10_1 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  exp_reg_0_0 = _RAND_35[10:0];
  _RAND_36 = {1{`RANDOM}};
  exp_reg_0_1 = _RAND_36[10:0];
  _RAND_37 = {1{`RANDOM}};
  exp_reg_1_0 = _RAND_37[10:0];
  _RAND_38 = {1{`RANDOM}};
  exp_reg_1_1 = _RAND_38[10:0];
  _RAND_39 = {1{`RANDOM}};
  exp_reg_2_0 = _RAND_39[10:0];
  _RAND_40 = {1{`RANDOM}};
  exp_reg_2_1 = _RAND_40[10:0];
  _RAND_41 = {2{`RANDOM}};
  frac_reg_0_0 = _RAND_41[51:0];
  _RAND_42 = {2{`RANDOM}};
  frac_reg_0_1 = _RAND_42[51:0];
  _RAND_43 = {2{`RANDOM}};
  frac_reg_1_0 = _RAND_43[51:0];
  _RAND_44 = {2{`RANDOM}};
  frac_reg_1_1 = _RAND_44[51:0];
  _RAND_45 = {2{`RANDOM}};
  frac_reg_2_0 = _RAND_45[51:0];
  _RAND_46 = {2{`RANDOM}};
  frac_reg_2_1 = _RAND_46[51:0];
  _RAND_47 = {2{`RANDOM}};
  wfrac_reg_0_0 = _RAND_47[52:0];
  _RAND_48 = {2{`RANDOM}};
  wfrac_reg_0_1 = _RAND_48[52:0];
  _RAND_49 = {2{`RANDOM}};
  wfrac_reg_1_0 = _RAND_49[52:0];
  _RAND_50 = {2{`RANDOM}};
  wfrac_reg_1_1 = _RAND_50[52:0];
  _RAND_51 = {2{`RANDOM}};
  wfrac_reg_2_0 = _RAND_51[52:0];
  _RAND_52 = {2{`RANDOM}};
  wfrac_reg_2_1 = _RAND_52[52:0];
  _RAND_53 = {1{`RANDOM}};
  exp_subber_out_s_reg_0 = _RAND_53[10:0];
  _RAND_54 = {1{`RANDOM}};
  exp_subber_out_s_reg_1 = _RAND_54[10:0];
  _RAND_55 = {1{`RANDOM}};
  exp_subber_out_c_reg_0 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  exp_subber_out_c_reg_1 = _RAND_56[0:0];
  _RAND_57 = {2{`RANDOM}};
  temp_wfrac_add_in_reg_0_0 = _RAND_57[52:0];
  _RAND_58 = {2{`RANDOM}};
  temp_wfrac_add_in_reg_0_1 = _RAND_58[52:0];
  _RAND_59 = {2{`RANDOM}};
  temp_wfrac_add_in_reg_1_0 = _RAND_59[52:0];
  _RAND_60 = {2{`RANDOM}};
  temp_wfrac_add_in_reg_1_1 = _RAND_60[52:0];
  _RAND_61 = {1{`RANDOM}};
  ref_sign_reg_0 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  ref_sign_reg_1 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  ref_sign_reg_2 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  ref_sign_reg_3 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  ref_sign_reg_4 = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  ref_sign_reg_5 = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  ref_sign_reg_6 = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  ref_sign_reg_7 = _RAND_68[0:0];
  _RAND_69 = {2{`RANDOM}};
  ref_frac_reg_0 = _RAND_69[51:0];
  _RAND_70 = {2{`RANDOM}};
  ref_frac_reg_1 = _RAND_70[51:0];
  _RAND_71 = {2{`RANDOM}};
  ref_frac_reg_2 = _RAND_71[51:0];
  _RAND_72 = {2{`RANDOM}};
  ref_frac_reg_3 = _RAND_72[51:0];
  _RAND_73 = {2{`RANDOM}};
  ref_frac_reg_4 = _RAND_73[51:0];
  _RAND_74 = {2{`RANDOM}};
  ref_frac_reg_5 = _RAND_74[51:0];
  _RAND_75 = {2{`RANDOM}};
  ref_frac_reg_6 = _RAND_75[51:0];
  _RAND_76 = {2{`RANDOM}};
  ref_frac_reg_7 = _RAND_76[51:0];
  _RAND_77 = {1{`RANDOM}};
  ref_exp_reg_0 = _RAND_77[10:0];
  _RAND_78 = {1{`RANDOM}};
  ref_exp_reg_1 = _RAND_78[10:0];
  _RAND_79 = {1{`RANDOM}};
  ref_exp_reg_2 = _RAND_79[10:0];
  _RAND_80 = {1{`RANDOM}};
  ref_exp_reg_3 = _RAND_80[10:0];
  _RAND_81 = {1{`RANDOM}};
  ref_exp_reg_4 = _RAND_81[10:0];
  _RAND_82 = {1{`RANDOM}};
  ref_exp_reg_5 = _RAND_82[10:0];
  _RAND_83 = {1{`RANDOM}};
  ref_exp_reg_6 = _RAND_83[10:0];
  _RAND_84 = {1{`RANDOM}};
  ref_exp_reg_7 = _RAND_84[10:0];
  _RAND_85 = {1{`RANDOM}};
  sub_exp_reg_0 = _RAND_85[10:0];
  _RAND_86 = {1{`RANDOM}};
  sub_exp_reg_1 = _RAND_86[10:0];
  _RAND_87 = {1{`RANDOM}};
  sub_exp_reg_2 = _RAND_87[10:0];
  _RAND_88 = {1{`RANDOM}};
  sub_exp_reg_3 = _RAND_88[10:0];
  _RAND_89 = {1{`RANDOM}};
  sub_exp_reg_4 = _RAND_89[10:0];
  _RAND_90 = {1{`RANDOM}};
  sub_exp_reg_5 = _RAND_90[10:0];
  _RAND_91 = {1{`RANDOM}};
  sub_exp_reg_6 = _RAND_91[10:0];
  _RAND_92 = {1{`RANDOM}};
  sub_exp_reg_7 = _RAND_92[10:0];
  _RAND_93 = {2{`RANDOM}};
  wfrac_adder_io_out_s_reg_0 = _RAND_93[52:0];
  _RAND_94 = {2{`RANDOM}};
  wfrac_adder_io_out_s_reg_1 = _RAND_94[52:0];
  _RAND_95 = {2{`RANDOM}};
  wfrac_adder_io_out_s_reg_2 = _RAND_95[52:0];
  _RAND_96 = {1{`RANDOM}};
  wfrac_adder_io_out_c_reg_0 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  new_sign_reg_0 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  new_sign_reg_1 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  new_sign_reg_2 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  new_sign_reg_3 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  new_sign_reg_4 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  new_sign_reg_5 = _RAND_102[0:0];
  _RAND_103 = {2{`RANDOM}};
  new_frac_reg_0 = _RAND_103[51:0];
  _RAND_104 = {1{`RANDOM}};
  new_exp_reg_0 = _RAND_104[10:0];
  _RAND_105 = {1{`RANDOM}};
  NoChange_reg_0 = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  NoChange_reg_1 = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  NoChange_reg_2 = _RAND_107[0:0];
  _RAND_108 = {1{`RANDOM}};
  NoChange_reg_3 = _RAND_108[0:0];
  _RAND_109 = {1{`RANDOM}};
  NoChange_reg_4 = _RAND_109[0:0];
  _RAND_110 = {1{`RANDOM}};
  ShiftDir_reg_0 = _RAND_110[0:0];
  _RAND_111 = {1{`RANDOM}};
  ShiftDir_reg_1 = _RAND_111[0:0];
  _RAND_112 = {1{`RANDOM}};
  ShiftDir_reg_2 = _RAND_112[0:0];
  _RAND_113 = {1{`RANDOM}};
  ShiftDir_reg_3 = _RAND_113[0:0];
  _RAND_114 = {1{`RANDOM}};
  ShiftDir_reg_4 = _RAND_114[0:0];
  _RAND_115 = {2{`RANDOM}};
  wfrac_adder_result_reg_0 = _RAND_115[52:0];
  _RAND_116 = {2{`RANDOM}};
  wfrac_adder_result_reg_1 = _RAND_116[52:0];
  _RAND_117 = {2{`RANDOM}};
  wfrac_adder_result_reg_2 = _RAND_117[52:0];
  _RAND_118 = {1{`RANDOM}};
  leadingOneDet_reg_0 = _RAND_118[6:0];
  _RAND_119 = {1{`RANDOM}};
  leadingOneDet_reg_1 = _RAND_119[6:0];
  _RAND_120 = {2{`RANDOM}};
  in_data_0_reg_0 = _RAND_120[63:0];
  _RAND_121 = {2{`RANDOM}};
  in_data_0_reg_1 = _RAND_121[63:0];
  _RAND_122 = {2{`RANDOM}};
  in_data_0_reg_2 = _RAND_122[63:0];
  _RAND_123 = {2{`RANDOM}};
  in_data_0_reg_3 = _RAND_123[63:0];
  _RAND_124 = {2{`RANDOM}};
  in_data_0_reg_4 = _RAND_124[63:0];
  _RAND_125 = {2{`RANDOM}};
  in_data_0_reg_5 = _RAND_125[63:0];
  _RAND_126 = {2{`RANDOM}};
  in_data_0_reg_6 = _RAND_126[63:0];
  _RAND_127 = {2{`RANDOM}};
  in_data_0_reg_7 = _RAND_127[63:0];
  _RAND_128 = {2{`RANDOM}};
  in_data_0_reg_8 = _RAND_128[63:0];
  _RAND_129 = {2{`RANDOM}};
  in_data_0_reg_9 = _RAND_129[63:0];
  _RAND_130 = {2{`RANDOM}};
  in_data_0_reg_10 = _RAND_130[63:0];
  _RAND_131 = {2{`RANDOM}};
  in_data_1_reg_0 = _RAND_131[63:0];
  _RAND_132 = {2{`RANDOM}};
  in_data_1_reg_1 = _RAND_132[63:0];
  _RAND_133 = {2{`RANDOM}};
  in_data_1_reg_2 = _RAND_133[63:0];
  _RAND_134 = {2{`RANDOM}};
  in_data_1_reg_3 = _RAND_134[63:0];
  _RAND_135 = {2{`RANDOM}};
  in_data_1_reg_4 = _RAND_135[63:0];
  _RAND_136 = {2{`RANDOM}};
  in_data_1_reg_5 = _RAND_136[63:0];
  _RAND_137 = {2{`RANDOM}};
  in_data_1_reg_6 = _RAND_137[63:0];
  _RAND_138 = {2{`RANDOM}};
  in_data_1_reg_7 = _RAND_138[63:0];
  _RAND_139 = {2{`RANDOM}};
  in_data_1_reg_8 = _RAND_139[63:0];
  _RAND_140 = {2{`RANDOM}};
  in_data_1_reg_9 = _RAND_140[63:0];
  _RAND_141 = {2{`RANDOM}};
  in_data_1_reg_10 = _RAND_141[63:0];
  _RAND_142 = {1{`RANDOM}};
  exp_subber2_out_s_reg_0 = _RAND_142[10:0];
  _RAND_143 = {1{`RANDOM}};
  exp_subber2_out_c_reg_0 = _RAND_143[0:0];
  _RAND_144 = {1{`RANDOM}};
  cmpl_exp_subber_out_s_reg_0 = _RAND_144[10:0];
  _RAND_145 = {2{`RANDOM}};
  cmpl_temp_wfrac_add_in_reg_0_0 = _RAND_145[52:0];
  _RAND_146 = {2{`RANDOM}};
  cmpl_temp_wfrac_add_in_reg_0_1 = _RAND_146[52:0];
  _RAND_147 = {2{`RANDOM}};
  cmpl_wfrac_adder_io_out_s_reg_0 = _RAND_147[52:0];
  _RAND_148 = {2{`RANDOM}};
  reg_out_s = _RAND_148[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

