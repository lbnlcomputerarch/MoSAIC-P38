package mosaic

import chisel3._
import chisel3.util._

class DDR4Config(
  val idSize:  Int = 11,
  val adrSize: Int = 34,
  val lenSize: Int = 8, // LENGTH
  val szeSize: Int = 3, // SIZE
  val brtSize: Int = 2, // BURST
  val datSize: Int = 512, // DATA
  val rspSize: Int = 2, // RESPONSE
  val cacSize: Int = 4, // CACHE
  val prtSize: Int = 3, // PROT
  val qosSize: Int = 4 // QOS
) {
  val stbSize: Int = datSize / 8 // STROBE
}

class StreamIO(
  datSize: Int = 32)
    extends Bundle {
  val packet = Decoupled(new Bundle {
    val last = Bool()
    val data = UInt(datSize.W)
    val keep = UInt((datSize / 8).W)
  })
}

class MetadataIO(
  datSize: Int = 128)
    extends Bundle {
  val data = Valid(UInt(datSize.W))
}

class AXI4LiteTargetIO(
  adrSize: Int = 12,
  datSize: Int = 32,
  rspSize: Int = 2)
    extends Bundle {
  val stbSize: Int = datSize / 8 // STROBE
  // Address Write
  val aw = Flipped(Decoupled(new Bundle {
    val addr = UInt(adrSize.W)
  }))

  // Write
  val w = Flipped(Decoupled(new Bundle {
    val data = UInt(datSize.W)
    val strb = UInt(stbSize.W)
  }))

  // Write Response
  val b = Decoupled(new Bundle {
    val resp = UInt(rspSize.W)
  })

  // Address Read
  val ar = Flipped(Decoupled(new Bundle {
    val addr = UInt(adrSize.W)
  }))

  // Read Response
  val r = Decoupled(new Bundle {
    val data = UInt(datSize.W)
    val resp = UInt(rspSize.W)
  })
}

class AXI4InitiatorIO(
  ddr4Config: DDR4Config)
    extends Bundle {
  // Address Write
  val aw = Decoupled(new Bundle {
    val id    = UInt(ddr4Config.idSize.W)
    val addr  = UInt(ddr4Config.adrSize.W)
    val len   = UInt(ddr4Config.lenSize.W)
    val size  = UInt(ddr4Config.szeSize.W)
    val burst = UInt(ddr4Config.brtSize.W)
    val lock  = Bool()
    val cache = UInt(ddr4Config.cacSize.W)
    val prot  = UInt(ddr4Config.prtSize.W)
    val qos   = UInt(ddr4Config.qosSize.W)
  })

  // Data Write
  val w = Decoupled(new Bundle {
    val last = Bool()
    val data = UInt(ddr4Config.datSize.W)
    val strb = UInt(ddr4Config.stbSize.W)
  })

  // Response Write
  val b = Flipped(Decoupled(new Bundle {
    val id   = UInt(ddr4Config.idSize.W)
    val resp = UInt(ddr4Config.rspSize.W)
  }))

  // Address Read
  val ar = Decoupled(new Bundle {
    val id    = UInt(ddr4Config.idSize.W)
    val addr  = UInt(ddr4Config.adrSize.W)
    val len   = UInt(ddr4Config.lenSize.W)
    val size  = UInt(ddr4Config.szeSize.W)
    val burst = UInt(ddr4Config.brtSize.W)
    val lock  = Bool()
    val cache = UInt(ddr4Config.cacSize.W)
    val prot  = UInt(ddr4Config.prtSize.W)
    val qos   = UInt(ddr4Config.qosSize.W)
  })

  // Response Read
  val r = Flipped(Decoupled(new Bundle {
    val last = Bool()
    val data = UInt(ddr4Config.datSize.W)
    val id   = UInt(ddr4Config.idSize.W)
    val resp = UInt(ddr4Config.rspSize.W)
  }))
}

class MoSAICIO(
  bw:         Int = 32,
  ddr4Ctrl:   Boolean,
  ddr4Config: DDR4Config)
    extends Bundle {
  val control = new AXI4LiteTargetIO(
    datSize = bw
  )
  val ddr4              = if (ddr4Ctrl) Some(new AXI4InitiatorIO(ddr4Config)) else None
  val enableProcessing  = Input(Bool())
  val internalResetDone = Output(Bool())
}

