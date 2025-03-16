if {!$IS_CHIP || $IS_FLAT} { 
    set_false_path -th [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_dbg_bus/data_bit*?u_cmind_cell_buf/cmind_uj_cell/Z]
    #set_sense -stop_propagation [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_dbg_bus/u_clk_*_cka/cmind_uj_ckcell/A1]
    set_sense -stop_propagation [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_dbg_bus/u_utmi_clk_cka/cmind_uj_ckcell/A1]
    set_sense -stop_propagation [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi0/i_spi_camera_control/cdnsspi_sclk_in_idle_sync1/gen_sync?0??inst_async_reset?i_cdns_syncflop/cmind_sync_buf2?bit2?0??genblk1?sync2_rst0?sig_in_sync0_reg/cmind_uj_cell/D]
    set_sense -stop_propagation [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi0/i_spi_camera_slavesync/cdnsspi_slave_clk_sync1/gen_sync?0??inst_async_reset?i_cdns_syncflop/cmind_sync_buf2?bit2?0??genblk1?sync2_rst0?sig_in_sync0_reg/cmind_uj_cell/D]
    set_sense -stop_propagation [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi1/i_spi_display_control/cdnsspi_sclk_in_idle_sync1/gen_sync?0??inst_async_reset?i_cdns_syncflop/cmind_sync_buf2?bit2?0??genblk1?sync2_rst0?sig_in_sync0_reg/cmind_uj_cell/D]
    set_sense -stop_propagation [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi1/i_spi_display_slavesync/cdnsspi_slave_clk_sync1/gen_sync?0??inst_async_reset?i_cdns_syncflop/cmind_sync_buf2?bit2?0??genblk1?sync2_rst0?sig_in_sync0_reg/cmind_uj_cell/D]
    set_sense -stop_propagation [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_control/cdnsspi_sclk_in_idle_sync1/gen_sync?0??inst_async_reset?i_cdns_syncflop/cmind_sync_buf2?bit2?0??genblk1?sync2_rst0?sig_in_sync0_reg/cmind_uj_cell/D]
    set_sense -stop_propagation [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_slavesync/cdnsspi_slave_clk_sync1/gen_sync?0??inst_async_reset?i_cdns_syncflop/cmind_sync_buf2?bit2?0??genblk1?sync2_rst0?sig_in_sync0_reg/cmind_uj_cell/D]
    set_sense -stop_propagation [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_control/sclk_out_reg/D]
}

