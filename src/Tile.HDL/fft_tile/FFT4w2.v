module full_subtractor_bw8(
  input  [7:0] io_in_a,
  input  [7:0] io_in_b,
  output [7:0] io_out_s,
  output       io_out_c
);
  wire [8:0] _result_T = io_in_a - io_in_b; // @[Arithmetic.scala 94:23]
  wire [9:0] _result_T_2 = _result_T - 9'h0; // @[Arithmetic.scala 94:34]
  wire [8:0] result = _result_T_2[8:0]; // @[Arithmetic.scala 93:22 94:12]
  assign io_out_s = result[7:0]; // @[Arithmetic.scala 95:23]
  assign io_out_c = result[8]; // @[Arithmetic.scala 96:23]
endmodule
module full_adder_bw24(
  input  [23:0] io_in_a,
  input  [23:0] io_in_b,
  output [23:0] io_out_s,
  output        io_out_c
);
  wire [24:0] _result_T = io_in_a + io_in_b; // @[Arithmetic.scala 79:23]
  wire [25:0] _result_T_1 = {{1'd0}, _result_T}; // @[Arithmetic.scala 79:34]
  wire [24:0] result = _result_T_1[24:0]; // @[Arithmetic.scala 78:22 79:12]
  assign io_out_s = result[23:0]; // @[Arithmetic.scala 80:23]
  assign io_out_c = result[24]; // @[Arithmetic.scala 81:23]
endmodule
module FP_adder_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
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
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
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
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
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
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_135;
`endif // RANDOMIZE_REG_INIT
  wire [7:0] subber_io_in_a; // @[FPArithmetic.scala 111:24]
  wire [7:0] subber_io_in_b; // @[FPArithmetic.scala 111:24]
  wire [7:0] subber_io_out_s; // @[FPArithmetic.scala 111:24]
  wire  subber_io_out_c; // @[FPArithmetic.scala 111:24]
  wire [23:0] adder_io_in_a; // @[FPArithmetic.scala 117:23]
  wire [23:0] adder_io_in_b; // @[FPArithmetic.scala 117:23]
  wire [23:0] adder_io_out_s; // @[FPArithmetic.scala 117:23]
  wire  adder_io_out_c; // @[FPArithmetic.scala 117:23]
  wire [7:0] subber2_io_in_a; // @[FPArithmetic.scala 178:25]
  wire [7:0] subber2_io_in_b; // @[FPArithmetic.scala 178:25]
  wire [7:0] subber2_io_out_s; // @[FPArithmetic.scala 178:25]
  wire  subber2_io_out_c; // @[FPArithmetic.scala 178:25]
  wire  sign_0 = io_in_a[31]; // @[FPArithmetic.scala 40:23]
  wire  sign_1 = io_in_b[31]; // @[FPArithmetic.scala 41:23]
  wire [8:0] _T_2 = 9'h100 - 9'h2; // @[FPArithmetic.scala 44:64]
  wire [8:0] _GEN_167 = {{1'd0}, io_in_a[30:23]}; // @[FPArithmetic.scala 44:36]
  wire [7:0] _GEN_0 = io_in_a[30:23] < 8'h1 ? 8'h1 : io_in_a[30:23]; // @[FPArithmetic.scala 46:46 47:14 49:14]
  wire [8:0] _GEN_1 = _GEN_167 > _T_2 ? _T_2 : {{1'd0}, _GEN_0}; // @[FPArithmetic.scala 44:71 45:14]
  wire [8:0] _GEN_168 = {{1'd0}, io_in_b[30:23]}; // @[FPArithmetic.scala 51:36]
  wire [7:0] _GEN_2 = io_in_b[30:23] < 8'h1 ? 8'h1 : io_in_b[30:23]; // @[FPArithmetic.scala 53:45 54:14 56:14]
  wire [8:0] _GEN_3 = _GEN_168 > _T_2 ? _T_2 : {{1'd0}, _GEN_2}; // @[FPArithmetic.scala 51:71 52:14]
  wire [22:0] frac_0 = io_in_a[22:0]; // @[FPArithmetic.scala 61:23]
  wire [22:0] frac_1 = io_in_b[22:0]; // @[FPArithmetic.scala 62:23]
  wire [23:0] whole_frac_0 = {1'h1,frac_0}; // @[FPArithmetic.scala 66:26]
  wire [23:0] whole_frac_1 = {1'h1,frac_1}; // @[FPArithmetic.scala 67:26]
  reg  sign_reg_0_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_0_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_1_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_1_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_2_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_2_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_3_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_3_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_4_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_4_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_5_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_5_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_6_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_6_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_7_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_7_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_8_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_8_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_9_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_9_1; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_10_0; // @[FPArithmetic.scala 69:28]
  reg  sign_reg_10_1; // @[FPArithmetic.scala 69:28]
  reg [7:0] exp_reg_0_0; // @[FPArithmetic.scala 70:28]
  reg [7:0] exp_reg_0_1; // @[FPArithmetic.scala 70:28]
  reg [7:0] exp_reg_1_0; // @[FPArithmetic.scala 70:28]
  reg [7:0] exp_reg_1_1; // @[FPArithmetic.scala 70:28]
  reg [7:0] exp_reg_2_0; // @[FPArithmetic.scala 70:28]
  reg [7:0] exp_reg_2_1; // @[FPArithmetic.scala 70:28]
  reg [22:0] frac_reg_0_0; // @[FPArithmetic.scala 71:28]
  reg [22:0] frac_reg_0_1; // @[FPArithmetic.scala 71:28]
  reg [22:0] frac_reg_1_0; // @[FPArithmetic.scala 71:28]
  reg [22:0] frac_reg_1_1; // @[FPArithmetic.scala 71:28]
  reg [22:0] frac_reg_2_0; // @[FPArithmetic.scala 71:28]
  reg [22:0] frac_reg_2_1; // @[FPArithmetic.scala 71:28]
  reg [23:0] wfrac_reg_0_0; // @[FPArithmetic.scala 72:28]
  reg [23:0] wfrac_reg_0_1; // @[FPArithmetic.scala 72:28]
  reg [23:0] wfrac_reg_1_0; // @[FPArithmetic.scala 72:28]
  reg [23:0] wfrac_reg_1_1; // @[FPArithmetic.scala 72:28]
  reg [23:0] wfrac_reg_2_0; // @[FPArithmetic.scala 72:28]
  reg [23:0] wfrac_reg_2_1; // @[FPArithmetic.scala 72:28]
  reg [7:0] subber_out_s_reg_0; // @[FPArithmetic.scala 74:35]
  reg [7:0] subber_out_s_reg_1; // @[FPArithmetic.scala 74:35]
  reg  subber_out_c_reg_0; // @[FPArithmetic.scala 75:35]
  reg  subber_out_c_reg_1; // @[FPArithmetic.scala 75:35]
  reg [23:0] wire_temp_add_in_reg_0_0; // @[FPArithmetic.scala 77:39]
  reg [23:0] wire_temp_add_in_reg_0_1; // @[FPArithmetic.scala 77:39]
  reg [23:0] wire_temp_add_in_reg_1_0; // @[FPArithmetic.scala 77:39]
  reg [23:0] wire_temp_add_in_reg_1_1; // @[FPArithmetic.scala 77:39]
  reg  ref_s_reg_0; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_1; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_2; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_3; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_4; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_5; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_6; // @[FPArithmetic.scala 79:31]
  reg  ref_s_reg_7; // @[FPArithmetic.scala 79:31]
  reg [22:0] ref_frac_reg_0; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_1; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_2; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_3; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_4; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_5; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_6; // @[FPArithmetic.scala 80:31]
  reg [22:0] ref_frac_reg_7; // @[FPArithmetic.scala 80:31]
  reg [7:0] ref_exp_reg_0; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_1; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_2; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_3; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_4; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_5; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_6; // @[FPArithmetic.scala 81:31]
  reg [7:0] ref_exp_reg_7; // @[FPArithmetic.scala 81:31]
  reg [7:0] sub_exp_reg_0; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_1; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_2; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_3; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_4; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_5; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_6; // @[FPArithmetic.scala 82:31]
  reg [7:0] sub_exp_reg_7; // @[FPArithmetic.scala 82:31]
  reg [23:0] adder_io_out_s_reg_0; // @[FPArithmetic.scala 84:37]
  reg [23:0] adder_io_out_s_reg_1; // @[FPArithmetic.scala 84:37]
  reg [23:0] adder_io_out_s_reg_2; // @[FPArithmetic.scala 84:37]
  reg  adder_io_out_c_reg_0; // @[FPArithmetic.scala 85:37]
  reg  new_s_reg_0; // @[FPArithmetic.scala 87:35]
  reg  new_s_reg_1; // @[FPArithmetic.scala 87:35]
  reg  new_s_reg_2; // @[FPArithmetic.scala 87:35]
  reg  new_s_reg_3; // @[FPArithmetic.scala 87:35]
  reg  new_s_reg_4; // @[FPArithmetic.scala 87:35]
  reg  new_s_reg_5; // @[FPArithmetic.scala 87:35]
  reg [22:0] new_out_frac_reg_0; // @[FPArithmetic.scala 88:35]
  reg [7:0] new_out_exp_reg_0; // @[FPArithmetic.scala 89:35]
  reg  E_reg_0; // @[FPArithmetic.scala 90:24]
  reg  E_reg_1; // @[FPArithmetic.scala 90:24]
  reg  E_reg_2; // @[FPArithmetic.scala 90:24]
  reg  E_reg_3; // @[FPArithmetic.scala 90:24]
  reg  E_reg_4; // @[FPArithmetic.scala 90:24]
  reg  D_reg_0; // @[FPArithmetic.scala 91:24]
  reg  D_reg_1; // @[FPArithmetic.scala 91:24]
  reg  D_reg_2; // @[FPArithmetic.scala 91:24]
  reg  D_reg_3; // @[FPArithmetic.scala 91:24]
  reg  D_reg_4; // @[FPArithmetic.scala 91:24]
  reg [23:0] adder_result_reg_0; // @[FPArithmetic.scala 93:35]
  reg [23:0] adder_result_reg_1; // @[FPArithmetic.scala 93:35]
  reg [23:0] adder_result_reg_2; // @[FPArithmetic.scala 93:35]
  reg [5:0] leadingOne_reg_0; // @[FPArithmetic.scala 95:33]
  reg [5:0] leadingOne_reg_1; // @[FPArithmetic.scala 95:33]
  reg [31:0] io_in_a_reg_0; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_1; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_2; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_3; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_4; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_5; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_6; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_7; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_8; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_9; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_a_reg_10; // @[FPArithmetic.scala 97:30]
  reg [31:0] io_in_b_reg_0; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_1; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_2; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_3; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_4; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_5; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_6; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_7; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_8; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_9; // @[FPArithmetic.scala 98:30]
  reg [31:0] io_in_b_reg_10; // @[FPArithmetic.scala 98:30]
  reg [7:0] subber2_out_s_reg_0; // @[FPArithmetic.scala 100:36]
  reg  subber2_out_c_reg_0; // @[FPArithmetic.scala 101:36]
  reg [7:0] cmpl_subber_out_s_reg_0; // @[FPArithmetic.scala 122:40]
  wire [7:0] _cmpl_subber_out_s_reg_0_T = ~subber_out_s_reg_0; // @[FPArithmetic.scala 124:41]
  wire [7:0] _cmpl_subber_out_s_reg_0_T_2 = 8'h1 + _cmpl_subber_out_s_reg_0_T; // @[FPArithmetic.scala 124:39]
  wire [23:0] _wire_temp_add_in_0_T = wfrac_reg_2_0 >> cmpl_subber_out_s_reg_0; // @[FPArithmetic.scala 132:46]
  wire [23:0] _wire_temp_add_in_1_T = wfrac_reg_2_1 >> subber_out_s_reg_1; // @[FPArithmetic.scala 140:46]
  reg [23:0] cmpl_wire_temp_add_in_reg_0_0; // @[FPArithmetic.scala 143:44]
  reg [23:0] cmpl_wire_temp_add_in_reg_0_1; // @[FPArithmetic.scala 143:44]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_0_T = ~wire_temp_add_in_reg_0_0; // @[FPArithmetic.scala 145:48]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_0_T_2 = 24'h1 + _cmpl_wire_temp_add_in_reg_0_0_T; // @[FPArithmetic.scala 145:46]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_1_T = ~wire_temp_add_in_reg_0_1; // @[FPArithmetic.scala 146:48]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_1_T_2 = 24'h1 + _cmpl_wire_temp_add_in_reg_0_1_T; // @[FPArithmetic.scala 146:46]
  wire [1:0] _adder_io_in_a_T = {sign_reg_4_1,sign_reg_4_0}; // @[FPArithmetic.scala 149:38]
  wire  _new_s_T = ~adder_io_out_c_reg_0; // @[FPArithmetic.scala 156:15]
  wire  new_s = ~adder_io_out_c_reg_0 & (sign_reg_5_0 | sign_reg_5_1) | sign_reg_5_0 & sign_reg_5_1; // @[FPArithmetic.scala 156:75]
  wire  _D_T_1 = sign_reg_5_0 ^ sign_reg_5_1; // @[FPArithmetic.scala 163:53]
  wire  D = _new_s_T | sign_reg_5_0 ^ sign_reg_5_1; // @[FPArithmetic.scala 163:35]
  wire  E = _new_s_T & ~adder_io_out_s_reg_0[23] | _new_s_T & ~_D_T_1 | adder_io_out_c_reg_0 & adder_io_out_s_reg_0[23]
     & _D_T_1; // @[FPArithmetic.scala 165:134]
  reg [23:0] cmpl_adder_io_out_s_reg_0; // @[FPArithmetic.scala 167:42]
  wire [23:0] _cmpl_adder_io_out_s_reg_0_T = ~adder_io_out_s_reg_1; // @[FPArithmetic.scala 170:43]
  wire [23:0] _cmpl_adder_io_out_s_reg_0_T_2 = 24'h1 + _cmpl_adder_io_out_s_reg_0_T; // @[FPArithmetic.scala 170:41]
  wire [1:0] _adder_result_T = {sign_reg_7_1,sign_reg_7_0}; // @[FPArithmetic.scala 174:53]
  wire [1:0] _leadingOne_T_25 = adder_result_reg_0[2] ? 2'h2 : {{1'd0}, adder_result_reg_0[1]}; // @[FPArithmetic.scala 177:70]
  wire [1:0] _leadingOne_T_26 = adder_result_reg_0[3] ? 2'h3 : _leadingOne_T_25; // @[FPArithmetic.scala 177:70]
  wire [2:0] _leadingOne_T_27 = adder_result_reg_0[4] ? 3'h4 : {{1'd0}, _leadingOne_T_26}; // @[FPArithmetic.scala 177:70]
  wire [2:0] _leadingOne_T_28 = adder_result_reg_0[5] ? 3'h5 : _leadingOne_T_27; // @[FPArithmetic.scala 177:70]
  wire [2:0] _leadingOne_T_29 = adder_result_reg_0[6] ? 3'h6 : _leadingOne_T_28; // @[FPArithmetic.scala 177:70]
  wire [2:0] _leadingOne_T_30 = adder_result_reg_0[7] ? 3'h7 : _leadingOne_T_29; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_31 = adder_result_reg_0[8] ? 4'h8 : {{1'd0}, _leadingOne_T_30}; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_32 = adder_result_reg_0[9] ? 4'h9 : _leadingOne_T_31; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_33 = adder_result_reg_0[10] ? 4'ha : _leadingOne_T_32; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_34 = adder_result_reg_0[11] ? 4'hb : _leadingOne_T_33; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_35 = adder_result_reg_0[12] ? 4'hc : _leadingOne_T_34; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_36 = adder_result_reg_0[13] ? 4'hd : _leadingOne_T_35; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_37 = adder_result_reg_0[14] ? 4'he : _leadingOne_T_36; // @[FPArithmetic.scala 177:70]
  wire [3:0] _leadingOne_T_38 = adder_result_reg_0[15] ? 4'hf : _leadingOne_T_37; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_39 = adder_result_reg_0[16] ? 5'h10 : {{1'd0}, _leadingOne_T_38}; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_40 = adder_result_reg_0[17] ? 5'h11 : _leadingOne_T_39; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_41 = adder_result_reg_0[18] ? 5'h12 : _leadingOne_T_40; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_42 = adder_result_reg_0[19] ? 5'h13 : _leadingOne_T_41; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_43 = adder_result_reg_0[20] ? 5'h14 : _leadingOne_T_42; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_44 = adder_result_reg_0[21] ? 5'h15 : _leadingOne_T_43; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_45 = adder_result_reg_0[22] ? 5'h16 : _leadingOne_T_44; // @[FPArithmetic.scala 177:70]
  wire [4:0] _leadingOne_T_46 = adder_result_reg_0[23] ? 5'h17 : _leadingOne_T_45; // @[FPArithmetic.scala 177:70]
  wire [5:0] leadingOne = _leadingOne_T_46 + 5'h1; // @[FPArithmetic.scala 177:77]
  wire [5:0] _subber2_io_in_b_T_1 = 6'h18 - leadingOne_reg_0; // @[FPArithmetic.scala 180:42]
  wire [7:0] exp_0 = _GEN_1[7:0]; // @[FPArithmetic.scala 42:19]
  wire [7:0] exp_1 = _GEN_3[7:0]; // @[FPArithmetic.scala 42:19]
  reg [31:0] reg_out_s; // @[FPArithmetic.scala 249:28]
  wire [8:0] _GEN_169 = {{1'd0}, ref_exp_reg_7}; // @[FPArithmetic.scala 266:29]
  wire [23:0] _new_out_frac_reg_0_T_2 = 24'h800000 - 24'h1; // @[FPArithmetic.scala 268:60]
  wire [7:0] _new_out_exp_reg_0_T_3 = ref_exp_reg_7 + 8'h1; // @[FPArithmetic.scala 270:48]
  wire [8:0] _GEN_142 = _GEN_169 == _T_2 ? _T_2 : {{1'd0}, _new_out_exp_reg_0_T_3}; // @[FPArithmetic.scala 266:66 267:30 270:30]
  wire [23:0] _GEN_143 = _GEN_169 == _T_2 ? _new_out_frac_reg_0_T_2 : {{1'd0}, adder_result_reg_2[23:1]}; // @[FPArithmetic.scala 266:66 268:31 271:31]
  wire [5:0] _new_out_frac_reg_0_T_6 = 6'h18 - leadingOne_reg_1; // @[FPArithmetic.scala 284:94]
  wire [85:0] _GEN_5 = {{63'd0}, adder_result_reg_2[22:0]}; // @[FPArithmetic.scala 284:73]
  wire [85:0] _new_out_frac_reg_0_T_7 = _GEN_5 << _new_out_frac_reg_0_T_6; // @[FPArithmetic.scala 284:73]
  wire [7:0] _GEN_144 = subber2_out_c_reg_0 ? 8'h1 : subber2_out_s_reg_0; // @[FPArithmetic.scala 279:46 280:32 283:32]
  wire [85:0] _GEN_145 = subber2_out_c_reg_0 ? 86'h0 : _new_out_frac_reg_0_T_7; // @[FPArithmetic.scala 279:46 281:33 284:33]
  wire [7:0] _GEN_146 = leadingOne_reg_1 == 6'h1 & adder_result_reg_2 == 24'h0 & ((sign_reg_10_0 ^ sign_reg_10_1) &
    io_in_a_reg_10[30:0] == io_in_b_reg_10[30:0]) ? 8'h0 : _GEN_144; // @[FPArithmetic.scala 275:184 276:30]
  wire [85:0] _GEN_147 = leadingOne_reg_1 == 6'h1 & adder_result_reg_2 == 24'h0 & ((sign_reg_10_0 ^ sign_reg_10_1) &
    io_in_a_reg_10[30:0] == io_in_b_reg_10[30:0]) ? 86'h0 : _GEN_145; // @[FPArithmetic.scala 275:184 277:31]
  wire  _GEN_148 = D_reg_4 ? new_s_reg_4 : new_s_reg_5; // @[FPArithmetic.scala 273:36 274:22 87:35]
  wire [7:0] _GEN_149 = D_reg_4 ? _GEN_146 : new_out_exp_reg_0; // @[FPArithmetic.scala 273:36 89:35]
  wire [85:0] _GEN_150 = D_reg_4 ? _GEN_147 : {{63'd0}, new_out_frac_reg_0}; // @[FPArithmetic.scala 273:36 88:35]
  wire  _GEN_151 = ~D_reg_4 ? new_s_reg_4 : _GEN_148; // @[FPArithmetic.scala 264:36 265:22]
  wire [8:0] _GEN_152 = ~D_reg_4 ? _GEN_142 : {{1'd0}, _GEN_149}; // @[FPArithmetic.scala 264:36]
  wire [85:0] _GEN_153 = ~D_reg_4 ? {{62'd0}, _GEN_143} : _GEN_150; // @[FPArithmetic.scala 264:36]
  wire  _GEN_154 = E_reg_4 ? new_s_reg_4 : _GEN_151; // @[FPArithmetic.scala 260:36 261:22]
  wire [8:0] _GEN_155 = E_reg_4 ? {{1'd0}, ref_exp_reg_7} : _GEN_152; // @[FPArithmetic.scala 260:36 262:28]
  wire [85:0] _GEN_156 = E_reg_4 ? {{63'd0}, adder_result_reg_2[22:0]} : _GEN_153; // @[FPArithmetic.scala 260:36 263:29]
  wire [85:0] _GEN_158 = sub_exp_reg_7 >= 8'h17 ? {{63'd0}, ref_frac_reg_7} : _GEN_156; // @[FPArithmetic.scala 256:48 258:29]
  wire [8:0] _GEN_159 = sub_exp_reg_7 >= 8'h17 ? {{1'd0}, ref_exp_reg_7} : _GEN_155; // @[FPArithmetic.scala 256:48 259:28]
  wire [8:0] _GEN_161 = io_in_a_reg_10[30:0] == 31'h0 & io_in_b_reg_10[30:0] == 31'h0 ? 9'h0 : _GEN_159; // @[FPArithmetic.scala 252:86 254:28]
  wire [85:0] _GEN_162 = io_in_a_reg_10[30:0] == 31'h0 & io_in_b_reg_10[30:0] == 31'h0 ? 86'h0 : _GEN_158; // @[FPArithmetic.scala 252:86 255:29]
  wire [31:0] _reg_out_s_T_1 = {new_s_reg_5,new_out_exp_reg_0,new_out_frac_reg_0}; // @[FPArithmetic.scala 288:55]
  wire [8:0] _GEN_164 = io_in_en ? _GEN_161 : {{1'd0}, new_out_exp_reg_0}; // @[FPArithmetic.scala 251:20 89:35]
  wire [85:0] _GEN_165 = io_in_en ? _GEN_162 : {{63'd0}, new_out_frac_reg_0}; // @[FPArithmetic.scala 251:20 88:35]
  wire [85:0] _GEN_170 = reset ? 86'h0 : _GEN_165; // @[FPArithmetic.scala 88:{35,35}]
  wire [8:0] _GEN_171 = reset ? 9'h0 : _GEN_164; // @[FPArithmetic.scala 89:{35,35}]
  full_subtractor_bw8 subber ( // @[FPArithmetic.scala 111:24]
    .io_in_a(subber_io_in_a),
    .io_in_b(subber_io_in_b),
    .io_out_s(subber_io_out_s),
    .io_out_c(subber_io_out_c)
  );
  full_adder_bw24 adder ( // @[FPArithmetic.scala 117:23]
    .io_in_a(adder_io_in_a),
    .io_in_b(adder_io_in_b),
    .io_out_s(adder_io_out_s),
    .io_out_c(adder_io_out_c)
  );
  full_subtractor_bw8 subber2 ( // @[FPArithmetic.scala 178:25]
    .io_in_a(subber2_io_in_a),
    .io_in_b(subber2_io_in_b),
    .io_out_s(subber2_io_out_s),
    .io_out_c(subber2_io_out_c)
  );
  assign io_out_s = reg_out_s; // @[FPArithmetic.scala 250:14]
  assign subber_io_in_a = exp_reg_0_0; // @[FPArithmetic.scala 112:20]
  assign subber_io_in_b = exp_reg_0_1; // @[FPArithmetic.scala 113:20]
  assign adder_io_in_a = _adder_io_in_a_T == 2'h1 ? cmpl_wire_temp_add_in_reg_0_0 : wire_temp_add_in_reg_1_0; // @[FPArithmetic.scala 149:25]
  assign adder_io_in_b = _adder_io_in_a_T == 2'h2 ? cmpl_wire_temp_add_in_reg_0_1 : wire_temp_add_in_reg_1_1; // @[FPArithmetic.scala 150:25]
  assign subber2_io_in_a = ref_exp_reg_6; // @[FPArithmetic.scala 179:21]
  assign subber2_io_in_b = {{2'd0}, _subber2_io_in_b_T_1}; // @[FPArithmetic.scala 180:21]
  always @(posedge clock) begin
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_0_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_0_0 <= sign_0; // @[FPArithmetic.scala 188:19]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_0_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_0_1 <= sign_1; // @[FPArithmetic.scala 188:19]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_1_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_1_0 <= sign_reg_0_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_1_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_1_1 <= sign_reg_0_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_2_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_2_0 <= sign_reg_1_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_2_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_2_1 <= sign_reg_1_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_3_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_3_0 <= sign_reg_2_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_3_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_3_1 <= sign_reg_2_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_4_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_4_0 <= sign_reg_3_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_4_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_4_1 <= sign_reg_3_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_5_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_5_0 <= sign_reg_4_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_5_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_5_1 <= sign_reg_4_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_6_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_6_0 <= sign_reg_5_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_6_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_6_1 <= sign_reg_5_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_7_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_7_0 <= sign_reg_6_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_7_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_7_1 <= sign_reg_6_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_8_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_8_0 <= sign_reg_7_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_8_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_8_1 <= sign_reg_7_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_9_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_9_0 <= sign_reg_8_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_9_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_9_1 <= sign_reg_8_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_10_0 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_10_0 <= sign_reg_9_0; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 69:28]
      sign_reg_10_1 <= 1'h0; // @[FPArithmetic.scala 69:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sign_reg_10_1 <= sign_reg_9_1; // @[FPArithmetic.scala 219:23]
    end
    if (reset) begin // @[FPArithmetic.scala 70:28]
      exp_reg_0_0 <= 8'h0; // @[FPArithmetic.scala 70:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      exp_reg_0_0 <= exp_0; // @[FPArithmetic.scala 189:18]
    end
    if (reset) begin // @[FPArithmetic.scala 70:28]
      exp_reg_0_1 <= 8'h0; // @[FPArithmetic.scala 70:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      exp_reg_0_1 <= exp_1; // @[FPArithmetic.scala 189:18]
    end
    if (reset) begin // @[FPArithmetic.scala 70:28]
      exp_reg_1_0 <= 8'h0; // @[FPArithmetic.scala 70:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      exp_reg_1_0 <= exp_reg_0_0; // @[FPArithmetic.scala 237:22]
    end
    if (reset) begin // @[FPArithmetic.scala 70:28]
      exp_reg_1_1 <= 8'h0; // @[FPArithmetic.scala 70:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      exp_reg_1_1 <= exp_reg_0_1; // @[FPArithmetic.scala 237:22]
    end
    if (reset) begin // @[FPArithmetic.scala 70:28]
      exp_reg_2_0 <= 8'h0; // @[FPArithmetic.scala 70:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      exp_reg_2_0 <= exp_reg_1_0; // @[FPArithmetic.scala 237:22]
    end
    if (reset) begin // @[FPArithmetic.scala 70:28]
      exp_reg_2_1 <= 8'h0; // @[FPArithmetic.scala 70:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      exp_reg_2_1 <= exp_reg_1_1; // @[FPArithmetic.scala 237:22]
    end
    if (reset) begin // @[FPArithmetic.scala 71:28]
      frac_reg_0_0 <= 23'h0; // @[FPArithmetic.scala 71:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      frac_reg_0_0 <= frac_0; // @[FPArithmetic.scala 190:19]
    end
    if (reset) begin // @[FPArithmetic.scala 71:28]
      frac_reg_0_1 <= 23'h0; // @[FPArithmetic.scala 71:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      frac_reg_0_1 <= frac_1; // @[FPArithmetic.scala 190:19]
    end
    if (reset) begin // @[FPArithmetic.scala 71:28]
      frac_reg_1_0 <= 23'h0; // @[FPArithmetic.scala 71:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      frac_reg_1_0 <= frac_reg_0_0; // @[FPArithmetic.scala 238:23]
    end
    if (reset) begin // @[FPArithmetic.scala 71:28]
      frac_reg_1_1 <= 23'h0; // @[FPArithmetic.scala 71:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      frac_reg_1_1 <= frac_reg_0_1; // @[FPArithmetic.scala 238:23]
    end
    if (reset) begin // @[FPArithmetic.scala 71:28]
      frac_reg_2_0 <= 23'h0; // @[FPArithmetic.scala 71:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      frac_reg_2_0 <= frac_reg_1_0; // @[FPArithmetic.scala 238:23]
    end
    if (reset) begin // @[FPArithmetic.scala 71:28]
      frac_reg_2_1 <= 23'h0; // @[FPArithmetic.scala 71:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      frac_reg_2_1 <= frac_reg_1_1; // @[FPArithmetic.scala 238:23]
    end
    if (reset) begin // @[FPArithmetic.scala 72:28]
      wfrac_reg_0_0 <= 24'h0; // @[FPArithmetic.scala 72:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wfrac_reg_0_0 <= whole_frac_0; // @[FPArithmetic.scala 191:20]
    end
    if (reset) begin // @[FPArithmetic.scala 72:28]
      wfrac_reg_0_1 <= 24'h0; // @[FPArithmetic.scala 72:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wfrac_reg_0_1 <= whole_frac_1; // @[FPArithmetic.scala 191:20]
    end
    if (reset) begin // @[FPArithmetic.scala 72:28]
      wfrac_reg_1_0 <= 24'h0; // @[FPArithmetic.scala 72:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wfrac_reg_1_0 <= wfrac_reg_0_0; // @[FPArithmetic.scala 239:24]
    end
    if (reset) begin // @[FPArithmetic.scala 72:28]
      wfrac_reg_1_1 <= 24'h0; // @[FPArithmetic.scala 72:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wfrac_reg_1_1 <= wfrac_reg_0_1; // @[FPArithmetic.scala 239:24]
    end
    if (reset) begin // @[FPArithmetic.scala 72:28]
      wfrac_reg_2_0 <= 24'h0; // @[FPArithmetic.scala 72:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wfrac_reg_2_0 <= wfrac_reg_1_0; // @[FPArithmetic.scala 239:24]
    end
    if (reset) begin // @[FPArithmetic.scala 72:28]
      wfrac_reg_2_1 <= 24'h0; // @[FPArithmetic.scala 72:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wfrac_reg_2_1 <= wfrac_reg_1_1; // @[FPArithmetic.scala 239:24]
    end
    if (reset) begin // @[FPArithmetic.scala 74:35]
      subber_out_s_reg_0 <= 8'h0; // @[FPArithmetic.scala 74:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      subber_out_s_reg_0 <= subber_io_out_s; // @[FPArithmetic.scala 193:27]
    end
    if (reset) begin // @[FPArithmetic.scala 74:35]
      subber_out_s_reg_1 <= 8'h0; // @[FPArithmetic.scala 74:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      subber_out_s_reg_1 <= subber_out_s_reg_0; // @[FPArithmetic.scala 242:31]
    end
    if (reset) begin // @[FPArithmetic.scala 75:35]
      subber_out_c_reg_0 <= 1'h0; // @[FPArithmetic.scala 75:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      subber_out_c_reg_0 <= subber_io_out_c; // @[FPArithmetic.scala 194:27]
    end
    if (reset) begin // @[FPArithmetic.scala 75:35]
      subber_out_c_reg_1 <= 1'h0; // @[FPArithmetic.scala 75:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      subber_out_c_reg_1 <= subber_out_c_reg_0; // @[FPArithmetic.scala 243:31]
    end
    if (reset) begin // @[FPArithmetic.scala 77:39]
      wire_temp_add_in_reg_0_0 <= 24'h0; // @[FPArithmetic.scala 77:39]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (subber_out_c_reg_1) begin // @[FPArithmetic.scala 127:39]
        wire_temp_add_in_reg_0_0 <= _wire_temp_add_in_0_T; // @[FPArithmetic.scala 132:27]
      end else begin
        wire_temp_add_in_reg_0_0 <= wfrac_reg_2_0; // @[FPArithmetic.scala 139:27]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 77:39]
      wire_temp_add_in_reg_0_1 <= 24'h0; // @[FPArithmetic.scala 77:39]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (subber_out_c_reg_1) begin // @[FPArithmetic.scala 127:39]
        wire_temp_add_in_reg_0_1 <= wfrac_reg_2_1; // @[FPArithmetic.scala 133:27]
      end else begin
        wire_temp_add_in_reg_0_1 <= _wire_temp_add_in_1_T; // @[FPArithmetic.scala 140:27]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 77:39]
      wire_temp_add_in_reg_1_0 <= 24'h0; // @[FPArithmetic.scala 77:39]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wire_temp_add_in_reg_1_0 <= wire_temp_add_in_reg_0_0; // @[FPArithmetic.scala 245:35]
    end
    if (reset) begin // @[FPArithmetic.scala 77:39]
      wire_temp_add_in_reg_1_1 <= 24'h0; // @[FPArithmetic.scala 77:39]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      wire_temp_add_in_reg_1_1 <= wire_temp_add_in_reg_0_1; // @[FPArithmetic.scala 245:35]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_0 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (subber_out_c_reg_1) begin // @[FPArithmetic.scala 127:39]
        ref_s_reg_0 <= sign_reg_2_1; // @[FPArithmetic.scala 130:13]
      end else begin
        ref_s_reg_0 <= sign_reg_2_0; // @[FPArithmetic.scala 137:13]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_1 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_1 <= ref_s_reg_0; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_2 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_2 <= ref_s_reg_1; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_3 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_3 <= ref_s_reg_2; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_4 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_4 <= ref_s_reg_3; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_5 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_5 <= ref_s_reg_4; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_6 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_6 <= ref_s_reg_5; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 79:31]
      ref_s_reg_7 <= 1'h0; // @[FPArithmetic.scala 79:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_s_reg_7 <= ref_s_reg_6; // @[FPArithmetic.scala 224:24]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_0 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (subber_out_c_reg_1) begin // @[FPArithmetic.scala 127:39]
        ref_frac_reg_0 <= frac_reg_2_1; // @[FPArithmetic.scala 131:16]
      end else begin
        ref_frac_reg_0 <= frac_reg_2_0; // @[FPArithmetic.scala 138:16]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_1 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_1 <= ref_frac_reg_0; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_2 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_2 <= ref_frac_reg_1; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_3 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_3 <= ref_frac_reg_2; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_4 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_4 <= ref_frac_reg_3; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_5 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_5 <= ref_frac_reg_4; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_6 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_6 <= ref_frac_reg_5; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 80:31]
      ref_frac_reg_7 <= 23'h0; // @[FPArithmetic.scala 80:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_frac_reg_7 <= ref_frac_reg_6; // @[FPArithmetic.scala 225:27]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_0 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (subber_out_c_reg_1) begin // @[FPArithmetic.scala 127:39]
        ref_exp_reg_0 <= exp_reg_2_1; // @[FPArithmetic.scala 128:15]
      end else begin
        ref_exp_reg_0 <= exp_reg_2_0; // @[FPArithmetic.scala 135:15]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_1 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_1 <= ref_exp_reg_0; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_2 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_2 <= ref_exp_reg_1; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_3 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_3 <= ref_exp_reg_2; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_4 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_4 <= ref_exp_reg_3; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_5 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_5 <= ref_exp_reg_4; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_6 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_6 <= ref_exp_reg_5; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 81:31]
      ref_exp_reg_7 <= 8'h0; // @[FPArithmetic.scala 81:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      ref_exp_reg_7 <= ref_exp_reg_6; // @[FPArithmetic.scala 226:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_0 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (subber_out_c_reg_1) begin // @[FPArithmetic.scala 127:39]
        sub_exp_reg_0 <= cmpl_subber_out_s_reg_0; // @[FPArithmetic.scala 129:15]
      end else begin
        sub_exp_reg_0 <= subber_out_s_reg_1; // @[FPArithmetic.scala 136:15]
      end
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_1 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_1 <= sub_exp_reg_0; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_2 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_2 <= sub_exp_reg_1; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_3 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_3 <= sub_exp_reg_2; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_4 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_4 <= sub_exp_reg_3; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_5 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_5 <= sub_exp_reg_4; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_6 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_6 <= sub_exp_reg_5; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 82:31]
      sub_exp_reg_7 <= 8'h0; // @[FPArithmetic.scala 82:31]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      sub_exp_reg_7 <= sub_exp_reg_6; // @[FPArithmetic.scala 227:26]
    end
    if (reset) begin // @[FPArithmetic.scala 84:37]
      adder_io_out_s_reg_0 <= 24'h0; // @[FPArithmetic.scala 84:37]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      adder_io_out_s_reg_0 <= adder_io_out_s; // @[FPArithmetic.scala 207:29]
    end
    if (reset) begin // @[FPArithmetic.scala 84:37]
      adder_io_out_s_reg_1 <= 24'h0; // @[FPArithmetic.scala 84:37]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      adder_io_out_s_reg_1 <= adder_io_out_s_reg_0; // @[FPArithmetic.scala 236:33]
    end
    if (reset) begin // @[FPArithmetic.scala 84:37]
      adder_io_out_s_reg_2 <= 24'h0; // @[FPArithmetic.scala 84:37]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      adder_io_out_s_reg_2 <= adder_io_out_s_reg_1; // @[FPArithmetic.scala 236:33]
    end
    if (reset) begin // @[FPArithmetic.scala 85:37]
      adder_io_out_c_reg_0 <= 1'h0; // @[FPArithmetic.scala 85:37]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      adder_io_out_c_reg_0 <= adder_io_out_c; // @[FPArithmetic.scala 208:29]
    end
    if (reset) begin // @[FPArithmetic.scala 87:35]
      new_s_reg_0 <= 1'h0; // @[FPArithmetic.scala 87:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      new_s_reg_0 <= new_s; // @[FPArithmetic.scala 203:20]
    end
    if (reset) begin // @[FPArithmetic.scala 87:35]
      new_s_reg_1 <= 1'h0; // @[FPArithmetic.scala 87:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      new_s_reg_1 <= new_s_reg_0; // @[FPArithmetic.scala 232:24]
    end
    if (reset) begin // @[FPArithmetic.scala 87:35]
      new_s_reg_2 <= 1'h0; // @[FPArithmetic.scala 87:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      new_s_reg_2 <= new_s_reg_1; // @[FPArithmetic.scala 232:24]
    end
    if (reset) begin // @[FPArithmetic.scala 87:35]
      new_s_reg_3 <= 1'h0; // @[FPArithmetic.scala 87:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      new_s_reg_3 <= new_s_reg_2; // @[FPArithmetic.scala 232:24]
    end
    if (reset) begin // @[FPArithmetic.scala 87:35]
      new_s_reg_4 <= 1'h0; // @[FPArithmetic.scala 87:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      new_s_reg_4 <= new_s_reg_3; // @[FPArithmetic.scala 232:24]
    end
    if (reset) begin // @[FPArithmetic.scala 87:35]
      new_s_reg_5 <= 1'h0; // @[FPArithmetic.scala 87:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 251:20]
      if (io_in_a_reg_10[30:0] == 31'h0 & io_in_b_reg_10[30:0] == 31'h0) begin // @[FPArithmetic.scala 252:86]
        new_s_reg_5 <= 1'h0; // @[FPArithmetic.scala 253:22]
      end else if (sub_exp_reg_7 >= 8'h17) begin // @[FPArithmetic.scala 256:48]
        new_s_reg_5 <= ref_s_reg_7; // @[FPArithmetic.scala 257:22]
      end else begin
        new_s_reg_5 <= _GEN_154;
      end
    end
    new_out_frac_reg_0 <= _GEN_170[22:0]; // @[FPArithmetic.scala 88:{35,35}]
    new_out_exp_reg_0 <= _GEN_171[7:0]; // @[FPArithmetic.scala 89:{35,35}]
    if (reset) begin // @[FPArithmetic.scala 90:24]
      E_reg_0 <= 1'h0; // @[FPArithmetic.scala 90:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      E_reg_0 <= E; // @[FPArithmetic.scala 204:16]
    end
    if (reset) begin // @[FPArithmetic.scala 90:24]
      E_reg_1 <= 1'h0; // @[FPArithmetic.scala 90:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      E_reg_1 <= E_reg_0; // @[FPArithmetic.scala 230:20]
    end
    if (reset) begin // @[FPArithmetic.scala 90:24]
      E_reg_2 <= 1'h0; // @[FPArithmetic.scala 90:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      E_reg_2 <= E_reg_1; // @[FPArithmetic.scala 230:20]
    end
    if (reset) begin // @[FPArithmetic.scala 90:24]
      E_reg_3 <= 1'h0; // @[FPArithmetic.scala 90:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      E_reg_3 <= E_reg_2; // @[FPArithmetic.scala 230:20]
    end
    if (reset) begin // @[FPArithmetic.scala 90:24]
      E_reg_4 <= 1'h0; // @[FPArithmetic.scala 90:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      E_reg_4 <= E_reg_3; // @[FPArithmetic.scala 230:20]
    end
    if (reset) begin // @[FPArithmetic.scala 91:24]
      D_reg_0 <= 1'h0; // @[FPArithmetic.scala 91:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      D_reg_0 <= D; // @[FPArithmetic.scala 205:16]
    end
    if (reset) begin // @[FPArithmetic.scala 91:24]
      D_reg_1 <= 1'h0; // @[FPArithmetic.scala 91:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      D_reg_1 <= D_reg_0; // @[FPArithmetic.scala 231:20]
    end
    if (reset) begin // @[FPArithmetic.scala 91:24]
      D_reg_2 <= 1'h0; // @[FPArithmetic.scala 91:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      D_reg_2 <= D_reg_1; // @[FPArithmetic.scala 231:20]
    end
    if (reset) begin // @[FPArithmetic.scala 91:24]
      D_reg_3 <= 1'h0; // @[FPArithmetic.scala 91:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      D_reg_3 <= D_reg_2; // @[FPArithmetic.scala 231:20]
    end
    if (reset) begin // @[FPArithmetic.scala 91:24]
      D_reg_4 <= 1'h0; // @[FPArithmetic.scala 91:24]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      D_reg_4 <= D_reg_3; // @[FPArithmetic.scala 231:20]
    end
    if (reset) begin // @[FPArithmetic.scala 93:35]
      adder_result_reg_0 <= 24'h0; // @[FPArithmetic.scala 93:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      if (new_s_reg_1 & ^_adder_result_T) begin // @[FPArithmetic.scala 174:24]
        adder_result_reg_0 <= cmpl_adder_io_out_s_reg_0;
      end else begin
        adder_result_reg_0 <= adder_io_out_s_reg_2;
      end
    end
    if (reset) begin // @[FPArithmetic.scala 93:35]
      adder_result_reg_1 <= 24'h0; // @[FPArithmetic.scala 93:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      adder_result_reg_1 <= adder_result_reg_0; // @[FPArithmetic.scala 235:31]
    end
    if (reset) begin // @[FPArithmetic.scala 93:35]
      adder_result_reg_2 <= 24'h0; // @[FPArithmetic.scala 93:35]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      adder_result_reg_2 <= adder_result_reg_1; // @[FPArithmetic.scala 235:31]
    end
    if (reset) begin // @[FPArithmetic.scala 95:33]
      leadingOne_reg_0 <= 6'h0; // @[FPArithmetic.scala 95:33]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      leadingOne_reg_0 <= leadingOne; // @[FPArithmetic.scala 212:25]
    end
    if (reset) begin // @[FPArithmetic.scala 95:33]
      leadingOne_reg_1 <= 6'h0; // @[FPArithmetic.scala 95:33]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      leadingOne_reg_1 <= leadingOne_reg_0; // @[FPArithmetic.scala 244:29]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_0 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_0 <= io_in_a; // @[FPArithmetic.scala 185:22]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_1 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_1 <= io_in_a_reg_0; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_2 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_2 <= io_in_a_reg_1; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_3 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_3 <= io_in_a_reg_2; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_4 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_4 <= io_in_a_reg_3; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_5 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_5 <= io_in_a_reg_4; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_6 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_6 <= io_in_a_reg_5; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_7 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_7 <= io_in_a_reg_6; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_8 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_8 <= io_in_a_reg_7; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_9 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_9 <= io_in_a_reg_8; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 97:30]
      io_in_a_reg_10 <= 32'h0; // @[FPArithmetic.scala 97:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_a_reg_10 <= io_in_a_reg_9; // @[FPArithmetic.scala 220:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_0 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_0 <= io_in_b; // @[FPArithmetic.scala 186:22]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_1 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_1 <= io_in_b_reg_0; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_2 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_2 <= io_in_b_reg_1; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_3 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_3 <= io_in_b_reg_2; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_4 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_4 <= io_in_b_reg_3; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_5 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_5 <= io_in_b_reg_4; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_6 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_6 <= io_in_b_reg_5; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_7 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_7 <= io_in_b_reg_6; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_8 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_8 <= io_in_b_reg_7; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_9 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_9 <= io_in_b_reg_8; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 98:30]
      io_in_b_reg_10 <= 32'h0; // @[FPArithmetic.scala 98:30]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      io_in_b_reg_10 <= io_in_b_reg_9; // @[FPArithmetic.scala 221:26]
    end
    if (reset) begin // @[FPArithmetic.scala 100:36]
      subber2_out_s_reg_0 <= 8'h0; // @[FPArithmetic.scala 100:36]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      subber2_out_s_reg_0 <= subber2_io_out_s; // @[FPArithmetic.scala 214:28]
    end
    if (reset) begin // @[FPArithmetic.scala 101:36]
      subber2_out_c_reg_0 <= 1'h0; // @[FPArithmetic.scala 101:36]
    end else if (io_in_en) begin // @[FPArithmetic.scala 184:19]
      subber2_out_c_reg_0 <= subber2_io_out_c; // @[FPArithmetic.scala 215:28]
    end
    if (reset) begin // @[FPArithmetic.scala 122:40]
      cmpl_subber_out_s_reg_0 <= 8'h0; // @[FPArithmetic.scala 122:40]
    end else if (io_in_en) begin // @[FPArithmetic.scala 123:19]
      cmpl_subber_out_s_reg_0 <= _cmpl_subber_out_s_reg_0_T_2; // @[FPArithmetic.scala 124:32]
    end
    if (reset) begin // @[FPArithmetic.scala 143:44]
      cmpl_wire_temp_add_in_reg_0_0 <= 24'h0; // @[FPArithmetic.scala 143:44]
    end else if (io_in_en) begin // @[FPArithmetic.scala 144:19]
      cmpl_wire_temp_add_in_reg_0_0 <= _cmpl_wire_temp_add_in_reg_0_0_T_2; // @[FPArithmetic.scala 145:39]
    end
    if (reset) begin // @[FPArithmetic.scala 143:44]
      cmpl_wire_temp_add_in_reg_0_1 <= 24'h0; // @[FPArithmetic.scala 143:44]
    end else if (io_in_en) begin // @[FPArithmetic.scala 144:19]
      cmpl_wire_temp_add_in_reg_0_1 <= _cmpl_wire_temp_add_in_reg_0_1_T_2; // @[FPArithmetic.scala 146:39]
    end
    if (reset) begin // @[FPArithmetic.scala 167:42]
      cmpl_adder_io_out_s_reg_0 <= 24'h0; // @[FPArithmetic.scala 167:42]
    end else if (io_in_en) begin // @[FPArithmetic.scala 169:19]
      cmpl_adder_io_out_s_reg_0 <= _cmpl_adder_io_out_s_reg_0_T_2; // @[FPArithmetic.scala 170:34]
    end
    if (reset) begin // @[FPArithmetic.scala 249:28]
      reg_out_s <= 32'h0; // @[FPArithmetic.scala 249:28]
    end else if (io_in_en) begin // @[FPArithmetic.scala 251:20]
      reg_out_s <= _reg_out_s_T_1; // @[FPArithmetic.scala 288:17]
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
  sign_reg_0_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  sign_reg_0_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  sign_reg_1_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  sign_reg_1_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  sign_reg_2_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  sign_reg_2_1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  sign_reg_3_0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  sign_reg_3_1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  sign_reg_4_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  sign_reg_4_1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sign_reg_5_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  sign_reg_5_1 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sign_reg_6_0 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  sign_reg_6_1 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sign_reg_7_0 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  sign_reg_7_1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  sign_reg_8_0 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sign_reg_8_1 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  sign_reg_9_0 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  sign_reg_9_1 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  sign_reg_10_0 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  sign_reg_10_1 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  exp_reg_0_0 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  exp_reg_0_1 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  exp_reg_1_0 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  exp_reg_1_1 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  exp_reg_2_0 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  exp_reg_2_1 = _RAND_27[7:0];
  _RAND_28 = {1{`RANDOM}};
  frac_reg_0_0 = _RAND_28[22:0];
  _RAND_29 = {1{`RANDOM}};
  frac_reg_0_1 = _RAND_29[22:0];
  _RAND_30 = {1{`RANDOM}};
  frac_reg_1_0 = _RAND_30[22:0];
  _RAND_31 = {1{`RANDOM}};
  frac_reg_1_1 = _RAND_31[22:0];
  _RAND_32 = {1{`RANDOM}};
  frac_reg_2_0 = _RAND_32[22:0];
  _RAND_33 = {1{`RANDOM}};
  frac_reg_2_1 = _RAND_33[22:0];
  _RAND_34 = {1{`RANDOM}};
  wfrac_reg_0_0 = _RAND_34[23:0];
  _RAND_35 = {1{`RANDOM}};
  wfrac_reg_0_1 = _RAND_35[23:0];
  _RAND_36 = {1{`RANDOM}};
  wfrac_reg_1_0 = _RAND_36[23:0];
  _RAND_37 = {1{`RANDOM}};
  wfrac_reg_1_1 = _RAND_37[23:0];
  _RAND_38 = {1{`RANDOM}};
  wfrac_reg_2_0 = _RAND_38[23:0];
  _RAND_39 = {1{`RANDOM}};
  wfrac_reg_2_1 = _RAND_39[23:0];
  _RAND_40 = {1{`RANDOM}};
  subber_out_s_reg_0 = _RAND_40[7:0];
  _RAND_41 = {1{`RANDOM}};
  subber_out_s_reg_1 = _RAND_41[7:0];
  _RAND_42 = {1{`RANDOM}};
  subber_out_c_reg_0 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  subber_out_c_reg_1 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  wire_temp_add_in_reg_0_0 = _RAND_44[23:0];
  _RAND_45 = {1{`RANDOM}};
  wire_temp_add_in_reg_0_1 = _RAND_45[23:0];
  _RAND_46 = {1{`RANDOM}};
  wire_temp_add_in_reg_1_0 = _RAND_46[23:0];
  _RAND_47 = {1{`RANDOM}};
  wire_temp_add_in_reg_1_1 = _RAND_47[23:0];
  _RAND_48 = {1{`RANDOM}};
  ref_s_reg_0 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  ref_s_reg_1 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  ref_s_reg_2 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  ref_s_reg_3 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  ref_s_reg_4 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  ref_s_reg_5 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  ref_s_reg_6 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  ref_s_reg_7 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  ref_frac_reg_0 = _RAND_56[22:0];
  _RAND_57 = {1{`RANDOM}};
  ref_frac_reg_1 = _RAND_57[22:0];
  _RAND_58 = {1{`RANDOM}};
  ref_frac_reg_2 = _RAND_58[22:0];
  _RAND_59 = {1{`RANDOM}};
  ref_frac_reg_3 = _RAND_59[22:0];
  _RAND_60 = {1{`RANDOM}};
  ref_frac_reg_4 = _RAND_60[22:0];
  _RAND_61 = {1{`RANDOM}};
  ref_frac_reg_5 = _RAND_61[22:0];
  _RAND_62 = {1{`RANDOM}};
  ref_frac_reg_6 = _RAND_62[22:0];
  _RAND_63 = {1{`RANDOM}};
  ref_frac_reg_7 = _RAND_63[22:0];
  _RAND_64 = {1{`RANDOM}};
  ref_exp_reg_0 = _RAND_64[7:0];
  _RAND_65 = {1{`RANDOM}};
  ref_exp_reg_1 = _RAND_65[7:0];
  _RAND_66 = {1{`RANDOM}};
  ref_exp_reg_2 = _RAND_66[7:0];
  _RAND_67 = {1{`RANDOM}};
  ref_exp_reg_3 = _RAND_67[7:0];
  _RAND_68 = {1{`RANDOM}};
  ref_exp_reg_4 = _RAND_68[7:0];
  _RAND_69 = {1{`RANDOM}};
  ref_exp_reg_5 = _RAND_69[7:0];
  _RAND_70 = {1{`RANDOM}};
  ref_exp_reg_6 = _RAND_70[7:0];
  _RAND_71 = {1{`RANDOM}};
  ref_exp_reg_7 = _RAND_71[7:0];
  _RAND_72 = {1{`RANDOM}};
  sub_exp_reg_0 = _RAND_72[7:0];
  _RAND_73 = {1{`RANDOM}};
  sub_exp_reg_1 = _RAND_73[7:0];
  _RAND_74 = {1{`RANDOM}};
  sub_exp_reg_2 = _RAND_74[7:0];
  _RAND_75 = {1{`RANDOM}};
  sub_exp_reg_3 = _RAND_75[7:0];
  _RAND_76 = {1{`RANDOM}};
  sub_exp_reg_4 = _RAND_76[7:0];
  _RAND_77 = {1{`RANDOM}};
  sub_exp_reg_5 = _RAND_77[7:0];
  _RAND_78 = {1{`RANDOM}};
  sub_exp_reg_6 = _RAND_78[7:0];
  _RAND_79 = {1{`RANDOM}};
  sub_exp_reg_7 = _RAND_79[7:0];
  _RAND_80 = {1{`RANDOM}};
  adder_io_out_s_reg_0 = _RAND_80[23:0];
  _RAND_81 = {1{`RANDOM}};
  adder_io_out_s_reg_1 = _RAND_81[23:0];
  _RAND_82 = {1{`RANDOM}};
  adder_io_out_s_reg_2 = _RAND_82[23:0];
  _RAND_83 = {1{`RANDOM}};
  adder_io_out_c_reg_0 = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  new_s_reg_0 = _RAND_84[0:0];
  _RAND_85 = {1{`RANDOM}};
  new_s_reg_1 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  new_s_reg_2 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  new_s_reg_3 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  new_s_reg_4 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  new_s_reg_5 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  new_out_frac_reg_0 = _RAND_90[22:0];
  _RAND_91 = {1{`RANDOM}};
  new_out_exp_reg_0 = _RAND_91[7:0];
  _RAND_92 = {1{`RANDOM}};
  E_reg_0 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  E_reg_1 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  E_reg_2 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  E_reg_3 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  E_reg_4 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  D_reg_0 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  D_reg_1 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  D_reg_2 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  D_reg_3 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  D_reg_4 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  adder_result_reg_0 = _RAND_102[23:0];
  _RAND_103 = {1{`RANDOM}};
  adder_result_reg_1 = _RAND_103[23:0];
  _RAND_104 = {1{`RANDOM}};
  adder_result_reg_2 = _RAND_104[23:0];
  _RAND_105 = {1{`RANDOM}};
  leadingOne_reg_0 = _RAND_105[5:0];
  _RAND_106 = {1{`RANDOM}};
  leadingOne_reg_1 = _RAND_106[5:0];
  _RAND_107 = {1{`RANDOM}};
  io_in_a_reg_0 = _RAND_107[31:0];
  _RAND_108 = {1{`RANDOM}};
  io_in_a_reg_1 = _RAND_108[31:0];
  _RAND_109 = {1{`RANDOM}};
  io_in_a_reg_2 = _RAND_109[31:0];
  _RAND_110 = {1{`RANDOM}};
  io_in_a_reg_3 = _RAND_110[31:0];
  _RAND_111 = {1{`RANDOM}};
  io_in_a_reg_4 = _RAND_111[31:0];
  _RAND_112 = {1{`RANDOM}};
  io_in_a_reg_5 = _RAND_112[31:0];
  _RAND_113 = {1{`RANDOM}};
  io_in_a_reg_6 = _RAND_113[31:0];
  _RAND_114 = {1{`RANDOM}};
  io_in_a_reg_7 = _RAND_114[31:0];
  _RAND_115 = {1{`RANDOM}};
  io_in_a_reg_8 = _RAND_115[31:0];
  _RAND_116 = {1{`RANDOM}};
  io_in_a_reg_9 = _RAND_116[31:0];
  _RAND_117 = {1{`RANDOM}};
  io_in_a_reg_10 = _RAND_117[31:0];
  _RAND_118 = {1{`RANDOM}};
  io_in_b_reg_0 = _RAND_118[31:0];
  _RAND_119 = {1{`RANDOM}};
  io_in_b_reg_1 = _RAND_119[31:0];
  _RAND_120 = {1{`RANDOM}};
  io_in_b_reg_2 = _RAND_120[31:0];
  _RAND_121 = {1{`RANDOM}};
  io_in_b_reg_3 = _RAND_121[31:0];
  _RAND_122 = {1{`RANDOM}};
  io_in_b_reg_4 = _RAND_122[31:0];
  _RAND_123 = {1{`RANDOM}};
  io_in_b_reg_5 = _RAND_123[31:0];
  _RAND_124 = {1{`RANDOM}};
  io_in_b_reg_6 = _RAND_124[31:0];
  _RAND_125 = {1{`RANDOM}};
  io_in_b_reg_7 = _RAND_125[31:0];
  _RAND_126 = {1{`RANDOM}};
  io_in_b_reg_8 = _RAND_126[31:0];
  _RAND_127 = {1{`RANDOM}};
  io_in_b_reg_9 = _RAND_127[31:0];
  _RAND_128 = {1{`RANDOM}};
  io_in_b_reg_10 = _RAND_128[31:0];
  _RAND_129 = {1{`RANDOM}};
  subber2_out_s_reg_0 = _RAND_129[7:0];
  _RAND_130 = {1{`RANDOM}};
  subber2_out_c_reg_0 = _RAND_130[0:0];
  _RAND_131 = {1{`RANDOM}};
  cmpl_subber_out_s_reg_0 = _RAND_131[7:0];
  _RAND_132 = {1{`RANDOM}};
  cmpl_wire_temp_add_in_reg_0_0 = _RAND_132[23:0];
  _RAND_133 = {1{`RANDOM}};
  cmpl_wire_temp_add_in_reg_0_1 = _RAND_133[23:0];
  _RAND_134 = {1{`RANDOM}};
  cmpl_adder_io_out_s_reg_0 = _RAND_134[23:0];
  _RAND_135 = {1{`RANDOM}};
  reg_out_s = _RAND_135[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FPComplexAdder_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a_Re,
  input  [31:0] io_in_a_Im,
  input  [31:0] io_in_b_Re,
  input  [31:0] io_in_b_Im,
  output [31:0] io_out_s_Re,
  output [31:0] io_out_s_Im
);
  wire  FP_adder_bw32_clock; // @[FPComplex.scala 42:25]
  wire  FP_adder_bw32_reset; // @[FPComplex.scala 42:25]
  wire  FP_adder_bw32_io_in_en; // @[FPComplex.scala 42:25]
  wire [31:0] FP_adder_bw32_io_in_a; // @[FPComplex.scala 42:25]
  wire [31:0] FP_adder_bw32_io_in_b; // @[FPComplex.scala 42:25]
  wire [31:0] FP_adder_bw32_io_out_s; // @[FPComplex.scala 42:25]
  wire  FP_adder_bw32_1_clock; // @[FPComplex.scala 42:25]
  wire  FP_adder_bw32_1_reset; // @[FPComplex.scala 42:25]
  wire  FP_adder_bw32_1_io_in_en; // @[FPComplex.scala 42:25]
  wire [31:0] FP_adder_bw32_1_io_in_a; // @[FPComplex.scala 42:25]
  wire [31:0] FP_adder_bw32_1_io_in_b; // @[FPComplex.scala 42:25]
  wire [31:0] FP_adder_bw32_1_io_out_s; // @[FPComplex.scala 42:25]
  FP_adder_bw32 FP_adder_bw32 ( // @[FPComplex.scala 42:25]
    .clock(FP_adder_bw32_clock),
    .reset(FP_adder_bw32_reset),
    .io_in_en(FP_adder_bw32_io_in_en),
    .io_in_a(FP_adder_bw32_io_in_a),
    .io_in_b(FP_adder_bw32_io_in_b),
    .io_out_s(FP_adder_bw32_io_out_s)
  );
  FP_adder_bw32 FP_adder_bw32_1 ( // @[FPComplex.scala 42:25]
    .clock(FP_adder_bw32_1_clock),
    .reset(FP_adder_bw32_1_reset),
    .io_in_en(FP_adder_bw32_1_io_in_en),
    .io_in_a(FP_adder_bw32_1_io_in_a),
    .io_in_b(FP_adder_bw32_1_io_in_b),
    .io_out_s(FP_adder_bw32_1_io_out_s)
  );
  assign io_out_s_Re = FP_adder_bw32_io_out_s; // @[FPComplex.scala 51:17]
  assign io_out_s_Im = FP_adder_bw32_1_io_out_s; // @[FPComplex.scala 52:17]
  assign FP_adder_bw32_clock = clock;
  assign FP_adder_bw32_reset = reset;
  assign FP_adder_bw32_io_in_en = io_in_en; // @[FPComplex.scala 45:24]
  assign FP_adder_bw32_io_in_a = io_in_a_Re; // @[FPComplex.scala 47:23]
  assign FP_adder_bw32_io_in_b = io_in_b_Re; // @[FPComplex.scala 48:23]
  assign FP_adder_bw32_1_clock = clock;
  assign FP_adder_bw32_1_reset = reset;
  assign FP_adder_bw32_1_io_in_en = io_in_en; // @[FPComplex.scala 46:24]
  assign FP_adder_bw32_1_io_in_a = io_in_a_Im; // @[FPComplex.scala 49:23]
  assign FP_adder_bw32_1_io_in_b = io_in_b_Im; // @[FPComplex.scala 50:23]
endmodule
module FP_subtractor_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
);
  wire  FP_adder_clock; // @[FPArithmetic.scala 302:26]
  wire  FP_adder_reset; // @[FPArithmetic.scala 302:26]
  wire  FP_adder_io_in_en; // @[FPArithmetic.scala 302:26]
  wire [31:0] FP_adder_io_in_a; // @[FPArithmetic.scala 302:26]
  wire [31:0] FP_adder_io_in_b; // @[FPArithmetic.scala 302:26]
  wire [31:0] FP_adder_io_out_s; // @[FPArithmetic.scala 302:26]
  wire  _adjusted_in_b_T_1 = ~io_in_b[31]; // @[FPArithmetic.scala 304:23]
  FP_adder_bw32 FP_adder ( // @[FPArithmetic.scala 302:26]
    .clock(FP_adder_clock),
    .reset(FP_adder_reset),
    .io_in_en(FP_adder_io_in_en),
    .io_in_a(FP_adder_io_in_a),
    .io_in_b(FP_adder_io_in_b),
    .io_out_s(FP_adder_io_out_s)
  );
  assign io_out_s = FP_adder_io_out_s; // @[FPArithmetic.scala 308:14]
  assign FP_adder_clock = clock;
  assign FP_adder_reset = reset;
  assign FP_adder_io_in_en = io_in_en; // @[FPArithmetic.scala 305:23]
  assign FP_adder_io_in_a = io_in_a; // @[FPArithmetic.scala 306:22]
  assign FP_adder_io_in_b = {_adjusted_in_b_T_1,io_in_b[30:0]}; // @[FPArithmetic.scala 304:41]
endmodule
module FPComplexSubtractor_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_a_Re,
  input  [31:0] io_in_a_Im,
  input  [31:0] io_in_b_Re,
  input  [31:0] io_in_b_Im,
  output [31:0] io_out_s_Re,
  output [31:0] io_out_s_Im
);
  wire  FP_subtractor_bw32_clock; // @[FPComplex.scala 112:25]
  wire  FP_subtractor_bw32_reset; // @[FPComplex.scala 112:25]
  wire  FP_subtractor_bw32_io_in_en; // @[FPComplex.scala 112:25]
  wire [31:0] FP_subtractor_bw32_io_in_a; // @[FPComplex.scala 112:25]
  wire [31:0] FP_subtractor_bw32_io_in_b; // @[FPComplex.scala 112:25]
  wire [31:0] FP_subtractor_bw32_io_out_s; // @[FPComplex.scala 112:25]
  wire  FP_subtractor_bw32_1_clock; // @[FPComplex.scala 112:25]
  wire  FP_subtractor_bw32_1_reset; // @[FPComplex.scala 112:25]
  wire  FP_subtractor_bw32_1_io_in_en; // @[FPComplex.scala 112:25]
  wire [31:0] FP_subtractor_bw32_1_io_in_a; // @[FPComplex.scala 112:25]
  wire [31:0] FP_subtractor_bw32_1_io_in_b; // @[FPComplex.scala 112:25]
  wire [31:0] FP_subtractor_bw32_1_io_out_s; // @[FPComplex.scala 112:25]
  FP_subtractor_bw32 FP_subtractor_bw32 ( // @[FPComplex.scala 112:25]
    .clock(FP_subtractor_bw32_clock),
    .reset(FP_subtractor_bw32_reset),
    .io_in_en(FP_subtractor_bw32_io_in_en),
    .io_in_a(FP_subtractor_bw32_io_in_a),
    .io_in_b(FP_subtractor_bw32_io_in_b),
    .io_out_s(FP_subtractor_bw32_io_out_s)
  );
  FP_subtractor_bw32 FP_subtractor_bw32_1 ( // @[FPComplex.scala 112:25]
    .clock(FP_subtractor_bw32_1_clock),
    .reset(FP_subtractor_bw32_1_reset),
    .io_in_en(FP_subtractor_bw32_1_io_in_en),
    .io_in_a(FP_subtractor_bw32_1_io_in_a),
    .io_in_b(FP_subtractor_bw32_1_io_in_b),
    .io_out_s(FP_subtractor_bw32_1_io_out_s)
  );
  assign io_out_s_Re = FP_subtractor_bw32_io_out_s; // @[FPComplex.scala 121:17]
  assign io_out_s_Im = FP_subtractor_bw32_1_io_out_s; // @[FPComplex.scala 122:17]
  assign FP_subtractor_bw32_clock = clock;
  assign FP_subtractor_bw32_reset = reset;
  assign FP_subtractor_bw32_io_in_en = io_in_en; // @[FPComplex.scala 115:25]
  assign FP_subtractor_bw32_io_in_a = io_in_a_Re; // @[FPComplex.scala 117:24]
  assign FP_subtractor_bw32_io_in_b = io_in_b_Re; // @[FPComplex.scala 118:24]
  assign FP_subtractor_bw32_1_clock = clock;
  assign FP_subtractor_bw32_1_reset = reset;
  assign FP_subtractor_bw32_1_io_in_en = io_in_en; // @[FPComplex.scala 116:25]
  assign FP_subtractor_bw32_1_io_in_a = io_in_a_Im; // @[FPComplex.scala 119:24]
  assign FP_subtractor_bw32_1_io_in_b = io_in_b_Im; // @[FPComplex.scala 120:24]
endmodule
module DFT_SymmetryExploits_fullwidth_r2_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input         io_in_valid,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  output [31:0] io_out_0_Re,
  output [31:0] io_out_0_Im,
  output [31:0] io_out_1_Re,
  output [31:0] io_out_1_Im,
  output        io_out_valid
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
`endif // RANDOMIZE_REG_INIT
  wire  FPComplexAdder_bw32_clock; // @[DFTDesigns.scala 70:25]
  wire  FPComplexAdder_bw32_reset; // @[DFTDesigns.scala 70:25]
  wire  FPComplexAdder_bw32_io_in_en; // @[DFTDesigns.scala 70:25]
  wire [31:0] FPComplexAdder_bw32_io_in_a_Re; // @[DFTDesigns.scala 70:25]
  wire [31:0] FPComplexAdder_bw32_io_in_a_Im; // @[DFTDesigns.scala 70:25]
  wire [31:0] FPComplexAdder_bw32_io_in_b_Re; // @[DFTDesigns.scala 70:25]
  wire [31:0] FPComplexAdder_bw32_io_in_b_Im; // @[DFTDesigns.scala 70:25]
  wire [31:0] FPComplexAdder_bw32_io_out_s_Re; // @[DFTDesigns.scala 70:25]
  wire [31:0] FPComplexAdder_bw32_io_out_s_Im; // @[DFTDesigns.scala 70:25]
  wire  FPComplexSubtractor_bw32_clock; // @[DFTDesigns.scala 71:30]
  wire  FPComplexSubtractor_bw32_reset; // @[DFTDesigns.scala 71:30]
  wire  FPComplexSubtractor_bw32_io_in_en; // @[DFTDesigns.scala 71:30]
  wire [31:0] FPComplexSubtractor_bw32_io_in_a_Re; // @[DFTDesigns.scala 71:30]
  wire [31:0] FPComplexSubtractor_bw32_io_in_a_Im; // @[DFTDesigns.scala 71:30]
  wire [31:0] FPComplexSubtractor_bw32_io_in_b_Re; // @[DFTDesigns.scala 71:30]
  wire [31:0] FPComplexSubtractor_bw32_io_in_b_Im; // @[DFTDesigns.scala 71:30]
  wire [31:0] FPComplexSubtractor_bw32_io_out_s_Re; // @[DFTDesigns.scala 71:30]
  wire [31:0] FPComplexSubtractor_bw32_io_out_s_Im; // @[DFTDesigns.scala 71:30]
  reg  shift_regs_r; // @[Reg.scala 16:16]
  reg  shift_regs_r_1; // @[Reg.scala 16:16]
  reg  shift_regs_r_2; // @[Reg.scala 16:16]
  reg  shift_regs_r_3; // @[Reg.scala 16:16]
  reg  shift_regs_r_4; // @[Reg.scala 16:16]
  reg  shift_regs_r_5; // @[Reg.scala 16:16]
  reg  shift_regs_r_6; // @[Reg.scala 16:16]
  reg  shift_regs_r_7; // @[Reg.scala 16:16]
  reg  shift_regs_r_8; // @[Reg.scala 16:16]
  reg  shift_regs_r_9; // @[Reg.scala 16:16]
  reg  shift_regs_r_10; // @[Reg.scala 16:16]
  reg  shift_regs_r_11; // @[Reg.scala 16:16]
  reg  shift_regs_r_12; // @[Reg.scala 16:16]
  reg  shift_regs; // @[Reg.scala 16:16]
  reg [31:0] sr_addout_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_addout_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_subout_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_subout_Im; // @[Reg.scala 16:16]
  FPComplexAdder_bw32 FPComplexAdder_bw32 ( // @[DFTDesigns.scala 70:25]
    .clock(FPComplexAdder_bw32_clock),
    .reset(FPComplexAdder_bw32_reset),
    .io_in_en(FPComplexAdder_bw32_io_in_en),
    .io_in_a_Re(FPComplexAdder_bw32_io_in_a_Re),
    .io_in_a_Im(FPComplexAdder_bw32_io_in_a_Im),
    .io_in_b_Re(FPComplexAdder_bw32_io_in_b_Re),
    .io_in_b_Im(FPComplexAdder_bw32_io_in_b_Im),
    .io_out_s_Re(FPComplexAdder_bw32_io_out_s_Re),
    .io_out_s_Im(FPComplexAdder_bw32_io_out_s_Im)
  );
  FPComplexSubtractor_bw32 FPComplexSubtractor_bw32 ( // @[DFTDesigns.scala 71:30]
    .clock(FPComplexSubtractor_bw32_clock),
    .reset(FPComplexSubtractor_bw32_reset),
    .io_in_en(FPComplexSubtractor_bw32_io_in_en),
    .io_in_a_Re(FPComplexSubtractor_bw32_io_in_a_Re),
    .io_in_a_Im(FPComplexSubtractor_bw32_io_in_a_Im),
    .io_in_b_Re(FPComplexSubtractor_bw32_io_in_b_Re),
    .io_in_b_Im(FPComplexSubtractor_bw32_io_in_b_Im),
    .io_out_s_Re(FPComplexSubtractor_bw32_io_out_s_Re),
    .io_out_s_Im(FPComplexSubtractor_bw32_io_out_s_Im)
  );
  assign io_out_0_Re = sr_addout_Re; // @[DFTDesigns.scala 82:17]
  assign io_out_0_Im = sr_addout_Im; // @[DFTDesigns.scala 82:17]
  assign io_out_1_Re = sr_subout_Re; // @[DFTDesigns.scala 83:17]
  assign io_out_1_Im = sr_subout_Im; // @[DFTDesigns.scala 83:17]
  assign io_out_valid = shift_regs; // @[DFTDesigns.scala 81:20]
  assign FPComplexAdder_bw32_clock = clock;
  assign FPComplexAdder_bw32_reset = reset;
  assign FPComplexAdder_bw32_io_in_en = io_in_en; // @[DFTDesigns.scala 75:19]
  assign FPComplexAdder_bw32_io_in_a_Re = io_in_0_Re; // @[DFTDesigns.scala 77:18]
  assign FPComplexAdder_bw32_io_in_a_Im = io_in_0_Im; // @[DFTDesigns.scala 77:18]
  assign FPComplexAdder_bw32_io_in_b_Re = io_in_1_Re; // @[DFTDesigns.scala 78:18]
  assign FPComplexAdder_bw32_io_in_b_Im = io_in_1_Im; // @[DFTDesigns.scala 78:18]
  assign FPComplexSubtractor_bw32_clock = clock;
  assign FPComplexSubtractor_bw32_reset = reset;
  assign FPComplexSubtractor_bw32_io_in_en = io_in_en; // @[DFTDesigns.scala 76:24]
  assign FPComplexSubtractor_bw32_io_in_a_Re = io_in_0_Re; // @[DFTDesigns.scala 79:23]
  assign FPComplexSubtractor_bw32_io_in_a_Im = io_in_0_Im; // @[DFTDesigns.scala 79:23]
  assign FPComplexSubtractor_bw32_io_in_b_Re = io_in_1_Re; // @[DFTDesigns.scala 80:23]
  assign FPComplexSubtractor_bw32_io_in_b_Im = io_in_1_Im; // @[DFTDesigns.scala 80:23]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r <= io_in_valid; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_1 <= shift_regs_r; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_2 <= shift_regs_r_1; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_3 <= shift_regs_r_2; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_4 <= shift_regs_r_3; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_5 <= shift_regs_r_4; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_6 <= shift_regs_r_5; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_7 <= shift_regs_r_6; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_8 <= shift_regs_r_7; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_9 <= shift_regs_r_8; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_10 <= shift_regs_r_9; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_11 <= shift_regs_r_10; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs_r_12 <= shift_regs_r_11; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      shift_regs <= shift_regs_r_12; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      sr_addout_Re <= FPComplexAdder_bw32_io_out_s_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      sr_addout_Im <= FPComplexAdder_bw32_io_out_s_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      sr_subout_Re <= FPComplexSubtractor_bw32_io_out_s_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      sr_subout_Im <= FPComplexSubtractor_bw32_io_out_s_Im; // @[Reg.scala 17:22]
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
  shift_regs_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  shift_regs_r_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  shift_regs_r_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  shift_regs_r_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  shift_regs_r_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  shift_regs_r_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  shift_regs_r_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  shift_regs_r_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  shift_regs_r_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  shift_regs_r_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  shift_regs_r_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  shift_regs_r_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  shift_regs_r_12 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  shift_regs = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sr_addout_Re = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  sr_addout_Im = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  sr_subout_Re = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  sr_subout_Im = _RAND_17[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RAM_n2_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input         io_in_valid,
  input  [31:0] io_in_data_Re,
  input  [31:0] io_in_data_Im,
  input         io_in_we,
  input  [1:0]  io_in_addr,
  output [31:0] io_out_data_Re,
  output [31:0] io_out_data_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem_0_Re; // @[PermutationDesigns.scala 1176:22]
  reg [31:0] mem_0_Im; // @[PermutationDesigns.scala 1176:22]
  reg [31:0] mem_1_Re; // @[PermutationDesigns.scala 1176:22]
  reg [31:0] mem_1_Im; // @[PermutationDesigns.scala 1176:22]
  wire  _out_reg_data_T_2 = io_in_en & ~io_in_we; // @[PermutationDesigns.scala 1180:67]
  reg [31:0] out_reg_data_Re; // @[Reg.scala 16:16]
  reg [31:0] out_reg_data_Im; // @[Reg.scala 16:16]
  wire [31:0] _GEN_6 = ~io_in_addr[0] ? io_in_data_Im : mem_0_Im; // @[PermutationDesigns.scala 1176:22 1187:{27,27}]
  wire [31:0] _GEN_7 = io_in_addr[0] ? io_in_data_Im : mem_1_Im; // @[PermutationDesigns.scala 1176:22 1187:{27,27}]
  wire [31:0] _GEN_8 = ~io_in_addr[0] ? io_in_data_Re : mem_0_Re; // @[PermutationDesigns.scala 1176:22 1187:{27,27}]
  wire [31:0] _GEN_9 = io_in_addr[0] ? io_in_data_Re : mem_1_Re; // @[PermutationDesigns.scala 1176:22 1187:{27,27}]
  assign io_out_data_Re = out_reg_data_Re; // @[PermutationDesigns.scala 1183:17]
  assign io_out_data_Im = out_reg_data_Im; // @[PermutationDesigns.scala 1183:17]
  always @(posedge clock) begin
    if (reset) begin // @[PermutationDesigns.scala 1176:22]
      mem_0_Re <= 32'h0; // @[PermutationDesigns.scala 1176:22]
    end else if (io_in_en) begin // @[PermutationDesigns.scala 1184:19]
      if (io_in_we) begin // @[PermutationDesigns.scala 1185:21]
        if (io_in_valid) begin // @[PermutationDesigns.scala 1186:27]
          mem_0_Re <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[PermutationDesigns.scala 1176:22]
      mem_0_Im <= 32'h0; // @[PermutationDesigns.scala 1176:22]
    end else if (io_in_en) begin // @[PermutationDesigns.scala 1184:19]
      if (io_in_we) begin // @[PermutationDesigns.scala 1185:21]
        if (io_in_valid) begin // @[PermutationDesigns.scala 1186:27]
          mem_0_Im <= _GEN_6;
        end
      end
    end
    if (reset) begin // @[PermutationDesigns.scala 1176:22]
      mem_1_Re <= 32'h0; // @[PermutationDesigns.scala 1176:22]
    end else if (io_in_en) begin // @[PermutationDesigns.scala 1184:19]
      if (io_in_we) begin // @[PermutationDesigns.scala 1185:21]
        if (io_in_valid) begin // @[PermutationDesigns.scala 1186:27]
          mem_1_Re <= _GEN_9;
        end
      end
    end
    if (reset) begin // @[PermutationDesigns.scala 1176:22]
      mem_1_Im <= 32'h0; // @[PermutationDesigns.scala 1176:22]
    end else if (io_in_en) begin // @[PermutationDesigns.scala 1184:19]
      if (io_in_we) begin // @[PermutationDesigns.scala 1185:21]
        if (io_in_valid) begin // @[PermutationDesigns.scala 1186:27]
          mem_1_Im <= _GEN_7;
        end
      end
    end
    if (_out_reg_data_T_2) begin // @[Reg.scala 17:18]
      if (io_in_addr[0]) begin // @[Reg.scala 17:22]
        out_reg_data_Re <= mem_1_Re; // @[Reg.scala 17:22]
      end else begin
        out_reg_data_Re <= mem_0_Re;
      end
    end
    if (_out_reg_data_T_2) begin // @[Reg.scala 17:18]
      if (io_in_addr[0]) begin // @[Reg.scala 17:22]
        out_reg_data_Im <= mem_1_Im; // @[Reg.scala 17:22]
      end else begin
        out_reg_data_Im <= mem_0_Im;
      end
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
  mem_0_Re = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  mem_0_Im = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  mem_1_Re = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  mem_1_Im = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  out_reg_data_Re = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  out_reg_data_Im = _RAND_5[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RAM_Block_N4_w2_bw32(
  input         clock,
  input         reset,
  input  [1:0]  io_in_raddr,
  input  [1:0]  io_in_waddr,
  input  [31:0] io_in_data_Re,
  input  [31:0] io_in_data_Im,
  input         io_in_offset_switch,
  input         io_in_valid,
  input         io_in_en,
  output [31:0] io_out_data_Re,
  output [31:0] io_out_data_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  RAM_n2_bw32_clock; // @[PermutationDesigns.scala 337:35]
  wire  RAM_n2_bw32_reset; // @[PermutationDesigns.scala 337:35]
  wire  RAM_n2_bw32_io_in_en; // @[PermutationDesigns.scala 337:35]
  wire  RAM_n2_bw32_io_in_valid; // @[PermutationDesigns.scala 337:35]
  wire [31:0] RAM_n2_bw32_io_in_data_Re; // @[PermutationDesigns.scala 337:35]
  wire [31:0] RAM_n2_bw32_io_in_data_Im; // @[PermutationDesigns.scala 337:35]
  wire  RAM_n2_bw32_io_in_we; // @[PermutationDesigns.scala 337:35]
  wire [1:0] RAM_n2_bw32_io_in_addr; // @[PermutationDesigns.scala 337:35]
  wire [31:0] RAM_n2_bw32_io_out_data_Re; // @[PermutationDesigns.scala 337:35]
  wire [31:0] RAM_n2_bw32_io_out_data_Im; // @[PermutationDesigns.scala 337:35]
  wire  RAM_n2_bw32_1_clock; // @[PermutationDesigns.scala 337:35]
  wire  RAM_n2_bw32_1_reset; // @[PermutationDesigns.scala 337:35]
  wire  RAM_n2_bw32_1_io_in_en; // @[PermutationDesigns.scala 337:35]
  wire  RAM_n2_bw32_1_io_in_valid; // @[PermutationDesigns.scala 337:35]
  wire [31:0] RAM_n2_bw32_1_io_in_data_Re; // @[PermutationDesigns.scala 337:35]
  wire [31:0] RAM_n2_bw32_1_io_in_data_Im; // @[PermutationDesigns.scala 337:35]
  wire  RAM_n2_bw32_1_io_in_we; // @[PermutationDesigns.scala 337:35]
  wire [1:0] RAM_n2_bw32_1_io_in_addr; // @[PermutationDesigns.scala 337:35]
  wire [31:0] RAM_n2_bw32_1_io_out_data_Re; // @[PermutationDesigns.scala 337:35]
  wire [31:0] RAM_n2_bw32_1_io_out_data_Im; // @[PermutationDesigns.scala 337:35]
  reg  offset_switch_reg; // @[Reg.scala 16:16]
  wire  _T_1 = ~io_in_offset_switch; // @[PermutationDesigns.scala 348:21]
  RAM_n2_bw32 RAM_n2_bw32 ( // @[PermutationDesigns.scala 337:35]
    .clock(RAM_n2_bw32_clock),
    .reset(RAM_n2_bw32_reset),
    .io_in_en(RAM_n2_bw32_io_in_en),
    .io_in_valid(RAM_n2_bw32_io_in_valid),
    .io_in_data_Re(RAM_n2_bw32_io_in_data_Re),
    .io_in_data_Im(RAM_n2_bw32_io_in_data_Im),
    .io_in_we(RAM_n2_bw32_io_in_we),
    .io_in_addr(RAM_n2_bw32_io_in_addr),
    .io_out_data_Re(RAM_n2_bw32_io_out_data_Re),
    .io_out_data_Im(RAM_n2_bw32_io_out_data_Im)
  );
  RAM_n2_bw32 RAM_n2_bw32_1 ( // @[PermutationDesigns.scala 337:35]
    .clock(RAM_n2_bw32_1_clock),
    .reset(RAM_n2_bw32_1_reset),
    .io_in_en(RAM_n2_bw32_1_io_in_en),
    .io_in_valid(RAM_n2_bw32_1_io_in_valid),
    .io_in_data_Re(RAM_n2_bw32_1_io_in_data_Re),
    .io_in_data_Im(RAM_n2_bw32_1_io_in_data_Im),
    .io_in_we(RAM_n2_bw32_1_io_in_we),
    .io_in_addr(RAM_n2_bw32_1_io_in_addr),
    .io_out_data_Re(RAM_n2_bw32_1_io_out_data_Re),
    .io_out_data_Im(RAM_n2_bw32_1_io_out_data_Im)
  );
  assign io_out_data_Re = offset_switch_reg ? RAM_n2_bw32_io_out_data_Re : RAM_n2_bw32_1_io_out_data_Re; // @[PermutationDesigns.scala 352:23]
  assign io_out_data_Im = offset_switch_reg ? RAM_n2_bw32_io_out_data_Im : RAM_n2_bw32_1_io_out_data_Im; // @[PermutationDesigns.scala 352:23]
  assign RAM_n2_bw32_clock = clock;
  assign RAM_n2_bw32_reset = reset;
  assign RAM_n2_bw32_io_in_en = io_in_en; // @[PermutationDesigns.scala 345:18]
  assign RAM_n2_bw32_io_in_valid = io_in_valid; // @[PermutationDesigns.scala 346:21]
  assign RAM_n2_bw32_io_in_data_Re = io_in_data_Re; // @[PermutationDesigns.scala 349:20]
  assign RAM_n2_bw32_io_in_data_Im = io_in_data_Im; // @[PermutationDesigns.scala 349:20]
  assign RAM_n2_bw32_io_in_we = ~io_in_offset_switch; // @[PermutationDesigns.scala 348:21]
  assign RAM_n2_bw32_io_in_addr = _T_1 ? io_in_waddr : io_in_raddr; // @[PermutationDesigns.scala 350:26]
  assign RAM_n2_bw32_1_clock = clock;
  assign RAM_n2_bw32_1_reset = reset;
  assign RAM_n2_bw32_1_io_in_en = io_in_en; // @[PermutationDesigns.scala 339:18]
  assign RAM_n2_bw32_1_io_in_valid = io_in_valid; // @[PermutationDesigns.scala 340:21]
  assign RAM_n2_bw32_1_io_in_data_Re = io_in_data_Re; // @[PermutationDesigns.scala 343:20]
  assign RAM_n2_bw32_1_io_in_data_Im = io_in_data_Im; // @[PermutationDesigns.scala 343:20]
  assign RAM_n2_bw32_1_io_in_we = io_in_offset_switch; // @[PermutationDesigns.scala 342:18]
  assign RAM_n2_bw32_1_io_in_addr = io_in_offset_switch ? io_in_waddr : io_in_raddr; // @[PermutationDesigns.scala 344:26]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      offset_switch_reg <= io_in_offset_switch; // @[Reg.scala 17:22]
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
  offset_switch_reg = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PrePermute_Config_ROM_N4_r2_base_r2_ptype1_w2(
  input   io_in_cnt,
  output  io_out_0,
  output  io_out_1
);
  assign io_out_0 = io_in_cnt; // @[PermutationDesigns.scala 253:{31,31}]
  assign io_out_1 = io_in_cnt ? 1'h0 : 1'h1; // @[PermutationDesigns.scala 253:{31,31}]
endmodule
module Permute_Config_ROM_N4_r2_base_r2_ptype1_w2(
  input   clock,
  input   io_in_en,
  input   io_in_cnt,
  output  io_out_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  out_reg_data_r; // @[Reg.scala 16:16]
  assign io_out_0 = out_reg_data_r; // @[PermutationDesigns.scala 317:{31,31}]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_reg_data_r <= io_in_cnt; // @[Reg.scala 17:22]
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
  out_reg_data_r = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Permutation_Wiring_w2_bw32(
  input         clock,
  input         io_in_valid,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  input         io_in_config_0,
  input         io_in_en,
  output        io_out_valid,
  output [31:0] io_out_0_Re,
  output [31:0] io_out_0_Im,
  output [31:0] io_out_1_Re,
  output [31:0] io_out_1_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] in_reg_0_Re; // @[Reg.scala 16:16]
  reg [31:0] in_reg_0_Im; // @[Reg.scala 16:16]
  reg [31:0] in_reg_1_Re; // @[Reg.scala 16:16]
  reg [31:0] in_reg_1_Im; // @[Reg.scala 16:16]
  reg  in_config_reg_0; // @[Reg.scala 16:16]
  reg  out_valid_reg; // @[Reg.scala 16:16]
  wire  _T = ~in_config_reg_0; // @[PermutationDesigns.scala 211:36]
  wire  pms_0 = _T ? 1'h0 : 1'h1; // @[Mux.scala 47:70]
  wire  pms_1 = in_config_reg_0 ? 1'h0 : 1'h1; // @[Mux.scala 47:70]
  assign io_out_valid = out_valid_reg; // @[PermutationDesigns.scala 223:18]
  assign io_out_0_Re = pms_0 ? in_reg_1_Re : in_reg_0_Re; // @[PermutationDesigns.scala 220:{31,31}]
  assign io_out_0_Im = pms_0 ? in_reg_1_Im : in_reg_0_Im; // @[PermutationDesigns.scala 220:{31,31}]
  assign io_out_1_Re = pms_1 ? in_reg_1_Re : in_reg_0_Re; // @[PermutationDesigns.scala 220:{31,31}]
  assign io_out_1_Im = pms_1 ? in_reg_1_Im : in_reg_0_Im; // @[PermutationDesigns.scala 220:{31,31}]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      in_reg_0_Re <= io_in_0_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      in_reg_0_Im <= io_in_0_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      in_reg_1_Re <= io_in_1_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      in_reg_1_Im <= io_in_1_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      in_config_reg_0 <= io_in_config_0; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_valid_reg <= io_in_valid; // @[Reg.scala 17:22]
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
  in_reg_0_Re = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  in_reg_0_Im = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  in_reg_1_Re = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  in_reg_1_Im = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  in_config_reg_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  out_valid_reg = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2(
  input   clock,
  input   io_in_en,
  input   io_in_cnt,
  output  io_out_0,
  output  io_out_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  out_reg_data_r; // @[Reg.scala 16:16]
  reg  out_reg_data_r_1; // @[Reg.scala 16:16]
  assign io_out_0 = out_reg_data_r; // @[PermutationDesigns.scala 285:{31,31}]
  assign io_out_1 = out_reg_data_r_1; // @[PermutationDesigns.scala 285:{31,31}]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_reg_data_r <= io_in_cnt; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      if (io_in_cnt) begin // @[Reg.scala 17:22]
        out_reg_data_r_1 <= 1'h0; // @[Reg.scala 17:22]
      end else begin
        out_reg_data_r_1 <= 1'h1;
      end
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
  out_reg_data_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  out_reg_data_r_1 = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32(
  input         clock,
  input         reset,
  input         io_in_en,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  input         io_in_valid,
  output [31:0] io_out_0_Re,
  output [31:0] io_out_0_Im,
  output [31:0] io_out_1_Re,
  output [31:0] io_out_1_Im,
  output        io_out_valid
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
`endif // RANDOMIZE_REG_INIT
  wire  RAM_Block_N4_w2_bw32_clock; // @[PermutationDesigns.scala 58:41]
  wire  RAM_Block_N4_w2_bw32_reset; // @[PermutationDesigns.scala 58:41]
  wire [1:0] RAM_Block_N4_w2_bw32_io_in_raddr; // @[PermutationDesigns.scala 58:41]
  wire [1:0] RAM_Block_N4_w2_bw32_io_in_waddr; // @[PermutationDesigns.scala 58:41]
  wire [31:0] RAM_Block_N4_w2_bw32_io_in_data_Re; // @[PermutationDesigns.scala 58:41]
  wire [31:0] RAM_Block_N4_w2_bw32_io_in_data_Im; // @[PermutationDesigns.scala 58:41]
  wire  RAM_Block_N4_w2_bw32_io_in_offset_switch; // @[PermutationDesigns.scala 58:41]
  wire  RAM_Block_N4_w2_bw32_io_in_valid; // @[PermutationDesigns.scala 58:41]
  wire  RAM_Block_N4_w2_bw32_io_in_en; // @[PermutationDesigns.scala 58:41]
  wire [31:0] RAM_Block_N4_w2_bw32_io_out_data_Re; // @[PermutationDesigns.scala 58:41]
  wire [31:0] RAM_Block_N4_w2_bw32_io_out_data_Im; // @[PermutationDesigns.scala 58:41]
  wire  RAM_Block_N4_w2_bw32_1_clock; // @[PermutationDesigns.scala 58:41]
  wire  RAM_Block_N4_w2_bw32_1_reset; // @[PermutationDesigns.scala 58:41]
  wire [1:0] RAM_Block_N4_w2_bw32_1_io_in_raddr; // @[PermutationDesigns.scala 58:41]
  wire [1:0] RAM_Block_N4_w2_bw32_1_io_in_waddr; // @[PermutationDesigns.scala 58:41]
  wire [31:0] RAM_Block_N4_w2_bw32_1_io_in_data_Re; // @[PermutationDesigns.scala 58:41]
  wire [31:0] RAM_Block_N4_w2_bw32_1_io_in_data_Im; // @[PermutationDesigns.scala 58:41]
  wire  RAM_Block_N4_w2_bw32_1_io_in_offset_switch; // @[PermutationDesigns.scala 58:41]
  wire  RAM_Block_N4_w2_bw32_1_io_in_valid; // @[PermutationDesigns.scala 58:41]
  wire  RAM_Block_N4_w2_bw32_1_io_in_en; // @[PermutationDesigns.scala 58:41]
  wire [31:0] RAM_Block_N4_w2_bw32_1_io_out_data_Re; // @[PermutationDesigns.scala 58:41]
  wire [31:0] RAM_Block_N4_w2_bw32_1_io_out_data_Im; // @[PermutationDesigns.scala 58:41]
  wire  PrePermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_cnt; // @[PermutationDesigns.scala 60:25]
  wire  PrePermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_0; // @[PermutationDesigns.scala 60:25]
  wire  PrePermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_1; // @[PermutationDesigns.scala 60:25]
  wire  Permute_Config_ROM_N4_r2_base_r2_ptype1_w2_clock; // @[PermutationDesigns.scala 63:22]
  wire  Permute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_en; // @[PermutationDesigns.scala 63:22]
  wire  Permute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_cnt; // @[PermutationDesigns.scala 63:22]
  wire  Permute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_0; // @[PermutationDesigns.scala 63:22]
  wire  Permutation_Wiring_w2_bw32_clock; // @[PermutationDesigns.scala 64:24]
  wire  Permutation_Wiring_w2_bw32_io_in_valid; // @[PermutationDesigns.scala 64:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_in_0_Re; // @[PermutationDesigns.scala 64:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_in_0_Im; // @[PermutationDesigns.scala 64:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_in_1_Re; // @[PermutationDesigns.scala 64:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_in_1_Im; // @[PermutationDesigns.scala 64:24]
  wire  Permutation_Wiring_w2_bw32_io_in_config_0; // @[PermutationDesigns.scala 64:24]
  wire  Permutation_Wiring_w2_bw32_io_in_en; // @[PermutationDesigns.scala 64:24]
  wire  Permutation_Wiring_w2_bw32_io_out_valid; // @[PermutationDesigns.scala 64:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_out_0_Re; // @[PermutationDesigns.scala 64:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_out_0_Im; // @[PermutationDesigns.scala 64:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_out_1_Re; // @[PermutationDesigns.scala 64:24]
  wire [31:0] Permutation_Wiring_w2_bw32_io_out_1_Im; // @[PermutationDesigns.scala 64:24]
  wire  PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_clock; // @[PermutationDesigns.scala 70:26]
  wire  PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_en; // @[PermutationDesigns.scala 70:26]
  wire  PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_cnt; // @[PermutationDesigns.scala 70:26]
  wire  PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_0; // @[PermutationDesigns.scala 70:26]
  wire  PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_1; // @[PermutationDesigns.scala 70:26]
  wire  RAM_Block_N4_w2_bw32_2_clock; // @[PermutationDesigns.scala 71:41]
  wire  RAM_Block_N4_w2_bw32_2_reset; // @[PermutationDesigns.scala 71:41]
  wire [1:0] RAM_Block_N4_w2_bw32_2_io_in_raddr; // @[PermutationDesigns.scala 71:41]
  wire [1:0] RAM_Block_N4_w2_bw32_2_io_in_waddr; // @[PermutationDesigns.scala 71:41]
  wire [31:0] RAM_Block_N4_w2_bw32_2_io_in_data_Re; // @[PermutationDesigns.scala 71:41]
  wire [31:0] RAM_Block_N4_w2_bw32_2_io_in_data_Im; // @[PermutationDesigns.scala 71:41]
  wire  RAM_Block_N4_w2_bw32_2_io_in_offset_switch; // @[PermutationDesigns.scala 71:41]
  wire  RAM_Block_N4_w2_bw32_2_io_in_valid; // @[PermutationDesigns.scala 71:41]
  wire  RAM_Block_N4_w2_bw32_2_io_in_en; // @[PermutationDesigns.scala 71:41]
  wire [31:0] RAM_Block_N4_w2_bw32_2_io_out_data_Re; // @[PermutationDesigns.scala 71:41]
  wire [31:0] RAM_Block_N4_w2_bw32_2_io_out_data_Im; // @[PermutationDesigns.scala 71:41]
  wire  RAM_Block_N4_w2_bw32_3_clock; // @[PermutationDesigns.scala 71:41]
  wire  RAM_Block_N4_w2_bw32_3_reset; // @[PermutationDesigns.scala 71:41]
  wire [1:0] RAM_Block_N4_w2_bw32_3_io_in_raddr; // @[PermutationDesigns.scala 71:41]
  wire [1:0] RAM_Block_N4_w2_bw32_3_io_in_waddr; // @[PermutationDesigns.scala 71:41]
  wire [31:0] RAM_Block_N4_w2_bw32_3_io_in_data_Re; // @[PermutationDesigns.scala 71:41]
  wire [31:0] RAM_Block_N4_w2_bw32_3_io_in_data_Im; // @[PermutationDesigns.scala 71:41]
  wire  RAM_Block_N4_w2_bw32_3_io_in_offset_switch; // @[PermutationDesigns.scala 71:41]
  wire  RAM_Block_N4_w2_bw32_3_io_in_valid; // @[PermutationDesigns.scala 71:41]
  wire  RAM_Block_N4_w2_bw32_3_io_in_en; // @[PermutationDesigns.scala 71:41]
  wire [31:0] RAM_Block_N4_w2_bw32_3_io_out_data_Re; // @[PermutationDesigns.scala 71:41]
  wire [31:0] RAM_Block_N4_w2_bw32_3_io_out_data_Im; // @[PermutationDesigns.scala 71:41]
  reg [31:0] Perm_shiftregs_data_r_Re; // @[Reg.scala 16:16]
  reg [31:0] Perm_shiftregs_data_r_Im; // @[Reg.scala 16:16]
  reg [31:0] Perm_shiftregs_data_r_1_Re; // @[Reg.scala 16:16]
  reg [31:0] Perm_shiftregs_data_r_1_Im; // @[Reg.scala 16:16]
  reg  Perm_shiftregs_valid; // @[Reg.scala 16:16]
  reg  REG; // @[PermutationDesigns.scala 73:47]
  reg  REG_1; // @[PermutationDesigns.scala 73:47]
  reg  value; // @[Counter.scala 62:40]
  reg  value_1; // @[Counter.scala 62:40]
  reg [1:0] value_2; // @[Counter.scala 62:40]
  reg [1:0] value_3; // @[Counter.scala 62:40]
  wire  _T_1 = REG & value_2 == 2'h0; // @[PermutationDesigns.scala 77:39]
  reg  r; // @[Reg.scala 16:16]
  wire  _T_3 = REG_1 & value_3 == 2'h0; // @[PermutationDesigns.scala 77:39]
  reg  r_1; // @[Reg.scala 16:16]
  reg [31:0] M0_shiftregs_data_r_Re; // @[Reg.scala 16:16]
  reg [31:0] M0_shiftregs_data_r_Im; // @[Reg.scala 16:16]
  reg [31:0] M0_shiftregs_data_r_1_Re; // @[Reg.scala 16:16]
  reg [31:0] M0_shiftregs_data_r_1_Im; // @[Reg.scala 16:16]
  reg  M0_shiftregs_valid; // @[Reg.scala 16:16]
  reg  value_4; // @[Counter.scala 62:40]
  reg  value_5; // @[Counter.scala 62:40]
  reg  value_6; // @[Counter.scala 62:40]
  reg  value_7; // @[Counter.scala 62:40]
  reg  value_9; // @[Counter.scala 62:40]
  reg  PostPC_fullcnt_reg; // @[Reg.scala 16:16]
  reg  PostPC_swtchcnt_reg; // @[Reg.scala 16:16]
  wire  _T_4 = io_in_en & io_in_valid; // @[PermutationDesigns.scala 92:21]
  wire  _GEN_15 = value_4 | REG; // @[PermutationDesigns.scala 94:45 96:27 73:47]
  wire  _GEN_18 = io_in_en & io_in_valid ? _GEN_15 : REG; // @[PermutationDesigns.scala 92:35 73:47]
  wire  _T_10 = io_in_en & Perm_shiftregs_valid; // @[PermutationDesigns.scala 112:21]
  wire  _GEN_25 = PostPC_fullcnt_reg | REG_1; // @[PermutationDesigns.scala 113:47 114:27 73:47]
  wire  _GEN_26 = io_in_en & Perm_shiftregs_valid ? _GEN_25 : REG_1; // @[PermutationDesigns.scala 112:44 73:47]
  wire  wrap_6 = value_2 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_13 = value_2 + 2'h1; // @[Counter.scala 78:24]
  wire  _T_16 = _T_4 & value_4; // @[PermutationDesigns.scala 125:45]
  wire  wrap_8 = value_3 == 2'h3; // @[Counter.scala 74:24]
  wire [1:0] _value_T_17 = value_3 + 2'h1; // @[Counter.scala 78:24]
  wire  _T_21 = _T_10 & PostPC_fullcnt_reg; // @[PermutationDesigns.scala 131:54]
  reg  out_valid_sr_1; // @[Reg.scala 16:16]
  reg [31:0] out_data_sr_r_2_Re; // @[Reg.scala 16:16]
  reg [31:0] out_data_sr_r_2_Im; // @[Reg.scala 16:16]
  reg [31:0] out_data_sr_r_3_Re; // @[Reg.scala 16:16]
  reg [31:0] out_data_sr_r_3_Im; // @[Reg.scala 16:16]
  RAM_Block_N4_w2_bw32 RAM_Block_N4_w2_bw32 ( // @[PermutationDesigns.scala 58:41]
    .clock(RAM_Block_N4_w2_bw32_clock),
    .reset(RAM_Block_N4_w2_bw32_reset),
    .io_in_raddr(RAM_Block_N4_w2_bw32_io_in_raddr),
    .io_in_waddr(RAM_Block_N4_w2_bw32_io_in_waddr),
    .io_in_data_Re(RAM_Block_N4_w2_bw32_io_in_data_Re),
    .io_in_data_Im(RAM_Block_N4_w2_bw32_io_in_data_Im),
    .io_in_offset_switch(RAM_Block_N4_w2_bw32_io_in_offset_switch),
    .io_in_valid(RAM_Block_N4_w2_bw32_io_in_valid),
    .io_in_en(RAM_Block_N4_w2_bw32_io_in_en),
    .io_out_data_Re(RAM_Block_N4_w2_bw32_io_out_data_Re),
    .io_out_data_Im(RAM_Block_N4_w2_bw32_io_out_data_Im)
  );
  RAM_Block_N4_w2_bw32 RAM_Block_N4_w2_bw32_1 ( // @[PermutationDesigns.scala 58:41]
    .clock(RAM_Block_N4_w2_bw32_1_clock),
    .reset(RAM_Block_N4_w2_bw32_1_reset),
    .io_in_raddr(RAM_Block_N4_w2_bw32_1_io_in_raddr),
    .io_in_waddr(RAM_Block_N4_w2_bw32_1_io_in_waddr),
    .io_in_data_Re(RAM_Block_N4_w2_bw32_1_io_in_data_Re),
    .io_in_data_Im(RAM_Block_N4_w2_bw32_1_io_in_data_Im),
    .io_in_offset_switch(RAM_Block_N4_w2_bw32_1_io_in_offset_switch),
    .io_in_valid(RAM_Block_N4_w2_bw32_1_io_in_valid),
    .io_in_en(RAM_Block_N4_w2_bw32_1_io_in_en),
    .io_out_data_Re(RAM_Block_N4_w2_bw32_1_io_out_data_Re),
    .io_out_data_Im(RAM_Block_N4_w2_bw32_1_io_out_data_Im)
  );
  PrePermute_Config_ROM_N4_r2_base_r2_ptype1_w2 PrePermute_Config_ROM_N4_r2_base_r2_ptype1_w2 ( // @[PermutationDesigns.scala 60:25]
    .io_in_cnt(PrePermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_cnt),
    .io_out_0(PrePermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_0),
    .io_out_1(PrePermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_1)
  );
  Permute_Config_ROM_N4_r2_base_r2_ptype1_w2 Permute_Config_ROM_N4_r2_base_r2_ptype1_w2 ( // @[PermutationDesigns.scala 63:22]
    .clock(Permute_Config_ROM_N4_r2_base_r2_ptype1_w2_clock),
    .io_in_en(Permute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_en),
    .io_in_cnt(Permute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_cnt),
    .io_out_0(Permute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_0)
  );
  Permutation_Wiring_w2_bw32 Permutation_Wiring_w2_bw32 ( // @[PermutationDesigns.scala 64:24]
    .clock(Permutation_Wiring_w2_bw32_clock),
    .io_in_valid(Permutation_Wiring_w2_bw32_io_in_valid),
    .io_in_0_Re(Permutation_Wiring_w2_bw32_io_in_0_Re),
    .io_in_0_Im(Permutation_Wiring_w2_bw32_io_in_0_Im),
    .io_in_1_Re(Permutation_Wiring_w2_bw32_io_in_1_Re),
    .io_in_1_Im(Permutation_Wiring_w2_bw32_io_in_1_Im),
    .io_in_config_0(Permutation_Wiring_w2_bw32_io_in_config_0),
    .io_in_en(Permutation_Wiring_w2_bw32_io_in_en),
    .io_out_valid(Permutation_Wiring_w2_bw32_io_out_valid),
    .io_out_0_Re(Permutation_Wiring_w2_bw32_io_out_0_Re),
    .io_out_0_Im(Permutation_Wiring_w2_bw32_io_out_0_Im),
    .io_out_1_Re(Permutation_Wiring_w2_bw32_io_out_1_Re),
    .io_out_1_Im(Permutation_Wiring_w2_bw32_io_out_1_Im)
  );
  PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2 PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2 ( // @[PermutationDesigns.scala 70:26]
    .clock(PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_clock),
    .io_in_en(PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_en),
    .io_in_cnt(PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_cnt),
    .io_out_0(PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_0),
    .io_out_1(PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_1)
  );
  RAM_Block_N4_w2_bw32 RAM_Block_N4_w2_bw32_2 ( // @[PermutationDesigns.scala 71:41]
    .clock(RAM_Block_N4_w2_bw32_2_clock),
    .reset(RAM_Block_N4_w2_bw32_2_reset),
    .io_in_raddr(RAM_Block_N4_w2_bw32_2_io_in_raddr),
    .io_in_waddr(RAM_Block_N4_w2_bw32_2_io_in_waddr),
    .io_in_data_Re(RAM_Block_N4_w2_bw32_2_io_in_data_Re),
    .io_in_data_Im(RAM_Block_N4_w2_bw32_2_io_in_data_Im),
    .io_in_offset_switch(RAM_Block_N4_w2_bw32_2_io_in_offset_switch),
    .io_in_valid(RAM_Block_N4_w2_bw32_2_io_in_valid),
    .io_in_en(RAM_Block_N4_w2_bw32_2_io_in_en),
    .io_out_data_Re(RAM_Block_N4_w2_bw32_2_io_out_data_Re),
    .io_out_data_Im(RAM_Block_N4_w2_bw32_2_io_out_data_Im)
  );
  RAM_Block_N4_w2_bw32 RAM_Block_N4_w2_bw32_3 ( // @[PermutationDesigns.scala 71:41]
    .clock(RAM_Block_N4_w2_bw32_3_clock),
    .reset(RAM_Block_N4_w2_bw32_3_reset),
    .io_in_raddr(RAM_Block_N4_w2_bw32_3_io_in_raddr),
    .io_in_waddr(RAM_Block_N4_w2_bw32_3_io_in_waddr),
    .io_in_data_Re(RAM_Block_N4_w2_bw32_3_io_in_data_Re),
    .io_in_data_Im(RAM_Block_N4_w2_bw32_3_io_in_data_Im),
    .io_in_offset_switch(RAM_Block_N4_w2_bw32_3_io_in_offset_switch),
    .io_in_valid(RAM_Block_N4_w2_bw32_3_io_in_valid),
    .io_in_en(RAM_Block_N4_w2_bw32_3_io_in_en),
    .io_out_data_Re(RAM_Block_N4_w2_bw32_3_io_out_data_Re),
    .io_out_data_Im(RAM_Block_N4_w2_bw32_3_io_out_data_Im)
  );
  assign io_out_0_Re = out_data_sr_r_2_Re; // @[PermutationDesigns.scala 179:{34,34}]
  assign io_out_0_Im = out_data_sr_r_2_Im; // @[PermutationDesigns.scala 179:{34,34}]
  assign io_out_1_Re = out_data_sr_r_3_Re; // @[PermutationDesigns.scala 179:{34,34}]
  assign io_out_1_Im = out_data_sr_r_3_Im; // @[PermutationDesigns.scala 179:{34,34}]
  assign io_out_valid = out_valid_sr_1; // @[PermutationDesigns.scala 183:22]
  assign RAM_Block_N4_w2_bw32_clock = clock;
  assign RAM_Block_N4_w2_bw32_reset = reset;
  assign RAM_Block_N4_w2_bw32_io_in_raddr = {{1'd0}, PrePermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_0}; // @[PermutationDesigns.scala 161:24]
  assign RAM_Block_N4_w2_bw32_io_in_waddr = {{1'd0}, value_4}; // @[PermutationDesigns.scala 159:24]
  assign RAM_Block_N4_w2_bw32_io_in_data_Re = io_in_0_Re; // @[PermutationDesigns.scala 157:23]
  assign RAM_Block_N4_w2_bw32_io_in_data_Im = io_in_0_Im; // @[PermutationDesigns.scala 157:23]
  assign RAM_Block_N4_w2_bw32_io_in_offset_switch = value_7; // @[PermutationDesigns.scala 162:53]
  assign RAM_Block_N4_w2_bw32_io_in_valid = io_in_valid; // @[PermutationDesigns.scala 158:24]
  assign RAM_Block_N4_w2_bw32_io_in_en = io_in_en; // @[PermutationDesigns.scala 156:21]
  assign RAM_Block_N4_w2_bw32_1_clock = clock;
  assign RAM_Block_N4_w2_bw32_1_reset = reset;
  assign RAM_Block_N4_w2_bw32_1_io_in_raddr = {{1'd0}, PrePermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_1}; // @[PermutationDesigns.scala 161:24]
  assign RAM_Block_N4_w2_bw32_1_io_in_waddr = {{1'd0}, value_4}; // @[PermutationDesigns.scala 159:24]
  assign RAM_Block_N4_w2_bw32_1_io_in_data_Re = io_in_1_Re; // @[PermutationDesigns.scala 157:23]
  assign RAM_Block_N4_w2_bw32_1_io_in_data_Im = io_in_1_Im; // @[PermutationDesigns.scala 157:23]
  assign RAM_Block_N4_w2_bw32_1_io_in_offset_switch = value_7; // @[PermutationDesigns.scala 162:53]
  assign RAM_Block_N4_w2_bw32_1_io_in_valid = io_in_valid; // @[PermutationDesigns.scala 158:24]
  assign RAM_Block_N4_w2_bw32_1_io_in_en = io_in_en; // @[PermutationDesigns.scala 156:21]
  assign PrePermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_cnt = value; // @[PermutationDesigns.scala 145:20]
  assign Permute_Config_ROM_N4_r2_base_r2_ptype1_w2_clock = clock;
  assign Permute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_en = io_in_en; // @[PermutationDesigns.scala 147:16]
  assign Permute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_cnt = value_5; // @[PermutationDesigns.scala 150:17]
  assign Permutation_Wiring_w2_bw32_clock = clock;
  assign Permutation_Wiring_w2_bw32_io_in_valid = M0_shiftregs_valid; // @[PermutationDesigns.scala 166:23]
  assign Permutation_Wiring_w2_bw32_io_in_0_Re = M0_shiftregs_data_r_Re; // @[PermutationDesigns.scala 79:{38,38}]
  assign Permutation_Wiring_w2_bw32_io_in_0_Im = M0_shiftregs_data_r_Im; // @[PermutationDesigns.scala 79:{38,38}]
  assign Permutation_Wiring_w2_bw32_io_in_1_Re = M0_shiftregs_data_r_1_Re; // @[PermutationDesigns.scala 79:{38,38}]
  assign Permutation_Wiring_w2_bw32_io_in_1_Im = M0_shiftregs_data_r_1_Im; // @[PermutationDesigns.scala 79:{38,38}]
  assign Permutation_Wiring_w2_bw32_io_in_config_0 = Permute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_0; // @[PermutationDesigns.scala 167:27]
  assign Permutation_Wiring_w2_bw32_io_in_en = io_in_en; // @[PermutationDesigns.scala 164:20]
  assign PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_clock = clock;
  assign PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_en = io_in_en; // @[PermutationDesigns.scala 151:20]
  assign PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_in_cnt = value_6; // @[PermutationDesigns.scala 153:21]
  assign RAM_Block_N4_w2_bw32_2_clock = clock;
  assign RAM_Block_N4_w2_bw32_2_reset = reset;
  assign RAM_Block_N4_w2_bw32_2_io_in_raddr = {{1'd0}, value_1}; // @[PermutationDesigns.scala 174:24]
  assign RAM_Block_N4_w2_bw32_2_io_in_waddr = {{1'd0}, PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_0}; // @[PermutationDesigns.scala 173:24]
  assign RAM_Block_N4_w2_bw32_2_io_in_data_Re = Perm_shiftregs_data_r_Re; // @[PermutationDesigns.scala 65:{40,40}]
  assign RAM_Block_N4_w2_bw32_2_io_in_data_Im = Perm_shiftregs_data_r_Im; // @[PermutationDesigns.scala 65:{40,40}]
  assign RAM_Block_N4_w2_bw32_2_io_in_offset_switch = PostPC_swtchcnt_reg; // @[PermutationDesigns.scala 175:32]
  assign RAM_Block_N4_w2_bw32_2_io_in_valid = Perm_shiftregs_valid; // @[PermutationDesigns.scala 172:24]
  assign RAM_Block_N4_w2_bw32_2_io_in_en = io_in_en; // @[PermutationDesigns.scala 169:21]
  assign RAM_Block_N4_w2_bw32_3_clock = clock;
  assign RAM_Block_N4_w2_bw32_3_reset = reset;
  assign RAM_Block_N4_w2_bw32_3_io_in_raddr = {{1'd0}, value_1}; // @[PermutationDesigns.scala 174:24]
  assign RAM_Block_N4_w2_bw32_3_io_in_waddr = {{1'd0}, PostPermute_Config_ROM_N4_r2_base_r2_ptype1_w2_io_out_1}; // @[PermutationDesigns.scala 173:24]
  assign RAM_Block_N4_w2_bw32_3_io_in_data_Re = Perm_shiftregs_data_r_1_Re; // @[PermutationDesigns.scala 65:{40,40}]
  assign RAM_Block_N4_w2_bw32_3_io_in_data_Im = Perm_shiftregs_data_r_1_Im; // @[PermutationDesigns.scala 65:{40,40}]
  assign RAM_Block_N4_w2_bw32_3_io_in_offset_switch = PostPC_swtchcnt_reg; // @[PermutationDesigns.scala 175:32]
  assign RAM_Block_N4_w2_bw32_3_io_in_valid = Perm_shiftregs_valid; // @[PermutationDesigns.scala 172:24]
  assign RAM_Block_N4_w2_bw32_3_io_in_en = io_in_en; // @[PermutationDesigns.scala 169:21]
  always @(posedge clock) begin
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_data_r_Re <= Permutation_Wiring_w2_bw32_io_out_0_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_data_r_Im <= Permutation_Wiring_w2_bw32_io_out_0_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_data_r_1_Re <= Permutation_Wiring_w2_bw32_io_out_1_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_data_r_1_Im <= Permutation_Wiring_w2_bw32_io_out_1_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      Perm_shiftregs_valid <= Permutation_Wiring_w2_bw32_io_out_valid; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[PermutationDesigns.scala 73:47]
      REG <= 1'h0; // @[PermutationDesigns.scala 73:47]
    end else if (REG) begin // @[PermutationDesigns.scala 119:30]
      if (wrap_6) begin // @[PermutationDesigns.scala 121:56]
        if (value) begin // @[PermutationDesigns.scala 123:52]
          REG <= _T_16;
        end else begin
          REG <= _GEN_18;
        end
      end else begin
        REG <= _GEN_18;
      end
    end else begin
      REG <= _GEN_18;
    end
    if (reset) begin // @[PermutationDesigns.scala 73:47]
      REG_1 <= 1'h0; // @[PermutationDesigns.scala 73:47]
    end else if (REG_1) begin // @[PermutationDesigns.scala 119:30]
      if (wrap_8) begin // @[PermutationDesigns.scala 121:56]
        if (value_1) begin // @[PermutationDesigns.scala 123:52]
          REG_1 <= _T_21;
        end else begin
          REG_1 <= _GEN_26;
        end
      end else begin
        REG_1 <= _GEN_26;
      end
    end else begin
      REG_1 <= _GEN_26;
    end
    if (reset) begin // @[Counter.scala 62:40]
      value <= 1'h0; // @[Counter.scala 62:40]
    end else if (REG) begin // @[PermutationDesigns.scala 119:30]
      if (wrap_6) begin // @[PermutationDesigns.scala 121:56]
        value <= value + 1'h1; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_1 <= 1'h0; // @[Counter.scala 62:40]
    end else if (REG_1) begin // @[PermutationDesigns.scala 119:30]
      if (wrap_8) begin // @[PermutationDesigns.scala 121:56]
        value_1 <= value_1 + 1'h1; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_2 <= 2'h0; // @[Counter.scala 62:40]
    end else if (REG) begin // @[PermutationDesigns.scala 119:30]
      value_2 <= _value_T_13; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_3 <= 2'h0; // @[Counter.scala 62:40]
    end else if (REG_1) begin // @[PermutationDesigns.scala 119:30]
      value_3 <= _value_T_17; // @[Counter.scala 78:15]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      r <= _T_1; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      r_1 <= _T_3; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_data_r_Re <= RAM_Block_N4_w2_bw32_io_out_data_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_data_r_Im <= RAM_Block_N4_w2_bw32_io_out_data_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_data_r_1_Re <= RAM_Block_N4_w2_bw32_1_io_out_data_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_data_r_1_Im <= RAM_Block_N4_w2_bw32_1_io_out_data_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      M0_shiftregs_valid <= r; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_4 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & io_in_valid) begin // @[PermutationDesigns.scala 92:35]
      value_4 <= value_4 + 1'h1; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_5 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & r) begin // @[PermutationDesigns.scala 100:40]
      value_5 <= value_5 + 1'h1; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_6 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & Permutation_Wiring_w2_bw32_io_out_valid) begin // @[PermutationDesigns.scala 106:38]
      value_6 <= value_6 + 1'h1; // @[Counter.scala 78:15]
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_7 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & io_in_valid) begin // @[PermutationDesigns.scala 92:35]
      if (value_4) begin // @[PermutationDesigns.scala 94:45]
        value_7 <= value_7 + 1'h1; // @[Counter.scala 78:15]
      end
    end
    if (reset) begin // @[Counter.scala 62:40]
      value_9 <= 1'h0; // @[Counter.scala 62:40]
    end else if (io_in_en & Permutation_Wiring_w2_bw32_io_out_valid) begin // @[PermutationDesigns.scala 106:38]
      if (value_6) begin // @[PermutationDesigns.scala 108:45]
        value_9 <= value_9 + 1'h1; // @[Counter.scala 78:15]
      end
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      PostPC_fullcnt_reg <= value_6; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      PostPC_swtchcnt_reg <= value_9; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_valid_sr_1 <= r_1; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_data_sr_r_2_Re <= RAM_Block_N4_w2_bw32_2_io_out_data_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_data_sr_r_2_Im <= RAM_Block_N4_w2_bw32_2_io_out_data_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_data_sr_r_3_Re <= RAM_Block_N4_w2_bw32_3_io_out_data_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en) begin // @[Reg.scala 17:18]
      out_data_sr_r_3_Im <= RAM_Block_N4_w2_bw32_3_io_out_data_Im; // @[Reg.scala 17:22]
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
  Perm_shiftregs_data_r_Re = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  Perm_shiftregs_data_r_Im = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  Perm_shiftregs_data_r_1_Re = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  Perm_shiftregs_data_r_1_Im = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  Perm_shiftregs_valid = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  REG = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  REG_1 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  value = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  value_1 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  value_2 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  value_3 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  r = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  r_1 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  M0_shiftregs_data_r_Re = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  M0_shiftregs_data_r_Im = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  M0_shiftregs_data_r_1_Re = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  M0_shiftregs_data_r_1_Im = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  M0_shiftregs_valid = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  value_4 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  value_5 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  value_6 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  value_7 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  value_9 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  PostPC_fullcnt_reg = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  PostPC_swtchcnt_reg = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  out_valid_sr_1 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  out_data_sr_r_2_Re = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  out_data_sr_r_2_Im = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  out_data_sr_r_3_Re = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  out_data_sr_r_3_Im = _RAND_29[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32(
  input         io_in_inv,
  input  [1:0]  io_in_addr,
  output [31:0] io_out_data_1_Re,
  output [31:0] io_out_data_1_Im
);
  wire [31:0] _GEN_5 = io_in_addr[0] ? 32'h3f0a5140 : 32'h3f800000; // @[TwidFactorDesigns.scala 65:{27,27}]
  wire [31:0] _GEN_7 = io_in_addr[0] ? 32'h3f576aa4 : 32'h0; // @[TwidFactorDesigns.scala 66:{27,27}]
  wire [31:0] _GEN_13 = io_in_addr[0] ? 32'h248d3131 : 32'h3f800000; // @[TwidFactorDesigns.scala 70:{27,27}]
  wire [31:0] _GEN_15 = io_in_addr[0] ? 32'hbf800000 : 32'h80800000; // @[TwidFactorDesigns.scala 71:{27,27}]
  assign io_out_data_1_Re = io_in_inv ? _GEN_5 : _GEN_13; // @[TwidFactorDesigns.scala 63:21 65:27 70:27]
  assign io_out_data_1_Im = io_in_inv ? _GEN_7 : _GEN_15; // @[TwidFactorDesigns.scala 63:21 66:27 71:27]
endmodule
module FPComplexScale_NonFPMult_bw32(
  input         clock,
  input         reset,
  input  [31:0] io_in_Re,
  input  [31:0] io_in_Im,
  input         io_in_en,
  input         io_is_neg,
  input         io_is_flip,
  output [31:0] io_out_Re,
  output [31:0] io_out_Im
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  sign_0 = io_in_Re[31]; // @[FPComplex.scala 738:24]
  wire  sign_1 = io_in_Im[31]; // @[FPComplex.scala 739:24]
  wire [7:0] exp_0 = io_in_Re[30:23]; // @[FPComplex.scala 741:23]
  wire [7:0] exp_1 = io_in_Im[30:23]; // @[FPComplex.scala 742:23]
  wire [22:0] frac_0 = io_in_Re[22:0]; // @[FPComplex.scala 744:24]
  wire [22:0] frac_1 = io_in_Im[22:0]; // @[FPComplex.scala 745:24]
  wire  new_sign_0 = io_is_neg ? ~sign_0 : sign_0; // @[FPComplex.scala 747:21 748:19 751:19]
  wire  new_sign_1 = io_is_neg ? ~sign_1 : sign_1; // @[FPComplex.scala 747:21 749:19 752:19]
  wire [7:0] _new_exp_0_T_1 = exp_0 - 8'h0; // @[FPComplex.scala 756:28]
  wire [7:0] new_exp_0 = exp_0 != 8'h0 ? _new_exp_0_T_1 : exp_0; // @[FPComplex.scala 755:26 756:18 758:18]
  wire [7:0] _new_exp_1_T_1 = exp_1 - 8'h0; // @[FPComplex.scala 761:28]
  wire [7:0] new_exp_1 = exp_1 != 8'h0 ? _new_exp_1_T_1 : exp_1; // @[FPComplex.scala 760:26 761:18 763:18]
  reg [31:0] out_reg_save_Re; // @[FPComplex.scala 766:31]
  reg [31:0] out_reg_save_Im; // @[FPComplex.scala 766:31]
  wire  _io_out_Re_T = ~new_sign_1; // @[FPComplex.scala 769:23]
  wire [31:0] _io_out_Re_T_2 = {_io_out_Re_T,new_exp_1,frac_1}; // @[FPComplex.scala 769:51]
  wire [31:0] _io_out_Im_T_1 = {new_sign_0,new_exp_0,frac_0}; // @[FPComplex.scala 770:50]
  wire [31:0] _GEN_4 = io_in_en ? _io_out_Re_T_2 : out_reg_save_Re; // @[FPComplex.scala 768:22 769:19 774:19]
  wire [31:0] _GEN_5 = io_in_en ? _io_out_Im_T_1 : out_reg_save_Im; // @[FPComplex.scala 768:22 770:19 775:19]
  wire [31:0] _io_out_Im_T_3 = {new_sign_1,new_exp_1,frac_1}; // @[FPComplex.scala 780:50]
  wire [31:0] _GEN_8 = io_in_en ? _io_out_Im_T_1 : out_reg_save_Re; // @[FPComplex.scala 778:22 779:19 784:19]
  wire [31:0] _GEN_9 = io_in_en ? _io_out_Im_T_3 : out_reg_save_Im; // @[FPComplex.scala 778:22 780:19 785:19]
  assign io_out_Re = io_is_flip ? _GEN_4 : _GEN_8; // @[FPComplex.scala 767:22]
  assign io_out_Im = io_is_flip ? _GEN_5 : _GEN_9; // @[FPComplex.scala 767:22]
  always @(posedge clock) begin
    if (reset) begin // @[FPComplex.scala 766:31]
      out_reg_save_Re <= 32'h0; // @[FPComplex.scala 766:31]
    end else if (io_is_flip) begin // @[FPComplex.scala 767:22]
      if (io_in_en) begin // @[FPComplex.scala 768:22]
        out_reg_save_Re <= _io_out_Re_T_2; // @[FPComplex.scala 769:19]
      end
    end else if (io_in_en) begin // @[FPComplex.scala 778:22]
      out_reg_save_Re <= _io_out_Im_T_1; // @[FPComplex.scala 779:19]
    end
    if (reset) begin // @[FPComplex.scala 766:31]
      out_reg_save_Im <= 32'h0; // @[FPComplex.scala 766:31]
    end else if (io_is_flip) begin // @[FPComplex.scala 767:22]
      if (io_in_en) begin // @[FPComplex.scala 768:22]
        out_reg_save_Im <= _io_out_Im_T_1; // @[FPComplex.scala 770:19]
      end
    end else if (io_in_en) begin // @[FPComplex.scala 778:22]
      out_reg_save_Im <= _io_out_Im_T_3; // @[FPComplex.scala 780:19]
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
  out_reg_save_Re = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  out_reg_save_Im = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32(
  input         clock,
  input         reset,
  input         io_in_inv,
  input         io_in_en_main,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  input         io_in_valid,
  output        io_out_valid,
  output [31:0] io_out_0_Re,
  output [31:0] io_out_0_Im,
  output [31:0] io_out_1_Re,
  output [31:0] io_out_1_Im
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
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
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
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
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
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
`endif // RANDOMIZE_REG_INIT
  wire  TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_in_inv; // @[TwidFactorDesigns.scala 145:26]
  wire [1:0] TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_in_addr; // @[TwidFactorDesigns.scala 145:26]
  wire [31:0] TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_out_data_1_Re; // @[TwidFactorDesigns.scala 145:26]
  wire [31:0] TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_out_data_1_Im; // @[TwidFactorDesigns.scala 145:26]
  wire  FPComplexScale_NonFPMult_bw32_clock; // @[TwidFactorDesigns.scala 195:30]
  wire  FPComplexScale_NonFPMult_bw32_reset; // @[TwidFactorDesigns.scala 195:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_io_in_Re; // @[TwidFactorDesigns.scala 195:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_io_in_Im; // @[TwidFactorDesigns.scala 195:30]
  wire  FPComplexScale_NonFPMult_bw32_io_in_en; // @[TwidFactorDesigns.scala 195:30]
  wire  FPComplexScale_NonFPMult_bw32_io_is_neg; // @[TwidFactorDesigns.scala 195:30]
  wire  FPComplexScale_NonFPMult_bw32_io_is_flip; // @[TwidFactorDesigns.scala 195:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_io_out_Re; // @[TwidFactorDesigns.scala 195:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_io_out_Im; // @[TwidFactorDesigns.scala 195:30]
  wire  FPComplexScale_NonFPMult_bw32_1_clock; // @[TwidFactorDesigns.scala 195:30]
  wire  FPComplexScale_NonFPMult_bw32_1_reset; // @[TwidFactorDesigns.scala 195:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_1_io_in_Re; // @[TwidFactorDesigns.scala 195:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_1_io_in_Im; // @[TwidFactorDesigns.scala 195:30]
  wire  FPComplexScale_NonFPMult_bw32_1_io_in_en; // @[TwidFactorDesigns.scala 195:30]
  wire  FPComplexScale_NonFPMult_bw32_1_io_is_neg; // @[TwidFactorDesigns.scala 195:30]
  wire  FPComplexScale_NonFPMult_bw32_1_io_is_flip; // @[TwidFactorDesigns.scala 195:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_1_io_out_Re; // @[TwidFactorDesigns.scala 195:30]
  wire [31:0] FPComplexScale_NonFPMult_bw32_1_io_out_Im; // @[TwidFactorDesigns.scala 195:30]
  reg  sr_valid_regs_r; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_1; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_2; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_3; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_4; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_5; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_6; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_7; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_8; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_9; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_10; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_11; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_12; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_13; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_14; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_15; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_16; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_17; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_18; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_19; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_20; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_21; // @[Reg.scala 16:16]
  reg  sr_valid_regs_r_22; // @[Reg.scala 16:16]
  reg  sr_valid_regs; // @[Reg.scala 16:16]
  reg  cnt; // @[TwidFactorDesigns.scala 193:24]
  reg [31:0] sr_result_regs_r_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_1_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_1_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_2_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_2_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_3_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_3_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_4_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_4_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_5_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_5_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_6_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_6_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_7_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_7_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_8_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_8_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_9_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_9_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_10_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_10_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_11_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_11_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_12_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_12_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_13_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_13_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_14_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_14_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_15_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_15_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_16_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_16_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_17_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_17_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_18_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_18_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_19_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_19_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_20_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_20_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_21_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_21_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_22_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_22_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_23_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_23_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_24_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_24_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_25_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_25_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_26_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_26_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_27_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_27_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_28_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_28_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_29_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_29_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_30_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_30_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_31_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_31_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_32_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_32_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_33_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_33_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_34_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_34_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_35_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_35_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_36_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_36_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_37_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_37_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_38_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_38_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_39_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_39_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_40_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_40_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_41_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_41_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_42_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_42_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_43_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_43_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_44_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_44_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_45_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_45_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_46_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_46_Im; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_47_Re; // @[Reg.scala 16:16]
  reg [31:0] sr_result_regs_r_47_Im; // @[Reg.scala 16:16]
  TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32 TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32 ( // @[TwidFactorDesigns.scala 145:26]
    .io_in_inv(TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_in_inv),
    .io_in_addr(TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_in_addr),
    .io_out_data_1_Re(TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_out_data_1_Re),
    .io_out_data_1_Im(TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_out_data_1_Im)
  );
  FPComplexScale_NonFPMult_bw32 FPComplexScale_NonFPMult_bw32 ( // @[TwidFactorDesigns.scala 195:30]
    .clock(FPComplexScale_NonFPMult_bw32_clock),
    .reset(FPComplexScale_NonFPMult_bw32_reset),
    .io_in_Re(FPComplexScale_NonFPMult_bw32_io_in_Re),
    .io_in_Im(FPComplexScale_NonFPMult_bw32_io_in_Im),
    .io_in_en(FPComplexScale_NonFPMult_bw32_io_in_en),
    .io_is_neg(FPComplexScale_NonFPMult_bw32_io_is_neg),
    .io_is_flip(FPComplexScale_NonFPMult_bw32_io_is_flip),
    .io_out_Re(FPComplexScale_NonFPMult_bw32_io_out_Re),
    .io_out_Im(FPComplexScale_NonFPMult_bw32_io_out_Im)
  );
  FPComplexScale_NonFPMult_bw32 FPComplexScale_NonFPMult_bw32_1 ( // @[TwidFactorDesigns.scala 195:30]
    .clock(FPComplexScale_NonFPMult_bw32_1_clock),
    .reset(FPComplexScale_NonFPMult_bw32_1_reset),
    .io_in_Re(FPComplexScale_NonFPMult_bw32_1_io_in_Re),
    .io_in_Im(FPComplexScale_NonFPMult_bw32_1_io_in_Im),
    .io_in_en(FPComplexScale_NonFPMult_bw32_1_io_in_en),
    .io_is_neg(FPComplexScale_NonFPMult_bw32_1_io_is_neg),
    .io_is_flip(FPComplexScale_NonFPMult_bw32_1_io_is_flip),
    .io_out_Re(FPComplexScale_NonFPMult_bw32_1_io_out_Re),
    .io_out_Im(FPComplexScale_NonFPMult_bw32_1_io_out_Im)
  );
  assign io_out_valid = sr_valid_regs; // @[TwidFactorDesigns.scala 147:18]
  assign io_out_0_Re = sr_result_regs_r_23_Re; // @[TwidFactorDesigns.scala 258:{35,35}]
  assign io_out_0_Im = sr_result_regs_r_23_Im; // @[TwidFactorDesigns.scala 258:{35,35}]
  assign io_out_1_Re = sr_result_regs_r_47_Re; // @[TwidFactorDesigns.scala 258:{35,35}]
  assign io_out_1_Im = sr_result_regs_r_47_Im; // @[TwidFactorDesigns.scala 258:{35,35}]
  assign TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_in_inv = io_in_inv; // @[TwidFactorDesigns.scala 263:23]
  assign TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_in_addr = {{1'd0}, cnt}; // @[TwidFactorDesigns.scala 262:24]
  assign FPComplexScale_NonFPMult_bw32_clock = clock;
  assign FPComplexScale_NonFPMult_bw32_reset = reset;
  assign FPComplexScale_NonFPMult_bw32_io_in_Re = io_in_0_Re; // @[TwidFactorDesigns.scala 204:27]
  assign FPComplexScale_NonFPMult_bw32_io_in_Im = io_in_0_Im; // @[TwidFactorDesigns.scala 204:27]
  assign FPComplexScale_NonFPMult_bw32_io_in_en = io_in_en_main; // @[TwidFactorDesigns.scala 199:30]
  assign FPComplexScale_NonFPMult_bw32_io_is_neg = 1'h0; // @[TwidFactorDesigns.scala 206:94]
  assign FPComplexScale_NonFPMult_bw32_io_is_flip = 1'h0; // @[TwidFactorDesigns.scala 206:94 207:34 214:34]
  assign FPComplexScale_NonFPMult_bw32_1_clock = clock;
  assign FPComplexScale_NonFPMult_bw32_1_reset = reset;
  assign FPComplexScale_NonFPMult_bw32_1_io_in_Re = io_in_1_Re; // @[TwidFactorDesigns.scala 204:27]
  assign FPComplexScale_NonFPMult_bw32_1_io_in_Im = io_in_1_Im; // @[TwidFactorDesigns.scala 204:27]
  assign FPComplexScale_NonFPMult_bw32_1_io_in_en = io_in_en_main; // @[TwidFactorDesigns.scala 199:30]
  assign FPComplexScale_NonFPMult_bw32_1_io_is_neg = TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_out_data_1_Re
    [30:0] == 31'h3f800000 ? TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_out_data_1_Re[31] :
    TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_out_data_1_Im[31]; // @[TwidFactorDesigns.scala 206:94]
  assign FPComplexScale_NonFPMult_bw32_1_io_is_flip =
    TwiddleFactorROM_sr_Streaming_N4_r2_w2_stage0_bw32_io_out_data_1_Re[30:0] == 31'h3f800000 ? 1'h0 : 1'h1; // @[TwidFactorDesigns.scala 206:94 207:34 214:34]
  always @(posedge clock) begin
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r <= io_in_valid; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_1 <= sr_valid_regs_r; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_2 <= sr_valid_regs_r_1; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_3 <= sr_valid_regs_r_2; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_4 <= sr_valid_regs_r_3; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_5 <= sr_valid_regs_r_4; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_6 <= sr_valid_regs_r_5; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_7 <= sr_valid_regs_r_6; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_8 <= sr_valid_regs_r_7; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_9 <= sr_valid_regs_r_8; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_10 <= sr_valid_regs_r_9; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_11 <= sr_valid_regs_r_10; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_12 <= sr_valid_regs_r_11; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_13 <= sr_valid_regs_r_12; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_14 <= sr_valid_regs_r_13; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_15 <= sr_valid_regs_r_14; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_16 <= sr_valid_regs_r_15; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_17 <= sr_valid_regs_r_16; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_18 <= sr_valid_regs_r_17; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_19 <= sr_valid_regs_r_18; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_20 <= sr_valid_regs_r_19; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_21 <= sr_valid_regs_r_20; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs_r_22 <= sr_valid_regs_r_21; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_valid_regs <= sr_valid_regs_r_22; // @[Reg.scala 17:22]
    end
    if (reset) begin // @[TwidFactorDesigns.scala 193:24]
      cnt <= 1'h0; // @[TwidFactorDesigns.scala 193:24]
    end else if (io_in_en_main) begin // @[TwidFactorDesigns.scala 222:27]
      if (io_in_valid) begin // @[TwidFactorDesigns.scala 223:27]
        if (cnt) begin // @[TwidFactorDesigns.scala 224:41]
          cnt <= 1'h0; // @[TwidFactorDesigns.scala 225:17]
        end else begin
          cnt <= cnt + 1'h1; // @[TwidFactorDesigns.scala 227:17]
        end
      end
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_Re <= FPComplexScale_NonFPMult_bw32_io_out_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_Im <= FPComplexScale_NonFPMult_bw32_io_out_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_1_Re <= sr_result_regs_r_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_1_Im <= sr_result_regs_r_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_2_Re <= sr_result_regs_r_1_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_2_Im <= sr_result_regs_r_1_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_3_Re <= sr_result_regs_r_2_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_3_Im <= sr_result_regs_r_2_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_4_Re <= sr_result_regs_r_3_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_4_Im <= sr_result_regs_r_3_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_5_Re <= sr_result_regs_r_4_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_5_Im <= sr_result_regs_r_4_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_6_Re <= sr_result_regs_r_5_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_6_Im <= sr_result_regs_r_5_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_7_Re <= sr_result_regs_r_6_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_7_Im <= sr_result_regs_r_6_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_8_Re <= sr_result_regs_r_7_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_8_Im <= sr_result_regs_r_7_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_9_Re <= sr_result_regs_r_8_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_9_Im <= sr_result_regs_r_8_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_10_Re <= sr_result_regs_r_9_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_10_Im <= sr_result_regs_r_9_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_11_Re <= sr_result_regs_r_10_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_11_Im <= sr_result_regs_r_10_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_12_Re <= sr_result_regs_r_11_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_12_Im <= sr_result_regs_r_11_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_13_Re <= sr_result_regs_r_12_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_13_Im <= sr_result_regs_r_12_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_14_Re <= sr_result_regs_r_13_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_14_Im <= sr_result_regs_r_13_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_15_Re <= sr_result_regs_r_14_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_15_Im <= sr_result_regs_r_14_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_16_Re <= sr_result_regs_r_15_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_16_Im <= sr_result_regs_r_15_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_17_Re <= sr_result_regs_r_16_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_17_Im <= sr_result_regs_r_16_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_18_Re <= sr_result_regs_r_17_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_18_Im <= sr_result_regs_r_17_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_19_Re <= sr_result_regs_r_18_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_19_Im <= sr_result_regs_r_18_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_20_Re <= sr_result_regs_r_19_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_20_Im <= sr_result_regs_r_19_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_21_Re <= sr_result_regs_r_20_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_21_Im <= sr_result_regs_r_20_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_22_Re <= sr_result_regs_r_21_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_22_Im <= sr_result_regs_r_21_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_23_Re <= sr_result_regs_r_22_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_23_Im <= sr_result_regs_r_22_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_24_Re <= FPComplexScale_NonFPMult_bw32_1_io_out_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_24_Im <= FPComplexScale_NonFPMult_bw32_1_io_out_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_25_Re <= sr_result_regs_r_24_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_25_Im <= sr_result_regs_r_24_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_26_Re <= sr_result_regs_r_25_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_26_Im <= sr_result_regs_r_25_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_27_Re <= sr_result_regs_r_26_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_27_Im <= sr_result_regs_r_26_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_28_Re <= sr_result_regs_r_27_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_28_Im <= sr_result_regs_r_27_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_29_Re <= sr_result_regs_r_28_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_29_Im <= sr_result_regs_r_28_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_30_Re <= sr_result_regs_r_29_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_30_Im <= sr_result_regs_r_29_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_31_Re <= sr_result_regs_r_30_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_31_Im <= sr_result_regs_r_30_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_32_Re <= sr_result_regs_r_31_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_32_Im <= sr_result_regs_r_31_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_33_Re <= sr_result_regs_r_32_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_33_Im <= sr_result_regs_r_32_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_34_Re <= sr_result_regs_r_33_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_34_Im <= sr_result_regs_r_33_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_35_Re <= sr_result_regs_r_34_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_35_Im <= sr_result_regs_r_34_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_36_Re <= sr_result_regs_r_35_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_36_Im <= sr_result_regs_r_35_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_37_Re <= sr_result_regs_r_36_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_37_Im <= sr_result_regs_r_36_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_38_Re <= sr_result_regs_r_37_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_38_Im <= sr_result_regs_r_37_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_39_Re <= sr_result_regs_r_38_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_39_Im <= sr_result_regs_r_38_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_40_Re <= sr_result_regs_r_39_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_40_Im <= sr_result_regs_r_39_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_41_Re <= sr_result_regs_r_40_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_41_Im <= sr_result_regs_r_40_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_42_Re <= sr_result_regs_r_41_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_42_Im <= sr_result_regs_r_41_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_43_Re <= sr_result_regs_r_42_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_43_Im <= sr_result_regs_r_42_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_44_Re <= sr_result_regs_r_43_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_44_Im <= sr_result_regs_r_43_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_45_Re <= sr_result_regs_r_44_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_45_Im <= sr_result_regs_r_44_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_46_Re <= sr_result_regs_r_45_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_46_Im <= sr_result_regs_r_45_Im; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_47_Re <= sr_result_regs_r_46_Re; // @[Reg.scala 17:22]
    end
    if (io_in_en_main) begin // @[Reg.scala 17:18]
      sr_result_regs_r_47_Im <= sr_result_regs_r_46_Im; // @[Reg.scala 17:22]
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
  sr_valid_regs_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  sr_valid_regs_r_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  sr_valid_regs_r_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  sr_valid_regs_r_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  sr_valid_regs_r_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  sr_valid_regs_r_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  sr_valid_regs_r_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  sr_valid_regs_r_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  sr_valid_regs_r_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  sr_valid_regs_r_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sr_valid_regs_r_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  sr_valid_regs_r_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sr_valid_regs_r_12 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  sr_valid_regs_r_13 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sr_valid_regs_r_14 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  sr_valid_regs_r_15 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  sr_valid_regs_r_16 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sr_valid_regs_r_17 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  sr_valid_regs_r_18 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  sr_valid_regs_r_19 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  sr_valid_regs_r_20 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  sr_valid_regs_r_21 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  sr_valid_regs_r_22 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  sr_valid_regs = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  cnt = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  sr_result_regs_r_Re = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  sr_result_regs_r_Im = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  sr_result_regs_r_1_Re = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  sr_result_regs_r_1_Im = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  sr_result_regs_r_2_Re = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  sr_result_regs_r_2_Im = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  sr_result_regs_r_3_Re = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  sr_result_regs_r_3_Im = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  sr_result_regs_r_4_Re = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  sr_result_regs_r_4_Im = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  sr_result_regs_r_5_Re = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  sr_result_regs_r_5_Im = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  sr_result_regs_r_6_Re = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  sr_result_regs_r_6_Im = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  sr_result_regs_r_7_Re = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  sr_result_regs_r_7_Im = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  sr_result_regs_r_8_Re = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  sr_result_regs_r_8_Im = _RAND_42[31:0];
  _RAND_43 = {1{`RANDOM}};
  sr_result_regs_r_9_Re = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  sr_result_regs_r_9_Im = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  sr_result_regs_r_10_Re = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  sr_result_regs_r_10_Im = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  sr_result_regs_r_11_Re = _RAND_47[31:0];
  _RAND_48 = {1{`RANDOM}};
  sr_result_regs_r_11_Im = _RAND_48[31:0];
  _RAND_49 = {1{`RANDOM}};
  sr_result_regs_r_12_Re = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  sr_result_regs_r_12_Im = _RAND_50[31:0];
  _RAND_51 = {1{`RANDOM}};
  sr_result_regs_r_13_Re = _RAND_51[31:0];
  _RAND_52 = {1{`RANDOM}};
  sr_result_regs_r_13_Im = _RAND_52[31:0];
  _RAND_53 = {1{`RANDOM}};
  sr_result_regs_r_14_Re = _RAND_53[31:0];
  _RAND_54 = {1{`RANDOM}};
  sr_result_regs_r_14_Im = _RAND_54[31:0];
  _RAND_55 = {1{`RANDOM}};
  sr_result_regs_r_15_Re = _RAND_55[31:0];
  _RAND_56 = {1{`RANDOM}};
  sr_result_regs_r_15_Im = _RAND_56[31:0];
  _RAND_57 = {1{`RANDOM}};
  sr_result_regs_r_16_Re = _RAND_57[31:0];
  _RAND_58 = {1{`RANDOM}};
  sr_result_regs_r_16_Im = _RAND_58[31:0];
  _RAND_59 = {1{`RANDOM}};
  sr_result_regs_r_17_Re = _RAND_59[31:0];
  _RAND_60 = {1{`RANDOM}};
  sr_result_regs_r_17_Im = _RAND_60[31:0];
  _RAND_61 = {1{`RANDOM}};
  sr_result_regs_r_18_Re = _RAND_61[31:0];
  _RAND_62 = {1{`RANDOM}};
  sr_result_regs_r_18_Im = _RAND_62[31:0];
  _RAND_63 = {1{`RANDOM}};
  sr_result_regs_r_19_Re = _RAND_63[31:0];
  _RAND_64 = {1{`RANDOM}};
  sr_result_regs_r_19_Im = _RAND_64[31:0];
  _RAND_65 = {1{`RANDOM}};
  sr_result_regs_r_20_Re = _RAND_65[31:0];
  _RAND_66 = {1{`RANDOM}};
  sr_result_regs_r_20_Im = _RAND_66[31:0];
  _RAND_67 = {1{`RANDOM}};
  sr_result_regs_r_21_Re = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  sr_result_regs_r_21_Im = _RAND_68[31:0];
  _RAND_69 = {1{`RANDOM}};
  sr_result_regs_r_22_Re = _RAND_69[31:0];
  _RAND_70 = {1{`RANDOM}};
  sr_result_regs_r_22_Im = _RAND_70[31:0];
  _RAND_71 = {1{`RANDOM}};
  sr_result_regs_r_23_Re = _RAND_71[31:0];
  _RAND_72 = {1{`RANDOM}};
  sr_result_regs_r_23_Im = _RAND_72[31:0];
  _RAND_73 = {1{`RANDOM}};
  sr_result_regs_r_24_Re = _RAND_73[31:0];
  _RAND_74 = {1{`RANDOM}};
  sr_result_regs_r_24_Im = _RAND_74[31:0];
  _RAND_75 = {1{`RANDOM}};
  sr_result_regs_r_25_Re = _RAND_75[31:0];
  _RAND_76 = {1{`RANDOM}};
  sr_result_regs_r_25_Im = _RAND_76[31:0];
  _RAND_77 = {1{`RANDOM}};
  sr_result_regs_r_26_Re = _RAND_77[31:0];
  _RAND_78 = {1{`RANDOM}};
  sr_result_regs_r_26_Im = _RAND_78[31:0];
  _RAND_79 = {1{`RANDOM}};
  sr_result_regs_r_27_Re = _RAND_79[31:0];
  _RAND_80 = {1{`RANDOM}};
  sr_result_regs_r_27_Im = _RAND_80[31:0];
  _RAND_81 = {1{`RANDOM}};
  sr_result_regs_r_28_Re = _RAND_81[31:0];
  _RAND_82 = {1{`RANDOM}};
  sr_result_regs_r_28_Im = _RAND_82[31:0];
  _RAND_83 = {1{`RANDOM}};
  sr_result_regs_r_29_Re = _RAND_83[31:0];
  _RAND_84 = {1{`RANDOM}};
  sr_result_regs_r_29_Im = _RAND_84[31:0];
  _RAND_85 = {1{`RANDOM}};
  sr_result_regs_r_30_Re = _RAND_85[31:0];
  _RAND_86 = {1{`RANDOM}};
  sr_result_regs_r_30_Im = _RAND_86[31:0];
  _RAND_87 = {1{`RANDOM}};
  sr_result_regs_r_31_Re = _RAND_87[31:0];
  _RAND_88 = {1{`RANDOM}};
  sr_result_regs_r_31_Im = _RAND_88[31:0];
  _RAND_89 = {1{`RANDOM}};
  sr_result_regs_r_32_Re = _RAND_89[31:0];
  _RAND_90 = {1{`RANDOM}};
  sr_result_regs_r_32_Im = _RAND_90[31:0];
  _RAND_91 = {1{`RANDOM}};
  sr_result_regs_r_33_Re = _RAND_91[31:0];
  _RAND_92 = {1{`RANDOM}};
  sr_result_regs_r_33_Im = _RAND_92[31:0];
  _RAND_93 = {1{`RANDOM}};
  sr_result_regs_r_34_Re = _RAND_93[31:0];
  _RAND_94 = {1{`RANDOM}};
  sr_result_regs_r_34_Im = _RAND_94[31:0];
  _RAND_95 = {1{`RANDOM}};
  sr_result_regs_r_35_Re = _RAND_95[31:0];
  _RAND_96 = {1{`RANDOM}};
  sr_result_regs_r_35_Im = _RAND_96[31:0];
  _RAND_97 = {1{`RANDOM}};
  sr_result_regs_r_36_Re = _RAND_97[31:0];
  _RAND_98 = {1{`RANDOM}};
  sr_result_regs_r_36_Im = _RAND_98[31:0];
  _RAND_99 = {1{`RANDOM}};
  sr_result_regs_r_37_Re = _RAND_99[31:0];
  _RAND_100 = {1{`RANDOM}};
  sr_result_regs_r_37_Im = _RAND_100[31:0];
  _RAND_101 = {1{`RANDOM}};
  sr_result_regs_r_38_Re = _RAND_101[31:0];
  _RAND_102 = {1{`RANDOM}};
  sr_result_regs_r_38_Im = _RAND_102[31:0];
  _RAND_103 = {1{`RANDOM}};
  sr_result_regs_r_39_Re = _RAND_103[31:0];
  _RAND_104 = {1{`RANDOM}};
  sr_result_regs_r_39_Im = _RAND_104[31:0];
  _RAND_105 = {1{`RANDOM}};
  sr_result_regs_r_40_Re = _RAND_105[31:0];
  _RAND_106 = {1{`RANDOM}};
  sr_result_regs_r_40_Im = _RAND_106[31:0];
  _RAND_107 = {1{`RANDOM}};
  sr_result_regs_r_41_Re = _RAND_107[31:0];
  _RAND_108 = {1{`RANDOM}};
  sr_result_regs_r_41_Im = _RAND_108[31:0];
  _RAND_109 = {1{`RANDOM}};
  sr_result_regs_r_42_Re = _RAND_109[31:0];
  _RAND_110 = {1{`RANDOM}};
  sr_result_regs_r_42_Im = _RAND_110[31:0];
  _RAND_111 = {1{`RANDOM}};
  sr_result_regs_r_43_Re = _RAND_111[31:0];
  _RAND_112 = {1{`RANDOM}};
  sr_result_regs_r_43_Im = _RAND_112[31:0];
  _RAND_113 = {1{`RANDOM}};
  sr_result_regs_r_44_Re = _RAND_113[31:0];
  _RAND_114 = {1{`RANDOM}};
  sr_result_regs_r_44_Im = _RAND_114[31:0];
  _RAND_115 = {1{`RANDOM}};
  sr_result_regs_r_45_Re = _RAND_115[31:0];
  _RAND_116 = {1{`RANDOM}};
  sr_result_regs_r_45_Im = _RAND_116[31:0];
  _RAND_117 = {1{`RANDOM}};
  sr_result_regs_r_46_Re = _RAND_117[31:0];
  _RAND_118 = {1{`RANDOM}};
  sr_result_regs_r_46_Im = _RAND_118[31:0];
  _RAND_119 = {1{`RANDOM}};
  sr_result_regs_r_47_Re = _RAND_119[31:0];
  _RAND_120 = {1{`RANDOM}};
  sr_result_regs_r_47_Im = _RAND_120[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FFT4w2(
  input         clock,
  input         reset,
  input         io_in_inv,
  input         io_in_ready,
  input  [31:0] io_in_0_Re,
  input  [31:0] io_in_0_Im,
  input  [31:0] io_in_1_Re,
  input  [31:0] io_in_1_Im,
  input         io_in_valid,
  output        io_out_valid,
  output [31:0] io_out_0_Re,
  output [31:0] io_out_0_Im,
  output [31:0] io_out_1_Re,
  output [31:0] io_out_1_Im
);
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_clock; // @[FFTSRDesigns.scala 119:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_reset; // @[FFTSRDesigns.scala 119:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_en; // @[FFTSRDesigns.scala 119:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_valid; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_0_Re; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_0_Im; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_1_Re; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_1_Im; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 119:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_valid; // @[FFTSRDesigns.scala 119:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_1_clock; // @[FFTSRDesigns.scala 119:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_1_reset; // @[FFTSRDesigns.scala 119:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_en; // @[FFTSRDesigns.scala 119:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_valid; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_0_Re; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_0_Im; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_1_Re; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_1_Im; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_0_Re; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_0_Im; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_1_Re; // @[FFTSRDesigns.scala 119:30]
  wire [31:0] DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_1_Im; // @[FFTSRDesigns.scala 119:30]
  wire  DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_valid; // @[FFTSRDesigns.scala 119:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_clock; // @[FFTSRDesigns.scala 126:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_reset; // @[FFTSRDesigns.scala 126:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_en; // @[FFTSRDesigns.scala 126:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_0_Re; // @[FFTSRDesigns.scala 126:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_0_Im; // @[FFTSRDesigns.scala 126:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_1_Re; // @[FFTSRDesigns.scala 126:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_1_Im; // @[FFTSRDesigns.scala 126:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_valid; // @[FFTSRDesigns.scala 126:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 126:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 126:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 126:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 126:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_valid; // @[FFTSRDesigns.scala 126:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_clock; // @[FFTSRDesigns.scala 129:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_reset; // @[FFTSRDesigns.scala 129:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_en; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_0_Re; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_0_Im; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_1_Re; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_1_Im; // @[FFTSRDesigns.scala 129:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_valid; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 129:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_valid; // @[FFTSRDesigns.scala 129:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_clock; // @[FFTSRDesigns.scala 129:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_reset; // @[FFTSRDesigns.scala 129:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_en; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_0_Re; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_0_Im; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_1_Re; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_1_Im; // @[FFTSRDesigns.scala 129:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_valid; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_0_Re; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_0_Im; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_1_Re; // @[FFTSRDesigns.scala 129:30]
  wire [31:0] Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_1_Im; // @[FFTSRDesigns.scala 129:30]
  wire  Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_valid; // @[FFTSRDesigns.scala 129:30]
  wire  TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_clock; // @[FFTSRDesigns.scala 134:28]
  wire  TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_reset; // @[FFTSRDesigns.scala 134:28]
  wire  TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_inv; // @[FFTSRDesigns.scala 134:28]
  wire  TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_en_main; // @[FFTSRDesigns.scala 134:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_0_Re; // @[FFTSRDesigns.scala 134:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_0_Im; // @[FFTSRDesigns.scala 134:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_1_Re; // @[FFTSRDesigns.scala 134:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_1_Im; // @[FFTSRDesigns.scala 134:28]
  wire  TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_valid; // @[FFTSRDesigns.scala 134:28]
  wire  TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_valid; // @[FFTSRDesigns.scala 134:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 134:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 134:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 134:28]
  wire [31:0] TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 134:28]
  DFT_SymmetryExploits_fullwidth_r2_bw32 DFT_SymmetryExploits_fullwidth_r2_bw32 ( // @[FFTSRDesigns.scala 119:30]
    .clock(DFT_SymmetryExploits_fullwidth_r2_bw32_clock),
    .reset(DFT_SymmetryExploits_fullwidth_r2_bw32_reset),
    .io_in_en(DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_en),
    .io_in_valid(DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_valid),
    .io_in_0_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_0_Re),
    .io_in_0_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_0_Im),
    .io_in_1_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_1_Re),
    .io_in_1_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_1_Im),
    .io_out_0_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_0_Re),
    .io_out_0_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_0_Im),
    .io_out_1_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_1_Re),
    .io_out_1_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_1_Im),
    .io_out_valid(DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_valid)
  );
  DFT_SymmetryExploits_fullwidth_r2_bw32 DFT_SymmetryExploits_fullwidth_r2_bw32_1 ( // @[FFTSRDesigns.scala 119:30]
    .clock(DFT_SymmetryExploits_fullwidth_r2_bw32_1_clock),
    .reset(DFT_SymmetryExploits_fullwidth_r2_bw32_1_reset),
    .io_in_en(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_en),
    .io_in_valid(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_valid),
    .io_in_0_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_0_Re),
    .io_in_0_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_0_Im),
    .io_in_1_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_1_Re),
    .io_in_1_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_1_Im),
    .io_out_0_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_0_Re),
    .io_out_0_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_0_Im),
    .io_out_1_Re(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_1_Re),
    .io_out_1_Im(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_1_Im),
    .io_out_valid(DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_valid)
  );
  Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32 Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32 ( // @[FFTSRDesigns.scala 126:30]
    .clock(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_clock),
    .reset(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_reset),
    .io_in_en(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_en),
    .io_in_0_Re(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_0_Re),
    .io_in_0_Im(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_0_Im),
    .io_in_1_Re(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_1_Re),
    .io_in_1_Im(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_1_Im),
    .io_in_valid(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_valid),
    .io_out_0_Re(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_0_Re),
    .io_out_0_Im(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_0_Im),
    .io_out_1_Re(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_1_Re),
    .io_out_1_Im(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_1_Im),
    .io_out_valid(Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_valid)
  );
  Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32 Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32 ( // @[FFTSRDesigns.scala 129:30]
    .clock(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_clock),
    .reset(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_reset),
    .io_in_en(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_en),
    .io_in_0_Re(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_0_Re),
    .io_in_0_Im(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_0_Im),
    .io_in_1_Re(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_1_Re),
    .io_in_1_Im(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_1_Im),
    .io_in_valid(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_valid),
    .io_out_0_Re(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_0_Re),
    .io_out_0_Im(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_0_Im),
    .io_out_1_Re(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_1_Re),
    .io_out_1_Im(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_1_Im),
    .io_out_valid(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_valid)
  );
  Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32 Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1 ( // @[FFTSRDesigns.scala 129:30]
    .clock(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_clock),
    .reset(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_reset),
    .io_in_en(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_en),
    .io_in_0_Re(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_0_Re),
    .io_in_0_Im(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_0_Im),
    .io_in_1_Re(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_1_Re),
    .io_in_1_Im(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_1_Im),
    .io_in_valid(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_valid),
    .io_out_0_Re(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_0_Re),
    .io_out_0_Im(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_0_Im),
    .io_out_1_Re(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_1_Re),
    .io_out_1_Im(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_1_Im),
    .io_out_valid(Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_valid)
  );
  TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32 TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32 ( // @[FFTSRDesigns.scala 134:28]
    .clock(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_clock),
    .reset(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_reset),
    .io_in_inv(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_inv),
    .io_in_en_main(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_en_main),
    .io_in_0_Re(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_0_Re),
    .io_in_0_Im(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_0_Im),
    .io_in_1_Re(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_1_Re),
    .io_in_1_Im(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_1_Im),
    .io_in_valid(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_valid),
    .io_out_valid(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_valid),
    .io_out_0_Re(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_0_Re),
    .io_out_0_Im(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_0_Im),
    .io_out_1_Re(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_1_Re),
    .io_out_1_Im(TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_1_Im)
  );
  assign io_out_valid = Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_valid; // @[FFTSRDesigns.scala 137:18]
  assign io_out_0_Re = Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_0_Re; // @[FFTSRDesigns.scala 138:12]
  assign io_out_0_Im = Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_0_Im; // @[FFTSRDesigns.scala 138:12]
  assign io_out_1_Re = Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_1_Re; // @[FFTSRDesigns.scala 138:12]
  assign io_out_1_Im = Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_out_1_Im; // @[FFTSRDesigns.scala 138:12]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_clock = clock;
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_reset = reset;
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 157:33]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_valid =
    Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_valid; // @[FFTSRDesigns.scala 160:38]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_0_Re = Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 161:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_0_Im = Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 161:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_1_Re = Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 161:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_io_in_1_Im = Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 161:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_clock = clock;
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_reset = reset;
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 157:33]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_valid =
    TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_valid; // @[FFTSRDesigns.scala 163:38]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_0_Re =
    TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 164:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_0_Im =
    TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 164:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_1_Re =
    TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 164:{42,42}]
  assign DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_in_1_Im =
    TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 164:{42,42}]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_clock = clock;
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_reset = reset;
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 140:27]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_0_Re = io_in_0_Re; // @[FFTSRDesigns.scala 141:24]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_0_Im = io_in_0_Im; // @[FFTSRDesigns.scala 141:24]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_1_Re = io_in_1_Re; // @[FFTSRDesigns.scala 141:24]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_1_Im = io_in_1_Im; // @[FFTSRDesigns.scala 141:24]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype1_bw32_io_in_valid = io_in_valid; // @[FFTSRDesigns.scala 142:30]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_clock = clock;
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_reset = reset;
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 145:31]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_0_Re = DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 147:{38,38}]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_0_Im = DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 147:{38,38}]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_1_Re = DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 147:{38,38}]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_1_Im = DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 147:{38,38}]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_in_valid =
    DFT_SymmetryExploits_fullwidth_r2_bw32_io_out_valid; // @[FFTSRDesigns.scala 146:34]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_clock = clock;
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_reset = reset;
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_en = io_in_ready; // @[FFTSRDesigns.scala 145:31]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_0_Re =
    DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_0_Re; // @[FFTSRDesigns.scala 147:{38,38}]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_0_Im =
    DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_0_Im; // @[FFTSRDesigns.scala 147:{38,38}]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_1_Re =
    DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_1_Re; // @[FFTSRDesigns.scala 147:{38,38}]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_1_Im =
    DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_1_Im; // @[FFTSRDesigns.scala 147:{38,38}]
  assign Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_1_io_in_valid =
    DFT_SymmetryExploits_fullwidth_r2_bw32_1_io_out_valid; // @[FFTSRDesigns.scala 146:34]
  assign TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_clock = clock;
  assign TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_reset = reset;
  assign TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_inv = io_in_inv; // @[FFTSRDesigns.scala 151:34]
  assign TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_en_main = io_in_ready; // @[FFTSRDesigns.scala 152:38]
  assign TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_0_Re =
    Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_0_Re; // @[FFTSRDesigns.scala 154:30]
  assign TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_0_Im =
    Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_0_Im; // @[FFTSRDesigns.scala 154:30]
  assign TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_1_Re =
    Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_1_Re; // @[FFTSRDesigns.scala 154:30]
  assign TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_1_Im =
    Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_1_Im; // @[FFTSRDesigns.scala 154:30]
  assign TwiddleApply_Streaming_NoValid_N4_r2_w2_stage0_bw32_io_in_valid =
    Permute_Streaming_N4_r2_base_r2_w2_ptype0_bw32_io_out_valid; // @[FFTSRDesigns.scala 153:36]
endmodule

