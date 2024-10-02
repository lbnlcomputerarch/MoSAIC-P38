// import Mill dependency
import mill._
import mill.define.Sources
import mill.modules.Util
import mill.scalalib.scalafmt.ScalafmtModule
import mill.scalalib._
// support BSP
import mill.bsp._

object mosaic extends SbtModule with ScalafmtModule { m =>
  override def millSourcePath = os.pwd / "src"
  override def scalaVersion = "2.13.12"
  override def scalacOptions = Seq(
    "-unchecked",
    "-deprecation",
    "-language:reflectiveCalls",
    "-feature",
    "-Xcheckinit",
    "-Xfatal-warnings",
    "-Ywarn-dead-code",
    "-Ywarn-unused",
    "-Ymacro-annotations"
  )
  override def sources = T.sources {
    super.sources() ++ Seq(PathRef(millSourcePath / "main"))
  }
  override def ivyDeps = Agg(
    ivy"org.chipsalliance::chisel:6.5.0"
  )
  override def scalacPluginIvyDeps = Agg(
    ivy"org.chipsalliance:::chisel-plugin:6.5.0"
  )
  object test extends SbtModuleTests with TestModule.ScalaTest {
    override def ivyDeps = m.ivyDeps() ++ Agg(
      ivy"org.scalatest::scalatest::3.2.16"
    )
  }
}
