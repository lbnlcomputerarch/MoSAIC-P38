# Software stack for asynchronous triangular solver

This directory contains C code, linker scripts and baremetal bootloader to run the asynchronous triangular solver algorithm. For more details in the algorithm look [P38-IUSG-Graphs](https://github.com/jshalf/P38-IUSG-Graphs/tree/master/Jordi).

To obtain the hex code that generates a sparse matrix run `perl ./data/pl`

To obtain the hex code for asynchornous triangular solver run `perl ./async_trisolve.pl`

The hex files data32\_x.hex and async\_trisolve32\_x.hex can be loaded in the PICORVs setting the @pico\_porgram array in the in a testcase.

```
@pico_program = ('async_trisolve32_0.hex', 'async_trisolve32_8.hex', 'async_trisolve32_16.hex',  'async_trisolve32_24.hex',
                 'async_trisolve32_1.hex', 'async_trisolve32_9.hex', 'async_trisolve32_17.hex',  'async_trisolve32_25.hex',
                 'async_trisolve32_2.hex', 'async_trisolve32_10.hex', 'async_trisolve32_18.hex', '',
                 'async_trisolve32_3.hex', 'async_trisolve32_11.hex', 'async_trisolve32_19.hex', 'data32_27.hex');
```
