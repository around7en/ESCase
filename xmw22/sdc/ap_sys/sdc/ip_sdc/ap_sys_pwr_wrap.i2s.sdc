
################################################################################
# Specify CLK1 clock period and name
################################################################################
# Clock name
set CLK1_NAME   ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb
set CLK1_PERIOD  $CYCLE_102M4

################################################################################
# Specify CLK2 and CLK3 clock period and name
################################################################################
set CLK2_NAME     ${AP_LIB_HIER}${AP_SYS_NAME}_clk_${IP_NAME}
set CLK2_PERIOD  $CYCLE_51M2

set CLK3_NAME     ${AP_SYS_NAME}_clk_i2s0_sck_generated_pad 
set CLK3_PERIOD   [expr $CYCLE_51M2*6.0]

set CLK4_NAME     ${AP_SYS_NAME}_clk_pdm_clk_mux_div2_pad
set CLK4_PERIOD   [expr $CYCLE_51M2*12.0]

set CLK5_NAME     ${AP_SYS_NAME}_clk_pdm_clk_mux_div1_pad
set CLK5_PERIOD   [expr $CYCLE_51M2*6.0]
######################################################################################
######################################################################################
# Define Variables for Constraints
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
set CLK1_HALF       [expr 0.50 * $CLK1_PERIOD]
set CLK1_ONEQRT     [expr 0.25 * $CLK1_PERIOD]
set CLK1_ONETHIRD   [expr 0.33 * $CLK1_PERIOD]
set CLK1_TWOTHIRD   [expr 0.60 * $CLK1_PERIOD]
set CLK1_TENTH      [expr 0.10 * $CLK1_PERIOD]

set CLK2_HALF       [expr 0.50 * $CLK2_PERIOD]
set CLK2_ONETHIRD   [expr 0.33 * $CLK2_PERIOD]
set CLK2_TWOTHIRD   [expr 0.60 * $CLK2_PERIOD]
set CLK2_TENTH      [expr 0.10 * $CLK2_PERIOD]

set CLK3_HALF       [expr 0.50 * $CLK3_PERIOD]
set CLK3_ONETHIRD   [expr 0.33 * $CLK3_PERIOD]
set CLK3_TWOTHIRD   [expr 0.60 * $CLK3_PERIOD]
set CLK3_TENTH      [expr 0.10 * $CLK3_PERIOD]

set CLK4_HALF       [expr 0.50 * $CLK4_PERIOD]
set CLK4_ONETHIRD   [expr 0.33 * $CLK4_PERIOD]
set CLK4_TWOTHIRD   [expr 0.60 * $CLK4_PERIOD]
set CLK4_TENTH      [expr 0.10 * $CLK4_PERIOD]

set CLK5_HALF       [expr 0.50 * $CLK5_PERIOD]
set CLK5_ONETHIRD   [expr 0.33 * $CLK5_PERIOD]
set CLK5_TWOTHIRD   [expr 0.60 * $CLK5_PERIOD]
set CLK5_TENTH      [expr 0.10 * $CLK5_PERIOD]
##################################################
# Constraints for all generic ports
echo "# Constraints for all generic ports"
##################################################

#-------------------------------------------------
# INPUTS in I2S domain
#-------------------------------------------------
if {! $IS_CHIP} {
    set clk2_input " ${IP_NAME}_scki \
                     ${IP_NAME}_wsi \
                     ${IP_NAME}_sdi \
                   "
} else {
    set clk2_input "$func_pad_names(iisclk) \
                    $func_pad_names(iislrclk) \
                    $func_pad_names(iisdi) \
                   "
}


#-------------------------------------------------
# OUTPUTS in APB domain
#-------------------------------------------------

#if {! $IS_CHIP} {
#    set clk1_output "${IP_NAME}_ws_oen \
#                     ${IP_NAME}_sck_oen \
#                    "
#} else {
#    set clk1_output "$func_pad_names(iisclk) \
#                     $func_pad_names(iislrclk) \
#                    "
#}
# sdoe and ctrloe are quasi-static signals
# strobe output may require synchronizer on chip level
                   
#-------------------------------------------------
# OUTPUTS in I2S domain
#-------------------------------------------------
if {! $IS_CHIP} {
    set clk3_output "${IP_NAME}_wso \
                     ${IP_NAME}_sdo \
                    "
} else {
    set clk3_output "$func_pad_names(iislrclk) \
                     $func_pad_names(iisdo) \
                    "
}
                     
if {! $IS_CHIP} {
    set clk4_input " ${IP_NAME}_sdi "
} else {
    set clk4_input " $func_pad_names(iisdi) "
}

