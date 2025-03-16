lappend CLOCK_GROUP(ap_sys_clk_top_ahb_scan_scan)  ${AP_SYS_HIER}ap_sys_clk_top_ahb_scan_scan
lappend CLOCK_GROUP(ap_sys_clk_sysram_ahb_scan_scan)  ${AP_SYS_HIER}ap_sys_clk_sysram_ahb_scan_scan
lappend CLOCK_GROUP(ap_sys_clk_sim0_apb)  ${AP_SYS_HIER}ap_sys_clk_sim0_apb ${AP_SYS_HIER}o_sim0_clk
lappend CLOCK_GROUP(ap_sys_clk_pwm2_apb_scan)  ${AP_SYS_HIER}ap_sys_clk_pwm2_apb_scan
lappend CLOCK_GROUP(ap_sys_clk_pwm2_apb)  ${AP_SYS_HIER}ap_sys_clk_pwm2_apb
lappend CLOCK_GROUP(ap_sys_clk_i2c1_apb)  ${AP_SYS_HIER}ap_sys_clk_i2c1_apb
lappend CLOCK_GROUP(ap_sys_utmi_clk_scan)  ${AP_SYS_HIER}ap_sys_utmi_clk_scan
lappend CLOCK_GROUP(ap_sys_clk_i2s0)  ${AP_SYS_HIER}ap_sys_clk_i2s0 ${AP_SYS_HIER}ap_sys_clk_i2s0_sck_generated ${AP_SYS_HIER}ap_sys_clk_i2s0_sck_generated_div2 ${AP_SYS_HIER}ap_sys_clk_pdm_clk_mux_div2 ${AP_SYS_HIER}pdm_clk ${AP_SYS_HIER}ap_sys_clk_pdm_clk_mux_div1 ${AP_SYS_HIER}pdm_clk ${AP_SYS_HIER}i2s0_scko
lappend CLOCK_GROUP(ap_sys_SYSCLK240)  ${AP_SYS_HIER}u_ap_sys_top_u_ap_sys_usb2_wrap_u_M31USBH225TL022V_00223601_SYSCLK120 ${AP_SYS_HIER}u_ap_sys_top_u_ap_sys_usb2_wrap_u_M31USBH225TL022V_00223601_U20_CLK60 ${AP_SYS_HIER}u_ap_sys_top_u_ap_sys_usb2_wrap_u_M31USBH225TL022V_00223601_U20_CLK30 ${AP_SYS_HIER}u_ap_sys_top_u_ap_sys_usb2_wrap_u_M31USBH225TL022V_00223601_U20_CLK7p5
lappend CLOCK_GROUP(ap_sys_CLKOSCO_U2_240M_CAL)  ${AP_SYS_HIER}u_ap_sys_top_u_ap_sys_usb2_wrap_u_M31USBH225TL022V_00223601_CLKOSCO_U2_120M_CAL
lappend CLOCK_GROUP(ap_sys_clk_can0_apb)  ${AP_SYS_HIER}ap_sys_clk_can0_apb
lappend CLOCK_GROUP(ap_sys_clk_spi1_apb)  ${AP_SYS_HIER}ap_sys_clk_spi1_apb ${AP_SYS_HIER}ap_sys_clk_spi1_apb_gate ${AP_SYS_HIER}ap_sys_clk_spi1_sclk_out ${AP_SYS_HIER}spi1_sclk_out
lappend CLOCK_GROUP(ap_sys_clk_uart1)  ${AP_SYS_HIER}ap_sys_clk_uart1
lappend CLOCK_GROUP(ap_sys_clk_sdio0)  ${AP_SYS_HIER}ap_sys_clk_sdio0 ${AP_SYS_HIER}ap_sys_clk_sdio0_sleep_in ${AP_SYS_HIER}ap_sys_clk_sdio0_div2 ${AP_SYS_HIER}ap_sys_clk_sdio0_mux_div2 ${AP_SYS_HIER}ap_sys_clk_sdio0_div4 ${AP_SYS_HIER}ap_sys_clk_sdio0_mux_div4 ${AP_SYS_HIER}ap_sys_clk_sdio0_mux_div1 ${AP_SYS_HIER}clk_sdcard ${AP_SYS_HIER}clk_sdcard ${AP_SYS_HIER}clk_sdcard
lappend CLOCK_GROUP(ap_sys_clk_uart4)  ${AP_SYS_HIER}ap_sys_clk_uart4
lappend CLOCK_GROUP(ap_sys_clk_spi_flash)  ${AP_SYS_HIER}ap_sys_clk_spi_flash ${AP_SYS_HIER}ap_sys_clk_qspi_sck_div ${AP_SYS_HIER}qspi_sck_o ${AP_SYS_HIER}qspi_do_o?3?
lappend CLOCK_GROUP(ap_sys_clk_uart5)  ${AP_SYS_HIER}ap_sys_clk_uart5
lappend CLOCK_GROUP(ap_sys_clk_pub_ahb_scan_scan)  ${AP_SYS_HIER}ap_sys_clk_pub_ahb_scan_scan
lappend CLOCK_GROUP(ap_sys_clk_sim1_apb)  ${AP_SYS_HIER}ap_sys_clk_sim1_apb ${AP_SYS_HIER}o_sim1_clk
lappend CLOCK_GROUP(ap_sys_clk_pwm3_apb)  ${AP_SYS_HIER}ap_sys_clk_pwm3_apb
lappend CLOCK_GROUP(ap_sys_clk_i2c2_apb)  ${AP_SYS_HIER}ap_sys_clk_i2c2_apb
lappend CLOCK_GROUP(ap_sys_clk_sdio0_sleep_out_scan)  ${AP_SYS_HIER}ap_sys_clk_sdio0_sleep_out_scan
lappend CLOCK_GROUP(ap_sys_clk_ap_ahb)  ${AP_SYS_HIER}ap_sys_clk_ap_ahb ${AP_SYS_HIER}ap_sys_clk_ap_apb ${AP_SYS_HIER}ap_sys_clk_ext_qspi_sck_div ${AP_SYS_HIER}ext_spi_sck_o
lappend CLOCK_GROUP(ap_sys_clk_can1_apb)  ${AP_SYS_HIER}ap_sys_clk_can1_apb
lappend CLOCK_GROUP(ap_sys_clk_spi0_apb)  ${AP_SYS_HIER}ap_sys_clk_spi0_apb
lappend CLOCK_GROUP(ap_sys_clk_spi2_apb)  ${AP_SYS_HIER}ap_sys_clk_spi2_apb ${AP_SYS_HIER}ap_sys_clk_spi2_apb_gate ${AP_SYS_HIER}ap_sys_clk_spi2_sclk_out ${AP_SYS_HIER}spi2_sclk_out
