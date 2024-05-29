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
// Description : TSQR accelerator
// File        : tsqr_st16_1c.v
// Notes       : 
//    - Chisel generated
////////////////////////////////////////////////

module fsm(
  input         clk,
  input         rst,
  input         tsqr_en,
  input  [15:0] tile_no,
  output [15:0] hh_cnt,
  output [15:0] mx_cnt,
  output        d1_rdy,
  output        d1_vld,
  output        d2_vld,
  output        vk1_vld,
  output        d3_rdy,
  output        d3_vld,
  output        tk_vld,
  output        d4_rdy,
  output        d5_rdy,
  output        d5_vld,
  output        yj_sft,
  output        d4_sft,
  output        hh_st,
  output        mem0_fi,
  output        mem1_fi,
  output        tsqr_fi,
  output        dmx0_mem_ena,
  output [31:0] dmx0_mem_wea,
  output [2:0]  dmx0_mem_addra,
  output        dmx0_mem_enb,
  output [2:0]  dmx0_mem_addrb,
  output        dmx1_mem_ena,
  output [31:0] dmx1_mem_wea,
  output [2:0]  dmx1_mem_addra,
  output        dmx1_mem_enb,
  output [2:0]  dmx1_mem_addrb,
  output        rtri_mem_ena,
  output [31:0] rtri_mem_wea,
  output [2:0]  rtri_mem_addra,
  output        rtri_mem_enb,
  output [2:0]  rtri_mem_addrb
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
`endif // RANDOMIZE_REG_INIT
  reg  hh_en; // @[tsqr_fsm.scala 89:24]
  reg  nxt_hh_en; // @[tsqr_fsm.scala 90:28]
  wire  _T = mem0_fi | mem1_fi; // @[tsqr_fsm.scala 94:28]
  wire  _GEN_0 = tsqr_en | nxt_hh_en; // @[tsqr_fsm.scala 96:28 97:23 90:28]
  reg [15:0] cnt; // @[tsqr_fsm.scala 106:22]
  reg [15:0] nxt_hh_cnt; // @[tsqr_fsm.scala 108:29]
  reg [15:0] nxt_mx_cnt; // @[tsqr_fsm.scala 109:29]
  wire  _T_1 = cnt == 16'h1bf; // @[tsqr_fsm.scala 111:18]
  wire [15:0] _nxt_cnt_T_1 = cnt + 16'h1; // @[tsqr_fsm.scala 114:28]
  wire [4:0] _T_3 = 5'h10 / 2'h2; // @[tsqr_fsm.scala 119:64]
  wire [4:0] _T_5 = _T_3 - 5'h1; // @[tsqr_fsm.scala 119:68]
  wire [15:0] _GEN_79 = {{11'd0}, _T_5}; // @[tsqr_fsm.scala 119:42]
  wire [15:0] _nxt_hh_cnt_T_1 = hh_cnt + 16'h1; // @[tsqr_fsm.scala 122:34]
  wire  _T_10 = hh_cnt == 16'h7; // @[tsqr_fsm.scala 127:22]
  wire [8:0] _T_17 = 9'h1bf - 9'h1; // @[tsqr_fsm.scala 129:77]
  wire [15:0] _GEN_80 = {{7'd0}, _T_17}; // @[tsqr_fsm.scala 129:63]
  wire [15:0] _nxt_mx_cnt_T_1 = mx_cnt + 16'h1; // @[tsqr_fsm.scala 130:34]
  reg [15:0] tr_cy_reg; // @[tsqr_fsm.scala 145:28]
  reg  tr_cnt_en; // @[tsqr_fsm.scala 146:28]
  reg [15:0] tr_cnt; // @[tsqr_fsm.scala 147:25]
  wire  rd_mem_fst = rst ? 1'h0 : tsqr_en & (~hh_en | ~nxt_hh_en); // @[tsqr_fsm.scala 152:18 153:24 158:24]
  wire  wr_mem_st = rst ? 1'h0 : hh_en & tr_cnt == 16'he0; // @[tsqr_fsm.scala 152:18 154:23 159:23]
  wire  rd_mem_st = rst ? 1'h0 : hh_en & cnt == 16'hd6; // @[tsqr_fsm.scala 152:18 156:23 161:23]
  wire [15:0] _tr_cy_T_1 = 16'h8 - hh_cnt; // @[tsqr_fsm.scala 168:45]
  wire [15:0] tr_cy = rd_mem_st ? _tr_cy_T_1 : tr_cy_reg; // @[tsqr_fsm.scala 167:24 168:19 170:19]
  wire [15:0] _hh_fi_T_1 = 16'he1 + tr_cy; // @[tsqr_fsm.scala 174:45]
  wire [15:0] _hh_fi_T_3 = _hh_fi_T_1 + 16'h1; // @[tsqr_fsm.scala 174:53]
  wire  hh_fi = tr_cnt == _hh_fi_T_3; // @[tsqr_fsm.scala 174:26]
  wire [15:0] _nxt_tr_cnt_T_1 = tr_cnt + 16'h1; // @[tsqr_fsm.scala 180:34]
  wire  _T_21 = hh_en & cnt == 16'hdb; // @[tsqr_fsm.scala 197:27]
  wire  _GEN_22 = hh_en & cnt == 16'hdb | tr_cnt_en; // @[tsqr_fsm.scala 197:51 198:23 146:28]
  wire  _GEN_23 = hh_fi ? 1'h0 : _GEN_22; // @[tsqr_fsm.scala 195:26 196:23]
  wire  _GEN_24 = rst ? 1'h0 : _GEN_23; // @[tsqr_fsm.scala 193:18 194:23]
  reg  tr_cnt_en_2; // @[tsqr_fsm.scala 200:30]
  wire  _GEN_25 = _T_21 | _GEN_24; // @[tsqr_fsm.scala 206:51 207:23]
  wire  _GEN_28 = hh_en & cnt == 16'hda | tr_cnt_en_2; // @[tsqr_fsm.scala 213:51 214:25 200:30]
  reg  d1_rdy_REG; // @[tsqr_fsm.scala 217:26]
  reg  d1_vld_REG; // @[tsqr_fsm.scala 218:26]
  reg  d2_vld_REG; // @[tsqr_fsm.scala 220:26]
  wire  _vk1_vld_T = cnt == 16'hd9; // @[tsqr_fsm.scala 222:41]
  reg  vk1_vld_REG; // @[tsqr_fsm.scala 222:27]
  reg  d3_rdy_REG; // @[tsqr_fsm.scala 223:26]
  reg  d3_vld_REG; // @[tsqr_fsm.scala 224:26]
  reg  tk_vld_REG; // @[tsqr_fsm.scala 226:26]
  wire  _d4_vld_T_1 = tr_cnt_en & tr_cnt >= 16'h40; // @[tsqr_fsm.scala 229:29]
  wire [15:0] _d4_vld_T_3 = 16'h40 + tr_cy; // @[tsqr_fsm.scala 229:78]
  wire [15:0] _d5_rdy_T_7 = _d4_vld_T_3 + 16'h80; // @[tsqr_fsm.scala 230:100]
  wire [15:0] _d5_vld_T_11 = _d5_rdy_T_7 + 16'ha; // @[tsqr_fsm.scala 231:127]
  wire  _yjp_vld_T_16 = tr_cnt >= 16'he1; // @[tsqr_fsm.scala 233:112]
  wire [15:0] _d4_sft_T_5 = 16'hc0 + tr_cy; // @[tsqr_fsm.scala 235:90]
  wire [15:0] _yj_sft_T_1 = 16'hc9 + tr_cy; // @[tsqr_fsm.scala 237:64]
  wire [15:0] _yj_sft_T_3 = _yj_sft_T_1 - 16'h1; // @[tsqr_fsm.scala 237:72]
  reg  yj_sft_REG; // @[tsqr_fsm.scala 237:25]
  reg  dmx0_mem_enb_reg; // @[tsqr_fsm.scala 245:35]
  reg  dmx1_mem_enb_reg; // @[tsqr_fsm.scala 246:35]
  reg  rtri_mem_enb_reg; // @[tsqr_fsm.scala 247:35]
  reg  dmx0_mem_ena_reg; // @[tsqr_fsm.scala 248:35]
  reg  dmx1_mem_ena_reg; // @[tsqr_fsm.scala 249:35]
  reg  rtri_mem_ena_reg; // @[tsqr_fsm.scala 250:35]
  wire  _rd_dmx0_en_T_1 = ~mx_cnt[0]; // @[tsqr_fsm.scala 263:27]
  wire [15:0] _rd_dmx0_en_T_4 = 16'hd8 + tr_cy; // @[tsqr_fsm.scala 263:76]
  wire [15:0] _rd_dmx0_en_T_6 = _rd_dmx0_en_T_4 + 16'h1; // @[tsqr_fsm.scala 263:84]
  wire  _rd_dmx0_en_T_8 = cnt >= 16'hd8 & cnt < _rd_dmx0_en_T_6; // @[tsqr_fsm.scala 263:58]
  wire  rd_dmx0_en = rst ? 1'h0 : ~mx_cnt[0] & (cnt >= 16'hd8 & cnt < _rd_dmx0_en_T_6); // @[tsqr_fsm.scala 255:18 256:24 263:24]
  wire  rd_dmx1_en = rst ? 1'h0 : mx_cnt[0] & _rd_dmx0_en_T_8; // @[tsqr_fsm.scala 255:18 257:24 264:24]
  wire  rd_rtri_en = rst ? 1'h0 : _rd_dmx0_en_T_8; // @[tsqr_fsm.scala 255:18 258:24 265:24]
  reg [2:0] dmx0_mem_addrb_reg; // @[tsqr_fsm.scala 271:37]
  reg [2:0] dmx1_mem_addrb_reg; // @[tsqr_fsm.scala 272:37]
  reg [2:0] rtri_mem_addrb_reg; // @[tsqr_fsm.scala 273:37]
  wire  _T_29 = hh_en & cnt == 16'hd8; // @[tsqr_fsm.scala 283:40]
  wire [2:0] _dmx0_mem_addrb_wire_T_1 = dmx0_mem_addrb_reg + 3'h1; // @[tsqr_fsm.scala 286:55]
  wire [2:0] _GEN_37 = rd_dmx0_en ? _dmx0_mem_addrb_wire_T_1 : dmx0_mem_addrb_reg; // @[tsqr_fsm.scala 285:31 286:33 288:33]
  wire [15:0] _GEN_38 = _rd_dmx0_en_T_1 & (hh_en & cnt == 16'hd8) ? hh_cnt : {{13'd0}, _GEN_37}; // @[tsqr_fsm.scala 283:63 284:32]
  wire [15:0] _GEN_39 = rd_mem_fst ? 16'h0 : _GEN_38; // @[tsqr_fsm.scala 281:25 282:33]
  wire [2:0] _dmx1_mem_addrb_wire_T_1 = dmx1_mem_addrb_reg + 3'h1; // @[tsqr_fsm.scala 296:55]
  wire [2:0] _GEN_40 = rd_dmx1_en ? _dmx1_mem_addrb_wire_T_1 : dmx1_mem_addrb_reg; // @[tsqr_fsm.scala 295:31 296:33 298:33]
  wire [15:0] _GEN_41 = mx_cnt[0] & _T_29 ? hh_cnt : {{13'd0}, _GEN_40}; // @[tsqr_fsm.scala 293:62 294:33]
  wire [15:0] _GEN_42 = rd_mem_fst ? 16'h0 : _GEN_41; // @[tsqr_fsm.scala 291:25 292:33]
  wire [2:0] _rtri_mem_addrb_wire_T_1 = rtri_mem_addrb_reg + 3'h1; // @[tsqr_fsm.scala 306:55]
  wire [2:0] _GEN_43 = rd_rtri_en ? _rtri_mem_addrb_wire_T_1 : rtri_mem_addrb_reg; // @[tsqr_fsm.scala 305:31 306:33 308:33]
  wire [15:0] _GEN_44 = _T_29 ? hh_cnt : {{13'd0}, _GEN_43}; // @[tsqr_fsm.scala 303:50 304:33]
  wire [15:0] _GEN_45 = rd_mem_fst ? 16'h0 : _GEN_44; // @[tsqr_fsm.scala 301:25 302:33]
  reg [31:0] dmx0_mem_wea_reg; // @[tsqr_fsm.scala 311:35]
  reg [31:0] dmx1_mem_wea_reg; // @[tsqr_fsm.scala 312:35]
  reg [31:0] rtri_mem_wea_reg; // @[tsqr_fsm.scala 313:35]
  reg [31:0] rtri_mem_wea_update; // @[tsqr_fsm.scala 316:38]
  wire  _dmx0_mem_ena_wire_T_6 = tr_cnt < _hh_fi_T_1; // @[tsqr_fsm.scala 323:85]
  wire  dmx0_mem_ena_wire = rst ? 1'h0 : _rd_dmx0_en_T_1 & _yjp_vld_T_16 & tr_cnt < _hh_fi_T_1; // @[tsqr_fsm.scala 318:18 319:31 323:31]
  wire  dmx1_mem_ena_wire = rst ? 1'h0 : mx_cnt[0] & _yjp_vld_T_16 & _dmx0_mem_ena_wire_T_6; // @[tsqr_fsm.scala 318:18 320:31 324:31]
  wire  rtri_mem_ena_wire = rst ? 1'h0 : _yjp_vld_T_16 & _dmx0_mem_ena_wire_T_6; // @[tsqr_fsm.scala 318:18 321:31 325:31]
  reg [2:0] dmx0_mem_addra_reg; // @[tsqr_fsm.scala 356:37]
  reg [2:0] dmx1_mem_addra_reg; // @[tsqr_fsm.scala 357:37]
  reg [2:0] rtri_mem_addra_reg; // @[tsqr_fsm.scala 358:37]
  wire  _T_45 = hh_en & tr_cnt == 16'he1; // @[tsqr_fsm.scala 360:34]
  wire [2:0] _dmx0_mem_addra_wire_T_1 = dmx0_mem_addra_reg + 3'h1; // @[tsqr_fsm.scala 363:55]
  wire [2:0] _GEN_55 = dmx0_mem_ena_wire ? _dmx0_mem_addra_wire_T_1 : dmx0_mem_addra_reg; // @[tsqr_fsm.scala 362:38 363:33 365:33]
  wire [15:0] _GEN_56 = _rd_dmx0_en_T_1 & (hh_en & tr_cnt == 16'he1) ? hh_cnt : {{13'd0}, _GEN_55}; // @[tsqr_fsm.scala 360:66 361:33]
  wire [2:0] _dmx1_mem_addra_wire_T_1 = dmx1_mem_addra_reg + 3'h1; // @[tsqr_fsm.scala 371:55]
  wire [2:0] _GEN_57 = dmx1_mem_ena_wire ? _dmx1_mem_addra_wire_T_1 : dmx1_mem_addra_reg; // @[tsqr_fsm.scala 370:38 371:33 373:33]
  wire [15:0] _GEN_58 = mx_cnt[0] & _T_45 ? hh_cnt : {{13'd0}, _GEN_57}; // @[tsqr_fsm.scala 368:65 369:33]
  wire [2:0] _rtri_mem_addra_wire_T_1 = rtri_mem_addra_reg + 3'h1; // @[tsqr_fsm.scala 379:55]
  wire [2:0] _GEN_59 = rtri_mem_ena_wire ? _rtri_mem_addra_wire_T_1 : rtri_mem_addra_reg; // @[tsqr_fsm.scala 378:38 379:33 381:33]
  wire [15:0] _GEN_60 = _T_45 ? hh_cnt : {{13'd0}, _GEN_59}; // @[tsqr_fsm.scala 376:53 377:33]
  wire [2:0] dmx0_mem_addra_wire = _GEN_56[2:0]; // @[tsqr_fsm.scala 277:39]
  wire [2:0] dmx1_mem_addra_wire = _GEN_58[2:0]; // @[tsqr_fsm.scala 278:39]
  wire [2:0] rtri_mem_addra_wire = _GEN_60[2:0]; // @[tsqr_fsm.scala 279:39]
  wire [2:0] dmx0_mem_addrb_wire = _GEN_39[2:0]; // @[tsqr_fsm.scala 274:39]
  wire [2:0] dmx1_mem_addrb_wire = _GEN_42[2:0]; // @[tsqr_fsm.scala 275:39]
  wire [2:0] rtri_mem_addrb_wire = _GEN_45[2:0]; // @[tsqr_fsm.scala 276:39]
  wire [16:0] _mem0_fi_T_4 = {{1'd0}, _hh_fi_T_1}; // @[tsqr_fsm.scala 419:63]
  wire  _mem0_fi_T_6 = tr_cnt == _mem0_fi_T_4[15:0]; // @[tsqr_fsm.scala 419:36]
  wire  _mem0_fi_T_8 = tr_cy == 16'h1; // @[tsqr_fsm.scala 419:80]
  wire [15:0] _tsqr_fi_T_2 = tile_no - 16'h1; // @[tsqr_fsm.scala 422:59]
  wire [18:0] _rtri_mem_wea_update_T_2 = hh_cnt * 3'h4; // @[tsqr_fsm.scala 429:62]
  wire [31:0] _rtri_mem_wea_update_T_3 = rtri_mem_wea_update >> _rtri_mem_wea_update_T_2; // @[tsqr_fsm.scala 429:52]
  assign hh_cnt = rst ? 16'h0 : nxt_hh_cnt; // @[tsqr_fsm.scala 135:18 137:20 141:20]
  assign mx_cnt = rst ? 16'h0 : nxt_mx_cnt; // @[tsqr_fsm.scala 135:18 138:20 142:20]
  assign d1_rdy = d1_rdy_REG; // @[tsqr_fsm.scala 217:16]
  assign d1_vld = d1_vld_REG; // @[tsqr_fsm.scala 218:16]
  assign d2_vld = d2_vld_REG; // @[tsqr_fsm.scala 220:16]
  assign vk1_vld = vk1_vld_REG; // @[tsqr_fsm.scala 222:17]
  assign d3_rdy = d3_rdy_REG; // @[tsqr_fsm.scala 223:16]
  assign d3_vld = d3_vld_REG; // @[tsqr_fsm.scala 224:16]
  assign tk_vld = tk_vld_REG; // @[tsqr_fsm.scala 226:16]
  assign d4_rdy = tr_cnt_en & tr_cnt < tr_cy; // @[tsqr_fsm.scala 228:29]
  assign d5_rdy = tr_cnt_en & tr_cnt >= 16'hc0 & tr_cnt < _d5_rdy_T_7; // @[tsqr_fsm.scala 230:69]
  assign d5_vld = tr_cnt_en & tr_cnt >= 16'hca & tr_cnt < _d5_vld_T_11; // @[tsqr_fsm.scala 231:82]
  assign yj_sft = yj_sft_REG; // @[tsqr_fsm.scala 237:16]
  assign d4_sft = _d4_vld_T_1 & tr_cnt < _d4_sft_T_5; // @[tsqr_fsm.scala 235:53]
  assign hh_st = rst ? 1'h0 : hh_en & tr_cnt == 16'he4; // @[tsqr_fsm.scala 152:18 155:19 160:19]
  assign mem0_fi = _rd_dmx0_en_T_1 & tr_cnt == _mem0_fi_T_4[15:0] & tr_cy == 16'h1; // @[tsqr_fsm.scala 419:71]
  assign mem1_fi = mx_cnt[0] & _mem0_fi_T_6 & _mem0_fi_T_8; // @[tsqr_fsm.scala 420:69]
  assign tsqr_fi = _T & mx_cnt == _tsqr_fi_T_2; // @[tsqr_fsm.scala 422:36]
  assign dmx0_mem_ena = dmx0_mem_ena_reg; // @[tsqr_fsm.scala 438:22]
  assign dmx0_mem_wea = _rd_dmx0_en_T_1 & wr_mem_st ? 32'hffffffff : dmx0_mem_wea_reg; // @[tsqr_fsm.scala 328:37 329:26 331:26]
  assign dmx0_mem_addra = dmx0_mem_addra_reg; // @[tsqr_fsm.scala 415:20]
  assign dmx0_mem_enb = dmx0_mem_enb_reg; // @[tsqr_fsm.scala 435:22]
  assign dmx0_mem_addrb = dmx0_mem_addrb_reg; // @[tsqr_fsm.scala 412:20]
  assign dmx1_mem_ena = dmx1_mem_ena_reg; // @[tsqr_fsm.scala 439:22]
  assign dmx1_mem_wea = mx_cnt[0] & wr_mem_st ? 32'hffffffff : dmx1_mem_wea_reg; // @[tsqr_fsm.scala 334:36 335:26 337:26]
  assign dmx1_mem_addra = dmx1_mem_addra_reg; // @[tsqr_fsm.scala 416:20]
  assign dmx1_mem_enb = dmx1_mem_enb_reg; // @[tsqr_fsm.scala 436:22]
  assign dmx1_mem_addrb = dmx1_mem_addrb_reg; // @[tsqr_fsm.scala 413:20]
  assign rtri_mem_ena = rtri_mem_ena_reg; // @[tsqr_fsm.scala 440:22]
  assign rtri_mem_wea = wr_mem_st ? rtri_mem_wea_update : rtri_mem_wea_reg; // @[tsqr_fsm.scala 340:24 341:26 343:26]
  assign rtri_mem_addra = rtri_mem_addra_reg; // @[tsqr_fsm.scala 417:20]
  assign rtri_mem_enb = rtri_mem_enb_reg; // @[tsqr_fsm.scala 437:22]
  assign rtri_mem_addrb = rtri_mem_addrb_reg; // @[tsqr_fsm.scala 414:20]
  always @(posedge clk) begin
    if (rst) begin // @[tsqr_fsm.scala 100:18]
      hh_en <= 1'h0; // @[tsqr_fsm.scala 101:19]
    end else begin
      hh_en <= nxt_hh_en; // @[tsqr_fsm.scala 103:19]
    end
    if (rst) begin // @[tsqr_fsm.scala 92:18]
      nxt_hh_en <= 1'h0; // @[tsqr_fsm.scala 93:23]
    end else if (mem0_fi | mem1_fi) begin // @[tsqr_fsm.scala 94:38]
      nxt_hh_en <= 1'h0; // @[tsqr_fsm.scala 95:23]
    end else begin
      nxt_hh_en <= _GEN_0;
    end
    if (rst) begin // @[tsqr_fsm.scala 135:18]
      cnt <= 16'h0; // @[tsqr_fsm.scala 136:17]
    end else if (cnt == 16'h1bf) begin // @[tsqr_fsm.scala 111:34]
      cnt <= 16'h0; // @[tsqr_fsm.scala 112:21]
    end else if (hh_en) begin // @[tsqr_fsm.scala 113:26]
      cnt <= _nxt_cnt_T_1; // @[tsqr_fsm.scala 114:21]
    end
    if (_T_1 & hh_cnt == _GEN_79) begin // @[tsqr_fsm.scala 119:75]
      nxt_hh_cnt <= 16'h0; // @[tsqr_fsm.scala 120:24]
    end else if (hh_en & _T_1) begin // @[tsqr_fsm.scala 121:48]
      nxt_hh_cnt <= _nxt_hh_cnt_T_1; // @[tsqr_fsm.scala 122:24]
    end else begin
      nxt_hh_cnt <= hh_cnt; // @[tsqr_fsm.scala 124:24]
    end
    if (hh_cnt == 16'h7 & mx_cnt == tile_no & _T_1) begin // @[tsqr_fsm.scala 127:96]
      nxt_mx_cnt <= 16'h0; // @[tsqr_fsm.scala 128:24]
    end else if (_T_10 & cnt == _GEN_80) begin // @[tsqr_fsm.scala 129:83]
      nxt_mx_cnt <= _nxt_mx_cnt_T_1; // @[tsqr_fsm.scala 130:24]
    end else begin
      nxt_mx_cnt <= mx_cnt; // @[tsqr_fsm.scala 132:24]
    end
    if (rst) begin // @[tsqr_fsm.scala 185:18]
      tr_cy_reg <= 16'h0; // @[tsqr_fsm.scala 187:23]
    end else if (rd_mem_st) begin // @[tsqr_fsm.scala 167:24]
      tr_cy_reg <= _tr_cy_T_1; // @[tsqr_fsm.scala 168:19]
    end
    if (rst) begin // @[tsqr_fsm.scala 202:18]
      tr_cnt_en <= 1'h0; // @[tsqr_fsm.scala 203:23]
    end else if (hh_fi) begin // @[tsqr_fsm.scala 204:26]
      tr_cnt_en <= 1'h0; // @[tsqr_fsm.scala 205:23]
    end else begin
      tr_cnt_en <= _GEN_25;
    end
    if (rst) begin // @[tsqr_fsm.scala 185:18]
      tr_cnt <= 16'h0; // @[tsqr_fsm.scala 186:20]
    end else if (hh_fi) begin // @[tsqr_fsm.scala 177:20]
      tr_cnt <= 16'h0; // @[tsqr_fsm.scala 178:24]
    end else if (tr_cnt_en) begin // @[tsqr_fsm.scala 179:30]
      tr_cnt <= _nxt_tr_cnt_T_1; // @[tsqr_fsm.scala 180:24]
    end
    if (rst) begin // @[tsqr_fsm.scala 209:18]
      tr_cnt_en_2 <= 1'h0; // @[tsqr_fsm.scala 210:25]
    end else if (hh_fi) begin // @[tsqr_fsm.scala 211:26]
      tr_cnt_en_2 <= 1'h0; // @[tsqr_fsm.scala 212:25]
    end else begin
      tr_cnt_en_2 <= _GEN_28;
    end
    d1_rdy_REG <= hh_en & cnt == 16'h1; // @[tsqr_fsm.scala 217:33]
    d1_vld_REG <= hh_en & cnt == 16'h41; // @[tsqr_fsm.scala 218:33]
    d2_vld_REG <= hh_en & cnt == 16'hcc; // @[tsqr_fsm.scala 220:33]
    vk1_vld_REG <= hh_en & cnt == 16'hd9; // @[tsqr_fsm.scala 222:34]
    d3_rdy_REG <= hh_en & _vk1_vld_T; // @[tsqr_fsm.scala 223:33]
    d3_vld_REG <= hh_en & cnt == 16'h119; // @[tsqr_fsm.scala 224:33]
    tk_vld_REG <= hh_en & cnt == 16'h19a; // @[tsqr_fsm.scala 226:33]
    yj_sft_REG <= tr_cnt_en_2 & tr_cnt < _yj_sft_T_3; // @[tsqr_fsm.scala 237:38]
    if (rst) begin // @[tsqr_fsm.scala 384:14]
      dmx0_mem_enb_reg <= 1'h0; // @[tsqr_fsm.scala 391:26]
    end else if (rst) begin // @[tsqr_fsm.scala 255:18]
      dmx0_mem_enb_reg <= 1'h0; // @[tsqr_fsm.scala 259:31]
    end else begin
      dmx0_mem_enb_reg <= _rd_dmx0_en_T_1 & rd_mem_fst | rd_dmx0_en; // @[tsqr_fsm.scala 266:31]
    end
    if (rst) begin // @[tsqr_fsm.scala 384:14]
      dmx1_mem_enb_reg <= 1'h0; // @[tsqr_fsm.scala 392:26]
    end else if (rst) begin // @[tsqr_fsm.scala 255:18]
      dmx1_mem_enb_reg <= 1'h0; // @[tsqr_fsm.scala 260:31]
    end else begin
      dmx1_mem_enb_reg <= mx_cnt[0] & rd_mem_fst | rd_dmx1_en; // @[tsqr_fsm.scala 267:31]
    end
    if (rst) begin // @[tsqr_fsm.scala 384:14]
      rtri_mem_enb_reg <= 1'h0; // @[tsqr_fsm.scala 393:26]
    end else if (rst) begin // @[tsqr_fsm.scala 255:18]
      rtri_mem_enb_reg <= 1'h0; // @[tsqr_fsm.scala 261:31]
    end else begin
      rtri_mem_enb_reg <= rd_mem_fst | rd_rtri_en; // @[tsqr_fsm.scala 268:31]
    end
    if (rst) begin // @[tsqr_fsm.scala 384:14]
      dmx0_mem_ena_reg <= 1'h0; // @[tsqr_fsm.scala 394:26]
    end else if (rst) begin // @[tsqr_fsm.scala 318:18]
      dmx0_mem_ena_reg <= 1'h0; // @[tsqr_fsm.scala 319:31]
    end else begin
      dmx0_mem_ena_reg <= _rd_dmx0_en_T_1 & _yjp_vld_T_16 & tr_cnt < _hh_fi_T_1; // @[tsqr_fsm.scala 323:31]
    end
    if (rst) begin // @[tsqr_fsm.scala 384:14]
      dmx1_mem_ena_reg <= 1'h0; // @[tsqr_fsm.scala 395:26]
    end else if (rst) begin // @[tsqr_fsm.scala 318:18]
      dmx1_mem_ena_reg <= 1'h0; // @[tsqr_fsm.scala 320:31]
    end else begin
      dmx1_mem_ena_reg <= mx_cnt[0] & _yjp_vld_T_16 & _dmx0_mem_ena_wire_T_6; // @[tsqr_fsm.scala 324:31]
    end
    if (rst) begin // @[tsqr_fsm.scala 384:14]
      rtri_mem_ena_reg <= 1'h0; // @[tsqr_fsm.scala 396:26]
    end else if (rst) begin // @[tsqr_fsm.scala 318:18]
      rtri_mem_ena_reg <= 1'h0; // @[tsqr_fsm.scala 321:31]
    end else begin
      rtri_mem_ena_reg <= _yjp_vld_T_16 & _dmx0_mem_ena_wire_T_6; // @[tsqr_fsm.scala 325:31]
    end
    if (rst) begin // @[tsqr_fsm.scala 384:14]
      dmx0_mem_addrb_reg <= 3'h0; // @[tsqr_fsm.scala 388:28]
    end else begin
      dmx0_mem_addrb_reg <= dmx0_mem_addrb_wire; // @[tsqr_fsm.scala 401:28]
    end
    if (rst) begin // @[tsqr_fsm.scala 384:14]
      dmx1_mem_addrb_reg <= 3'h0; // @[tsqr_fsm.scala 389:28]
    end else begin
      dmx1_mem_addrb_reg <= dmx1_mem_addrb_wire; // @[tsqr_fsm.scala 402:28]
    end
    if (rst) begin // @[tsqr_fsm.scala 384:14]
      rtri_mem_addrb_reg <= 3'h0; // @[tsqr_fsm.scala 390:28]
    end else begin
      rtri_mem_addrb_reg <= rtri_mem_addrb_wire; // @[tsqr_fsm.scala 403:28]
    end
    if (rst) begin // @[tsqr_fsm.scala 346:18]
      dmx0_mem_wea_reg <= 32'h0; // @[tsqr_fsm.scala 347:30]
    end else begin
      dmx0_mem_wea_reg <= dmx0_mem_wea; // @[tsqr_fsm.scala 351:30]
    end
    if (rst) begin // @[tsqr_fsm.scala 346:18]
      dmx1_mem_wea_reg <= 32'h0; // @[tsqr_fsm.scala 348:30]
    end else begin
      dmx1_mem_wea_reg <= dmx1_mem_wea; // @[tsqr_fsm.scala 352:30]
    end
    if (rst) begin // @[tsqr_fsm.scala 346:18]
      rtri_mem_wea_reg <= 32'h0; // @[tsqr_fsm.scala 349:30]
    end else begin
      rtri_mem_wea_reg <= rtri_mem_wea; // @[tsqr_fsm.scala 353:30]
    end
    if (rst) begin // @[tsqr_fsm.scala 424:14]
      rtri_mem_wea_update <= 32'hffffffff; // @[tsqr_fsm.scala 427:29]
    end else if (hh_en & tr_cnt == 16'hdf) begin // @[tsqr_fsm.scala 428:55]
      rtri_mem_wea_update <= _rtri_mem_wea_update_T_3; // @[tsqr_fsm.scala 429:29]
    end else begin
      rtri_mem_wea_update <= 32'hffffffff; // @[tsqr_fsm.scala 433:29]
    end
    if (rst) begin // @[tsqr_fsm.scala 384:14]
      dmx0_mem_addra_reg <= 3'h0; // @[tsqr_fsm.scala 385:28]
    end else begin
      dmx0_mem_addra_reg <= dmx0_mem_addra_wire; // @[tsqr_fsm.scala 398:28]
    end
    if (rst) begin // @[tsqr_fsm.scala 384:14]
      dmx1_mem_addra_reg <= 3'h0; // @[tsqr_fsm.scala 386:28]
    end else begin
      dmx1_mem_addra_reg <= dmx1_mem_addra_wire; // @[tsqr_fsm.scala 399:28]
    end
    if (rst) begin // @[tsqr_fsm.scala 384:14]
      rtri_mem_addra_reg <= 3'h0; // @[tsqr_fsm.scala 387:28]
    end else begin
      rtri_mem_addra_reg <= rtri_mem_addra_wire; // @[tsqr_fsm.scala 400:28]
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
  hh_en = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  nxt_hh_en = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  cnt = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  nxt_hh_cnt = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  nxt_mx_cnt = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  tr_cy_reg = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  tr_cnt_en = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  tr_cnt = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  tr_cnt_en_2 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  d1_rdy_REG = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  d1_vld_REG = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  d2_vld_REG = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  vk1_vld_REG = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  d3_rdy_REG = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  d3_vld_REG = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  tk_vld_REG = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  yj_sft_REG = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  dmx0_mem_enb_reg = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  dmx1_mem_enb_reg = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  rtri_mem_enb_reg = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  dmx0_mem_ena_reg = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  dmx1_mem_ena_reg = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  rtri_mem_ena_reg = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  dmx0_mem_addrb_reg = _RAND_23[2:0];
  _RAND_24 = {1{`RANDOM}};
  dmx1_mem_addrb_reg = _RAND_24[2:0];
  _RAND_25 = {1{`RANDOM}};
  rtri_mem_addrb_reg = _RAND_25[2:0];
  _RAND_26 = {1{`RANDOM}};
  dmx0_mem_wea_reg = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  dmx1_mem_wea_reg = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  rtri_mem_wea_reg = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  rtri_mem_wea_update = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  dmx0_mem_addra_reg = _RAND_30[2:0];
  _RAND_31 = {1{`RANDOM}};
  dmx1_mem_addra_reg = _RAND_31[2:0];
  _RAND_32 = {1{`RANDOM}};
  rtri_mem_addra_reg = _RAND_32[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module multiplier(
  input  [23:0] io_in_a,
  input  [23:0] io_in_b,
  output [47:0] io_out_s
);
  assign io_out_s = io_in_a * io_in_b; // @[BinaryDesigns.scala 81:23]
endmodule
module full_subber(
  input  [7:0] io_in_a,
  input  [7:0] io_in_b,
  output [7:0] io_out_s,
  output       io_out_c
);
  wire [8:0] _result_T = io_in_a - io_in_b; // @[BinaryDesigns.scala 69:23]
  wire [9:0] _result_T_2 = _result_T - 9'h0; // @[BinaryDesigns.scala 69:34]
  wire [8:0] result = _result_T_2[8:0]; // @[BinaryDesigns.scala 68:22 69:12]
  assign io_out_s = result[7:0]; // @[BinaryDesigns.scala 70:23]
  assign io_out_c = result[8]; // @[BinaryDesigns.scala 71:23]
endmodule
module twoscomplement(
  input  [7:0] io_in,
  output [7:0] io_out
);
  wire [7:0] _x_T = ~io_in; // @[BinaryDesigns.scala 25:16]
  assign io_out = 8'h1 + _x_T; // @[BinaryDesigns.scala 25:14]
endmodule
module full_adder(
  input  [7:0] io_in_a,
  input  [7:0] io_in_b,
  output [7:0] io_out_s,
  output       io_out_c
);
  wire [8:0] _result_T = io_in_a + io_in_b; // @[BinaryDesigns.scala 55:23]
  wire [9:0] _result_T_1 = {{1'd0}, _result_T}; // @[BinaryDesigns.scala 55:34]
  wire [8:0] result = _result_T_1[8:0]; // @[BinaryDesigns.scala 54:22 55:12]
  assign io_out_s = result[7:0]; // @[BinaryDesigns.scala 56:23]
  assign io_out_c = result[8]; // @[BinaryDesigns.scala 57:23]
endmodule
module FP_multiplier_10ccs(
  input         clock,
  input         reset,
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
  reg [63:0] _RAND_32;
  reg [63:0] _RAND_33;
  reg [63:0] _RAND_34;
  reg [63:0] _RAND_35;
  reg [63:0] _RAND_36;
  reg [63:0] _RAND_37;
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
`endif // RANDOMIZE_REG_INIT
  wire [23:0] multiplier_io_in_a; // @[FloatingPointDesigns.scala 1723:28]
  wire [23:0] multiplier_io_in_b; // @[FloatingPointDesigns.scala 1723:28]
  wire [47:0] multiplier_io_out_s; // @[FloatingPointDesigns.scala 1723:28]
  wire [7:0] subber_io_in_a; // @[FloatingPointDesigns.scala 1730:24]
  wire [7:0] subber_io_in_b; // @[FloatingPointDesigns.scala 1730:24]
  wire [7:0] subber_io_out_s; // @[FloatingPointDesigns.scala 1730:24]
  wire  subber_io_out_c; // @[FloatingPointDesigns.scala 1730:24]
  wire [7:0] complementN_io_in; // @[FloatingPointDesigns.scala 1739:29]
  wire [7:0] complementN_io_out; // @[FloatingPointDesigns.scala 1739:29]
  wire [7:0] adderN_io_in_a; // @[FloatingPointDesigns.scala 1756:24]
  wire [7:0] adderN_io_in_b; // @[FloatingPointDesigns.scala 1756:24]
  wire [7:0] adderN_io_out_s; // @[FloatingPointDesigns.scala 1756:24]
  wire  adderN_io_out_c; // @[FloatingPointDesigns.scala 1756:24]
  wire  s_0 = io_in_a[31]; // @[FloatingPointDesigns.scala 1689:20]
  wire  s_1 = io_in_b[31]; // @[FloatingPointDesigns.scala 1690:20]
  wire [8:0] _T_2 = 9'h100 - 9'h2; // @[FloatingPointDesigns.scala 1694:64]
  wire [8:0] _GEN_63 = {{1'd0}, io_in_a[30:23]}; // @[FloatingPointDesigns.scala 1694:36]
  wire [7:0] _GEN_0 = io_in_a[30:23] < 8'h1 ? 8'h1 : io_in_a[30:23]; // @[FloatingPointDesigns.scala 1696:45 1697:14 1699:14]
  wire [8:0] _GEN_1 = _GEN_63 > _T_2 ? _T_2 : {{1'd0}, _GEN_0}; // @[FloatingPointDesigns.scala 1694:71 1695:14]
  wire [8:0] _GEN_64 = {{1'd0}, io_in_b[30:23]}; // @[FloatingPointDesigns.scala 1701:36]
  wire [7:0] _GEN_2 = io_in_b[30:23] < 8'h1 ? 8'h1 : io_in_b[30:23]; // @[FloatingPointDesigns.scala 1703:45 1704:14 1706:14]
  wire [8:0] _GEN_3 = _GEN_64 > _T_2 ? _T_2 : {{1'd0}, _GEN_2}; // @[FloatingPointDesigns.scala 1701:71 1702:14]
  wire [22:0] frac_0 = io_in_a[22:0]; // @[FloatingPointDesigns.scala 1711:23]
  wire [22:0] frac_1 = io_in_b[22:0]; // @[FloatingPointDesigns.scala 1712:23]
  wire [23:0] new_frac_0 = {1'h1,frac_0}; // @[FloatingPointDesigns.scala 1716:24]
  wire [23:0] new_frac_1 = {1'h1,frac_1}; // @[FloatingPointDesigns.scala 1717:24]
  reg  s_reg_0_0; // @[FloatingPointDesigns.scala 1719:24]
  reg  s_reg_0_1; // @[FloatingPointDesigns.scala 1719:24]
  reg  s_reg_1_0; // @[FloatingPointDesigns.scala 1719:24]
  reg  s_reg_1_1; // @[FloatingPointDesigns.scala 1719:24]
  reg  s_reg_2_0; // @[FloatingPointDesigns.scala 1719:24]
  reg  s_reg_2_1; // @[FloatingPointDesigns.scala 1719:24]
  reg  s_reg_3_0; // @[FloatingPointDesigns.scala 1719:24]
  reg  s_reg_3_1; // @[FloatingPointDesigns.scala 1719:24]
  reg  s_reg_4_0; // @[FloatingPointDesigns.scala 1719:24]
  reg  s_reg_4_1; // @[FloatingPointDesigns.scala 1719:24]
  reg [7:0] exp_reg_0_0; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_0_1; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_1_0; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_1_1; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_2_0; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_2_1; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_3_0; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_3_1; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_4_0; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_4_1; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_5_0; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_5_1; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_6_0; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_6_1; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_7_0; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_7_1; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_8_0; // @[FloatingPointDesigns.scala 1720:26]
  reg [7:0] exp_reg_8_1; // @[FloatingPointDesigns.scala 1720:26]
  reg [23:0] new_frac_reg_0_0; // @[FloatingPointDesigns.scala 1721:31]
  reg [23:0] new_frac_reg_0_1; // @[FloatingPointDesigns.scala 1721:31]
  reg [23:0] new_frac_reg_1_0; // @[FloatingPointDesigns.scala 1721:31]
  reg [23:0] new_frac_reg_1_1; // @[FloatingPointDesigns.scala 1721:31]
  reg [47:0] multipplier_out_s_reg_0; // @[FloatingPointDesigns.scala 1727:40]
  reg [47:0] multipplier_out_s_reg_1; // @[FloatingPointDesigns.scala 1727:40]
  reg [47:0] multipplier_out_s_reg_2; // @[FloatingPointDesigns.scala 1727:40]
  reg [47:0] multipplier_out_s_reg_3; // @[FloatingPointDesigns.scala 1727:40]
  reg [47:0] multipplier_out_s_reg_4; // @[FloatingPointDesigns.scala 1727:40]
  reg [47:0] multipplier_out_s_reg_5; // @[FloatingPointDesigns.scala 1727:40]
  reg [7:0] subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1735:35]
  reg [7:0] complementN_out_reg_0; // @[FloatingPointDesigns.scala 1742:38]
  reg [7:0] complementN_out_reg_1; // @[FloatingPointDesigns.scala 1742:38]
  reg [7:0] complementN_out_reg_2; // @[FloatingPointDesigns.scala 1742:38]
  wire  new_s = s_reg_4_0 ^ s_reg_4_1; // @[FloatingPointDesigns.scala 1745:26]
  reg  new_s_reg_0; // @[FloatingPointDesigns.scala 1747:28]
  reg  new_s_reg_1; // @[FloatingPointDesigns.scala 1747:28]
  reg  new_s_reg_2; // @[FloatingPointDesigns.scala 1747:28]
  reg  new_s_reg_3; // @[FloatingPointDesigns.scala 1747:28]
  wire  is_exp1_neg_wire = exp_reg_5_1 < 8'h7f; // @[FloatingPointDesigns.scala 1750:40]
  reg  is_exp1_neg_reg_0; // @[FloatingPointDesigns.scala 1752:34]
  reg  is_exp1_neg_reg_1; // @[FloatingPointDesigns.scala 1752:34]
  wire [7:0] _adderN_io_in_a_T_1 = exp_reg_6_0 + 8'h1; // @[FloatingPointDesigns.scala 1760:39]
  reg [7:0] adderN_out_s_reg_0; // @[FloatingPointDesigns.scala 1767:35]
  reg  adderN_out_c_reg_0; // @[FloatingPointDesigns.scala 1768:35]
  reg [7:0] new_exp_reg_0; // @[FloatingPointDesigns.scala 1770:30]
  reg [22:0] new_mant_reg_0; // @[FloatingPointDesigns.scala 1771:31]
  reg [31:0] reg_out_s; // @[FloatingPointDesigns.scala 1773:28]
  wire  _new_exp_reg_0_T_1 = ~adderN_out_c_reg_0; // @[FloatingPointDesigns.scala 1777:55]
  wire [7:0] _new_exp_reg_0_T_2 = ~adderN_out_c_reg_0 ? 8'h1 : adderN_out_s_reg_0; // @[FloatingPointDesigns.scala 1777:54]
  wire  _new_exp_reg_0_T_5 = adderN_out_c_reg_0 | adderN_out_s_reg_0 > 8'hfe; // @[FloatingPointDesigns.scala 1777:142]
  wire [7:0] _new_exp_reg_0_T_6 = adderN_out_c_reg_0 | adderN_out_s_reg_0 > 8'hfe ? 8'hfe : adderN_out_s_reg_0; // @[FloatingPointDesigns.scala 1777:114]
  wire [7:0] _new_exp_reg_0_T_7 = is_exp1_neg_reg_1 ? _new_exp_reg_0_T_2 : _new_exp_reg_0_T_6; // @[FloatingPointDesigns.scala 1777:30]
  wire [31:0] _reg_out_s_T_1 = {new_s_reg_3,new_exp_reg_0,new_mant_reg_0}; // @[FloatingPointDesigns.scala 1819:53]
  wire [7:0] exp_0 = _GEN_1[7:0]; // @[FloatingPointDesigns.scala 1693:19]
  wire [7:0] exp_1 = _GEN_3[7:0]; // @[FloatingPointDesigns.scala 1693:19]
  wire [47:0] _GEN_17 = multiplier_io_out_s; // @[FloatingPointDesigns.scala 1775:19 1787:32 1727:40]
  wire [7:0] _GEN_18 = subber_io_out_s; // @[FloatingPointDesigns.scala 1775:19 1788:27 1735:35]
  wire [7:0] _GEN_20 = complementN_io_out; // @[FloatingPointDesigns.scala 1775:19 1790:30 1742:38]
  wire [7:0] _GEN_23 = adderN_io_out_s; // @[FloatingPointDesigns.scala 1775:19 1793:27 1767:35]
  wire  _GEN_24 = adderN_io_out_c; // @[FloatingPointDesigns.scala 1775:19 1794:27 1768:35]
  multiplier multiplier ( // @[FloatingPointDesigns.scala 1723:28]
    .io_in_a(multiplier_io_in_a),
    .io_in_b(multiplier_io_in_b),
    .io_out_s(multiplier_io_out_s)
  );
  full_subber subber ( // @[FloatingPointDesigns.scala 1730:24]
    .io_in_a(subber_io_in_a),
    .io_in_b(subber_io_in_b),
    .io_out_s(subber_io_out_s),
    .io_out_c(subber_io_out_c)
  );
  twoscomplement complementN ( // @[FloatingPointDesigns.scala 1739:29]
    .io_in(complementN_io_in),
    .io_out(complementN_io_out)
  );
  full_adder adderN ( // @[FloatingPointDesigns.scala 1756:24]
    .io_in_a(adderN_io_in_a),
    .io_in_b(adderN_io_in_b),
    .io_out_s(adderN_io_out_s),
    .io_out_c(adderN_io_out_c)
  );
  assign io_out_s = reg_out_s; // @[FloatingPointDesigns.scala 1822:14]
  assign multiplier_io_in_a = new_frac_reg_1_0; // @[FloatingPointDesigns.scala 1724:24]
  assign multiplier_io_in_b = new_frac_reg_1_1; // @[FloatingPointDesigns.scala 1725:24]
  assign subber_io_in_a = 8'h7f; // @[FloatingPointDesigns.scala 1731:20]
  assign subber_io_in_b = exp_reg_2_1; // @[FloatingPointDesigns.scala 1732:20]
  assign complementN_io_in = subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1740:23]
  assign adderN_io_in_a = multipplier_out_s_reg_4[47] ? _adderN_io_in_a_T_1 : exp_reg_6_0; // @[FloatingPointDesigns.scala 1759:70 1760:22 1763:22]
  assign adderN_io_in_b = complementN_out_reg_2; // @[FloatingPointDesigns.scala 1759:70 1761:22 1764:22]
  always @(posedge clock) begin
    if (reset) begin // @[FloatingPointDesigns.scala 1719:24]
      s_reg_0_0 <= 1'h0; // @[FloatingPointDesigns.scala 1719:24]
    end else begin
      s_reg_0_0 <= s_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1719:24]
      s_reg_0_1 <= 1'h0; // @[FloatingPointDesigns.scala 1719:24]
    end else begin
      s_reg_0_1 <= s_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1719:24]
      s_reg_1_0 <= 1'h0; // @[FloatingPointDesigns.scala 1719:24]
    end else begin
      s_reg_1_0 <= s_reg_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1719:24]
      s_reg_1_1 <= 1'h0; // @[FloatingPointDesigns.scala 1719:24]
    end else begin
      s_reg_1_1 <= s_reg_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1719:24]
      s_reg_2_0 <= 1'h0; // @[FloatingPointDesigns.scala 1719:24]
    end else begin
      s_reg_2_0 <= s_reg_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1719:24]
      s_reg_2_1 <= 1'h0; // @[FloatingPointDesigns.scala 1719:24]
    end else begin
      s_reg_2_1 <= s_reg_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1719:24]
      s_reg_3_0 <= 1'h0; // @[FloatingPointDesigns.scala 1719:24]
    end else begin
      s_reg_3_0 <= s_reg_2_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1719:24]
      s_reg_3_1 <= 1'h0; // @[FloatingPointDesigns.scala 1719:24]
    end else begin
      s_reg_3_1 <= s_reg_2_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1719:24]
      s_reg_4_0 <= 1'h0; // @[FloatingPointDesigns.scala 1719:24]
    end else begin
      s_reg_4_0 <= s_reg_3_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1719:24]
      s_reg_4_1 <= 1'h0; // @[FloatingPointDesigns.scala 1719:24]
    end else begin
      s_reg_4_1 <= s_reg_3_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_0_0 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_0_0 <= exp_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_0_1 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_0_1 <= exp_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_1_0 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_1_0 <= exp_reg_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_1_1 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_1_1 <= exp_reg_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_2_0 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_2_0 <= exp_reg_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_2_1 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_2_1 <= exp_reg_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_3_0 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_3_0 <= exp_reg_2_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_3_1 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_3_1 <= exp_reg_2_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_4_0 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_4_0 <= exp_reg_3_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_4_1 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_4_1 <= exp_reg_3_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_5_0 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_5_0 <= exp_reg_4_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_5_1 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_5_1 <= exp_reg_4_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_6_0 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_6_0 <= exp_reg_5_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_6_1 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_6_1 <= exp_reg_5_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_7_0 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_7_0 <= exp_reg_6_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_7_1 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_7_1 <= exp_reg_6_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_8_0 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_8_0 <= exp_reg_7_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1720:26]
      exp_reg_8_1 <= 8'h0; // @[FloatingPointDesigns.scala 1720:26]
    end else begin
      exp_reg_8_1 <= exp_reg_7_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1721:31]
      new_frac_reg_0_0 <= 24'h0; // @[FloatingPointDesigns.scala 1721:31]
    end else begin
      new_frac_reg_0_0 <= new_frac_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1721:31]
      new_frac_reg_0_1 <= 24'h0; // @[FloatingPointDesigns.scala 1721:31]
    end else begin
      new_frac_reg_0_1 <= new_frac_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1721:31]
      new_frac_reg_1_0 <= 24'h0; // @[FloatingPointDesigns.scala 1721:31]
    end else begin
      new_frac_reg_1_0 <= new_frac_reg_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1721:31]
      new_frac_reg_1_1 <= 24'h0; // @[FloatingPointDesigns.scala 1721:31]
    end else begin
      new_frac_reg_1_1 <= new_frac_reg_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1727:40]
      multipplier_out_s_reg_0 <= 48'h0; // @[FloatingPointDesigns.scala 1727:40]
    end else begin
      multipplier_out_s_reg_0 <= _GEN_17;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1727:40]
      multipplier_out_s_reg_1 <= 48'h0; // @[FloatingPointDesigns.scala 1727:40]
    end else begin
      multipplier_out_s_reg_1 <= multipplier_out_s_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1727:40]
      multipplier_out_s_reg_2 <= 48'h0; // @[FloatingPointDesigns.scala 1727:40]
    end else begin
      multipplier_out_s_reg_2 <= multipplier_out_s_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1727:40]
      multipplier_out_s_reg_3 <= 48'h0; // @[FloatingPointDesigns.scala 1727:40]
    end else begin
      multipplier_out_s_reg_3 <= multipplier_out_s_reg_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1727:40]
      multipplier_out_s_reg_4 <= 48'h0; // @[FloatingPointDesigns.scala 1727:40]
    end else begin
      multipplier_out_s_reg_4 <= multipplier_out_s_reg_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1727:40]
      multipplier_out_s_reg_5 <= 48'h0; // @[FloatingPointDesigns.scala 1727:40]
    end else begin
      multipplier_out_s_reg_5 <= multipplier_out_s_reg_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1735:35]
      subber_out_s_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1735:35]
    end else begin
      subber_out_s_reg_0 <= _GEN_18;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1742:38]
      complementN_out_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1742:38]
    end else begin
      complementN_out_reg_0 <= _GEN_20;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1742:38]
      complementN_out_reg_1 <= 8'h0; // @[FloatingPointDesigns.scala 1742:38]
    end else begin
      complementN_out_reg_1 <= complementN_out_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1742:38]
      complementN_out_reg_2 <= 8'h0; // @[FloatingPointDesigns.scala 1742:38]
    end else begin
      complementN_out_reg_2 <= complementN_out_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1747:28]
      new_s_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1747:28]
    end else begin
      new_s_reg_0 <= new_s;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1747:28]
      new_s_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1747:28]
    end else begin
      new_s_reg_1 <= new_s_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1747:28]
      new_s_reg_2 <= 1'h0; // @[FloatingPointDesigns.scala 1747:28]
    end else begin
      new_s_reg_2 <= new_s_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1747:28]
      new_s_reg_3 <= 1'h0; // @[FloatingPointDesigns.scala 1747:28]
    end else begin
      new_s_reg_3 <= new_s_reg_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1752:34]
      is_exp1_neg_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1752:34]
    end else begin
      is_exp1_neg_reg_0 <= is_exp1_neg_wire;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1752:34]
      is_exp1_neg_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1752:34]
    end else begin
      is_exp1_neg_reg_1 <= is_exp1_neg_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1767:35]
      adderN_out_s_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1767:35]
    end else begin
      adderN_out_s_reg_0 <= _GEN_23;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1768:35]
      adderN_out_c_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1768:35]
    end else begin
      adderN_out_c_reg_0 <= _GEN_24;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1770:30]
      new_exp_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1770:30]
    end else if (multipplier_out_s_reg_5[47]) begin // @[FloatingPointDesigns.scala 1776:72]
      new_exp_reg_0 <= _new_exp_reg_0_T_7; // @[FloatingPointDesigns.scala 1777:24]
    end else begin
      new_exp_reg_0 <= _new_exp_reg_0_T_7; // @[FloatingPointDesigns.scala 1780:24]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1771:31]
      new_mant_reg_0 <= 23'h0; // @[FloatingPointDesigns.scala 1771:31]
    end else if (multipplier_out_s_reg_5[47]) begin // @[FloatingPointDesigns.scala 1776:72]
      if (is_exp1_neg_reg_1) begin // @[FloatingPointDesigns.scala 1778:31]
        if (_new_exp_reg_0_T_1) begin // @[FloatingPointDesigns.scala 1778:55]
          new_mant_reg_0 <= 23'h0;
        end else begin
          new_mant_reg_0 <= multipplier_out_s_reg_5[46:24];
        end
      end else if (_new_exp_reg_0_T_5) begin // @[FloatingPointDesigns.scala 1778:160]
        new_mant_reg_0 <= 23'h7fffff;
      end else begin
        new_mant_reg_0 <= multipplier_out_s_reg_5[46:24];
      end
    end else if (is_exp1_neg_reg_1) begin // @[FloatingPointDesigns.scala 1781:31]
      if (_new_exp_reg_0_T_1) begin // @[FloatingPointDesigns.scala 1781:55]
        new_mant_reg_0 <= 23'h0;
      end else begin
        new_mant_reg_0 <= multipplier_out_s_reg_5[45:23];
      end
    end else if (_new_exp_reg_0_T_5) begin // @[FloatingPointDesigns.scala 1781:156]
      new_mant_reg_0 <= 23'h7fffff;
    end else begin
      new_mant_reg_0 <= multipplier_out_s_reg_5[45:23];
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1773:28]
      reg_out_s <= 32'h0; // @[FloatingPointDesigns.scala 1773:28]
    end else if (exp_reg_8_0 == 8'h0 | exp_reg_8_1 == 8'h0) begin // @[FloatingPointDesigns.scala 1816:60]
      reg_out_s <= 32'h0; // @[FloatingPointDesigns.scala 1817:19]
    end else begin
      reg_out_s <= _reg_out_s_T_1; // @[FloatingPointDesigns.scala 1819:19]
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
  s_reg_0_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  s_reg_0_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  s_reg_1_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  s_reg_1_1 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  s_reg_2_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  s_reg_2_1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  s_reg_3_0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  s_reg_3_1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  s_reg_4_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  s_reg_4_1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  exp_reg_0_0 = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  exp_reg_0_1 = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  exp_reg_1_0 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  exp_reg_1_1 = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  exp_reg_2_0 = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  exp_reg_2_1 = _RAND_15[7:0];
  _RAND_16 = {1{`RANDOM}};
  exp_reg_3_0 = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  exp_reg_3_1 = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  exp_reg_4_0 = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  exp_reg_4_1 = _RAND_19[7:0];
  _RAND_20 = {1{`RANDOM}};
  exp_reg_5_0 = _RAND_20[7:0];
  _RAND_21 = {1{`RANDOM}};
  exp_reg_5_1 = _RAND_21[7:0];
  _RAND_22 = {1{`RANDOM}};
  exp_reg_6_0 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  exp_reg_6_1 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  exp_reg_7_0 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  exp_reg_7_1 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  exp_reg_8_0 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  exp_reg_8_1 = _RAND_27[7:0];
  _RAND_28 = {1{`RANDOM}};
  new_frac_reg_0_0 = _RAND_28[23:0];
  _RAND_29 = {1{`RANDOM}};
  new_frac_reg_0_1 = _RAND_29[23:0];
  _RAND_30 = {1{`RANDOM}};
  new_frac_reg_1_0 = _RAND_30[23:0];
  _RAND_31 = {1{`RANDOM}};
  new_frac_reg_1_1 = _RAND_31[23:0];
  _RAND_32 = {2{`RANDOM}};
  multipplier_out_s_reg_0 = _RAND_32[47:0];
  _RAND_33 = {2{`RANDOM}};
  multipplier_out_s_reg_1 = _RAND_33[47:0];
  _RAND_34 = {2{`RANDOM}};
  multipplier_out_s_reg_2 = _RAND_34[47:0];
  _RAND_35 = {2{`RANDOM}};
  multipplier_out_s_reg_3 = _RAND_35[47:0];
  _RAND_36 = {2{`RANDOM}};
  multipplier_out_s_reg_4 = _RAND_36[47:0];
  _RAND_37 = {2{`RANDOM}};
  multipplier_out_s_reg_5 = _RAND_37[47:0];
  _RAND_38 = {1{`RANDOM}};
  subber_out_s_reg_0 = _RAND_38[7:0];
  _RAND_39 = {1{`RANDOM}};
  complementN_out_reg_0 = _RAND_39[7:0];
  _RAND_40 = {1{`RANDOM}};
  complementN_out_reg_1 = _RAND_40[7:0];
  _RAND_41 = {1{`RANDOM}};
  complementN_out_reg_2 = _RAND_41[7:0];
  _RAND_42 = {1{`RANDOM}};
  new_s_reg_0 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  new_s_reg_1 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  new_s_reg_2 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  new_s_reg_3 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  is_exp1_neg_reg_0 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  is_exp1_neg_reg_1 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  adderN_out_s_reg_0 = _RAND_48[7:0];
  _RAND_49 = {1{`RANDOM}};
  adderN_out_c_reg_0 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  new_exp_reg_0 = _RAND_50[7:0];
  _RAND_51 = {1{`RANDOM}};
  new_mant_reg_0 = _RAND_51[22:0];
  _RAND_52 = {1{`RANDOM}};
  reg_out_s = _RAND_52[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module full_adder_16(
  input  [23:0] io_in_a,
  input  [23:0] io_in_b,
  output [23:0] io_out_s,
  output        io_out_c
);
  wire [24:0] _result_T = io_in_a + io_in_b; // @[BinaryDesigns.scala 55:23]
  wire [25:0] _result_T_1 = {{1'd0}, _result_T}; // @[BinaryDesigns.scala 55:34]
  wire [24:0] result = _result_T_1[24:0]; // @[BinaryDesigns.scala 54:22 55:12]
  assign io_out_s = result[23:0]; // @[BinaryDesigns.scala 56:23]
  assign io_out_c = result[24]; // @[BinaryDesigns.scala 57:23]
endmodule
module FP_adder_13ccs(
  input         clock,
  input         reset,
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
  wire [7:0] subber_io_in_a; // @[FloatingPointDesigns.scala 1456:24]
  wire [7:0] subber_io_in_b; // @[FloatingPointDesigns.scala 1456:24]
  wire [7:0] subber_io_out_s; // @[FloatingPointDesigns.scala 1456:24]
  wire  subber_io_out_c; // @[FloatingPointDesigns.scala 1456:24]
  wire [23:0] adder_io_in_a; // @[FloatingPointDesigns.scala 1462:23]
  wire [23:0] adder_io_in_b; // @[FloatingPointDesigns.scala 1462:23]
  wire [23:0] adder_io_out_s; // @[FloatingPointDesigns.scala 1462:23]
  wire  adder_io_out_c; // @[FloatingPointDesigns.scala 1462:23]
  wire [7:0] subber2_io_in_a; // @[FloatingPointDesigns.scala 1523:25]
  wire [7:0] subber2_io_in_b; // @[FloatingPointDesigns.scala 1523:25]
  wire [7:0] subber2_io_out_s; // @[FloatingPointDesigns.scala 1523:25]
  wire  subber2_io_out_c; // @[FloatingPointDesigns.scala 1523:25]
  wire  sign_0 = io_in_a[31]; // @[FloatingPointDesigns.scala 1385:23]
  wire  sign_1 = io_in_b[31]; // @[FloatingPointDesigns.scala 1386:23]
  wire [8:0] _T_2 = 9'h100 - 9'h2; // @[FloatingPointDesigns.scala 1389:64]
  wire [8:0] _GEN_167 = {{1'd0}, io_in_a[30:23]}; // @[FloatingPointDesigns.scala 1389:36]
  wire [7:0] _GEN_0 = io_in_a[30:23] < 8'h1 ? 8'h1 : io_in_a[30:23]; // @[FloatingPointDesigns.scala 1391:46 1392:14 1394:14]
  wire [8:0] _GEN_1 = _GEN_167 > _T_2 ? _T_2 : {{1'd0}, _GEN_0}; // @[FloatingPointDesigns.scala 1389:71 1390:14]
  wire [8:0] _GEN_168 = {{1'd0}, io_in_b[30:23]}; // @[FloatingPointDesigns.scala 1396:36]
  wire [7:0] _GEN_2 = io_in_b[30:23] < 8'h1 ? 8'h1 : io_in_b[30:23]; // @[FloatingPointDesigns.scala 1398:45 1399:14 1401:14]
  wire [8:0] _GEN_3 = _GEN_168 > _T_2 ? _T_2 : {{1'd0}, _GEN_2}; // @[FloatingPointDesigns.scala 1396:71 1397:14]
  wire [22:0] frac_0 = io_in_a[22:0]; // @[FloatingPointDesigns.scala 1406:23]
  wire [22:0] frac_1 = io_in_b[22:0]; // @[FloatingPointDesigns.scala 1407:23]
  wire [23:0] whole_frac_0 = {1'h1,frac_0}; // @[FloatingPointDesigns.scala 1411:26]
  wire [23:0] whole_frac_1 = {1'h1,frac_1}; // @[FloatingPointDesigns.scala 1412:26]
  reg  sign_reg_0_0; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_0_1; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_1_0; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_1_1; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_2_0; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_2_1; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_3_0; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_3_1; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_4_0; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_4_1; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_5_0; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_5_1; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_6_0; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_6_1; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_7_0; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_7_1; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_8_0; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_8_1; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_9_0; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_9_1; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_10_0; // @[FloatingPointDesigns.scala 1414:28]
  reg  sign_reg_10_1; // @[FloatingPointDesigns.scala 1414:28]
  reg [7:0] exp_reg_0_0; // @[FloatingPointDesigns.scala 1415:28]
  reg [7:0] exp_reg_0_1; // @[FloatingPointDesigns.scala 1415:28]
  reg [7:0] exp_reg_1_0; // @[FloatingPointDesigns.scala 1415:28]
  reg [7:0] exp_reg_1_1; // @[FloatingPointDesigns.scala 1415:28]
  reg [7:0] exp_reg_2_0; // @[FloatingPointDesigns.scala 1415:28]
  reg [7:0] exp_reg_2_1; // @[FloatingPointDesigns.scala 1415:28]
  reg [22:0] frac_reg_0_0; // @[FloatingPointDesigns.scala 1416:28]
  reg [22:0] frac_reg_0_1; // @[FloatingPointDesigns.scala 1416:28]
  reg [22:0] frac_reg_1_0; // @[FloatingPointDesigns.scala 1416:28]
  reg [22:0] frac_reg_1_1; // @[FloatingPointDesigns.scala 1416:28]
  reg [22:0] frac_reg_2_0; // @[FloatingPointDesigns.scala 1416:28]
  reg [22:0] frac_reg_2_1; // @[FloatingPointDesigns.scala 1416:28]
  reg [23:0] wfrac_reg_0_0; // @[FloatingPointDesigns.scala 1417:28]
  reg [23:0] wfrac_reg_0_1; // @[FloatingPointDesigns.scala 1417:28]
  reg [23:0] wfrac_reg_1_0; // @[FloatingPointDesigns.scala 1417:28]
  reg [23:0] wfrac_reg_1_1; // @[FloatingPointDesigns.scala 1417:28]
  reg [23:0] wfrac_reg_2_0; // @[FloatingPointDesigns.scala 1417:28]
  reg [23:0] wfrac_reg_2_1; // @[FloatingPointDesigns.scala 1417:28]
  reg [7:0] subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1419:35]
  reg [7:0] subber_out_s_reg_1; // @[FloatingPointDesigns.scala 1419:35]
  reg  subber_out_c_reg_0; // @[FloatingPointDesigns.scala 1420:35]
  reg  subber_out_c_reg_1; // @[FloatingPointDesigns.scala 1420:35]
  reg [23:0] wire_temp_add_in_reg_0_0; // @[FloatingPointDesigns.scala 1422:39]
  reg [23:0] wire_temp_add_in_reg_0_1; // @[FloatingPointDesigns.scala 1422:39]
  reg [23:0] wire_temp_add_in_reg_1_0; // @[FloatingPointDesigns.scala 1422:39]
  reg [23:0] wire_temp_add_in_reg_1_1; // @[FloatingPointDesigns.scala 1422:39]
  reg  ref_s_reg_0; // @[FloatingPointDesigns.scala 1424:31]
  reg  ref_s_reg_1; // @[FloatingPointDesigns.scala 1424:31]
  reg  ref_s_reg_2; // @[FloatingPointDesigns.scala 1424:31]
  reg  ref_s_reg_3; // @[FloatingPointDesigns.scala 1424:31]
  reg  ref_s_reg_4; // @[FloatingPointDesigns.scala 1424:31]
  reg  ref_s_reg_5; // @[FloatingPointDesigns.scala 1424:31]
  reg  ref_s_reg_6; // @[FloatingPointDesigns.scala 1424:31]
  reg  ref_s_reg_7; // @[FloatingPointDesigns.scala 1424:31]
  reg [22:0] ref_frac_reg_0; // @[FloatingPointDesigns.scala 1425:31]
  reg [22:0] ref_frac_reg_1; // @[FloatingPointDesigns.scala 1425:31]
  reg [22:0] ref_frac_reg_2; // @[FloatingPointDesigns.scala 1425:31]
  reg [22:0] ref_frac_reg_3; // @[FloatingPointDesigns.scala 1425:31]
  reg [22:0] ref_frac_reg_4; // @[FloatingPointDesigns.scala 1425:31]
  reg [22:0] ref_frac_reg_5; // @[FloatingPointDesigns.scala 1425:31]
  reg [22:0] ref_frac_reg_6; // @[FloatingPointDesigns.scala 1425:31]
  reg [22:0] ref_frac_reg_7; // @[FloatingPointDesigns.scala 1425:31]
  reg [7:0] ref_exp_reg_0; // @[FloatingPointDesigns.scala 1426:31]
  reg [7:0] ref_exp_reg_1; // @[FloatingPointDesigns.scala 1426:31]
  reg [7:0] ref_exp_reg_2; // @[FloatingPointDesigns.scala 1426:31]
  reg [7:0] ref_exp_reg_3; // @[FloatingPointDesigns.scala 1426:31]
  reg [7:0] ref_exp_reg_4; // @[FloatingPointDesigns.scala 1426:31]
  reg [7:0] ref_exp_reg_5; // @[FloatingPointDesigns.scala 1426:31]
  reg [7:0] ref_exp_reg_6; // @[FloatingPointDesigns.scala 1426:31]
  reg [7:0] ref_exp_reg_7; // @[FloatingPointDesigns.scala 1426:31]
  reg [7:0] sub_exp_reg_0; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] sub_exp_reg_1; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] sub_exp_reg_2; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] sub_exp_reg_3; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] sub_exp_reg_4; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] sub_exp_reg_5; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] sub_exp_reg_6; // @[FloatingPointDesigns.scala 1427:31]
  reg [7:0] sub_exp_reg_7; // @[FloatingPointDesigns.scala 1427:31]
  reg [23:0] adder_io_out_s_reg_0; // @[FloatingPointDesigns.scala 1429:37]
  reg [23:0] adder_io_out_s_reg_1; // @[FloatingPointDesigns.scala 1429:37]
  reg [23:0] adder_io_out_s_reg_2; // @[FloatingPointDesigns.scala 1429:37]
  reg  adder_io_out_c_reg_0; // @[FloatingPointDesigns.scala 1430:37]
  reg  new_s_reg_0; // @[FloatingPointDesigns.scala 1432:35]
  reg  new_s_reg_1; // @[FloatingPointDesigns.scala 1432:35]
  reg  new_s_reg_2; // @[FloatingPointDesigns.scala 1432:35]
  reg  new_s_reg_3; // @[FloatingPointDesigns.scala 1432:35]
  reg  new_s_reg_4; // @[FloatingPointDesigns.scala 1432:35]
  reg  new_s_reg_5; // @[FloatingPointDesigns.scala 1432:35]
  reg [22:0] new_out_frac_reg_0; // @[FloatingPointDesigns.scala 1433:35]
  reg [7:0] new_out_exp_reg_0; // @[FloatingPointDesigns.scala 1434:35]
  reg  E_reg_0; // @[FloatingPointDesigns.scala 1435:24]
  reg  E_reg_1; // @[FloatingPointDesigns.scala 1435:24]
  reg  E_reg_2; // @[FloatingPointDesigns.scala 1435:24]
  reg  E_reg_3; // @[FloatingPointDesigns.scala 1435:24]
  reg  E_reg_4; // @[FloatingPointDesigns.scala 1435:24]
  reg  D_reg_0; // @[FloatingPointDesigns.scala 1436:24]
  reg  D_reg_1; // @[FloatingPointDesigns.scala 1436:24]
  reg  D_reg_2; // @[FloatingPointDesigns.scala 1436:24]
  reg  D_reg_3; // @[FloatingPointDesigns.scala 1436:24]
  reg  D_reg_4; // @[FloatingPointDesigns.scala 1436:24]
  reg [23:0] adder_result_reg_0; // @[FloatingPointDesigns.scala 1438:35]
  reg [23:0] adder_result_reg_1; // @[FloatingPointDesigns.scala 1438:35]
  reg [23:0] adder_result_reg_2; // @[FloatingPointDesigns.scala 1438:35]
  reg [5:0] leadingOne_reg_0; // @[FloatingPointDesigns.scala 1440:33]
  reg [5:0] leadingOne_reg_1; // @[FloatingPointDesigns.scala 1440:33]
  reg [31:0] io_in_a_reg_0; // @[FloatingPointDesigns.scala 1442:30]
  reg [31:0] io_in_a_reg_1; // @[FloatingPointDesigns.scala 1442:30]
  reg [31:0] io_in_a_reg_2; // @[FloatingPointDesigns.scala 1442:30]
  reg [31:0] io_in_a_reg_3; // @[FloatingPointDesigns.scala 1442:30]
  reg [31:0] io_in_a_reg_4; // @[FloatingPointDesigns.scala 1442:30]
  reg [31:0] io_in_a_reg_5; // @[FloatingPointDesigns.scala 1442:30]
  reg [31:0] io_in_a_reg_6; // @[FloatingPointDesigns.scala 1442:30]
  reg [31:0] io_in_a_reg_7; // @[FloatingPointDesigns.scala 1442:30]
  reg [31:0] io_in_a_reg_8; // @[FloatingPointDesigns.scala 1442:30]
  reg [31:0] io_in_a_reg_9; // @[FloatingPointDesigns.scala 1442:30]
  reg [31:0] io_in_a_reg_10; // @[FloatingPointDesigns.scala 1442:30]
  reg [31:0] io_in_b_reg_0; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_b_reg_1; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_b_reg_2; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_b_reg_3; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_b_reg_4; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_b_reg_5; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_b_reg_6; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_b_reg_7; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_b_reg_8; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_b_reg_9; // @[FloatingPointDesigns.scala 1443:30]
  reg [31:0] io_in_b_reg_10; // @[FloatingPointDesigns.scala 1443:30]
  reg [7:0] subber2_out_s_reg_0; // @[FloatingPointDesigns.scala 1445:36]
  reg  subber2_out_c_reg_0; // @[FloatingPointDesigns.scala 1446:36]
  reg [7:0] cmpl_subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1467:40]
  wire [7:0] _cmpl_subber_out_s_reg_0_T = ~subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1469:41]
  wire [7:0] _cmpl_subber_out_s_reg_0_T_2 = 8'h1 + _cmpl_subber_out_s_reg_0_T; // @[FloatingPointDesigns.scala 1469:39]
  wire [23:0] _wire_temp_add_in_0_T = wfrac_reg_2_0 >> cmpl_subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1477:46]
  wire [23:0] _wire_temp_add_in_1_T = wfrac_reg_2_1 >> subber_out_s_reg_1; // @[FloatingPointDesigns.scala 1485:46]
  reg [23:0] cmpl_wire_temp_add_in_reg_0_0; // @[FloatingPointDesigns.scala 1488:44]
  reg [23:0] cmpl_wire_temp_add_in_reg_0_1; // @[FloatingPointDesigns.scala 1488:44]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_0_T = ~wire_temp_add_in_reg_0_0; // @[FloatingPointDesigns.scala 1490:48]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_0_T_2 = 24'h1 + _cmpl_wire_temp_add_in_reg_0_0_T; // @[FloatingPointDesigns.scala 1490:46]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_1_T = ~wire_temp_add_in_reg_0_1; // @[FloatingPointDesigns.scala 1491:48]
  wire [23:0] _cmpl_wire_temp_add_in_reg_0_1_T_2 = 24'h1 + _cmpl_wire_temp_add_in_reg_0_1_T; // @[FloatingPointDesigns.scala 1491:46]
  wire [1:0] _adder_io_in_a_T = {sign_reg_4_1,sign_reg_4_0}; // @[FloatingPointDesigns.scala 1494:38]
  wire  _new_s_T = ~adder_io_out_c_reg_0; // @[FloatingPointDesigns.scala 1501:15]
  wire  new_s = ~adder_io_out_c_reg_0 & (sign_reg_5_0 | sign_reg_5_1) | sign_reg_5_0 & sign_reg_5_1; // @[FloatingPointDesigns.scala 1501:75]
  wire  _D_T_1 = sign_reg_5_0 ^ sign_reg_5_1; // @[FloatingPointDesigns.scala 1508:53]
  wire  D = _new_s_T | sign_reg_5_0 ^ sign_reg_5_1; // @[FloatingPointDesigns.scala 1508:35]
  wire  E = _new_s_T & ~adder_io_out_s_reg_0[23] | _new_s_T & ~_D_T_1 | adder_io_out_c_reg_0 & adder_io_out_s_reg_0[23]
     & _D_T_1; // @[FloatingPointDesigns.scala 1510:134]
  reg [23:0] cmpl_adder_io_out_s_reg_0; // @[FloatingPointDesigns.scala 1512:42]
  wire [23:0] _cmpl_adder_io_out_s_reg_0_T = ~adder_io_out_s_reg_1; // @[FloatingPointDesigns.scala 1515:43]
  wire [23:0] _cmpl_adder_io_out_s_reg_0_T_2 = 24'h1 + _cmpl_adder_io_out_s_reg_0_T; // @[FloatingPointDesigns.scala 1515:41]
  wire [1:0] _adder_result_T = {sign_reg_7_1,sign_reg_7_0}; // @[FloatingPointDesigns.scala 1519:53]
  wire [1:0] _leadingOne_T_25 = adder_result_reg_0[2] ? 2'h2 : {{1'd0}, adder_result_reg_0[1]}; // @[FloatingPointDesigns.scala 1522:70]
  wire [1:0] _leadingOne_T_26 = adder_result_reg_0[3] ? 2'h3 : _leadingOne_T_25; // @[FloatingPointDesigns.scala 1522:70]
  wire [2:0] _leadingOne_T_27 = adder_result_reg_0[4] ? 3'h4 : {{1'd0}, _leadingOne_T_26}; // @[FloatingPointDesigns.scala 1522:70]
  wire [2:0] _leadingOne_T_28 = adder_result_reg_0[5] ? 3'h5 : _leadingOne_T_27; // @[FloatingPointDesigns.scala 1522:70]
  wire [2:0] _leadingOne_T_29 = adder_result_reg_0[6] ? 3'h6 : _leadingOne_T_28; // @[FloatingPointDesigns.scala 1522:70]
  wire [2:0] _leadingOne_T_30 = adder_result_reg_0[7] ? 3'h7 : _leadingOne_T_29; // @[FloatingPointDesigns.scala 1522:70]
  wire [3:0] _leadingOne_T_31 = adder_result_reg_0[8] ? 4'h8 : {{1'd0}, _leadingOne_T_30}; // @[FloatingPointDesigns.scala 1522:70]
  wire [3:0] _leadingOne_T_32 = adder_result_reg_0[9] ? 4'h9 : _leadingOne_T_31; // @[FloatingPointDesigns.scala 1522:70]
  wire [3:0] _leadingOne_T_33 = adder_result_reg_0[10] ? 4'ha : _leadingOne_T_32; // @[FloatingPointDesigns.scala 1522:70]
  wire [3:0] _leadingOne_T_34 = adder_result_reg_0[11] ? 4'hb : _leadingOne_T_33; // @[FloatingPointDesigns.scala 1522:70]
  wire [3:0] _leadingOne_T_35 = adder_result_reg_0[12] ? 4'hc : _leadingOne_T_34; // @[FloatingPointDesigns.scala 1522:70]
  wire [3:0] _leadingOne_T_36 = adder_result_reg_0[13] ? 4'hd : _leadingOne_T_35; // @[FloatingPointDesigns.scala 1522:70]
  wire [3:0] _leadingOne_T_37 = adder_result_reg_0[14] ? 4'he : _leadingOne_T_36; // @[FloatingPointDesigns.scala 1522:70]
  wire [3:0] _leadingOne_T_38 = adder_result_reg_0[15] ? 4'hf : _leadingOne_T_37; // @[FloatingPointDesigns.scala 1522:70]
  wire [4:0] _leadingOne_T_39 = adder_result_reg_0[16] ? 5'h10 : {{1'd0}, _leadingOne_T_38}; // @[FloatingPointDesigns.scala 1522:70]
  wire [4:0] _leadingOne_T_40 = adder_result_reg_0[17] ? 5'h11 : _leadingOne_T_39; // @[FloatingPointDesigns.scala 1522:70]
  wire [4:0] _leadingOne_T_41 = adder_result_reg_0[18] ? 5'h12 : _leadingOne_T_40; // @[FloatingPointDesigns.scala 1522:70]
  wire [4:0] _leadingOne_T_42 = adder_result_reg_0[19] ? 5'h13 : _leadingOne_T_41; // @[FloatingPointDesigns.scala 1522:70]
  wire [4:0] _leadingOne_T_43 = adder_result_reg_0[20] ? 5'h14 : _leadingOne_T_42; // @[FloatingPointDesigns.scala 1522:70]
  wire [4:0] _leadingOne_T_44 = adder_result_reg_0[21] ? 5'h15 : _leadingOne_T_43; // @[FloatingPointDesigns.scala 1522:70]
  wire [4:0] _leadingOne_T_45 = adder_result_reg_0[22] ? 5'h16 : _leadingOne_T_44; // @[FloatingPointDesigns.scala 1522:70]
  wire [4:0] _leadingOne_T_46 = adder_result_reg_0[23] ? 5'h17 : _leadingOne_T_45; // @[FloatingPointDesigns.scala 1522:70]
  wire [5:0] leadingOne = _leadingOne_T_46 + 5'h1; // @[FloatingPointDesigns.scala 1522:77]
  wire [5:0] _subber2_io_in_b_T_1 = 6'h18 - leadingOne_reg_0; // @[FloatingPointDesigns.scala 1525:42]
  wire [7:0] exp_0 = _GEN_1[7:0]; // @[FloatingPointDesigns.scala 1387:19]
  wire [7:0] exp_1 = _GEN_3[7:0]; // @[FloatingPointDesigns.scala 1387:19]
  wire [7:0] _GEN_24 = subber_io_out_s; // @[FloatingPointDesigns.scala 1529:19 1538:27 1419:35]
  wire  _GEN_25 = subber_io_out_c; // @[FloatingPointDesigns.scala 1529:19 1539:27 1420:35]
  wire [23:0] _GEN_35 = adder_io_out_s; // @[FloatingPointDesigns.scala 1529:19 1554:29 1429:37]
  wire  _GEN_36 = adder_io_out_c; // @[FloatingPointDesigns.scala 1529:19 1555:29 1430:37]
  wire [7:0] _GEN_39 = subber2_io_out_s; // @[FloatingPointDesigns.scala 1529:19 1561:28 1445:36]
  wire  _GEN_40 = subber2_io_out_c; // @[FloatingPointDesigns.scala 1529:19 1562:28 1446:36]
  reg [31:0] reg_out_s; // @[FloatingPointDesigns.scala 1596:28]
  wire [8:0] _GEN_169 = {{1'd0}, ref_exp_reg_7}; // @[FloatingPointDesigns.scala 1613:29]
  wire [23:0] _new_out_frac_reg_0_T_2 = 24'h800000 - 24'h1; // @[FloatingPointDesigns.scala 1615:60]
  wire [7:0] _new_out_exp_reg_0_T_3 = ref_exp_reg_7 + 8'h1; // @[FloatingPointDesigns.scala 1617:48]
  wire [8:0] _GEN_142 = _GEN_169 == _T_2 ? _T_2 : {{1'd0}, _new_out_exp_reg_0_T_3}; // @[FloatingPointDesigns.scala 1613:66 1614:30 1617:30]
  wire [23:0] _GEN_143 = _GEN_169 == _T_2 ? _new_out_frac_reg_0_T_2 : {{1'd0}, adder_result_reg_2[23:1]}; // @[FloatingPointDesigns.scala 1613:66 1615:31 1618:31]
  wire [5:0] _new_out_frac_reg_0_T_6 = 6'h18 - leadingOne_reg_1; // @[FloatingPointDesigns.scala 1631:94]
  wire [85:0] _GEN_4 = {{63'd0}, adder_result_reg_2[22:0]}; // @[FloatingPointDesigns.scala 1631:73]
  wire [85:0] _new_out_frac_reg_0_T_7 = _GEN_4 << _new_out_frac_reg_0_T_6; // @[FloatingPointDesigns.scala 1631:73]
  wire [7:0] _GEN_144 = subber2_out_c_reg_0 ? 8'h1 : subber2_out_s_reg_0; // @[FloatingPointDesigns.scala 1626:46 1627:32 1630:32]
  wire [85:0] _GEN_145 = subber2_out_c_reg_0 ? 86'h0 : _new_out_frac_reg_0_T_7; // @[FloatingPointDesigns.scala 1626:46 1628:33 1631:33]
  wire [7:0] _GEN_146 = leadingOne_reg_1 == 6'h1 & adder_result_reg_2 == 24'h0 & ((sign_reg_10_0 ^ sign_reg_10_1) &
    io_in_a_reg_10[30:0] == io_in_b_reg_10[30:0]) ? 8'h0 : _GEN_144; // @[FloatingPointDesigns.scala 1622:184 1623:30]
  wire [85:0] _GEN_147 = leadingOne_reg_1 == 6'h1 & adder_result_reg_2 == 24'h0 & ((sign_reg_10_0 ^ sign_reg_10_1) &
    io_in_a_reg_10[30:0] == io_in_b_reg_10[30:0]) ? 86'h0 : _GEN_145; // @[FloatingPointDesigns.scala 1622:184 1624:31]
  wire  _GEN_148 = D_reg_4 ? new_s_reg_4 : new_s_reg_5; // @[FloatingPointDesigns.scala 1620:36 1621:22 1432:35]
  wire [7:0] _GEN_149 = D_reg_4 ? _GEN_146 : new_out_exp_reg_0; // @[FloatingPointDesigns.scala 1434:35 1620:36]
  wire [85:0] _GEN_150 = D_reg_4 ? _GEN_147 : {{63'd0}, new_out_frac_reg_0}; // @[FloatingPointDesigns.scala 1433:35 1620:36]
  wire  _GEN_151 = ~D_reg_4 ? new_s_reg_4 : _GEN_148; // @[FloatingPointDesigns.scala 1611:36 1612:22]
  wire [8:0] _GEN_152 = ~D_reg_4 ? _GEN_142 : {{1'd0}, _GEN_149}; // @[FloatingPointDesigns.scala 1611:36]
  wire [85:0] _GEN_153 = ~D_reg_4 ? {{62'd0}, _GEN_143} : _GEN_150; // @[FloatingPointDesigns.scala 1611:36]
  wire [8:0] _GEN_155 = E_reg_4 ? {{1'd0}, ref_exp_reg_7} : _GEN_152; // @[FloatingPointDesigns.scala 1607:36 1609:28]
  wire [85:0] _GEN_156 = E_reg_4 ? {{63'd0}, adder_result_reg_2[22:0]} : _GEN_153; // @[FloatingPointDesigns.scala 1607:36 1610:29]
  wire [85:0] _GEN_158 = sub_exp_reg_7 >= 8'h17 ? {{63'd0}, ref_frac_reg_7} : _GEN_156; // @[FloatingPointDesigns.scala 1603:48 1605:29]
  wire [8:0] _GEN_159 = sub_exp_reg_7 >= 8'h17 ? {{1'd0}, ref_exp_reg_7} : _GEN_155; // @[FloatingPointDesigns.scala 1603:48 1606:28]
  wire [8:0] _GEN_161 = io_in_a_reg_10[30:0] == 31'h0 & io_in_b_reg_10[30:0] == 31'h0 ? 9'h0 : _GEN_159; // @[FloatingPointDesigns.scala 1599:86 1601:28]
  wire [85:0] _GEN_162 = io_in_a_reg_10[30:0] == 31'h0 & io_in_b_reg_10[30:0] == 31'h0 ? 86'h0 : _GEN_158; // @[FloatingPointDesigns.scala 1599:86 1602:29]
  wire [31:0] _reg_out_s_T_1 = {new_s_reg_5,new_out_exp_reg_0,new_out_frac_reg_0}; // @[FloatingPointDesigns.scala 1635:55]
  wire [85:0] _GEN_170 = reset ? 86'h0 : _GEN_162; // @[FloatingPointDesigns.scala 1433:{35,35}]
  wire [8:0] _GEN_171 = reset ? 9'h0 : _GEN_161; // @[FloatingPointDesigns.scala 1434:{35,35}]
  full_subber subber ( // @[FloatingPointDesigns.scala 1456:24]
    .io_in_a(subber_io_in_a),
    .io_in_b(subber_io_in_b),
    .io_out_s(subber_io_out_s),
    .io_out_c(subber_io_out_c)
  );
  full_adder_16 adder ( // @[FloatingPointDesigns.scala 1462:23]
    .io_in_a(adder_io_in_a),
    .io_in_b(adder_io_in_b),
    .io_out_s(adder_io_out_s),
    .io_out_c(adder_io_out_c)
  );
  full_subber subber2 ( // @[FloatingPointDesigns.scala 1523:25]
    .io_in_a(subber2_io_in_a),
    .io_in_b(subber2_io_in_b),
    .io_out_s(subber2_io_out_s),
    .io_out_c(subber2_io_out_c)
  );
  assign io_out_s = reg_out_s; // @[FloatingPointDesigns.scala 1597:14]
  assign subber_io_in_a = exp_reg_0_0; // @[FloatingPointDesigns.scala 1457:20]
  assign subber_io_in_b = exp_reg_0_1; // @[FloatingPointDesigns.scala 1458:20]
  assign adder_io_in_a = _adder_io_in_a_T == 2'h1 ? cmpl_wire_temp_add_in_reg_0_0 : wire_temp_add_in_reg_1_0; // @[FloatingPointDesigns.scala 1494:25]
  assign adder_io_in_b = _adder_io_in_a_T == 2'h2 ? cmpl_wire_temp_add_in_reg_0_1 : wire_temp_add_in_reg_1_1; // @[FloatingPointDesigns.scala 1495:25]
  assign subber2_io_in_a = ref_exp_reg_6; // @[FloatingPointDesigns.scala 1524:21]
  assign subber2_io_in_b = {{2'd0}, _subber2_io_in_b_T_1}; // @[FloatingPointDesigns.scala 1525:21]
  always @(posedge clock) begin
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_0_0 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_0_0 <= sign_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_0_1 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_0_1 <= sign_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_1_0 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_1_0 <= sign_reg_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_1_1 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_1_1 <= sign_reg_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_2_0 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_2_0 <= sign_reg_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_2_1 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_2_1 <= sign_reg_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_3_0 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_3_0 <= sign_reg_2_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_3_1 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_3_1 <= sign_reg_2_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_4_0 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_4_0 <= sign_reg_3_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_4_1 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_4_1 <= sign_reg_3_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_5_0 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_5_0 <= sign_reg_4_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_5_1 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_5_1 <= sign_reg_4_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_6_0 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_6_0 <= sign_reg_5_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_6_1 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_6_1 <= sign_reg_5_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_7_0 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_7_0 <= sign_reg_6_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_7_1 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_7_1 <= sign_reg_6_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_8_0 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_8_0 <= sign_reg_7_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_8_1 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_8_1 <= sign_reg_7_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_9_0 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_9_0 <= sign_reg_8_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_9_1 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_9_1 <= sign_reg_8_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_10_0 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_10_0 <= sign_reg_9_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1414:28]
      sign_reg_10_1 <= 1'h0; // @[FloatingPointDesigns.scala 1414:28]
    end else begin
      sign_reg_10_1 <= sign_reg_9_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      exp_reg_0_0 <= 8'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else begin
      exp_reg_0_0 <= exp_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      exp_reg_0_1 <= 8'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else begin
      exp_reg_0_1 <= exp_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      exp_reg_1_0 <= 8'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else begin
      exp_reg_1_0 <= exp_reg_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      exp_reg_1_1 <= 8'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else begin
      exp_reg_1_1 <= exp_reg_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      exp_reg_2_0 <= 8'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else begin
      exp_reg_2_0 <= exp_reg_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1415:28]
      exp_reg_2_1 <= 8'h0; // @[FloatingPointDesigns.scala 1415:28]
    end else begin
      exp_reg_2_1 <= exp_reg_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1416:28]
      frac_reg_0_0 <= 23'h0; // @[FloatingPointDesigns.scala 1416:28]
    end else begin
      frac_reg_0_0 <= frac_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1416:28]
      frac_reg_0_1 <= 23'h0; // @[FloatingPointDesigns.scala 1416:28]
    end else begin
      frac_reg_0_1 <= frac_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1416:28]
      frac_reg_1_0 <= 23'h0; // @[FloatingPointDesigns.scala 1416:28]
    end else begin
      frac_reg_1_0 <= frac_reg_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1416:28]
      frac_reg_1_1 <= 23'h0; // @[FloatingPointDesigns.scala 1416:28]
    end else begin
      frac_reg_1_1 <= frac_reg_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1416:28]
      frac_reg_2_0 <= 23'h0; // @[FloatingPointDesigns.scala 1416:28]
    end else begin
      frac_reg_2_0 <= frac_reg_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1416:28]
      frac_reg_2_1 <= 23'h0; // @[FloatingPointDesigns.scala 1416:28]
    end else begin
      frac_reg_2_1 <= frac_reg_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1417:28]
      wfrac_reg_0_0 <= 24'h0; // @[FloatingPointDesigns.scala 1417:28]
    end else begin
      wfrac_reg_0_0 <= whole_frac_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1417:28]
      wfrac_reg_0_1 <= 24'h0; // @[FloatingPointDesigns.scala 1417:28]
    end else begin
      wfrac_reg_0_1 <= whole_frac_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1417:28]
      wfrac_reg_1_0 <= 24'h0; // @[FloatingPointDesigns.scala 1417:28]
    end else begin
      wfrac_reg_1_0 <= wfrac_reg_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1417:28]
      wfrac_reg_1_1 <= 24'h0; // @[FloatingPointDesigns.scala 1417:28]
    end else begin
      wfrac_reg_1_1 <= wfrac_reg_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1417:28]
      wfrac_reg_2_0 <= 24'h0; // @[FloatingPointDesigns.scala 1417:28]
    end else begin
      wfrac_reg_2_0 <= wfrac_reg_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1417:28]
      wfrac_reg_2_1 <= 24'h0; // @[FloatingPointDesigns.scala 1417:28]
    end else begin
      wfrac_reg_2_1 <= wfrac_reg_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1419:35]
      subber_out_s_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1419:35]
    end else begin
      subber_out_s_reg_0 <= _GEN_24;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1419:35]
      subber_out_s_reg_1 <= 8'h0; // @[FloatingPointDesigns.scala 1419:35]
    end else begin
      subber_out_s_reg_1 <= subber_out_s_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1420:35]
      subber_out_c_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1420:35]
    end else begin
      subber_out_c_reg_0 <= _GEN_25;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1420:35]
      subber_out_c_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1420:35]
    end else begin
      subber_out_c_reg_1 <= subber_out_c_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1422:39]
      wire_temp_add_in_reg_0_0 <= 24'h0; // @[FloatingPointDesigns.scala 1422:39]
    end else if (subber_out_c_reg_1) begin // @[FloatingPointDesigns.scala 1472:39]
      wire_temp_add_in_reg_0_0 <= _wire_temp_add_in_0_T; // @[FloatingPointDesigns.scala 1477:27]
    end else begin
      wire_temp_add_in_reg_0_0 <= wfrac_reg_2_0; // @[FloatingPointDesigns.scala 1484:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1422:39]
      wire_temp_add_in_reg_0_1 <= 24'h0; // @[FloatingPointDesigns.scala 1422:39]
    end else if (subber_out_c_reg_1) begin // @[FloatingPointDesigns.scala 1472:39]
      wire_temp_add_in_reg_0_1 <= wfrac_reg_2_1; // @[FloatingPointDesigns.scala 1478:27]
    end else begin
      wire_temp_add_in_reg_0_1 <= _wire_temp_add_in_1_T; // @[FloatingPointDesigns.scala 1485:27]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1422:39]
      wire_temp_add_in_reg_1_0 <= 24'h0; // @[FloatingPointDesigns.scala 1422:39]
    end else begin
      wire_temp_add_in_reg_1_0 <= wire_temp_add_in_reg_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1422:39]
      wire_temp_add_in_reg_1_1 <= 24'h0; // @[FloatingPointDesigns.scala 1422:39]
    end else begin
      wire_temp_add_in_reg_1_1 <= wire_temp_add_in_reg_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1424:31]
      ref_s_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1424:31]
    end else if (subber_out_c_reg_1) begin // @[FloatingPointDesigns.scala 1472:39]
      ref_s_reg_0 <= sign_reg_2_1; // @[FloatingPointDesigns.scala 1475:13]
    end else begin
      ref_s_reg_0 <= sign_reg_2_0; // @[FloatingPointDesigns.scala 1482:13]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1424:31]
      ref_s_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1424:31]
    end else begin
      ref_s_reg_1 <= ref_s_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1424:31]
      ref_s_reg_2 <= 1'h0; // @[FloatingPointDesigns.scala 1424:31]
    end else begin
      ref_s_reg_2 <= ref_s_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1424:31]
      ref_s_reg_3 <= 1'h0; // @[FloatingPointDesigns.scala 1424:31]
    end else begin
      ref_s_reg_3 <= ref_s_reg_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1424:31]
      ref_s_reg_4 <= 1'h0; // @[FloatingPointDesigns.scala 1424:31]
    end else begin
      ref_s_reg_4 <= ref_s_reg_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1424:31]
      ref_s_reg_5 <= 1'h0; // @[FloatingPointDesigns.scala 1424:31]
    end else begin
      ref_s_reg_5 <= ref_s_reg_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1424:31]
      ref_s_reg_6 <= 1'h0; // @[FloatingPointDesigns.scala 1424:31]
    end else begin
      ref_s_reg_6 <= ref_s_reg_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1424:31]
      ref_s_reg_7 <= 1'h0; // @[FloatingPointDesigns.scala 1424:31]
    end else begin
      ref_s_reg_7 <= ref_s_reg_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_frac_reg_0 <= 23'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else if (subber_out_c_reg_1) begin // @[FloatingPointDesigns.scala 1472:39]
      ref_frac_reg_0 <= frac_reg_2_1; // @[FloatingPointDesigns.scala 1476:16]
    end else begin
      ref_frac_reg_0 <= frac_reg_2_0; // @[FloatingPointDesigns.scala 1483:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_frac_reg_1 <= 23'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else begin
      ref_frac_reg_1 <= ref_frac_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_frac_reg_2 <= 23'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else begin
      ref_frac_reg_2 <= ref_frac_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_frac_reg_3 <= 23'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else begin
      ref_frac_reg_3 <= ref_frac_reg_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_frac_reg_4 <= 23'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else begin
      ref_frac_reg_4 <= ref_frac_reg_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_frac_reg_5 <= 23'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else begin
      ref_frac_reg_5 <= ref_frac_reg_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_frac_reg_6 <= 23'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else begin
      ref_frac_reg_6 <= ref_frac_reg_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1425:31]
      ref_frac_reg_7 <= 23'h0; // @[FloatingPointDesigns.scala 1425:31]
    end else begin
      ref_frac_reg_7 <= ref_frac_reg_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_exp_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else if (subber_out_c_reg_1) begin // @[FloatingPointDesigns.scala 1472:39]
      ref_exp_reg_0 <= exp_reg_2_1; // @[FloatingPointDesigns.scala 1473:15]
    end else begin
      ref_exp_reg_0 <= exp_reg_2_0; // @[FloatingPointDesigns.scala 1480:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_exp_reg_1 <= 8'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else begin
      ref_exp_reg_1 <= ref_exp_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_exp_reg_2 <= 8'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else begin
      ref_exp_reg_2 <= ref_exp_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_exp_reg_3 <= 8'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else begin
      ref_exp_reg_3 <= ref_exp_reg_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_exp_reg_4 <= 8'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else begin
      ref_exp_reg_4 <= ref_exp_reg_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_exp_reg_5 <= 8'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else begin
      ref_exp_reg_5 <= ref_exp_reg_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_exp_reg_6 <= 8'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else begin
      ref_exp_reg_6 <= ref_exp_reg_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1426:31]
      ref_exp_reg_7 <= 8'h0; // @[FloatingPointDesigns.scala 1426:31]
    end else begin
      ref_exp_reg_7 <= ref_exp_reg_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      sub_exp_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else if (subber_out_c_reg_1) begin // @[FloatingPointDesigns.scala 1472:39]
      sub_exp_reg_0 <= cmpl_subber_out_s_reg_0; // @[FloatingPointDesigns.scala 1474:15]
    end else begin
      sub_exp_reg_0 <= subber_out_s_reg_1; // @[FloatingPointDesigns.scala 1481:15]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      sub_exp_reg_1 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else begin
      sub_exp_reg_1 <= sub_exp_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      sub_exp_reg_2 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else begin
      sub_exp_reg_2 <= sub_exp_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      sub_exp_reg_3 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else begin
      sub_exp_reg_3 <= sub_exp_reg_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      sub_exp_reg_4 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else begin
      sub_exp_reg_4 <= sub_exp_reg_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      sub_exp_reg_5 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else begin
      sub_exp_reg_5 <= sub_exp_reg_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      sub_exp_reg_6 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else begin
      sub_exp_reg_6 <= sub_exp_reg_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1427:31]
      sub_exp_reg_7 <= 8'h0; // @[FloatingPointDesigns.scala 1427:31]
    end else begin
      sub_exp_reg_7 <= sub_exp_reg_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1429:37]
      adder_io_out_s_reg_0 <= 24'h0; // @[FloatingPointDesigns.scala 1429:37]
    end else begin
      adder_io_out_s_reg_0 <= _GEN_35;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1429:37]
      adder_io_out_s_reg_1 <= 24'h0; // @[FloatingPointDesigns.scala 1429:37]
    end else begin
      adder_io_out_s_reg_1 <= adder_io_out_s_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1429:37]
      adder_io_out_s_reg_2 <= 24'h0; // @[FloatingPointDesigns.scala 1429:37]
    end else begin
      adder_io_out_s_reg_2 <= adder_io_out_s_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1430:37]
      adder_io_out_c_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1430:37]
    end else begin
      adder_io_out_c_reg_0 <= _GEN_36;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1432:35]
      new_s_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1432:35]
    end else begin
      new_s_reg_0 <= new_s;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1432:35]
      new_s_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1432:35]
    end else begin
      new_s_reg_1 <= new_s_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1432:35]
      new_s_reg_2 <= 1'h0; // @[FloatingPointDesigns.scala 1432:35]
    end else begin
      new_s_reg_2 <= new_s_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1432:35]
      new_s_reg_3 <= 1'h0; // @[FloatingPointDesigns.scala 1432:35]
    end else begin
      new_s_reg_3 <= new_s_reg_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1432:35]
      new_s_reg_4 <= 1'h0; // @[FloatingPointDesigns.scala 1432:35]
    end else begin
      new_s_reg_4 <= new_s_reg_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1432:35]
      new_s_reg_5 <= 1'h0; // @[FloatingPointDesigns.scala 1432:35]
    end else if (io_in_a_reg_10[30:0] == 31'h0 & io_in_b_reg_10[30:0] == 31'h0) begin // @[FloatingPointDesigns.scala 1599:86]
      new_s_reg_5 <= 1'h0; // @[FloatingPointDesigns.scala 1600:22]
    end else if (sub_exp_reg_7 >= 8'h17) begin // @[FloatingPointDesigns.scala 1603:48]
      new_s_reg_5 <= ref_s_reg_7; // @[FloatingPointDesigns.scala 1604:22]
    end else if (E_reg_4) begin // @[FloatingPointDesigns.scala 1607:36]
      new_s_reg_5 <= new_s_reg_4; // @[FloatingPointDesigns.scala 1608:22]
    end else begin
      new_s_reg_5 <= _GEN_151;
    end
    new_out_frac_reg_0 <= _GEN_170[22:0]; // @[FloatingPointDesigns.scala 1433:{35,35}]
    new_out_exp_reg_0 <= _GEN_171[7:0]; // @[FloatingPointDesigns.scala 1434:{35,35}]
    if (reset) begin // @[FloatingPointDesigns.scala 1435:24]
      E_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1435:24]
    end else begin
      E_reg_0 <= E;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1435:24]
      E_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1435:24]
    end else begin
      E_reg_1 <= E_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1435:24]
      E_reg_2 <= 1'h0; // @[FloatingPointDesigns.scala 1435:24]
    end else begin
      E_reg_2 <= E_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1435:24]
      E_reg_3 <= 1'h0; // @[FloatingPointDesigns.scala 1435:24]
    end else begin
      E_reg_3 <= E_reg_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1435:24]
      E_reg_4 <= 1'h0; // @[FloatingPointDesigns.scala 1435:24]
    end else begin
      E_reg_4 <= E_reg_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1436:24]
      D_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1436:24]
    end else begin
      D_reg_0 <= D;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1436:24]
      D_reg_1 <= 1'h0; // @[FloatingPointDesigns.scala 1436:24]
    end else begin
      D_reg_1 <= D_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1436:24]
      D_reg_2 <= 1'h0; // @[FloatingPointDesigns.scala 1436:24]
    end else begin
      D_reg_2 <= D_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1436:24]
      D_reg_3 <= 1'h0; // @[FloatingPointDesigns.scala 1436:24]
    end else begin
      D_reg_3 <= D_reg_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1436:24]
      D_reg_4 <= 1'h0; // @[FloatingPointDesigns.scala 1436:24]
    end else begin
      D_reg_4 <= D_reg_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1438:35]
      adder_result_reg_0 <= 24'h0; // @[FloatingPointDesigns.scala 1438:35]
    end else if (new_s_reg_1 & ^_adder_result_T) begin // @[FloatingPointDesigns.scala 1519:24]
      adder_result_reg_0 <= cmpl_adder_io_out_s_reg_0;
    end else begin
      adder_result_reg_0 <= adder_io_out_s_reg_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1438:35]
      adder_result_reg_1 <= 24'h0; // @[FloatingPointDesigns.scala 1438:35]
    end else begin
      adder_result_reg_1 <= adder_result_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1438:35]
      adder_result_reg_2 <= 24'h0; // @[FloatingPointDesigns.scala 1438:35]
    end else begin
      adder_result_reg_2 <= adder_result_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1440:33]
      leadingOne_reg_0 <= 6'h0; // @[FloatingPointDesigns.scala 1440:33]
    end else begin
      leadingOne_reg_0 <= leadingOne;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1440:33]
      leadingOne_reg_1 <= 6'h0; // @[FloatingPointDesigns.scala 1440:33]
    end else begin
      leadingOne_reg_1 <= leadingOne_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1442:30]
      io_in_a_reg_0 <= 32'h0; // @[FloatingPointDesigns.scala 1442:30]
    end else begin
      io_in_a_reg_0 <= io_in_a;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1442:30]
      io_in_a_reg_1 <= 32'h0; // @[FloatingPointDesigns.scala 1442:30]
    end else begin
      io_in_a_reg_1 <= io_in_a_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1442:30]
      io_in_a_reg_2 <= 32'h0; // @[FloatingPointDesigns.scala 1442:30]
    end else begin
      io_in_a_reg_2 <= io_in_a_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1442:30]
      io_in_a_reg_3 <= 32'h0; // @[FloatingPointDesigns.scala 1442:30]
    end else begin
      io_in_a_reg_3 <= io_in_a_reg_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1442:30]
      io_in_a_reg_4 <= 32'h0; // @[FloatingPointDesigns.scala 1442:30]
    end else begin
      io_in_a_reg_4 <= io_in_a_reg_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1442:30]
      io_in_a_reg_5 <= 32'h0; // @[FloatingPointDesigns.scala 1442:30]
    end else begin
      io_in_a_reg_5 <= io_in_a_reg_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1442:30]
      io_in_a_reg_6 <= 32'h0; // @[FloatingPointDesigns.scala 1442:30]
    end else begin
      io_in_a_reg_6 <= io_in_a_reg_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1442:30]
      io_in_a_reg_7 <= 32'h0; // @[FloatingPointDesigns.scala 1442:30]
    end else begin
      io_in_a_reg_7 <= io_in_a_reg_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1442:30]
      io_in_a_reg_8 <= 32'h0; // @[FloatingPointDesigns.scala 1442:30]
    end else begin
      io_in_a_reg_8 <= io_in_a_reg_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1442:30]
      io_in_a_reg_9 <= 32'h0; // @[FloatingPointDesigns.scala 1442:30]
    end else begin
      io_in_a_reg_9 <= io_in_a_reg_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1442:30]
      io_in_a_reg_10 <= 32'h0; // @[FloatingPointDesigns.scala 1442:30]
    end else begin
      io_in_a_reg_10 <= io_in_a_reg_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_b_reg_0 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else begin
      io_in_b_reg_0 <= io_in_b;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_b_reg_1 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else begin
      io_in_b_reg_1 <= io_in_b_reg_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_b_reg_2 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else begin
      io_in_b_reg_2 <= io_in_b_reg_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_b_reg_3 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else begin
      io_in_b_reg_3 <= io_in_b_reg_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_b_reg_4 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else begin
      io_in_b_reg_4 <= io_in_b_reg_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_b_reg_5 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else begin
      io_in_b_reg_5 <= io_in_b_reg_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_b_reg_6 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else begin
      io_in_b_reg_6 <= io_in_b_reg_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_b_reg_7 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else begin
      io_in_b_reg_7 <= io_in_b_reg_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_b_reg_8 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else begin
      io_in_b_reg_8 <= io_in_b_reg_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_b_reg_9 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else begin
      io_in_b_reg_9 <= io_in_b_reg_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1443:30]
      io_in_b_reg_10 <= 32'h0; // @[FloatingPointDesigns.scala 1443:30]
    end else begin
      io_in_b_reg_10 <= io_in_b_reg_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1445:36]
      subber2_out_s_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1445:36]
    end else begin
      subber2_out_s_reg_0 <= _GEN_39;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1446:36]
      subber2_out_c_reg_0 <= 1'h0; // @[FloatingPointDesigns.scala 1446:36]
    end else begin
      subber2_out_c_reg_0 <= _GEN_40;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1467:40]
      cmpl_subber_out_s_reg_0 <= 8'h0; // @[FloatingPointDesigns.scala 1467:40]
    end else begin
      cmpl_subber_out_s_reg_0 <= _cmpl_subber_out_s_reg_0_T_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1488:44]
      cmpl_wire_temp_add_in_reg_0_0 <= 24'h0; // @[FloatingPointDesigns.scala 1488:44]
    end else begin
      cmpl_wire_temp_add_in_reg_0_0 <= _cmpl_wire_temp_add_in_reg_0_0_T_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1488:44]
      cmpl_wire_temp_add_in_reg_0_1 <= 24'h0; // @[FloatingPointDesigns.scala 1488:44]
    end else begin
      cmpl_wire_temp_add_in_reg_0_1 <= _cmpl_wire_temp_add_in_reg_0_1_T_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1512:42]
      cmpl_adder_io_out_s_reg_0 <= 24'h0; // @[FloatingPointDesigns.scala 1512:42]
    end else begin
      cmpl_adder_io_out_s_reg_0 <= _cmpl_adder_io_out_s_reg_0_T_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1596:28]
      reg_out_s <= 32'h0; // @[FloatingPointDesigns.scala 1596:28]
    end else begin
      reg_out_s <= _reg_out_s_T_1;
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
module FP_DDOT_dp(
  input         clock,
  input         reset,
  input  [31:0] io_in_a_0,
  input  [31:0] io_in_a_1,
  input  [31:0] io_in_a_2,
  input  [31:0] io_in_a_3,
  input  [31:0] io_in_a_4,
  input  [31:0] io_in_a_5,
  input  [31:0] io_in_a_6,
  input  [31:0] io_in_a_7,
  input  [31:0] io_in_a_8,
  input  [31:0] io_in_a_9,
  input  [31:0] io_in_a_10,
  input  [31:0] io_in_a_11,
  input  [31:0] io_in_a_12,
  input  [31:0] io_in_a_13,
  input  [31:0] io_in_a_14,
  input  [31:0] io_in_a_15,
  input  [31:0] io_in_b_0,
  input  [31:0] io_in_b_1,
  input  [31:0] io_in_b_2,
  input  [31:0] io_in_b_3,
  input  [31:0] io_in_b_4,
  input  [31:0] io_in_b_5,
  input  [31:0] io_in_b_6,
  input  [31:0] io_in_b_7,
  input  [31:0] io_in_b_8,
  input  [31:0] io_in_b_9,
  input  [31:0] io_in_b_10,
  input  [31:0] io_in_b_11,
  input  [31:0] io_in_b_12,
  input  [31:0] io_in_b_13,
  input  [31:0] io_in_b_14,
  input  [31:0] io_in_b_15,
  output [31:0] io_out_s
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  FP_multiplier_10ccs_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_1_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_1_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_1_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_1_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_1_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_2_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_2_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_2_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_2_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_2_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_3_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_3_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_3_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_3_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_3_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_4_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_4_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_4_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_4_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_4_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_5_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_5_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_5_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_5_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_5_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_6_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_6_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_6_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_6_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_6_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_7_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_7_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_7_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_7_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_7_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_8_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_8_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_8_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_8_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_8_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_9_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_9_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_9_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_9_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_9_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_10_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_10_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_10_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_10_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_10_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_11_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_11_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_11_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_11_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_11_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_12_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_12_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_12_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_12_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_12_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_13_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_13_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_13_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_13_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_13_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_14_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_14_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_14_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_14_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_14_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_15_clock; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_multiplier_10ccs_15_reset; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_15_io_in_a; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_15_io_in_b; // @[FloatingPointDesigns.scala 2411:44]
  wire [31:0] FP_multiplier_10ccs_15_io_out_s; // @[FloatingPointDesigns.scala 2411:44]
  wire  FP_adder_13ccs_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_1_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_1_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_1_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_1_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_1_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_2_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_2_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_2_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_2_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_2_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_3_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_3_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_3_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_3_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_3_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_4_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_4_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_4_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_4_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_4_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_5_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_5_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_5_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_5_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_5_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_6_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_6_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_6_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_6_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_6_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_7_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_7_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_7_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_7_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_7_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_8_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_8_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_8_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_8_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_8_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_9_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_9_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_9_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_9_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_9_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_10_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_10_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_10_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_10_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_10_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_11_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_11_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_11_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_11_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_11_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_12_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_12_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_12_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_12_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_12_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_13_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_13_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_13_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_13_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_13_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_14_clock; // @[FloatingPointDesigns.scala 2419:17]
  wire  FP_adder_13ccs_14_reset; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_14_io_in_a; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_14_io_in_b; // @[FloatingPointDesigns.scala 2419:17]
  wire [31:0] FP_adder_13ccs_14_io_out_s; // @[FloatingPointDesigns.scala 2419:17]
  reg [31:0] io_out_s_REG; // @[FloatingPointDesigns.scala 2468:26]
  FP_multiplier_10ccs FP_multiplier_10ccs ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_clock),
    .reset(FP_multiplier_10ccs_reset),
    .io_in_a(FP_multiplier_10ccs_io_in_a),
    .io_in_b(FP_multiplier_10ccs_io_in_b),
    .io_out_s(FP_multiplier_10ccs_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_1 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_1_clock),
    .reset(FP_multiplier_10ccs_1_reset),
    .io_in_a(FP_multiplier_10ccs_1_io_in_a),
    .io_in_b(FP_multiplier_10ccs_1_io_in_b),
    .io_out_s(FP_multiplier_10ccs_1_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_2 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_2_clock),
    .reset(FP_multiplier_10ccs_2_reset),
    .io_in_a(FP_multiplier_10ccs_2_io_in_a),
    .io_in_b(FP_multiplier_10ccs_2_io_in_b),
    .io_out_s(FP_multiplier_10ccs_2_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_3 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_3_clock),
    .reset(FP_multiplier_10ccs_3_reset),
    .io_in_a(FP_multiplier_10ccs_3_io_in_a),
    .io_in_b(FP_multiplier_10ccs_3_io_in_b),
    .io_out_s(FP_multiplier_10ccs_3_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_4 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_4_clock),
    .reset(FP_multiplier_10ccs_4_reset),
    .io_in_a(FP_multiplier_10ccs_4_io_in_a),
    .io_in_b(FP_multiplier_10ccs_4_io_in_b),
    .io_out_s(FP_multiplier_10ccs_4_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_5 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_5_clock),
    .reset(FP_multiplier_10ccs_5_reset),
    .io_in_a(FP_multiplier_10ccs_5_io_in_a),
    .io_in_b(FP_multiplier_10ccs_5_io_in_b),
    .io_out_s(FP_multiplier_10ccs_5_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_6 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_6_clock),
    .reset(FP_multiplier_10ccs_6_reset),
    .io_in_a(FP_multiplier_10ccs_6_io_in_a),
    .io_in_b(FP_multiplier_10ccs_6_io_in_b),
    .io_out_s(FP_multiplier_10ccs_6_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_7 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_7_clock),
    .reset(FP_multiplier_10ccs_7_reset),
    .io_in_a(FP_multiplier_10ccs_7_io_in_a),
    .io_in_b(FP_multiplier_10ccs_7_io_in_b),
    .io_out_s(FP_multiplier_10ccs_7_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_8 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_8_clock),
    .reset(FP_multiplier_10ccs_8_reset),
    .io_in_a(FP_multiplier_10ccs_8_io_in_a),
    .io_in_b(FP_multiplier_10ccs_8_io_in_b),
    .io_out_s(FP_multiplier_10ccs_8_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_9 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_9_clock),
    .reset(FP_multiplier_10ccs_9_reset),
    .io_in_a(FP_multiplier_10ccs_9_io_in_a),
    .io_in_b(FP_multiplier_10ccs_9_io_in_b),
    .io_out_s(FP_multiplier_10ccs_9_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_10 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_10_clock),
    .reset(FP_multiplier_10ccs_10_reset),
    .io_in_a(FP_multiplier_10ccs_10_io_in_a),
    .io_in_b(FP_multiplier_10ccs_10_io_in_b),
    .io_out_s(FP_multiplier_10ccs_10_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_11 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_11_clock),
    .reset(FP_multiplier_10ccs_11_reset),
    .io_in_a(FP_multiplier_10ccs_11_io_in_a),
    .io_in_b(FP_multiplier_10ccs_11_io_in_b),
    .io_out_s(FP_multiplier_10ccs_11_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_12 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_12_clock),
    .reset(FP_multiplier_10ccs_12_reset),
    .io_in_a(FP_multiplier_10ccs_12_io_in_a),
    .io_in_b(FP_multiplier_10ccs_12_io_in_b),
    .io_out_s(FP_multiplier_10ccs_12_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_13 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_13_clock),
    .reset(FP_multiplier_10ccs_13_reset),
    .io_in_a(FP_multiplier_10ccs_13_io_in_a),
    .io_in_b(FP_multiplier_10ccs_13_io_in_b),
    .io_out_s(FP_multiplier_10ccs_13_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_14 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_14_clock),
    .reset(FP_multiplier_10ccs_14_reset),
    .io_in_a(FP_multiplier_10ccs_14_io_in_a),
    .io_in_b(FP_multiplier_10ccs_14_io_in_b),
    .io_out_s(FP_multiplier_10ccs_14_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_15 ( // @[FloatingPointDesigns.scala 2411:44]
    .clock(FP_multiplier_10ccs_15_clock),
    .reset(FP_multiplier_10ccs_15_reset),
    .io_in_a(FP_multiplier_10ccs_15_io_in_a),
    .io_in_b(FP_multiplier_10ccs_15_io_in_b),
    .io_out_s(FP_multiplier_10ccs_15_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_clock),
    .reset(FP_adder_13ccs_reset),
    .io_in_a(FP_adder_13ccs_io_in_a),
    .io_in_b(FP_adder_13ccs_io_in_b),
    .io_out_s(FP_adder_13ccs_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_1 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_1_clock),
    .reset(FP_adder_13ccs_1_reset),
    .io_in_a(FP_adder_13ccs_1_io_in_a),
    .io_in_b(FP_adder_13ccs_1_io_in_b),
    .io_out_s(FP_adder_13ccs_1_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_2 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_2_clock),
    .reset(FP_adder_13ccs_2_reset),
    .io_in_a(FP_adder_13ccs_2_io_in_a),
    .io_in_b(FP_adder_13ccs_2_io_in_b),
    .io_out_s(FP_adder_13ccs_2_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_3 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_3_clock),
    .reset(FP_adder_13ccs_3_reset),
    .io_in_a(FP_adder_13ccs_3_io_in_a),
    .io_in_b(FP_adder_13ccs_3_io_in_b),
    .io_out_s(FP_adder_13ccs_3_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_4 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_4_clock),
    .reset(FP_adder_13ccs_4_reset),
    .io_in_a(FP_adder_13ccs_4_io_in_a),
    .io_in_b(FP_adder_13ccs_4_io_in_b),
    .io_out_s(FP_adder_13ccs_4_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_5 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_5_clock),
    .reset(FP_adder_13ccs_5_reset),
    .io_in_a(FP_adder_13ccs_5_io_in_a),
    .io_in_b(FP_adder_13ccs_5_io_in_b),
    .io_out_s(FP_adder_13ccs_5_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_6 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_6_clock),
    .reset(FP_adder_13ccs_6_reset),
    .io_in_a(FP_adder_13ccs_6_io_in_a),
    .io_in_b(FP_adder_13ccs_6_io_in_b),
    .io_out_s(FP_adder_13ccs_6_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_7 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_7_clock),
    .reset(FP_adder_13ccs_7_reset),
    .io_in_a(FP_adder_13ccs_7_io_in_a),
    .io_in_b(FP_adder_13ccs_7_io_in_b),
    .io_out_s(FP_adder_13ccs_7_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_8 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_8_clock),
    .reset(FP_adder_13ccs_8_reset),
    .io_in_a(FP_adder_13ccs_8_io_in_a),
    .io_in_b(FP_adder_13ccs_8_io_in_b),
    .io_out_s(FP_adder_13ccs_8_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_9 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_9_clock),
    .reset(FP_adder_13ccs_9_reset),
    .io_in_a(FP_adder_13ccs_9_io_in_a),
    .io_in_b(FP_adder_13ccs_9_io_in_b),
    .io_out_s(FP_adder_13ccs_9_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_10 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_10_clock),
    .reset(FP_adder_13ccs_10_reset),
    .io_in_a(FP_adder_13ccs_10_io_in_a),
    .io_in_b(FP_adder_13ccs_10_io_in_b),
    .io_out_s(FP_adder_13ccs_10_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_11 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_11_clock),
    .reset(FP_adder_13ccs_11_reset),
    .io_in_a(FP_adder_13ccs_11_io_in_a),
    .io_in_b(FP_adder_13ccs_11_io_in_b),
    .io_out_s(FP_adder_13ccs_11_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_12 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_12_clock),
    .reset(FP_adder_13ccs_12_reset),
    .io_in_a(FP_adder_13ccs_12_io_in_a),
    .io_in_b(FP_adder_13ccs_12_io_in_b),
    .io_out_s(FP_adder_13ccs_12_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_13 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_13_clock),
    .reset(FP_adder_13ccs_13_reset),
    .io_in_a(FP_adder_13ccs_13_io_in_a),
    .io_in_b(FP_adder_13ccs_13_io_in_b),
    .io_out_s(FP_adder_13ccs_13_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_14 ( // @[FloatingPointDesigns.scala 2419:17]
    .clock(FP_adder_13ccs_14_clock),
    .reset(FP_adder_13ccs_14_reset),
    .io_in_a(FP_adder_13ccs_14_io_in_a),
    .io_in_b(FP_adder_13ccs_14_io_in_b),
    .io_out_s(FP_adder_13ccs_14_io_out_s)
  );
  assign io_out_s = io_out_s_REG; // @[FloatingPointDesigns.scala 2468:16]
  assign FP_multiplier_10ccs_clock = clock;
  assign FP_multiplier_10ccs_reset = reset;
  assign FP_multiplier_10ccs_io_in_a = io_in_a_0; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_io_in_b = io_in_b_0; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_1_clock = clock;
  assign FP_multiplier_10ccs_1_reset = reset;
  assign FP_multiplier_10ccs_1_io_in_a = io_in_a_1; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_1_io_in_b = io_in_b_1; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_2_clock = clock;
  assign FP_multiplier_10ccs_2_reset = reset;
  assign FP_multiplier_10ccs_2_io_in_a = io_in_a_2; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_2_io_in_b = io_in_b_2; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_3_clock = clock;
  assign FP_multiplier_10ccs_3_reset = reset;
  assign FP_multiplier_10ccs_3_io_in_a = io_in_a_3; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_3_io_in_b = io_in_b_3; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_4_clock = clock;
  assign FP_multiplier_10ccs_4_reset = reset;
  assign FP_multiplier_10ccs_4_io_in_a = io_in_a_4; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_4_io_in_b = io_in_b_4; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_5_clock = clock;
  assign FP_multiplier_10ccs_5_reset = reset;
  assign FP_multiplier_10ccs_5_io_in_a = io_in_a_5; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_5_io_in_b = io_in_b_5; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_6_clock = clock;
  assign FP_multiplier_10ccs_6_reset = reset;
  assign FP_multiplier_10ccs_6_io_in_a = io_in_a_6; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_6_io_in_b = io_in_b_6; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_7_clock = clock;
  assign FP_multiplier_10ccs_7_reset = reset;
  assign FP_multiplier_10ccs_7_io_in_a = io_in_a_7; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_7_io_in_b = io_in_b_7; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_8_clock = clock;
  assign FP_multiplier_10ccs_8_reset = reset;
  assign FP_multiplier_10ccs_8_io_in_a = io_in_a_8; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_8_io_in_b = io_in_b_8; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_9_clock = clock;
  assign FP_multiplier_10ccs_9_reset = reset;
  assign FP_multiplier_10ccs_9_io_in_a = io_in_a_9; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_9_io_in_b = io_in_b_9; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_10_clock = clock;
  assign FP_multiplier_10ccs_10_reset = reset;
  assign FP_multiplier_10ccs_10_io_in_a = io_in_a_10; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_10_io_in_b = io_in_b_10; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_11_clock = clock;
  assign FP_multiplier_10ccs_11_reset = reset;
  assign FP_multiplier_10ccs_11_io_in_a = io_in_a_11; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_11_io_in_b = io_in_b_11; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_12_clock = clock;
  assign FP_multiplier_10ccs_12_reset = reset;
  assign FP_multiplier_10ccs_12_io_in_a = io_in_a_12; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_12_io_in_b = io_in_b_12; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_13_clock = clock;
  assign FP_multiplier_10ccs_13_reset = reset;
  assign FP_multiplier_10ccs_13_io_in_a = io_in_a_13; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_13_io_in_b = io_in_b_13; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_14_clock = clock;
  assign FP_multiplier_10ccs_14_reset = reset;
  assign FP_multiplier_10ccs_14_io_in_a = io_in_a_14; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_14_io_in_b = io_in_b_14; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_multiplier_10ccs_15_clock = clock;
  assign FP_multiplier_10ccs_15_reset = reset;
  assign FP_multiplier_10ccs_15_io_in_a = io_in_a_15; // @[FloatingPointDesigns.scala 2413:47]
  assign FP_multiplier_10ccs_15_io_in_b = io_in_b_15; // @[FloatingPointDesigns.scala 2414:47]
  assign FP_adder_13ccs_clock = clock;
  assign FP_adder_13ccs_reset = reset;
  assign FP_adder_13ccs_io_in_a = FP_multiplier_10ccs_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_io_in_b = FP_multiplier_10ccs_1_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_1_clock = clock;
  assign FP_adder_13ccs_1_reset = reset;
  assign FP_adder_13ccs_1_io_in_a = FP_multiplier_10ccs_2_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_1_io_in_b = FP_multiplier_10ccs_3_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_2_clock = clock;
  assign FP_adder_13ccs_2_reset = reset;
  assign FP_adder_13ccs_2_io_in_a = FP_multiplier_10ccs_4_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_2_io_in_b = FP_multiplier_10ccs_5_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_3_clock = clock;
  assign FP_adder_13ccs_3_reset = reset;
  assign FP_adder_13ccs_3_io_in_a = FP_multiplier_10ccs_6_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_3_io_in_b = FP_multiplier_10ccs_7_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_4_clock = clock;
  assign FP_adder_13ccs_4_reset = reset;
  assign FP_adder_13ccs_4_io_in_a = FP_multiplier_10ccs_8_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_4_io_in_b = FP_multiplier_10ccs_9_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_5_clock = clock;
  assign FP_adder_13ccs_5_reset = reset;
  assign FP_adder_13ccs_5_io_in_a = FP_multiplier_10ccs_10_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_5_io_in_b = FP_multiplier_10ccs_11_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_6_clock = clock;
  assign FP_adder_13ccs_6_reset = reset;
  assign FP_adder_13ccs_6_io_in_a = FP_multiplier_10ccs_12_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_6_io_in_b = FP_multiplier_10ccs_13_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_7_clock = clock;
  assign FP_adder_13ccs_7_reset = reset;
  assign FP_adder_13ccs_7_io_in_a = FP_multiplier_10ccs_14_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_7_io_in_b = FP_multiplier_10ccs_15_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_8_clock = clock;
  assign FP_adder_13ccs_8_reset = reset;
  assign FP_adder_13ccs_8_io_in_a = FP_adder_13ccs_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_8_io_in_b = FP_adder_13ccs_1_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_9_clock = clock;
  assign FP_adder_13ccs_9_reset = reset;
  assign FP_adder_13ccs_9_io_in_a = FP_adder_13ccs_2_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_9_io_in_b = FP_adder_13ccs_3_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_10_clock = clock;
  assign FP_adder_13ccs_10_reset = reset;
  assign FP_adder_13ccs_10_io_in_a = FP_adder_13ccs_4_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_10_io_in_b = FP_adder_13ccs_5_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_11_clock = clock;
  assign FP_adder_13ccs_11_reset = reset;
  assign FP_adder_13ccs_11_io_in_a = FP_adder_13ccs_6_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_11_io_in_b = FP_adder_13ccs_7_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_12_clock = clock;
  assign FP_adder_13ccs_12_reset = reset;
  assign FP_adder_13ccs_12_io_in_a = FP_adder_13ccs_8_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_12_io_in_b = FP_adder_13ccs_9_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_13_clock = clock;
  assign FP_adder_13ccs_13_reset = reset;
  assign FP_adder_13ccs_13_io_in_a = FP_adder_13ccs_10_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_13_io_in_b = FP_adder_13ccs_11_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  assign FP_adder_13ccs_14_clock = clock;
  assign FP_adder_13ccs_14_reset = reset;
  assign FP_adder_13ccs_14_io_in_a = FP_adder_13ccs_12_io_out_s; // @[FloatingPointDesigns.scala 2450:43]
  assign FP_adder_13ccs_14_io_in_b = FP_adder_13ccs_13_io_out_s; // @[FloatingPointDesigns.scala 2451:43]
  always @(posedge clock) begin
    io_out_s_REG <= FP_adder_13ccs_14_io_out_s; // @[FloatingPointDesigns.scala 2468:26]
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
  io_out_s_REG = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module FP_subtractor_13ccs(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
);
  wire  FP_adder_clock; // @[FloatingPointDesigns.scala 1650:26]
  wire  FP_adder_reset; // @[FloatingPointDesigns.scala 1650:26]
  wire [31:0] FP_adder_io_in_a; // @[FloatingPointDesigns.scala 1650:26]
  wire [31:0] FP_adder_io_in_b; // @[FloatingPointDesigns.scala 1650:26]
  wire [31:0] FP_adder_io_out_s; // @[FloatingPointDesigns.scala 1650:26]
  wire  _adjusted_in_b_T_1 = ~io_in_b[31]; // @[FloatingPointDesigns.scala 1653:23]
  FP_adder_13ccs FP_adder ( // @[FloatingPointDesigns.scala 1650:26]
    .clock(FP_adder_clock),
    .reset(FP_adder_reset),
    .io_in_a(FP_adder_io_in_a),
    .io_in_b(FP_adder_io_in_b),
    .io_out_s(FP_adder_io_out_s)
  );
  assign io_out_s = FP_adder_io_out_s; // @[FloatingPointDesigns.scala 1657:14]
  assign FP_adder_clock = clock;
  assign FP_adder_reset = reset;
  assign FP_adder_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 1655:22]
  assign FP_adder_io_in_b = {_adjusted_in_b_T_1,io_in_b[30:0]}; // @[FloatingPointDesigns.scala 1653:41]
endmodule
module FP_square_root_newfpu(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
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
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
  reg [31:0] _RAND_139;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
  reg [31:0] _RAND_144;
  reg [31:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_153;
  reg [31:0] _RAND_154;
  reg [31:0] _RAND_155;
  reg [31:0] _RAND_156;
  reg [31:0] _RAND_157;
  reg [31:0] _RAND_158;
  reg [31:0] _RAND_159;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_163;
  reg [31:0] _RAND_164;
  reg [31:0] _RAND_165;
  reg [31:0] _RAND_166;
  reg [31:0] _RAND_167;
  reg [31:0] _RAND_168;
  reg [31:0] _RAND_169;
  reg [31:0] _RAND_170;
  reg [31:0] _RAND_171;
  reg [31:0] _RAND_172;
  reg [31:0] _RAND_173;
  reg [31:0] _RAND_174;
  reg [31:0] _RAND_175;
  reg [31:0] _RAND_176;
  reg [31:0] _RAND_177;
  reg [31:0] _RAND_178;
  reg [31:0] _RAND_179;
  reg [31:0] _RAND_180;
  reg [31:0] _RAND_181;
  reg [31:0] _RAND_182;
  reg [31:0] _RAND_183;
  reg [31:0] _RAND_184;
  reg [31:0] _RAND_185;
  reg [31:0] _RAND_186;
  reg [31:0] _RAND_187;
  reg [31:0] _RAND_188;
  reg [31:0] _RAND_189;
  reg [31:0] _RAND_190;
  reg [31:0] _RAND_191;
  reg [31:0] _RAND_192;
  reg [31:0] _RAND_193;
  reg [31:0] _RAND_194;
  reg [31:0] _RAND_195;
  reg [31:0] _RAND_196;
  reg [31:0] _RAND_197;
  reg [31:0] _RAND_198;
  reg [31:0] _RAND_199;
  reg [31:0] _RAND_200;
  reg [31:0] _RAND_201;
  reg [31:0] _RAND_202;
  reg [31:0] _RAND_203;
  reg [31:0] _RAND_204;
  reg [31:0] _RAND_205;
  reg [31:0] _RAND_206;
  reg [31:0] _RAND_207;
  reg [31:0] _RAND_208;
  reg [31:0] _RAND_209;
  reg [31:0] _RAND_210;
  reg [31:0] _RAND_211;
  reg [31:0] _RAND_212;
  reg [31:0] _RAND_213;
  reg [31:0] _RAND_214;
  reg [31:0] _RAND_215;
  reg [31:0] _RAND_216;
  reg [31:0] _RAND_217;
  reg [31:0] _RAND_218;
  reg [31:0] _RAND_219;
  reg [31:0] _RAND_220;
  reg [31:0] _RAND_221;
  reg [31:0] _RAND_222;
  reg [31:0] _RAND_223;
  reg [31:0] _RAND_224;
  reg [31:0] _RAND_225;
  reg [31:0] _RAND_226;
  reg [31:0] _RAND_227;
`endif // RANDOMIZE_REG_INIT
  wire  FP_multiplier_10ccs_clock; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_reset; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_io_in_a; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_io_in_b; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_io_out_s; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_1_clock; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_1_reset; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_1_io_in_a; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_1_io_in_b; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_1_io_out_s; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_2_clock; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_2_reset; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_2_io_in_a; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_2_io_in_b; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_2_io_out_s; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_3_clock; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_3_reset; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_3_io_in_a; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_3_io_in_b; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_3_io_out_s; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_4_clock; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_4_reset; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_4_io_in_a; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_4_io_in_b; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_4_io_out_s; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_5_clock; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_5_reset; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_5_io_in_a; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_5_io_in_b; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_5_io_out_s; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_6_clock; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_6_reset; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_6_io_in_a; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_6_io_in_b; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_6_io_out_s; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_7_clock; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_7_reset; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_7_io_in_a; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_7_io_in_b; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_7_io_out_s; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_8_clock; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_multiplier_10ccs_8_reset; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_8_io_in_a; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_8_io_in_b; // @[FloatingPointDesigns.scala 1878:65]
  wire [31:0] FP_multiplier_10ccs_8_io_out_s; // @[FloatingPointDesigns.scala 1878:65]
  wire  FP_subtractor_13ccs_clock; // @[FloatingPointDesigns.scala 1879:50]
  wire  FP_subtractor_13ccs_reset; // @[FloatingPointDesigns.scala 1879:50]
  wire [31:0] FP_subtractor_13ccs_io_in_a; // @[FloatingPointDesigns.scala 1879:50]
  wire [31:0] FP_subtractor_13ccs_io_in_b; // @[FloatingPointDesigns.scala 1879:50]
  wire [31:0] FP_subtractor_13ccs_io_out_s; // @[FloatingPointDesigns.scala 1879:50]
  wire  FP_subtractor_13ccs_1_clock; // @[FloatingPointDesigns.scala 1879:50]
  wire  FP_subtractor_13ccs_1_reset; // @[FloatingPointDesigns.scala 1879:50]
  wire [31:0] FP_subtractor_13ccs_1_io_in_a; // @[FloatingPointDesigns.scala 1879:50]
  wire [31:0] FP_subtractor_13ccs_1_io_in_b; // @[FloatingPointDesigns.scala 1879:50]
  wire [31:0] FP_subtractor_13ccs_1_io_out_s; // @[FloatingPointDesigns.scala 1879:50]
  wire  FP_subtractor_13ccs_2_clock; // @[FloatingPointDesigns.scala 1879:50]
  wire  FP_subtractor_13ccs_2_reset; // @[FloatingPointDesigns.scala 1879:50]
  wire [31:0] FP_subtractor_13ccs_2_io_in_a; // @[FloatingPointDesigns.scala 1879:50]
  wire [31:0] FP_subtractor_13ccs_2_io_in_b; // @[FloatingPointDesigns.scala 1879:50]
  wire [31:0] FP_subtractor_13ccs_2_io_out_s; // @[FloatingPointDesigns.scala 1879:50]
  wire  multiplier4_clock; // @[FloatingPointDesigns.scala 1947:29]
  wire  multiplier4_reset; // @[FloatingPointDesigns.scala 1947:29]
  wire [31:0] multiplier4_io_in_a; // @[FloatingPointDesigns.scala 1947:29]
  wire [31:0] multiplier4_io_in_b; // @[FloatingPointDesigns.scala 1947:29]
  wire [31:0] multiplier4_io_out_s; // @[FloatingPointDesigns.scala 1947:29]
  wire [30:0] _number_T_1 = {{1'd0}, io_in_a[30:1]}; // @[FloatingPointDesigns.scala 1862:36]
  wire [30:0] _GEN_0 = io_in_a[30:0] > 31'h7ef477d4 ? 31'h3f7a3bea : _number_T_1; // @[FloatingPointDesigns.scala 1859:46 1860:14 1862:14]
  wire [31:0] number = {{1'd0}, _GEN_0}; // @[FloatingPointDesigns.scala 1856:22]
  wire [31:0] result = 32'h5f3759df - number; // @[FloatingPointDesigns.scala 1869:25]
  reg [31:0] x_n_0; // @[FloatingPointDesigns.scala 1871:22]
  reg [31:0] x_n_1; // @[FloatingPointDesigns.scala 1871:22]
  reg [31:0] x_n_2; // @[FloatingPointDesigns.scala 1871:22]
  reg [31:0] x_n_4; // @[FloatingPointDesigns.scala 1871:22]
  reg [31:0] x_n_5; // @[FloatingPointDesigns.scala 1871:22]
  reg [31:0] x_n_6; // @[FloatingPointDesigns.scala 1871:22]
  reg [31:0] x_n_8; // @[FloatingPointDesigns.scala 1871:22]
  reg [31:0] x_n_9; // @[FloatingPointDesigns.scala 1871:22]
  reg [31:0] x_n_10; // @[FloatingPointDesigns.scala 1871:22]
  reg [31:0] a_2_0; // @[FloatingPointDesigns.scala 1872:22]
  reg [31:0] a_2_1; // @[FloatingPointDesigns.scala 1872:22]
  reg [31:0] a_2_2; // @[FloatingPointDesigns.scala 1872:22]
  reg [31:0] a_2_3; // @[FloatingPointDesigns.scala 1872:22]
  reg [31:0] a_2_4; // @[FloatingPointDesigns.scala 1872:22]
  reg [31:0] a_2_5; // @[FloatingPointDesigns.scala 1872:22]
  reg [31:0] a_2_6; // @[FloatingPointDesigns.scala 1872:22]
  reg [31:0] a_2_7; // @[FloatingPointDesigns.scala 1872:22]
  reg [31:0] a_2_8; // @[FloatingPointDesigns.scala 1872:22]
  reg [31:0] a_2_9; // @[FloatingPointDesigns.scala 1872:22]
  reg [31:0] a_2_10; // @[FloatingPointDesigns.scala 1872:22]
  reg [31:0] a_2_11; // @[FloatingPointDesigns.scala 1872:22]
  reg [31:0] stage1_regs_0_0_0; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_0_1; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_0_2; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_0_3; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_0_4; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_0_5; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_0_6; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_0_7; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_0_8; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_1_0; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_1_1; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_1_2; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_1_3; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_1_4; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_1_5; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_1_6; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_1_7; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_0_1_8; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_0_0; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_0_1; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_0_2; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_0_3; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_0_4; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_0_5; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_0_6; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_0_7; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_0_8; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_1_0; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_1_1; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_1_2; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_1_3; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_1_4; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_1_5; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_1_6; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_1_7; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_1_1_8; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_0_0; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_0_1; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_0_2; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_0_3; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_0_4; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_0_5; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_0_6; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_0_7; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_0_8; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_1_0; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_1_1; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_1_2; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_1_3; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_1_4; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_1_5; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_1_6; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_1_7; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage1_regs_2_1_8; // @[FloatingPointDesigns.scala 1873:30]
  reg [31:0] stage2_regs_0_0_0; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_0_1; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_0_2; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_0_3; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_0_4; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_0_5; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_0_6; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_0_7; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_0_8; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_1_0; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_1_1; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_1_2; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_1_3; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_1_4; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_1_5; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_1_6; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_1_7; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_0_1_8; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_0_0; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_0_1; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_0_2; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_0_3; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_0_4; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_0_5; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_0_6; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_0_7; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_0_8; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_1_0; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_1_1; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_1_2; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_1_3; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_1_4; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_1_5; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_1_6; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_1_7; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_1_1_8; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_0_0; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_0_1; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_0_2; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_0_3; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_0_4; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_0_5; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_0_6; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_0_7; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_0_8; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_1_0; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_1_1; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_1_2; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_1_3; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_1_4; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_1_5; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_1_6; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_1_7; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage2_regs_2_1_8; // @[FloatingPointDesigns.scala 1874:30]
  reg [31:0] stage3_regs_0_0_0; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_0_1; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_0_2; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_0_3; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_0_4; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_0_5; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_0_6; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_0_7; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_0_8; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_0_9; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_0_10; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_0_11; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_1_0; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_1_1; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_1_2; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_1_3; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_1_4; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_1_5; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_1_6; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_1_7; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_1_8; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_1_9; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_1_10; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_0_1_11; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_0_0; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_0_1; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_0_2; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_0_3; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_0_4; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_0_5; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_0_6; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_0_7; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_0_8; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_0_9; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_0_10; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_0_11; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_1_0; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_1_1; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_1_2; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_1_3; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_1_4; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_1_5; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_1_6; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_1_7; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_1_8; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_1_9; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_1_10; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_1_1_11; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_0_0; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_0_1; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_0_2; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_0_3; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_0_4; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_0_5; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_0_6; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_0_7; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_0_8; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_0_9; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_0_10; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_0_11; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_1_0; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_1_1; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_1_2; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_1_3; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_1_4; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_1_5; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_1_6; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_1_7; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_1_8; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_1_9; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_1_10; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage3_regs_2_1_11; // @[FloatingPointDesigns.scala 1875:30]
  reg [31:0] stage4_regs_0_1_0; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_0_1_1; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_0_1_2; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_0_1_3; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_0_1_4; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_0_1_5; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_0_1_6; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_0_1_7; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_0_1_8; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_1_1_0; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_1_1_1; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_1_1_2; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_1_1_3; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_1_1_4; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_1_1_5; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_1_1_6; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_1_1_7; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_1_1_8; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_2_1_0; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_2_1_1; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_2_1_2; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_2_1_3; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_2_1_4; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_2_1_5; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_2_1_6; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_2_1_7; // @[FloatingPointDesigns.scala 1876:30]
  reg [31:0] stage4_regs_2_1_8; // @[FloatingPointDesigns.scala 1876:30]
  wire [7:0] _a_2_0_T_3 = io_in_a[30:23] - 8'h1; // @[FloatingPointDesigns.scala 1901:75]
  wire [31:0] _a_2_0_T_6 = {io_in_a[31],_a_2_0_T_3,io_in_a[22:0]}; // @[FloatingPointDesigns.scala 1901:82]
  wire [31:0] _GEN_139 = FP_multiplier_10ccs_2_io_out_s; // @[FloatingPointDesigns.scala 1871:22 1908:28 1909:26]
  wire [31:0] _GEN_215 = FP_multiplier_10ccs_5_io_out_s; // @[FloatingPointDesigns.scala 1871:22 1908:28 1909:26]
  wire [7:0] _restore_a_T_3 = stage4_regs_2_1_8[30:23] + 8'h1; // @[FloatingPointDesigns.scala 1946:106]
  wire [8:0] _restore_a_T_4 = {stage4_regs_2_1_8[31],_restore_a_T_3}; // @[FloatingPointDesigns.scala 1946:55]
  FP_multiplier_10ccs FP_multiplier_10ccs ( // @[FloatingPointDesigns.scala 1878:65]
    .clock(FP_multiplier_10ccs_clock),
    .reset(FP_multiplier_10ccs_reset),
    .io_in_a(FP_multiplier_10ccs_io_in_a),
    .io_in_b(FP_multiplier_10ccs_io_in_b),
    .io_out_s(FP_multiplier_10ccs_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_1 ( // @[FloatingPointDesigns.scala 1878:65]
    .clock(FP_multiplier_10ccs_1_clock),
    .reset(FP_multiplier_10ccs_1_reset),
    .io_in_a(FP_multiplier_10ccs_1_io_in_a),
    .io_in_b(FP_multiplier_10ccs_1_io_in_b),
    .io_out_s(FP_multiplier_10ccs_1_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_2 ( // @[FloatingPointDesigns.scala 1878:65]
    .clock(FP_multiplier_10ccs_2_clock),
    .reset(FP_multiplier_10ccs_2_reset),
    .io_in_a(FP_multiplier_10ccs_2_io_in_a),
    .io_in_b(FP_multiplier_10ccs_2_io_in_b),
    .io_out_s(FP_multiplier_10ccs_2_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_3 ( // @[FloatingPointDesigns.scala 1878:65]
    .clock(FP_multiplier_10ccs_3_clock),
    .reset(FP_multiplier_10ccs_3_reset),
    .io_in_a(FP_multiplier_10ccs_3_io_in_a),
    .io_in_b(FP_multiplier_10ccs_3_io_in_b),
    .io_out_s(FP_multiplier_10ccs_3_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_4 ( // @[FloatingPointDesigns.scala 1878:65]
    .clock(FP_multiplier_10ccs_4_clock),
    .reset(FP_multiplier_10ccs_4_reset),
    .io_in_a(FP_multiplier_10ccs_4_io_in_a),
    .io_in_b(FP_multiplier_10ccs_4_io_in_b),
    .io_out_s(FP_multiplier_10ccs_4_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_5 ( // @[FloatingPointDesigns.scala 1878:65]
    .clock(FP_multiplier_10ccs_5_clock),
    .reset(FP_multiplier_10ccs_5_reset),
    .io_in_a(FP_multiplier_10ccs_5_io_in_a),
    .io_in_b(FP_multiplier_10ccs_5_io_in_b),
    .io_out_s(FP_multiplier_10ccs_5_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_6 ( // @[FloatingPointDesigns.scala 1878:65]
    .clock(FP_multiplier_10ccs_6_clock),
    .reset(FP_multiplier_10ccs_6_reset),
    .io_in_a(FP_multiplier_10ccs_6_io_in_a),
    .io_in_b(FP_multiplier_10ccs_6_io_in_b),
    .io_out_s(FP_multiplier_10ccs_6_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_7 ( // @[FloatingPointDesigns.scala 1878:65]
    .clock(FP_multiplier_10ccs_7_clock),
    .reset(FP_multiplier_10ccs_7_reset),
    .io_in_a(FP_multiplier_10ccs_7_io_in_a),
    .io_in_b(FP_multiplier_10ccs_7_io_in_b),
    .io_out_s(FP_multiplier_10ccs_7_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_8 ( // @[FloatingPointDesigns.scala 1878:65]
    .clock(FP_multiplier_10ccs_8_clock),
    .reset(FP_multiplier_10ccs_8_reset),
    .io_in_a(FP_multiplier_10ccs_8_io_in_a),
    .io_in_b(FP_multiplier_10ccs_8_io_in_b),
    .io_out_s(FP_multiplier_10ccs_8_io_out_s)
  );
  FP_subtractor_13ccs FP_subtractor_13ccs ( // @[FloatingPointDesigns.scala 1879:50]
    .clock(FP_subtractor_13ccs_clock),
    .reset(FP_subtractor_13ccs_reset),
    .io_in_a(FP_subtractor_13ccs_io_in_a),
    .io_in_b(FP_subtractor_13ccs_io_in_b),
    .io_out_s(FP_subtractor_13ccs_io_out_s)
  );
  FP_subtractor_13ccs FP_subtractor_13ccs_1 ( // @[FloatingPointDesigns.scala 1879:50]
    .clock(FP_subtractor_13ccs_1_clock),
    .reset(FP_subtractor_13ccs_1_reset),
    .io_in_a(FP_subtractor_13ccs_1_io_in_a),
    .io_in_b(FP_subtractor_13ccs_1_io_in_b),
    .io_out_s(FP_subtractor_13ccs_1_io_out_s)
  );
  FP_subtractor_13ccs FP_subtractor_13ccs_2 ( // @[FloatingPointDesigns.scala 1879:50]
    .clock(FP_subtractor_13ccs_2_clock),
    .reset(FP_subtractor_13ccs_2_reset),
    .io_in_a(FP_subtractor_13ccs_2_io_in_a),
    .io_in_b(FP_subtractor_13ccs_2_io_in_b),
    .io_out_s(FP_subtractor_13ccs_2_io_out_s)
  );
  FP_multiplier_10ccs multiplier4 ( // @[FloatingPointDesigns.scala 1947:29]
    .clock(multiplier4_clock),
    .reset(multiplier4_reset),
    .io_in_a(multiplier4_io_in_a),
    .io_in_b(multiplier4_io_in_b),
    .io_out_s(multiplier4_io_out_s)
  );
  assign io_out_s = {{1'd0}, multiplier4_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 1951:14]
  assign FP_multiplier_10ccs_clock = clock;
  assign FP_multiplier_10ccs_reset = reset;
  assign FP_multiplier_10ccs_io_in_a = {1'h0,result[30:0]}; // @[FloatingPointDesigns.scala 1905:48]
  assign FP_multiplier_10ccs_io_in_b = {1'h0,result[30:0]}; // @[FloatingPointDesigns.scala 1906:48]
  assign FP_multiplier_10ccs_1_clock = clock;
  assign FP_multiplier_10ccs_1_reset = reset;
  assign FP_multiplier_10ccs_1_io_in_a = FP_multiplier_10ccs_io_out_s; // @[FloatingPointDesigns.scala 1918:34]
  assign FP_multiplier_10ccs_1_io_in_b = {1'h0,stage1_regs_0_1_8[30:0]}; // @[FloatingPointDesigns.scala 1919:46]
  assign FP_multiplier_10ccs_2_clock = clock;
  assign FP_multiplier_10ccs_2_reset = reset;
  assign FP_multiplier_10ccs_2_io_in_a = {1'h0,stage3_regs_0_0_11[30:0]}; // @[FloatingPointDesigns.scala 1936:46]
  assign FP_multiplier_10ccs_2_io_in_b = FP_subtractor_13ccs_io_out_s; // @[FloatingPointDesigns.scala 1937:34]
  assign FP_multiplier_10ccs_3_clock = clock;
  assign FP_multiplier_10ccs_3_reset = reset;
  assign FP_multiplier_10ccs_3_io_in_a = {1'h0,FP_multiplier_10ccs_2_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 1914:48]
  assign FP_multiplier_10ccs_3_io_in_b = {1'h0,FP_multiplier_10ccs_2_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 1915:48]
  assign FP_multiplier_10ccs_4_clock = clock;
  assign FP_multiplier_10ccs_4_reset = reset;
  assign FP_multiplier_10ccs_4_io_in_a = FP_multiplier_10ccs_3_io_out_s; // @[FloatingPointDesigns.scala 1918:34]
  assign FP_multiplier_10ccs_4_io_in_b = {1'h0,stage1_regs_1_1_8[30:0]}; // @[FloatingPointDesigns.scala 1919:46]
  assign FP_multiplier_10ccs_5_clock = clock;
  assign FP_multiplier_10ccs_5_reset = reset;
  assign FP_multiplier_10ccs_5_io_in_a = {1'h0,stage3_regs_1_0_11[30:0]}; // @[FloatingPointDesigns.scala 1936:46]
  assign FP_multiplier_10ccs_5_io_in_b = FP_subtractor_13ccs_1_io_out_s; // @[FloatingPointDesigns.scala 1937:34]
  assign FP_multiplier_10ccs_6_clock = clock;
  assign FP_multiplier_10ccs_6_reset = reset;
  assign FP_multiplier_10ccs_6_io_in_a = {1'h0,FP_multiplier_10ccs_5_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 1914:48]
  assign FP_multiplier_10ccs_6_io_in_b = {1'h0,FP_multiplier_10ccs_5_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 1915:48]
  assign FP_multiplier_10ccs_7_clock = clock;
  assign FP_multiplier_10ccs_7_reset = reset;
  assign FP_multiplier_10ccs_7_io_in_a = FP_multiplier_10ccs_6_io_out_s; // @[FloatingPointDesigns.scala 1918:34]
  assign FP_multiplier_10ccs_7_io_in_b = {1'h0,stage1_regs_2_1_8[30:0]}; // @[FloatingPointDesigns.scala 1919:46]
  assign FP_multiplier_10ccs_8_clock = clock;
  assign FP_multiplier_10ccs_8_reset = reset;
  assign FP_multiplier_10ccs_8_io_in_a = {1'h0,stage3_regs_2_0_11[30:0]}; // @[FloatingPointDesigns.scala 1936:46]
  assign FP_multiplier_10ccs_8_io_in_b = FP_subtractor_13ccs_2_io_out_s; // @[FloatingPointDesigns.scala 1937:34]
  assign FP_subtractor_13ccs_clock = clock;
  assign FP_subtractor_13ccs_reset = reset;
  assign FP_subtractor_13ccs_io_in_a = 32'h3fc00000; // @[FloatingPointDesigns.scala 1857:26 1858:16]
  assign FP_subtractor_13ccs_io_in_b = FP_multiplier_10ccs_1_io_out_s; // @[FloatingPointDesigns.scala 1928:31]
  assign FP_subtractor_13ccs_1_clock = clock;
  assign FP_subtractor_13ccs_1_reset = reset;
  assign FP_subtractor_13ccs_1_io_in_a = 32'h3fc00000; // @[FloatingPointDesigns.scala 1857:26 1858:16]
  assign FP_subtractor_13ccs_1_io_in_b = FP_multiplier_10ccs_4_io_out_s; // @[FloatingPointDesigns.scala 1928:31]
  assign FP_subtractor_13ccs_2_clock = clock;
  assign FP_subtractor_13ccs_2_reset = reset;
  assign FP_subtractor_13ccs_2_io_in_a = 32'h3fc00000; // @[FloatingPointDesigns.scala 1857:26 1858:16]
  assign FP_subtractor_13ccs_2_io_in_b = FP_multiplier_10ccs_7_io_out_s; // @[FloatingPointDesigns.scala 1928:31]
  assign multiplier4_clock = clock;
  assign multiplier4_reset = reset;
  assign multiplier4_io_in_a = {1'h0,FP_multiplier_10ccs_8_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 1949:37]
  assign multiplier4_io_in_b = {_restore_a_T_4,stage4_regs_2_1_8[22:0]}; // @[FloatingPointDesigns.scala 1946:113]
  always @(posedge clock) begin
    if (reset) begin // @[FloatingPointDesigns.scala 1871:22]
      x_n_0 <= 32'h0; // @[FloatingPointDesigns.scala 1871:22]
    end else begin
      x_n_0 <= result;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1871:22]
      x_n_1 <= 32'h0; // @[FloatingPointDesigns.scala 1871:22]
    end else begin
      x_n_1 <= stage1_regs_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1871:22]
      x_n_2 <= 32'h0; // @[FloatingPointDesigns.scala 1871:22]
    end else begin
      x_n_2 <= stage2_regs_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1871:22]
      x_n_4 <= 32'h0; // @[FloatingPointDesigns.scala 1871:22]
    end else begin
      x_n_4 <= _GEN_139;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1871:22]
      x_n_5 <= 32'h0; // @[FloatingPointDesigns.scala 1871:22]
    end else begin
      x_n_5 <= stage1_regs_1_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1871:22]
      x_n_6 <= 32'h0; // @[FloatingPointDesigns.scala 1871:22]
    end else begin
      x_n_6 <= stage2_regs_1_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1871:22]
      x_n_8 <= 32'h0; // @[FloatingPointDesigns.scala 1871:22]
    end else begin
      x_n_8 <= _GEN_215;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1871:22]
      x_n_9 <= 32'h0; // @[FloatingPointDesigns.scala 1871:22]
    end else begin
      x_n_9 <= stage1_regs_2_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1871:22]
      x_n_10 <= 32'h0; // @[FloatingPointDesigns.scala 1871:22]
    end else begin
      x_n_10 <= stage2_regs_2_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1872:22]
      a_2_0 <= 32'h0; // @[FloatingPointDesigns.scala 1872:22]
    end else begin
      a_2_0 <= _a_2_0_T_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1872:22]
      a_2_1 <= 32'h0; // @[FloatingPointDesigns.scala 1872:22]
    end else begin
      a_2_1 <= stage1_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1872:22]
      a_2_2 <= 32'h0; // @[FloatingPointDesigns.scala 1872:22]
    end else begin
      a_2_2 <= stage2_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1872:22]
      a_2_3 <= 32'h0; // @[FloatingPointDesigns.scala 1872:22]
    end else begin
      a_2_3 <= stage3_regs_0_1_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1872:22]
      a_2_4 <= 32'h0; // @[FloatingPointDesigns.scala 1872:22]
    end else begin
      a_2_4 <= stage4_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1872:22]
      a_2_5 <= 32'h0; // @[FloatingPointDesigns.scala 1872:22]
    end else begin
      a_2_5 <= stage1_regs_1_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1872:22]
      a_2_6 <= 32'h0; // @[FloatingPointDesigns.scala 1872:22]
    end else begin
      a_2_6 <= stage2_regs_1_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1872:22]
      a_2_7 <= 32'h0; // @[FloatingPointDesigns.scala 1872:22]
    end else begin
      a_2_7 <= stage3_regs_1_1_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1872:22]
      a_2_8 <= 32'h0; // @[FloatingPointDesigns.scala 1872:22]
    end else begin
      a_2_8 <= stage4_regs_1_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1872:22]
      a_2_9 <= 32'h0; // @[FloatingPointDesigns.scala 1872:22]
    end else begin
      a_2_9 <= stage1_regs_2_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1872:22]
      a_2_10 <= 32'h0; // @[FloatingPointDesigns.scala 1872:22]
    end else begin
      a_2_10 <= stage2_regs_2_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1872:22]
      a_2_11 <= 32'h0; // @[FloatingPointDesigns.scala 1872:22]
    end else begin
      a_2_11 <= stage3_regs_2_1_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_0_0 <= x_n_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_0_1 <= stage1_regs_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_0_2 <= stage1_regs_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_0_3 <= stage1_regs_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_0_4 <= stage1_regs_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_0_5 <= stage1_regs_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_0_6 <= stage1_regs_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_0_7 <= stage1_regs_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_0_8 <= stage1_regs_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_1_0 <= a_2_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_1_1 <= stage1_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_1_2 <= stage1_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_1_3 <= stage1_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_1_4 <= stage1_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_1_5 <= stage1_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_1_6 <= stage1_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_1_7 <= stage1_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_0_1_8 <= stage1_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_0_0 <= x_n_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_0_1 <= stage1_regs_1_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_0_2 <= stage1_regs_1_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_0_3 <= stage1_regs_1_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_0_4 <= stage1_regs_1_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_0_5 <= stage1_regs_1_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_0_6 <= stage1_regs_1_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_0_7 <= stage1_regs_1_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_0_8 <= stage1_regs_1_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_1_0 <= a_2_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_1_1 <= stage1_regs_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_1_2 <= stage1_regs_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_1_3 <= stage1_regs_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_1_4 <= stage1_regs_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_1_5 <= stage1_regs_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_1_6 <= stage1_regs_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_1_7 <= stage1_regs_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_1_1_8 <= stage1_regs_1_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_0_0 <= x_n_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_0_1 <= stage1_regs_2_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_0_2 <= stage1_regs_2_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_0_3 <= stage1_regs_2_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_0_4 <= stage1_regs_2_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_0_5 <= stage1_regs_2_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_0_6 <= stage1_regs_2_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_0_7 <= stage1_regs_2_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_0_8 <= stage1_regs_2_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_1_0 <= a_2_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_1_1 <= stage1_regs_2_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_1_2 <= stage1_regs_2_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_1_3 <= stage1_regs_2_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_1_4 <= stage1_regs_2_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_1_5 <= stage1_regs_2_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_1_6 <= stage1_regs_2_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_1_7 <= stage1_regs_2_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1873:30]
      stage1_regs_2_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1873:30]
    end else begin
      stage1_regs_2_1_8 <= stage1_regs_2_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_0_0 <= x_n_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_0_1 <= stage2_regs_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_0_2 <= stage2_regs_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_0_3 <= stage2_regs_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_0_4 <= stage2_regs_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_0_5 <= stage2_regs_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_0_6 <= stage2_regs_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_0_7 <= stage2_regs_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_0_8 <= stage2_regs_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_1_0 <= a_2_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_1_1 <= stage2_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_1_2 <= stage2_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_1_3 <= stage2_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_1_4 <= stage2_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_1_5 <= stage2_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_1_6 <= stage2_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_1_7 <= stage2_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_0_1_8 <= stage2_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_0_0 <= x_n_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_0_1 <= stage2_regs_1_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_0_2 <= stage2_regs_1_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_0_3 <= stage2_regs_1_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_0_4 <= stage2_regs_1_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_0_5 <= stage2_regs_1_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_0_6 <= stage2_regs_1_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_0_7 <= stage2_regs_1_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_0_8 <= stage2_regs_1_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_1_0 <= a_2_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_1_1 <= stage2_regs_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_1_2 <= stage2_regs_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_1_3 <= stage2_regs_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_1_4 <= stage2_regs_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_1_5 <= stage2_regs_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_1_6 <= stage2_regs_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_1_7 <= stage2_regs_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_1_1_8 <= stage2_regs_1_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_0_0 <= x_n_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_0_1 <= stage2_regs_2_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_0_2 <= stage2_regs_2_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_0_3 <= stage2_regs_2_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_0_4 <= stage2_regs_2_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_0_5 <= stage2_regs_2_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_0_6 <= stage2_regs_2_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_0_7 <= stage2_regs_2_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_0_8 <= stage2_regs_2_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_1_0 <= a_2_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_1_1 <= stage2_regs_2_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_1_2 <= stage2_regs_2_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_1_3 <= stage2_regs_2_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_1_4 <= stage2_regs_2_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_1_5 <= stage2_regs_2_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_1_6 <= stage2_regs_2_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_1_7 <= stage2_regs_2_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1874:30]
      stage2_regs_2_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1874:30]
    end else begin
      stage2_regs_2_1_8 <= stage2_regs_2_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_0_0 <= x_n_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_0_1 <= stage3_regs_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_0_2 <= stage3_regs_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_0_3 <= stage3_regs_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_0_4 <= stage3_regs_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_0_5 <= stage3_regs_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_0_6 <= stage3_regs_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_0_7 <= stage3_regs_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_0_8 <= stage3_regs_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_0_9 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_0_9 <= stage3_regs_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_0_10 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_0_10 <= stage3_regs_0_0_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_0_11 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_0_11 <= stage3_regs_0_0_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_1_0 <= a_2_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_1_1 <= stage3_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_1_2 <= stage3_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_1_3 <= stage3_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_1_4 <= stage3_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_1_5 <= stage3_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_1_6 <= stage3_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_1_7 <= stage3_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_1_8 <= stage3_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_1_9 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_1_9 <= stage3_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_1_10 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_1_10 <= stage3_regs_0_1_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_0_1_11 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_0_1_11 <= stage3_regs_0_1_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_0_0 <= x_n_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_0_1 <= stage3_regs_1_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_0_2 <= stage3_regs_1_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_0_3 <= stage3_regs_1_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_0_4 <= stage3_regs_1_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_0_5 <= stage3_regs_1_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_0_6 <= stage3_regs_1_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_0_7 <= stage3_regs_1_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_0_8 <= stage3_regs_1_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_0_9 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_0_9 <= stage3_regs_1_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_0_10 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_0_10 <= stage3_regs_1_0_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_0_11 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_0_11 <= stage3_regs_1_0_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_1_0 <= a_2_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_1_1 <= stage3_regs_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_1_2 <= stage3_regs_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_1_3 <= stage3_regs_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_1_4 <= stage3_regs_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_1_5 <= stage3_regs_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_1_6 <= stage3_regs_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_1_7 <= stage3_regs_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_1_8 <= stage3_regs_1_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_1_9 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_1_9 <= stage3_regs_1_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_1_10 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_1_10 <= stage3_regs_1_1_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_1_1_11 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_1_1_11 <= stage3_regs_1_1_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_0_0 <= x_n_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_0_1 <= stage3_regs_2_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_0_2 <= stage3_regs_2_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_0_3 <= stage3_regs_2_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_0_4 <= stage3_regs_2_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_0_5 <= stage3_regs_2_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_0_6 <= stage3_regs_2_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_0_7 <= stage3_regs_2_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_0_8 <= stage3_regs_2_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_0_9 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_0_9 <= stage3_regs_2_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_0_10 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_0_10 <= stage3_regs_2_0_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_0_11 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_0_11 <= stage3_regs_2_0_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_1_0 <= a_2_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_1_1 <= stage3_regs_2_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_1_2 <= stage3_regs_2_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_1_3 <= stage3_regs_2_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_1_4 <= stage3_regs_2_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_1_5 <= stage3_regs_2_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_1_6 <= stage3_regs_2_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_1_7 <= stage3_regs_2_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_1_8 <= stage3_regs_2_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_1_9 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_1_9 <= stage3_regs_2_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_1_10 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_1_10 <= stage3_regs_2_1_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1875:30]
      stage3_regs_2_1_11 <= 32'h0; // @[FloatingPointDesigns.scala 1875:30]
    end else begin
      stage3_regs_2_1_11 <= stage3_regs_2_1_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_0_1_0 <= a_2_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_0_1_1 <= stage4_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_0_1_2 <= stage4_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_0_1_3 <= stage4_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_0_1_4 <= stage4_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_0_1_5 <= stage4_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_0_1_6 <= stage4_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_0_1_7 <= stage4_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_0_1_8 <= stage4_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_1_1_0 <= a_2_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_1_1_1 <= stage4_regs_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_1_1_2 <= stage4_regs_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_1_1_3 <= stage4_regs_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_1_1_4 <= stage4_regs_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_1_1_5 <= stage4_regs_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_1_1_6 <= stage4_regs_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_1_1_7 <= stage4_regs_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_1_1_8 <= stage4_regs_1_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_2_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_2_1_0 <= a_2_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_2_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_2_1_1 <= stage4_regs_2_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_2_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_2_1_2 <= stage4_regs_2_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_2_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_2_1_3 <= stage4_regs_2_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_2_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_2_1_4 <= stage4_regs_2_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_2_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_2_1_5 <= stage4_regs_2_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_2_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_2_1_6 <= stage4_regs_2_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_2_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_2_1_7 <= stage4_regs_2_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 1876:30]
      stage4_regs_2_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 1876:30]
    end else begin
      stage4_regs_2_1_8 <= stage4_regs_2_1_7;
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
  x_n_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  x_n_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  x_n_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  x_n_4 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  x_n_5 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  x_n_6 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  x_n_8 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  x_n_9 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  x_n_10 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  a_2_0 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  a_2_1 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  a_2_2 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  a_2_3 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  a_2_4 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  a_2_5 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  a_2_6 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  a_2_7 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  a_2_8 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  a_2_9 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  a_2_10 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  a_2_11 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  stage1_regs_0_0_0 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  stage1_regs_0_0_1 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  stage1_regs_0_0_2 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  stage1_regs_0_0_3 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  stage1_regs_0_0_4 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  stage1_regs_0_0_5 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  stage1_regs_0_0_6 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  stage1_regs_0_0_7 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  stage1_regs_0_0_8 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  stage1_regs_0_1_0 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  stage1_regs_0_1_1 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  stage1_regs_0_1_2 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  stage1_regs_0_1_3 = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  stage1_regs_0_1_4 = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  stage1_regs_0_1_5 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  stage1_regs_0_1_6 = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  stage1_regs_0_1_7 = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  stage1_regs_0_1_8 = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  stage1_regs_1_0_0 = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  stage1_regs_1_0_1 = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  stage1_regs_1_0_2 = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  stage1_regs_1_0_3 = _RAND_42[31:0];
  _RAND_43 = {1{`RANDOM}};
  stage1_regs_1_0_4 = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  stage1_regs_1_0_5 = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  stage1_regs_1_0_6 = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  stage1_regs_1_0_7 = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  stage1_regs_1_0_8 = _RAND_47[31:0];
  _RAND_48 = {1{`RANDOM}};
  stage1_regs_1_1_0 = _RAND_48[31:0];
  _RAND_49 = {1{`RANDOM}};
  stage1_regs_1_1_1 = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  stage1_regs_1_1_2 = _RAND_50[31:0];
  _RAND_51 = {1{`RANDOM}};
  stage1_regs_1_1_3 = _RAND_51[31:0];
  _RAND_52 = {1{`RANDOM}};
  stage1_regs_1_1_4 = _RAND_52[31:0];
  _RAND_53 = {1{`RANDOM}};
  stage1_regs_1_1_5 = _RAND_53[31:0];
  _RAND_54 = {1{`RANDOM}};
  stage1_regs_1_1_6 = _RAND_54[31:0];
  _RAND_55 = {1{`RANDOM}};
  stage1_regs_1_1_7 = _RAND_55[31:0];
  _RAND_56 = {1{`RANDOM}};
  stage1_regs_1_1_8 = _RAND_56[31:0];
  _RAND_57 = {1{`RANDOM}};
  stage1_regs_2_0_0 = _RAND_57[31:0];
  _RAND_58 = {1{`RANDOM}};
  stage1_regs_2_0_1 = _RAND_58[31:0];
  _RAND_59 = {1{`RANDOM}};
  stage1_regs_2_0_2 = _RAND_59[31:0];
  _RAND_60 = {1{`RANDOM}};
  stage1_regs_2_0_3 = _RAND_60[31:0];
  _RAND_61 = {1{`RANDOM}};
  stage1_regs_2_0_4 = _RAND_61[31:0];
  _RAND_62 = {1{`RANDOM}};
  stage1_regs_2_0_5 = _RAND_62[31:0];
  _RAND_63 = {1{`RANDOM}};
  stage1_regs_2_0_6 = _RAND_63[31:0];
  _RAND_64 = {1{`RANDOM}};
  stage1_regs_2_0_7 = _RAND_64[31:0];
  _RAND_65 = {1{`RANDOM}};
  stage1_regs_2_0_8 = _RAND_65[31:0];
  _RAND_66 = {1{`RANDOM}};
  stage1_regs_2_1_0 = _RAND_66[31:0];
  _RAND_67 = {1{`RANDOM}};
  stage1_regs_2_1_1 = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  stage1_regs_2_1_2 = _RAND_68[31:0];
  _RAND_69 = {1{`RANDOM}};
  stage1_regs_2_1_3 = _RAND_69[31:0];
  _RAND_70 = {1{`RANDOM}};
  stage1_regs_2_1_4 = _RAND_70[31:0];
  _RAND_71 = {1{`RANDOM}};
  stage1_regs_2_1_5 = _RAND_71[31:0];
  _RAND_72 = {1{`RANDOM}};
  stage1_regs_2_1_6 = _RAND_72[31:0];
  _RAND_73 = {1{`RANDOM}};
  stage1_regs_2_1_7 = _RAND_73[31:0];
  _RAND_74 = {1{`RANDOM}};
  stage1_regs_2_1_8 = _RAND_74[31:0];
  _RAND_75 = {1{`RANDOM}};
  stage2_regs_0_0_0 = _RAND_75[31:0];
  _RAND_76 = {1{`RANDOM}};
  stage2_regs_0_0_1 = _RAND_76[31:0];
  _RAND_77 = {1{`RANDOM}};
  stage2_regs_0_0_2 = _RAND_77[31:0];
  _RAND_78 = {1{`RANDOM}};
  stage2_regs_0_0_3 = _RAND_78[31:0];
  _RAND_79 = {1{`RANDOM}};
  stage2_regs_0_0_4 = _RAND_79[31:0];
  _RAND_80 = {1{`RANDOM}};
  stage2_regs_0_0_5 = _RAND_80[31:0];
  _RAND_81 = {1{`RANDOM}};
  stage2_regs_0_0_6 = _RAND_81[31:0];
  _RAND_82 = {1{`RANDOM}};
  stage2_regs_0_0_7 = _RAND_82[31:0];
  _RAND_83 = {1{`RANDOM}};
  stage2_regs_0_0_8 = _RAND_83[31:0];
  _RAND_84 = {1{`RANDOM}};
  stage2_regs_0_1_0 = _RAND_84[31:0];
  _RAND_85 = {1{`RANDOM}};
  stage2_regs_0_1_1 = _RAND_85[31:0];
  _RAND_86 = {1{`RANDOM}};
  stage2_regs_0_1_2 = _RAND_86[31:0];
  _RAND_87 = {1{`RANDOM}};
  stage2_regs_0_1_3 = _RAND_87[31:0];
  _RAND_88 = {1{`RANDOM}};
  stage2_regs_0_1_4 = _RAND_88[31:0];
  _RAND_89 = {1{`RANDOM}};
  stage2_regs_0_1_5 = _RAND_89[31:0];
  _RAND_90 = {1{`RANDOM}};
  stage2_regs_0_1_6 = _RAND_90[31:0];
  _RAND_91 = {1{`RANDOM}};
  stage2_regs_0_1_7 = _RAND_91[31:0];
  _RAND_92 = {1{`RANDOM}};
  stage2_regs_0_1_8 = _RAND_92[31:0];
  _RAND_93 = {1{`RANDOM}};
  stage2_regs_1_0_0 = _RAND_93[31:0];
  _RAND_94 = {1{`RANDOM}};
  stage2_regs_1_0_1 = _RAND_94[31:0];
  _RAND_95 = {1{`RANDOM}};
  stage2_regs_1_0_2 = _RAND_95[31:0];
  _RAND_96 = {1{`RANDOM}};
  stage2_regs_1_0_3 = _RAND_96[31:0];
  _RAND_97 = {1{`RANDOM}};
  stage2_regs_1_0_4 = _RAND_97[31:0];
  _RAND_98 = {1{`RANDOM}};
  stage2_regs_1_0_5 = _RAND_98[31:0];
  _RAND_99 = {1{`RANDOM}};
  stage2_regs_1_0_6 = _RAND_99[31:0];
  _RAND_100 = {1{`RANDOM}};
  stage2_regs_1_0_7 = _RAND_100[31:0];
  _RAND_101 = {1{`RANDOM}};
  stage2_regs_1_0_8 = _RAND_101[31:0];
  _RAND_102 = {1{`RANDOM}};
  stage2_regs_1_1_0 = _RAND_102[31:0];
  _RAND_103 = {1{`RANDOM}};
  stage2_regs_1_1_1 = _RAND_103[31:0];
  _RAND_104 = {1{`RANDOM}};
  stage2_regs_1_1_2 = _RAND_104[31:0];
  _RAND_105 = {1{`RANDOM}};
  stage2_regs_1_1_3 = _RAND_105[31:0];
  _RAND_106 = {1{`RANDOM}};
  stage2_regs_1_1_4 = _RAND_106[31:0];
  _RAND_107 = {1{`RANDOM}};
  stage2_regs_1_1_5 = _RAND_107[31:0];
  _RAND_108 = {1{`RANDOM}};
  stage2_regs_1_1_6 = _RAND_108[31:0];
  _RAND_109 = {1{`RANDOM}};
  stage2_regs_1_1_7 = _RAND_109[31:0];
  _RAND_110 = {1{`RANDOM}};
  stage2_regs_1_1_8 = _RAND_110[31:0];
  _RAND_111 = {1{`RANDOM}};
  stage2_regs_2_0_0 = _RAND_111[31:0];
  _RAND_112 = {1{`RANDOM}};
  stage2_regs_2_0_1 = _RAND_112[31:0];
  _RAND_113 = {1{`RANDOM}};
  stage2_regs_2_0_2 = _RAND_113[31:0];
  _RAND_114 = {1{`RANDOM}};
  stage2_regs_2_0_3 = _RAND_114[31:0];
  _RAND_115 = {1{`RANDOM}};
  stage2_regs_2_0_4 = _RAND_115[31:0];
  _RAND_116 = {1{`RANDOM}};
  stage2_regs_2_0_5 = _RAND_116[31:0];
  _RAND_117 = {1{`RANDOM}};
  stage2_regs_2_0_6 = _RAND_117[31:0];
  _RAND_118 = {1{`RANDOM}};
  stage2_regs_2_0_7 = _RAND_118[31:0];
  _RAND_119 = {1{`RANDOM}};
  stage2_regs_2_0_8 = _RAND_119[31:0];
  _RAND_120 = {1{`RANDOM}};
  stage2_regs_2_1_0 = _RAND_120[31:0];
  _RAND_121 = {1{`RANDOM}};
  stage2_regs_2_1_1 = _RAND_121[31:0];
  _RAND_122 = {1{`RANDOM}};
  stage2_regs_2_1_2 = _RAND_122[31:0];
  _RAND_123 = {1{`RANDOM}};
  stage2_regs_2_1_3 = _RAND_123[31:0];
  _RAND_124 = {1{`RANDOM}};
  stage2_regs_2_1_4 = _RAND_124[31:0];
  _RAND_125 = {1{`RANDOM}};
  stage2_regs_2_1_5 = _RAND_125[31:0];
  _RAND_126 = {1{`RANDOM}};
  stage2_regs_2_1_6 = _RAND_126[31:0];
  _RAND_127 = {1{`RANDOM}};
  stage2_regs_2_1_7 = _RAND_127[31:0];
  _RAND_128 = {1{`RANDOM}};
  stage2_regs_2_1_8 = _RAND_128[31:0];
  _RAND_129 = {1{`RANDOM}};
  stage3_regs_0_0_0 = _RAND_129[31:0];
  _RAND_130 = {1{`RANDOM}};
  stage3_regs_0_0_1 = _RAND_130[31:0];
  _RAND_131 = {1{`RANDOM}};
  stage3_regs_0_0_2 = _RAND_131[31:0];
  _RAND_132 = {1{`RANDOM}};
  stage3_regs_0_0_3 = _RAND_132[31:0];
  _RAND_133 = {1{`RANDOM}};
  stage3_regs_0_0_4 = _RAND_133[31:0];
  _RAND_134 = {1{`RANDOM}};
  stage3_regs_0_0_5 = _RAND_134[31:0];
  _RAND_135 = {1{`RANDOM}};
  stage3_regs_0_0_6 = _RAND_135[31:0];
  _RAND_136 = {1{`RANDOM}};
  stage3_regs_0_0_7 = _RAND_136[31:0];
  _RAND_137 = {1{`RANDOM}};
  stage3_regs_0_0_8 = _RAND_137[31:0];
  _RAND_138 = {1{`RANDOM}};
  stage3_regs_0_0_9 = _RAND_138[31:0];
  _RAND_139 = {1{`RANDOM}};
  stage3_regs_0_0_10 = _RAND_139[31:0];
  _RAND_140 = {1{`RANDOM}};
  stage3_regs_0_0_11 = _RAND_140[31:0];
  _RAND_141 = {1{`RANDOM}};
  stage3_regs_0_1_0 = _RAND_141[31:0];
  _RAND_142 = {1{`RANDOM}};
  stage3_regs_0_1_1 = _RAND_142[31:0];
  _RAND_143 = {1{`RANDOM}};
  stage3_regs_0_1_2 = _RAND_143[31:0];
  _RAND_144 = {1{`RANDOM}};
  stage3_regs_0_1_3 = _RAND_144[31:0];
  _RAND_145 = {1{`RANDOM}};
  stage3_regs_0_1_4 = _RAND_145[31:0];
  _RAND_146 = {1{`RANDOM}};
  stage3_regs_0_1_5 = _RAND_146[31:0];
  _RAND_147 = {1{`RANDOM}};
  stage3_regs_0_1_6 = _RAND_147[31:0];
  _RAND_148 = {1{`RANDOM}};
  stage3_regs_0_1_7 = _RAND_148[31:0];
  _RAND_149 = {1{`RANDOM}};
  stage3_regs_0_1_8 = _RAND_149[31:0];
  _RAND_150 = {1{`RANDOM}};
  stage3_regs_0_1_9 = _RAND_150[31:0];
  _RAND_151 = {1{`RANDOM}};
  stage3_regs_0_1_10 = _RAND_151[31:0];
  _RAND_152 = {1{`RANDOM}};
  stage3_regs_0_1_11 = _RAND_152[31:0];
  _RAND_153 = {1{`RANDOM}};
  stage3_regs_1_0_0 = _RAND_153[31:0];
  _RAND_154 = {1{`RANDOM}};
  stage3_regs_1_0_1 = _RAND_154[31:0];
  _RAND_155 = {1{`RANDOM}};
  stage3_regs_1_0_2 = _RAND_155[31:0];
  _RAND_156 = {1{`RANDOM}};
  stage3_regs_1_0_3 = _RAND_156[31:0];
  _RAND_157 = {1{`RANDOM}};
  stage3_regs_1_0_4 = _RAND_157[31:0];
  _RAND_158 = {1{`RANDOM}};
  stage3_regs_1_0_5 = _RAND_158[31:0];
  _RAND_159 = {1{`RANDOM}};
  stage3_regs_1_0_6 = _RAND_159[31:0];
  _RAND_160 = {1{`RANDOM}};
  stage3_regs_1_0_7 = _RAND_160[31:0];
  _RAND_161 = {1{`RANDOM}};
  stage3_regs_1_0_8 = _RAND_161[31:0];
  _RAND_162 = {1{`RANDOM}};
  stage3_regs_1_0_9 = _RAND_162[31:0];
  _RAND_163 = {1{`RANDOM}};
  stage3_regs_1_0_10 = _RAND_163[31:0];
  _RAND_164 = {1{`RANDOM}};
  stage3_regs_1_0_11 = _RAND_164[31:0];
  _RAND_165 = {1{`RANDOM}};
  stage3_regs_1_1_0 = _RAND_165[31:0];
  _RAND_166 = {1{`RANDOM}};
  stage3_regs_1_1_1 = _RAND_166[31:0];
  _RAND_167 = {1{`RANDOM}};
  stage3_regs_1_1_2 = _RAND_167[31:0];
  _RAND_168 = {1{`RANDOM}};
  stage3_regs_1_1_3 = _RAND_168[31:0];
  _RAND_169 = {1{`RANDOM}};
  stage3_regs_1_1_4 = _RAND_169[31:0];
  _RAND_170 = {1{`RANDOM}};
  stage3_regs_1_1_5 = _RAND_170[31:0];
  _RAND_171 = {1{`RANDOM}};
  stage3_regs_1_1_6 = _RAND_171[31:0];
  _RAND_172 = {1{`RANDOM}};
  stage3_regs_1_1_7 = _RAND_172[31:0];
  _RAND_173 = {1{`RANDOM}};
  stage3_regs_1_1_8 = _RAND_173[31:0];
  _RAND_174 = {1{`RANDOM}};
  stage3_regs_1_1_9 = _RAND_174[31:0];
  _RAND_175 = {1{`RANDOM}};
  stage3_regs_1_1_10 = _RAND_175[31:0];
  _RAND_176 = {1{`RANDOM}};
  stage3_regs_1_1_11 = _RAND_176[31:0];
  _RAND_177 = {1{`RANDOM}};
  stage3_regs_2_0_0 = _RAND_177[31:0];
  _RAND_178 = {1{`RANDOM}};
  stage3_regs_2_0_1 = _RAND_178[31:0];
  _RAND_179 = {1{`RANDOM}};
  stage3_regs_2_0_2 = _RAND_179[31:0];
  _RAND_180 = {1{`RANDOM}};
  stage3_regs_2_0_3 = _RAND_180[31:0];
  _RAND_181 = {1{`RANDOM}};
  stage3_regs_2_0_4 = _RAND_181[31:0];
  _RAND_182 = {1{`RANDOM}};
  stage3_regs_2_0_5 = _RAND_182[31:0];
  _RAND_183 = {1{`RANDOM}};
  stage3_regs_2_0_6 = _RAND_183[31:0];
  _RAND_184 = {1{`RANDOM}};
  stage3_regs_2_0_7 = _RAND_184[31:0];
  _RAND_185 = {1{`RANDOM}};
  stage3_regs_2_0_8 = _RAND_185[31:0];
  _RAND_186 = {1{`RANDOM}};
  stage3_regs_2_0_9 = _RAND_186[31:0];
  _RAND_187 = {1{`RANDOM}};
  stage3_regs_2_0_10 = _RAND_187[31:0];
  _RAND_188 = {1{`RANDOM}};
  stage3_regs_2_0_11 = _RAND_188[31:0];
  _RAND_189 = {1{`RANDOM}};
  stage3_regs_2_1_0 = _RAND_189[31:0];
  _RAND_190 = {1{`RANDOM}};
  stage3_regs_2_1_1 = _RAND_190[31:0];
  _RAND_191 = {1{`RANDOM}};
  stage3_regs_2_1_2 = _RAND_191[31:0];
  _RAND_192 = {1{`RANDOM}};
  stage3_regs_2_1_3 = _RAND_192[31:0];
  _RAND_193 = {1{`RANDOM}};
  stage3_regs_2_1_4 = _RAND_193[31:0];
  _RAND_194 = {1{`RANDOM}};
  stage3_regs_2_1_5 = _RAND_194[31:0];
  _RAND_195 = {1{`RANDOM}};
  stage3_regs_2_1_6 = _RAND_195[31:0];
  _RAND_196 = {1{`RANDOM}};
  stage3_regs_2_1_7 = _RAND_196[31:0];
  _RAND_197 = {1{`RANDOM}};
  stage3_regs_2_1_8 = _RAND_197[31:0];
  _RAND_198 = {1{`RANDOM}};
  stage3_regs_2_1_9 = _RAND_198[31:0];
  _RAND_199 = {1{`RANDOM}};
  stage3_regs_2_1_10 = _RAND_199[31:0];
  _RAND_200 = {1{`RANDOM}};
  stage3_regs_2_1_11 = _RAND_200[31:0];
  _RAND_201 = {1{`RANDOM}};
  stage4_regs_0_1_0 = _RAND_201[31:0];
  _RAND_202 = {1{`RANDOM}};
  stage4_regs_0_1_1 = _RAND_202[31:0];
  _RAND_203 = {1{`RANDOM}};
  stage4_regs_0_1_2 = _RAND_203[31:0];
  _RAND_204 = {1{`RANDOM}};
  stage4_regs_0_1_3 = _RAND_204[31:0];
  _RAND_205 = {1{`RANDOM}};
  stage4_regs_0_1_4 = _RAND_205[31:0];
  _RAND_206 = {1{`RANDOM}};
  stage4_regs_0_1_5 = _RAND_206[31:0];
  _RAND_207 = {1{`RANDOM}};
  stage4_regs_0_1_6 = _RAND_207[31:0];
  _RAND_208 = {1{`RANDOM}};
  stage4_regs_0_1_7 = _RAND_208[31:0];
  _RAND_209 = {1{`RANDOM}};
  stage4_regs_0_1_8 = _RAND_209[31:0];
  _RAND_210 = {1{`RANDOM}};
  stage4_regs_1_1_0 = _RAND_210[31:0];
  _RAND_211 = {1{`RANDOM}};
  stage4_regs_1_1_1 = _RAND_211[31:0];
  _RAND_212 = {1{`RANDOM}};
  stage4_regs_1_1_2 = _RAND_212[31:0];
  _RAND_213 = {1{`RANDOM}};
  stage4_regs_1_1_3 = _RAND_213[31:0];
  _RAND_214 = {1{`RANDOM}};
  stage4_regs_1_1_4 = _RAND_214[31:0];
  _RAND_215 = {1{`RANDOM}};
  stage4_regs_1_1_5 = _RAND_215[31:0];
  _RAND_216 = {1{`RANDOM}};
  stage4_regs_1_1_6 = _RAND_216[31:0];
  _RAND_217 = {1{`RANDOM}};
  stage4_regs_1_1_7 = _RAND_217[31:0];
  _RAND_218 = {1{`RANDOM}};
  stage4_regs_1_1_8 = _RAND_218[31:0];
  _RAND_219 = {1{`RANDOM}};
  stage4_regs_2_1_0 = _RAND_219[31:0];
  _RAND_220 = {1{`RANDOM}};
  stage4_regs_2_1_1 = _RAND_220[31:0];
  _RAND_221 = {1{`RANDOM}};
  stage4_regs_2_1_2 = _RAND_221[31:0];
  _RAND_222 = {1{`RANDOM}};
  stage4_regs_2_1_3 = _RAND_222[31:0];
  _RAND_223 = {1{`RANDOM}};
  stage4_regs_2_1_4 = _RAND_223[31:0];
  _RAND_224 = {1{`RANDOM}};
  stage4_regs_2_1_5 = _RAND_224[31:0];
  _RAND_225 = {1{`RANDOM}};
  stage4_regs_2_1_6 = _RAND_225[31:0];
  _RAND_226 = {1{`RANDOM}};
  stage4_regs_2_1_7 = _RAND_226[31:0];
  _RAND_227 = {1{`RANDOM}};
  stage4_regs_2_1_8 = _RAND_227[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module hqr5(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b,
  output [31:0] io_out_s
);
  wire  FP_adder_13ccs_clock; // @[FloatingPointDesigns.scala 2512:23]
  wire  FP_adder_13ccs_reset; // @[FloatingPointDesigns.scala 2512:23]
  wire [31:0] FP_adder_13ccs_io_in_a; // @[FloatingPointDesigns.scala 2512:23]
  wire [31:0] FP_adder_13ccs_io_in_b; // @[FloatingPointDesigns.scala 2512:23]
  wire [31:0] FP_adder_13ccs_io_out_s; // @[FloatingPointDesigns.scala 2512:23]
  wire  FP_subtractor_13ccs_clock; // @[FloatingPointDesigns.scala 2513:28]
  wire  FP_subtractor_13ccs_reset; // @[FloatingPointDesigns.scala 2513:28]
  wire [31:0] FP_subtractor_13ccs_io_in_a; // @[FloatingPointDesigns.scala 2513:28]
  wire [31:0] FP_subtractor_13ccs_io_in_b; // @[FloatingPointDesigns.scala 2513:28]
  wire [31:0] FP_subtractor_13ccs_io_out_s; // @[FloatingPointDesigns.scala 2513:28]
  FP_adder_13ccs FP_adder_13ccs ( // @[FloatingPointDesigns.scala 2512:23]
    .clock(FP_adder_13ccs_clock),
    .reset(FP_adder_13ccs_reset),
    .io_in_a(FP_adder_13ccs_io_in_a),
    .io_in_b(FP_adder_13ccs_io_in_b),
    .io_out_s(FP_adder_13ccs_io_out_s)
  );
  FP_subtractor_13ccs FP_subtractor_13ccs ( // @[FloatingPointDesigns.scala 2513:28]
    .clock(FP_subtractor_13ccs_clock),
    .reset(FP_subtractor_13ccs_reset),
    .io_in_a(FP_subtractor_13ccs_io_in_a),
    .io_in_b(FP_subtractor_13ccs_io_in_b),
    .io_out_s(FP_subtractor_13ccs_io_out_s)
  );
  assign io_out_s = io_in_a[31] ? FP_subtractor_13ccs_io_out_s : FP_adder_13ccs_io_out_s; // @[FloatingPointDesigns.scala 2521:24 2522:14 2524:14]
  assign FP_adder_13ccs_clock = clock;
  assign FP_adder_13ccs_reset = reset;
  assign FP_adder_13ccs_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2515:16]
  assign FP_adder_13ccs_io_in_b = io_in_b; // @[FloatingPointDesigns.scala 2516:16]
  assign FP_subtractor_13ccs_clock = clock;
  assign FP_subtractor_13ccs_reset = reset;
  assign FP_subtractor_13ccs_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2518:21]
  assign FP_subtractor_13ccs_io_in_b = io_in_b; // @[FloatingPointDesigns.scala 2519:21]
endmodule
module FP_reciprocal_newfpu(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
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
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
  reg [31:0] _RAND_139;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
  reg [31:0] _RAND_144;
  reg [31:0] _RAND_145;
  reg [31:0] _RAND_146;
  reg [31:0] _RAND_147;
  reg [31:0] _RAND_148;
  reg [31:0] _RAND_149;
  reg [31:0] _RAND_150;
  reg [31:0] _RAND_151;
  reg [31:0] _RAND_152;
  reg [31:0] _RAND_153;
  reg [31:0] _RAND_154;
  reg [31:0] _RAND_155;
  reg [31:0] _RAND_156;
  reg [31:0] _RAND_157;
  reg [31:0] _RAND_158;
  reg [31:0] _RAND_159;
  reg [31:0] _RAND_160;
  reg [31:0] _RAND_161;
  reg [31:0] _RAND_162;
  reg [31:0] _RAND_163;
  reg [31:0] _RAND_164;
  reg [31:0] _RAND_165;
  reg [31:0] _RAND_166;
  reg [31:0] _RAND_167;
  reg [31:0] _RAND_168;
  reg [31:0] _RAND_169;
  reg [31:0] _RAND_170;
  reg [31:0] _RAND_171;
  reg [31:0] _RAND_172;
  reg [31:0] _RAND_173;
  reg [31:0] _RAND_174;
  reg [31:0] _RAND_175;
  reg [31:0] _RAND_176;
  reg [31:0] _RAND_177;
  reg [31:0] _RAND_178;
  reg [31:0] _RAND_179;
  reg [31:0] _RAND_180;
  reg [31:0] _RAND_181;
  reg [31:0] _RAND_182;
  reg [31:0] _RAND_183;
  reg [31:0] _RAND_184;
  reg [31:0] _RAND_185;
  reg [31:0] _RAND_186;
  reg [31:0] _RAND_187;
  reg [31:0] _RAND_188;
  reg [31:0] _RAND_189;
  reg [31:0] _RAND_190;
  reg [31:0] _RAND_191;
  reg [31:0] _RAND_192;
  reg [31:0] _RAND_193;
  reg [31:0] _RAND_194;
  reg [31:0] _RAND_195;
  reg [31:0] _RAND_196;
  reg [31:0] _RAND_197;
`endif // RANDOMIZE_REG_INIT
  wire  FP_multiplier_10ccs_clock; // @[FloatingPointDesigns.scala 2007:65]
  wire  FP_multiplier_10ccs_reset; // @[FloatingPointDesigns.scala 2007:65]
  wire [31:0] FP_multiplier_10ccs_io_in_a; // @[FloatingPointDesigns.scala 2007:65]
  wire [31:0] FP_multiplier_10ccs_io_in_b; // @[FloatingPointDesigns.scala 2007:65]
  wire [31:0] FP_multiplier_10ccs_io_out_s; // @[FloatingPointDesigns.scala 2007:65]
  wire  FP_multiplier_10ccs_1_clock; // @[FloatingPointDesigns.scala 2007:65]
  wire  FP_multiplier_10ccs_1_reset; // @[FloatingPointDesigns.scala 2007:65]
  wire [31:0] FP_multiplier_10ccs_1_io_in_a; // @[FloatingPointDesigns.scala 2007:65]
  wire [31:0] FP_multiplier_10ccs_1_io_in_b; // @[FloatingPointDesigns.scala 2007:65]
  wire [31:0] FP_multiplier_10ccs_1_io_out_s; // @[FloatingPointDesigns.scala 2007:65]
  wire  FP_multiplier_10ccs_2_clock; // @[FloatingPointDesigns.scala 2007:65]
  wire  FP_multiplier_10ccs_2_reset; // @[FloatingPointDesigns.scala 2007:65]
  wire [31:0] FP_multiplier_10ccs_2_io_in_a; // @[FloatingPointDesigns.scala 2007:65]
  wire [31:0] FP_multiplier_10ccs_2_io_in_b; // @[FloatingPointDesigns.scala 2007:65]
  wire [31:0] FP_multiplier_10ccs_2_io_out_s; // @[FloatingPointDesigns.scala 2007:65]
  wire  FP_subtractor_13ccs_clock; // @[FloatingPointDesigns.scala 2008:50]
  wire  FP_subtractor_13ccs_reset; // @[FloatingPointDesigns.scala 2008:50]
  wire [31:0] FP_subtractor_13ccs_io_in_a; // @[FloatingPointDesigns.scala 2008:50]
  wire [31:0] FP_subtractor_13ccs_io_in_b; // @[FloatingPointDesigns.scala 2008:50]
  wire [31:0] FP_subtractor_13ccs_io_out_s; // @[FloatingPointDesigns.scala 2008:50]
  wire  multiplier4_clock; // @[FloatingPointDesigns.scala 2087:29]
  wire  multiplier4_reset; // @[FloatingPointDesigns.scala 2087:29]
  wire [31:0] multiplier4_io_in_a; // @[FloatingPointDesigns.scala 2087:29]
  wire [31:0] multiplier4_io_in_b; // @[FloatingPointDesigns.scala 2087:29]
  wire [31:0] multiplier4_io_out_s; // @[FloatingPointDesigns.scala 2087:29]
  wire  FP_multiplier_10ccs_3_clock; // @[FloatingPointDesigns.scala 2099:69]
  wire  FP_multiplier_10ccs_3_reset; // @[FloatingPointDesigns.scala 2099:69]
  wire [31:0] FP_multiplier_10ccs_3_io_in_a; // @[FloatingPointDesigns.scala 2099:69]
  wire [31:0] FP_multiplier_10ccs_3_io_in_b; // @[FloatingPointDesigns.scala 2099:69]
  wire [31:0] FP_multiplier_10ccs_3_io_out_s; // @[FloatingPointDesigns.scala 2099:69]
  wire  FP_multiplier_10ccs_4_clock; // @[FloatingPointDesigns.scala 2099:69]
  wire  FP_multiplier_10ccs_4_reset; // @[FloatingPointDesigns.scala 2099:69]
  wire [31:0] FP_multiplier_10ccs_4_io_in_a; // @[FloatingPointDesigns.scala 2099:69]
  wire [31:0] FP_multiplier_10ccs_4_io_in_b; // @[FloatingPointDesigns.scala 2099:69]
  wire [31:0] FP_multiplier_10ccs_4_io_out_s; // @[FloatingPointDesigns.scala 2099:69]
  wire  FP_multiplier_10ccs_5_clock; // @[FloatingPointDesigns.scala 2099:69]
  wire  FP_multiplier_10ccs_5_reset; // @[FloatingPointDesigns.scala 2099:69]
  wire [31:0] FP_multiplier_10ccs_5_io_in_a; // @[FloatingPointDesigns.scala 2099:69]
  wire [31:0] FP_multiplier_10ccs_5_io_in_b; // @[FloatingPointDesigns.scala 2099:69]
  wire [31:0] FP_multiplier_10ccs_5_io_out_s; // @[FloatingPointDesigns.scala 2099:69]
  wire  FP_multiplier_10ccs_6_clock; // @[FloatingPointDesigns.scala 2099:69]
  wire  FP_multiplier_10ccs_6_reset; // @[FloatingPointDesigns.scala 2099:69]
  wire [31:0] FP_multiplier_10ccs_6_io_in_a; // @[FloatingPointDesigns.scala 2099:69]
  wire [31:0] FP_multiplier_10ccs_6_io_in_b; // @[FloatingPointDesigns.scala 2099:69]
  wire [31:0] FP_multiplier_10ccs_6_io_out_s; // @[FloatingPointDesigns.scala 2099:69]
  wire  FP_subtractor_13ccs_1_clock; // @[FloatingPointDesigns.scala 2100:54]
  wire  FP_subtractor_13ccs_1_reset; // @[FloatingPointDesigns.scala 2100:54]
  wire [31:0] FP_subtractor_13ccs_1_io_in_a; // @[FloatingPointDesigns.scala 2100:54]
  wire [31:0] FP_subtractor_13ccs_1_io_in_b; // @[FloatingPointDesigns.scala 2100:54]
  wire [31:0] FP_subtractor_13ccs_1_io_out_s; // @[FloatingPointDesigns.scala 2100:54]
  wire  FP_subtractor_13ccs_2_clock; // @[FloatingPointDesigns.scala 2100:54]
  wire  FP_subtractor_13ccs_2_reset; // @[FloatingPointDesigns.scala 2100:54]
  wire [31:0] FP_subtractor_13ccs_2_io_in_a; // @[FloatingPointDesigns.scala 2100:54]
  wire [31:0] FP_subtractor_13ccs_2_io_in_b; // @[FloatingPointDesigns.scala 2100:54]
  wire [31:0] FP_subtractor_13ccs_2_io_out_s; // @[FloatingPointDesigns.scala 2100:54]
  wire [30:0] _number_T_1 = {{1'd0}, io_in_a[30:1]}; // @[FloatingPointDesigns.scala 1992:36]
  wire [30:0] _GEN_0 = io_in_a[30:0] > 31'h7ef477d4 ? 31'h3f7a3bea : _number_T_1; // @[FloatingPointDesigns.scala 1989:46 1990:14 1992:14]
  wire [31:0] number = {{1'd0}, _GEN_0}; // @[FloatingPointDesigns.scala 1984:22]
  wire [31:0] result = 32'h5f3759df - number; // @[FloatingPointDesigns.scala 1999:25]
  reg [31:0] x_n_0; // @[FloatingPointDesigns.scala 2001:22]
  reg [31:0] x_n_1; // @[FloatingPointDesigns.scala 2001:22]
  reg [31:0] x_n_2; // @[FloatingPointDesigns.scala 2001:22]
  reg [31:0] a_2_0; // @[FloatingPointDesigns.scala 2002:22]
  reg [31:0] a_2_1; // @[FloatingPointDesigns.scala 2002:22]
  reg [31:0] a_2_2; // @[FloatingPointDesigns.scala 2002:22]
  reg [31:0] a_2_3; // @[FloatingPointDesigns.scala 2002:22]
  reg [31:0] stage1_regs_0_0_0; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_0_1; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_0_2; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_0_3; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_0_4; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_0_5; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_0_6; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_0_7; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_0_8; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_1_0; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_1_1; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_1_2; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_1_3; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_1_4; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_1_5; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_1_6; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_1_7; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage1_regs_0_1_8; // @[FloatingPointDesigns.scala 2003:30]
  reg [31:0] stage2_regs_0_0_0; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_0_1; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_0_2; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_0_3; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_0_4; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_0_5; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_0_6; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_0_7; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_0_8; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_1_0; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_1_1; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_1_2; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_1_3; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_1_4; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_1_5; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_1_6; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_1_7; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage2_regs_0_1_8; // @[FloatingPointDesigns.scala 2004:30]
  reg [31:0] stage3_regs_0_0_0; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_0_1; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_0_2; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_0_3; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_0_4; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_0_5; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_0_6; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_0_7; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_0_8; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_0_9; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_0_10; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_0_11; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_1_0; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_1_1; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_1_2; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_1_3; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_1_4; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_1_5; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_1_6; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_1_7; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_1_8; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_1_9; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_1_10; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage3_regs_0_1_11; // @[FloatingPointDesigns.scala 2005:30]
  reg [31:0] stage4_regs_0_1_0; // @[FloatingPointDesigns.scala 2006:30]
  reg [31:0] stage4_regs_0_1_1; // @[FloatingPointDesigns.scala 2006:30]
  reg [31:0] stage4_regs_0_1_2; // @[FloatingPointDesigns.scala 2006:30]
  reg [31:0] stage4_regs_0_1_3; // @[FloatingPointDesigns.scala 2006:30]
  reg [31:0] stage4_regs_0_1_4; // @[FloatingPointDesigns.scala 2006:30]
  reg [31:0] stage4_regs_0_1_5; // @[FloatingPointDesigns.scala 2006:30]
  reg [31:0] stage4_regs_0_1_6; // @[FloatingPointDesigns.scala 2006:30]
  reg [31:0] stage4_regs_0_1_7; // @[FloatingPointDesigns.scala 2006:30]
  reg [31:0] stage4_regs_0_1_8; // @[FloatingPointDesigns.scala 2006:30]
  wire [7:0] _a_2_0_T_3 = io_in_a[30:23] - 8'h1; // @[FloatingPointDesigns.scala 2032:75]
  wire [31:0] _a_2_0_T_6 = {io_in_a[31],_a_2_0_T_3,io_in_a[22:0]}; // @[FloatingPointDesigns.scala 2032:82]
  reg [31:0] a_2_isr_to_r; // @[FloatingPointDesigns.scala 2077:31]
  reg [31:0] transition_regs_0; // @[FloatingPointDesigns.scala 2078:34]
  reg [31:0] transition_regs_1; // @[FloatingPointDesigns.scala 2078:34]
  reg [31:0] transition_regs_2; // @[FloatingPointDesigns.scala 2078:34]
  reg [31:0] transition_regs_3; // @[FloatingPointDesigns.scala 2078:34]
  reg [31:0] transition_regs_4; // @[FloatingPointDesigns.scala 2078:34]
  reg [31:0] transition_regs_5; // @[FloatingPointDesigns.scala 2078:34]
  reg [31:0] transition_regs_6; // @[FloatingPointDesigns.scala 2078:34]
  reg [31:0] transition_regs_7; // @[FloatingPointDesigns.scala 2078:34]
  reg [31:0] transition_regs_8; // @[FloatingPointDesigns.scala 2078:34]
  wire [7:0] _a_2_isr_to_r_T_3 = stage4_regs_0_1_8[30:23] + 8'h1; // @[FloatingPointDesigns.scala 2080:115]
  wire [31:0] _a_2_isr_to_r_T_6 = {stage4_regs_0_1_8[31],_a_2_isr_to_r_T_3,stage4_regs_0_1_8[22:0]}; // @[FloatingPointDesigns.scala 2080:122]
  reg [31:0] x_n_r_0; // @[FloatingPointDesigns.scala 2094:24]
  reg [31:0] x_n_r_1; // @[FloatingPointDesigns.scala 2094:24]
  reg [31:0] x_n_r_3; // @[FloatingPointDesigns.scala 2094:24]
  reg [31:0] x_n_r_4; // @[FloatingPointDesigns.scala 2094:24]
  reg [31:0] a_2_r_0; // @[FloatingPointDesigns.scala 2095:24]
  reg [31:0] a_2_r_1; // @[FloatingPointDesigns.scala 2095:24]
  reg [31:0] a_2_r_2; // @[FloatingPointDesigns.scala 2095:24]
  reg [31:0] a_2_r_3; // @[FloatingPointDesigns.scala 2095:24]
  reg [31:0] a_2_r_4; // @[FloatingPointDesigns.scala 2095:24]
  reg [31:0] a_2_r_5; // @[FloatingPointDesigns.scala 2095:24]
  reg [31:0] stage1_regs_r_0_0_0; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_0_1; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_0_2; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_0_3; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_0_4; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_0_5; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_0_6; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_0_7; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_0_8; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_1_0; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_1_1; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_1_2; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_1_3; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_1_4; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_1_5; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_1_6; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_1_7; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_0_1_8; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_0_0; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_0_1; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_0_2; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_0_3; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_0_4; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_0_5; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_0_6; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_0_7; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_0_8; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_1_0; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_1_1; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_1_2; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_1_3; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_1_4; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_1_5; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_1_6; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_1_7; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage1_regs_r_1_1_8; // @[FloatingPointDesigns.scala 2096:32]
  reg [31:0] stage2_regs_r_0_0_0; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_0_1; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_0_2; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_0_3; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_0_4; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_0_5; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_0_6; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_0_7; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_0_8; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_0_9; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_0_10; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_0_11; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_1_0; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_1_1; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_1_2; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_1_3; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_1_4; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_1_5; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_1_6; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_1_7; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_1_8; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_1_9; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_1_10; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_0_1_11; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_0_0; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_0_1; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_0_2; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_0_3; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_0_4; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_0_5; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_0_6; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_0_7; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_0_8; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_0_9; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_0_10; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_0_11; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_1_0; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_1_1; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_1_2; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_1_3; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_1_4; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_1_5; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_1_6; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_1_7; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_1_8; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_1_9; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_1_10; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage2_regs_r_1_1_11; // @[FloatingPointDesigns.scala 2097:32]
  reg [31:0] stage3_regs_r_0_1_0; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_0_1_1; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_0_1_2; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_0_1_3; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_0_1_4; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_0_1_5; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_0_1_6; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_0_1_7; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_0_1_8; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_1_1_0; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_1_1_1; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_1_1_2; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_1_1_3; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_1_1_4; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_1_1_5; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_1_1_6; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_1_1_7; // @[FloatingPointDesigns.scala 2098:32]
  reg [31:0] stage3_regs_r_1_1_8; // @[FloatingPointDesigns.scala 2098:32]
  wire [31:0] _GEN_133 = multiplier4_io_out_s; // @[FloatingPointDesigns.scala 2094:24 2119:28 2120:28]
  wire [31:0] _GEN_189 = FP_multiplier_10ccs_4_io_out_s; // @[FloatingPointDesigns.scala 2094:24 2128:28 2129:28]
  FP_multiplier_10ccs FP_multiplier_10ccs ( // @[FloatingPointDesigns.scala 2007:65]
    .clock(FP_multiplier_10ccs_clock),
    .reset(FP_multiplier_10ccs_reset),
    .io_in_a(FP_multiplier_10ccs_io_in_a),
    .io_in_b(FP_multiplier_10ccs_io_in_b),
    .io_out_s(FP_multiplier_10ccs_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_1 ( // @[FloatingPointDesigns.scala 2007:65]
    .clock(FP_multiplier_10ccs_1_clock),
    .reset(FP_multiplier_10ccs_1_reset),
    .io_in_a(FP_multiplier_10ccs_1_io_in_a),
    .io_in_b(FP_multiplier_10ccs_1_io_in_b),
    .io_out_s(FP_multiplier_10ccs_1_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_2 ( // @[FloatingPointDesigns.scala 2007:65]
    .clock(FP_multiplier_10ccs_2_clock),
    .reset(FP_multiplier_10ccs_2_reset),
    .io_in_a(FP_multiplier_10ccs_2_io_in_a),
    .io_in_b(FP_multiplier_10ccs_2_io_in_b),
    .io_out_s(FP_multiplier_10ccs_2_io_out_s)
  );
  FP_subtractor_13ccs FP_subtractor_13ccs ( // @[FloatingPointDesigns.scala 2008:50]
    .clock(FP_subtractor_13ccs_clock),
    .reset(FP_subtractor_13ccs_reset),
    .io_in_a(FP_subtractor_13ccs_io_in_a),
    .io_in_b(FP_subtractor_13ccs_io_in_b),
    .io_out_s(FP_subtractor_13ccs_io_out_s)
  );
  FP_multiplier_10ccs multiplier4 ( // @[FloatingPointDesigns.scala 2087:29]
    .clock(multiplier4_clock),
    .reset(multiplier4_reset),
    .io_in_a(multiplier4_io_in_a),
    .io_in_b(multiplier4_io_in_b),
    .io_out_s(multiplier4_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_3 ( // @[FloatingPointDesigns.scala 2099:69]
    .clock(FP_multiplier_10ccs_3_clock),
    .reset(FP_multiplier_10ccs_3_reset),
    .io_in_a(FP_multiplier_10ccs_3_io_in_a),
    .io_in_b(FP_multiplier_10ccs_3_io_in_b),
    .io_out_s(FP_multiplier_10ccs_3_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_4 ( // @[FloatingPointDesigns.scala 2099:69]
    .clock(FP_multiplier_10ccs_4_clock),
    .reset(FP_multiplier_10ccs_4_reset),
    .io_in_a(FP_multiplier_10ccs_4_io_in_a),
    .io_in_b(FP_multiplier_10ccs_4_io_in_b),
    .io_out_s(FP_multiplier_10ccs_4_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_5 ( // @[FloatingPointDesigns.scala 2099:69]
    .clock(FP_multiplier_10ccs_5_clock),
    .reset(FP_multiplier_10ccs_5_reset),
    .io_in_a(FP_multiplier_10ccs_5_io_in_a),
    .io_in_b(FP_multiplier_10ccs_5_io_in_b),
    .io_out_s(FP_multiplier_10ccs_5_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_6 ( // @[FloatingPointDesigns.scala 2099:69]
    .clock(FP_multiplier_10ccs_6_clock),
    .reset(FP_multiplier_10ccs_6_reset),
    .io_in_a(FP_multiplier_10ccs_6_io_in_a),
    .io_in_b(FP_multiplier_10ccs_6_io_in_b),
    .io_out_s(FP_multiplier_10ccs_6_io_out_s)
  );
  FP_subtractor_13ccs FP_subtractor_13ccs_1 ( // @[FloatingPointDesigns.scala 2100:54]
    .clock(FP_subtractor_13ccs_1_clock),
    .reset(FP_subtractor_13ccs_1_reset),
    .io_in_a(FP_subtractor_13ccs_1_io_in_a),
    .io_in_b(FP_subtractor_13ccs_1_io_in_b),
    .io_out_s(FP_subtractor_13ccs_1_io_out_s)
  );
  FP_subtractor_13ccs FP_subtractor_13ccs_2 ( // @[FloatingPointDesigns.scala 2100:54]
    .clock(FP_subtractor_13ccs_2_clock),
    .reset(FP_subtractor_13ccs_2_reset),
    .io_in_a(FP_subtractor_13ccs_2_io_in_a),
    .io_in_b(FP_subtractor_13ccs_2_io_in_b),
    .io_out_s(FP_subtractor_13ccs_2_io_out_s)
  );
  assign io_out_s = {stage3_regs_r_1_1_8[31],FP_multiplier_10ccs_6_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 2156:58]
  assign FP_multiplier_10ccs_clock = clock;
  assign FP_multiplier_10ccs_reset = reset;
  assign FP_multiplier_10ccs_io_in_a = {1'h0,result[30:0]}; // @[FloatingPointDesigns.scala 2036:48]
  assign FP_multiplier_10ccs_io_in_b = {1'h0,result[30:0]}; // @[FloatingPointDesigns.scala 2037:48]
  assign FP_multiplier_10ccs_1_clock = clock;
  assign FP_multiplier_10ccs_1_reset = reset;
  assign FP_multiplier_10ccs_1_io_in_a = FP_multiplier_10ccs_io_out_s; // @[FloatingPointDesigns.scala 2049:34]
  assign FP_multiplier_10ccs_1_io_in_b = {1'h0,stage1_regs_0_1_8[30:0]}; // @[FloatingPointDesigns.scala 2050:46]
  assign FP_multiplier_10ccs_2_clock = clock;
  assign FP_multiplier_10ccs_2_reset = reset;
  assign FP_multiplier_10ccs_2_io_in_a = {1'h0,stage3_regs_0_0_11[30:0]}; // @[FloatingPointDesigns.scala 2067:46]
  assign FP_multiplier_10ccs_2_io_in_b = FP_subtractor_13ccs_io_out_s; // @[FloatingPointDesigns.scala 2068:34]
  assign FP_subtractor_13ccs_clock = clock;
  assign FP_subtractor_13ccs_reset = reset;
  assign FP_subtractor_13ccs_io_in_a = 32'h3fc00000; // @[FloatingPointDesigns.scala 1985:26 1986:16]
  assign FP_subtractor_13ccs_io_in_b = FP_multiplier_10ccs_1_io_out_s; // @[FloatingPointDesigns.scala 2059:31]
  assign multiplier4_clock = clock;
  assign multiplier4_reset = reset;
  assign multiplier4_io_in_a = {1'h0,FP_multiplier_10ccs_2_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 2089:37]
  assign multiplier4_io_in_b = {1'h0,FP_multiplier_10ccs_2_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 2090:37]
  assign FP_multiplier_10ccs_3_clock = clock;
  assign FP_multiplier_10ccs_3_reset = reset;
  assign FP_multiplier_10ccs_3_io_in_a = {1'h0,multiplier4_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 2125:50]
  assign FP_multiplier_10ccs_3_io_in_b = {1'h0,transition_regs_8[30:0]}; // @[FloatingPointDesigns.scala 2126:50]
  assign FP_multiplier_10ccs_4_clock = clock;
  assign FP_multiplier_10ccs_4_reset = reset;
  assign FP_multiplier_10ccs_4_io_in_a = {1'h0,stage2_regs_r_0_0_11[30:0]}; // @[FloatingPointDesigns.scala 2147:48]
  assign FP_multiplier_10ccs_4_io_in_b = FP_subtractor_13ccs_1_io_out_s; // @[FloatingPointDesigns.scala 2148:36]
  assign FP_multiplier_10ccs_5_clock = clock;
  assign FP_multiplier_10ccs_5_reset = reset;
  assign FP_multiplier_10ccs_5_io_in_a = {1'h0,FP_multiplier_10ccs_4_io_out_s[30:0]}; // @[FloatingPointDesigns.scala 2134:50]
  assign FP_multiplier_10ccs_5_io_in_b = {1'h0,stage3_regs_r_0_1_8[30:0]}; // @[FloatingPointDesigns.scala 2135:50]
  assign FP_multiplier_10ccs_6_clock = clock;
  assign FP_multiplier_10ccs_6_reset = reset;
  assign FP_multiplier_10ccs_6_io_in_a = {1'h0,stage2_regs_r_1_0_11[30:0]}; // @[FloatingPointDesigns.scala 2147:48]
  assign FP_multiplier_10ccs_6_io_in_b = FP_subtractor_13ccs_2_io_out_s; // @[FloatingPointDesigns.scala 2148:36]
  assign FP_subtractor_13ccs_1_clock = clock;
  assign FP_subtractor_13ccs_1_reset = reset;
  assign FP_subtractor_13ccs_1_io_in_a = 32'h40000000; // @[FloatingPointDesigns.scala 1987:19 1988:9]
  assign FP_subtractor_13ccs_1_io_in_b = FP_multiplier_10ccs_3_io_out_s; // @[FloatingPointDesigns.scala 2139:33]
  assign FP_subtractor_13ccs_2_clock = clock;
  assign FP_subtractor_13ccs_2_reset = reset;
  assign FP_subtractor_13ccs_2_io_in_a = 32'h40000000; // @[FloatingPointDesigns.scala 1987:19 1988:9]
  assign FP_subtractor_13ccs_2_io_in_b = FP_multiplier_10ccs_5_io_out_s; // @[FloatingPointDesigns.scala 2139:33]
  always @(posedge clock) begin
    if (reset) begin // @[FloatingPointDesigns.scala 2001:22]
      x_n_0 <= 32'h0; // @[FloatingPointDesigns.scala 2001:22]
    end else begin
      x_n_0 <= result;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2001:22]
      x_n_1 <= 32'h0; // @[FloatingPointDesigns.scala 2001:22]
    end else begin
      x_n_1 <= stage1_regs_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2001:22]
      x_n_2 <= 32'h0; // @[FloatingPointDesigns.scala 2001:22]
    end else begin
      x_n_2 <= stage2_regs_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2002:22]
      a_2_0 <= 32'h0; // @[FloatingPointDesigns.scala 2002:22]
    end else begin
      a_2_0 <= _a_2_0_T_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2002:22]
      a_2_1 <= 32'h0; // @[FloatingPointDesigns.scala 2002:22]
    end else begin
      a_2_1 <= stage1_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2002:22]
      a_2_2 <= 32'h0; // @[FloatingPointDesigns.scala 2002:22]
    end else begin
      a_2_2 <= stage2_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2002:22]
      a_2_3 <= 32'h0; // @[FloatingPointDesigns.scala 2002:22]
    end else begin
      a_2_3 <= stage3_regs_0_1_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_0_0 <= x_n_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_0_1 <= stage1_regs_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_0_2 <= stage1_regs_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_0_3 <= stage1_regs_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_0_4 <= stage1_regs_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_0_5 <= stage1_regs_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_0_6 <= stage1_regs_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_0_7 <= stage1_regs_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_0_8 <= stage1_regs_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_1_0 <= a_2_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_1_1 <= stage1_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_1_2 <= stage1_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_1_3 <= stage1_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_1_4 <= stage1_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_1_5 <= stage1_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_1_6 <= stage1_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_1_7 <= stage1_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2003:30]
      stage1_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2003:30]
    end else begin
      stage1_regs_0_1_8 <= stage1_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_0_0 <= x_n_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_0_1 <= stage2_regs_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_0_2 <= stage2_regs_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_0_3 <= stage2_regs_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_0_4 <= stage2_regs_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_0_5 <= stage2_regs_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_0_6 <= stage2_regs_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_0_7 <= stage2_regs_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_0_8 <= stage2_regs_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_1_0 <= a_2_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_1_1 <= stage2_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_1_2 <= stage2_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_1_3 <= stage2_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_1_4 <= stage2_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_1_5 <= stage2_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_1_6 <= stage2_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_1_7 <= stage2_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2004:30]
      stage2_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2004:30]
    end else begin
      stage2_regs_0_1_8 <= stage2_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_0_0 <= x_n_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_0_1 <= stage3_regs_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_0_2 <= stage3_regs_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_0_3 <= stage3_regs_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_0_4 <= stage3_regs_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_0_5 <= stage3_regs_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_0_6 <= stage3_regs_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_0_7 <= stage3_regs_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_0_8 <= stage3_regs_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_0_9 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_0_9 <= stage3_regs_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_0_10 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_0_10 <= stage3_regs_0_0_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_0_11 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_0_11 <= stage3_regs_0_0_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_1_0 <= a_2_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_1_1 <= stage3_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_1_2 <= stage3_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_1_3 <= stage3_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_1_4 <= stage3_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_1_5 <= stage3_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_1_6 <= stage3_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_1_7 <= stage3_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_1_8 <= stage3_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_1_9 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_1_9 <= stage3_regs_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_1_10 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_1_10 <= stage3_regs_0_1_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2005:30]
      stage3_regs_0_1_11 <= 32'h0; // @[FloatingPointDesigns.scala 2005:30]
    end else begin
      stage3_regs_0_1_11 <= stage3_regs_0_1_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:30]
      stage4_regs_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2006:30]
    end else begin
      stage4_regs_0_1_0 <= a_2_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:30]
      stage4_regs_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2006:30]
    end else begin
      stage4_regs_0_1_1 <= stage4_regs_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:30]
      stage4_regs_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2006:30]
    end else begin
      stage4_regs_0_1_2 <= stage4_regs_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:30]
      stage4_regs_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2006:30]
    end else begin
      stage4_regs_0_1_3 <= stage4_regs_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:30]
      stage4_regs_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2006:30]
    end else begin
      stage4_regs_0_1_4 <= stage4_regs_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:30]
      stage4_regs_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2006:30]
    end else begin
      stage4_regs_0_1_5 <= stage4_regs_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:30]
      stage4_regs_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2006:30]
    end else begin
      stage4_regs_0_1_6 <= stage4_regs_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:30]
      stage4_regs_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2006:30]
    end else begin
      stage4_regs_0_1_7 <= stage4_regs_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2006:30]
      stage4_regs_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2006:30]
    end else begin
      stage4_regs_0_1_8 <= stage4_regs_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2077:31]
      a_2_isr_to_r <= 32'h0; // @[FloatingPointDesigns.scala 2077:31]
    end else begin
      a_2_isr_to_r <= _a_2_isr_to_r_T_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2078:34]
      transition_regs_0 <= 32'h0; // @[FloatingPointDesigns.scala 2078:34]
    end else begin
      transition_regs_0 <= a_2_isr_to_r;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2078:34]
      transition_regs_1 <= 32'h0; // @[FloatingPointDesigns.scala 2078:34]
    end else begin
      transition_regs_1 <= transition_regs_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2078:34]
      transition_regs_2 <= 32'h0; // @[FloatingPointDesigns.scala 2078:34]
    end else begin
      transition_regs_2 <= transition_regs_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2078:34]
      transition_regs_3 <= 32'h0; // @[FloatingPointDesigns.scala 2078:34]
    end else begin
      transition_regs_3 <= transition_regs_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2078:34]
      transition_regs_4 <= 32'h0; // @[FloatingPointDesigns.scala 2078:34]
    end else begin
      transition_regs_4 <= transition_regs_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2078:34]
      transition_regs_5 <= 32'h0; // @[FloatingPointDesigns.scala 2078:34]
    end else begin
      transition_regs_5 <= transition_regs_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2078:34]
      transition_regs_6 <= 32'h0; // @[FloatingPointDesigns.scala 2078:34]
    end else begin
      transition_regs_6 <= transition_regs_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2078:34]
      transition_regs_7 <= 32'h0; // @[FloatingPointDesigns.scala 2078:34]
    end else begin
      transition_regs_7 <= transition_regs_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2078:34]
      transition_regs_8 <= 32'h0; // @[FloatingPointDesigns.scala 2078:34]
    end else begin
      transition_regs_8 <= transition_regs_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2094:24]
      x_n_r_0 <= 32'h0; // @[FloatingPointDesigns.scala 2094:24]
    end else begin
      x_n_r_0 <= _GEN_133;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2094:24]
      x_n_r_1 <= 32'h0; // @[FloatingPointDesigns.scala 2094:24]
    end else begin
      x_n_r_1 <= stage1_regs_r_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2094:24]
      x_n_r_3 <= 32'h0; // @[FloatingPointDesigns.scala 2094:24]
    end else begin
      x_n_r_3 <= _GEN_189;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2094:24]
      x_n_r_4 <= 32'h0; // @[FloatingPointDesigns.scala 2094:24]
    end else begin
      x_n_r_4 <= stage1_regs_r_1_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2095:24]
      a_2_r_0 <= 32'h0; // @[FloatingPointDesigns.scala 2095:24]
    end else begin
      a_2_r_0 <= transition_regs_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2095:24]
      a_2_r_1 <= 32'h0; // @[FloatingPointDesigns.scala 2095:24]
    end else begin
      a_2_r_1 <= stage1_regs_r_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2095:24]
      a_2_r_2 <= 32'h0; // @[FloatingPointDesigns.scala 2095:24]
    end else begin
      a_2_r_2 <= stage2_regs_r_0_1_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2095:24]
      a_2_r_3 <= 32'h0; // @[FloatingPointDesigns.scala 2095:24]
    end else begin
      a_2_r_3 <= stage3_regs_r_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2095:24]
      a_2_r_4 <= 32'h0; // @[FloatingPointDesigns.scala 2095:24]
    end else begin
      a_2_r_4 <= stage1_regs_r_1_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2095:24]
      a_2_r_5 <= 32'h0; // @[FloatingPointDesigns.scala 2095:24]
    end else begin
      a_2_r_5 <= stage2_regs_r_1_1_11;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_0_0 <= x_n_r_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_0_1 <= stage1_regs_r_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_0_2 <= stage1_regs_r_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_0_3 <= stage1_regs_r_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_0_4 <= stage1_regs_r_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_0_5 <= stage1_regs_r_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_0_6 <= stage1_regs_r_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_0_7 <= stage1_regs_r_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_0_8 <= stage1_regs_r_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_1_0 <= a_2_r_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_1_1 <= stage1_regs_r_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_1_2 <= stage1_regs_r_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_1_3 <= stage1_regs_r_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_1_4 <= stage1_regs_r_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_1_5 <= stage1_regs_r_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_1_6 <= stage1_regs_r_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_1_7 <= stage1_regs_r_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_0_1_8 <= stage1_regs_r_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_0_0 <= x_n_r_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_0_1 <= stage1_regs_r_1_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_0_2 <= stage1_regs_r_1_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_0_3 <= stage1_regs_r_1_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_0_4 <= stage1_regs_r_1_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_0_5 <= stage1_regs_r_1_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_0_6 <= stage1_regs_r_1_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_0_7 <= stage1_regs_r_1_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_0_8 <= stage1_regs_r_1_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_1_0 <= a_2_r_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_1_1 <= stage1_regs_r_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_1_2 <= stage1_regs_r_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_1_3 <= stage1_regs_r_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_1_4 <= stage1_regs_r_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_1_5 <= stage1_regs_r_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_1_6 <= stage1_regs_r_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_1_7 <= stage1_regs_r_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2096:32]
      stage1_regs_r_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2096:32]
    end else begin
      stage1_regs_r_1_1_8 <= stage1_regs_r_1_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_0_0 <= x_n_r_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_0_1 <= stage2_regs_r_0_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_0_2 <= stage2_regs_r_0_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_0_3 <= stage2_regs_r_0_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_0_4 <= stage2_regs_r_0_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_0_5 <= stage2_regs_r_0_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_0_6 <= stage2_regs_r_0_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_0_7 <= stage2_regs_r_0_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_0_8 <= stage2_regs_r_0_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_0_9 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_0_9 <= stage2_regs_r_0_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_0_10 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_0_10 <= stage2_regs_r_0_0_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_0_11 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_0_11 <= stage2_regs_r_0_0_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_1_0 <= a_2_r_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_1_1 <= stage2_regs_r_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_1_2 <= stage2_regs_r_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_1_3 <= stage2_regs_r_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_1_4 <= stage2_regs_r_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_1_5 <= stage2_regs_r_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_1_6 <= stage2_regs_r_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_1_7 <= stage2_regs_r_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_1_8 <= stage2_regs_r_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_1_9 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_1_9 <= stage2_regs_r_0_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_1_10 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_1_10 <= stage2_regs_r_0_1_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_0_1_11 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_0_1_11 <= stage2_regs_r_0_1_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_0_0 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_0_0 <= x_n_r_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_0_1 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_0_1 <= stage2_regs_r_1_0_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_0_2 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_0_2 <= stage2_regs_r_1_0_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_0_3 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_0_3 <= stage2_regs_r_1_0_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_0_4 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_0_4 <= stage2_regs_r_1_0_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_0_5 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_0_5 <= stage2_regs_r_1_0_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_0_6 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_0_6 <= stage2_regs_r_1_0_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_0_7 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_0_7 <= stage2_regs_r_1_0_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_0_8 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_0_8 <= stage2_regs_r_1_0_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_0_9 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_0_9 <= stage2_regs_r_1_0_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_0_10 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_0_10 <= stage2_regs_r_1_0_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_0_11 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_0_11 <= stage2_regs_r_1_0_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_1_0 <= a_2_r_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_1_1 <= stage2_regs_r_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_1_2 <= stage2_regs_r_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_1_3 <= stage2_regs_r_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_1_4 <= stage2_regs_r_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_1_5 <= stage2_regs_r_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_1_6 <= stage2_regs_r_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_1_7 <= stage2_regs_r_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_1_8 <= stage2_regs_r_1_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_1_9 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_1_9 <= stage2_regs_r_1_1_8;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_1_10 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_1_10 <= stage2_regs_r_1_1_9;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2097:32]
      stage2_regs_r_1_1_11 <= 32'h0; // @[FloatingPointDesigns.scala 2097:32]
    end else begin
      stage2_regs_r_1_1_11 <= stage2_regs_r_1_1_10;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_0_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_0_1_0 <= a_2_r_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_0_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_0_1_1 <= stage3_regs_r_0_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_0_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_0_1_2 <= stage3_regs_r_0_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_0_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_0_1_3 <= stage3_regs_r_0_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_0_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_0_1_4 <= stage3_regs_r_0_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_0_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_0_1_5 <= stage3_regs_r_0_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_0_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_0_1_6 <= stage3_regs_r_0_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_0_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_0_1_7 <= stage3_regs_r_0_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_0_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_0_1_8 <= stage3_regs_r_0_1_7;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_1_1_0 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_1_1_0 <= a_2_r_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_1_1_1 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_1_1_1 <= stage3_regs_r_1_1_0;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_1_1_2 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_1_1_2 <= stage3_regs_r_1_1_1;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_1_1_3 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_1_1_3 <= stage3_regs_r_1_1_2;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_1_1_4 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_1_1_4 <= stage3_regs_r_1_1_3;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_1_1_5 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_1_1_5 <= stage3_regs_r_1_1_4;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_1_1_6 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_1_1_6 <= stage3_regs_r_1_1_5;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_1_1_7 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_1_1_7 <= stage3_regs_r_1_1_6;
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2098:32]
      stage3_regs_r_1_1_8 <= 32'h0; // @[FloatingPointDesigns.scala 2098:32]
    end else begin
      stage3_regs_r_1_1_8 <= stage3_regs_r_1_1_7;
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
  x_n_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  x_n_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  x_n_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  a_2_0 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  a_2_1 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  a_2_2 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  a_2_3 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  stage1_regs_0_0_0 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  stage1_regs_0_0_1 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  stage1_regs_0_0_2 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  stage1_regs_0_0_3 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  stage1_regs_0_0_4 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  stage1_regs_0_0_5 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  stage1_regs_0_0_6 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  stage1_regs_0_0_7 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  stage1_regs_0_0_8 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  stage1_regs_0_1_0 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  stage1_regs_0_1_1 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  stage1_regs_0_1_2 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  stage1_regs_0_1_3 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  stage1_regs_0_1_4 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  stage1_regs_0_1_5 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  stage1_regs_0_1_6 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  stage1_regs_0_1_7 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  stage1_regs_0_1_8 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  stage2_regs_0_0_0 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  stage2_regs_0_0_1 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  stage2_regs_0_0_2 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  stage2_regs_0_0_3 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  stage2_regs_0_0_4 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  stage2_regs_0_0_5 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  stage2_regs_0_0_6 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  stage2_regs_0_0_7 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  stage2_regs_0_0_8 = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  stage2_regs_0_1_0 = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  stage2_regs_0_1_1 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  stage2_regs_0_1_2 = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  stage2_regs_0_1_3 = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  stage2_regs_0_1_4 = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  stage2_regs_0_1_5 = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  stage2_regs_0_1_6 = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  stage2_regs_0_1_7 = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  stage2_regs_0_1_8 = _RAND_42[31:0];
  _RAND_43 = {1{`RANDOM}};
  stage3_regs_0_0_0 = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  stage3_regs_0_0_1 = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  stage3_regs_0_0_2 = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  stage3_regs_0_0_3 = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  stage3_regs_0_0_4 = _RAND_47[31:0];
  _RAND_48 = {1{`RANDOM}};
  stage3_regs_0_0_5 = _RAND_48[31:0];
  _RAND_49 = {1{`RANDOM}};
  stage3_regs_0_0_6 = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  stage3_regs_0_0_7 = _RAND_50[31:0];
  _RAND_51 = {1{`RANDOM}};
  stage3_regs_0_0_8 = _RAND_51[31:0];
  _RAND_52 = {1{`RANDOM}};
  stage3_regs_0_0_9 = _RAND_52[31:0];
  _RAND_53 = {1{`RANDOM}};
  stage3_regs_0_0_10 = _RAND_53[31:0];
  _RAND_54 = {1{`RANDOM}};
  stage3_regs_0_0_11 = _RAND_54[31:0];
  _RAND_55 = {1{`RANDOM}};
  stage3_regs_0_1_0 = _RAND_55[31:0];
  _RAND_56 = {1{`RANDOM}};
  stage3_regs_0_1_1 = _RAND_56[31:0];
  _RAND_57 = {1{`RANDOM}};
  stage3_regs_0_1_2 = _RAND_57[31:0];
  _RAND_58 = {1{`RANDOM}};
  stage3_regs_0_1_3 = _RAND_58[31:0];
  _RAND_59 = {1{`RANDOM}};
  stage3_regs_0_1_4 = _RAND_59[31:0];
  _RAND_60 = {1{`RANDOM}};
  stage3_regs_0_1_5 = _RAND_60[31:0];
  _RAND_61 = {1{`RANDOM}};
  stage3_regs_0_1_6 = _RAND_61[31:0];
  _RAND_62 = {1{`RANDOM}};
  stage3_regs_0_1_7 = _RAND_62[31:0];
  _RAND_63 = {1{`RANDOM}};
  stage3_regs_0_1_8 = _RAND_63[31:0];
  _RAND_64 = {1{`RANDOM}};
  stage3_regs_0_1_9 = _RAND_64[31:0];
  _RAND_65 = {1{`RANDOM}};
  stage3_regs_0_1_10 = _RAND_65[31:0];
  _RAND_66 = {1{`RANDOM}};
  stage3_regs_0_1_11 = _RAND_66[31:0];
  _RAND_67 = {1{`RANDOM}};
  stage4_regs_0_1_0 = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  stage4_regs_0_1_1 = _RAND_68[31:0];
  _RAND_69 = {1{`RANDOM}};
  stage4_regs_0_1_2 = _RAND_69[31:0];
  _RAND_70 = {1{`RANDOM}};
  stage4_regs_0_1_3 = _RAND_70[31:0];
  _RAND_71 = {1{`RANDOM}};
  stage4_regs_0_1_4 = _RAND_71[31:0];
  _RAND_72 = {1{`RANDOM}};
  stage4_regs_0_1_5 = _RAND_72[31:0];
  _RAND_73 = {1{`RANDOM}};
  stage4_regs_0_1_6 = _RAND_73[31:0];
  _RAND_74 = {1{`RANDOM}};
  stage4_regs_0_1_7 = _RAND_74[31:0];
  _RAND_75 = {1{`RANDOM}};
  stage4_regs_0_1_8 = _RAND_75[31:0];
  _RAND_76 = {1{`RANDOM}};
  a_2_isr_to_r = _RAND_76[31:0];
  _RAND_77 = {1{`RANDOM}};
  transition_regs_0 = _RAND_77[31:0];
  _RAND_78 = {1{`RANDOM}};
  transition_regs_1 = _RAND_78[31:0];
  _RAND_79 = {1{`RANDOM}};
  transition_regs_2 = _RAND_79[31:0];
  _RAND_80 = {1{`RANDOM}};
  transition_regs_3 = _RAND_80[31:0];
  _RAND_81 = {1{`RANDOM}};
  transition_regs_4 = _RAND_81[31:0];
  _RAND_82 = {1{`RANDOM}};
  transition_regs_5 = _RAND_82[31:0];
  _RAND_83 = {1{`RANDOM}};
  transition_regs_6 = _RAND_83[31:0];
  _RAND_84 = {1{`RANDOM}};
  transition_regs_7 = _RAND_84[31:0];
  _RAND_85 = {1{`RANDOM}};
  transition_regs_8 = _RAND_85[31:0];
  _RAND_86 = {1{`RANDOM}};
  x_n_r_0 = _RAND_86[31:0];
  _RAND_87 = {1{`RANDOM}};
  x_n_r_1 = _RAND_87[31:0];
  _RAND_88 = {1{`RANDOM}};
  x_n_r_3 = _RAND_88[31:0];
  _RAND_89 = {1{`RANDOM}};
  x_n_r_4 = _RAND_89[31:0];
  _RAND_90 = {1{`RANDOM}};
  a_2_r_0 = _RAND_90[31:0];
  _RAND_91 = {1{`RANDOM}};
  a_2_r_1 = _RAND_91[31:0];
  _RAND_92 = {1{`RANDOM}};
  a_2_r_2 = _RAND_92[31:0];
  _RAND_93 = {1{`RANDOM}};
  a_2_r_3 = _RAND_93[31:0];
  _RAND_94 = {1{`RANDOM}};
  a_2_r_4 = _RAND_94[31:0];
  _RAND_95 = {1{`RANDOM}};
  a_2_r_5 = _RAND_95[31:0];
  _RAND_96 = {1{`RANDOM}};
  stage1_regs_r_0_0_0 = _RAND_96[31:0];
  _RAND_97 = {1{`RANDOM}};
  stage1_regs_r_0_0_1 = _RAND_97[31:0];
  _RAND_98 = {1{`RANDOM}};
  stage1_regs_r_0_0_2 = _RAND_98[31:0];
  _RAND_99 = {1{`RANDOM}};
  stage1_regs_r_0_0_3 = _RAND_99[31:0];
  _RAND_100 = {1{`RANDOM}};
  stage1_regs_r_0_0_4 = _RAND_100[31:0];
  _RAND_101 = {1{`RANDOM}};
  stage1_regs_r_0_0_5 = _RAND_101[31:0];
  _RAND_102 = {1{`RANDOM}};
  stage1_regs_r_0_0_6 = _RAND_102[31:0];
  _RAND_103 = {1{`RANDOM}};
  stage1_regs_r_0_0_7 = _RAND_103[31:0];
  _RAND_104 = {1{`RANDOM}};
  stage1_regs_r_0_0_8 = _RAND_104[31:0];
  _RAND_105 = {1{`RANDOM}};
  stage1_regs_r_0_1_0 = _RAND_105[31:0];
  _RAND_106 = {1{`RANDOM}};
  stage1_regs_r_0_1_1 = _RAND_106[31:0];
  _RAND_107 = {1{`RANDOM}};
  stage1_regs_r_0_1_2 = _RAND_107[31:0];
  _RAND_108 = {1{`RANDOM}};
  stage1_regs_r_0_1_3 = _RAND_108[31:0];
  _RAND_109 = {1{`RANDOM}};
  stage1_regs_r_0_1_4 = _RAND_109[31:0];
  _RAND_110 = {1{`RANDOM}};
  stage1_regs_r_0_1_5 = _RAND_110[31:0];
  _RAND_111 = {1{`RANDOM}};
  stage1_regs_r_0_1_6 = _RAND_111[31:0];
  _RAND_112 = {1{`RANDOM}};
  stage1_regs_r_0_1_7 = _RAND_112[31:0];
  _RAND_113 = {1{`RANDOM}};
  stage1_regs_r_0_1_8 = _RAND_113[31:0];
  _RAND_114 = {1{`RANDOM}};
  stage1_regs_r_1_0_0 = _RAND_114[31:0];
  _RAND_115 = {1{`RANDOM}};
  stage1_regs_r_1_0_1 = _RAND_115[31:0];
  _RAND_116 = {1{`RANDOM}};
  stage1_regs_r_1_0_2 = _RAND_116[31:0];
  _RAND_117 = {1{`RANDOM}};
  stage1_regs_r_1_0_3 = _RAND_117[31:0];
  _RAND_118 = {1{`RANDOM}};
  stage1_regs_r_1_0_4 = _RAND_118[31:0];
  _RAND_119 = {1{`RANDOM}};
  stage1_regs_r_1_0_5 = _RAND_119[31:0];
  _RAND_120 = {1{`RANDOM}};
  stage1_regs_r_1_0_6 = _RAND_120[31:0];
  _RAND_121 = {1{`RANDOM}};
  stage1_regs_r_1_0_7 = _RAND_121[31:0];
  _RAND_122 = {1{`RANDOM}};
  stage1_regs_r_1_0_8 = _RAND_122[31:0];
  _RAND_123 = {1{`RANDOM}};
  stage1_regs_r_1_1_0 = _RAND_123[31:0];
  _RAND_124 = {1{`RANDOM}};
  stage1_regs_r_1_1_1 = _RAND_124[31:0];
  _RAND_125 = {1{`RANDOM}};
  stage1_regs_r_1_1_2 = _RAND_125[31:0];
  _RAND_126 = {1{`RANDOM}};
  stage1_regs_r_1_1_3 = _RAND_126[31:0];
  _RAND_127 = {1{`RANDOM}};
  stage1_regs_r_1_1_4 = _RAND_127[31:0];
  _RAND_128 = {1{`RANDOM}};
  stage1_regs_r_1_1_5 = _RAND_128[31:0];
  _RAND_129 = {1{`RANDOM}};
  stage1_regs_r_1_1_6 = _RAND_129[31:0];
  _RAND_130 = {1{`RANDOM}};
  stage1_regs_r_1_1_7 = _RAND_130[31:0];
  _RAND_131 = {1{`RANDOM}};
  stage1_regs_r_1_1_8 = _RAND_131[31:0];
  _RAND_132 = {1{`RANDOM}};
  stage2_regs_r_0_0_0 = _RAND_132[31:0];
  _RAND_133 = {1{`RANDOM}};
  stage2_regs_r_0_0_1 = _RAND_133[31:0];
  _RAND_134 = {1{`RANDOM}};
  stage2_regs_r_0_0_2 = _RAND_134[31:0];
  _RAND_135 = {1{`RANDOM}};
  stage2_regs_r_0_0_3 = _RAND_135[31:0];
  _RAND_136 = {1{`RANDOM}};
  stage2_regs_r_0_0_4 = _RAND_136[31:0];
  _RAND_137 = {1{`RANDOM}};
  stage2_regs_r_0_0_5 = _RAND_137[31:0];
  _RAND_138 = {1{`RANDOM}};
  stage2_regs_r_0_0_6 = _RAND_138[31:0];
  _RAND_139 = {1{`RANDOM}};
  stage2_regs_r_0_0_7 = _RAND_139[31:0];
  _RAND_140 = {1{`RANDOM}};
  stage2_regs_r_0_0_8 = _RAND_140[31:0];
  _RAND_141 = {1{`RANDOM}};
  stage2_regs_r_0_0_9 = _RAND_141[31:0];
  _RAND_142 = {1{`RANDOM}};
  stage2_regs_r_0_0_10 = _RAND_142[31:0];
  _RAND_143 = {1{`RANDOM}};
  stage2_regs_r_0_0_11 = _RAND_143[31:0];
  _RAND_144 = {1{`RANDOM}};
  stage2_regs_r_0_1_0 = _RAND_144[31:0];
  _RAND_145 = {1{`RANDOM}};
  stage2_regs_r_0_1_1 = _RAND_145[31:0];
  _RAND_146 = {1{`RANDOM}};
  stage2_regs_r_0_1_2 = _RAND_146[31:0];
  _RAND_147 = {1{`RANDOM}};
  stage2_regs_r_0_1_3 = _RAND_147[31:0];
  _RAND_148 = {1{`RANDOM}};
  stage2_regs_r_0_1_4 = _RAND_148[31:0];
  _RAND_149 = {1{`RANDOM}};
  stage2_regs_r_0_1_5 = _RAND_149[31:0];
  _RAND_150 = {1{`RANDOM}};
  stage2_regs_r_0_1_6 = _RAND_150[31:0];
  _RAND_151 = {1{`RANDOM}};
  stage2_regs_r_0_1_7 = _RAND_151[31:0];
  _RAND_152 = {1{`RANDOM}};
  stage2_regs_r_0_1_8 = _RAND_152[31:0];
  _RAND_153 = {1{`RANDOM}};
  stage2_regs_r_0_1_9 = _RAND_153[31:0];
  _RAND_154 = {1{`RANDOM}};
  stage2_regs_r_0_1_10 = _RAND_154[31:0];
  _RAND_155 = {1{`RANDOM}};
  stage2_regs_r_0_1_11 = _RAND_155[31:0];
  _RAND_156 = {1{`RANDOM}};
  stage2_regs_r_1_0_0 = _RAND_156[31:0];
  _RAND_157 = {1{`RANDOM}};
  stage2_regs_r_1_0_1 = _RAND_157[31:0];
  _RAND_158 = {1{`RANDOM}};
  stage2_regs_r_1_0_2 = _RAND_158[31:0];
  _RAND_159 = {1{`RANDOM}};
  stage2_regs_r_1_0_3 = _RAND_159[31:0];
  _RAND_160 = {1{`RANDOM}};
  stage2_regs_r_1_0_4 = _RAND_160[31:0];
  _RAND_161 = {1{`RANDOM}};
  stage2_regs_r_1_0_5 = _RAND_161[31:0];
  _RAND_162 = {1{`RANDOM}};
  stage2_regs_r_1_0_6 = _RAND_162[31:0];
  _RAND_163 = {1{`RANDOM}};
  stage2_regs_r_1_0_7 = _RAND_163[31:0];
  _RAND_164 = {1{`RANDOM}};
  stage2_regs_r_1_0_8 = _RAND_164[31:0];
  _RAND_165 = {1{`RANDOM}};
  stage2_regs_r_1_0_9 = _RAND_165[31:0];
  _RAND_166 = {1{`RANDOM}};
  stage2_regs_r_1_0_10 = _RAND_166[31:0];
  _RAND_167 = {1{`RANDOM}};
  stage2_regs_r_1_0_11 = _RAND_167[31:0];
  _RAND_168 = {1{`RANDOM}};
  stage2_regs_r_1_1_0 = _RAND_168[31:0];
  _RAND_169 = {1{`RANDOM}};
  stage2_regs_r_1_1_1 = _RAND_169[31:0];
  _RAND_170 = {1{`RANDOM}};
  stage2_regs_r_1_1_2 = _RAND_170[31:0];
  _RAND_171 = {1{`RANDOM}};
  stage2_regs_r_1_1_3 = _RAND_171[31:0];
  _RAND_172 = {1{`RANDOM}};
  stage2_regs_r_1_1_4 = _RAND_172[31:0];
  _RAND_173 = {1{`RANDOM}};
  stage2_regs_r_1_1_5 = _RAND_173[31:0];
  _RAND_174 = {1{`RANDOM}};
  stage2_regs_r_1_1_6 = _RAND_174[31:0];
  _RAND_175 = {1{`RANDOM}};
  stage2_regs_r_1_1_7 = _RAND_175[31:0];
  _RAND_176 = {1{`RANDOM}};
  stage2_regs_r_1_1_8 = _RAND_176[31:0];
  _RAND_177 = {1{`RANDOM}};
  stage2_regs_r_1_1_9 = _RAND_177[31:0];
  _RAND_178 = {1{`RANDOM}};
  stage2_regs_r_1_1_10 = _RAND_178[31:0];
  _RAND_179 = {1{`RANDOM}};
  stage2_regs_r_1_1_11 = _RAND_179[31:0];
  _RAND_180 = {1{`RANDOM}};
  stage3_regs_r_0_1_0 = _RAND_180[31:0];
  _RAND_181 = {1{`RANDOM}};
  stage3_regs_r_0_1_1 = _RAND_181[31:0];
  _RAND_182 = {1{`RANDOM}};
  stage3_regs_r_0_1_2 = _RAND_182[31:0];
  _RAND_183 = {1{`RANDOM}};
  stage3_regs_r_0_1_3 = _RAND_183[31:0];
  _RAND_184 = {1{`RANDOM}};
  stage3_regs_r_0_1_4 = _RAND_184[31:0];
  _RAND_185 = {1{`RANDOM}};
  stage3_regs_r_0_1_5 = _RAND_185[31:0];
  _RAND_186 = {1{`RANDOM}};
  stage3_regs_r_0_1_6 = _RAND_186[31:0];
  _RAND_187 = {1{`RANDOM}};
  stage3_regs_r_0_1_7 = _RAND_187[31:0];
  _RAND_188 = {1{`RANDOM}};
  stage3_regs_r_0_1_8 = _RAND_188[31:0];
  _RAND_189 = {1{`RANDOM}};
  stage3_regs_r_1_1_0 = _RAND_189[31:0];
  _RAND_190 = {1{`RANDOM}};
  stage3_regs_r_1_1_1 = _RAND_190[31:0];
  _RAND_191 = {1{`RANDOM}};
  stage3_regs_r_1_1_2 = _RAND_191[31:0];
  _RAND_192 = {1{`RANDOM}};
  stage3_regs_r_1_1_3 = _RAND_192[31:0];
  _RAND_193 = {1{`RANDOM}};
  stage3_regs_r_1_1_4 = _RAND_193[31:0];
  _RAND_194 = {1{`RANDOM}};
  stage3_regs_r_1_1_5 = _RAND_194[31:0];
  _RAND_195 = {1{`RANDOM}};
  stage3_regs_r_1_1_6 = _RAND_195[31:0];
  _RAND_196 = {1{`RANDOM}};
  stage3_regs_r_1_1_7 = _RAND_196[31:0];
  _RAND_197 = {1{`RANDOM}};
  stage3_regs_r_1_1_8 = _RAND_197[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module hqr7(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
  output [31:0] io_out_s
);
  wire  FP_multiplier_10ccs_clock; // @[FloatingPointDesigns.scala 2533:28]
  wire  FP_multiplier_10ccs_reset; // @[FloatingPointDesigns.scala 2533:28]
  wire [31:0] FP_multiplier_10ccs_io_in_a; // @[FloatingPointDesigns.scala 2533:28]
  wire [31:0] FP_multiplier_10ccs_io_in_b; // @[FloatingPointDesigns.scala 2533:28]
  wire [31:0] FP_multiplier_10ccs_io_out_s; // @[FloatingPointDesigns.scala 2533:28]
  wire  FP_reciprocal_newfpu_clock; // @[FloatingPointDesigns.scala 2534:28]
  wire  FP_reciprocal_newfpu_reset; // @[FloatingPointDesigns.scala 2534:28]
  wire [31:0] FP_reciprocal_newfpu_io_in_a; // @[FloatingPointDesigns.scala 2534:28]
  wire [31:0] FP_reciprocal_newfpu_io_out_s; // @[FloatingPointDesigns.scala 2534:28]
  FP_multiplier_10ccs FP_multiplier_10ccs ( // @[FloatingPointDesigns.scala 2533:28]
    .clock(FP_multiplier_10ccs_clock),
    .reset(FP_multiplier_10ccs_reset),
    .io_in_a(FP_multiplier_10ccs_io_in_a),
    .io_in_b(FP_multiplier_10ccs_io_in_b),
    .io_out_s(FP_multiplier_10ccs_io_out_s)
  );
  FP_reciprocal_newfpu FP_reciprocal_newfpu ( // @[FloatingPointDesigns.scala 2534:28]
    .clock(FP_reciprocal_newfpu_clock),
    .reset(FP_reciprocal_newfpu_reset),
    .io_in_a(FP_reciprocal_newfpu_io_in_a),
    .io_out_s(FP_reciprocal_newfpu_io_out_s)
  );
  assign io_out_s = FP_multiplier_10ccs_io_out_s; // @[FloatingPointDesigns.scala 2541:14]
  assign FP_multiplier_10ccs_clock = clock;
  assign FP_multiplier_10ccs_reset = reset;
  assign FP_multiplier_10ccs_io_in_a = 32'hc0000000; // @[FloatingPointDesigns.scala 2538:21]
  assign FP_multiplier_10ccs_io_in_b = FP_reciprocal_newfpu_io_out_s; // @[FloatingPointDesigns.scala 2539:21]
  assign FP_reciprocal_newfpu_clock = clock;
  assign FP_reciprocal_newfpu_reset = reset;
  assign FP_reciprocal_newfpu_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2537:21]
endmodule
module FPReg(
  input         clock,
  input         reset,
  input  [31:0] io_in,
  output [31:0] io_out
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
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_0; // @[FloatingPointDesigns.scala 2270:22]
  reg [31:0] reg_1; // @[FloatingPointDesigns.scala 2270:22]
  reg [31:0] reg_2; // @[FloatingPointDesigns.scala 2270:22]
  reg [31:0] reg_3; // @[FloatingPointDesigns.scala 2270:22]
  reg [31:0] reg_4; // @[FloatingPointDesigns.scala 2270:22]
  reg [31:0] reg_5; // @[FloatingPointDesigns.scala 2270:22]
  reg [31:0] reg_6; // @[FloatingPointDesigns.scala 2270:22]
  reg [31:0] reg_7; // @[FloatingPointDesigns.scala 2270:22]
  reg [31:0] reg_8; // @[FloatingPointDesigns.scala 2270:22]
  reg [31:0] reg_9; // @[FloatingPointDesigns.scala 2270:22]
  assign io_out = reg_9; // @[FloatingPointDesigns.scala 2276:12]
  always @(posedge clock) begin
    if (reset) begin // @[FloatingPointDesigns.scala 2270:22]
      reg_0 <= 32'h0; // @[FloatingPointDesigns.scala 2270:22]
    end else begin
      reg_0 <= io_in; // @[FloatingPointDesigns.scala 2272:14]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2270:22]
      reg_1 <= 32'h0; // @[FloatingPointDesigns.scala 2270:22]
    end else begin
      reg_1 <= reg_0; // @[FloatingPointDesigns.scala 2274:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2270:22]
      reg_2 <= 32'h0; // @[FloatingPointDesigns.scala 2270:22]
    end else begin
      reg_2 <= reg_1; // @[FloatingPointDesigns.scala 2274:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2270:22]
      reg_3 <= 32'h0; // @[FloatingPointDesigns.scala 2270:22]
    end else begin
      reg_3 <= reg_2; // @[FloatingPointDesigns.scala 2274:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2270:22]
      reg_4 <= 32'h0; // @[FloatingPointDesigns.scala 2270:22]
    end else begin
      reg_4 <= reg_3; // @[FloatingPointDesigns.scala 2274:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2270:22]
      reg_5 <= 32'h0; // @[FloatingPointDesigns.scala 2270:22]
    end else begin
      reg_5 <= reg_4; // @[FloatingPointDesigns.scala 2274:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2270:22]
      reg_6 <= 32'h0; // @[FloatingPointDesigns.scala 2270:22]
    end else begin
      reg_6 <= reg_5; // @[FloatingPointDesigns.scala 2274:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2270:22]
      reg_7 <= 32'h0; // @[FloatingPointDesigns.scala 2270:22]
    end else begin
      reg_7 <= reg_6; // @[FloatingPointDesigns.scala 2274:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2270:22]
      reg_8 <= 32'h0; // @[FloatingPointDesigns.scala 2270:22]
    end else begin
      reg_8 <= reg_7; // @[FloatingPointDesigns.scala 2274:16]
    end
    if (reset) begin // @[FloatingPointDesigns.scala 2270:22]
      reg_9 <= 32'h0; // @[FloatingPointDesigns.scala 2270:22]
    end else begin
      reg_9 <= reg_8; // @[FloatingPointDesigns.scala 2274:16]
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
  reg_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  reg_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  reg_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  reg_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  reg_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  reg_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  reg_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  reg_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  reg_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  reg_9 = _RAND_9[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module axpy_dp(
  input         clock,
  input         reset,
  input  [31:0] io_in_a,
  input  [31:0] io_in_b_0,
  input  [31:0] io_in_b_1,
  input  [31:0] io_in_b_2,
  input  [31:0] io_in_b_3,
  input  [31:0] io_in_b_4,
  input  [31:0] io_in_b_5,
  input  [31:0] io_in_b_6,
  input  [31:0] io_in_b_7,
  input  [31:0] io_in_b_8,
  input  [31:0] io_in_b_9,
  input  [31:0] io_in_b_10,
  input  [31:0] io_in_b_11,
  input  [31:0] io_in_b_12,
  input  [31:0] io_in_b_13,
  input  [31:0] io_in_b_14,
  input  [31:0] io_in_b_15,
  input  [31:0] io_in_c_0,
  input  [31:0] io_in_c_1,
  input  [31:0] io_in_c_2,
  input  [31:0] io_in_c_3,
  input  [31:0] io_in_c_4,
  input  [31:0] io_in_c_5,
  input  [31:0] io_in_c_6,
  input  [31:0] io_in_c_7,
  input  [31:0] io_in_c_8,
  input  [31:0] io_in_c_9,
  input  [31:0] io_in_c_10,
  input  [31:0] io_in_c_11,
  input  [31:0] io_in_c_12,
  input  [31:0] io_in_c_13,
  input  [31:0] io_in_c_14,
  input  [31:0] io_in_c_15,
  output [31:0] io_out_s_0,
  output [31:0] io_out_s_1,
  output [31:0] io_out_s_2,
  output [31:0] io_out_s_3,
  output [31:0] io_out_s_4,
  output [31:0] io_out_s_5,
  output [31:0] io_out_s_6,
  output [31:0] io_out_s_7,
  output [31:0] io_out_s_8,
  output [31:0] io_out_s_9,
  output [31:0] io_out_s_10,
  output [31:0] io_out_s_11,
  output [31:0] io_out_s_12,
  output [31:0] io_out_s_13,
  output [31:0] io_out_s_14,
  output [31:0] io_out_s_15
);
  wire  FP_multiplier_10ccs_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_1_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_1_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_1_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_1_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_1_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_2_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_2_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_2_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_2_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_2_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_3_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_3_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_3_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_3_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_3_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_4_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_4_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_4_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_4_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_4_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_5_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_5_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_5_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_5_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_5_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_6_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_6_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_6_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_6_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_6_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_7_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_7_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_7_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_7_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_7_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_8_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_8_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_8_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_8_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_8_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_9_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_9_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_9_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_9_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_9_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_10_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_10_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_10_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_10_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_10_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_11_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_11_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_11_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_11_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_11_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_12_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_12_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_12_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_12_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_12_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_13_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_13_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_13_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_13_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_13_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_14_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_14_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_14_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_14_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_14_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_15_clock; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_multiplier_10ccs_15_reset; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_15_io_in_a; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_15_io_in_b; // @[FloatingPointDesigns.scala 2485:28]
  wire [31:0] FP_multiplier_10ccs_15_io_out_s; // @[FloatingPointDesigns.scala 2485:28]
  wire  FP_adder_13ccs_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_1_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_1_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_1_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_1_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_1_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_2_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_2_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_2_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_2_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_2_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_3_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_3_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_3_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_3_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_3_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_4_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_4_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_4_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_4_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_4_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_5_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_5_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_5_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_5_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_5_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_6_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_6_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_6_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_6_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_6_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_7_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_7_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_7_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_7_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_7_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_8_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_8_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_8_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_8_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_8_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_9_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_9_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_9_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_9_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_9_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_10_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_10_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_10_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_10_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_10_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_11_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_11_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_11_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_11_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_11_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_12_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_12_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_12_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_12_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_12_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_13_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_13_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_13_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_13_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_13_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_14_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_14_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_14_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_14_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_14_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_15_clock; // @[FloatingPointDesigns.scala 2490:25]
  wire  FP_adder_13ccs_15_reset; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_15_io_in_a; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_15_io_in_b; // @[FloatingPointDesigns.scala 2490:25]
  wire [31:0] FP_adder_13ccs_15_io_out_s; // @[FloatingPointDesigns.scala 2490:25]
  wire  FPReg_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_1_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_1_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_1_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_1_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_2_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_2_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_2_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_2_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_3_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_3_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_3_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_3_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_4_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_4_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_4_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_4_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_5_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_5_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_5_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_5_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_6_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_6_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_6_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_6_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_7_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_7_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_7_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_7_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_8_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_8_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_8_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_8_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_9_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_9_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_9_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_9_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_10_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_10_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_10_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_10_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_11_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_11_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_11_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_11_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_12_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_12_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_12_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_12_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_13_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_13_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_13_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_13_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_14_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_14_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_14_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_14_io_out; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_15_clock; // @[FloatingPointDesigns.scala 2494:48]
  wire  FPReg_15_reset; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_15_io_in; // @[FloatingPointDesigns.scala 2494:48]
  wire [31:0] FPReg_15_io_out; // @[FloatingPointDesigns.scala 2494:48]
  FP_multiplier_10ccs FP_multiplier_10ccs ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_clock),
    .reset(FP_multiplier_10ccs_reset),
    .io_in_a(FP_multiplier_10ccs_io_in_a),
    .io_in_b(FP_multiplier_10ccs_io_in_b),
    .io_out_s(FP_multiplier_10ccs_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_1 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_1_clock),
    .reset(FP_multiplier_10ccs_1_reset),
    .io_in_a(FP_multiplier_10ccs_1_io_in_a),
    .io_in_b(FP_multiplier_10ccs_1_io_in_b),
    .io_out_s(FP_multiplier_10ccs_1_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_2 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_2_clock),
    .reset(FP_multiplier_10ccs_2_reset),
    .io_in_a(FP_multiplier_10ccs_2_io_in_a),
    .io_in_b(FP_multiplier_10ccs_2_io_in_b),
    .io_out_s(FP_multiplier_10ccs_2_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_3 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_3_clock),
    .reset(FP_multiplier_10ccs_3_reset),
    .io_in_a(FP_multiplier_10ccs_3_io_in_a),
    .io_in_b(FP_multiplier_10ccs_3_io_in_b),
    .io_out_s(FP_multiplier_10ccs_3_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_4 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_4_clock),
    .reset(FP_multiplier_10ccs_4_reset),
    .io_in_a(FP_multiplier_10ccs_4_io_in_a),
    .io_in_b(FP_multiplier_10ccs_4_io_in_b),
    .io_out_s(FP_multiplier_10ccs_4_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_5 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_5_clock),
    .reset(FP_multiplier_10ccs_5_reset),
    .io_in_a(FP_multiplier_10ccs_5_io_in_a),
    .io_in_b(FP_multiplier_10ccs_5_io_in_b),
    .io_out_s(FP_multiplier_10ccs_5_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_6 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_6_clock),
    .reset(FP_multiplier_10ccs_6_reset),
    .io_in_a(FP_multiplier_10ccs_6_io_in_a),
    .io_in_b(FP_multiplier_10ccs_6_io_in_b),
    .io_out_s(FP_multiplier_10ccs_6_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_7 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_7_clock),
    .reset(FP_multiplier_10ccs_7_reset),
    .io_in_a(FP_multiplier_10ccs_7_io_in_a),
    .io_in_b(FP_multiplier_10ccs_7_io_in_b),
    .io_out_s(FP_multiplier_10ccs_7_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_8 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_8_clock),
    .reset(FP_multiplier_10ccs_8_reset),
    .io_in_a(FP_multiplier_10ccs_8_io_in_a),
    .io_in_b(FP_multiplier_10ccs_8_io_in_b),
    .io_out_s(FP_multiplier_10ccs_8_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_9 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_9_clock),
    .reset(FP_multiplier_10ccs_9_reset),
    .io_in_a(FP_multiplier_10ccs_9_io_in_a),
    .io_in_b(FP_multiplier_10ccs_9_io_in_b),
    .io_out_s(FP_multiplier_10ccs_9_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_10 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_10_clock),
    .reset(FP_multiplier_10ccs_10_reset),
    .io_in_a(FP_multiplier_10ccs_10_io_in_a),
    .io_in_b(FP_multiplier_10ccs_10_io_in_b),
    .io_out_s(FP_multiplier_10ccs_10_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_11 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_11_clock),
    .reset(FP_multiplier_10ccs_11_reset),
    .io_in_a(FP_multiplier_10ccs_11_io_in_a),
    .io_in_b(FP_multiplier_10ccs_11_io_in_b),
    .io_out_s(FP_multiplier_10ccs_11_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_12 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_12_clock),
    .reset(FP_multiplier_10ccs_12_reset),
    .io_in_a(FP_multiplier_10ccs_12_io_in_a),
    .io_in_b(FP_multiplier_10ccs_12_io_in_b),
    .io_out_s(FP_multiplier_10ccs_12_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_13 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_13_clock),
    .reset(FP_multiplier_10ccs_13_reset),
    .io_in_a(FP_multiplier_10ccs_13_io_in_a),
    .io_in_b(FP_multiplier_10ccs_13_io_in_b),
    .io_out_s(FP_multiplier_10ccs_13_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_14 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_14_clock),
    .reset(FP_multiplier_10ccs_14_reset),
    .io_in_a(FP_multiplier_10ccs_14_io_in_a),
    .io_in_b(FP_multiplier_10ccs_14_io_in_b),
    .io_out_s(FP_multiplier_10ccs_14_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs_15 ( // @[FloatingPointDesigns.scala 2485:28]
    .clock(FP_multiplier_10ccs_15_clock),
    .reset(FP_multiplier_10ccs_15_reset),
    .io_in_a(FP_multiplier_10ccs_15_io_in_a),
    .io_in_b(FP_multiplier_10ccs_15_io_in_b),
    .io_out_s(FP_multiplier_10ccs_15_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_clock),
    .reset(FP_adder_13ccs_reset),
    .io_in_a(FP_adder_13ccs_io_in_a),
    .io_in_b(FP_adder_13ccs_io_in_b),
    .io_out_s(FP_adder_13ccs_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_1 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_1_clock),
    .reset(FP_adder_13ccs_1_reset),
    .io_in_a(FP_adder_13ccs_1_io_in_a),
    .io_in_b(FP_adder_13ccs_1_io_in_b),
    .io_out_s(FP_adder_13ccs_1_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_2 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_2_clock),
    .reset(FP_adder_13ccs_2_reset),
    .io_in_a(FP_adder_13ccs_2_io_in_a),
    .io_in_b(FP_adder_13ccs_2_io_in_b),
    .io_out_s(FP_adder_13ccs_2_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_3 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_3_clock),
    .reset(FP_adder_13ccs_3_reset),
    .io_in_a(FP_adder_13ccs_3_io_in_a),
    .io_in_b(FP_adder_13ccs_3_io_in_b),
    .io_out_s(FP_adder_13ccs_3_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_4 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_4_clock),
    .reset(FP_adder_13ccs_4_reset),
    .io_in_a(FP_adder_13ccs_4_io_in_a),
    .io_in_b(FP_adder_13ccs_4_io_in_b),
    .io_out_s(FP_adder_13ccs_4_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_5 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_5_clock),
    .reset(FP_adder_13ccs_5_reset),
    .io_in_a(FP_adder_13ccs_5_io_in_a),
    .io_in_b(FP_adder_13ccs_5_io_in_b),
    .io_out_s(FP_adder_13ccs_5_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_6 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_6_clock),
    .reset(FP_adder_13ccs_6_reset),
    .io_in_a(FP_adder_13ccs_6_io_in_a),
    .io_in_b(FP_adder_13ccs_6_io_in_b),
    .io_out_s(FP_adder_13ccs_6_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_7 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_7_clock),
    .reset(FP_adder_13ccs_7_reset),
    .io_in_a(FP_adder_13ccs_7_io_in_a),
    .io_in_b(FP_adder_13ccs_7_io_in_b),
    .io_out_s(FP_adder_13ccs_7_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_8 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_8_clock),
    .reset(FP_adder_13ccs_8_reset),
    .io_in_a(FP_adder_13ccs_8_io_in_a),
    .io_in_b(FP_adder_13ccs_8_io_in_b),
    .io_out_s(FP_adder_13ccs_8_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_9 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_9_clock),
    .reset(FP_adder_13ccs_9_reset),
    .io_in_a(FP_adder_13ccs_9_io_in_a),
    .io_in_b(FP_adder_13ccs_9_io_in_b),
    .io_out_s(FP_adder_13ccs_9_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_10 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_10_clock),
    .reset(FP_adder_13ccs_10_reset),
    .io_in_a(FP_adder_13ccs_10_io_in_a),
    .io_in_b(FP_adder_13ccs_10_io_in_b),
    .io_out_s(FP_adder_13ccs_10_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_11 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_11_clock),
    .reset(FP_adder_13ccs_11_reset),
    .io_in_a(FP_adder_13ccs_11_io_in_a),
    .io_in_b(FP_adder_13ccs_11_io_in_b),
    .io_out_s(FP_adder_13ccs_11_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_12 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_12_clock),
    .reset(FP_adder_13ccs_12_reset),
    .io_in_a(FP_adder_13ccs_12_io_in_a),
    .io_in_b(FP_adder_13ccs_12_io_in_b),
    .io_out_s(FP_adder_13ccs_12_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_13 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_13_clock),
    .reset(FP_adder_13ccs_13_reset),
    .io_in_a(FP_adder_13ccs_13_io_in_a),
    .io_in_b(FP_adder_13ccs_13_io_in_b),
    .io_out_s(FP_adder_13ccs_13_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_14 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_14_clock),
    .reset(FP_adder_13ccs_14_reset),
    .io_in_a(FP_adder_13ccs_14_io_in_a),
    .io_in_b(FP_adder_13ccs_14_io_in_b),
    .io_out_s(FP_adder_13ccs_14_io_out_s)
  );
  FP_adder_13ccs FP_adder_13ccs_15 ( // @[FloatingPointDesigns.scala 2490:25]
    .clock(FP_adder_13ccs_15_clock),
    .reset(FP_adder_13ccs_15_reset),
    .io_in_a(FP_adder_13ccs_15_io_in_a),
    .io_in_b(FP_adder_13ccs_15_io_in_b),
    .io_out_s(FP_adder_13ccs_15_io_out_s)
  );
  FPReg FPReg ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_clock),
    .reset(FPReg_reset),
    .io_in(FPReg_io_in),
    .io_out(FPReg_io_out)
  );
  FPReg FPReg_1 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_1_clock),
    .reset(FPReg_1_reset),
    .io_in(FPReg_1_io_in),
    .io_out(FPReg_1_io_out)
  );
  FPReg FPReg_2 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_2_clock),
    .reset(FPReg_2_reset),
    .io_in(FPReg_2_io_in),
    .io_out(FPReg_2_io_out)
  );
  FPReg FPReg_3 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_3_clock),
    .reset(FPReg_3_reset),
    .io_in(FPReg_3_io_in),
    .io_out(FPReg_3_io_out)
  );
  FPReg FPReg_4 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_4_clock),
    .reset(FPReg_4_reset),
    .io_in(FPReg_4_io_in),
    .io_out(FPReg_4_io_out)
  );
  FPReg FPReg_5 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_5_clock),
    .reset(FPReg_5_reset),
    .io_in(FPReg_5_io_in),
    .io_out(FPReg_5_io_out)
  );
  FPReg FPReg_6 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_6_clock),
    .reset(FPReg_6_reset),
    .io_in(FPReg_6_io_in),
    .io_out(FPReg_6_io_out)
  );
  FPReg FPReg_7 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_7_clock),
    .reset(FPReg_7_reset),
    .io_in(FPReg_7_io_in),
    .io_out(FPReg_7_io_out)
  );
  FPReg FPReg_8 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_8_clock),
    .reset(FPReg_8_reset),
    .io_in(FPReg_8_io_in),
    .io_out(FPReg_8_io_out)
  );
  FPReg FPReg_9 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_9_clock),
    .reset(FPReg_9_reset),
    .io_in(FPReg_9_io_in),
    .io_out(FPReg_9_io_out)
  );
  FPReg FPReg_10 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_10_clock),
    .reset(FPReg_10_reset),
    .io_in(FPReg_10_io_in),
    .io_out(FPReg_10_io_out)
  );
  FPReg FPReg_11 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_11_clock),
    .reset(FPReg_11_reset),
    .io_in(FPReg_11_io_in),
    .io_out(FPReg_11_io_out)
  );
  FPReg FPReg_12 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_12_clock),
    .reset(FPReg_12_reset),
    .io_in(FPReg_12_io_in),
    .io_out(FPReg_12_io_out)
  );
  FPReg FPReg_13 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_13_clock),
    .reset(FPReg_13_reset),
    .io_in(FPReg_13_io_in),
    .io_out(FPReg_13_io_out)
  );
  FPReg FPReg_14 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_14_clock),
    .reset(FPReg_14_reset),
    .io_in(FPReg_14_io_in),
    .io_out(FPReg_14_io_out)
  );
  FPReg FPReg_15 ( // @[FloatingPointDesigns.scala 2494:48]
    .clock(FPReg_15_clock),
    .reset(FPReg_15_reset),
    .io_in(FPReg_15_io_in),
    .io_out(FPReg_15_io_out)
  );
  assign io_out_s_0 = FP_adder_13ccs_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_1 = FP_adder_13ccs_1_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_2 = FP_adder_13ccs_2_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_3 = FP_adder_13ccs_3_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_4 = FP_adder_13ccs_4_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_5 = FP_adder_13ccs_5_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_6 = FP_adder_13ccs_6_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_7 = FP_adder_13ccs_7_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_8 = FP_adder_13ccs_8_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_9 = FP_adder_13ccs_9_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_10 = FP_adder_13ccs_10_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_11 = FP_adder_13ccs_11_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_12 = FP_adder_13ccs_12_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_13 = FP_adder_13ccs_13_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_14 = FP_adder_13ccs_14_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign io_out_s_15 = FP_adder_13ccs_15_io_out_s; // @[FloatingPointDesigns.scala 2501:19]
  assign FP_multiplier_10ccs_clock = clock;
  assign FP_multiplier_10ccs_reset = reset;
  assign FP_multiplier_10ccs_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_io_in_b = io_in_b_0; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_1_clock = clock;
  assign FP_multiplier_10ccs_1_reset = reset;
  assign FP_multiplier_10ccs_1_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_1_io_in_b = io_in_b_1; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_2_clock = clock;
  assign FP_multiplier_10ccs_2_reset = reset;
  assign FP_multiplier_10ccs_2_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_2_io_in_b = io_in_b_2; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_3_clock = clock;
  assign FP_multiplier_10ccs_3_reset = reset;
  assign FP_multiplier_10ccs_3_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_3_io_in_b = io_in_b_3; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_4_clock = clock;
  assign FP_multiplier_10ccs_4_reset = reset;
  assign FP_multiplier_10ccs_4_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_4_io_in_b = io_in_b_4; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_5_clock = clock;
  assign FP_multiplier_10ccs_5_reset = reset;
  assign FP_multiplier_10ccs_5_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_5_io_in_b = io_in_b_5; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_6_clock = clock;
  assign FP_multiplier_10ccs_6_reset = reset;
  assign FP_multiplier_10ccs_6_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_6_io_in_b = io_in_b_6; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_7_clock = clock;
  assign FP_multiplier_10ccs_7_reset = reset;
  assign FP_multiplier_10ccs_7_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_7_io_in_b = io_in_b_7; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_8_clock = clock;
  assign FP_multiplier_10ccs_8_reset = reset;
  assign FP_multiplier_10ccs_8_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_8_io_in_b = io_in_b_8; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_9_clock = clock;
  assign FP_multiplier_10ccs_9_reset = reset;
  assign FP_multiplier_10ccs_9_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_9_io_in_b = io_in_b_9; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_10_clock = clock;
  assign FP_multiplier_10ccs_10_reset = reset;
  assign FP_multiplier_10ccs_10_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_10_io_in_b = io_in_b_10; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_11_clock = clock;
  assign FP_multiplier_10ccs_11_reset = reset;
  assign FP_multiplier_10ccs_11_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_11_io_in_b = io_in_b_11; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_12_clock = clock;
  assign FP_multiplier_10ccs_12_reset = reset;
  assign FP_multiplier_10ccs_12_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_12_io_in_b = io_in_b_12; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_13_clock = clock;
  assign FP_multiplier_10ccs_13_reset = reset;
  assign FP_multiplier_10ccs_13_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_13_io_in_b = io_in_b_13; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_14_clock = clock;
  assign FP_multiplier_10ccs_14_reset = reset;
  assign FP_multiplier_10ccs_14_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_14_io_in_b = io_in_b_14; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_multiplier_10ccs_15_clock = clock;
  assign FP_multiplier_10ccs_15_reset = reset;
  assign FP_multiplier_10ccs_15_io_in_a = io_in_a; // @[FloatingPointDesigns.scala 2496:30]
  assign FP_multiplier_10ccs_15_io_in_b = io_in_b_15; // @[FloatingPointDesigns.scala 2497:30]
  assign FP_adder_13ccs_clock = clock;
  assign FP_adder_13ccs_reset = reset;
  assign FP_adder_13ccs_io_in_a = FP_multiplier_10ccs_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_io_in_b = FPReg_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_1_clock = clock;
  assign FP_adder_13ccs_1_reset = reset;
  assign FP_adder_13ccs_1_io_in_a = FP_multiplier_10ccs_1_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_1_io_in_b = FPReg_1_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_2_clock = clock;
  assign FP_adder_13ccs_2_reset = reset;
  assign FP_adder_13ccs_2_io_in_a = FP_multiplier_10ccs_2_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_2_io_in_b = FPReg_2_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_3_clock = clock;
  assign FP_adder_13ccs_3_reset = reset;
  assign FP_adder_13ccs_3_io_in_a = FP_multiplier_10ccs_3_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_3_io_in_b = FPReg_3_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_4_clock = clock;
  assign FP_adder_13ccs_4_reset = reset;
  assign FP_adder_13ccs_4_io_in_a = FP_multiplier_10ccs_4_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_4_io_in_b = FPReg_4_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_5_clock = clock;
  assign FP_adder_13ccs_5_reset = reset;
  assign FP_adder_13ccs_5_io_in_a = FP_multiplier_10ccs_5_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_5_io_in_b = FPReg_5_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_6_clock = clock;
  assign FP_adder_13ccs_6_reset = reset;
  assign FP_adder_13ccs_6_io_in_a = FP_multiplier_10ccs_6_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_6_io_in_b = FPReg_6_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_7_clock = clock;
  assign FP_adder_13ccs_7_reset = reset;
  assign FP_adder_13ccs_7_io_in_a = FP_multiplier_10ccs_7_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_7_io_in_b = FPReg_7_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_8_clock = clock;
  assign FP_adder_13ccs_8_reset = reset;
  assign FP_adder_13ccs_8_io_in_a = FP_multiplier_10ccs_8_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_8_io_in_b = FPReg_8_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_9_clock = clock;
  assign FP_adder_13ccs_9_reset = reset;
  assign FP_adder_13ccs_9_io_in_a = FP_multiplier_10ccs_9_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_9_io_in_b = FPReg_9_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_10_clock = clock;
  assign FP_adder_13ccs_10_reset = reset;
  assign FP_adder_13ccs_10_io_in_a = FP_multiplier_10ccs_10_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_10_io_in_b = FPReg_10_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_11_clock = clock;
  assign FP_adder_13ccs_11_reset = reset;
  assign FP_adder_13ccs_11_io_in_a = FP_multiplier_10ccs_11_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_11_io_in_b = FPReg_11_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_12_clock = clock;
  assign FP_adder_13ccs_12_reset = reset;
  assign FP_adder_13ccs_12_io_in_a = FP_multiplier_10ccs_12_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_12_io_in_b = FPReg_12_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_13_clock = clock;
  assign FP_adder_13ccs_13_reset = reset;
  assign FP_adder_13ccs_13_io_in_a = FP_multiplier_10ccs_13_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_13_io_in_b = FPReg_13_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_14_clock = clock;
  assign FP_adder_13ccs_14_reset = reset;
  assign FP_adder_13ccs_14_io_in_a = FP_multiplier_10ccs_14_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_14_io_in_b = FPReg_14_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FP_adder_13ccs_15_clock = clock;
  assign FP_adder_13ccs_15_reset = reset;
  assign FP_adder_13ccs_15_io_in_a = FP_multiplier_10ccs_15_io_out_s; // @[FloatingPointDesigns.scala 2499:27]
  assign FP_adder_13ccs_15_io_in_b = FPReg_15_io_out; // @[FloatingPointDesigns.scala 2500:27]
  assign FPReg_clock = clock;
  assign FPReg_reset = reset;
  assign FPReg_io_in = io_in_c_0; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_1_clock = clock;
  assign FPReg_1_reset = reset;
  assign FPReg_1_io_in = io_in_c_1; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_2_clock = clock;
  assign FPReg_2_reset = reset;
  assign FPReg_2_io_in = io_in_c_2; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_3_clock = clock;
  assign FPReg_3_reset = reset;
  assign FPReg_3_io_in = io_in_c_3; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_4_clock = clock;
  assign FPReg_4_reset = reset;
  assign FPReg_4_io_in = io_in_c_4; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_5_clock = clock;
  assign FPReg_5_reset = reset;
  assign FPReg_5_io_in = io_in_c_5; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_6_clock = clock;
  assign FPReg_6_reset = reset;
  assign FPReg_6_io_in = io_in_c_6; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_7_clock = clock;
  assign FPReg_7_reset = reset;
  assign FPReg_7_io_in = io_in_c_7; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_8_clock = clock;
  assign FPReg_8_reset = reset;
  assign FPReg_8_io_in = io_in_c_8; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_9_clock = clock;
  assign FPReg_9_reset = reset;
  assign FPReg_9_io_in = io_in_c_9; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_10_clock = clock;
  assign FPReg_10_reset = reset;
  assign FPReg_10_io_in = io_in_c_10; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_11_clock = clock;
  assign FPReg_11_reset = reset;
  assign FPReg_11_io_in = io_in_c_11; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_12_clock = clock;
  assign FPReg_12_reset = reset;
  assign FPReg_12_io_in = io_in_c_12; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_13_clock = clock;
  assign FPReg_13_reset = reset;
  assign FPReg_13_io_in = io_in_c_13; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_14_clock = clock;
  assign FPReg_14_reset = reset;
  assign FPReg_14_io_in = io_in_c_14; // @[FloatingPointDesigns.scala 2498:25]
  assign FPReg_15_clock = clock;
  assign FPReg_15_reset = reset;
  assign FPReg_15_io_in = io_in_c_15; // @[FloatingPointDesigns.scala 2498:25]
endmodule
module hh_datapath_1(
  input          io_clk,
  input          io_rst,
  input  [15:0]  io_hh_cnt,
  input          io_d1_rdy,
  input          io_d1_vld,
  input          io_d2_vld,
  input          io_vk1_vld,
  input          io_d3_rdy,
  input          io_d3_vld,
  input          io_tk_vld,
  input          io_d4_rdy,
  input          io_d5_rdy,
  input          io_d5_vld,
  input          io_yj_sft,
  input          io_d4_sft,
  input  [511:0] io_hh_din,
  output [511:0] io_hh_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [511:0] _RAND_0;
  reg [25727:0] _RAND_1;
  reg [25727:0] _RAND_2;
  reg [25727:0] _RAND_3;
  reg [25727:0] _RAND_4;
  reg [511:0] _RAND_5;
  reg [511:0] _RAND_6;
  reg [511:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [4063:0] _RAND_17;
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
`endif // RANDOMIZE_REG_INIT
  wire  FP_DDOT_dp_clock; // @[hh_datapath_chisel.scala 252:21]
  wire  FP_DDOT_dp_reset; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_0; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_1; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_2; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_3; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_4; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_5; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_6; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_7; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_8; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_9; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_10; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_11; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_12; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_13; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_14; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_a_15; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_0; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_1; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_2; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_3; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_4; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_5; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_6; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_7; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_8; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_9; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_10; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_11; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_12; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_13; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_14; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_in_b_15; // @[hh_datapath_chisel.scala 252:21]
  wire [31:0] FP_DDOT_dp_io_out_s; // @[hh_datapath_chisel.scala 252:21]
  wire  FP_square_root_newfpu_clock; // @[hh_datapath_chisel.scala 260:22]
  wire  FP_square_root_newfpu_reset; // @[hh_datapath_chisel.scala 260:22]
  wire [31:0] FP_square_root_newfpu_io_in_a; // @[hh_datapath_chisel.scala 260:22]
  wire [31:0] FP_square_root_newfpu_io_out_s; // @[hh_datapath_chisel.scala 260:22]
  wire  hqr5_clock; // @[hh_datapath_chisel.scala 265:20]
  wire  hqr5_reset; // @[hh_datapath_chisel.scala 265:20]
  wire [31:0] hqr5_io_in_a; // @[hh_datapath_chisel.scala 265:20]
  wire [31:0] hqr5_io_in_b; // @[hh_datapath_chisel.scala 265:20]
  wire [31:0] hqr5_io_out_s; // @[hh_datapath_chisel.scala 265:20]
  wire  hqr7_clock; // @[hh_datapath_chisel.scala 270:20]
  wire  hqr7_reset; // @[hh_datapath_chisel.scala 270:20]
  wire [31:0] hqr7_io_in_a; // @[hh_datapath_chisel.scala 270:20]
  wire [31:0] hqr7_io_out_s; // @[hh_datapath_chisel.scala 270:20]
  wire  FP_multiplier_10ccs_clock; // @[hh_datapath_chisel.scala 274:21]
  wire  FP_multiplier_10ccs_reset; // @[hh_datapath_chisel.scala 274:21]
  wire [31:0] FP_multiplier_10ccs_io_in_a; // @[hh_datapath_chisel.scala 274:21]
  wire [31:0] FP_multiplier_10ccs_io_in_b; // @[hh_datapath_chisel.scala 274:21]
  wire [31:0] FP_multiplier_10ccs_io_out_s; // @[hh_datapath_chisel.scala 274:21]
  wire  axpy_dp_clock; // @[hh_datapath_chisel.scala 280:20]
  wire  axpy_dp_reset; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_a; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_0; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_1; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_2; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_3; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_4; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_5; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_6; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_7; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_8; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_9; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_10; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_11; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_12; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_13; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_14; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_b_15; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_0; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_1; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_2; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_3; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_4; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_5; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_6; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_7; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_8; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_9; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_10; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_11; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_12; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_13; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_14; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_in_c_15; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_0; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_1; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_2; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_3; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_4; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_5; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_6; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_7; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_8; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_9; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_10; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_11; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_12; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_13; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_14; // @[hh_datapath_chisel.scala 280:20]
  wire [31:0] axpy_dp_io_out_s_15; // @[hh_datapath_chisel.scala 280:20]
  reg [511:0] yj0; // @[hh_datapath_chisel.scala 62:18]
  reg [25727:0] yj_reg_1; // @[hh_datapath_chisel.scala 63:23]
  reg [25727:0] yj_reg_2; // @[hh_datapath_chisel.scala 64:23]
  reg [25727:0] yj_reg_3; // @[hh_datapath_chisel.scala 65:23]
  reg [25727:0] yj_reg_4; // @[hh_datapath_chisel.scala 66:23]
  wire [26239:0] _yj_reg_4_T_1 = {yj_reg_3[511:0],yj_reg_4}; // @[Cat.scala 31:58]
  wire [26239:0] _yj_reg_3_T_1 = {yj_reg_2[511:0],yj_reg_3}; // @[Cat.scala 31:58]
  wire [26239:0] _yj_reg_2_T_1 = {yj_reg_1[511:0],yj_reg_2}; // @[Cat.scala 31:58]
  wire [26239:0] _yj_reg_1_T = {io_hh_din,yj_reg_1}; // @[Cat.scala 31:58]
  reg [511:0] ddot_din_a_reg; // @[hh_datapath_chisel.scala 90:29]
  reg [511:0] ddot_din_b_reg; // @[hh_datapath_chisel.scala 91:29]
  reg [511:0] vk_reg; // @[hh_datapath_chisel.scala 92:21]
  reg [31:0] d1_reg; // @[hh_datapath_chisel.scala 93:21]
  reg [31:0] d3_reg; // @[hh_datapath_chisel.scala 94:21]
  reg [31:0] d4_update; // @[hh_datapath_chisel.scala 99:24]
  reg [31:0] x1_reg; // @[hh_datapath_chisel.scala 106:21]
  reg [31:0] d2_reg; // @[hh_datapath_chisel.scala 107:21]
  reg [31:0] vk1_reg; // @[hh_datapath_chisel.scala 108:22]
  reg [31:0] tk_reg; // @[hh_datapath_chisel.scala 109:21]
  reg [31:0] d4_reg; // @[hh_datapath_chisel.scala 110:21]
  reg [31:0] d5_reg; // @[hh_datapath_chisel.scala 111:21]
  wire [31:0] vk1_update = hqr5_io_out_s; // @[hh_datapath_chisel.scala 268:15 97:26]
  wire [31:0] vk1 = io_vk1_vld ? vk1_update : vk1_reg; // @[hh_datapath_chisel.scala 199:21 200:11 202:11]
  wire [15:0] _myNewVec_15_T_1 = io_hh_cnt + 16'h1; // @[hh_datapath_chisel.scala 238:55]
  wire [16:0] _myNewVec_15_T_2 = {{1'd0}, _myNewVec_15_T_1}; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] myVec_15 = io_hh_din[31:0]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_14 = io_hh_din[63:32]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_13 = io_hh_din[95:64]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_12 = io_hh_din[127:96]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_11 = io_hh_din[159:128]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_10 = io_hh_din[191:160]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_9 = io_hh_din[223:192]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_8 = io_hh_din[255:224]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_7 = io_hh_din[287:256]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_6 = io_hh_din[319:288]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_5 = io_hh_din[351:320]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_4 = io_hh_din[383:352]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_3 = io_hh_din[415:384]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_2 = io_hh_din[447:416]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_1 = io_hh_din[479:448]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] myVec_0 = io_hh_din[511:480]; // @[hh_datapath_chisel.scala 225:28]
  wire [31:0] _GEN_59 = 4'h1 == _myNewVec_15_T_2[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_60 = 4'h2 == _myNewVec_15_T_2[3:0] ? myVec_2 : _GEN_59; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_61 = 4'h3 == _myNewVec_15_T_2[3:0] ? myVec_3 : _GEN_60; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_62 = 4'h4 == _myNewVec_15_T_2[3:0] ? myVec_4 : _GEN_61; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_63 = 4'h5 == _myNewVec_15_T_2[3:0] ? myVec_5 : _GEN_62; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_64 = 4'h6 == _myNewVec_15_T_2[3:0] ? myVec_6 : _GEN_63; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_65 = 4'h7 == _myNewVec_15_T_2[3:0] ? myVec_7 : _GEN_64; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_66 = 4'h8 == _myNewVec_15_T_2[3:0] ? myVec_8 : _GEN_65; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_67 = 4'h9 == _myNewVec_15_T_2[3:0] ? myVec_9 : _GEN_66; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_68 = 4'ha == _myNewVec_15_T_2[3:0] ? myVec_10 : _GEN_67; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_69 = 4'hb == _myNewVec_15_T_2[3:0] ? myVec_11 : _GEN_68; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_70 = 4'hc == _myNewVec_15_T_2[3:0] ? myVec_12 : _GEN_69; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_71 = 4'hd == _myNewVec_15_T_2[3:0] ? myVec_13 : _GEN_70; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_72 = 4'he == _myNewVec_15_T_2[3:0] ? myVec_14 : _GEN_71; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_15 = 4'hf == _myNewVec_15_T_2[3:0] ? myVec_15 : _GEN_72; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_14_T_3 = _myNewVec_15_T_1 + 16'h1; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_75 = 4'h1 == _myNewVec_14_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_76 = 4'h2 == _myNewVec_14_T_3[3:0] ? myVec_2 : _GEN_75; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_77 = 4'h3 == _myNewVec_14_T_3[3:0] ? myVec_3 : _GEN_76; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_78 = 4'h4 == _myNewVec_14_T_3[3:0] ? myVec_4 : _GEN_77; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_79 = 4'h5 == _myNewVec_14_T_3[3:0] ? myVec_5 : _GEN_78; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_80 = 4'h6 == _myNewVec_14_T_3[3:0] ? myVec_6 : _GEN_79; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_81 = 4'h7 == _myNewVec_14_T_3[3:0] ? myVec_7 : _GEN_80; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_82 = 4'h8 == _myNewVec_14_T_3[3:0] ? myVec_8 : _GEN_81; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_83 = 4'h9 == _myNewVec_14_T_3[3:0] ? myVec_9 : _GEN_82; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_84 = 4'ha == _myNewVec_14_T_3[3:0] ? myVec_10 : _GEN_83; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_85 = 4'hb == _myNewVec_14_T_3[3:0] ? myVec_11 : _GEN_84; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_86 = 4'hc == _myNewVec_14_T_3[3:0] ? myVec_12 : _GEN_85; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_87 = 4'hd == _myNewVec_14_T_3[3:0] ? myVec_13 : _GEN_86; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_88 = 4'he == _myNewVec_14_T_3[3:0] ? myVec_14 : _GEN_87; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_14 = 4'hf == _myNewVec_14_T_3[3:0] ? myVec_15 : _GEN_88; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_13_T_3 = _myNewVec_15_T_1 + 16'h2; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_91 = 4'h1 == _myNewVec_13_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_92 = 4'h2 == _myNewVec_13_T_3[3:0] ? myVec_2 : _GEN_91; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_93 = 4'h3 == _myNewVec_13_T_3[3:0] ? myVec_3 : _GEN_92; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_94 = 4'h4 == _myNewVec_13_T_3[3:0] ? myVec_4 : _GEN_93; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_95 = 4'h5 == _myNewVec_13_T_3[3:0] ? myVec_5 : _GEN_94; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_96 = 4'h6 == _myNewVec_13_T_3[3:0] ? myVec_6 : _GEN_95; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_97 = 4'h7 == _myNewVec_13_T_3[3:0] ? myVec_7 : _GEN_96; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_98 = 4'h8 == _myNewVec_13_T_3[3:0] ? myVec_8 : _GEN_97; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_99 = 4'h9 == _myNewVec_13_T_3[3:0] ? myVec_9 : _GEN_98; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_100 = 4'ha == _myNewVec_13_T_3[3:0] ? myVec_10 : _GEN_99; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_101 = 4'hb == _myNewVec_13_T_3[3:0] ? myVec_11 : _GEN_100; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_102 = 4'hc == _myNewVec_13_T_3[3:0] ? myVec_12 : _GEN_101; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_103 = 4'hd == _myNewVec_13_T_3[3:0] ? myVec_13 : _GEN_102; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_104 = 4'he == _myNewVec_13_T_3[3:0] ? myVec_14 : _GEN_103; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_13 = 4'hf == _myNewVec_13_T_3[3:0] ? myVec_15 : _GEN_104; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_12_T_3 = _myNewVec_15_T_1 + 16'h3; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_107 = 4'h1 == _myNewVec_12_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_108 = 4'h2 == _myNewVec_12_T_3[3:0] ? myVec_2 : _GEN_107; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_109 = 4'h3 == _myNewVec_12_T_3[3:0] ? myVec_3 : _GEN_108; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_110 = 4'h4 == _myNewVec_12_T_3[3:0] ? myVec_4 : _GEN_109; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_111 = 4'h5 == _myNewVec_12_T_3[3:0] ? myVec_5 : _GEN_110; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_112 = 4'h6 == _myNewVec_12_T_3[3:0] ? myVec_6 : _GEN_111; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_113 = 4'h7 == _myNewVec_12_T_3[3:0] ? myVec_7 : _GEN_112; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_114 = 4'h8 == _myNewVec_12_T_3[3:0] ? myVec_8 : _GEN_113; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_115 = 4'h9 == _myNewVec_12_T_3[3:0] ? myVec_9 : _GEN_114; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_116 = 4'ha == _myNewVec_12_T_3[3:0] ? myVec_10 : _GEN_115; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_117 = 4'hb == _myNewVec_12_T_3[3:0] ? myVec_11 : _GEN_116; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_118 = 4'hc == _myNewVec_12_T_3[3:0] ? myVec_12 : _GEN_117; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_119 = 4'hd == _myNewVec_12_T_3[3:0] ? myVec_13 : _GEN_118; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_120 = 4'he == _myNewVec_12_T_3[3:0] ? myVec_14 : _GEN_119; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_12 = 4'hf == _myNewVec_12_T_3[3:0] ? myVec_15 : _GEN_120; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_11_T_3 = _myNewVec_15_T_1 + 16'h4; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_123 = 4'h1 == _myNewVec_11_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_124 = 4'h2 == _myNewVec_11_T_3[3:0] ? myVec_2 : _GEN_123; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_125 = 4'h3 == _myNewVec_11_T_3[3:0] ? myVec_3 : _GEN_124; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_126 = 4'h4 == _myNewVec_11_T_3[3:0] ? myVec_4 : _GEN_125; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_127 = 4'h5 == _myNewVec_11_T_3[3:0] ? myVec_5 : _GEN_126; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_128 = 4'h6 == _myNewVec_11_T_3[3:0] ? myVec_6 : _GEN_127; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_129 = 4'h7 == _myNewVec_11_T_3[3:0] ? myVec_7 : _GEN_128; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_130 = 4'h8 == _myNewVec_11_T_3[3:0] ? myVec_8 : _GEN_129; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_131 = 4'h9 == _myNewVec_11_T_3[3:0] ? myVec_9 : _GEN_130; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_132 = 4'ha == _myNewVec_11_T_3[3:0] ? myVec_10 : _GEN_131; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_133 = 4'hb == _myNewVec_11_T_3[3:0] ? myVec_11 : _GEN_132; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_134 = 4'hc == _myNewVec_11_T_3[3:0] ? myVec_12 : _GEN_133; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_135 = 4'hd == _myNewVec_11_T_3[3:0] ? myVec_13 : _GEN_134; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_136 = 4'he == _myNewVec_11_T_3[3:0] ? myVec_14 : _GEN_135; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_11 = 4'hf == _myNewVec_11_T_3[3:0] ? myVec_15 : _GEN_136; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_10_T_3 = _myNewVec_15_T_1 + 16'h5; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_139 = 4'h1 == _myNewVec_10_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_140 = 4'h2 == _myNewVec_10_T_3[3:0] ? myVec_2 : _GEN_139; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_141 = 4'h3 == _myNewVec_10_T_3[3:0] ? myVec_3 : _GEN_140; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_142 = 4'h4 == _myNewVec_10_T_3[3:0] ? myVec_4 : _GEN_141; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_143 = 4'h5 == _myNewVec_10_T_3[3:0] ? myVec_5 : _GEN_142; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_144 = 4'h6 == _myNewVec_10_T_3[3:0] ? myVec_6 : _GEN_143; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_145 = 4'h7 == _myNewVec_10_T_3[3:0] ? myVec_7 : _GEN_144; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_146 = 4'h8 == _myNewVec_10_T_3[3:0] ? myVec_8 : _GEN_145; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_147 = 4'h9 == _myNewVec_10_T_3[3:0] ? myVec_9 : _GEN_146; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_148 = 4'ha == _myNewVec_10_T_3[3:0] ? myVec_10 : _GEN_147; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_149 = 4'hb == _myNewVec_10_T_3[3:0] ? myVec_11 : _GEN_148; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_150 = 4'hc == _myNewVec_10_T_3[3:0] ? myVec_12 : _GEN_149; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_151 = 4'hd == _myNewVec_10_T_3[3:0] ? myVec_13 : _GEN_150; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_152 = 4'he == _myNewVec_10_T_3[3:0] ? myVec_14 : _GEN_151; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_10 = 4'hf == _myNewVec_10_T_3[3:0] ? myVec_15 : _GEN_152; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_9_T_3 = _myNewVec_15_T_1 + 16'h6; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_155 = 4'h1 == _myNewVec_9_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_156 = 4'h2 == _myNewVec_9_T_3[3:0] ? myVec_2 : _GEN_155; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_157 = 4'h3 == _myNewVec_9_T_3[3:0] ? myVec_3 : _GEN_156; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_158 = 4'h4 == _myNewVec_9_T_3[3:0] ? myVec_4 : _GEN_157; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_159 = 4'h5 == _myNewVec_9_T_3[3:0] ? myVec_5 : _GEN_158; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_160 = 4'h6 == _myNewVec_9_T_3[3:0] ? myVec_6 : _GEN_159; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_161 = 4'h7 == _myNewVec_9_T_3[3:0] ? myVec_7 : _GEN_160; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_162 = 4'h8 == _myNewVec_9_T_3[3:0] ? myVec_8 : _GEN_161; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_163 = 4'h9 == _myNewVec_9_T_3[3:0] ? myVec_9 : _GEN_162; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_164 = 4'ha == _myNewVec_9_T_3[3:0] ? myVec_10 : _GEN_163; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_165 = 4'hb == _myNewVec_9_T_3[3:0] ? myVec_11 : _GEN_164; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_166 = 4'hc == _myNewVec_9_T_3[3:0] ? myVec_12 : _GEN_165; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_167 = 4'hd == _myNewVec_9_T_3[3:0] ? myVec_13 : _GEN_166; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_168 = 4'he == _myNewVec_9_T_3[3:0] ? myVec_14 : _GEN_167; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_9 = 4'hf == _myNewVec_9_T_3[3:0] ? myVec_15 : _GEN_168; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_8_T_3 = _myNewVec_15_T_1 + 16'h7; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_171 = 4'h1 == _myNewVec_8_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_172 = 4'h2 == _myNewVec_8_T_3[3:0] ? myVec_2 : _GEN_171; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_173 = 4'h3 == _myNewVec_8_T_3[3:0] ? myVec_3 : _GEN_172; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_174 = 4'h4 == _myNewVec_8_T_3[3:0] ? myVec_4 : _GEN_173; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_175 = 4'h5 == _myNewVec_8_T_3[3:0] ? myVec_5 : _GEN_174; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_176 = 4'h6 == _myNewVec_8_T_3[3:0] ? myVec_6 : _GEN_175; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_177 = 4'h7 == _myNewVec_8_T_3[3:0] ? myVec_7 : _GEN_176; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_178 = 4'h8 == _myNewVec_8_T_3[3:0] ? myVec_8 : _GEN_177; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_179 = 4'h9 == _myNewVec_8_T_3[3:0] ? myVec_9 : _GEN_178; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_180 = 4'ha == _myNewVec_8_T_3[3:0] ? myVec_10 : _GEN_179; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_181 = 4'hb == _myNewVec_8_T_3[3:0] ? myVec_11 : _GEN_180; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_182 = 4'hc == _myNewVec_8_T_3[3:0] ? myVec_12 : _GEN_181; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_183 = 4'hd == _myNewVec_8_T_3[3:0] ? myVec_13 : _GEN_182; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_184 = 4'he == _myNewVec_8_T_3[3:0] ? myVec_14 : _GEN_183; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_8 = 4'hf == _myNewVec_8_T_3[3:0] ? myVec_15 : _GEN_184; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_7_T_3 = _myNewVec_15_T_1 + 16'h8; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_187 = 4'h1 == _myNewVec_7_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_188 = 4'h2 == _myNewVec_7_T_3[3:0] ? myVec_2 : _GEN_187; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_189 = 4'h3 == _myNewVec_7_T_3[3:0] ? myVec_3 : _GEN_188; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_190 = 4'h4 == _myNewVec_7_T_3[3:0] ? myVec_4 : _GEN_189; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_191 = 4'h5 == _myNewVec_7_T_3[3:0] ? myVec_5 : _GEN_190; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_192 = 4'h6 == _myNewVec_7_T_3[3:0] ? myVec_6 : _GEN_191; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_193 = 4'h7 == _myNewVec_7_T_3[3:0] ? myVec_7 : _GEN_192; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_194 = 4'h8 == _myNewVec_7_T_3[3:0] ? myVec_8 : _GEN_193; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_195 = 4'h9 == _myNewVec_7_T_3[3:0] ? myVec_9 : _GEN_194; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_196 = 4'ha == _myNewVec_7_T_3[3:0] ? myVec_10 : _GEN_195; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_197 = 4'hb == _myNewVec_7_T_3[3:0] ? myVec_11 : _GEN_196; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_198 = 4'hc == _myNewVec_7_T_3[3:0] ? myVec_12 : _GEN_197; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_199 = 4'hd == _myNewVec_7_T_3[3:0] ? myVec_13 : _GEN_198; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_200 = 4'he == _myNewVec_7_T_3[3:0] ? myVec_14 : _GEN_199; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_7 = 4'hf == _myNewVec_7_T_3[3:0] ? myVec_15 : _GEN_200; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_6_T_3 = _myNewVec_15_T_1 + 16'h9; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_203 = 4'h1 == _myNewVec_6_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_204 = 4'h2 == _myNewVec_6_T_3[3:0] ? myVec_2 : _GEN_203; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_205 = 4'h3 == _myNewVec_6_T_3[3:0] ? myVec_3 : _GEN_204; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_206 = 4'h4 == _myNewVec_6_T_3[3:0] ? myVec_4 : _GEN_205; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_207 = 4'h5 == _myNewVec_6_T_3[3:0] ? myVec_5 : _GEN_206; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_208 = 4'h6 == _myNewVec_6_T_3[3:0] ? myVec_6 : _GEN_207; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_209 = 4'h7 == _myNewVec_6_T_3[3:0] ? myVec_7 : _GEN_208; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_210 = 4'h8 == _myNewVec_6_T_3[3:0] ? myVec_8 : _GEN_209; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_211 = 4'h9 == _myNewVec_6_T_3[3:0] ? myVec_9 : _GEN_210; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_212 = 4'ha == _myNewVec_6_T_3[3:0] ? myVec_10 : _GEN_211; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_213 = 4'hb == _myNewVec_6_T_3[3:0] ? myVec_11 : _GEN_212; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_214 = 4'hc == _myNewVec_6_T_3[3:0] ? myVec_12 : _GEN_213; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_215 = 4'hd == _myNewVec_6_T_3[3:0] ? myVec_13 : _GEN_214; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_216 = 4'he == _myNewVec_6_T_3[3:0] ? myVec_14 : _GEN_215; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_6 = 4'hf == _myNewVec_6_T_3[3:0] ? myVec_15 : _GEN_216; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_5_T_3 = _myNewVec_15_T_1 + 16'ha; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_219 = 4'h1 == _myNewVec_5_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_220 = 4'h2 == _myNewVec_5_T_3[3:0] ? myVec_2 : _GEN_219; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_221 = 4'h3 == _myNewVec_5_T_3[3:0] ? myVec_3 : _GEN_220; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_222 = 4'h4 == _myNewVec_5_T_3[3:0] ? myVec_4 : _GEN_221; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_223 = 4'h5 == _myNewVec_5_T_3[3:0] ? myVec_5 : _GEN_222; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_224 = 4'h6 == _myNewVec_5_T_3[3:0] ? myVec_6 : _GEN_223; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_225 = 4'h7 == _myNewVec_5_T_3[3:0] ? myVec_7 : _GEN_224; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_226 = 4'h8 == _myNewVec_5_T_3[3:0] ? myVec_8 : _GEN_225; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_227 = 4'h9 == _myNewVec_5_T_3[3:0] ? myVec_9 : _GEN_226; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_228 = 4'ha == _myNewVec_5_T_3[3:0] ? myVec_10 : _GEN_227; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_229 = 4'hb == _myNewVec_5_T_3[3:0] ? myVec_11 : _GEN_228; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_230 = 4'hc == _myNewVec_5_T_3[3:0] ? myVec_12 : _GEN_229; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_231 = 4'hd == _myNewVec_5_T_3[3:0] ? myVec_13 : _GEN_230; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_232 = 4'he == _myNewVec_5_T_3[3:0] ? myVec_14 : _GEN_231; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_5 = 4'hf == _myNewVec_5_T_3[3:0] ? myVec_15 : _GEN_232; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_4_T_3 = _myNewVec_15_T_1 + 16'hb; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_235 = 4'h1 == _myNewVec_4_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_236 = 4'h2 == _myNewVec_4_T_3[3:0] ? myVec_2 : _GEN_235; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_237 = 4'h3 == _myNewVec_4_T_3[3:0] ? myVec_3 : _GEN_236; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_238 = 4'h4 == _myNewVec_4_T_3[3:0] ? myVec_4 : _GEN_237; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_239 = 4'h5 == _myNewVec_4_T_3[3:0] ? myVec_5 : _GEN_238; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_240 = 4'h6 == _myNewVec_4_T_3[3:0] ? myVec_6 : _GEN_239; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_241 = 4'h7 == _myNewVec_4_T_3[3:0] ? myVec_7 : _GEN_240; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_242 = 4'h8 == _myNewVec_4_T_3[3:0] ? myVec_8 : _GEN_241; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_243 = 4'h9 == _myNewVec_4_T_3[3:0] ? myVec_9 : _GEN_242; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_244 = 4'ha == _myNewVec_4_T_3[3:0] ? myVec_10 : _GEN_243; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_245 = 4'hb == _myNewVec_4_T_3[3:0] ? myVec_11 : _GEN_244; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_246 = 4'hc == _myNewVec_4_T_3[3:0] ? myVec_12 : _GEN_245; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_247 = 4'hd == _myNewVec_4_T_3[3:0] ? myVec_13 : _GEN_246; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_248 = 4'he == _myNewVec_4_T_3[3:0] ? myVec_14 : _GEN_247; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_4 = 4'hf == _myNewVec_4_T_3[3:0] ? myVec_15 : _GEN_248; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_3_T_3 = _myNewVec_15_T_1 + 16'hc; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_251 = 4'h1 == _myNewVec_3_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_252 = 4'h2 == _myNewVec_3_T_3[3:0] ? myVec_2 : _GEN_251; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_253 = 4'h3 == _myNewVec_3_T_3[3:0] ? myVec_3 : _GEN_252; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_254 = 4'h4 == _myNewVec_3_T_3[3:0] ? myVec_4 : _GEN_253; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_255 = 4'h5 == _myNewVec_3_T_3[3:0] ? myVec_5 : _GEN_254; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_256 = 4'h6 == _myNewVec_3_T_3[3:0] ? myVec_6 : _GEN_255; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_257 = 4'h7 == _myNewVec_3_T_3[3:0] ? myVec_7 : _GEN_256; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_258 = 4'h8 == _myNewVec_3_T_3[3:0] ? myVec_8 : _GEN_257; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_259 = 4'h9 == _myNewVec_3_T_3[3:0] ? myVec_9 : _GEN_258; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_260 = 4'ha == _myNewVec_3_T_3[3:0] ? myVec_10 : _GEN_259; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_261 = 4'hb == _myNewVec_3_T_3[3:0] ? myVec_11 : _GEN_260; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_262 = 4'hc == _myNewVec_3_T_3[3:0] ? myVec_12 : _GEN_261; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_263 = 4'hd == _myNewVec_3_T_3[3:0] ? myVec_13 : _GEN_262; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_264 = 4'he == _myNewVec_3_T_3[3:0] ? myVec_14 : _GEN_263; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_3 = 4'hf == _myNewVec_3_T_3[3:0] ? myVec_15 : _GEN_264; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_2_T_3 = _myNewVec_15_T_1 + 16'hd; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_267 = 4'h1 == _myNewVec_2_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_268 = 4'h2 == _myNewVec_2_T_3[3:0] ? myVec_2 : _GEN_267; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_269 = 4'h3 == _myNewVec_2_T_3[3:0] ? myVec_3 : _GEN_268; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_270 = 4'h4 == _myNewVec_2_T_3[3:0] ? myVec_4 : _GEN_269; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_271 = 4'h5 == _myNewVec_2_T_3[3:0] ? myVec_5 : _GEN_270; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_272 = 4'h6 == _myNewVec_2_T_3[3:0] ? myVec_6 : _GEN_271; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_273 = 4'h7 == _myNewVec_2_T_3[3:0] ? myVec_7 : _GEN_272; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_274 = 4'h8 == _myNewVec_2_T_3[3:0] ? myVec_8 : _GEN_273; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_275 = 4'h9 == _myNewVec_2_T_3[3:0] ? myVec_9 : _GEN_274; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_276 = 4'ha == _myNewVec_2_T_3[3:0] ? myVec_10 : _GEN_275; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_277 = 4'hb == _myNewVec_2_T_3[3:0] ? myVec_11 : _GEN_276; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_278 = 4'hc == _myNewVec_2_T_3[3:0] ? myVec_12 : _GEN_277; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_279 = 4'hd == _myNewVec_2_T_3[3:0] ? myVec_13 : _GEN_278; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_280 = 4'he == _myNewVec_2_T_3[3:0] ? myVec_14 : _GEN_279; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_2 = 4'hf == _myNewVec_2_T_3[3:0] ? myVec_15 : _GEN_280; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_1_T_3 = _myNewVec_15_T_1 + 16'he; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_283 = 4'h1 == _myNewVec_1_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_284 = 4'h2 == _myNewVec_1_T_3[3:0] ? myVec_2 : _GEN_283; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_285 = 4'h3 == _myNewVec_1_T_3[3:0] ? myVec_3 : _GEN_284; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_286 = 4'h4 == _myNewVec_1_T_3[3:0] ? myVec_4 : _GEN_285; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_287 = 4'h5 == _myNewVec_1_T_3[3:0] ? myVec_5 : _GEN_286; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_288 = 4'h6 == _myNewVec_1_T_3[3:0] ? myVec_6 : _GEN_287; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_289 = 4'h7 == _myNewVec_1_T_3[3:0] ? myVec_7 : _GEN_288; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_290 = 4'h8 == _myNewVec_1_T_3[3:0] ? myVec_8 : _GEN_289; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_291 = 4'h9 == _myNewVec_1_T_3[3:0] ? myVec_9 : _GEN_290; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_292 = 4'ha == _myNewVec_1_T_3[3:0] ? myVec_10 : _GEN_291; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_293 = 4'hb == _myNewVec_1_T_3[3:0] ? myVec_11 : _GEN_292; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_294 = 4'hc == _myNewVec_1_T_3[3:0] ? myVec_12 : _GEN_293; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_295 = 4'hd == _myNewVec_1_T_3[3:0] ? myVec_13 : _GEN_294; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_296 = 4'he == _myNewVec_1_T_3[3:0] ? myVec_14 : _GEN_295; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_1 = 4'hf == _myNewVec_1_T_3[3:0] ? myVec_15 : _GEN_296; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [15:0] _myNewVec_0_T_3 = _myNewVec_15_T_1 + 16'hf; // @[hh_datapath_chisel.scala 238:60]
  wire [31:0] _GEN_299 = 4'h1 == _myNewVec_0_T_3[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_300 = 4'h2 == _myNewVec_0_T_3[3:0] ? myVec_2 : _GEN_299; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_301 = 4'h3 == _myNewVec_0_T_3[3:0] ? myVec_3 : _GEN_300; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_302 = 4'h4 == _myNewVec_0_T_3[3:0] ? myVec_4 : _GEN_301; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_303 = 4'h5 == _myNewVec_0_T_3[3:0] ? myVec_5 : _GEN_302; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_304 = 4'h6 == _myNewVec_0_T_3[3:0] ? myVec_6 : _GEN_303; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_305 = 4'h7 == _myNewVec_0_T_3[3:0] ? myVec_7 : _GEN_304; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_306 = 4'h8 == _myNewVec_0_T_3[3:0] ? myVec_8 : _GEN_305; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_307 = 4'h9 == _myNewVec_0_T_3[3:0] ? myVec_9 : _GEN_306; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_308 = 4'ha == _myNewVec_0_T_3[3:0] ? myVec_10 : _GEN_307; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_309 = 4'hb == _myNewVec_0_T_3[3:0] ? myVec_11 : _GEN_308; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_310 = 4'hc == _myNewVec_0_T_3[3:0] ? myVec_12 : _GEN_309; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_311 = 4'hd == _myNewVec_0_T_3[3:0] ? myVec_13 : _GEN_310; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] _GEN_312 = 4'he == _myNewVec_0_T_3[3:0] ? myVec_14 : _GEN_311; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [31:0] myNewVec_0 = 4'hf == _myNewVec_0_T_3[3:0] ? myVec_15 : _GEN_312; // @[hh_datapath_chisel.scala 238:{37,37}]
  wire [255:0] myNewWire_lo = {myNewVec_7,myNewVec_6,myNewVec_5,myNewVec_4,myNewVec_3,myNewVec_2,myNewVec_1,myNewVec_0}; // @[hh_datapath_chisel.scala 242:27]
  wire [543:0] _vk_update_T = {vk1,myNewVec_15,myNewVec_14,myNewVec_13,myNewVec_12,myNewVec_11,myNewVec_10,myNewVec_9,
    myNewVec_8,myNewWire_lo}; // @[Cat.scala 31:58]
  wire [21:0] _vk_update_T_3 = _myNewVec_15_T_1 * 6'h20; // @[hh_datapath_chisel.scala 246:57]
  wire [543:0] _vk_update_T_4 = _vk_update_T >> _vk_update_T_3; // @[hh_datapath_chisel.scala 246:39]
  wire [543:0] _GEN_314 = io_vk1_vld ? _vk_update_T_4 : 544'h0; // @[hh_datapath_chisel.scala 245:27 246:17 249:17]
  wire [543:0] _GEN_315 = io_rst ? 544'h0 : _GEN_314; // @[hh_datapath_chisel.scala 243:17 244:17]
  wire [511:0] vk_update = _GEN_315[511:0]; // @[hh_datapath_chisel.scala 89:25]
  wire [511:0] vk = io_vk1_vld ? vk_update : vk_reg; // @[hh_datapath_chisel.scala 159:21 160:10 162:10]
  wire [31:0] ddot_dout = FP_DDOT_dp_io_out_s; // @[hh_datapath_chisel.scala 258:15 84:25]
  wire [31:0] _GEN_41 = 4'h1 == io_hh_cnt[3:0] ? myVec_1 : myVec_0; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_42 = 4'h2 == io_hh_cnt[3:0] ? myVec_2 : _GEN_41; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_43 = 4'h3 == io_hh_cnt[3:0] ? myVec_3 : _GEN_42; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_44 = 4'h4 == io_hh_cnt[3:0] ? myVec_4 : _GEN_43; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_45 = 4'h5 == io_hh_cnt[3:0] ? myVec_5 : _GEN_44; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_46 = 4'h6 == io_hh_cnt[3:0] ? myVec_6 : _GEN_45; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_47 = 4'h7 == io_hh_cnt[3:0] ? myVec_7 : _GEN_46; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_48 = 4'h8 == io_hh_cnt[3:0] ? myVec_8 : _GEN_47; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_49 = 4'h9 == io_hh_cnt[3:0] ? myVec_9 : _GEN_48; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_50 = 4'ha == io_hh_cnt[3:0] ? myVec_10 : _GEN_49; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_51 = 4'hb == io_hh_cnt[3:0] ? myVec_11 : _GEN_50; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_52 = 4'hc == io_hh_cnt[3:0] ? myVec_12 : _GEN_51; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_53 = 4'hd == io_hh_cnt[3:0] ? myVec_13 : _GEN_52; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_54 = 4'he == io_hh_cnt[3:0] ? myVec_14 : _GEN_53; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_55 = 4'hf == io_hh_cnt[3:0] ? myVec_15 : _GEN_54; // @[hh_datapath_chisel.scala 230:{17,17}]
  wire [31:0] _GEN_56 = io_d1_rdy ? _GEN_55 : 32'h0; // @[hh_datapath_chisel.scala 229:26 230:17 232:17]
  wire [31:0] x1_update = io_rst ? 32'h0 : _GEN_56; // @[hh_datapath_chisel.scala 227:17 228:17]
  wire [31:0] d2_update = FP_square_root_newfpu_io_out_s; // @[hh_datapath_chisel.scala 263:15 96:25]
  wire [31:0] tk_update = hqr7_io_out_s; // @[hh_datapath_chisel.scala 272:14 98:25]
  wire [31:0] d5_update = FP_multiplier_10ccs_io_out_s; // @[hh_datapath_chisel.scala 100:25 278:14]
  reg [4063:0] d4_update_reg; // @[hh_datapath_chisel.scala 165:28]
  wire [4095:0] _d4_update_reg_T = {ddot_dout,d4_update_reg}; // @[Cat.scala 31:58]
  reg [31:0] myAxpyVec_0; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_1; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_2; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_3; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_4; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_5; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_6; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_7; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_8; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_9; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_10; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_11; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_12; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_13; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_14; // @[hh_datapath_chisel.scala 286:23]
  reg [31:0] myAxpyVec_15; // @[hh_datapath_chisel.scala 286:23]
  wire [255:0] io_hh_dout_lo = {myAxpyVec_7,myAxpyVec_6,myAxpyVec_5,myAxpyVec_4,myAxpyVec_3,myAxpyVec_2,myAxpyVec_1,
    myAxpyVec_0}; // @[hh_datapath_chisel.scala 294:28]
  wire [255:0] io_hh_dout_hi = {myAxpyVec_15,myAxpyVec_14,myAxpyVec_13,myAxpyVec_12,myAxpyVec_11,myAxpyVec_10,
    myAxpyVec_9,myAxpyVec_8}; // @[hh_datapath_chisel.scala 294:28]
  FP_DDOT_dp FP_DDOT_dp ( // @[hh_datapath_chisel.scala 252:21]
    .clock(FP_DDOT_dp_clock),
    .reset(FP_DDOT_dp_reset),
    .io_in_a_0(FP_DDOT_dp_io_in_a_0),
    .io_in_a_1(FP_DDOT_dp_io_in_a_1),
    .io_in_a_2(FP_DDOT_dp_io_in_a_2),
    .io_in_a_3(FP_DDOT_dp_io_in_a_3),
    .io_in_a_4(FP_DDOT_dp_io_in_a_4),
    .io_in_a_5(FP_DDOT_dp_io_in_a_5),
    .io_in_a_6(FP_DDOT_dp_io_in_a_6),
    .io_in_a_7(FP_DDOT_dp_io_in_a_7),
    .io_in_a_8(FP_DDOT_dp_io_in_a_8),
    .io_in_a_9(FP_DDOT_dp_io_in_a_9),
    .io_in_a_10(FP_DDOT_dp_io_in_a_10),
    .io_in_a_11(FP_DDOT_dp_io_in_a_11),
    .io_in_a_12(FP_DDOT_dp_io_in_a_12),
    .io_in_a_13(FP_DDOT_dp_io_in_a_13),
    .io_in_a_14(FP_DDOT_dp_io_in_a_14),
    .io_in_a_15(FP_DDOT_dp_io_in_a_15),
    .io_in_b_0(FP_DDOT_dp_io_in_b_0),
    .io_in_b_1(FP_DDOT_dp_io_in_b_1),
    .io_in_b_2(FP_DDOT_dp_io_in_b_2),
    .io_in_b_3(FP_DDOT_dp_io_in_b_3),
    .io_in_b_4(FP_DDOT_dp_io_in_b_4),
    .io_in_b_5(FP_DDOT_dp_io_in_b_5),
    .io_in_b_6(FP_DDOT_dp_io_in_b_6),
    .io_in_b_7(FP_DDOT_dp_io_in_b_7),
    .io_in_b_8(FP_DDOT_dp_io_in_b_8),
    .io_in_b_9(FP_DDOT_dp_io_in_b_9),
    .io_in_b_10(FP_DDOT_dp_io_in_b_10),
    .io_in_b_11(FP_DDOT_dp_io_in_b_11),
    .io_in_b_12(FP_DDOT_dp_io_in_b_12),
    .io_in_b_13(FP_DDOT_dp_io_in_b_13),
    .io_in_b_14(FP_DDOT_dp_io_in_b_14),
    .io_in_b_15(FP_DDOT_dp_io_in_b_15),
    .io_out_s(FP_DDOT_dp_io_out_s)
  );
  FP_square_root_newfpu FP_square_root_newfpu ( // @[hh_datapath_chisel.scala 260:22]
    .clock(FP_square_root_newfpu_clock),
    .reset(FP_square_root_newfpu_reset),
    .io_in_a(FP_square_root_newfpu_io_in_a),
    .io_out_s(FP_square_root_newfpu_io_out_s)
  );
  hqr5 hqr5 ( // @[hh_datapath_chisel.scala 265:20]
    .clock(hqr5_clock),
    .reset(hqr5_reset),
    .io_in_a(hqr5_io_in_a),
    .io_in_b(hqr5_io_in_b),
    .io_out_s(hqr5_io_out_s)
  );
  hqr7 hqr7 ( // @[hh_datapath_chisel.scala 270:20]
    .clock(hqr7_clock),
    .reset(hqr7_reset),
    .io_in_a(hqr7_io_in_a),
    .io_out_s(hqr7_io_out_s)
  );
  FP_multiplier_10ccs FP_multiplier_10ccs ( // @[hh_datapath_chisel.scala 274:21]
    .clock(FP_multiplier_10ccs_clock),
    .reset(FP_multiplier_10ccs_reset),
    .io_in_a(FP_multiplier_10ccs_io_in_a),
    .io_in_b(FP_multiplier_10ccs_io_in_b),
    .io_out_s(FP_multiplier_10ccs_io_out_s)
  );
  axpy_dp axpy_dp ( // @[hh_datapath_chisel.scala 280:20]
    .clock(axpy_dp_clock),
    .reset(axpy_dp_reset),
    .io_in_a(axpy_dp_io_in_a),
    .io_in_b_0(axpy_dp_io_in_b_0),
    .io_in_b_1(axpy_dp_io_in_b_1),
    .io_in_b_2(axpy_dp_io_in_b_2),
    .io_in_b_3(axpy_dp_io_in_b_3),
    .io_in_b_4(axpy_dp_io_in_b_4),
    .io_in_b_5(axpy_dp_io_in_b_5),
    .io_in_b_6(axpy_dp_io_in_b_6),
    .io_in_b_7(axpy_dp_io_in_b_7),
    .io_in_b_8(axpy_dp_io_in_b_8),
    .io_in_b_9(axpy_dp_io_in_b_9),
    .io_in_b_10(axpy_dp_io_in_b_10),
    .io_in_b_11(axpy_dp_io_in_b_11),
    .io_in_b_12(axpy_dp_io_in_b_12),
    .io_in_b_13(axpy_dp_io_in_b_13),
    .io_in_b_14(axpy_dp_io_in_b_14),
    .io_in_b_15(axpy_dp_io_in_b_15),
    .io_in_c_0(axpy_dp_io_in_c_0),
    .io_in_c_1(axpy_dp_io_in_c_1),
    .io_in_c_2(axpy_dp_io_in_c_2),
    .io_in_c_3(axpy_dp_io_in_c_3),
    .io_in_c_4(axpy_dp_io_in_c_4),
    .io_in_c_5(axpy_dp_io_in_c_5),
    .io_in_c_6(axpy_dp_io_in_c_6),
    .io_in_c_7(axpy_dp_io_in_c_7),
    .io_in_c_8(axpy_dp_io_in_c_8),
    .io_in_c_9(axpy_dp_io_in_c_9),
    .io_in_c_10(axpy_dp_io_in_c_10),
    .io_in_c_11(axpy_dp_io_in_c_11),
    .io_in_c_12(axpy_dp_io_in_c_12),
    .io_in_c_13(axpy_dp_io_in_c_13),
    .io_in_c_14(axpy_dp_io_in_c_14),
    .io_in_c_15(axpy_dp_io_in_c_15),
    .io_out_s_0(axpy_dp_io_out_s_0),
    .io_out_s_1(axpy_dp_io_out_s_1),
    .io_out_s_2(axpy_dp_io_out_s_2),
    .io_out_s_3(axpy_dp_io_out_s_3),
    .io_out_s_4(axpy_dp_io_out_s_4),
    .io_out_s_5(axpy_dp_io_out_s_5),
    .io_out_s_6(axpy_dp_io_out_s_6),
    .io_out_s_7(axpy_dp_io_out_s_7),
    .io_out_s_8(axpy_dp_io_out_s_8),
    .io_out_s_9(axpy_dp_io_out_s_9),
    .io_out_s_10(axpy_dp_io_out_s_10),
    .io_out_s_11(axpy_dp_io_out_s_11),
    .io_out_s_12(axpy_dp_io_out_s_12),
    .io_out_s_13(axpy_dp_io_out_s_13),
    .io_out_s_14(axpy_dp_io_out_s_14),
    .io_out_s_15(axpy_dp_io_out_s_15)
  );
  assign io_hh_dout = {io_hh_dout_hi,io_hh_dout_lo}; // @[hh_datapath_chisel.scala 294:28]
  assign FP_DDOT_dp_clock = io_clk;
  assign FP_DDOT_dp_reset = io_rst;
  assign FP_DDOT_dp_io_in_a_0 = ddot_din_a_reg[511:480]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_1 = ddot_din_a_reg[479:448]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_2 = ddot_din_a_reg[447:416]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_3 = ddot_din_a_reg[415:384]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_4 = ddot_din_a_reg[383:352]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_5 = ddot_din_a_reg[351:320]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_6 = ddot_din_a_reg[319:288]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_7 = ddot_din_a_reg[287:256]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_8 = ddot_din_a_reg[255:224]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_9 = ddot_din_a_reg[223:192]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_10 = ddot_din_a_reg[191:160]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_11 = ddot_din_a_reg[159:128]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_12 = ddot_din_a_reg[127:96]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_13 = ddot_din_a_reg[95:64]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_14 = ddot_din_a_reg[63:32]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_a_15 = ddot_din_a_reg[31:0]; // @[hh_datapath_chisel.scala 255:37]
  assign FP_DDOT_dp_io_in_b_0 = ddot_din_b_reg[511:480]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_1 = ddot_din_b_reg[479:448]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_2 = ddot_din_b_reg[447:416]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_3 = ddot_din_b_reg[415:384]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_4 = ddot_din_b_reg[383:352]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_5 = ddot_din_b_reg[351:320]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_6 = ddot_din_b_reg[319:288]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_7 = ddot_din_b_reg[287:256]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_8 = ddot_din_b_reg[255:224]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_9 = ddot_din_b_reg[223:192]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_10 = ddot_din_b_reg[191:160]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_11 = ddot_din_b_reg[159:128]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_12 = ddot_din_b_reg[127:96]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_13 = ddot_din_b_reg[95:64]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_14 = ddot_din_b_reg[63:32]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_DDOT_dp_io_in_b_15 = ddot_din_b_reg[31:0]; // @[hh_datapath_chisel.scala 256:37]
  assign FP_square_root_newfpu_clock = io_clk;
  assign FP_square_root_newfpu_reset = io_rst;
  assign FP_square_root_newfpu_io_in_a = io_d1_vld ? ddot_dout : d1_reg; // @[hh_datapath_chisel.scala 175:20 176:10 178:10]
  assign hqr5_clock = io_clk;
  assign hqr5_reset = io_rst;
  assign hqr5_io_in_a = io_d1_rdy ? x1_update : x1_reg; // @[hh_datapath_chisel.scala 187:20 188:10 190:10]
  assign hqr5_io_in_b = io_d2_vld ? d2_update : d2_reg; // @[hh_datapath_chisel.scala 193:20 194:10 196:10]
  assign hqr7_clock = io_clk;
  assign hqr7_reset = io_rst;
  assign hqr7_io_in_a = io_d3_vld ? ddot_dout : d3_reg; // @[hh_datapath_chisel.scala 181:20 182:10 184:10]
  assign FP_multiplier_10ccs_clock = io_clk;
  assign FP_multiplier_10ccs_reset = io_rst;
  assign FP_multiplier_10ccs_io_in_a = io_d5_rdy ? d4_update : d4_reg; // @[hh_datapath_chisel.scala 211:20 212:10 214:10]
  assign FP_multiplier_10ccs_io_in_b = io_tk_vld ? tk_update : tk_reg; // @[hh_datapath_chisel.scala 205:20 206:10 208:10]
  assign axpy_dp_clock = io_clk;
  assign axpy_dp_reset = io_rst;
  assign axpy_dp_io_in_a = io_d5_vld ? d5_update : d5_reg; // @[hh_datapath_chisel.scala 217:20 218:10 220:10]
  assign axpy_dp_io_in_b_0 = vk[511:480]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_1 = vk[479:448]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_2 = vk[447:416]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_3 = vk[415:384]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_4 = vk[383:352]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_5 = vk[351:320]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_6 = vk[319:288]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_7 = vk[287:256]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_8 = vk[255:224]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_9 = vk[223:192]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_10 = vk[191:160]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_11 = vk[159:128]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_12 = vk[127:96]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_13 = vk[95:64]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_14 = vk[63:32]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_b_15 = vk[31:0]; // @[hh_datapath_chisel.scala 283:25]
  assign axpy_dp_io_in_c_0 = yj0[511:480]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_1 = yj0[479:448]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_2 = yj0[447:416]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_3 = yj0[415:384]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_4 = yj0[383:352]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_5 = yj0[351:320]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_6 = yj0[319:288]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_7 = yj0[287:256]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_8 = yj0[255:224]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_9 = yj0[223:192]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_10 = yj0[191:160]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_11 = yj0[159:128]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_12 = yj0[127:96]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_13 = yj0[95:64]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_14 = yj0[63:32]; // @[hh_datapath_chisel.scala 284:26]
  assign axpy_dp_io_in_c_15 = yj0[31:0]; // @[hh_datapath_chisel.scala 284:26]
  always @(posedge io_clk) begin
    if (io_rst) begin // @[hh_datapath_chisel.scala 68:17]
      yj0 <= 512'h0; // @[hh_datapath_chisel.scala 73:11]
    end else if (io_yj_sft) begin // @[hh_datapath_chisel.scala 74:26]
      yj0 <= yj_reg_4[511:0]; // @[hh_datapath_chisel.scala 79:11]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 68:17]
      yj_reg_1 <= 25728'h0; // @[hh_datapath_chisel.scala 69:16]
    end else if (io_yj_sft) begin // @[hh_datapath_chisel.scala 74:26]
      yj_reg_1 <= _yj_reg_1_T[26239:512]; // @[hh_datapath_chisel.scala 78:16]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 68:17]
      yj_reg_2 <= 25728'h0; // @[hh_datapath_chisel.scala 70:16]
    end else if (io_yj_sft) begin // @[hh_datapath_chisel.scala 74:26]
      yj_reg_2 <= _yj_reg_2_T_1[26239:512]; // @[hh_datapath_chisel.scala 77:16]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 68:17]
      yj_reg_3 <= 25728'h0; // @[hh_datapath_chisel.scala 71:16]
    end else if (io_yj_sft) begin // @[hh_datapath_chisel.scala 74:26]
      yj_reg_3 <= _yj_reg_3_T_1[26239:512]; // @[hh_datapath_chisel.scala 76:16]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 68:17]
      yj_reg_4 <= 25728'h0; // @[hh_datapath_chisel.scala 72:16]
    end else if (io_yj_sft) begin // @[hh_datapath_chisel.scala 74:26]
      yj_reg_4 <= _yj_reg_4_T_1[26239:512]; // @[hh_datapath_chisel.scala 75:16]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 113:18]
      ddot_din_a_reg <= 512'h0; // @[hh_datapath_chisel.scala 114:22]
    end else if (io_d1_rdy) begin // @[hh_datapath_chisel.scala 139:20]
      ddot_din_a_reg <= io_hh_din; // @[hh_datapath_chisel.scala 140:18]
    end else if (io_d3_rdy) begin // @[hh_datapath_chisel.scala 141:26]
      if (io_vk1_vld) begin // @[hh_datapath_chisel.scala 159:21]
        ddot_din_a_reg <= vk_update; // @[hh_datapath_chisel.scala 160:10]
      end else begin
        ddot_din_a_reg <= vk_reg; // @[hh_datapath_chisel.scala 162:10]
      end
    end else if (io_d4_rdy) begin // @[hh_datapath_chisel.scala 143:26]
      ddot_din_a_reg <= io_hh_din; // @[hh_datapath_chisel.scala 144:18]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 113:18]
      ddot_din_b_reg <= 512'h0; // @[hh_datapath_chisel.scala 115:22]
    end else if (io_d1_rdy) begin // @[hh_datapath_chisel.scala 149:20]
      ddot_din_b_reg <= io_hh_din; // @[hh_datapath_chisel.scala 150:18]
    end else if (io_d3_rdy) begin // @[hh_datapath_chisel.scala 151:26]
      ddot_din_b_reg <= vk; // @[hh_datapath_chisel.scala 152:18]
    end else if (io_d4_rdy) begin // @[hh_datapath_chisel.scala 153:26]
      ddot_din_b_reg <= vk; // @[hh_datapath_chisel.scala 154:18]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 113:18]
      vk_reg <= 512'h0; // @[hh_datapath_chisel.scala 116:14]
    end else if (io_vk1_vld) begin // @[hh_datapath_chisel.scala 159:21]
      vk_reg <= vk_update; // @[hh_datapath_chisel.scala 160:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 113:18]
      d1_reg <= 32'h0; // @[hh_datapath_chisel.scala 117:14]
    end else if (io_d1_vld) begin // @[hh_datapath_chisel.scala 175:20]
      d1_reg <= ddot_dout; // @[hh_datapath_chisel.scala 176:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 113:18]
      d3_reg <= 32'h0; // @[hh_datapath_chisel.scala 118:14]
    end else if (io_d3_vld) begin // @[hh_datapath_chisel.scala 181:20]
      d3_reg <= ddot_dout; // @[hh_datapath_chisel.scala 182:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 166:17]
      d4_update <= 32'h0; // @[hh_datapath_chisel.scala 167:17]
    end else if (io_d4_sft) begin // @[hh_datapath_chisel.scala 169:26]
      d4_update <= d4_update_reg[31:0]; // @[hh_datapath_chisel.scala 172:17]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 113:18]
      x1_reg <= 32'h0; // @[hh_datapath_chisel.scala 119:14]
    end else if (io_d1_rdy) begin // @[hh_datapath_chisel.scala 187:20]
      if (io_rst) begin // @[hh_datapath_chisel.scala 227:17]
        x1_reg <= 32'h0; // @[hh_datapath_chisel.scala 228:17]
      end else if (io_d1_rdy) begin // @[hh_datapath_chisel.scala 229:26]
        x1_reg <= _GEN_55; // @[hh_datapath_chisel.scala 230:17]
      end else begin
        x1_reg <= 32'h0; // @[hh_datapath_chisel.scala 232:17]
      end
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 113:18]
      d2_reg <= 32'h0; // @[hh_datapath_chisel.scala 120:14]
    end else if (io_d2_vld) begin // @[hh_datapath_chisel.scala 193:20]
      d2_reg <= d2_update; // @[hh_datapath_chisel.scala 194:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 113:18]
      vk1_reg <= 32'h0; // @[hh_datapath_chisel.scala 121:15]
    end else if (io_vk1_vld) begin // @[hh_datapath_chisel.scala 199:21]
      vk1_reg <= vk1_update; // @[hh_datapath_chisel.scala 200:11]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 113:18]
      tk_reg <= 32'h0; // @[hh_datapath_chisel.scala 122:14]
    end else if (io_tk_vld) begin // @[hh_datapath_chisel.scala 205:20]
      tk_reg <= tk_update; // @[hh_datapath_chisel.scala 206:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 113:18]
      d4_reg <= 32'h0; // @[hh_datapath_chisel.scala 123:14]
    end else if (io_d5_rdy) begin // @[hh_datapath_chisel.scala 211:20]
      d4_reg <= d4_update; // @[hh_datapath_chisel.scala 212:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 113:18]
      d5_reg <= 32'h0; // @[hh_datapath_chisel.scala 124:14]
    end else if (io_d5_vld) begin // @[hh_datapath_chisel.scala 217:20]
      d5_reg <= d5_update; // @[hh_datapath_chisel.scala 218:10]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 166:17]
      d4_update_reg <= 4064'h0; // @[hh_datapath_chisel.scala 168:21]
    end else if (io_d4_sft) begin // @[hh_datapath_chisel.scala 169:26]
      d4_update_reg <= _d4_update_reg_T[4095:32]; // @[hh_datapath_chisel.scala 171:21]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_0 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_0 <= axpy_dp_io_out_s_15; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_1 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_1 <= axpy_dp_io_out_s_14; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_2 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_2 <= axpy_dp_io_out_s_13; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_3 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_3 <= axpy_dp_io_out_s_12; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_4 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_4 <= axpy_dp_io_out_s_11; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_5 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_5 <= axpy_dp_io_out_s_10; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_6 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_6 <= axpy_dp_io_out_s_9; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_7 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_7 <= axpy_dp_io_out_s_8; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_8 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_8 <= axpy_dp_io_out_s_7; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_9 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_9 <= axpy_dp_io_out_s_6; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_10 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_10 <= axpy_dp_io_out_s_5; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_11 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_11 <= axpy_dp_io_out_s_4; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_12 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_12 <= axpy_dp_io_out_s_3; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_13 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_13 <= axpy_dp_io_out_s_2; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_14 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_14 <= axpy_dp_io_out_s_1; // @[hh_datapath_chisel.scala 292:36]
    end
    if (io_rst) begin // @[hh_datapath_chisel.scala 287:16]
      myAxpyVec_15 <= 32'h0; // @[hh_datapath_chisel.scala 289:36]
    end else begin
      myAxpyVec_15 <= axpy_dp_io_out_s_0; // @[hh_datapath_chisel.scala 292:36]
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
  _RAND_0 = {16{`RANDOM}};
  yj0 = _RAND_0[511:0];
  _RAND_1 = {804{`RANDOM}};
  yj_reg_1 = _RAND_1[25727:0];
  _RAND_2 = {804{`RANDOM}};
  yj_reg_2 = _RAND_2[25727:0];
  _RAND_3 = {804{`RANDOM}};
  yj_reg_3 = _RAND_3[25727:0];
  _RAND_4 = {804{`RANDOM}};
  yj_reg_4 = _RAND_4[25727:0];
  _RAND_5 = {16{`RANDOM}};
  ddot_din_a_reg = _RAND_5[511:0];
  _RAND_6 = {16{`RANDOM}};
  ddot_din_b_reg = _RAND_6[511:0];
  _RAND_7 = {16{`RANDOM}};
  vk_reg = _RAND_7[511:0];
  _RAND_8 = {1{`RANDOM}};
  d1_reg = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  d3_reg = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  d4_update = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  x1_reg = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  d2_reg = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  vk1_reg = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  tk_reg = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  d4_reg = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  d5_reg = _RAND_16[31:0];
  _RAND_17 = {127{`RANDOM}};
  d4_update_reg = _RAND_17[4063:0];
  _RAND_18 = {1{`RANDOM}};
  myAxpyVec_0 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  myAxpyVec_1 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  myAxpyVec_2 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  myAxpyVec_3 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  myAxpyVec_4 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  myAxpyVec_5 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  myAxpyVec_6 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  myAxpyVec_7 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  myAxpyVec_8 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  myAxpyVec_9 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  myAxpyVec_10 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  myAxpyVec_11 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  myAxpyVec_12 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  myAxpyVec_13 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  myAxpyVec_14 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  myAxpyVec_15 = _RAND_33[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module hh_core(
  input          io_clk,
  input          io_rst,
  input  [15:0]  io_hh_cnt,
  input          io_d1_rdy,
  input          io_d1_vld,
  input          io_d2_vld,
  input          io_vk1_vld,
  input          io_d3_rdy,
  input          io_d3_vld,
  input          io_tk_vld,
  input          io_d4_rdy,
  input          io_d5_rdy,
  input          io_d5_vld,
  input          io_yj_sft,
  input          io_d4_sft,
  input          io_hh_st,
  input          io_dmx0_mem_ena,
  input  [31:0]  io_dmx0_mem_wea,
  input  [2:0]   io_dmx0_mem_addra,
  input  [255:0] io_dmx0_mem_dina,
  input          io_dmx0_mem_enb,
  input  [2:0]   io_dmx0_mem_addrb,
  output [255:0] io_dmx0_mem_doutb,
  input          io_dmx1_mem_ena,
  input  [31:0]  io_dmx1_mem_wea,
  input  [2:0]   io_dmx1_mem_addra,
  input  [255:0] io_dmx1_mem_dina,
  input          io_dmx1_mem_enb,
  input  [2:0]   io_dmx1_mem_addrb,
  output [255:0] io_dmx1_mem_doutb,
  input          io_rtri_mem_ena,
  input  [31:0]  io_rtri_mem_wea,
  input  [2:0]   io_rtri_mem_addra,
  input  [255:0] io_rtri_mem_dina,
  input          io_rtri_mem_enb,
  input  [2:0]   io_rtri_mem_addrb,
  output [255:0] io_rtri_mem_doutb,
  output [511:0] io_hh_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [511:0] _RAND_2;
  reg [511:0] _RAND_3;
  reg [511:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire  simple_dual_clka; // @[hh_core.scala 165:31]
  wire  simple_dual_clkb; // @[hh_core.scala 165:31]
  wire  simple_dual_ena; // @[hh_core.scala 165:31]
  wire  simple_dual_enb; // @[hh_core.scala 165:31]
  wire [31:0] simple_dual_wea; // @[hh_core.scala 165:31]
  wire [2:0] simple_dual_addra; // @[hh_core.scala 165:31]
  wire [2:0] simple_dual_addrb; // @[hh_core.scala 165:31]
  wire [255:0] simple_dual_dina; // @[hh_core.scala 165:31]
  wire [255:0] simple_dual_doutb; // @[hh_core.scala 165:31]
  wire  simple_dual_1_clka; // @[hh_core.scala 177:31]
  wire  simple_dual_1_clkb; // @[hh_core.scala 177:31]
  wire  simple_dual_1_ena; // @[hh_core.scala 177:31]
  wire  simple_dual_1_enb; // @[hh_core.scala 177:31]
  wire [31:0] simple_dual_1_wea; // @[hh_core.scala 177:31]
  wire [2:0] simple_dual_1_addra; // @[hh_core.scala 177:31]
  wire [2:0] simple_dual_1_addrb; // @[hh_core.scala 177:31]
  wire [255:0] simple_dual_1_dina; // @[hh_core.scala 177:31]
  wire [255:0] simple_dual_1_doutb; // @[hh_core.scala 177:31]
  wire  simple_dual_2_clka; // @[hh_core.scala 188:31]
  wire  simple_dual_2_clkb; // @[hh_core.scala 188:31]
  wire  simple_dual_2_ena; // @[hh_core.scala 188:31]
  wire  simple_dual_2_enb; // @[hh_core.scala 188:31]
  wire [31:0] simple_dual_2_wea; // @[hh_core.scala 188:31]
  wire [2:0] simple_dual_2_addra; // @[hh_core.scala 188:31]
  wire [2:0] simple_dual_2_addrb; // @[hh_core.scala 188:31]
  wire [255:0] simple_dual_2_dina; // @[hh_core.scala 188:31]
  wire [255:0] simple_dual_2_doutb; // @[hh_core.scala 188:31]
  wire  u_hh_datapath_io_clk; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_rst; // @[hh_core.scala 199:38]
  wire [15:0] u_hh_datapath_io_hh_cnt; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_d1_rdy; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_d1_vld; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_d2_vld; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_vk1_vld; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_d3_rdy; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_d3_vld; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_tk_vld; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_d4_rdy; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_d5_rdy; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_d5_vld; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_yj_sft; // @[hh_core.scala 199:38]
  wire  u_hh_datapath_io_d4_sft; // @[hh_core.scala 199:38]
  wire [511:0] u_hh_datapath_io_hh_din; // @[hh_core.scala 199:38]
  wire [511:0] u_hh_datapath_io_hh_dout; // @[hh_core.scala 199:38]
  reg  hh0_din_rdy; // @[hh_core.scala 81:34]
  reg  hh1_din_rdy; // @[hh_core.scala 82:34]
  reg [511:0] hh_din_reg; // @[hh_core.scala 84:33]
  reg [511:0] hh_din; // @[hh_core.scala 87:29]
  wire  _T = hh0_din_rdy | hh1_din_rdy; // @[hh_core.scala 102:30]
  wire [16:0] _myTriMemVec2_7_T = {{1'd0}, io_hh_cnt}; // @[hh_core.scala 129:74]
  wire [31:0] myTriMemVec_7 = io_rtri_mem_doutb[31:0]; // @[hh_core.scala 124:52]
  wire [31:0] myTriMemVec_6 = io_rtri_mem_doutb[63:32]; // @[hh_core.scala 124:52]
  wire [31:0] myTriMemVec_5 = io_rtri_mem_doutb[95:64]; // @[hh_core.scala 124:52]
  wire [31:0] myTriMemVec_4 = io_rtri_mem_doutb[127:96]; // @[hh_core.scala 124:52]
  wire [31:0] myTriMemVec_3 = io_rtri_mem_doutb[159:128]; // @[hh_core.scala 124:52]
  wire [31:0] myTriMemVec_2 = io_rtri_mem_doutb[191:160]; // @[hh_core.scala 124:52]
  wire [31:0] myTriMemVec_1 = io_rtri_mem_doutb[223:192]; // @[hh_core.scala 124:52]
  wire [31:0] myTriMemVec_0 = io_rtri_mem_doutb[255:224]; // @[hh_core.scala 124:52]
  wire [31:0] _GEN_8 = 3'h1 == _myTriMemVec2_7_T[2:0] ? myTriMemVec_1 : myTriMemVec_0; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_9 = 3'h2 == _myTriMemVec2_7_T[2:0] ? myTriMemVec_2 : _GEN_8; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_10 = 3'h3 == _myTriMemVec2_7_T[2:0] ? myTriMemVec_3 : _GEN_9; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_11 = 3'h4 == _myTriMemVec2_7_T[2:0] ? myTriMemVec_4 : _GEN_10; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_12 = 3'h5 == _myTriMemVec2_7_T[2:0] ? myTriMemVec_5 : _GEN_11; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_13 = 3'h6 == _myTriMemVec2_7_T[2:0] ? myTriMemVec_6 : _GEN_12; // @[hh_core.scala 129:{54,54}]
  wire [31:0] myTriMemVec2_7 = 3'h7 == _myTriMemVec2_7_T[2:0] ? myTriMemVec_7 : _GEN_13; // @[hh_core.scala 129:{54,54}]
  wire [15:0] _myTriMemVec2_6_T_1 = 16'h1 + io_hh_cnt; // @[hh_core.scala 129:74]
  wire [31:0] _GEN_16 = 3'h1 == _myTriMemVec2_6_T_1[2:0] ? myTriMemVec_1 : myTriMemVec_0; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_17 = 3'h2 == _myTriMemVec2_6_T_1[2:0] ? myTriMemVec_2 : _GEN_16; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_18 = 3'h3 == _myTriMemVec2_6_T_1[2:0] ? myTriMemVec_3 : _GEN_17; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_19 = 3'h4 == _myTriMemVec2_6_T_1[2:0] ? myTriMemVec_4 : _GEN_18; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_20 = 3'h5 == _myTriMemVec2_6_T_1[2:0] ? myTriMemVec_5 : _GEN_19; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_21 = 3'h6 == _myTriMemVec2_6_T_1[2:0] ? myTriMemVec_6 : _GEN_20; // @[hh_core.scala 129:{54,54}]
  wire [31:0] myTriMemVec2_6 = 3'h7 == _myTriMemVec2_6_T_1[2:0] ? myTriMemVec_7 : _GEN_21; // @[hh_core.scala 129:{54,54}]
  wire [15:0] _myTriMemVec2_5_T_1 = 16'h2 + io_hh_cnt; // @[hh_core.scala 129:74]
  wire [31:0] _GEN_24 = 3'h1 == _myTriMemVec2_5_T_1[2:0] ? myTriMemVec_1 : myTriMemVec_0; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_25 = 3'h2 == _myTriMemVec2_5_T_1[2:0] ? myTriMemVec_2 : _GEN_24; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_26 = 3'h3 == _myTriMemVec2_5_T_1[2:0] ? myTriMemVec_3 : _GEN_25; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_27 = 3'h4 == _myTriMemVec2_5_T_1[2:0] ? myTriMemVec_4 : _GEN_26; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_28 = 3'h5 == _myTriMemVec2_5_T_1[2:0] ? myTriMemVec_5 : _GEN_27; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_29 = 3'h6 == _myTriMemVec2_5_T_1[2:0] ? myTriMemVec_6 : _GEN_28; // @[hh_core.scala 129:{54,54}]
  wire [31:0] myTriMemVec2_5 = 3'h7 == _myTriMemVec2_5_T_1[2:0] ? myTriMemVec_7 : _GEN_29; // @[hh_core.scala 129:{54,54}]
  wire [15:0] _myTriMemVec2_4_T_1 = 16'h3 + io_hh_cnt; // @[hh_core.scala 129:74]
  wire [31:0] _GEN_32 = 3'h1 == _myTriMemVec2_4_T_1[2:0] ? myTriMemVec_1 : myTriMemVec_0; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_33 = 3'h2 == _myTriMemVec2_4_T_1[2:0] ? myTriMemVec_2 : _GEN_32; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_34 = 3'h3 == _myTriMemVec2_4_T_1[2:0] ? myTriMemVec_3 : _GEN_33; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_35 = 3'h4 == _myTriMemVec2_4_T_1[2:0] ? myTriMemVec_4 : _GEN_34; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_36 = 3'h5 == _myTriMemVec2_4_T_1[2:0] ? myTriMemVec_5 : _GEN_35; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_37 = 3'h6 == _myTriMemVec2_4_T_1[2:0] ? myTriMemVec_6 : _GEN_36; // @[hh_core.scala 129:{54,54}]
  wire [31:0] myTriMemVec2_4 = 3'h7 == _myTriMemVec2_4_T_1[2:0] ? myTriMemVec_7 : _GEN_37; // @[hh_core.scala 129:{54,54}]
  wire [15:0] _myTriMemVec2_3_T_1 = 16'h4 + io_hh_cnt; // @[hh_core.scala 129:74]
  wire [31:0] _GEN_40 = 3'h1 == _myTriMemVec2_3_T_1[2:0] ? myTriMemVec_1 : myTriMemVec_0; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_41 = 3'h2 == _myTriMemVec2_3_T_1[2:0] ? myTriMemVec_2 : _GEN_40; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_42 = 3'h3 == _myTriMemVec2_3_T_1[2:0] ? myTriMemVec_3 : _GEN_41; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_43 = 3'h4 == _myTriMemVec2_3_T_1[2:0] ? myTriMemVec_4 : _GEN_42; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_44 = 3'h5 == _myTriMemVec2_3_T_1[2:0] ? myTriMemVec_5 : _GEN_43; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_45 = 3'h6 == _myTriMemVec2_3_T_1[2:0] ? myTriMemVec_6 : _GEN_44; // @[hh_core.scala 129:{54,54}]
  wire [31:0] myTriMemVec2_3 = 3'h7 == _myTriMemVec2_3_T_1[2:0] ? myTriMemVec_7 : _GEN_45; // @[hh_core.scala 129:{54,54}]
  wire [15:0] _myTriMemVec2_2_T_1 = 16'h5 + io_hh_cnt; // @[hh_core.scala 129:74]
  wire [31:0] _GEN_48 = 3'h1 == _myTriMemVec2_2_T_1[2:0] ? myTriMemVec_1 : myTriMemVec_0; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_49 = 3'h2 == _myTriMemVec2_2_T_1[2:0] ? myTriMemVec_2 : _GEN_48; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_50 = 3'h3 == _myTriMemVec2_2_T_1[2:0] ? myTriMemVec_3 : _GEN_49; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_51 = 3'h4 == _myTriMemVec2_2_T_1[2:0] ? myTriMemVec_4 : _GEN_50; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_52 = 3'h5 == _myTriMemVec2_2_T_1[2:0] ? myTriMemVec_5 : _GEN_51; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_53 = 3'h6 == _myTriMemVec2_2_T_1[2:0] ? myTriMemVec_6 : _GEN_52; // @[hh_core.scala 129:{54,54}]
  wire [31:0] myTriMemVec2_2 = 3'h7 == _myTriMemVec2_2_T_1[2:0] ? myTriMemVec_7 : _GEN_53; // @[hh_core.scala 129:{54,54}]
  wire [15:0] _myTriMemVec2_1_T_1 = 16'h6 + io_hh_cnt; // @[hh_core.scala 129:74]
  wire [31:0] _GEN_56 = 3'h1 == _myTriMemVec2_1_T_1[2:0] ? myTriMemVec_1 : myTriMemVec_0; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_57 = 3'h2 == _myTriMemVec2_1_T_1[2:0] ? myTriMemVec_2 : _GEN_56; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_58 = 3'h3 == _myTriMemVec2_1_T_1[2:0] ? myTriMemVec_3 : _GEN_57; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_59 = 3'h4 == _myTriMemVec2_1_T_1[2:0] ? myTriMemVec_4 : _GEN_58; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_60 = 3'h5 == _myTriMemVec2_1_T_1[2:0] ? myTriMemVec_5 : _GEN_59; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_61 = 3'h6 == _myTriMemVec2_1_T_1[2:0] ? myTriMemVec_6 : _GEN_60; // @[hh_core.scala 129:{54,54}]
  wire [31:0] myTriMemVec2_1 = 3'h7 == _myTriMemVec2_1_T_1[2:0] ? myTriMemVec_7 : _GEN_61; // @[hh_core.scala 129:{54,54}]
  wire [15:0] _myTriMemVec2_0_T_1 = 16'h7 + io_hh_cnt; // @[hh_core.scala 129:74]
  wire [31:0] _GEN_64 = 3'h1 == _myTriMemVec2_0_T_1[2:0] ? myTriMemVec_1 : myTriMemVec_0; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_65 = 3'h2 == _myTriMemVec2_0_T_1[2:0] ? myTriMemVec_2 : _GEN_64; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_66 = 3'h3 == _myTriMemVec2_0_T_1[2:0] ? myTriMemVec_3 : _GEN_65; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_67 = 3'h4 == _myTriMemVec2_0_T_1[2:0] ? myTriMemVec_4 : _GEN_66; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_68 = 3'h5 == _myTriMemVec2_0_T_1[2:0] ? myTriMemVec_5 : _GEN_67; // @[hh_core.scala 129:{54,54}]
  wire [31:0] _GEN_69 = 3'h6 == _myTriMemVec2_0_T_1[2:0] ? myTriMemVec_6 : _GEN_68; // @[hh_core.scala 129:{54,54}]
  wire [31:0] myTriMemVec2_0 = 3'h7 == _myTriMemVec2_0_T_1[2:0] ? myTriMemVec_7 : _GEN_69; // @[hh_core.scala 129:{54,54}]
  wire [255:0] myTriMemWire = {myTriMemVec2_7,myTriMemVec2_6,myTriMemVec2_5,myTriMemVec2_4,myTriMemVec2_3,myTriMemVec2_2
    ,myTriMemVec2_1,myTriMemVec2_0}; // @[hh_core.scala 133:42]
  wire [21:0] _hh_din_update_T = io_hh_cnt * 6'h20; // @[hh_core.scala 136:65]
  wire [255:0] _hh_din_update_T_1 = myTriMemWire >> _hh_din_update_T; // @[hh_core.scala 136:52]
  wire [255:0] _GEN_5 = hh1_din_rdy ? io_dmx1_mem_doutb : 256'h0; // @[hh_core.scala 115:36 116:31 118:31]
  wire [255:0] dmx_mem_doutb = hh0_din_rdy ? io_dmx0_mem_doutb : _GEN_5; // @[hh_core.scala 113:30 114:31]
  wire [511:0] _hh_din_update_T_2 = {_hh_din_update_T_1,dmx_mem_doutb}; // @[Cat.scala 31:58]
  reg [511:0] hh_dout_update_REG; // @[hh_core.scala 160:42]
  wire [511:0] _hh_dout_update_T_1 = hh_dout_update_REG >> _hh_din_update_T; // @[hh_core.scala 160:57]
  wire [511:0] _GEN_329 = io_hh_st ? _hh_dout_update_T_1 : hh_din_reg; // @[hh_core.scala 159:33 160:32 162:32]
  wire [31:0] myHhdoutVec_0 = io_hh_dout[511:480]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_1 = io_hh_dout[479:448]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_2 = io_hh_dout[447:416]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_3 = io_hh_dout[415:384]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_4 = io_hh_dout[383:352]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_5 = io_hh_dout[351:320]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_6 = io_hh_dout[319:288]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_7 = io_hh_dout[287:256]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_8 = io_hh_dout[255:224]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_9 = io_hh_dout[223:192]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_10 = io_hh_dout[191:160]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_11 = io_hh_dout[159:128]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_12 = io_hh_dout[127:96]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_13 = io_hh_dout[95:64]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_14 = io_hh_dout[63:32]; // @[hh_core.scala 146:45]
  wire [31:0] myHhdoutVec_15 = io_hh_dout[31:0]; // @[hh_core.scala 146:45]
  wire [15:0] _myHhdoutVec2_15_T_3 = _myTriMemVec2_7_T[15:0] + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_74 = 4'h1 == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_75 = 4'h2 == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_2 : _GEN_74; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_76 = 4'h3 == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_3 : _GEN_75; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_77 = 4'h4 == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_4 : _GEN_76; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_78 = 4'h5 == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_5 : _GEN_77; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_79 = 4'h6 == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_6 : _GEN_78; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_80 = 4'h7 == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_7 : _GEN_79; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_81 = 4'h8 == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_8 : _GEN_80; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_82 = 4'h9 == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_9 : _GEN_81; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_83 = 4'ha == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_10 : _GEN_82; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_84 = 4'hb == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_11 : _GEN_83; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_85 = 4'hc == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_12 : _GEN_84; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_86 = 4'hd == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_13 : _GEN_85; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_87 = 4'he == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_14 : _GEN_86; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_15 = 4'hf == _myHhdoutVec2_15_T_3[3:0] ? myHhdoutVec_15 : _GEN_87; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_14_T_3 = _myTriMemVec2_6_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_90 = 4'h1 == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_91 = 4'h2 == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_2 : _GEN_90; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_92 = 4'h3 == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_3 : _GEN_91; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_93 = 4'h4 == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_4 : _GEN_92; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_94 = 4'h5 == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_5 : _GEN_93; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_95 = 4'h6 == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_6 : _GEN_94; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_96 = 4'h7 == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_7 : _GEN_95; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_97 = 4'h8 == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_8 : _GEN_96; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_98 = 4'h9 == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_9 : _GEN_97; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_99 = 4'ha == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_10 : _GEN_98; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_100 = 4'hb == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_11 : _GEN_99; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_101 = 4'hc == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_12 : _GEN_100; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_102 = 4'hd == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_13 : _GEN_101; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_103 = 4'he == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_14 : _GEN_102; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_14 = 4'hf == _myHhdoutVec2_14_T_3[3:0] ? myHhdoutVec_15 : _GEN_103; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_13_T_3 = _myTriMemVec2_5_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_106 = 4'h1 == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_107 = 4'h2 == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_2 : _GEN_106; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_108 = 4'h3 == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_3 : _GEN_107; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_109 = 4'h4 == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_4 : _GEN_108; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_110 = 4'h5 == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_5 : _GEN_109; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_111 = 4'h6 == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_6 : _GEN_110; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_112 = 4'h7 == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_7 : _GEN_111; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_113 = 4'h8 == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_8 : _GEN_112; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_114 = 4'h9 == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_9 : _GEN_113; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_115 = 4'ha == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_10 : _GEN_114; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_116 = 4'hb == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_11 : _GEN_115; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_117 = 4'hc == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_12 : _GEN_116; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_118 = 4'hd == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_13 : _GEN_117; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_119 = 4'he == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_14 : _GEN_118; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_13 = 4'hf == _myHhdoutVec2_13_T_3[3:0] ? myHhdoutVec_15 : _GEN_119; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_12_T_3 = _myTriMemVec2_4_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_122 = 4'h1 == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_123 = 4'h2 == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_2 : _GEN_122; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_124 = 4'h3 == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_3 : _GEN_123; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_125 = 4'h4 == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_4 : _GEN_124; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_126 = 4'h5 == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_5 : _GEN_125; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_127 = 4'h6 == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_6 : _GEN_126; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_128 = 4'h7 == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_7 : _GEN_127; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_129 = 4'h8 == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_8 : _GEN_128; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_130 = 4'h9 == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_9 : _GEN_129; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_131 = 4'ha == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_10 : _GEN_130; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_132 = 4'hb == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_11 : _GEN_131; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_133 = 4'hc == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_12 : _GEN_132; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_134 = 4'hd == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_13 : _GEN_133; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_135 = 4'he == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_14 : _GEN_134; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_12 = 4'hf == _myHhdoutVec2_12_T_3[3:0] ? myHhdoutVec_15 : _GEN_135; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_11_T_3 = _myTriMemVec2_3_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_138 = 4'h1 == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_139 = 4'h2 == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_2 : _GEN_138; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_140 = 4'h3 == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_3 : _GEN_139; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_141 = 4'h4 == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_4 : _GEN_140; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_142 = 4'h5 == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_5 : _GEN_141; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_143 = 4'h6 == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_6 : _GEN_142; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_144 = 4'h7 == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_7 : _GEN_143; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_145 = 4'h8 == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_8 : _GEN_144; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_146 = 4'h9 == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_9 : _GEN_145; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_147 = 4'ha == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_10 : _GEN_146; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_148 = 4'hb == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_11 : _GEN_147; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_149 = 4'hc == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_12 : _GEN_148; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_150 = 4'hd == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_13 : _GEN_149; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_151 = 4'he == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_14 : _GEN_150; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_11 = 4'hf == _myHhdoutVec2_11_T_3[3:0] ? myHhdoutVec_15 : _GEN_151; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_10_T_3 = _myTriMemVec2_2_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_154 = 4'h1 == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_155 = 4'h2 == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_2 : _GEN_154; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_156 = 4'h3 == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_3 : _GEN_155; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_157 = 4'h4 == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_4 : _GEN_156; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_158 = 4'h5 == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_5 : _GEN_157; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_159 = 4'h6 == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_6 : _GEN_158; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_160 = 4'h7 == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_7 : _GEN_159; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_161 = 4'h8 == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_8 : _GEN_160; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_162 = 4'h9 == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_9 : _GEN_161; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_163 = 4'ha == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_10 : _GEN_162; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_164 = 4'hb == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_11 : _GEN_163; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_165 = 4'hc == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_12 : _GEN_164; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_166 = 4'hd == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_13 : _GEN_165; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_167 = 4'he == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_14 : _GEN_166; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_10 = 4'hf == _myHhdoutVec2_10_T_3[3:0] ? myHhdoutVec_15 : _GEN_167; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_9_T_3 = _myTriMemVec2_1_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_170 = 4'h1 == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_171 = 4'h2 == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_2 : _GEN_170; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_172 = 4'h3 == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_3 : _GEN_171; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_173 = 4'h4 == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_4 : _GEN_172; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_174 = 4'h5 == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_5 : _GEN_173; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_175 = 4'h6 == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_6 : _GEN_174; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_176 = 4'h7 == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_7 : _GEN_175; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_177 = 4'h8 == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_8 : _GEN_176; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_178 = 4'h9 == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_9 : _GEN_177; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_179 = 4'ha == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_10 : _GEN_178; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_180 = 4'hb == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_11 : _GEN_179; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_181 = 4'hc == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_12 : _GEN_180; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_182 = 4'hd == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_13 : _GEN_181; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_183 = 4'he == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_14 : _GEN_182; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_9 = 4'hf == _myHhdoutVec2_9_T_3[3:0] ? myHhdoutVec_15 : _GEN_183; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_8_T_3 = _myTriMemVec2_0_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_186 = 4'h1 == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_187 = 4'h2 == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_2 : _GEN_186; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_188 = 4'h3 == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_3 : _GEN_187; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_189 = 4'h4 == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_4 : _GEN_188; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_190 = 4'h5 == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_5 : _GEN_189; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_191 = 4'h6 == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_6 : _GEN_190; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_192 = 4'h7 == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_7 : _GEN_191; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_193 = 4'h8 == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_8 : _GEN_192; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_194 = 4'h9 == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_9 : _GEN_193; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_195 = 4'ha == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_10 : _GEN_194; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_196 = 4'hb == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_11 : _GEN_195; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_197 = 4'hc == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_12 : _GEN_196; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_198 = 4'hd == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_13 : _GEN_197; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_199 = 4'he == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_14 : _GEN_198; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_8 = 4'hf == _myHhdoutVec2_8_T_3[3:0] ? myHhdoutVec_15 : _GEN_199; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_7_T_1 = 16'h8 + io_hh_cnt; // @[hh_core.scala 151:72]
  wire [15:0] _myHhdoutVec2_7_T_3 = _myHhdoutVec2_7_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_202 = 4'h1 == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_203 = 4'h2 == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_2 : _GEN_202; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_204 = 4'h3 == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_3 : _GEN_203; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_205 = 4'h4 == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_4 : _GEN_204; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_206 = 4'h5 == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_5 : _GEN_205; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_207 = 4'h6 == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_6 : _GEN_206; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_208 = 4'h7 == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_7 : _GEN_207; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_209 = 4'h8 == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_8 : _GEN_208; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_210 = 4'h9 == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_9 : _GEN_209; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_211 = 4'ha == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_10 : _GEN_210; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_212 = 4'hb == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_11 : _GEN_211; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_213 = 4'hc == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_12 : _GEN_212; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_214 = 4'hd == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_13 : _GEN_213; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_215 = 4'he == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_14 : _GEN_214; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_7 = 4'hf == _myHhdoutVec2_7_T_3[3:0] ? myHhdoutVec_15 : _GEN_215; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_6_T_1 = 16'h9 + io_hh_cnt; // @[hh_core.scala 151:72]
  wire [15:0] _myHhdoutVec2_6_T_3 = _myHhdoutVec2_6_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_218 = 4'h1 == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_219 = 4'h2 == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_2 : _GEN_218; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_220 = 4'h3 == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_3 : _GEN_219; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_221 = 4'h4 == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_4 : _GEN_220; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_222 = 4'h5 == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_5 : _GEN_221; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_223 = 4'h6 == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_6 : _GEN_222; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_224 = 4'h7 == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_7 : _GEN_223; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_225 = 4'h8 == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_8 : _GEN_224; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_226 = 4'h9 == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_9 : _GEN_225; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_227 = 4'ha == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_10 : _GEN_226; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_228 = 4'hb == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_11 : _GEN_227; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_229 = 4'hc == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_12 : _GEN_228; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_230 = 4'hd == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_13 : _GEN_229; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_231 = 4'he == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_14 : _GEN_230; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_6 = 4'hf == _myHhdoutVec2_6_T_3[3:0] ? myHhdoutVec_15 : _GEN_231; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_5_T_1 = 16'ha + io_hh_cnt; // @[hh_core.scala 151:72]
  wire [15:0] _myHhdoutVec2_5_T_3 = _myHhdoutVec2_5_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_234 = 4'h1 == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_235 = 4'h2 == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_2 : _GEN_234; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_236 = 4'h3 == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_3 : _GEN_235; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_237 = 4'h4 == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_4 : _GEN_236; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_238 = 4'h5 == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_5 : _GEN_237; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_239 = 4'h6 == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_6 : _GEN_238; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_240 = 4'h7 == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_7 : _GEN_239; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_241 = 4'h8 == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_8 : _GEN_240; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_242 = 4'h9 == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_9 : _GEN_241; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_243 = 4'ha == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_10 : _GEN_242; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_244 = 4'hb == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_11 : _GEN_243; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_245 = 4'hc == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_12 : _GEN_244; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_246 = 4'hd == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_13 : _GEN_245; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_247 = 4'he == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_14 : _GEN_246; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_5 = 4'hf == _myHhdoutVec2_5_T_3[3:0] ? myHhdoutVec_15 : _GEN_247; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_4_T_1 = 16'hb + io_hh_cnt; // @[hh_core.scala 151:72]
  wire [15:0] _myHhdoutVec2_4_T_3 = _myHhdoutVec2_4_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_250 = 4'h1 == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_251 = 4'h2 == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_2 : _GEN_250; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_252 = 4'h3 == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_3 : _GEN_251; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_253 = 4'h4 == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_4 : _GEN_252; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_254 = 4'h5 == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_5 : _GEN_253; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_255 = 4'h6 == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_6 : _GEN_254; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_256 = 4'h7 == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_7 : _GEN_255; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_257 = 4'h8 == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_8 : _GEN_256; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_258 = 4'h9 == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_9 : _GEN_257; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_259 = 4'ha == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_10 : _GEN_258; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_260 = 4'hb == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_11 : _GEN_259; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_261 = 4'hc == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_12 : _GEN_260; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_262 = 4'hd == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_13 : _GEN_261; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_263 = 4'he == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_14 : _GEN_262; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_4 = 4'hf == _myHhdoutVec2_4_T_3[3:0] ? myHhdoutVec_15 : _GEN_263; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_3_T_1 = 16'hc + io_hh_cnt; // @[hh_core.scala 151:72]
  wire [15:0] _myHhdoutVec2_3_T_3 = _myHhdoutVec2_3_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_266 = 4'h1 == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_267 = 4'h2 == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_2 : _GEN_266; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_268 = 4'h3 == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_3 : _GEN_267; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_269 = 4'h4 == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_4 : _GEN_268; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_270 = 4'h5 == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_5 : _GEN_269; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_271 = 4'h6 == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_6 : _GEN_270; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_272 = 4'h7 == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_7 : _GEN_271; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_273 = 4'h8 == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_8 : _GEN_272; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_274 = 4'h9 == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_9 : _GEN_273; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_275 = 4'ha == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_10 : _GEN_274; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_276 = 4'hb == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_11 : _GEN_275; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_277 = 4'hc == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_12 : _GEN_276; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_278 = 4'hd == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_13 : _GEN_277; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_279 = 4'he == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_14 : _GEN_278; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_3 = 4'hf == _myHhdoutVec2_3_T_3[3:0] ? myHhdoutVec_15 : _GEN_279; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_2_T_1 = 16'hd + io_hh_cnt; // @[hh_core.scala 151:72]
  wire [15:0] _myHhdoutVec2_2_T_3 = _myHhdoutVec2_2_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_282 = 4'h1 == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_283 = 4'h2 == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_2 : _GEN_282; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_284 = 4'h3 == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_3 : _GEN_283; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_285 = 4'h4 == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_4 : _GEN_284; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_286 = 4'h5 == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_5 : _GEN_285; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_287 = 4'h6 == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_6 : _GEN_286; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_288 = 4'h7 == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_7 : _GEN_287; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_289 = 4'h8 == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_8 : _GEN_288; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_290 = 4'h9 == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_9 : _GEN_289; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_291 = 4'ha == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_10 : _GEN_290; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_292 = 4'hb == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_11 : _GEN_291; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_293 = 4'hc == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_12 : _GEN_292; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_294 = 4'hd == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_13 : _GEN_293; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_295 = 4'he == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_14 : _GEN_294; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_2 = 4'hf == _myHhdoutVec2_2_T_3[3:0] ? myHhdoutVec_15 : _GEN_295; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_1_T_1 = 16'he + io_hh_cnt; // @[hh_core.scala 151:72]
  wire [15:0] _myHhdoutVec2_1_T_3 = _myHhdoutVec2_1_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_298 = 4'h1 == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_299 = 4'h2 == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_2 : _GEN_298; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_300 = 4'h3 == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_3 : _GEN_299; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_301 = 4'h4 == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_4 : _GEN_300; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_302 = 4'h5 == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_5 : _GEN_301; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_303 = 4'h6 == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_6 : _GEN_302; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_304 = 4'h7 == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_7 : _GEN_303; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_305 = 4'h8 == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_8 : _GEN_304; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_306 = 4'h9 == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_9 : _GEN_305; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_307 = 4'ha == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_10 : _GEN_306; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_308 = 4'hb == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_11 : _GEN_307; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_309 = 4'hc == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_12 : _GEN_308; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_310 = 4'hd == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_13 : _GEN_309; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_311 = 4'he == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_14 : _GEN_310; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_1 = 4'hf == _myHhdoutVec2_1_T_3[3:0] ? myHhdoutVec_15 : _GEN_311; // @[hh_core.scala 151:{52,52}]
  wire [15:0] _myHhdoutVec2_0_T_1 = 16'hf + io_hh_cnt; // @[hh_core.scala 151:72]
  wire [15:0] _myHhdoutVec2_0_T_3 = _myHhdoutVec2_0_T_1 + 16'h1; // @[hh_core.scala 151:84]
  wire [31:0] _GEN_314 = 4'h1 == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_1 : myHhdoutVec_0; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_315 = 4'h2 == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_2 : _GEN_314; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_316 = 4'h3 == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_3 : _GEN_315; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_317 = 4'h4 == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_4 : _GEN_316; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_318 = 4'h5 == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_5 : _GEN_317; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_319 = 4'h6 == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_6 : _GEN_318; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_320 = 4'h7 == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_7 : _GEN_319; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_321 = 4'h8 == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_8 : _GEN_320; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_322 = 4'h9 == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_9 : _GEN_321; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_323 = 4'ha == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_10 : _GEN_322; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_324 = 4'hb == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_11 : _GEN_323; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_325 = 4'hc == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_12 : _GEN_324; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_326 = 4'hd == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_13 : _GEN_325; // @[hh_core.scala 151:{52,52}]
  wire [31:0] _GEN_327 = 4'he == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_14 : _GEN_326; // @[hh_core.scala 151:{52,52}]
  wire [31:0] myHhdoutVec2_0 = 4'hf == _myHhdoutVec2_0_T_3[3:0] ? myHhdoutVec_15 : _GEN_327; // @[hh_core.scala 151:{52,52}]
  wire [255:0] myHhdoutWire_lo = {myHhdoutVec2_7,myHhdoutVec2_6,myHhdoutVec2_5,myHhdoutVec2_4,myHhdoutVec2_3,
    myHhdoutVec2_2,myHhdoutVec2_1,myHhdoutVec2_0}; // @[hh_core.scala 155:42]
  wire [255:0] myHhdoutWire_hi = {myHhdoutVec2_15,myHhdoutVec2_14,myHhdoutVec2_13,myHhdoutVec2_12,myHhdoutVec2_11,
    myHhdoutVec2_10,myHhdoutVec2_9,myHhdoutVec2_8}; // @[hh_core.scala 155:42]
  wire [511:0] hh_dout = u_hh_datapath_io_hh_dout; // @[hh_core.scala 223:21 79:27]
  simple_dual simple_dual ( // @[hh_core.scala 165:31]
    .clka(simple_dual_clka),
    .clkb(simple_dual_clkb),
    .ena(simple_dual_ena),
    .enb(simple_dual_enb),
    .wea(simple_dual_wea),
    .addra(simple_dual_addra),
    .addrb(simple_dual_addrb),
    .dina(simple_dual_dina),
    .doutb(simple_dual_doutb)
  );
  simple_dual simple_dual_1 ( // @[hh_core.scala 177:31]
    .clka(simple_dual_1_clka),
    .clkb(simple_dual_1_clkb),
    .ena(simple_dual_1_ena),
    .enb(simple_dual_1_enb),
    .wea(simple_dual_1_wea),
    .addra(simple_dual_1_addra),
    .addrb(simple_dual_1_addrb),
    .dina(simple_dual_1_dina),
    .doutb(simple_dual_1_doutb)
  );
  simple_dual simple_dual_2 ( // @[hh_core.scala 188:31]
    .clka(simple_dual_2_clka),
    .clkb(simple_dual_2_clkb),
    .ena(simple_dual_2_ena),
    .enb(simple_dual_2_enb),
    .wea(simple_dual_2_wea),
    .addra(simple_dual_2_addra),
    .addrb(simple_dual_2_addrb),
    .dina(simple_dual_2_dina),
    .doutb(simple_dual_2_doutb)
  );
  hh_datapath_1 u_hh_datapath ( // @[hh_core.scala 199:38]
    .io_clk(u_hh_datapath_io_clk),
    .io_rst(u_hh_datapath_io_rst),
    .io_hh_cnt(u_hh_datapath_io_hh_cnt),
    .io_d1_rdy(u_hh_datapath_io_d1_rdy),
    .io_d1_vld(u_hh_datapath_io_d1_vld),
    .io_d2_vld(u_hh_datapath_io_d2_vld),
    .io_vk1_vld(u_hh_datapath_io_vk1_vld),
    .io_d3_rdy(u_hh_datapath_io_d3_rdy),
    .io_d3_vld(u_hh_datapath_io_d3_vld),
    .io_tk_vld(u_hh_datapath_io_tk_vld),
    .io_d4_rdy(u_hh_datapath_io_d4_rdy),
    .io_d5_rdy(u_hh_datapath_io_d5_rdy),
    .io_d5_vld(u_hh_datapath_io_d5_vld),
    .io_yj_sft(u_hh_datapath_io_yj_sft),
    .io_d4_sft(u_hh_datapath_io_d4_sft),
    .io_hh_din(u_hh_datapath_io_hh_din),
    .io_hh_dout(u_hh_datapath_io_hh_dout)
  );
  assign io_dmx0_mem_doutb = simple_dual_doutb; // @[hh_core.scala 175:31]
  assign io_dmx1_mem_doutb = simple_dual_1_doutb; // @[hh_core.scala 186:31]
  assign io_rtri_mem_doutb = simple_dual_2_doutb; // @[hh_core.scala 197:31]
  assign io_hh_dout = io_rst ? 512'h0 : hh_dout; // @[hh_core.scala 224:25 225:27 227:24]
  assign simple_dual_clka = io_clk; // @[hh_core.scala 167:25]
  assign simple_dual_clkb = io_clk; // @[hh_core.scala 172:25]
  assign simple_dual_ena = io_dmx0_mem_ena; // @[hh_core.scala 168:24]
  assign simple_dual_enb = io_dmx0_mem_enb; // @[hh_core.scala 173:24]
  assign simple_dual_wea = io_dmx0_mem_wea; // @[hh_core.scala 169:24]
  assign simple_dual_addra = io_dmx0_mem_addra; // @[hh_core.scala 170:26]
  assign simple_dual_addrb = io_dmx0_mem_addrb; // @[hh_core.scala 174:26]
  assign simple_dual_dina = io_dmx0_mem_dina; // @[hh_core.scala 171:25]
  assign simple_dual_1_clka = io_clk; // @[hh_core.scala 178:25]
  assign simple_dual_1_clkb = io_clk; // @[hh_core.scala 183:25]
  assign simple_dual_1_ena = io_dmx1_mem_ena; // @[hh_core.scala 179:24]
  assign simple_dual_1_enb = io_dmx1_mem_enb; // @[hh_core.scala 184:24]
  assign simple_dual_1_wea = io_dmx1_mem_wea; // @[hh_core.scala 180:24]
  assign simple_dual_1_addra = io_dmx1_mem_addra; // @[hh_core.scala 181:26]
  assign simple_dual_1_addrb = io_dmx1_mem_addrb; // @[hh_core.scala 185:26]
  assign simple_dual_1_dina = io_dmx1_mem_dina; // @[hh_core.scala 182:25]
  assign simple_dual_2_clka = io_clk; // @[hh_core.scala 189:25]
  assign simple_dual_2_clkb = io_clk; // @[hh_core.scala 194:25]
  assign simple_dual_2_ena = io_rtri_mem_ena; // @[hh_core.scala 190:24]
  assign simple_dual_2_enb = io_rtri_mem_enb; // @[hh_core.scala 195:24]
  assign simple_dual_2_wea = io_rtri_mem_wea; // @[hh_core.scala 191:24]
  assign simple_dual_2_addra = io_rtri_mem_addra; // @[hh_core.scala 192:26]
  assign simple_dual_2_addrb = io_rtri_mem_addrb; // @[hh_core.scala 196:26]
  assign simple_dual_2_dina = io_rtri_mem_dina; // @[hh_core.scala 193:25]
  assign u_hh_datapath_io_clk = io_clk; // @[hh_core.scala 201:34]
  assign u_hh_datapath_io_rst = io_rst; // @[hh_core.scala 202:34]
  assign u_hh_datapath_io_hh_cnt = io_hh_cnt; // @[hh_core.scala 203:37]
  assign u_hh_datapath_io_d1_rdy = io_d1_rdy; // @[hh_core.scala 204:37]
  assign u_hh_datapath_io_d1_vld = io_d1_vld; // @[hh_core.scala 205:37]
  assign u_hh_datapath_io_d2_vld = io_d2_vld; // @[hh_core.scala 207:37]
  assign u_hh_datapath_io_vk1_vld = io_vk1_vld; // @[hh_core.scala 209:38]
  assign u_hh_datapath_io_d3_rdy = io_d3_rdy; // @[hh_core.scala 210:37]
  assign u_hh_datapath_io_d3_vld = io_d3_vld; // @[hh_core.scala 211:37]
  assign u_hh_datapath_io_tk_vld = io_tk_vld; // @[hh_core.scala 213:37]
  assign u_hh_datapath_io_d4_rdy = io_d4_rdy; // @[hh_core.scala 214:37]
  assign u_hh_datapath_io_d5_rdy = io_d5_rdy; // @[hh_core.scala 216:37]
  assign u_hh_datapath_io_d5_vld = io_d5_vld; // @[hh_core.scala 217:37]
  assign u_hh_datapath_io_yj_sft = io_yj_sft; // @[hh_core.scala 220:37]
  assign u_hh_datapath_io_d4_sft = io_d4_sft; // @[hh_core.scala 221:37]
  assign u_hh_datapath_io_hh_din = hh_din; // @[hh_core.scala 222:37]
  always @(posedge io_clk) begin
    if (io_rst) begin // @[hh_core.scala 89:25]
      hh0_din_rdy <= 1'h0; // @[hh_core.scala 90:29]
    end else begin
      hh0_din_rdy <= io_dmx0_mem_enb & io_rtri_mem_enb; // @[hh_core.scala 95:29]
    end
    if (io_rst) begin // @[hh_core.scala 89:25]
      hh1_din_rdy <= 1'h0; // @[hh_core.scala 91:29]
    end else begin
      hh1_din_rdy <= io_dmx1_mem_enb & io_rtri_mem_enb; // @[hh_core.scala 96:29]
    end
    if (io_rst) begin // @[hh_core.scala 89:25]
      hh_din_reg <= 512'h0; // @[hh_core.scala 92:28]
    end else if (hh0_din_rdy | hh1_din_rdy) begin // @[hh_core.scala 102:44]
      if (_T) begin // @[hh_core.scala 135:44]
        hh_din_reg <= _hh_din_update_T_2; // @[hh_core.scala 136:31]
      end else if (io_rst) begin // @[hh_core.scala 137:31]
        hh_din_reg <= 512'h0; // @[hh_core.scala 138:31]
      end
    end else if (io_hh_st) begin // @[hh_core.scala 104:33]
      if (io_rst) begin // @[hh_core.scala 157:25]
        hh_din_reg <= 512'h0; // @[hh_core.scala 158:32]
      end else begin
        hh_din_reg <= _GEN_329;
      end
    end
    if (io_rst) begin // @[hh_core.scala 89:25]
      hh_din <= 512'h0; // @[hh_core.scala 92:28]
    end else if (hh0_din_rdy | hh1_din_rdy) begin // @[hh_core.scala 102:44]
      if (_T) begin // @[hh_core.scala 135:44]
        hh_din <= _hh_din_update_T_2; // @[hh_core.scala 136:31]
      end else if (io_rst) begin // @[hh_core.scala 137:31]
        hh_din <= 512'h0; // @[hh_core.scala 138:31]
      end else begin
        hh_din <= hh_din_reg; // @[hh_core.scala 140:31]
      end
    end else if (io_hh_st) begin // @[hh_core.scala 104:33]
      if (io_rst) begin // @[hh_core.scala 157:25]
        hh_din <= 512'h0; // @[hh_core.scala 158:32]
      end else begin
        hh_din <= _GEN_329;
      end
    end else begin
      hh_din <= hh_din_reg; // @[hh_core.scala 108:29]
    end
    hh_dout_update_REG <= {myHhdoutWire_hi,myHhdoutWire_lo}; // @[hh_core.scala 155:42]
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
  hh0_din_rdy = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  hh1_din_rdy = _RAND_1[0:0];
  _RAND_2 = {16{`RANDOM}};
  hh_din_reg = _RAND_2[511:0];
  _RAND_3 = {16{`RANDOM}};
  hh_din = _RAND_3[511:0];
  _RAND_4 = {16{`RANDOM}};
  hh_dout_update_REG = _RAND_4[511:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module tsqr_mc(
  input          clk,
  input          rst,
  input          tsqr_en,
  input  [15:0]  tile_no,
  input  [2:0]   dma_mem_ena,
  input  [31:0]  dma_mem_wea,
  input  [2:0]   dma_mem_addra,
  input  [255:0] dma_mem_dina,
  input  [2:0]   dma_mem_enb,
  input  [2:0]   dma_mem_addrb,
  output [255:0] dma_mem_doutb,
  output         mem0_fi_c_0,
  output         mem1_fi_c_0,
  output         tsqr_fi
);
  wire  fsms_0_clk; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_rst; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_tsqr_en; // @[tsqr_mc.scala 1811:46]
  wire [15:0] fsms_0_tile_no; // @[tsqr_mc.scala 1811:46]
  wire [15:0] fsms_0_hh_cnt; // @[tsqr_mc.scala 1811:46]
  wire [15:0] fsms_0_mx_cnt; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_d1_rdy; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_d1_vld; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_d2_vld; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_vk1_vld; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_d3_rdy; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_d3_vld; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_tk_vld; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_d4_rdy; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_d5_rdy; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_d5_vld; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_yj_sft; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_d4_sft; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_hh_st; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_mem0_fi; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_mem1_fi; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_tsqr_fi; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_dmx0_mem_ena; // @[tsqr_mc.scala 1811:46]
  wire [31:0] fsms_0_dmx0_mem_wea; // @[tsqr_mc.scala 1811:46]
  wire [2:0] fsms_0_dmx0_mem_addra; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_dmx0_mem_enb; // @[tsqr_mc.scala 1811:46]
  wire [2:0] fsms_0_dmx0_mem_addrb; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_dmx1_mem_ena; // @[tsqr_mc.scala 1811:46]
  wire [31:0] fsms_0_dmx1_mem_wea; // @[tsqr_mc.scala 1811:46]
  wire [2:0] fsms_0_dmx1_mem_addra; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_dmx1_mem_enb; // @[tsqr_mc.scala 1811:46]
  wire [2:0] fsms_0_dmx1_mem_addrb; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_rtri_mem_ena; // @[tsqr_mc.scala 1811:46]
  wire [31:0] fsms_0_rtri_mem_wea; // @[tsqr_mc.scala 1811:46]
  wire [2:0] fsms_0_rtri_mem_addra; // @[tsqr_mc.scala 1811:46]
  wire  fsms_0_rtri_mem_enb; // @[tsqr_mc.scala 1811:46]
  wire [2:0] fsms_0_rtri_mem_addrb; // @[tsqr_mc.scala 1811:46]
  wire  hh_core_io_clk; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_rst; // @[tsqr_mc.scala 1812:47]
  wire [15:0] hh_core_io_hh_cnt; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_d1_rdy; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_d1_vld; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_d2_vld; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_vk1_vld; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_d3_rdy; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_d3_vld; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_tk_vld; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_d4_rdy; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_d5_rdy; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_d5_vld; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_yj_sft; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_d4_sft; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_hh_st; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_dmx0_mem_ena; // @[tsqr_mc.scala 1812:47]
  wire [31:0] hh_core_io_dmx0_mem_wea; // @[tsqr_mc.scala 1812:47]
  wire [2:0] hh_core_io_dmx0_mem_addra; // @[tsqr_mc.scala 1812:47]
  wire [255:0] hh_core_io_dmx0_mem_dina; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_dmx0_mem_enb; // @[tsqr_mc.scala 1812:47]
  wire [2:0] hh_core_io_dmx0_mem_addrb; // @[tsqr_mc.scala 1812:47]
  wire [255:0] hh_core_io_dmx0_mem_doutb; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_dmx1_mem_ena; // @[tsqr_mc.scala 1812:47]
  wire [31:0] hh_core_io_dmx1_mem_wea; // @[tsqr_mc.scala 1812:47]
  wire [2:0] hh_core_io_dmx1_mem_addra; // @[tsqr_mc.scala 1812:47]
  wire [255:0] hh_core_io_dmx1_mem_dina; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_dmx1_mem_enb; // @[tsqr_mc.scala 1812:47]
  wire [2:0] hh_core_io_dmx1_mem_addrb; // @[tsqr_mc.scala 1812:47]
  wire [255:0] hh_core_io_dmx1_mem_doutb; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_rtri_mem_ena; // @[tsqr_mc.scala 1812:47]
  wire [31:0] hh_core_io_rtri_mem_wea; // @[tsqr_mc.scala 1812:47]
  wire [2:0] hh_core_io_rtri_mem_addra; // @[tsqr_mc.scala 1812:47]
  wire [255:0] hh_core_io_rtri_mem_dina; // @[tsqr_mc.scala 1812:47]
  wire  hh_core_io_rtri_mem_enb; // @[tsqr_mc.scala 1812:47]
  wire [2:0] hh_core_io_rtri_mem_addrb; // @[tsqr_mc.scala 1812:47]
  wire [255:0] hh_core_io_rtri_mem_doutb; // @[tsqr_mc.scala 1812:47]
  wire [511:0] hh_core_io_hh_dout; // @[tsqr_mc.scala 1812:47]
  wire [15:0] _tile_no_c_0_T = tile_no / 1'h1; // @[tsqr_mc.scala 221:48]
  wire [15:0] _tile_no_c_0_T_2 = _tile_no_c_0_T - 16'h1; // @[tsqr_mc.scala 221:62]
  wire [16:0] _tile_no_c_0_T_3 = {{1'd0}, _tile_no_c_0_T_2}; // @[tsqr_mc.scala 221:67]
  wire  tsqr_fi_c_0 = fsms_0_tsqr_fi; // @[tsqr_mc.scala 177:26 1842:22]
  wire  fsm_rtri_mem_ena_c_0 = fsms_0_rtri_mem_ena; // @[tsqr_mc.scala 1853:31 188:35]
  wire  fsm_dmx0_mem_ena_c_0 = fsms_0_dmx0_mem_ena; // @[tsqr_mc.scala 178:35 1843:31]
  wire  fsm_dmx1_mem_ena_c_0 = fsms_0_dmx1_mem_ena; // @[tsqr_mc.scala 183:35 1848:31]
  wire [31:0] fsm_rtri_mem_wea_c_0 = fsms_0_rtri_mem_wea; // @[tsqr_mc.scala 1854:31 189:35]
  wire [31:0] fsm_dmx0_mem_wea_c_0 = fsms_0_dmx0_mem_wea; // @[tsqr_mc.scala 179:35 1844:31]
  wire [31:0] fsm_dmx1_mem_wea_c_0 = fsms_0_dmx1_mem_wea; // @[tsqr_mc.scala 184:35 1849:31]
  wire [2:0] fsm_rtri_mem_addra_c_0 = fsms_0_rtri_mem_addra; // @[tsqr_mc.scala 1855:33 190:37]
  wire [2:0] fsm_dmx0_mem_addra_c_0 = fsms_0_dmx0_mem_addra; // @[tsqr_mc.scala 180:37 1845:33]
  wire [2:0] fsm_dmx1_mem_addra_c_0 = fsms_0_dmx1_mem_addra; // @[tsqr_mc.scala 185:37 1850:33]
  wire [511:0] hh_dout_c_0 = hh_core_io_hh_dout; // @[tsqr_mc.scala 1901:22 193:26]
  wire [255:0] _GEN_8 = fsm_rtri_mem_ena_c_0 ? hh_dout_c_0[511:256] : 256'h0; // @[tsqr_mc.scala 1255:42 1256:32 1258:32]
  wire [255:0] _GEN_10 = fsm_dmx0_mem_ena_c_0 ? hh_dout_c_0[255:0] : 256'h0; // @[tsqr_mc.scala 1278:56 1279:58 1281:46]
  wire [255:0] _GEN_12 = fsm_dmx1_mem_ena_c_0 ? hh_dout_c_0[255:0] : 256'h0; // @[tsqr_mc.scala 1504:56 1505:58 1507:46]
  wire  fsm_rtri_mem_enb_c_0 = fsms_0_rtri_mem_enb; // @[tsqr_mc.scala 1856:31 191:35]
  wire  fsm_dmx0_mem_enb_c_0 = fsms_0_dmx0_mem_enb; // @[tsqr_mc.scala 181:35 1846:31]
  wire  fsm_dmx1_mem_enb_c_0 = fsms_0_dmx1_mem_enb; // @[tsqr_mc.scala 1851:31 186:35]
  wire [2:0] fsm_rtri_mem_addrb_c_0 = fsms_0_rtri_mem_addrb; // @[tsqr_mc.scala 1857:33 192:37]
  wire [2:0] fsm_dmx0_mem_addrb_c_0 = fsms_0_dmx0_mem_addrb; // @[tsqr_mc.scala 182:37 1847:33]
  wire [2:0] fsm_dmx1_mem_addrb_c_0 = fsms_0_dmx1_mem_addrb; // @[tsqr_mc.scala 1852:33 187:37]
  wire [255:0] dmx1_mem_doutb_c_0 = hh_core_io_dmx1_mem_doutb; // @[tsqr_mc.scala 1758:32 1904:29]
  wire [255:0] _GEN_17 = dma_mem_enb[0] ? dmx1_mem_doutb_c_0 : 256'h0; // @[tsqr_mc.scala 1778:43 1779:27 1781:27]
  wire [255:0] dmx0_mem_doutb_c_0 = hh_core_io_dmx0_mem_doutb; // @[tsqr_mc.scala 1757:32 1903:29]
  wire [255:0] _GEN_18 = dma_mem_enb[1] ? dmx0_mem_doutb_c_0 : _GEN_17; // @[tsqr_mc.scala 1776:40 1777:27]
  wire [255:0] rtri_mem_doutb_c_0 = hh_core_io_rtri_mem_doutb; // @[tsqr_mc.scala 1756:32 1902:29]
  wire [255:0] _GEN_19 = dma_mem_enb[2] ? rtri_mem_doutb_c_0 : _GEN_18; // @[tsqr_mc.scala 1774:39 1775:27]
  fsm fsms_0 ( // @[tsqr_mc.scala 1811:46]
    .clk(fsms_0_clk),
    .rst(fsms_0_rst),
    .tsqr_en(fsms_0_tsqr_en),
    .tile_no(fsms_0_tile_no),
    .hh_cnt(fsms_0_hh_cnt),
    .mx_cnt(fsms_0_mx_cnt),
    .d1_rdy(fsms_0_d1_rdy),
    .d1_vld(fsms_0_d1_vld),
    .d2_vld(fsms_0_d2_vld),
    .vk1_vld(fsms_0_vk1_vld),
    .d3_rdy(fsms_0_d3_rdy),
    .d3_vld(fsms_0_d3_vld),
    .tk_vld(fsms_0_tk_vld),
    .d4_rdy(fsms_0_d4_rdy),
    .d5_rdy(fsms_0_d5_rdy),
    .d5_vld(fsms_0_d5_vld),
    .yj_sft(fsms_0_yj_sft),
    .d4_sft(fsms_0_d4_sft),
    .hh_st(fsms_0_hh_st),
    .mem0_fi(fsms_0_mem0_fi),
    .mem1_fi(fsms_0_mem1_fi),
    .tsqr_fi(fsms_0_tsqr_fi),
    .dmx0_mem_ena(fsms_0_dmx0_mem_ena),
    .dmx0_mem_wea(fsms_0_dmx0_mem_wea),
    .dmx0_mem_addra(fsms_0_dmx0_mem_addra),
    .dmx0_mem_enb(fsms_0_dmx0_mem_enb),
    .dmx0_mem_addrb(fsms_0_dmx0_mem_addrb),
    .dmx1_mem_ena(fsms_0_dmx1_mem_ena),
    .dmx1_mem_wea(fsms_0_dmx1_mem_wea),
    .dmx1_mem_addra(fsms_0_dmx1_mem_addra),
    .dmx1_mem_enb(fsms_0_dmx1_mem_enb),
    .dmx1_mem_addrb(fsms_0_dmx1_mem_addrb),
    .rtri_mem_ena(fsms_0_rtri_mem_ena),
    .rtri_mem_wea(fsms_0_rtri_mem_wea),
    .rtri_mem_addra(fsms_0_rtri_mem_addra),
    .rtri_mem_enb(fsms_0_rtri_mem_enb),
    .rtri_mem_addrb(fsms_0_rtri_mem_addrb)
  );
  hh_core hh_core ( // @[tsqr_mc.scala 1812:47]
    .io_clk(hh_core_io_clk),
    .io_rst(hh_core_io_rst),
    .io_hh_cnt(hh_core_io_hh_cnt),
    .io_d1_rdy(hh_core_io_d1_rdy),
    .io_d1_vld(hh_core_io_d1_vld),
    .io_d2_vld(hh_core_io_d2_vld),
    .io_vk1_vld(hh_core_io_vk1_vld),
    .io_d3_rdy(hh_core_io_d3_rdy),
    .io_d3_vld(hh_core_io_d3_vld),
    .io_tk_vld(hh_core_io_tk_vld),
    .io_d4_rdy(hh_core_io_d4_rdy),
    .io_d5_rdy(hh_core_io_d5_rdy),
    .io_d5_vld(hh_core_io_d5_vld),
    .io_yj_sft(hh_core_io_yj_sft),
    .io_d4_sft(hh_core_io_d4_sft),
    .io_hh_st(hh_core_io_hh_st),
    .io_dmx0_mem_ena(hh_core_io_dmx0_mem_ena),
    .io_dmx0_mem_wea(hh_core_io_dmx0_mem_wea),
    .io_dmx0_mem_addra(hh_core_io_dmx0_mem_addra),
    .io_dmx0_mem_dina(hh_core_io_dmx0_mem_dina),
    .io_dmx0_mem_enb(hh_core_io_dmx0_mem_enb),
    .io_dmx0_mem_addrb(hh_core_io_dmx0_mem_addrb),
    .io_dmx0_mem_doutb(hh_core_io_dmx0_mem_doutb),
    .io_dmx1_mem_ena(hh_core_io_dmx1_mem_ena),
    .io_dmx1_mem_wea(hh_core_io_dmx1_mem_wea),
    .io_dmx1_mem_addra(hh_core_io_dmx1_mem_addra),
    .io_dmx1_mem_dina(hh_core_io_dmx1_mem_dina),
    .io_dmx1_mem_enb(hh_core_io_dmx1_mem_enb),
    .io_dmx1_mem_addrb(hh_core_io_dmx1_mem_addrb),
    .io_dmx1_mem_doutb(hh_core_io_dmx1_mem_doutb),
    .io_rtri_mem_ena(hh_core_io_rtri_mem_ena),
    .io_rtri_mem_wea(hh_core_io_rtri_mem_wea),
    .io_rtri_mem_addra(hh_core_io_rtri_mem_addra),
    .io_rtri_mem_dina(hh_core_io_rtri_mem_dina),
    .io_rtri_mem_enb(hh_core_io_rtri_mem_enb),
    .io_rtri_mem_addrb(hh_core_io_rtri_mem_addrb),
    .io_rtri_mem_doutb(hh_core_io_rtri_mem_doutb),
    .io_hh_dout(hh_core_io_hh_dout)
  );
  assign dma_mem_doutb = rst ? 256'h0 : _GEN_19; // @[tsqr_mc.scala 1772:14 1773:23]
  assign mem0_fi_c_0 = fsms_0_mem0_fi; // @[tsqr_mc.scala 1840:22]
  assign mem1_fi_c_0 = fsms_0_mem1_fi; // @[tsqr_mc.scala 1841:22]
  assign tsqr_fi = tsqr_en & tsqr_fi_c_0; // @[tsqr_mc.scala 241:23 242:17 244:17]
  assign fsms_0_clk = clk; // @[tsqr_mc.scala 1815:21]
  assign fsms_0_rst = rst; // @[tsqr_mc.scala 1816:21]
  assign fsms_0_tsqr_en = tsqr_en; // @[tsqr_mc.scala 212:34]
  assign fsms_0_tile_no = tsqr_en ? _tile_no_c_0_T_3[15:0] : 16'h0; // @[tsqr_mc.scala 216:29 221:36 237:28]
  assign hh_core_io_clk = clk; // @[tsqr_mc.scala 1859:22]
  assign hh_core_io_rst = rst; // @[tsqr_mc.scala 1860:22]
  assign hh_core_io_hh_cnt = fsms_0_hh_cnt; // @[tsqr_mc.scala 157:25 1819:21]
  assign hh_core_io_d1_rdy = fsms_0_d1_rdy; // @[tsqr_mc.scala 158:25 1821:21]
  assign hh_core_io_d1_vld = fsms_0_d1_vld; // @[tsqr_mc.scala 159:25 1822:21]
  assign hh_core_io_d2_vld = fsms_0_d2_vld; // @[tsqr_mc.scala 161:25 1824:21]
  assign hh_core_io_vk1_vld = fsms_0_vk1_vld; // @[tsqr_mc.scala 163:26 1826:22]
  assign hh_core_io_d3_rdy = fsms_0_d3_rdy; // @[tsqr_mc.scala 164:25 1827:21]
  assign hh_core_io_d3_vld = fsms_0_d3_vld; // @[tsqr_mc.scala 165:25 1828:21]
  assign hh_core_io_tk_vld = fsms_0_tk_vld; // @[tsqr_mc.scala 167:25 1830:21]
  assign hh_core_io_d4_rdy = fsms_0_d4_rdy; // @[tsqr_mc.scala 168:25 1831:21]
  assign hh_core_io_d5_rdy = fsms_0_d5_rdy; // @[tsqr_mc.scala 170:25 1833:21]
  assign hh_core_io_d5_vld = fsms_0_d5_vld; // @[tsqr_mc.scala 171:25 1834:21]
  assign hh_core_io_yj_sft = fsms_0_yj_sft; // @[tsqr_mc.scala 174:25 1837:21]
  assign hh_core_io_d4_sft = fsms_0_d4_sft; // @[tsqr_mc.scala 175:25 1838:21]
  assign hh_core_io_hh_st = fsms_0_hh_st; // @[tsqr_mc.scala 176:24 1839:20]
  assign hh_core_io_dmx0_mem_ena = dma_mem_ena[1] | fsm_dmx0_mem_ena_c_0; // @[tsqr_mc.scala 260:88]
  assign hh_core_io_dmx0_mem_wea = dma_mem_ena[1] ? dma_mem_wea : fsm_dmx0_mem_wea_c_0; // @[tsqr_mc.scala 356:61 357:45 359:45]
  assign hh_core_io_dmx0_mem_addra = dma_mem_ena[1] ? dma_mem_addra : fsm_dmx0_mem_addra_c_0; // @[tsqr_mc.scala 814:61 815:47 817:47]
  assign hh_core_io_dmx0_mem_dina = dma_mem_ena[1] ? dma_mem_dina : _GEN_10; // @[tsqr_mc.scala 1276:61 1277:46]
  assign hh_core_io_dmx0_mem_enb = dma_mem_enb[1] | fsm_dmx0_mem_enb_c_0; // @[tsqr_mc.scala 1722:68]
  assign hh_core_io_dmx0_mem_addrb = dma_mem_enb[1] ? dma_mem_addrb : fsm_dmx0_mem_addrb_c_0; // @[tsqr_mc.scala 1741:50 1742:33 1744:33]
  assign hh_core_io_dmx1_mem_ena = dma_mem_ena[0] | fsm_dmx1_mem_ena_c_0; // @[tsqr_mc.scala 301:80]
  assign hh_core_io_dmx1_mem_wea = dma_mem_ena[0] ? dma_mem_wea : fsm_dmx1_mem_wea_c_0; // @[tsqr_mc.scala 578:59 579:45 581:45]
  assign hh_core_io_dmx1_mem_addra = dma_mem_ena[0] ? dma_mem_addra : fsm_dmx1_mem_addra_c_0; // @[tsqr_mc.scala 1036:59 1037:47 1039:47]
  assign hh_core_io_dmx1_mem_dina = dma_mem_ena[0] ? dma_mem_dina : _GEN_12; // @[tsqr_mc.scala 1502:59 1503:46]
  assign hh_core_io_dmx1_mem_enb = dma_mem_enb[0] | fsm_dmx1_mem_enb_c_0; // @[tsqr_mc.scala 1723:70]
  assign hh_core_io_dmx1_mem_addrb = dma_mem_enb[0] ? dma_mem_addrb : fsm_dmx1_mem_addrb_c_0; // @[tsqr_mc.scala 1749:52 1750:33 1752:33]
  assign hh_core_io_rtri_mem_ena = dma_mem_ena[2] | fsm_rtri_mem_ena_c_0; // @[tsqr_mc.scala 249:68]
  assign hh_core_io_rtri_mem_wea = dma_mem_ena[2] ? dma_mem_wea : fsm_rtri_mem_wea_c_0; // @[tsqr_mc.scala 339:50 340:31 342:31]
  assign hh_core_io_rtri_mem_addra = dma_mem_ena[2] ? dma_mem_addra : fsm_rtri_mem_addra_c_0; // @[tsqr_mc.scala 795:50 796:33 798:33]
  assign hh_core_io_rtri_mem_dina = dma_mem_ena[2] ? dma_mem_dina : _GEN_8; // @[tsqr_mc.scala 1253:50 1254:32]
  assign hh_core_io_rtri_mem_enb = dma_mem_enb[2] | fsm_rtri_mem_enb_c_0; // @[tsqr_mc.scala 1721:68]
  assign hh_core_io_rtri_mem_addrb = dma_mem_enb[2] ? dma_mem_addrb : fsm_rtri_mem_addrb_c_0; // @[tsqr_mc.scala 1733:50 1734:33 1736:33]
endmodule

