
################################################################################
#  Specify CLK1 and CLK2 clock period and name
################################################################################
set CLK1_NAME   ${AP_LIB_HIER}${AP_SYS_NAME}_clk_${IP_NAME}_apb
set CLK1_PERIOD $CYCLE_61M44 

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
set CLK1_HALF         [expr 0.50 * $CLK1_PERIOD]
#set CLK1_ONETHIRD     [expr 0.33 * $CLK1_PERIOD]
set CLK1_ONETHIRD     [expr 0.40 * $CLK1_PERIOD]
set CLK1_TENTH        [expr 0.20 * $CLK1_PERIOD]

##################################################
# Constraints for all generic ports
echo "# Constraints for all generic ports"
##################################################
### Group all inputs ###
if {! $IS_CHIP} {
    set clk1_input " ${IP_NAME}_sda_input \
                     ${IP_NAME}_scl_input \
                   "
    set clk1_output " ${IP_NAME}_sda_oen \
                  ${IP_NAME}_sda_out \
                  ${IP_NAME}_scl_oen \
                  ${IP_NAME}_scl_out \
                "
} else {
    set clk1_input " $func_pad_names(${PAD_INDEX}_sda) \
                     $func_pad_names(${PAD_INDEX}_sck) \
                   "
    set clk1_output " $func_pad_names(${PAD_INDEX}_sda) \
                      $func_pad_names(${PAD_INDEX}_sck) \
                    "
}
### Group all outputs ###
### Remove clock out ports from outputs ###
echo "#####################################################"
echo "  Defining constraints for input and output delays"
echo "#####################################################"

##################################################
## set delays
##################################################
set_input_delay  -add_delay -min $CLK1_TENTH    -clock $CLK1_NAME $clk1_input
set_input_delay  -add_delay -max $CLK1_ONETHIRD -clock $CLK1_NAME $clk1_input
set_output_delay -add_delay -min $CLK1_TENTH    -clock $CLK1_NAME $clk1_output
set_output_delay -add_delay -max $CLK1_ONETHIRD -clock $CLK1_NAME $clk1_output

