# One-off corrected copy of program_card.tcl for the authorized 2026-11-18
# AU250 full-scratchpad FPGA run (evidence: 07-fpga-run-20261118T000500Z).
# Corrections vs the original (see original-vs-run-tcl.diff):
#   - PROGRAM.FILE points at the accepted AU250 bitstream
#   - PROBES.FILE / FULL_PROBES.FILE omitted: no .ltx exists for this bitstream
#   - fail early if the bitstream is missing
# The original file in open-nic-shell-lbnl/ is unchanged.

set bitstream /home/ffard/mosaic-pico64-au250-acf21c2b179f/open-nic-shell-lbnl/build/au250/open_nic_shell/open_nic_shell.runs/impl_1/open_nic_shell.bit
if {![file exists $bitstream]} {
    error "Bitstream not found: $bitstream"
}

open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
current_hw_device [get_hw_devices xcu250_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xcu250_0] 0]

#probe file properties intentionally omitted: no .ltx accompanies this bitstream

set_property PROGRAM.FILE $bitstream [get_hw_devices xcu250_0]

program_hw_devices [get_hw_devices xcu250_0]
refresh_hw_device [lindex [get_hw_devices xcu250_0] 0]
