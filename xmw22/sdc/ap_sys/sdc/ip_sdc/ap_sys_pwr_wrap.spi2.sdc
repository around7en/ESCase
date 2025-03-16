set CLK1_NAME     ${AP_LIB_HIER}${AP_SYS_NAME}_clk_${IP_NAME}_apb_gate
set CLK2_NAME     ${AP_SYS_NAME}_${IP_NAME}_sclk_in
set CLK1_PERIOD  $CYCLE_102M4
set CLK2_PERIOD  $CYCLE_26M
set CLK3_NAME    ${AP_SYS_NAME}_${IP_NAME}_sclk_generated
set CLK1_HALF         [expr 0.50 * $CLK1_PERIOD]
set CLK1_ONETHIRD     [expr 0.33 * $CLK1_PERIOD]
set CLK1_TWOTENTH     [expr 0.20 * $CLK1_PERIOD]

set CLK2_HALF         [expr 0.50 * $CLK2_PERIOD]
set CLK2_ONETHIRD     [expr 0.33 * $CLK2_PERIOD]
set CLK2_TWOTENTH     [expr 0.20 * $CLK2_PERIOD]

set SCLK_BR_DIV 2

set CLK3_HALF         [expr 0.50 * $CLK1_PERIOD * $SCLK_BR_DIV]
if {! $IS_CHIP} {
    set SPI_MRX ${IP_NAME}_miso_in
    set SPI_MTX ${IP_NAME}_mosi_out
    set clk1_input " ${IP_NAME}_sclk_in \
                     ${IP_NAME}_mosi_in \
                     ${IP_NAME}_nss_in \
                   "
    set clk2_input " ${IP_NAME}_nss_in \
                   "
    set clk1_output " ${IP_NAME}_mosi_oen \
                      ${IP_NAME}_nss_oen \
                      ${IP_NAME}_nss_out \
                      ${IP_NAME}_sclk_oen \
                      ${IP_NAME}_miso_out \
                      ${IP_NAME}_miso_oen \
                    "
    set clk2_output " ${IP_NAME}_miso_out  \
                    "
    set_input_delay  -min $CLK1_TWOTENTH -clock $CLK1_NAME [get_ports $clk1_input] -add_delay
    set_input_delay  -max $CLK1_ONETHIRD -clock $CLK1_NAME [get_ports $clk1_input] -add_delay

    set_output_delay -min $CLK1_TWOTENTH -clock $CLK1_NAME [get_ports $clk1_output]  -add_delay
    set_output_delay -max $CLK1_ONETHIRD -clock $CLK1_NAME [get_ports $clk1_output]  -add_delay

    set_input_delay  -min $CLK2_TWOTENTH         -clock $CLK2_NAME [get_ports $clk2_input]  -add_delay
    set_input_delay  -max $CLK2_ONETHIRD       -clock $CLK2_NAME [get_ports $clk2_input]  -add_delay

    set_output_delay -min -3    -clock $CLK2_NAME [get_ports $clk2_output] -add_delay
    set_output_delay -max 3     -clock $CLK2_NAME [get_ports $clk2_output] -add_delay
    set_output_delay -min -3    -clock $CLK2_NAME [get_ports $clk2_output] -add_delay -clock_fall
    set_output_delay -max 3     -clock $CLK2_NAME [get_ports $clk2_output] -add_delay -clock_fall

    ####################
    # MISO input delay #
    ####################
    # min_delay - 2/5 of SCLK_HALF
    set_input_delay [expr 0.40 * $CLK3_HALF] -clock $CLK3_NAME  $SPI_MRX -min -add_delay
    # max_delay - 2/3 of SCLK_HALF
    set_input_delay [expr 0.85 * $CLK3_HALF] -clock $CLK3_NAME  $SPI_MRX -max -add_delay
    # min_delay - 2/5 of SCLK_HALF
    set_input_delay [expr 0.40 * $CLK3_HALF] -clock $CLK3_NAME  $SPI_MRX -min -add_delay -clock_fall
    # max_delay - 2/3 of SCLK_HALF
    set_input_delay [expr 0.85 * $CLK3_HALF] -clock $CLK3_NAME  $SPI_MRX -max -add_delay -clock_fall
    
    set_multicycle_path [expr $SCLK_BR_DIV/2]   -setup -end   -from [get_clocks $CLK3_NAME] -to [get_clocks $CLK1_NAME]
    set_multicycle_path [expr $SCLK_BR_DIV - 1] -hold  -end   -from [get_clocks $CLK3_NAME] -to [get_clocks $CLK1_NAME]
    #####################
    # MOSI output delay #
    #####################
    # min_delay - 2/5 of SCLK_HALF
    set_output_delay -4 -clock $CLK3_NAME  $SPI_MTX -min -add_delay
    # max_delay - 2/3 of SCLK_HALF
    set_output_delay 5 -clock $CLK3_NAME  $SPI_MTX -max -add_delay
    # min_delay - 2/5 of SCLK_HALF
    set_output_delay -4 -clock $CLK3_NAME  $SPI_MTX -min -add_delay -clock_fall
    # max_delay - 2/3 of SCLK_HALF
    set_output_delay 5 -clock $CLK3_NAME  $SPI_MTX -max -add_delay -clock_fall
    # set multicycle path clock constraints
    set_multicycle_path [expr $SCLK_BR_DIV/2]     -setup -start -from [get_clocks $CLK1_NAME]     -to [get_clocks $CLK3_NAME]
    set_multicycle_path [expr $SCLK_BR_DIV - 1]   -hold  -start -from [get_clocks $CLK1_NAME]     -to [get_clocks $CLK3_NAME]
} else {
    set SPI_MRX $func_pad_names(spi2_miso)
    set SPI_MTX $func_pad_names(spi2_mosi)
    set clk1_input "$func_pad_names(spi2_clk) \
                     $func_pad_names(spi2_mosi) \
                     $func_pad_names(spi2_cs) \
                   "
    set clk2_input  $func_pad_names(spi2_cs) 
    set clk1_output $func_pad_names(spi2_miso) 
    set clk2_output $func_pad_names(spi2_miso)  
    set_input_delay  -min $CLK1_TWOTENTH -clock $CLK1_NAME [get_ports $clk1_input] -add_delay
    set_input_delay  -max $CLK1_ONETHIRD -clock $CLK1_NAME [get_ports $clk1_input] -add_delay
    set_output_delay -min $CLK1_TWOTENTH -clock $CLK1_NAME [get_ports $clk1_output]  -add_delay
    set_output_delay -max $CLK1_ONETHIRD -clock $CLK1_NAME [get_ports $clk1_output]  -add_delay

    set_output_delay -min 0              -clock $CLK1_NAME [get_ports $func_pad_names(spi2_cs)]  -add_delay
    set_output_delay -max 2.0            -clock $CLK1_NAME [get_ports $func_pad_names(spi2_cs)]  -add_delay

    set_multicycle_path  2 -setup -end -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_transmit/i_cdnsspi_fifo_tx/rd_pointer_reg_3_0_/CP -to $func_pad_names(spi2_miso)
    set_multicycle_path  1 -hold -end -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_transmit/i_cdnsspi_fifo_tx/rd_pointer_reg_3_0_/CP -to $func_pad_names(spi2_miso)
    set_multicycle_path  2 -setup -end -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_transmit/i_cdnsspi_fifo_tx/empty_reg/CP -to $func_pad_names(spi2_miso)
    set_multicycle_path  1 -hold -end -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_transmit/i_cdnsspi_fifo_tx/empty_reg/CP -to $func_pad_names(spi2_miso)

    foreach i $func_pad_names(${IP_NAME}_clk) {
        set CLK3_NAME  ${AP_SYS_NAME}_${IP_NAME}_sclk_generated_$i 
        set CLK2_NAME  ${AP_SYS_NAME}_${IP_NAME}_sclk_in_$i
        ####################
        # MISO input delay #
        ####################
        # min_delay - 2/5 of SCLK_HALF
        set_input_delay [expr -0.89 * $CLK3_HALF] -clock $CLK3_NAME  $SPI_MRX -min -add_delay
        # max_delay - 2/3 of SCLK_HALF
        #set_input_delay [expr 0.66 * $CLK3_HALF] -clock $CLK3_NAME  $SPI_MRX -max -add_delay
        set_input_delay 2.43 -clock $CLK3_NAME  $SPI_MRX -max -add_delay
        # min_delay - 2/5 of SCLK_HALF
        set_input_delay [expr -0.89 * $CLK3_HALF] -clock $CLK3_NAME  $SPI_MRX -min -add_delay -clock_fall
        # max_delay - 2/3 of SCLK_HALF
        #set_input_delay [expr 0.66 * $CLK3_HALF] -clock $CLK3_NAME  $SPI_MRX -max -add_delay -clock_fall
        set_input_delay 2.43 -clock $CLK3_NAME  $SPI_MRX -max -add_delay -clock_fall
        set_multicycle_path [expr $SCLK_BR_DIV/2]   -setup -end   -from [get_clocks $CLK3_NAME] -to [get_clocks $CLK1_NAME]
        set_multicycle_path [expr $SCLK_BR_DIV - 1] -hold  -end   -from [get_clocks $CLK3_NAME] -to [get_clocks $CLK1_NAME]

        #####################
        # MOSI output delay #
        #####################
        ## min_delay - 2/5 of SCLK_HALF
        #set_output_delay [expr 0.40 * $CLK3_HALF] -clock $CLK3_NAME  $SPI_MTX -min -add_delay
        ## max_delay - 2/3 of SCLK_HALF
        #set_output_delay [expr 0.66 * $CLK3_HALF] -clock $CLK3_NAME  $SPI_MTX -max -add_delay
        ## min_delay - 2/5 of SCLK_HALF
        #set_output_delay [expr 0.40 * $CLK3_HALF] -clock $CLK3_NAME  $SPI_MTX -min -add_delay -clock_fall
        ## max_delay - 2/3 of SCLK_HALF
        #set_output_delay [expr 0.66 * $CLK3_HALF] -clock $CLK3_NAME  $SPI_MTX -max -add_delay -clock_fall
        ## set multicycle path clock constraints
        # min_delay - 2/5 of SCLK_HALF
        set_output_delay -4 -clock $CLK3_NAME  $SPI_MTX -min -add_delay
        # max_delay - 2/3 of SCLK_HALF
        set_output_delay 5 -clock $CLK3_NAME  $SPI_MTX -max -add_delay
        # min_delay - 2/5 of SCLK_HALF
        set_output_delay -4 -clock $CLK3_NAME  $SPI_MTX -min -add_delay -clock_fall
        # max_delay - 2/3 of SCLK_HALF
        set_output_delay 5 -clock $CLK3_NAME  $SPI_MTX -max -add_delay -clock_fall
        # set multicycle path clock constraints
        set_multicycle_path [expr $SCLK_BR_DIV/2]     -setup -start -from [get_clocks $CLK1_NAME]     -to [get_clocks $CLK3_NAME]
        set_multicycle_path [expr $SCLK_BR_DIV - 1]   -hold  -start -from [get_clocks $CLK1_NAME]     -to [get_clocks $CLK3_NAME]

        set_input_delay  -min 1.5   -clock $CLK2_NAME [get_ports $clk2_input]  -add_delay
        set_input_delay  -max 5     -clock $CLK2_NAME [get_ports $clk2_input]  -add_delay

        set_output_delay -min -3    -clock $CLK2_NAME [get_ports $clk2_output] -add_delay
        set_output_delay -max 3     -clock $CLK2_NAME [get_ports $clk2_output] -add_delay
        set_output_delay -min -3    -clock $CLK2_NAME [get_ports $clk2_output] -add_delay -clock_fall
        set_output_delay -max 3     -clock $CLK2_NAME [get_ports $clk2_output] -add_delay -clock_fall
    }
}

