#modify io clock variable when you need
set clk_auxclk1_IISMCK_out                   top_aux_clk_top_aux1
#set clk_iisclk_IISCLK_in                     clk_iisclk_IISCLK_in
set clk_iisclk_IISCLK_out                    ap_sys_clk_i2s0_sck_generated_pad
set clk_spi2_clk_IISCLK_in                   ap_sys_spi2_sclk_in_IISCLK
set clk_spi2_clk_IISCLK_out                  ap_sys_spi2_sclk_generated_IISCLK
set clk_spi2_clk_EXTINT3_in                  ap_sys_spi2_sclk_in_EXTINT3
set clk_spi2_clk_EXTINT3_out                 ap_sys_spi2_sclk_generated_EXTINT3
set clk_spi2_clk_SPI2_CLK_in                 ap_sys_spi2_sclk_in_SPI2_CLK
set clk_spi2_clk_SPI2_CLK_out                ap_sys_spi2_sclk_generated_SPI2_CLK
set clk_pdm_clk_IIC2_SDA_out                 "ap_sys_clk_pdm_clk_mux_div2_pad_IIC2_SDA ap_sys_clk_pdm_clk_mux_div1_pad_IIC2_SDA"
set clk_pdm_clk_FEIO6_out                    "ap_sys_clk_pdm_clk_mux_div2_pad_FEIO6 ap_sys_clk_pdm_clk_mux_div1_pad_FEIO6"
set clk_sim1_clk_SIM1_CLK_out                ap_sys_sim1_clk
set clk_sim0_clk_SIM0_CLK_out                ap_sys_sim0_clk
#set clk_qspi_sck_d3_SF0_SCK_in               clk_qspi_sck_d3_SF0_SCK_in
set clk_qspi_sck_d3_SF0_SCK_out              ap_sys_QSPI_SCK
set clk_cam_spi_clk_CAM_SPI_CLK_in           ap_sys_spi0_sclk_in
#set clk_cam_spi_clk_CAM_SPI_CLK_out          clk_cam_spi_clk_CAM_SPI_CLK_out
#set clk_lcd_spi_clk_CAM_SPI_CLK_in           clk_lcd_spi_clk_CAM_SPI_CLK_in
set clk_lcd_spi_clk_CAM_SPI_CLK_out          ap_sys_spi1_sclk_generated_CAM_SPI_CLK
#set clk_lcd_spi_clk_U0RTSN_in                clk_lcd_spi_clk_U0RTSN_in
set clk_lcd_spi_clk_U0RTSN_out               ap_sys_spi1_sclk_generated_U0RTSN
#set clk_lcd_spi_clk_EXTINT3_in               clk_lcd_spi_clk_EXTINT3_in
set clk_lcd_spi_clk_EXTINT3_out              ap_sys_spi1_sclk_generated_EXTINT3
#set clk_lcd_spi_clk_SPI2_CLK_in              clk_lcd_spi_clk_SPI2_CLK_in
set clk_lcd_spi_clk_SPI2_CLK_out             ap_sys_spi1_sclk_generated_SPI2_CLK
set clk_ptest_edt_clock_CAM_SPI_CLK_in       edt_clock
set clk_usbphy_test_clk_CAM_SPI_CLK_in       ap_sys_usbphy_test_clk
set clk_hsdl_clk_SPI2_CLK_out                cp_sys_clk_hsdl 
set clk_auxclk2_CAM_MCLK_out                 top_aux_clk_top_aux2
set clk_ptest_scan_clock_CAM_MCLK_in         scan_clock
set clk_swclk_SWCLK_in                       cpu_sys_jtag_clk
set clk_ptest_jtag_tck_SWCLK_in              jtag_clock
set clk_psram_ck_CLK_out                     CK_O
#set clk_psram_ck_n_CLKB_out                  clk_psram_ck_n_CLKB_out
set clk_psram_dqs_DQS_in                     DQS0
set clk_psram_dqs_DQS_out                    DQS_CK
set clk_auxclk0_AUXCLK0_out                  top_aux_clk_top_aux0
set clk_rffe_clk_FEIO0_out                   cp_sys_clk_mipi_o_scl
set clk_sd_clk_SPI2_CLK_out                  "ap_sys_clk_sdio0_mux_div1_pad ap_sys_clk_sdio0_mux_div2_pad ap_sys_clk_sdio0_mux_div4_pad"
#set clk_sf1_clk_SPI2_CLK_in                  clk_sf1_clk_SPI2_CLK_in
set clk_sf1_clk_SPI2_CLK_out                 ap_sys_EXT_QSPI_SCK
set clk_tlb_sclk_SPI2_CLK_in                 clk_tlb_sclk_pad_in
#create_clock -name clk_iisclk_IISCLK_in           -period $CYCLE_12M288         -add [get_ports IISCLK]
#lappend CLOCK_GROUP($clk_iisclk_IISCLK_in) clk_iisclk_IISCLK_in
#create_clock -name clk_spi2_clk_IISCLK_in         -period $CYCLE_51M2           -add [get_ports SPI2_CLK]
#lappend CLOCK_GROUP($clk_spi2_clk_IISCLK_in) clk_spi2_clk_IISCLK_in
#create_clock -name clk_spi2_clk_EXTINT3_in        -period $CYCLE_51M2           -add [get_ports SPI2_CLK]
#lappend CLOCK_GROUP($clk_spi2_clk_EXTINT3_in) clk_spi2_clk_EXTINT3_in
#create_clock -name clk_spi2_clk_SPI2_CLK_in       -period $CYCLE_51M2           -add [get_ports SPI2_CLK]
#lappend CLOCK_GROUP($clk_spi2_clk_SPI2_CLK_in) clk_spi2_clk_SPI2_CLK_in
#create_clock -name clk_qspi_sck_d3_SF0_SCK_in     -period $CYCLE_153M6          -add [get_ports SF0_SCK]
#lappend CLOCK_GROUP($clk_qspi_sck_d3_SF0_SCK_in) clk_qspi_sck_d3_SF0_SCK_in
#create_clock -name clk_cam_spi_clk_CAM_SPI_CLK_in -period $CYCLE_26M            -add [get_ports CAM_SPI_CLK]
#lappend CLOCK_GROUP($clk_cam_spi_clk_CAM_SPI_CLK_in) clk_cam_spi_clk_CAM_SPI_CLK_in
#create_clock -name clk_lcd_spi_clk_CAM_SPI_CLK_in -period $CYCLE_51M2           -add [get_ports SPI2_CLK]
#lappend CLOCK_GROUP($clk_lcd_spi_clk_CAM_SPI_CLK_in) clk_lcd_spi_clk_CAM_SPI_CLK_in
#create_clock -name clk_lcd_spi_clk_U0RTSN_in      -period $CYCLE_51M2           -add [get_ports SPI2_CLK]
#lappend CLOCK_GROUP($clk_lcd_spi_clk_U0RTSN_in) clk_lcd_spi_clk_U0RTSN_in
#create_clock -name clk_lcd_spi_clk_EXTINT3_in     -period $CYCLE_51M2           -add [get_ports SPI2_CLK]
#lappend CLOCK_GROUP($clk_lcd_spi_clk_EXTINT3_in) clk_lcd_spi_clk_EXTINT3_in
#create_clock -name clk_lcd_spi_clk_SPI2_CLK_in    -period $CYCLE_51M2           -add [get_ports SPI2_CLK]
#lappend CLOCK_GROUP($clk_lcd_spi_clk_SPI2_CLK_in) clk_lcd_spi_clk_SPI2_CLK_in
#create_clock -name clk_ptest_edt_clock_CAM_SPI_CLK_in -period $CYCLE_26M            -add [get_ports CAM_SPI_CLK]
#lappend CLOCK_GROUP($clk_ptest_edt_clock_CAM_SPI_CLK_in) clk_ptest_edt_clock_CAM_SPI_CLK_in
#create_clock -name clk_usbphy_test_clk_CAM_SPI_CLK_in -period $CYCLE_60M            -add [get_ports CAM_SPI_CLK]
#lappend CLOCK_GROUP($clk_usbphy_test_clk_CAM_SPI_CLK_in) clk_usbphy_test_clk_CAM_SPI_CLK_in
#create_clock -name clk_ptest_scan_clock_CAM_MCLK_in -period $CYCLE_26M            -add [get_ports CAM_MCLK]
#lappend CLOCK_GROUP($clk_ptest_scan_clock_CAM_MCLK_in) clk_ptest_scan_clock_CAM_MCLK_in
#create_clock -name clk_swclk_SWCLK_in             -period $CYCLE_26M            -add [get_ports SWCLK]
#lappend CLOCK_GROUP($clk_swclk_SWCLK_in) clk_swclk_SWCLK_in
#create_clock -name clk_ptest_jtag_tck_SWCLK_in    -period $CYCLE_26M            -add [get_ports SWCLK]
#lappend CLOCK_GROUP($clk_ptest_jtag_tck_SWCLK_in) clk_ptest_jtag_tck_SWCLK_in
#create_clock -name clk_psram_dqs_DQS_in           -period $CYCLE_204M8          -add [get_ports DQS]
#lappend CLOCK_GROUP($clk_psram_dqs_DQS_in) clk_psram_dqs_DQS_in
#create_clock -name clk_sf1_clk_SPI2_CLK_in        -period $CYCLE_26M            -add [get_ports SPI2_CLK]
#lappend CLOCK_GROUP($clk_sf1_clk_SPI2_CLK_in) clk_sf1_clk_SPI2_CLK_in
#create_clock -name clk_tlb_sclk_SPI2_CLK_in       -period $CYCLE_102M4          -add [get_ports SPI2_CLK]
#lappend CLOCK_GROUP($clk_tlb_sclk_SPI2_CLK_in) clk_tlb_sclk_SPI2_CLK_in
set_sense -stop_propagation -clocks [get_clocks $clk_auxclk1_IISMCK_out                  ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_IISMCK/C
set_sense -stop_propagation -clocks [get_clocks $clk_iisclk_IISCLK_out                   ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_IISCLK/C
#set_sense -stop_propagation -clocks [get_clocks $clk_iisclk_IISCLK_in                    ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio3/cmind_uj_cell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_iisclk_IISCLK_in                    ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_spi2_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_IISCLK_out                 ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_IISCLK/C
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_IISCLK_in                  ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio3/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_IISCLK_in                  ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_iisclk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_sim1_clk_SIM1_CLK_out               ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_SIM1_CLK/C
set_sense -stop_propagation -clocks [get_clocks $clk_sim0_clk_SIM0_CLK_out               ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_SIM0_CLK/C
set_sense -stop_propagation -clocks [get_clocks $clk_qspi_sck_d3_SF0_SCK_out             ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_SF0_SCK/C
#set_sense -stop_propagation -clocks [get_clocks $clk_cam_spi_clk_CAM_SPI_CLK_out         ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_CAM_SPI_CLK/C
set_sense -stop_propagation -clocks [get_clocks $clk_cam_spi_clk_CAM_SPI_CLK_in          ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio15/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_cam_spi_clk_CAM_SPI_CLK_in          ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_lcd_spi_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_cam_spi_clk_CAM_SPI_CLK_in          ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_ptest_edt_clock/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_cam_spi_clk_CAM_SPI_CLK_in          ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_usbphy_test_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_CAM_SPI_CLK_out         ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_CAM_SPI_CLK/C
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_CAM_SPI_CLK_in          ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio15/cmind_uj_cell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_CAM_SPI_CLK_in          ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_cam_spi_clk/cmind_uj_ckcell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_CAM_SPI_CLK_in          ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_ptest_edt_clock/cmind_uj_ckcell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_CAM_SPI_CLK_in          ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_usbphy_test_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_ptest_edt_clock_CAM_SPI_CLK_in      ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio15/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_ptest_edt_clock_CAM_SPI_CLK_in      ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_cam_spi_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_ptest_edt_clock_CAM_SPI_CLK_in      ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_lcd_spi_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_ptest_edt_clock_CAM_SPI_CLK_in      ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_usbphy_test_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_usbphy_test_clk_CAM_SPI_CLK_in      ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio15/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_usbphy_test_clk_CAM_SPI_CLK_in      ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_cam_spi_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_usbphy_test_clk_CAM_SPI_CLK_in      ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_lcd_spi_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_usbphy_test_clk_CAM_SPI_CLK_in      ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_ptest_edt_clock/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_auxclk2_CAM_MCLK_out                ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_CAM_MCLK/C
set_sense -stop_propagation -clocks [get_clocks $clk_ptest_scan_clock_CAM_MCLK_in        ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio17/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_swclk_SWCLK_in                      ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_dbg_rxd/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_swclk_SWCLK_in                      ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_u3rxd/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_swclk_SWCLK_in                      ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio29/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_swclk_SWCLK_in                      ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_ptest_jtag_tck/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_ptest_jtag_tck_SWCLK_in             ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_swclk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_ptest_jtag_tck_SWCLK_in             ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_dbg_rxd/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_ptest_jtag_tck_SWCLK_in             ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_u3rxd/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_ptest_jtag_tck_SWCLK_in             ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio29/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_U0RTSN_out              ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_U0RTSN/C
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_U0RTSN_in               ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio27/cmind_uj_cell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_U0RTSN_in               ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_ptest_jtag_reset/cmind_uj_cell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_U0RTSN_in               ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_sysram0_ram_dslp/cmind_uj_cell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_U0RTSN_in               ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_usbphy_vcontrol2/cmind_uj_cell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_psram_ck_n_CLKB_out                 ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_CLKB/C
set_sense -stop_propagation -clocks [get_clocks $clk_psram_ck_CLK_out                    ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_CLK/C
set_sense -stop_propagation -clocks [get_clocks $clk_psram_dqs_DQS_out                   ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_DQS/C
set_sense -stop_propagation -clocks [get_clocks $clk_pdm_clk_IIC2_SDA_out                ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_IIC2_SDA/C
set_sense -stop_propagation -clocks [get_clocks $clk_auxclk0_AUXCLK0_out                 ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_AUXCLK0/C
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_EXTINT3_out                ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_EXTINT3/C
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_EXTINT3_in                 ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio45/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_EXTINT3_in                 ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_extint3/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_EXTINT3_in                 ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_iic2_sda/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_EXTINT3_in                 ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_lcd_spi_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_EXTINT3_in                 ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_ptest_edt_ch_in15/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_EXTINT3_out             ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_EXTINT3/C
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_EXTINT3_in              ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio45/cmind_uj_cell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_EXTINT3_in              ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_extint3/cmind_uj_cell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_EXTINT3_in              ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_iic2_sda/cmind_uj_cell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_EXTINT3_in              ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_spi2_clk/cmind_uj_ckcell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_EXTINT3_in              ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_ptest_edt_ch_in15/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_pdm_clk_FEIO6_out                   ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_FEIO6/C
set_sense -stop_propagation -clocks [get_clocks $clk_rffe_clk_FEIO0_out                  ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_FEIO0/C
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_SPI2_CLK_out               ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_SPI2_CLK/C
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_SPI2_CLK_in                ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio51/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_SPI2_CLK_in                ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_lcd_spi_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_SPI2_CLK_in                ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_sf1_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_spi2_clk_SPI2_CLK_in                ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_tlb_sclk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_sd_clk_SPI2_CLK_out                 ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_SPI2_CLK/C
set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_SPI2_CLK_out            ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_SPI2_CLK/C
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_SPI2_CLK_in             ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio51/cmind_uj_cell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_SPI2_CLK_in             ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_spi2_clk/cmind_uj_ckcell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_SPI2_CLK_in             ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_sf1_clk/cmind_uj_ckcell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_lcd_spi_clk_SPI2_CLK_in             ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_tlb_sclk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_sf1_clk_SPI2_CLK_out                ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_SPI2_CLK/C
#set_sense -stop_propagation -clocks [get_clocks $clk_sf1_clk_SPI2_CLK_in                 ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio51/cmind_uj_cell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_sf1_clk_SPI2_CLK_in                 ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_spi2_clk/cmind_uj_ckcell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_sf1_clk_SPI2_CLK_in                 ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_lcd_spi_clk/cmind_uj_ckcell/Z
#set_sense -stop_propagation -clocks [get_clocks $clk_sf1_clk_SPI2_CLK_in                 ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_tlb_sclk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_hsdl_clk_SPI2_CLK_out               ] ${IO_TOP_HIER}/u_io_group_digital_inst_wrap/u_SPI2_CLK/C
set_sense -stop_propagation -clocks [get_clocks $clk_tlb_sclk_SPI2_CLK_in                ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio51/cmind_uj_cell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_tlb_sclk_SPI2_CLK_in                ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_spi2_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_tlb_sclk_SPI2_CLK_in                ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_lcd_spi_clk/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks [get_clocks $clk_tlb_sclk_SPI2_CLK_in                ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_sf1_clk/cmind_uj_ckcell/Z