if {! $IS_CHIP} {
    set clk5_input " ${IP_NAME}_sdi "
} else {
    set clk5_input " $func_pad_names(iisdi) "
}
##################################################
# Set delays
##################################################
#-------------------------------------------------
# Gray-coded cross clock domain paths
#-------------------------------------------------
set_max_delay -from $CLK1_NAME  -to $CLK2_NAME  $CLK2_HALF
set_min_delay -from $CLK1_NAME  -to $CLK2_NAME  $CLK2_TENTH
set_max_delay -from $CLK2_NAME  -to $CLK1_NAME  $CLK1_HALF
set_min_delay -from $CLK2_NAME  -to $CLK1_NAME  $CLK1_TENTH

#-------------------------------------------------
# Input delay to register
#-------------------------------------------------
set_input_delay -add_delay -min $CLK2_ONETHIRD -clock $CLK2_NAME $clk2_input
set_input_delay -add_delay -max $CLK2_TWOTHIRD -clock $CLK2_NAME $clk2_input

#-------------------------------------------------
# Output delay from register
#-------------------------------------------------
#set_output_delay -add_delay -min $CLK1_ONETHIRD -clock $CLK1_NAME $clk1_output
#set_output_delay -add_delay -max $CLK1_TWOTHIRD -clock $CLK1_NAME $clk1_output
set_output_delay -add_delay -min 0      -clock $CLK3_NAME $clk3_output
set_output_delay -add_delay -max 10     -clock $CLK3_NAME $clk3_output
if {! $IS_CHIP} {
    set_input_delay -add_delay -min 0   -clock $CLK4_NAME $clk4_input
    set_input_delay -add_delay -max 10  -clock $CLK4_NAME $clk4_input
    
    set_input_delay -add_delay -min 0   -clock $CLK4_NAME $clk4_input -clock_fall
    set_input_delay -add_delay -max 10  -clock $CLK4_NAME $clk4_input -clock_fall
    set_multicycle_path 6 -from $CLK4_NAME   -to $CLK2_NAME -setup -end
    set_multicycle_path 5 -from $CLK4_NAME   -to $CLK2_NAME -hold -end
} else {
    foreach i $func_pad_names(pdm_clk) {
        set CLK4_NAME ${AP_SYS_NAME}_clk_pdm_clk_mux_div2_pad_$i
        set_input_delay -add_delay -min 0   -clock $CLK4_NAME $clk4_input
        set_input_delay -add_delay -max 10  -clock $CLK4_NAME $clk4_input
        
        set_input_delay -add_delay -min 0   -clock $CLK4_NAME $clk4_input -clock_fall
        set_input_delay -add_delay -max 10  -clock $CLK4_NAME $clk4_input -clock_fall
        set_multicycle_path 6 -from $CLK4_NAME   -to $CLK2_NAME -setup -end
        set_multicycle_path 5 -from $CLK4_NAME   -to $CLK2_NAME -hold -end
    }
}
set_multicycle_path 6 -from $CLK2_NAME   -to $CLK3_NAME -setup -start
set_multicycle_path 5 -from $CLK2_NAME   -to $CLK3_NAME -hold -start

if {! $IS_CHIP} {
    set_input_delay -add_delay -min 0   -clock $CLK5_NAME $clk5_input
    set_input_delay -add_delay -max 10  -clock $CLK5_NAME $clk5_input
    set_multicycle_path 6 -from $CLK5_NAME   -to $CLK2_NAME -setup -end
    set_multicycle_path 5 -from $CLK5_NAME   -to $CLK2_NAME -hold -end

} else {
    foreach i $func_pad_names(pdm_clk) {
        set CLK5_NAME ${AP_SYS_NAME}_clk_pdm_clk_mux_div1_pad_$i
        set_input_delay -add_delay -min 0   -clock $CLK5_NAME $clk5_input
        set_input_delay -add_delay -max 10  -clock $CLK5_NAME $clk5_input
        set_multicycle_path 6 -from $CLK5_NAME   -to $CLK2_NAME -setup -end
        set_multicycle_path 5 -from $CLK5_NAME   -to $CLK2_NAME -hold -end
    }
}
if {$IS_CHIP} {
set_multicycle_path 2 -from $CLK1_NAME   -th ${AP_SYS_HIER}${IP_NAME}_sck_oen  -to $func_pad_names(iisclk) -setup -start
set_multicycle_path 1 -from $CLK1_NAME   -th ${AP_SYS_HIER}${IP_NAME}_sck_oen  -to $func_pad_names(iisclk) -hold -start

set_multicycle_path 2 -from $CLK1_NAME   -th ${AP_SYS_HIER}${IP_NAME}_ws_oen  -to $func_pad_names(iislrclk) -setup -start
set_multicycle_path 1 -from $CLK1_NAME   -th ${AP_SYS_HIER}${IP_NAME}_ws_oen  -to $func_pad_names(iislrclk) -hold -start
}