if {$IS_CHIP} {
    #set_sense -stop_propagation -clocks [get_clocks ${AP_SYS_NAME}_spi0_sclk_generated] [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_CAM_SPI_CLK/C]
    foreach i $func_pad_names(lcd_spi_clk) {
        set_sense -stop_propagation -clocks [get_clocks ${AP_SYS_NAME}_spi1_sclk_generated_$i] [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_$i/C]
    }
    foreach i $func_pad_names(spi2_clk) {
        set_sense -stop_propagation -clocks [get_clocks ${AP_SYS_NAME}_spi2_sclk_generated_$i] [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_$i/C]
    }
    set_sense -stop_propagation -clocks [get_clocks ap_sys_sim1_clk] [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SIM1_CLK/C]
    set_sense -stop_propagation -clocks [get_clocks ap_sys_sim0_clk] [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SIM0_CLK/C]
    set_sense -stop_propagation -clocks [get_clocks ap_sys_QSPI_SCK_D3] [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SF0_IO3/C]
    set_sense -stop_propagation -clocks [get_clocks ap_sys_QSPI_SCK] [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SF0_SCK/C]
    set_sense -stop_propagation -clocks [get_clocks ap_sys_QSPI_SCK] [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SF0_SCK/C]
   #set_sense -stop_propagation -clocks [get_clocks ap_sys_clk_sdio0_mux_div1_pad] [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_CLK/C]
   #set_sense -stop_propagation -clocks [get_clocks ap_sys_clk_sdio0_mux_div2_pad] [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_CLK/C]
   #set_sense -stop_propagation -clocks [get_clocks ap_sys_clk_sdio0_mux_div4_pad] [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_CLK/C]

    set_false_path -th [get_pins u_digital_top/u_ap_sys_pwr_wrap/spi*_miso_oen] -from ${AP_LIB_HIER}ap_sys_clk_i2s0 -th u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_MISO/OE 
    set_false_path -th [get_pins u_digital_top/u_ap_sys_pwr_wrap/spi*_miso_oen] -from ap_sys_clk_sdio0_mux_div4_pad -th u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_MISO/OE 
    set_false_path -th [get_pins u_digital_top/u_ap_sys_pwr_wrap/spi*_miso_oen] -from ap_sys_clk_sdio0_mux_div2_pad -th u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_MISO/OE 
    set_false_path -th [get_pins u_digital_top/u_ap_sys_pwr_wrap/spi*_miso_oen] -from ap_sys_clk_sdio0_mux_div1_pad -th u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_MISO/OE 
    set_false_path -th [get_pins u_digital_top/u_ap_sys_pwr_wrap/spi*_miso_oen] -from ap_sys_EXT_QSPI_SCK -th u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_MISO/OE 
    set_false_path -th [get_pins u_digital_top/u_ap_sys_pwr_wrap/spi*_miso_oen] -from ${AP_LIB_HIER}ap_sys_clk_i2c2_apb -th u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_MISO/OE 
    set_false_path -th [get_pins u_digital_top/u_ap_sys_pwr_wrap/spi*_miso_oen] -from ${AP_LIB_HIER}ap_sys_clk_i2s0 -th u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_EXTINT0/OE 
    set_false_path -th [get_pins u_digital_top/u_ap_sys_pwr_wrap/spi*_miso_oen] -from ${AP_LIB_HIER}ap_sys_clk_i2c2_apb -th u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_EXTINT0/OE 
    set_false_path -th [get_pins u_digital_top/u_ap_sys_pwr_wrap/spi*_miso_oen] -from ${AP_LIB_HIER}ap_sys_clk_i2c2_apb -th u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_CAM_SPI_D0/OE 
    set_false_path -th [get_pins u_digital_top/u_ap_sys_pwr_wrap/spi*_miso_oen] -from CAM_SPI_D0  -th u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_CAM_SPI_D0/OE 
   # set spi2_pad_list " \
   # u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_CSN/C u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_IISDI/OE \
   # u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_IISLRCLK/C u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_IISDI/OE \
   # u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_EXTINT4/C u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_IISDI/OE \
   # "
   # 
   # foreach {sp ep} $spi2_pad_list {
   # set_multicycle_path 2 -setup -through $sp \
   #                              -through u_digital_top/u_ap_sys_pwr_wrap/spi2_nss_in                      \
   #                              -through u_digital_top/u_ap_sys_pwr_wrap/spi2_miso_oen                    \
   #                              -through $ep    \
   #                              -start
   # set_multicycle_path 1 -hold  -through $sp  \
   #                              -through u_digital_top/u_ap_sys_pwr_wrap/spi2_nss_in                      \
   #                              -through u_digital_top/u_ap_sys_pwr_wrap/spi2_miso_oen                    \
   #                              -through $ep    \
   #                              -start                
   # }

    if {$IS_FLAT} { 
        set_false_path -from [get_ports IISCLK] -to [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_control/cdnsspi_sclk_in_idle_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D] 
        #set_false_path -from [get_ports IISCLK] -to [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_slavesync/cdnsspi_slave_clk_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D] 

        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_apb/remap_en_reg/CP ]   -to ap_sys_QSPI_SCK
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_apb/remap_en_reg/CP ]   -to ap_sys_QSPI_SCK_D3
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_apb/remap_type_reg/CP] -to SF0_SCK 
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_apb/remap_type_reg/CP] -to SF0_IO3 
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_apb/d23_force_en_reg/CP] -to SF0_IO2 
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_apb/d23_force_en_reg/CP] -to SF0_SCK 
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_apb/d23_force_en_reg/CP] -to SF0_IO3 

        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/spi_enable_o_reg/CP] -to [get_ports -filter {direction == inout}]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/spi_enable_o_reg/CP] -to [get_ports SPI2_MOSI]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/spi_enable_o_reg/CP] -to [get_ports EXTINT1]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/spi_enable_o_reg/CP] -to [get_ports CAM_SPI_D1]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/spi_enable_o_reg/CP] -to [get_ports IISLRCLK]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/spi_enable_o_reg/CP] -to [get_ports IISDO]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/spi_enable_o_reg/CP] -to [get_ports SPI2_CSN]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/config_reg_reg*/CP] -to [get_ports -filter {direction == inout}]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/config_reg_reg*/CP] -to [get_ports CAM_SPI_D1]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/config_reg_reg*/CP] -to [get_ports CAM_PWD]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/config_reg_reg*/CP] -to [get_ports EXTINT4]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/config_reg_reg*/CP] -to [get_ports SPI2_MOSI]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/config_reg_reg*/CP] -to [get_ports EXTINT1]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/config_reg_reg*/CP] -to [get_ports CAM_SPI_D2]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/config_reg_reg*/CP] -to [get_ports IISLRCLK]
 #      set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_registers/config_reg_reg*/CP] -to [get_ports IISLRCLK]

        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_control/busfree_counter_reg_*_/CP]  -to [get_ports SPI2_MOSI]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_control/busfree_counter_reg_*_/CP]  -to [get_ports EXTINT1]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_control/busfree_counter_reg_*_/CP]  -to [get_ports SPI2_CSN]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_control/busfree_counter_reg_*_/CP]  -to [get_ports IISLRCLK]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_control/busfree_counter_reg_*_/CP]  -to [get_ports CAM_SPI_D1]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_control/busfree_counter_reg_*_/CP]  -to [get_ports EXTINT4]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi*/i_*_control/busfree_counter_reg_*_/CP]  -to [get_ports IISDO]

        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_slavesync/cdnsspi_n_ss_in_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_ports EXTINT4] 
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_slavesync/cdnsspi_n_ss_in_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_ports IISLRCLK] 
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_slavesync/cdnsspi_n_ss_in_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_ports SPI2_CSN] 
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_slavesync/cdnsspi_n_ss_in_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_ports IISDO] 

        set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/qspi_sck_o_pre_reg/CP -to [get_clocks ap_sys_QSPI_SCK]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi1/i_spi_display_slavesync/cdnsspi_n_ss_in_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_ports SPI2_MOSI]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi1/i_spi_display_slavesync/cdnsspi_n_ss_in_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_ports CAM_SPI_D1]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_slavesync/cdnsspi_n_ss_in_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_ports SPI2_MOSI]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi1/i_spi_display_slavesync/cdnsspi_n_ss_in_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_ports EXTINT1]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi1/i_spi_display_slavesync/cdnsspi_n_ss_in_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_ports U0CTSN]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi0/i_spi_camera_slavesync/cdnsspi_n_ss_in_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_ports CAM_SPI_D1]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_slavesync/cdnsspi_n_ss_in_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_ports EXTINT1]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_slavesync/cdnsspi_n_ss_in_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_ports IISLRCLK]

        set_false_path -from ap_sys_EXT_QSPI_SCK -to [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/d_data*_in_syn_reg/D]
        set_false_path -from ap_sys_EXT_QSPI_SCK -to [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/slot_int_sts_reg/D]
        set_false_path -from ap_sys_EXT_QSPI_SCK -to [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/d_card_int_1_4_8_reg/D]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/slot_type_r_reg*/CP] -to ap_sys_EXT_QSPI_SCK 
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_slavetx/s_txsel_reg*/CP] -to ap_sys_clk_sdio0_mux_div4_pad  
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_slavetx/s_txsel_reg*/CP] -to ap_sys_clk_sdio0_mux_div2_pad  
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_slavetx/s_txsel_reg*/CP] -to ap_sys_clk_sdio0_mux_div1_pad  

        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/legacy_sd8_mode_reg/CP] -to [get_ports KEYIN1]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/legacy_sd8_mode_reg/CP] -to [get_ports SPI2_MISO]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/legacy_sd8_mode_reg/CP] -to [get_ports SPI2_CSN]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/legacy_sd8_mode_reg/CP] -to [get_ports KEYOUT1]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/legacy_sd8_mode_reg/CP] -to [get_ports SPI2_MOSI]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/sd4_mode_reg/CP] -to [get_ports KEYIN1]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/sd4_mode_reg/CP] -to [get_ports SPI2_MISO]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/sd4_mode_reg/CP] -to [get_ports SPI2_CSN]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/sd4_mode_reg/CP] -to [get_ports KEYOUT1]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/sd4_mode_reg/CP] -to [get_ports SPI2_MOSI]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/high_speed_reg/CP] -to [get_ports KEYIN1]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/high_speed_reg/CP] -to [get_ports SPI2_MISO]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/high_speed_reg/CP] -to [get_ports SPI2_CSN]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/high_speed_reg/CP] -to [get_ports KEYOUT1]
        set_false_path -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_reg_ctrl1/high_speed_reg/CP] -to [get_ports SPI2_MOSI]
        set_false_path -th u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/u_sck_out/cmind_uj_ckcell/Z -th u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SF0_SCK/A -to ap_sys_QSPI_SCK_D3
        set_false_path -th u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/u_sck_out/cmind_uj_ckcell/Z -th u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SF0_IO3/A -to ap_sys_QSPI_SCK
        set_false_path -th u_digital_top/u_dbg_sys_top/data_bit_7__u_cmind_cell_buf/cmind_uj_cell/Z -to [get_ports SIM1_RST]
        set_multicycle_path 2 -setup -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_clk_core_top/u_ap_clk_core_reg/frc_*_clk_top_ahb_scan_reg/CP] -to [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_main_mtx_wrap/u_ahb_anti_hang_s1/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
        set_multicycle_path 1 -hold -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_clk_core_top/u_ap_clk_core_reg/frc_*_clk_top_ahb_scan_reg/CP] -to [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_main_mtx_wrap/u_ahb_anti_hang_s1/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
        set_multicycle_path 2 -setup -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_clk_core_top/u_ap_clk_core_reg/frc_*_clk_pub_ahb_scan_reg/CP] -to [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_main_mtx_wrap/u_ahb_anti_hang_s2/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
        set_multicycle_path 1 -hold -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_clk_core_top/u_ap_clk_core_reg/frc_*_clk_pub_ahb_scan_reg/CP] -to [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_main_mtx_wrap/u_ahb_anti_hang_s2/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
        set_multicycle_path 2 -setup -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_clk_core_top/u_ap_clk_core_reg/frc_*_clk_sysram_ahb_scan_reg/CP] -to [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_main_mtx_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
        set_multicycle_path 1 -hold -from [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_clk_core_top/u_ap_clk_core_reg/frc_*_clk_sysram_ahb_scan_reg/CP] -to [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_main_mtx_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
    }
}

