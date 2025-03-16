if (![info exist VDD_AON]) {
    set VDD_AON 0.8
}

if (![info exist IS_CHIP]) {
    set IS_CHIP 0
}

if (![info exist IS_FLAT]) {
    set IS_FLAT 0
}

if {! $IS_CHIP} {
    set RTC_SYS_HIER ""
    set RTC_SYS_NAME xmw_rtc_pwr_wrap
    set PROJ_DIR $env(PROJ_DIR)
    set XMW_RTC_TOP_HIER     ""
}


source $PROJ_DIR/de/aon_sys/sdc/xmw_rtc_pwr_wrap.all.sdc
