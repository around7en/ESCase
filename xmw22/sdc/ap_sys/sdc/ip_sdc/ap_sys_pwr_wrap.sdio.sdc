
################################################################################
#  Specify CLK1 and CLK2 and CLK3 clock period and name
################################################################################
set CLK1_NAME   ${AP_SYS_NAME}_clk_${IP_NAME}_mux_div1_pad
set CLK1_PERIOD $CYCLE_102M4
set CLK2_NAME   ${AP_SYS_NAME}_clk_${IP_NAME}_mux_div2_pad
set CLK2_PERIOD $CYCLE_51M2
set CLK3_NAME   ${AP_SYS_NAME}_clk_${IP_NAME}_mux_div4_pad
set CLK3_PERIOD $CYCLE_25M6

######################################################################################
#  Define Variables for Constraints
######################################################################################
#####################################################
#
#  Create variables for the external delay on
#  each of the interfaced
#  By Default the logic under test gets 1/3 the timing
#  Budget.  Changing the vars will change the budget
#  for the whole interface.
#
#####################################################
set CLK1_ONETHIRD     [expr 0.60 * $CLK1_PERIOD]
set CLK1_TENTH        [expr 0.20 * $CLK1_PERIOD]
set CLK2_ONETHIRD     [expr 0.60 * $CLK2_PERIOD]
set CLK2_TENTH        [expr 0.20 * $CLK2_PERIOD]

set CLK1_ONETHIRD_HALF     [expr 0.30 * $CLK1_PERIOD]
set CLK1_TENTH_HALF        [expr 0.10 * $CLK1_PERIOD]
set CLK2_ONETHIRD_HALF     [expr 0.30 * $CLK2_PERIOD]
set CLK2_TENTH_HALF        [expr 0.10 * $CLK2_PERIOD]

if {! $IS_CHIP} {
    set clk_input_data " iopad_ahb_sd_data0_in \
                         iopad_ahb_sd_data1_in \
                         iopad_ahb_sd_data2_in \
                         iopad_ahb_sd_data3_in \
                       "
    set clk_input_cmd "  iopad_ahb_sd_cmd_in "
                      
    set clk_output_data " ahb_iopad_sd_data0_out \
                          ahb_iopad_sd_data1_out \
                          ahb_iopad_sd_data2_out \
                          ahb_iopad_sd_data3_out \
                          ahb_iopad_sd_data0_out_en \
                          ahb_iopad_sd_data1_out_en \
                          ahb_iopad_sd_data2_out_en \
                          ahb_iopad_sd_data3_out_en \
                       "
    set clk_output_cmd "  ahb_iopad_sd_cmd_out \
                          ahb_iopad_sd_cmd_out_en \
                       "
} else {
    set clk_input_data " $func_pad_names(sd_d0) \
                         $func_pad_names(sd_d1) \
                         $func_pad_names(sd_d2) \
                         $func_pad_names(sd_d3) \
                       "
    set clk_input_cmd " $func_pad_names(sd_cmd) "
                      
    set clk_output_data " $func_pad_names(sd_d0) \
                          $func_pad_names(sd_d1) \
                          $func_pad_names(sd_d2) \
                          $func_pad_names(sd_d3) \
                       "
    set clk_output_cmd " $func_pad_names(sd_cmd) \
                       "
}

##################################################
## set delays
##################################################

#######################cmd out delay##############
set_output_delay -add_delay -min -2                  -clock $CLK2_NAME $clk_output_cmd
set_output_delay -add_delay -max 6                   -clock $CLK2_NAME $clk_output_cmd

set_output_delay -add_delay -min -0.8                -clock $CLK1_NAME $clk_output_cmd
set_output_delay -add_delay -max 3                   -clock $CLK1_NAME $clk_output_cmd

set_output_delay -add_delay -min -5                  -clock $CLK3_NAME $clk_output_cmd 
set_output_delay -add_delay -max 5                   -clock $CLK3_NAME $clk_output_cmd
if {! $IS_CHIP || $IS_FLAT } {
    set_false_path -fall_from ap_sys_clk_sdio0_mux_div1 -to $clk_output_cmd 
    set_false_path -fall_from ap_sys_clk_sdio0_mux_div2 -to $clk_output_cmd 
    set_false_path -rise_from ap_sys_clk_sdio0_mux_div4 -to $clk_output_cmd 
} else {
    set_false_path -fall_from ${AP_LIB_HIER}clk_sdcard_2 -to $clk_output_cmd 
    set_false_path -fall_from ${AP_LIB_HIER}clk_sdcard_1 -to $clk_output_cmd 
    set_false_path -rise_from ${AP_LIB_HIER}clk_sdcard_3 -to $clk_output_cmd 
}
#######################cmd input delay##############
set_input_delay  -add_delay -min 1.5                 -clock $CLK1_NAME $clk_input_cmd 
set_input_delay  -add_delay -max 2.7                 -clock $CLK1_NAME $clk_input_cmd 

