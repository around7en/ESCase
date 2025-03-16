if (![info exist IS_CHIP]) {
    set IS_CHIP 0
}
if {! $IS_CHIP} {
    set AP_SYS_HIER ""
    set AP_SYS_NAME ap_sys
    set PROJ_DIR $env(PROJ_DIR)
    source  $PROJ_DIR/de/common/sdc/clk_period.sdc
    set VCLK_CYCLE $CYCLE_26M
}
source $PROJ_DIR/de/ap_sys/sdc/ap_sys_pwr_wrap.all.sdc
