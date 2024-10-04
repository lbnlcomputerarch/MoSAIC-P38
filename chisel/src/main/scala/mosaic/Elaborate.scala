object Elaborate extends App {
  val firtoolOptions = Array(
    "-disable-all-randomization",
    "--lowering-options=" + List(
      // make yosys happy
      // see https://github.com/llvm/circt/blob/main/docs/VerilogGeneration.md
      "disallowLocalVariables",
      "disallowPackedArrays",
      "locationInfoStyle=wrapInAtSquareBracket"
    ).reduce(_ + "," + _)
  )
  println(
    circt.stage.ChiselStage.emitSystemVerilogFile(
      new mosaic.MoSAICChisel(),
      args,
      firtoolOptions
    )
  )
}
