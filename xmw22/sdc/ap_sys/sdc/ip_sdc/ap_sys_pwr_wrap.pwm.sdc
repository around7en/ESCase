################################################################################
#  Specify CLK1 clock period and name 
################################################################################
# PCLK constraint to 200 MHz
#set CLK1_PERIOD $CYCLE_26M 
################################################################################
#  Define Variables for Constraints
###############################################################################
#####################################################
#
#  Create variables for the external delay on 
#  each of the interfaced
#  By Default the logic under test gets 1/3 the timing
#  Budget.  Changing the vars will change the budget 
#  for the whole interface.
#
#####################################################
# CLK1
set CLK1_HALF         [expr 0.50 * $CLK1_PERIOD]
set CLK1_ONETHIRD     [expr 0.7 * $CLK1_PERIOD]
set CLK1_TENTH        [expr 0.10 * $CLK1_PERIOD]
set CLK1_TWOTENTH     [expr 0.20 * $CLK1_PERIOD]

###############################################################################
# Source Clocks
###############################################################################   
# CLK1
set CLK1 ${AP_LIB_HIER}${AP_SYS_NAME}_clk_${IP_NAME}_apb
### Group all outputs ###
##################################################
# Define the outputs that will be recived by FFs
# on each clock
##################################################
# CLK1
if {! $IS_CHIP} {
    set clk1_output " ${IP_NAME}_pwm_output \
                    "
} else {
    set clk1_output "$func_pad_names(${PAD_INDEX}) \
                    "
}

#set async_output { \
#                 }

##################################################
## set delays
##################################################
# output delays
# CLK1

set_output_delay -add_delay -min $CLK1_TWOTENTH -clock $CLK1 $clk1_output
set_output_delay -add_delay -max $CLK1_ONETHIRD -clock $CLK1 $clk1_output
if {$IS_CHIP} {
set_multicycle_path 2 -from $CLK1 -th ${AP_SYS_HIER}${IP_NAME}_pwm_output -to $func_pad_names(${PAD_INDEX}) -setup -start 
set_multicycle_path 1 -from $CLK1 -th ${AP_SYS_HIER}${IP_NAME}_pwm_output -to $func_pad_names(${PAD_INDEX}) -hold -start
}
