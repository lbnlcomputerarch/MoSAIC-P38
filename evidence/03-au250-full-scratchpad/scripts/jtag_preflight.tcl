# Read-only JTAG preflight for the 2026-11-18 AU250 full-scratchpad run.
# Lists hardware targets and devices and reports the expected xcu250_0.
# Programs nothing.

open_hw_manager
connect_hw_server -allow_non_jtag
foreach t [get_hw_targets] {
    puts "HW_TARGET: $t"
}
open_hw_target
foreach d [get_hw_devices] {
    puts "HW_DEVICE: $d"
}
if {[llength [get_hw_devices -quiet xcu250_0]] == 0} {
    puts "PREFLIGHT_FAIL: xcu250_0 not visible"
    close_hw_target
    disconnect_hw_server
    close_hw_manager
    exit 1
}
set dev [lindex [get_hw_devices xcu250_0] 0]
foreach p {PART FAMILY SPEED} {
    if {[catch {get_property $p $dev} v]} {
        puts "PROP $p: <unavailable>"
    } else {
        puts "PROP $p: $v"
    }
}
puts "PREFLIGHT_OK: xcu250_0 visible"
close_hw_target
disconnect_hw_server
close_hw_manager
