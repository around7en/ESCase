set CLK1_NAME     ${AP_LIB_HIER}${AP_SYS_NAME}_clk_${IP_NAME}_apb
set CLK2_NAME     ${AP_SYS_NAME}_${IP_NAME}_sclk_in
set CLK1_PERIOD  $CYCLE_102M4
set CLK2_PERIOD  $CYCLE_26M
set CLK1_HALF         [expr 0.50 * $CLK1_PERIOD]
set CLK1_ONETHIRD     [expr 0.33 * $CLK1_PERIOD]
set CLK1_TWOTENTH     [expr 0.20 * $CLK1_PERIOD]

set CLK2_HALF         [expr 0.50 * $CLK2_PERIOD]
set CLK2_ONETHIRD     [expr 0.33 * $CLK2_PERIOD]
set CLK2_TWOTENTH     [expr 0.20 * $CLK2_PERIOD]

set SCLK_BR_DIV 2
if {! $IS_CHIP} {
    set clk1_input " ${IP_NAME}_sclk_in \
                     ${IP_NAME}_mosi_in \
                     ${IP_NAME}_miso_in \
                     ${IP_NAME}_d3_in \
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

    set_input_delay  -min $CLK2_TWOTENTH -clock $CLK2_NAME [get_ports $clk2_input]  -add_delay
    set_input_delay  -max $CLK2_ONETHIRD -clock $CLK2_NAME [get_ports $clk2_input]  -add_delay

    set_output_delay -min $CLK2_TWOTENTH -clock $CLK2_NAME [get_ports $clk2_output] -add_delay
    set_output_delay -max $CLK2_ONETHIRD -clock $CLK2_NAME [get_ports $clk2_output] -add_delay
    set_output_delay -min $CLK2_TWOTENTH -clock $CLK2_NAME [get_ports $clk2_output] -add_delay -clock_fall
    set_output_delay -max $CLK2_ONETHIRD -clock $CLK2_NAME [get_ports $clk2_output] -add_delay -clock_fall
} else {
    set clk1_input "$func_pad_names(cam_spi_clk) \
                    $func_pad_names(cam_spi_d3) \
                    $func_pad_names(cam_spi_d2) \
                    $func_pad_names(cam_spi_d1) \
                    $func_pad_names(cam_spi_d0) \
                   "
    set clk2_input  $func_pad_names(cam_spi_d2) 
    set clk1_output $func_pad_names(cam_spi_d1) 
    set clk2_output $func_pad_names(cam_spi_d1) 
    
    set_input_delay  -min 0              -clock $CLK1_NAME [get_ports $clk1_input] -add_delay
    set_input_delay  -max 2.5            -clock $CLK1_NAME [get_ports $clk1_input] -add_delay

    set_output_delay -min $CLK1_TWOTENTH -clock $CLK1_NAME [get_ports $clk1_output]  -add_delay
    set_output_delay -max $CLK1_ONETHIRD -clock $CLK1_NAME [get_ports $clk1_output]  -add_delay

    set_output_delay -min 0              -clock $CLK1_NAME [get_ports $func_pad_names(cam_spi_d2)]  -add_delay
    set_output_delay -max 2.0            -clock $CLK1_NAME [get_ports $func_pad_names(cam_spi_d2)]  -add_delay

    set_input_delay  -min 0              -clock $CLK2_NAME [get_ports $clk2_input]  -add_delay
    set_input_delay  -max 12             -clock $CLK2_NAME [get_ports $clk2_input]  -add_delay

    set_output_delay -min -3    -clock $CLK2_NAME [get_ports $clk2_output] -add_delay
    set_output_delay -max 3     -clock $CLK2_NAME [get_ports $clk2_output] -add_delay
    set_output_delay -min -3    -clock $CLK2_NAME [get_ports $clk2_output] -add_delay -clock_fall
    set_output_delay -max 3     -clock $CLK2_NAME [get_ports $clk2_output] -add_delay -clock_fall

    set_multicycle_path  2 -setup -end -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi0/i_spi_camera_transmit/i_spi_camera_fifo_tx/rd_pointer_reg_3_0_/CP -to $func_pad_names(cam_spi_d1)
    set_multicycle_path  1 -hold -end -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi0/i_spi_camera_transmit/i_spi_camera_fifo_tx/rd_pointer_reg_3_0_/CP -to $func_pad_names(cam_spi_d1)
    set_multicycle_path  2 -setup -end -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi0/i_spi_camera_transmit/i_spi_camera_fifo_tx/empty_reg/CP -to $func_pad_names(cam_spi_d1)
    set_multicycle_path  1 -hold -end -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi0/i_spi_camera_transmit/i_spi_camera_fifo_tx/empty_reg/CP -to $func_pad_names(cam_spi_d1)
}


