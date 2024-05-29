open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
current_hw_device [get_hw_devices xcu280_u55c_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xcu280_u55c_0] 0]

set_property PROBES.FILE {open_nic_shell.ltx} [get_hw_devices xcu280_u55c_0]
set_property FULL_PROBES.FILE {open_nic_shell.ltx} [get_hw_devices xcu280_u55c_0]
set_property PROGRAM.FILE {open_nic_shell.bit} [get_hw_devices xcu280_u55c_0]

program_hw_devices [get_hw_devices xcu280_u55c_0]
refresh_hw_device [lindex [get_hw_devices xcu280_u55c_0] 0]
