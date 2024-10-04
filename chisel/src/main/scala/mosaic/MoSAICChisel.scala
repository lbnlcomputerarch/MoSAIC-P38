//> using scala "2.13.12"
//> using dep "org.chipsalliance::chisel:6.5.0"
//> using plugin "org.chipsalliance:::chisel-plugin:6.5.0"
//> using options "-unchecked", "-deprecation", "-language:reflectiveCalls", "-feature", "-Xcheckinit", "-Xfatal-warnings", "-Ywarn-dead-code", "-Ywarn-unused", "-Ymacro-annotations"

package mosaic

import chisel3._
// _root_ disambiguates from package chisel3.util.circt if user imports chisel3.util._
import _root_.circt.stage.ChiselStage

class MoSAICChisel extends Module {
  val io = IO(new Bundle {
    val control           = new AXI4LiteTargetIO()
    val enableProcessing  = Input(Bool())
    val internalResetDone = Output(Bool())
  })

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
  val tiles = Module(new mosaic())

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
