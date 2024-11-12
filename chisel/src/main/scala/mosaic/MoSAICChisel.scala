//> using scala "2.13.12"
//> using dep "org.chipsalliance::chisel:6.5.0"
//> using plugin "org.chipsalliance:::chisel-plugin:6.5.0"
//> using options "-unchecked", "-deprecation", "-language:reflectiveCalls", "-feature", "-Xcheckinit", "-Xfatal-warnings", "-Ywarn-dead-code", "-Ywarn-unused", "-Ymacro-annotations"

package mosaic

import chisel3._
// _root_ disambiguates from package chisel3.util.circt if user imports chisel3.util._
import _root_.circt.stage.ChiselStage

class MoSAICChisel(
  mosaicConfig: String = "mosaic_2x2_ddr4_pkt_firesim")
    extends Module {
  val ddr4Ctrl: Boolean = mosaicConfig.contains("ddr")
  val io = IO(
    new MoSAICIO(
      ddr4Ctrl   = ddr4Ctrl,
      ddr4Config = new DDR4Config()
    )
  )

  // Packet Interface
  val stream = Wire(new Bundle {
    val in  = Flipped(new StreamIO())
    val out = new StreamIO()
  })

  // Metadata Interface
  val meta = Wire(new Bundle {
    val in  = Flipped(new MetadataIO())
    val out = new MetadataIO()
  })

  // MoSAIC Black Box Instantiation
  val tiles = Module(
    new mosaic(
      mosaicConfig = mosaicConfig
    )
  )

  // Packet Interface Wiring
  // - Input
  tiles.io.stream_in_packet_in_TVALID := stream.in.packet.valid
  tiles.io.stream_in_packet_in_TLAST  := stream.in.packet.bits.last
  tiles.io.stream_in_packet_in_TDATA  := stream.in.packet.bits.data
  tiles.io.stream_in_packet_in_TKEEP  := stream.in.packet.bits.keep
  stream.in.packet.ready              := tiles.io.stream_in_packet_in_TREADY
  // - Output
  stream.out.packet.valid               := tiles.io.stream_out_packet_out_TVALID
  stream.out.packet.bits.last           := tiles.io.stream_out_packet_out_TLAST
  stream.out.packet.bits.data           := tiles.io.stream_out_packet_out_TDATA
  stream.out.packet.bits.keep           := tiles.io.stream_out_packet_out_TKEEP
  tiles.io.stream_out_packet_out_TREADY := stream.out.packet.ready
  // - Disable Interface
  stream.in.packet.valid     := false.B
  stream.in.packet.bits.last := 0.U
  stream.in.packet.bits.data := 0.U
  stream.in.packet.bits.keep := 0.U
  stream.out.packet.ready    := false.B

  // AXI Control Interface Wiring
  // - Address Write
  tiles.io.control_S_AXI_AWADDR  := io.control.aw.bits.addr
  tiles.io.control_S_AXI_AWVALID := io.control.aw.valid
  io.control.aw.ready            := tiles.io.control_S_AXI_AWREADY
  // - Write
  tiles.io.control_S_AXI_WDATA  := io.control.w.bits.data
  tiles.io.control_S_AXI_WSTRB  := io.control.w.bits.strb
  tiles.io.control_S_AXI_WVALID := io.control.w.valid
  io.control.w.ready            := tiles.io.control_S_AXI_WREADY
  // - Response Write
  io.control.b.bits.resp        := tiles.io.control_S_AXI_BRESP
  io.control.b.valid            := tiles.io.control_S_AXI_BVALID
  tiles.io.control_S_AXI_BREADY := io.control.b.ready
  // - Address Read
  tiles.io.control_S_AXI_ARADDR  := io.control.ar.bits.addr
  tiles.io.control_S_AXI_ARVALID := io.control.ar.valid
  io.control.ar.ready            := tiles.io.control_S_AXI_ARREADY
  // - Response Read
  io.control.r.bits.data        := tiles.io.control_S_AXI_RDATA
  io.control.r.bits.resp        := tiles.io.control_S_AXI_RRESP
  io.control.r.valid            := tiles.io.control_S_AXI_RVALID
  tiles.io.control_S_AXI_RREADY := io.control.r.ready

  // Metadata Interface Wiring
  // - Input
  tiles.io.notify_in_metadata_in_VALID := meta.in.data.valid
  tiles.io.notify_in_metadata_in_DATA  := meta.in.data.bits
  // - Output
  meta.out.data.valid := tiles.io.notify_out_metadata_out_VALID
  meta.out.data.bits  := tiles.io.notify_out_metadata_out_DATA
  // - Disable Interface
  meta.in.data.valid := false.B
  meta.in.data.bits  := 0.U

  // Clock and Reset
  tiles.io.clk_line_rst    := reset.asBool
  tiles.io.clk_line        := clock
  tiles.io.clk_control_rst := reset.asBool
  tiles.io.clk_control     := clock

  tiles.io.enable_processing := io.enableProcessing
  io.internalResetDone       := tiles.io.internal_rst_done

  // DDR4 AXI Interface Wiring
  if (ddr4Ctrl) {
    tiles.io.s_axi_awready.get := io.ddr4.get.aw.ready
    io.ddr4.get.aw.valid       := tiles.io.s_axi_awvalid.get
    io.ddr4.get.aw.bits.id     := tiles.io.s_axi_awid.get
    io.ddr4.get.aw.bits.addr   := tiles.io.s_axi_awaddr.get
    io.ddr4.get.aw.bits.len    := tiles.io.s_axi_awlen.get
    io.ddr4.get.aw.bits.size   := tiles.io.s_axi_awsize.get
    io.ddr4.get.aw.bits.burst  := tiles.io.s_axi_awburst.get
    io.ddr4.get.aw.bits.lock   := tiles.io.s_axi_awlock.get
    io.ddr4.get.aw.bits.cache  := tiles.io.s_axi_awcache.get
    io.ddr4.get.aw.bits.prot   := tiles.io.s_axi_awprot.get
    io.ddr4.get.aw.bits.qos    := tiles.io.s_axi_awqos.get
    // - Write
    tiles.io.s_axi_wready.get := io.ddr4.get.w.ready
    io.ddr4.get.w.valid       := tiles.io.s_axi_wvalid.get
    io.ddr4.get.w.bits.last   := tiles.io.s_axi_wlast.get
    io.ddr4.get.w.bits.data   := tiles.io.s_axi_wdata.get
    io.ddr4.get.w.bits.strb   := tiles.io.s_axi_wstrb.get
    // - Response Write
    io.ddr4.get.b.ready       := tiles.io.s_axi_bready.get
    tiles.io.s_axi_bvalid.get := io.ddr4.get.b.valid
    tiles.io.s_axi_bid.get    := io.ddr4.get.b.bits.id
    tiles.io.s_axi_bresp.get  := io.ddr4.get.b.bits.resp
    // - Address Read
    tiles.io.s_axi_arready.get := io.ddr4.get.ar.ready
    io.ddr4.get.ar.valid       := tiles.io.s_axi_arvalid.get
    io.ddr4.get.ar.bits.id     := tiles.io.s_axi_arid.get
    io.ddr4.get.ar.bits.addr   := tiles.io.s_axi_araddr.get
    io.ddr4.get.ar.bits.len    := tiles.io.s_axi_arlen.get
    io.ddr4.get.ar.bits.size   := tiles.io.s_axi_arsize.get
    io.ddr4.get.ar.bits.burst  := tiles.io.s_axi_arburst.get
    io.ddr4.get.ar.bits.lock   := tiles.io.s_axi_arlock.get
    io.ddr4.get.ar.bits.cache  := tiles.io.s_axi_arcache.get
    io.ddr4.get.ar.bits.prot   := tiles.io.s_axi_arprot.get
    io.ddr4.get.ar.bits.qos    := tiles.io.s_axi_arqos.get
    // - Response Read
    io.ddr4.get.r.ready       := tiles.io.s_axi_rready.get
    tiles.io.s_axi_rvalid.get := io.ddr4.get.r.valid
    tiles.io.s_axi_rlast.get  := io.ddr4.get.r.bits.last
    tiles.io.s_axi_rdata.get  := io.ddr4.get.r.bits.data
    tiles.io.s_axi_rid.get    := io.ddr4.get.r.bits.id
    tiles.io.s_axi_rresp.get  := io.ddr4.get.r.bits.resp

    // Clock and Reset
    tiles.io.clk_memory.get     := clock
    tiles.io.clk_memory_rst.get := reset.asBool
  }
}

object Main extends App {
  println(
    ChiselStage.emitSystemVerilogFile(
      gen = new MoSAICChisel(),
      args = Array(
        "--target-dir",
        "build/"
      ),
      firtoolOpts = Array(
        "-disable-all-randomization",
        "--lowering-options=" + List(
          // make yosys happy
          // see https://github.com/llvm/circt/blob/main/docs/VerilogGeneration.md
          "disallowLocalVariables",
          "disallowPackedArrays",
          "locationInfoStyle=wrapInAtSquareBracket"
        ).reduce(_ + "," + _)
      )
    )
  )
}