if {!$IS_CHIP || $IS_FLAT} { 
    source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.dubhe.sdc
    set mem_lists [get_object_name [get_cells * -hierarchical -filter "(is_memory_cell == true) && (ref_name =~ *T22ARF2*)"]]
    foreach mem_list $mem_lists {
        set_disable_timing $mem_list -from CLKA -to CLKB
        set_disable_timing $mem_list -from CLKB -to CLKA
    }
    set mem_lists [get_object_name [get_cells * -hierarchical -filter "(is_memory_cell == true) && (ref_name =~ *T22ARAD*)"]]
    foreach mem_list $mem_lists {
    set_disable_timing $mem_list -from CLKA -to CLKB
    set_disable_timing $mem_list -from CLKB -to CLKA
    }
}

if {! $IS_CHIP} {
    set_false_path -to [get_ports apsys_shutdown_ack_n]
    set_false_path -from [get_ports apsys_shutdown_n]
} else {
    set_false_path -th [get_pins ${AP_SYS_HIER}apsys_shutdown_ack_n]
    set_false_path -th [get_pins ${AP_SYS_HIER}apsys_shutdown_n]
}

if {!$IS_CHIP || $IS_FLAT} {
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_dubheram_top/u_ra1up_ema_0/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_dubheram_top/u_ra1up_ema_1/cmind_uj_cell/Z] 
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_dubheram_top/u_ra1up_ema_2/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_dubheram_top/u_ra1up_emaw_0/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_dubheram_top/u_ra1up_emaw_1/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_dubheram_top/u_ra1up_emas/cmind_uj_cell/Z] 
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_dubheram_top/u_ra1up_rawl/cmind_uj_cell/Z] 
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_dubheram_top/u_ra1up_rawlm_0/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_dubheram_top/u_ra1up_rawlm_1/cmind_uj_cell/Z] 
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_dubheram_top/u_ra1up_wabl/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_dubheram_top/u_ra1up_wablm_0/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_dubheram_top/u_ra1up_wablm_1/cmind_uj_cell/Z] 
    
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_adma/u_rf1hp_ema_0/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_adma/u_rf1hp_ema_1/cmind_uj_cell/Z] 
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_adma/u_rf1hp_ema_2/cmind_uj_cell/Z] 
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_adma/u_rf1hp_emaw_0/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_adma/u_rf1hp_emaw_1/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_adma/u_rf1hp_emas/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_adma/u_rf1hp_rawl/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_adma/u_rf1hp_rawlm_0/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_adma/u_rf1hp_rawlm_1/cmind_uj_cell/Z] 
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_adma/u_rf1hp_wabl/cmind_uj_cell/Z] 
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_adma/u_rf1hp_wablm_0/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_adma/u_rf1hp_wablm_1/cmind_uj_cell/Z] 
    
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_in/u_rf2hp_emaa_0/cmind_uj_cell/Z] 
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_in/u_rf2hp_emaa_1/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_in/u_rf2hp_emaa_2/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_in/u_rf2hp_emab_0/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_in/u_rf2hp_emab_1/cmind_uj_cell/Z] 
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_in/u_rf2hp_emab_2/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_in/u_rf2hp_emasa/cmind_uj_cell/Z] 
    
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_out/u_rf2hp_emaa_0/cmind_uj_cell/Z] 
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_out/u_rf2hp_emaa_1/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_out/u_rf2hp_emaa_2/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_out/u_rf2hp_emab_0/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_out/u_rf2hp_emab_1/cmind_uj_cell/Z] 
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_out/u_rf2hp_emab_2/cmind_uj_cell/Z] 
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_ram_top/u_apsys_usbhs_out/u_rf2hp_emasa/cmind_uj_cell/Z] 
    
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram1/u_radhp_emaa_2/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram1/u_radhp_emaa_1/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram1/u_radhp_emaa_0/cmind_uj_cell/Z]
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram1/u_radhp_emawa_1/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram1/u_radhp_emawa_0/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram1/u_radhp_emasa/cmind_uj_cell/Z]
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram1/u_radhp_emab_2/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram1/u_radhp_emab_1/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram1/u_radhp_emab_0/cmind_uj_cell/Z]
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram1/u_radhp_emawb_1/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram1/u_radhp_emawb_0/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram1/u_radhp_emasb/cmind_uj_cell/Z]
    
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram2/u_radhp_emaa_2/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram2/u_radhp_emaa_1/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram2/u_radhp_emaa_0/cmind_uj_cell/Z]
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram2/u_radhp_emawa_1/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram2/u_radhp_emawa_0/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram2/u_radhp_emasa/cmind_uj_cell/Z]
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram2/u_radhp_emab_2/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram2/u_radhp_emab_1/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram2/u_radhp_emab_0/cmind_uj_cell/Z]
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram2/u_radhp_emawb_1/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram2/u_radhp_emawb_0/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ram_wrap/ram2/u_radhp_emasb/cmind_uj_cell/Z]
    
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN0/u_can_ram_top/u_rf2hp_emaa_0/cmind_uj_cell/Z]
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN0/u_can_ram_top/u_rf2hp_emaa_1/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN0/u_can_ram_top/u_rf2hp_emaa_2/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN0/u_can_ram_top/u_rf2hp_emab_0/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN0/u_can_ram_top/u_rf2hp_emab_1/cmind_uj_cell/Z]
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN0/u_can_ram_top/u_rf2hp_emab_2/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN0/u_can_ram_top/u_rf2hp_emasa/cmind_uj_cell/Z]
    
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN1/u_can_ram_top/u_rf2hp_emaa_0/cmind_uj_cell/Z]
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN1/u_can_ram_top/u_rf2hp_emaa_1/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN1/u_can_ram_top/u_rf2hp_emaa_2/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN1/u_can_ram_top/u_rf2hp_emab_0/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN1/u_can_ram_top/u_rf2hp_emab_1/cmind_uj_cell/Z]
    set_case_analysis 1 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN1/u_can_ram_top/u_rf2hp_emab_2/cmind_uj_cell/Z]
    set_case_analysis 0 [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_CAN1/u_can_ram_top/u_rf2hp_emasa/cmind_uj_cell/Z]
}
#$uart 
# Add inter clock domain max timing - if domains are asynchronous
##################################################
# Set path delay constraints (in place of set_false_paths)
set_max_delay [expr $CYCLE_76M8] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb -to ${AP_LIB_HIER}${AP_SYS_NAME}_clk_uart1
set_max_delay [expr $CYCLE_102M4] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_uart1 -to ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb

