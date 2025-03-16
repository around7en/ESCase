set VDD_DBG 0P8

if (![info exist IS_CHIP]) {
    set IS_CHIP 0
}

if {! $IS_CHIP} {
    set DBG_SYS_HIER ""
    set DBG_SYS_NAME dbg_sys
    set PROJ_DIR $env(PROJ_DIR)
}
if {$IS_CHIP && !$IS_FLAT} {
    set DBG_SYS_LIB_HIER "" 
} else {
    set DBG_SYS_LIB_HIER ""
}

source $PROJ_DIR/de/dbg_sys/sdc/dbg_sys_top.all.sdc
