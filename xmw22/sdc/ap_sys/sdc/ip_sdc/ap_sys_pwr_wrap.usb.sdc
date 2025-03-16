
# TEST_CLK
set CLK1_NAME             ${AP_SYS_NAME}_usbphy_test_clk
set CLK1_PERIOD           $CYCLE_26M

set CLK1_ONETHIRD         [expr 0.67 * $CLK1_PERIOD]
set CLK1_TWOTENTH         [expr 0.20 * $CLK1_PERIOD]

# test inputs
if {! $IS_CHIP} {
    set clk1_input   { usbphy_test_si1 \
                       usbphy_test_si2 \
                       usbphy_test_si3 \
                       usbphy_test_si4 \
                       usbphy_test_se }
} else {
    set clk1_input " $func_pad_names(usbphy_test_si1) \
                     $func_pad_names(usbphy_test_si2) \
                     $func_pad_names(usbphy_test_si3) \
                     $func_pad_names(usbphy_test_si4) \
                     $func_pad_names(usbphy_test_se)  \
                     "
}
# test outputs
if {! $IS_CHIP} {
    set clk1_output  { usbphy_test_so1 \
                       usbphy_test_so2 \
                       usbphy_test_so3 \
                       usbphy_test_so4 }
} else {
    set clk1_output "$func_pad_names(usbphy_test_so1) \
                     $func_pad_names(usbphy_test_so2) \
                     $func_pad_names(usbphy_test_so3) \
                     $func_pad_names(usbphy_test_so4) \
                   "
}
set_input_delay  -min $CLK1_TWOTENTH -clock $CLK1_NAME [get_ports $clk1_input] -add_delay
set_input_delay  -max $CLK1_ONETHIRD -clock $CLK1_NAME [get_ports $clk1_input] -add_delay
set_output_delay -min $CLK1_TWOTENTH -clock $CLK1_NAME [get_ports $clk1_output]  -add_delay
set_output_delay -max $CLK1_ONETHIRD -clock $CLK1_NAME [get_ports $clk1_output]  -add_delay
if {!$IS_CHIP || $IS_FLAT} {
    set_dont_touch_network [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_usb2_wrap/u_M31USBH225TL022V_00223601/DP]
    set_dont_touch_network [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_usb2_wrap/u_M31USBH225TL022V_00223601/DM]
} else {
    set_dont_touch_network [get_pins ${AP_SYS_HIER}DP]
    set_dont_touch_network [get_pins ${AP_SYS_HIER}DM]
}


