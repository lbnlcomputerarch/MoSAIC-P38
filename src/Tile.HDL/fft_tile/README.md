
# FFT accelerator
This FFT accelerator is Chisel generated. 

The testcase to test within MoSAIC is mosaic_fft.pl. 

The source code for the MoSAIC tile is found at src/Tile.HDL/fft_tile

Within Tile_fft_int.sv you can adjust the acc_fft_sw instance name to match the desired streaming width. The options are:
- acc_fft_sw2
- acc_fft_sw4
- acc_fft_sw8
- acc_fft_sw16
- acc_fft_sw32

The generated verilog code is included for the following FFTs (name format: FFT{size}w{streaming width}):
- FFT4w2
- FFT4w4
- FFT8w2
- FFT8w4
- FFT8w8
- FFT16w2
- FFT16w4
- FFT16w8
- FFT16w16
- FFT32w2
- FFT32w4
- FFT32w8
- FFT32w16
- FFT32w32
Set the desired FFT instance to test in the corresponding acc_fft_sw{width}.sv file.

