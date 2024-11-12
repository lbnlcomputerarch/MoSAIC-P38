package mosaic

import sys.process._
import scala.io.Source

import chisel3._
import chisel3.util.HasBlackBoxPath
import chisel3.experimental._ // To enable experimental features

class mosaic(
  bw:           Int        = 32,
  ddr4Config:   DDR4Config = new DDR4Config(),
  mosaicConfig: String     = "mosaic_2x2_firesim")
    extends BlackBox(
      Map(
        "BW" -> IntParam(bw)
      )
    )
    with HasBlackBoxPath {
  val ddr4Ctrl: Boolean = mosaicConfig.contains("ddr")
  val bwb:      Int     = bw / 8

  val io = IO(
    new SVMoSAICIO(
      ddr4Ctrl   = ddr4Ctrl,
      bw         = bw,
      ddr4Config = ddr4Config
    )
  )

  val mosaicChiselDir = System.getProperty("user.dir")
  val mosaicVsrcDir   = s"${mosaicChiselDir}/src/main/resources/mosaic/vsrc"
  val mosaicFileList  = s"${mosaicChiselDir}/../icarus/file_list.txt"

  val perlMake =
    s"make -C ${mosaicVsrcDir} build MOSAIC_PERL_SCRIPT=\"${mosaicConfig}\""
  require(perlMake.! == 0, "Failed to run MoSAIC Perl Build step")

  val fileList = Source
    .fromFile(mosaicFileList)
    .getLines()
    .toList
    .filter(_.nonEmpty)
    .filterNot(_.startsWith("#"))
    .filterNot(_.contains("Testbench"))
    .map(mosaicChiselDir + "/" + _)

  // pre-process the verilog to remove "includes" and combine into one file
  val make =
    s"make -C ${mosaicVsrcDir} default MOSAIC_PERL_SCRIPT=\"${mosaicConfig}\" ALL_VSRCS=\"${fileList.mkString(" ")}\""
  require(make.! == 0, "Failed to run preprocessing step")

  // add wrapper/blackbox after it is pre-processed
  addPath(s"${mosaicVsrcDir}/mosaic.preprocessed.sv")
}
