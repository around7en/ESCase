######################################################
###all sdc
######################################################

source  $PROJ_DIR/de/common/sdc/clk_period.sdc

if {$VDD_AON==0.8} {
    source  $PROJ_DIR/de/aon_sys/sdc/xmw_rtc_pwr_wrap.clk_top.TT0P80V.sdc
} else {
    source  $PROJ_DIR/de/aon_sys/sdc/xmw_rtc_pwr_wrap.clk_top.TT0P70V.sdc
    source  $PROJ_DIR/de/aon_sys/sdc/xmw_rtc_pwr_wrap.exception.TT0P70V.sdc
}

source  $PROJ_DIR/de/aon_sys/sdc/xmw_rtc_pwr_wrap.exception.sdc

if {! $IS_CHIP} {
    if {$VDD_AON==0.8} {
        source  $PROJ_DIR/de/aon_sys/sdc/xmw_rtc_pwr_wrap.io.TT0P80V.sdc
    } else {
        source  $PROJ_DIR/de/aon_sys/sdc/xmw_rtc_pwr_wrap.io.TT0P70V.sdc
    }
}
if {$IS_CHIP} {
    source $PROJ_DIR/de/aon_sys/sdc/impl_guide/xmw_rtc_pwr_wrap.func.dont_touch.tcl
}

if {! $IS_CHIP} {
    source  $PROJ_DIR/de/common/sdc/clk_group.sdc
}
