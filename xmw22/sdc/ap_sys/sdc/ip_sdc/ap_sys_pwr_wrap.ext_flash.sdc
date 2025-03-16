if {! $IS_CHIP} {
    set_output_delay [expr 0.25 * $CYCLE_102M4] -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports ext_spi_cs_n_o]
    set_output_delay [expr 0.25 * $CYCLE_102M4] -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports ext_spi_do_o]
    set_output_delay [expr 0.25 * $CYCLE_102M4] -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports ext_spi_do_en_o]
    set_input_delay  [expr 0.25 * $CYCLE_102M4] -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports ext_spi_di_i]
    #fall edge
    set_output_delay [expr 0.25 * $CYCLE_102M4] -max -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports ext_spi_cs_n_o]
    set_output_delay [expr 0.25 * $CYCLE_102M4] -max -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports ext_spi_do_o]
    set_output_delay [expr 0.25 * $CYCLE_102M4] -max -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports ext_spi_do_en_o]
    set_input_delay  [expr 0.25 * $CYCLE_102M4] -max -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports ext_spi_di_i]

    set_output_delay [expr 0.05 * $CYCLE_102M4] -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports ext_spi_cs_n_o]
    set_output_delay [expr 0.05 * $CYCLE_102M4] -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports ext_spi_do_o]
    set_output_delay [expr 0.05 * $CYCLE_102M4] -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports ext_spi_do_en_o]
    set_input_delay  [expr 0.05 * $CYCLE_102M4] -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports ext_spi_di_i]
    #fall edge
    set_output_delay [expr 0.05 * $CYCLE_102M4] -min -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports ext_spi_cs_n_o]
    set_output_delay [expr 0.05 * $CYCLE_102M4] -min -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports ext_spi_do_o]
    set_output_delay [expr 0.05 * $CYCLE_102M4] -min -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports ext_spi_do_en_o]
    set_input_delay  [expr 0.05 * $CYCLE_102M4] -min -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports ext_spi_di_i]
} else {
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_csn)];#QSPICSn, change 5ns to 1 cycle, guaranteed by design 
    set_output_delay -0.4   -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_csn)];#QSPICSn, change 5ns to 1 cycle, guaranteed by design
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io0)];#QSPIDO
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io1)];#QSPIDO
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io2)];#QSPIDO
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io3)];#QSPIDO
    set_output_delay -0.4   -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io0)];#QSPIDO
    set_output_delay -0.4   -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io1)];#QSPIDO
    set_output_delay -0.4   -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io2)];#QSPIDO
    set_output_delay -0.4   -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io3)];#QSPIDO
    set_input_delay   7   -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io0)];#QSPIDI, 7-2cycle=3ns, guaranteed by design sample point delay
    set_input_delay   7   -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io1)];#QSPIDI, 7-2cycle=3ns, guaranteed by design sample point delay
    set_input_delay   7   -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io2)];#QSPIDI, 7-2cycle=3ns, guaranteed by design sample point delay
    set_input_delay   7   -max -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io3)];#QSPIDI, 7-2cycle=3ns, guaranteed by design sample point delay
    set_input_delay   1.5 -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io0)];#QSPIDI 
    set_input_delay   1.5 -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io1)];#QSPIDI
    set_input_delay   1.5 -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io2)];#QSPIDI
    set_input_delay   1.5 -min -clock ${AP_SYS_NAME}_EXT_QSPI_SCK -add_delay [get_ports $func_pad_names(sf1_io3)];#QSPIDI
    #fall edge
    set_output_delay  2   -max -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io0)];#QSPIDO
    set_output_delay  2   -max -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io1)];#QSPIDO
    set_output_delay  2   -max -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io2)];#QSPIDO
    set_output_delay  2   -max -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io3)];#QSPIDO
    set_output_delay -0.4   -min -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io0)];#QSPIDO
    set_output_delay -0.4   -min -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io1)];#QSPIDO
    set_output_delay -0.4   -min -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io2)];#QSPIDO
    set_output_delay -0.4   -min -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io3)];#QSPIDO
    set_input_delay   7   -max -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io0)];#QSPIDI, guaranteed by design sample point delay
    set_input_delay   7   -max -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io1)];#QSPIDI, guaranteed by design sample point delay
    set_input_delay   7   -max -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io2)];#QSPIDI, guaranteed by design sample point delay
    set_input_delay   7   -max -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io3)];#QSPIDI, guaranteed by design sample point delay
    set_input_delay   1.5 -min -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io0)];#QSPIDI
    set_input_delay   1.5 -min -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io1)];#QSPIDI
    set_input_delay   1.5 -min -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io2)];#QSPIDI
    set_input_delay   1.5 -min -clock  ${AP_SYS_NAME}_EXT_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(sf1_io3)];#QSPIDI
    set_multicycle_path  2 -setup -end -from $func_pad_names(sf1_io0)     -to [get_clocks ${AP_LIB_HIER}ap_sys_clk_ap_apb]
    set_multicycle_path  1 -hold  -end -from $func_pad_names(sf1_io0)     -to [get_clocks ${AP_LIB_HIER}ap_sys_clk_ap_apb]
    set_multicycle_path  2 -setup -end -from $func_pad_names(sf1_io1)     -to [get_clocks ${AP_LIB_HIER}ap_sys_clk_ap_apb]
    set_multicycle_path  1 -hold  -end -from $func_pad_names(sf1_io1)     -to [get_clocks ${AP_LIB_HIER}ap_sys_clk_ap_apb]
    set_multicycle_path  2 -setup -end -from $func_pad_names(sf1_io2)     -to [get_clocks ${AP_LIB_HIER}ap_sys_clk_ap_apb]
    set_multicycle_path  1 -hold  -end -from $func_pad_names(sf1_io2)     -to [get_clocks ${AP_LIB_HIER}ap_sys_clk_ap_apb]
    set_multicycle_path  2 -setup -end -from $func_pad_names(sf1_io3)     -to [get_clocks ${AP_LIB_HIER}ap_sys_clk_ap_apb]
    set_multicycle_path  1 -hold  -end -from $func_pad_names(sf1_io3)     -to [get_clocks ${AP_LIB_HIER}ap_sys_clk_ap_apb]
    #if {$IS_FLAT} {    
    #    set_false_path -th u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_ext_qspi_flashc/u_qspi_flashc_fsm/u_buf_cr_sckscale_eq0/cmind_uj_cell/Z
    #}
    if {$IS_FLAT} {    
        set_case_analysis 0 u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_ext_qspi_flashc/u_qspi_flashc_fsm/u_clk_ckmux2/cmind_uj_ckcell/S
    }
}

