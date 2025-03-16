if {! $IS_CHIP} {
    set_input_delay  -min [expr $CYCLE_102M4 * 0.20] -clock ${AP_SYS_NAME}_clk_ap_apb -add_delay [get_ports ${IP_NAME}_ctsn]
    set_input_delay  -max [expr $CYCLE_102M4 * 0.33] -clock ${AP_SYS_NAME}_clk_ap_apb -add_delay [get_ports ${IP_NAME}_ctsn]
    
    set_output_delay  -min [expr $CYCLE_102M4 * 0.20] -clock ${AP_SYS_NAME}_clk_ap_apb -add_delay [get_ports ${IP_NAME}_rtsn]
    set_output_delay  -max [expr $CYCLE_102M4 * 0.33] -clock ${AP_SYS_NAME}_clk_ap_apb -add_delay [get_ports ${IP_NAME}_rtsn]
    set_output_delay  -min [expr $CYCLE_102M4 * 0.20] -clock ${AP_SYS_NAME}_clk_ap_apb -add_delay [get_ports ${IP_NAME}_txd]
    set_output_delay  -max [expr $CYCLE_102M4 * 0.33] -clock ${AP_SYS_NAME}_clk_ap_apb -add_delay [get_ports ${IP_NAME}_txd]
    
    set_input_delay  -min [expr $CYCLE_76M8 * 0.20] -clock ${AP_SYS_NAME}_clk_${IP_NAME}  -add_delay [get_ports ${IP_NAME}_rxd]
    set_input_delay  -max [expr $CYCLE_76M8 * 0.33] -clock ${AP_SYS_NAME}_clk_${IP_NAME}  -add_delay [get_ports ${IP_NAME}_rxd]
    set_output_delay  -min [expr $CYCLE_76M8 * 0.20] -clock ${AP_SYS_NAME}_clk_${IP_NAME}  -add_delay [get_ports ${IP_NAME}_txd]
    set_output_delay  -max [expr $CYCLE_76M8 * 0.33] -clock ${AP_SYS_NAME}_clk_${IP_NAME}  -add_delay [get_ports ${IP_NAME}_txd]
} else {
    set_input_delay  -min [expr $CYCLE_76M8 * 0.0] -clock ${AP_LIB_HIER}${AP_SYS_NAME}_clk_${IP_NAME}  -add_delay [get_ports $func_pad_names(${PAD_INDEX}rxd)]
    set_input_delay  -max [expr $CYCLE_76M8 * 0.3] -clock ${AP_LIB_HIER}${AP_SYS_NAME}_clk_${IP_NAME}  -add_delay [get_ports $func_pad_names(${PAD_INDEX}rxd)]
    set_output_delay  -min [expr $CYCLE_76M8 * 0.0] -clock ${AP_LIB_HIER}${AP_SYS_NAME}_clk_${IP_NAME}  -add_delay [get_ports $func_pad_names(${PAD_INDEX}txd)]
    set_output_delay  -max [expr $CYCLE_76M8 * 0.15] -clock ${AP_LIB_HIER}${AP_SYS_NAME}_clk_${IP_NAME}  -add_delay [get_ports $func_pad_names(${PAD_INDEX}txd)]
}