set_min_delay [expr $CYCLE_76M8/100] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb -to ${AP_LIB_HIER}${AP_SYS_NAME}_clk_uart1
set_min_delay [expr $CYCLE_102M4/100] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_uart1 -to ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb

set_max_delay [expr $CYCLE_76M8] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb -to ${AP_LIB_HIER}${AP_SYS_NAME}_clk_uart4
set_max_delay [expr $CYCLE_102M4] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_uart4 -to ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb

set_min_delay [expr $CYCLE_76M8/100] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb -to ${AP_LIB_HIER}${AP_SYS_NAME}_clk_uart4
set_min_delay [expr $CYCLE_102M4/100] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_uart4 -to ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb

set_max_delay [expr $CYCLE_76M8] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb -to ${AP_LIB_HIER}${AP_SYS_NAME}_clk_uart5
set_max_delay [expr $CYCLE_102M4] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_uart5 -to ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb

set_min_delay [expr $CYCLE_76M8/100] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb -to ${AP_LIB_HIER}${AP_SYS_NAME}_clk_uart5
set_min_delay [expr $CYCLE_102M4/100] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_uart5 -to ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ap_apb
#spi0
set IP_NAME spi0
set CLK1_PERIOD  $CYCLE_102M4
set CLK1_HALF         [expr 0.50 * $CLK1_PERIOD]
set CLK1_ONETHIRD     [expr 0.33 * $CLK1_PERIOD]
set CLK1_TWOTENTH     [expr 0.20 * $CLK1_PERIOD]