class SVMoSAICIO(
  ddr4Ctrl:   Boolean = false,
  bw:         Int     = 32,
  ddr4Config: DDR4Config)
    extends Bundle {
  private val bwb: Int = bw / 8

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
  // Metadata
  ////////////////////
  val notify_in_metadata_in_VALID   = Input(Bool())
  val notify_in_metadata_in_DATA    = Input(UInt(128.W))
  val notify_out_metadata_out_VALID = Output(Bool())
  val notify_out_metadata_out_DATA  = Output(UInt(128.W))

  ////////////////////
  // Memory Manager
  ////////////////////
  // - ADDRESS WRITE
  val s_axi_awready = if (ddr4Ctrl) Some(Input(Bool())) else None
  val s_axi_awvalid = if (ddr4Ctrl) Some(Output(Bool())) else None
  val s_axi_awid    = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.idSize.W))) else None
  val s_axi_awaddr  = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.adrSize.W))) else None
  val s_axi_awlen   = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.lenSize.W))) else None
  val s_axi_awsize  = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.szeSize.W))) else None
  val s_axi_awburst = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.brtSize.W))) else None
  val s_axi_awlock  = if (ddr4Ctrl) Some(Output(Bool())) else None
  val s_axi_awcache = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.cacSize.W))) else None
  val s_axi_awprot  = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.prtSize.W))) else None
  val s_axi_awqos   = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.qosSize.W))) else None
  // - DATA WRITE
  val s_axi_wready = if (ddr4Ctrl) Some(Input(Bool())) else None
  val s_axi_wvalid = if (ddr4Ctrl) Some(Output(Bool())) else None
  val s_axi_wlast  = if (ddr4Ctrl) Some(Output(Bool())) else None
  val s_axi_wdata  = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.datSize.W))) else None
  val s_axi_wstrb  = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.stbSize.W))) else None
  // - VALID WRITE
  val s_axi_bready = if (ddr4Ctrl) Some(Output(Bool())) else None
  val s_axi_bvalid = if (ddr4Ctrl) Some(Input(Bool())) else None
  val s_axi_bid    = if (ddr4Ctrl) Some(Input(UInt(ddr4Config.idSize.W))) else None
  val s_axi_bresp  = if (ddr4Ctrl) Some(Input(UInt(ddr4Config.rspSize.W))) else None
  // - ADDRESS READ
  val s_axi_arready = if (ddr4Ctrl) Some(Input(Bool())) else None
  val s_axi_arvalid = if (ddr4Ctrl) Some(Output(Bool())) else None
  val s_axi_arid    = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.idSize.W))) else None
  val s_axi_araddr  = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.adrSize.W))) else None
  val s_axi_arlen   = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.lenSize.W))) else None
  val s_axi_arsize  = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.szeSize.W))) else None
  val s_axi_arburst = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.brtSize.W))) else None
  val s_axi_arlock  = if (ddr4Ctrl) Some(Output(Bool())) else None
  val s_axi_arcache = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.cacSize.W))) else None
  val s_axi_arprot  = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.prtSize.W))) else None
  val s_axi_arqos   = if (ddr4Ctrl) Some(Output(UInt(ddr4Config.qosSize.W))) else None
  // - RESPONSE READ
  val s_axi_rready = if (ddr4Ctrl) Some(Output(Bool())) else None
  val s_axi_rvalid = if (ddr4Ctrl) Some(Input(Bool())) else None
  val s_axi_rlast  = if (ddr4Ctrl) Some(Input(Bool())) else None
  val s_axi_rdata  = if (ddr4Ctrl) Some(Input(UInt(ddr4Config.datSize.W))) else None
  val s_axi_rid    = if (ddr4Ctrl) Some(Input(UInt(ddr4Config.idSize.W))) else None
  val s_axi_rresp  = if (ddr4Ctrl) Some(Input(UInt(ddr4Config.rspSize.W))) else None

  val clk_memory     = if (ddr4Ctrl) Some(Input(Clock())) else None
  val clk_memory_rst = if (ddr4Ctrl) Some(Input(Reset())) else None

  ////////////////////
  // Clock and Reset
  ////////////////////
  val clk_line_rst      = Input(Reset())
  val clk_line          = Input(Clock())
  val clk_control_rst   = Input(Reset())
  val clk_control       = Input(Clock())
  val enable_processing = Input(Bool())
  val internal_rst_done = Output(Bool())
}