set_input_delay  -add_delay -min 2.5                 -clock $CLK2_NAME $clk_input_cmd
set_input_delay  -add_delay -max 14                  -clock $CLK2_NAME $clk_input_cmd

set_input_delay  -add_delay -min 0                   -clock $CLK3_NAME $clk_input_cmd -clock_fall
set_input_delay  -add_delay -max 14                  -clock $CLK3_NAME $clk_input_cmd -clock_fall
if {! $IS_CHIP || $IS_FLAT } {
    set_false_path -from $clk_input_cmd -fall_to ap_sys_clk_sdio0_mux_div1  
    set_false_path -from $clk_input_cmd -fall_to ap_sys_clk_sdio0_mux_div2  
    set_false_path -from $clk_input_cmd -fall_to ap_sys_clk_sdio0_mux_div4  
} else {
    set_false_path -from $clk_input_cmd -fall_to ${AP_LIB_HIER}clk_sdcard_2 
    set_false_path -from $clk_input_cmd -fall_to ${AP_LIB_HIER}clk_sdcard_1 
    set_false_path -from $clk_input_cmd -fall_to ${AP_LIB_HIER}clk_sdcard_3 
}
#if {! $IS_CHIP || $IS_FLAT } {
#    set_false_path -rise_from $CLK2_NAME -to [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_high_ctrl1/d_n_cmd_in_reg/D]
#    set_false_path -rise_from $CLK1_NAME -to [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_high_ctrl1/d_n_cmd_in_reg/D]
#    set_false_path -fall_from $CLK3_NAME -to [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_high_ctrl1/d_cmd_in_reg/D]
#}
#######################data out delay##############
set_output_delay -add_delay -min -0.8                -clock $CLK1_NAME $clk_output_data
set_output_delay -add_delay -max 3                   -clock $CLK1_NAME $clk_output_data

set_output_delay -add_delay -min -2                  -clock $CLK2_NAME $clk_output_data
set_output_delay -add_delay -max 6                   -clock $CLK2_NAME $clk_output_data

set_output_delay -add_delay -min -5                  -clock $CLK3_NAME $clk_output_data
set_output_delay -add_delay -max 5                   -clock $CLK3_NAME $clk_output_data
if {! $IS_CHIP || $IS_FLAT } {
    set_false_path -fall_from ap_sys_clk_sdio0_mux_div1 -to ap_sys_clk_sdio0_mux_div1_pad 
    set_false_path -fall_from ap_sys_clk_sdio0_mux_div2 -to ap_sys_clk_sdio0_mux_div2_pad 
    set_false_path -rise_from ap_sys_clk_sdio0_mux_div4 -to ap_sys_clk_sdio0_mux_div4_pad 
} else {
    set_false_path -fall_from ${AP_LIB_HIER}clk_sdcard_2 -to ap_sys_clk_sdio0_mux_div1_pad 
    set_false_path -fall_from ${AP_LIB_HIER}clk_sdcard_1 -to ap_sys_clk_sdio0_mux_div2_pad 
    set_false_path -rise_from ${AP_LIB_HIER}clk_sdcard_3 -to ap_sys_clk_sdio0_mux_div4_pad 
}
#######################data in delay##############
set_input_delay  -add_delay -min 1.5                 -clock $CLK1_NAME $clk_input_data 
set_input_delay  -add_delay -max 2.7                 -clock $CLK1_NAME $clk_input_data 

set_input_delay  -add_delay -min 2.5                 -clock $CLK2_NAME $clk_input_data
set_input_delay  -add_delay -max 14                  -clock $CLK2_NAME $clk_input_data

set_input_delay  -add_delay -min 0                   -clock $CLK3_NAME $clk_input_data -clock_fall
set_input_delay  -add_delay -max 14                  -clock $CLK3_NAME $clk_input_data -clock_fall

if {! $IS_CHIP || $IS_FLAT } {
    set_false_path -from ap_sys_clk_sdio0_mux_div1_pad -fall_to ap_sys_clk_sdio0_mux_div1  
    set_false_path -from ap_sys_clk_sdio0_mux_div2_pad -fall_to ap_sys_clk_sdio0_mux_div2  
    set_false_path -from ap_sys_clk_sdio0_mux_div4_pad -fall_to ap_sys_clk_sdio0_mux_div4  
} else {
    set_false_path -from ap_sys_clk_sdio0_mux_div1_pad -fall_to ${AP_LIB_HIER}clk_sdcard_2 
    set_false_path -from ap_sys_clk_sdio0_mux_div2_pad -fall_to ${AP_LIB_HIER}clk_sdcard_1 
    set_false_path -from ap_sys_clk_sdio0_mux_div4_pad -fall_to ${AP_LIB_HIER}clk_sdcard_3 
}