set CLK2_PERIOD $CYCLE_51M2
set CLK2_HALF         [expr 0.50 * $CLK2_PERIOD]
set CLK2_ONETHIRD     [expr 0.33 * $CLK2_PERIOD]
set CLK2_TWOTENTH     [expr 0.20 * $CLK2_PERIOD]

#if {! $IS_CHIP} {
#    set_max_delay [expr $CLK2_HALF + $CLK1_HALF + 1] -from ${AP_SYS_HIER}spi0_nss_in -to ${AP_SYS_HIER}spi0_miso_oen
#    set_min_delay 0.00                               -from ${AP_SYS_HIER}spi0_nss_in -to ${AP_SYS_HIER}spi0_miso_oen
#} else {
#    set_max_delay [expr $CLK2_HALF + $CLK1_HALF + 1] -th [get_ports $func_pad_names(cam_spi_d2)] -from ap_sys_spi0_sclk_in -to [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_CAM_SPI_D1/OE]
#    set_min_delay 0.00                               -th [get_ports $func_pad_names(cam_spi_d2)] -from ap_sys_spi0_sclk_in -to [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_CAM_SPI_D1/OE]
#    #set_false_path -th [get_ports $func_pad_names(cam_spi_d2)] -from  ${AP_SYS_NAME}_clk_${IP_NAME}_apb -to ${AP_SYS_NAME}_${IP_NAME}_sclk_generated
#}

