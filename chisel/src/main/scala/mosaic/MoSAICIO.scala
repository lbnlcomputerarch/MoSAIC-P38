package mosaic

import chisel3._
import chisel3.util._

class StreamIO (
  datSize : Int = 32
) extends Bundle {
  val packet = Decoupled(new Bundle {
    val last = Bool()
    val data = UInt(datSize.W)
    val keep = UInt((datSize / 8).W)
  })
}

class MetadataIO (
  datSize : Int = 128
) extends Bundle {
  val data = Valid(UInt(datSize.W))
}

class AXI4LiteTargetIO (
  adrSize : Int = 12,
  datSize : Int = 32,
  rspSize : Int = 2
) extends Bundle {
  val stbSize : Int = datSize / 8 // STROBE
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

class AXI4InitiatorIO (
  idSize  : Int = 11,
  adrSize : Int = 34,
  lenSize : Int = 8,  // LENGTH
  szeSize : Int = 3,  // SIZE
  brtSize : Int = 2,  // BURST
  datSize : Int = 512,// DATA
  rspSize : Int = 2,  // RESPONSE
  cacSize : Int = 4,  // CACHE
  prtSize : Int = 3,  // PROT
  qosSize : Int = 4   // QOS
) extends Bundle {
  val stbSize : Int = datSize / 8 // STROBE
  // Address Write
  val aw = Decoupled(new Bundle {
    val id =    UInt(idSize.W)
    val addr =  UInt(adrSize.W)
    val len =   UInt(lenSize.W)
    val size =  UInt(szeSize.W)
    val burst = UInt(brtSize.W)
    val lock =  Bool()
    val cache = UInt(cacSize.W)
    val prot =  UInt(prtSize.W)
    val qos =   UInt(qosSize.W)
  })

  // Data Write
  val w = Decoupled(new Bundle {
    val last =  Bool()
    val data =  UInt(datSize.W)
    val strb =  UInt(stbSize.W)
  })

  // Response Write
  val b = Flipped(Decoupled(new Bundle {
    val id =    UInt(idSize.W)
    val resp =  UInt(rspSize.W)
  }))

  // Address Read
  val ar = Decoupled(new Bundle {
    val id =    UInt(idSize.W)
    val addr =  UInt(adrSize.W)
    val len =   UInt(lenSize.W)
    val size =  UInt(szeSize.W)
    val burst = UInt(brtSize.W)
    val lock =  Bool()
    val cache = UInt(cacSize.W)
    val prot =  UInt(prtSize.W)
    val qos =   UInt(qosSize.W)
  })

  // Response Read
  val r = Flipped(Decoupled(new Bundle {
    val data =  UInt(datSize.W)
    val id =    UInt(idSize.W)
    val resp =  UInt(rspSize.W)
  }))
}
