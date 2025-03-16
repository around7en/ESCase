#if (![info exist IS_CHIP]) {
#    set IS_CHIP 0
#}
#if {! $IS_CHIP} {
#    set AP_SYS_HIER ""
#    set AP_SYS_NAME ap_sys
#    set PROJ_DIR $env(PROJ_DIR)
#    source  $PROJ_DIR/de/common/sdc/clk_period.sdc
#    set VCLK_CYCLE $CYCLE_26M
#}
if {$IS_CHIP && !$IS_FLAT} {
    set AP_LIB_HIER $AP_SYS_HIER
} else {
    set AP_LIB_HIER ""
}
set AP_SYS_CLK_CORE_HIER "${AP_SYS_HIER}u_ap_sys_top/u_ap_clk_core_top/u_ap_clk_core_wrap/u_ap_clk_core/"

if {!$IS_CHIP || $IS_FLAT} {
    if {[file exist $PROJ_DIR/de/ap_sys/sdc/ap_sys_pwr_wrap.mbist.sdc]} {
        source $PROJ_DIR/de/ap_sys/sdc/ap_sys_pwr_wrap.mbist.sdc 
    }
}
source $PROJ_DIR/de/ap_sys/sdc/ap_clk_core.auto.sdc 
source $PROJ_DIR/de/ap_sys/sdc/ap_sys_peri_top.clk.sdc
if {! $IS_CHIP} {
    source $PROJ_DIR/de/ap_sys/sdc/ap_sys_pwr_wrap.usbphy_clk.sdc
}

source $PROJ_DIR/de/ap_sys/sdc/ap_sys_pwr_wrap.io.sdc
source $PROJ_DIR/de/ap_sys/sdc/ap_sys_pwr_wrap.exception.sdc

if {!$IS_CHIP || $IS_FLAT} {
    source $PROJ_DIR/de/ap_sys/sdc/ap_sys_pwr_wrap.data_chk.sdc
    if {! $IS_CHIP} {
        source $PROJ_DIR/de/common/sdc/clk_group.sdc
        #set_clock_groups -physically_exclusive -group "${AP_SYS_NAME}_clk_pdm_clk_mux_div2 " \
        #                                       -group "${AP_SYS_NAME}_clk_pdm_clk_mux_div1 "
        ##set_clock_groups -logically_exclusive -group $CLOCK_GROUP_PDM_CLK_MUX_DIV1_PAD(1) $CLOCK_GROUP_PDM_CLK_MUX_DIV1_PAD(2) 
        ##set_clock_groups -logically_exclusive -group $CLOCK_GROUP_PDM_CLK_MUX_DIV2_PAD(1) $CLOCK_GROUP_PDM_CLK_MUX_DIV2_PAD(2) 
        #set_clock_groups -physically_exclusive -group "${AP_SYS_NAME}_clk_sdio0_mux_div1_pad ${AP_SYS_NAME}_clk_sdio0_mux_div1" \
        #                                       -group "${AP_SYS_NAME}_clk_sdio0_mux_divn_pad ${AP_SYS_NAME}_clk_sdio0_mux_divn"
        ##set_clock_groups -logically_exclusive -group $CLOCK_GROUP_SPI1_SCK_GEN(1) -group $CLOCK_GROUP_SPI1_SCK_GEN(2) -group $CLOCK_GROUP_SPI1_SCK_GEN(3)
        ##set_clock_groups -logically_exclusive -group $CLOCK_GROUP_SPI2_SCK_GEN(1) -group $CLOCK_GROUP_SPI2_SCK_GEN(2) -group $CLOCK_GROUP_SPI2_SCK_GEN(3)
        #set_clock_groups -logically_exclusive -group "ap_sys_QSPI_SCK" \
        #                                      -group "ap_sys_QSPI_SCK_D3"
    }
}
