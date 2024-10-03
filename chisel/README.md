# Chisel Wrapper for MoSAIC

Simple Chisel 6 wrapper for MoSAIC.

## Dependencies

This project can be built with the following build tools:

- [`scala-cli`](https://scala-cli.virtuslab.org/install) is the easiest way to build Chisel.
- [Mill](https://mill-build.com/), a modern Scala build tool that's more user friendly than SBT. The instructions for installing `mill` can be found [here](https://www.chisel-lang.org/docs/installation#mill).

## Build Verilog

### `scala-cli`

```bash
scala-cli src/main/scala/mosaic/MoSAICChisel.scala src/main/scala/mosaic/MoSAICIO.scala src/main/scala/mosaic/mosaic.scala
```

The generated SystemVerilog will be displayed to the console.

### `mill`

```bash
make verilog
```

You'll find the generated SystemVerilog in `build`.

## References

- [Chisel Documentation](https://www.chisel-lang.org/docs)
- [Chisel Template](https://github.com/chipsalliance/chisel-template)
- [Chisel Playground](https://github.com/OSCPU/chisel-playground)