#spi1
set IP_NAME spi1
set CLK1_PERIOD  $CYCLE_102M4
set CLK1_HALF         [expr 0.50 * $CLK1_PERIOD]
set CLK1_ONETHIRD     [expr 0.33 * $CLK1_PERIOD]
set CLK1_TWOTENTH     [expr 0.20 * $CLK1_PERIOD]

set CLK2_PERIOD $CYCLE_51M2
set CLK2_HALF         [expr 0.50 * $CLK2_PERIOD]
set CLK2_ONETHIRD     [expr 0.33 * $CLK2_PERIOD]
set CLK2_TWOTENTH     [expr 0.20 * $CLK2_PERIOD]

if {! $IS_CHIP} {
    #set_max_delay [expr $CLK2_HALF + $CLK1_HALF + 1] -from ${AP_SYS_HIER}spi1_nss_in -to ${AP_SYS_HIER}spi1_miso_oen
    #set_min_delay 0.00                               -from ${AP_SYS_HIER}spi1_nss_in -to ${AP_SYS_HIER}spi1_miso_oen
} else {
    #set_max_delay [expr $CLK2_HALF + $CLK1_HALF + 1] -from [get_ports $func_pad_names(lcd_spi_cs)] -to [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_CAM_SPI_D0/OE]
    #set_min_delay 0.00                               -from [get_ports $func_pad_names(lcd_spi_cs)] -to [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_CAM_SPI_D0/OE]
    #set_max_delay [expr $CLK2_HALF + $CLK1_HALF + 1] -from [get_ports $func_pad_names(lcd_spi_cs)] -to [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_EXTINT0/OE]
    #set_min_delay 0.00                               -from [get_ports $func_pad_names(lcd_spi_cs)] -to [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_EXTINT0/OE]
    #set_max_delay [expr $CLK2_HALF + $CLK1_HALF + 1] -from [get_ports $func_pad_names(lcd_spi_cs)] -to [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_MISO/OE]
    #set_min_delay 0.00                               -from [get_ports $func_pad_names(lcd_spi_cs)] -to [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_MISO/OE]
    foreach i $func_pad_names(lcd_spi_clk) {
        set_false_path -th [get_ports $func_pad_names(lcd_spi_miso)] -from  ${AP_LIB_HIER}${AP_SYS_NAME}_clk_${IP_NAME}_apb_gate -to ${AP_SYS_NAME}_spi1_sclk_generated_$i 
        if {$IS_FLAT} {
            set_false_path  -from ${AP_SYS_NAME}_spi1_sclk_generated_$i -to [get_pins u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_peri_top/u_spi1/i_spi_display_slavesync/cdnsspi_si_sync1/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
        }
    }
}

#spi2
#spi2
set IP_NAME spi2
set CLK1_PERIOD  $CYCLE_102M4
set CLK1_HALF         [expr 0.50 * $CLK1_PERIOD]
set CLK1_ONETHIRD     [expr 0.33 * $CLK1_PERIOD]
set CLK1_TWOTENTH     [expr 0.20 * $CLK1_PERIOD]

set CLK2_PERIOD $CYCLE_51M2
set CLK2_HALF         [expr 0.50 * $CLK2_PERIOD]
set CLK2_ONETHIRD     [expr 0.33 * $CLK2_PERIOD]
set CLK2_TWOTENTH     [expr 0.20 * $CLK2_PERIOD]

if {! $IS_CHIP} {
    set_max_delay [expr $CLK2_HALF + $CLK1_HALF + 1] -from ${AP_SYS_HIER}spi2_nss_in -to ${AP_SYS_HIER}spi2_miso_oen
    set_min_delay 0.00                               -from ${AP_SYS_HIER}spi2_nss_in -to ${AP_SYS_HIER}spi2_miso_oen
} else {
    foreach i $func_pad_names(${IP_NAME}_clk) {
        set CLK2_NAME  ${AP_SYS_NAME}_${IP_NAME}_sclk_in_$i
        set_max_delay [expr $CLK2_HALF + $CLK1_HALF + 1] -from $CLK2_NAME  -th [get_ports $func_pad_names(spi2_cs)] -to  [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_MISO/OE]
        set_min_delay 0.00                               -from $CLK2_NAME  -th [get_ports $func_pad_names(spi2_cs)] -to  [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_SPI2_MISO/OE]
        set_max_delay [expr $CLK2_HALF + $CLK1_HALF + 1] -from $CLK2_NAME  -th [get_ports $func_pad_names(spi2_cs)] -to  [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_IISDI/OE]
        set_min_delay 0.00                               -from $CLK2_NAME  -th [get_ports $func_pad_names(spi2_cs)] -to  [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_IISDI/OE]
        set_max_delay [expr $CLK2_HALF + $CLK1_HALF + 1] -from $CLK2_NAME  -th [get_ports $func_pad_names(spi2_cs)] -to  [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_EXTINT0/OE]
        set_min_delay 0.00                               -from $CLK2_NAME  -th [get_ports $func_pad_names(spi2_cs)] -to  [get_pins u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_EXTINT0/OE]
    }
    foreach i $func_pad_names(spi2_clk) {
        set_false_path -th [get_ports $func_pad_names(spi2_miso)] -from ${AP_LIB_HIER}${AP_SYS_NAME}_clk_${IP_NAME}_apb_gate -to ${AP_SYS_NAME}_spi2_sclk_generated_$i
    }
}
                                                                                                              
