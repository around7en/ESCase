#-----------------------------------------------------------------------------------
# Set the clock period and other delays options
#-----------------------------------------------------------------------------------
set i_clk_period $CYCLE_51M2
set i_clk ${AP_LIB_HIER}${AP_SYS_NAME}_clk_${IP_NAME}_apb
set o_iec7816_clk  ${AP_SYS_NAME}_${IP_NAME}_clk
set SIM_CLK_DIV 8
set o_iec7816_clk_period $CYCLE_51M2*$SIM_CLK_DIV 
#-----------------------------------------------------------------------------------
# Creating the generated clock o_iec7816_clk from i_clk
#-----------------------------------------------------------------------------------
if {! $IS_CHIP} {
    set o_iec7816_clk_inputs " i_${IP_NAME}_rxd \
                               i_${IP_NAME}_det \
                             "
    set o_iec7816_clk_outputs " o_${IP_NAME}_txd_en \
                                o_${IP_NAME}_txd \
                                o_${IP_NAME}_rst_n \
                                o_${IP_NAME}_class \
                                o_${IP_NAME}_vdd_en \
                             "
} else {
    set o_iec7816_clk_inputs " $func_pad_names(${PAD_INDEX}_io) \
                               $func_pad_names(${PAD_INDEX}_det) \
                             "
    set o_iec7816_clk_outputs " $func_pad_names(${PAD_INDEX}_io) \
                                $func_pad_names(${PAD_INDEX}_rst) \
                             "
}

#set_input_delay [expr 0.3*${o_iec7816_clk_period}] -clock $o_iec7816_clk [ get_ports $o_iec7816_clk_inputs ]
#set_output_delay [expr 0.5*${o_iec7816_clk_period}] -clock $o_iec7816_clk [ get_ports $o_iec7816_clk_outputs ]
set_input_delay -add_delay 20 -clock $o_iec7816_clk [ get_ports $o_iec7816_clk_inputs ]
set_output_delay -add_delay 20 -clock $o_iec7816_clk [ get_ports $o_iec7816_clk_outputs ]

set_multicycle_path -setup -start -from [get_clocks $i_clk ] -to [get_clocks $o_iec7816_clk ] $SIM_CLK_DIV 
set_multicycle_path -hold -start -from [get_clocks $i_clk ] -to [get_clocks $o_iec7816_clk ] [expr $SIM_CLK_DIV-1] 
set_multicycle_path -setup -end -from [get_clocks $o_iec7816_clk ] -to [get_clocks $i_clk ] $SIM_CLK_DIV 
set_multicycle_path -hold -end -from [get_clocks $o_iec7816_clk ] -to [get_clocks $i_clk ] [expr $SIM_CLK_DIV-1] 

if {$IS_CHIP} {
set_multicycle_path 2 -from $i_clk -th u_digital_top/u_ap_sys_pwr_wrap/o_${IP_NAME}_rst_n  -to $func_pad_names(${PAD_INDEX}_rst) -setup -start 
set_multicycle_path 1 -from $i_clk -th u_digital_top/u_ap_sys_pwr_wrap/o_${IP_NAME}_rst_n  -to $func_pad_names(${PAD_INDEX}_rst) -hold -start 
}
