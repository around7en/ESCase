set DESIGN(dft,port,ptest_edt_clock)     $func_pad_names(ptest_edt_clock)
set DESIGN(dft,port,ptest_jtag_tck)      $func_pad_names(ptest_jtag_tck)
set DESIGN(dft,port,ptest_scan_clock)    $func_pad_names(ptest_scan_clock)
#set_case_analysis 0 u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_ptest_scan_en/cmind_uj_cell/Z
create_clock -name edt_clock   -period $CYCLE_SCAN -waveform $WAVEF_SCAN   -add $DESIGN(dft,port,ptest_edt_clock)
create_clock -name scan_clock  -period $CYCLE_DC   -waveform $WAVEF_SCAN   -add $DESIGN(dft,port,ptest_scan_clock)
create_clock -name jtag_clock  -period $CYCLE_SCAN -waveform $WAVEF_SCAN   -add $DESIGN(dft,port,ptest_jtag_tck)
set CLOCK_GROUP(edt_clock) [list edt_clock ]
set CLOCK_GROUP(scan_clock) [list scan_clock ]
set CLOCK_GROUP(jtag_clock) [list jtag_clock]


#disable to break scan clock loop
#set_disable_timing -from I  -to Z u_digital_top/u_top_clk_core/u_ptest_slow_clock_occ_buf/proj_top_occ_edt_tessent_occ_dft_internal_clk_u_ptest_slow_clock_occ_buf_inst/tessent_persistent_clk_slow_clock_buf
#set_disable_timing -from I1 -to Z u_digital_top/u_top_clk_core/u_ptest_slow_clock_occ_buf/proj_top_occ_edt_tessent_occ_dft_internal_clk_u_ptest_slow_clock_occ_buf_inst/tessent_persistent_clk_inject_tck_mux
#set_disable_timing -from I  -to Z u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_wrap/u_dbg_clk_core/u_ptest_slow_clock_occ_buf/proj_top_occ_edt_tessent_occ_dft_internal_clk_u_dbg_clk_core_u_ptest_slow_clock_occ_buf_inst/tessent_persistent_clk_slow_clock_buf
set occ_mux_pin [get_object_name [get_pins -hierarchical -quiet -filter "full_name =~ *occ_edt_tessent_occ_*tessent_persistent_clk_clock_out_mux/I1"]]
if {[llength $occ_mux_pin] > 0} {
    set_sense -stop_propagation [get_pins -hierarchical  -filter "full_name =~ *occ_edt_tessent_occ_*tessent_persistent_clk_clock_out_mux/I1"]
}

set jtag_tck_and_list [get_object_name [get_pins -hierarchical -quiet -filter "full_name =~ *controller_inst/MBISTPG_ASYNC_INTERF/tessent_persistent_cell_AND_TCK_RETIME1_IN/Z"]]
if {[llength $jtag_tck_and_list] > 0} {
    set_sense -stop_propagation [get_pins -hierarchical -quiet -filter "full_name =~ *controller_inst/MBISTPG_ASYNC_INTERF/tessent_persistent_cell_AND_TCK_RETIME1_IN/Z"]
}

#set_disable_timing -from IE  -to C u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_CAM_SPI_D0
##stop mbist clock to other function
##edt clock,.,$s:set func_pad_names(\(\w\+\)).*:set_sense -stop_propagation -clocks [get_clock edt_clock] u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_\1/cmind_uj_ckcell/I:gc
#set_sense -stop_propagation -clocks [get_clock edt_clock] u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_gpio15/cmind_uj_cell/I
#set_sense -stop_propagation -clocks [get_clock edt_clock] u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_cam_spi_clk/cmind_uj_ckcell/I
#set_sense -stop_propagation -clocks [get_clock edt_clock] u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_lcd_spi_clk/cmind_uj_ckcell/I
#set_sense -stop_propagation -clocks [get_clock edt_clock] u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_dbgbus12/cmind_uj_cell/I
#set_sense -stop_propagation -clocks [get_clock edt_clock] u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_usbphy_test_clk/cmind_uj_ckcell/I
#
##jtag_clock,.,$s:set func_pad_names(\(\w\+\)).*:set_sense -stop_propagation -clocks [get_clock jtag_clock] u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_\1/cmind_uj_ckcell/I:gc
#set_sense -stop_propagation -clocks [get_clock jtag_clock] u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_swclk/cmind_uj_ckcell/I
#set_sense -stop_propagation -clocks [get_clock jtag_clock] u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_gpio29/cmind_uj_cell/I
