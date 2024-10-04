package mosaic

import sys.process._

import chisel3._
import chisel3.util.HasBlackBoxPath
import chisel3.experimental._ // To enable experimental features

class mosaic(
  bw: Int = 32,
  // ddr4_ctrl: Boolean = false
  mosaicConfig: String = s"mosaic_2x2_firesim")
    extends BlackBox(
      Map(
        "BW" -> IntParam(bw)
      )
    )
    with HasBlackBoxPath {
  val bwb:          Int = bw / 8
  val S_AXI_ID_SZ:  Int = 11
  val S_AXI_ADR_SZ: Int = 34 // ADDRESS
  val S_AXI_LEN_SZ: Int = 8 // LENGTH
  val S_AXI_SZE_SZ: Int = 3 // SIZE
  val S_AXI_BRT_SZ: Int = 2 // BURST
  val S_AXI_DAT_SZ: Int = 512 // DATA
  val S_AXI_STB_SZ: Int = 64 // STROBE
  val S_AXI_RSP_SZ: Int = 2 // RESPONSE
  val S_AXI_CAC_SZ: Int = 4 // CACHE
  val S_AXI_PRT_SZ: Int = 3 // PROT
  val S_AXI_QOS_SZ: Int = 4 // QOS

  val io = IO(new Bundle {
    //////////////////////
    // Packet interface
    //////////////////////
    // Input
    val stream_in_packet_in_TVALID = Input(Bool())
    val stream_in_packet_in_TLAST  = Input(Bool())
    val stream_in_packet_in_TDATA  = Input(UInt(bw.W))
    val stream_in_packet_in_TKEEP  = Input(UInt(bwb.W))
    val stream_in_packet_in_TREADY = Output(Bool())

    // Output
    val stream_out_packet_out_TVALID = Output(Bool())
    val stream_out_packet_out_TLAST  = Output(Bool())
    val stream_out_packet_out_TDATA  = Output(UInt(bw.W))
    val stream_out_packet_out_TKEEP  = Output(UInt(bwb.W))
    val stream_out_packet_out_TREADY = Input(Bool())

    ////////////////////
    // AXI
    ////////////////////
    // Address Write
    val control_S_AXI_AWADDR  = Input(UInt(12.W))
    val control_S_AXI_AWVALID = Input(Bool())
    val control_S_AXI_AWREADY = Output(Bool())

    // Write
    val control_S_AXI_WDATA  = Input(UInt(bw.W))
    val control_S_AXI_WSTRB  = Input(UInt(bwb.W))
    val control_S_AXI_WVALID = Input(Bool())
    val control_S_AXI_WREADY = Output(Bool())

    // Write Response
    val control_S_AXI_BRESP  = Output(UInt(2.W))
    val control_S_AXI_BVALID = Output(Bool())
    val control_S_AXI_BREADY = Input(Bool())

    // Address Read
    val control_S_AXI_ARADDR  = Input(UInt(12.W))
    val control_S_AXI_ARVALID = Input(Bool())
    val control_S_AXI_ARREADY = Output(Bool())

    // Read Response
    val control_S_AXI_RDATA  = Output(UInt(bw.W))
    val control_S_AXI_RRESP  = Output(UInt(2.W))
    val control_S_AXI_RVALID = Output(Bool())
    val control_S_AXI_RREADY = Input(Bool())

    ////////////////////
    // Memory Manager
    ////////////////////
    // if (ddr4_ctrl) {
    //     //- ADDRESS WRITE
    //     val s_axi_awready = Input(Bool())
    //     val s_axi_awvalid = Output(Bool())
    //     val s_axi_awid =    Output(UInt(S_AXI_ID_SZ.W))
    //     val s_axi_awaddr =  Output(UInt(S_AXI_ADR_SZ.W))
    //     val s_axi_awlen =   Output(UInt(S_AXI_LEN_SZ.W))
    //     val s_axi_awsize =  Output(UInt(S_AXI_SZE_SZ.W))
    //     val s_axi_awburst = Output(UInt(S_AXI_BRT_SZ.W))
    //     val s_axi_awlock =  Output(Bool())
    //     val s_axi_awcache = Output(UInt(S_AXI_CAC_SZ.W))
    //     val s_axi_awprot =  Output(UInt(S_AXI_PRT_SZ.W))
    //     val s_axi_awqos =   Output(UInt(S_AXI_QOS_SZ.W))
    //     //- DATA WRITE
    //     val s_axi_wready =  Input(Bool())
    //     val s_axi_wvalid =  Output(Bool())
    //     val s_axi_wlast =   Output(Bool())
    //     val s_axi_wdata =   Output(UInt(S_AXI_DAT_SZ.W))
    //     val s_axi_wstrb =   Output(UInt(S_AXI_STB_SZ.W))
    //     //- VALID WRITE
    //     val s_axi_bready =  Output(Bool())
    //     val s_axi_bvalid =  Input(Bool())
    //     val s_axi_bid =     Input(UInt(S_AXI_ID_SZ.W))
    //     val s_axi_bresp =   Input(UInt(S_AXI_RSP_SZ.W))
    //     //- ADDRESS READ
    //     val s_axi_arready = Input(Bool())
    //     val s_axi_arvalid = Output(Bool())
    //     val s_axi_arid =    Output(UInt(S_AXI_ID_SZ.W))
    //     val s_axi_araddr =  Output(UInt(S_AXI_ADR_SZ.W))
    //     val s_axi_arlen =   Output(UInt(S_AXI_LEN_SZ.W))
    //     val s_axi_arsize =  Output(UInt(S_AXI_SZE_SZ.W))
    //     val s_axi_arburst = Output(UInt(S_AXI_BRT_SZ.W))
    //     val s_axi_arlock =  Output(Bool())
    //     val s_axi_arcache = Output(UInt(S_AXI_CAC_SZ.W))
    //     val s_axi_arprot =  Output(UInt(S_AXI_PRT_SZ.W))
    //     val s_axi_arqos =   Output(UInt(S_AXI_QOS_SZ.W))
    //     //- RESPONSE READ
    //     val s_axi_rready =  Output(Bool())
    //     val s_axi_rvalid =  Input(Bool())
    //     val s_axi_rlast =   Input(Bool())
    //     val s_axi_rdata =   Input(UInt(S_AXI_DAT_SZ.W))
    //     val s_axi_rid =     Input(UInt(S_AXI_ID_SZ.W))
    //     val s_axi_rresp =   Input(UInt(S_AXI_RSP_SZ.W))

    //     val clk_memory =        Input(Clock())
    //     val clk_memory_rst =    Input(Reset())
    // }

    ////////////////////
    // Metadata
    ////////////////////
    val notify_in_metadata_in_VALID   = Input(Bool())
    val notify_in_metadata_in_DATA    = Input(UInt(128.W))
    val notify_out_metadata_out_VALID = Output(Bool())
    val notify_out_metadata_out_DATA  = Output(UInt(128.W))

    ////////////////////
    // Clock and Reset
    ////////////////////
    val clk_line_rst      = Input(Reset())
    val clk_line          = Input(Clock())
    val clk_control_rst   = Input(Reset())
    val clk_control       = Input(Clock())
    val enable_processing = Input(Bool())
    val internal_rst_done = Output(Bool())
  })

  val mosaicChiselDir = System.getProperty("user.dir")
  val mosaicVsrcDir   = s"${mosaicChiselDir}/src/main/resources/mosaic/vsrc"

  // pre-process the verilog to remove "includes" and combine into one file
  val make = s"make -C ${mosaicVsrcDir} default MOSAIC_PERL_SCRIPT=\"${mosaicConfig}\""
  require(make.! == 0, "Failed to run preprocessing step")

  // add wrapper/blackbox after it is pre-processed
  addPath(s"${mosaicVsrcDir}/mosaic.preprocessed.sv")
}
