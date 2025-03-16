######################################################
###all sdc
######################################################

if (![info exist IS_CHIP]) {
    set IS_CHIP 0
}

if (![info exist IS_FLAT]) {
    set IS_FLAT 0
}


if {! $IS_CHIP} {
    set CP_SYS_HIER ""
    set CP_SYS_NAME cp_sys
    set PROJ_DIR $env(PROJ_DIR)
}
if {$IS_CHIP && !$IS_FLAT} {
    set CP_LIB_HIER $CP_SYS_HIER
} else {
    set CP_LIB_HIER ""
}

set CP_SYS_TOP_HIER     "${CP_SYS_HIER}u_cp_sys_top/"
set CP_SYS_CLK_CORE_HIER    "${CP_SYS_HIER}u_cp_sys_top/u_cp_sys_clk_top/u_cp_clk_core_wrap/u_cp_clk_core/"
set CP_SYS_CLK_MANUAL_HIER  "${CP_SYS_HIER}u_cp_sys_top/u_cp_sys_clk_top/u_cp_clk_manual/"

source $PROJ_DIR/de/common/sdc/clk_period.sdc

source $PROJ_DIR/de/cp_sys/sdc/cp_sys_pwr_wrap.clk_top.sdc
source $PROJ_DIR/de/cp_sys/sdc/cp_sys_pwr_wrap.mbist.sdc

source $PROJ_DIR/de/cp_sys/sdc/cp_sys_pwr_wrap.io.sdc

if {!$IS_CHIP || $IS_FLAT} {
source $PROJ_DIR/de/cp_sys/sdc/cp_sys_pwr_wrap.exception.sdc

#source $PROJ_DIR/de/cp_sys/sdc/cp_sys_pwr_wrap.bus_exception.sdc

source $PROJ_DIR/de/cp_sys/sdc/cp_sys_pwr_wrap.data_chk.sdc

if {$IS_CHIP} {
    source $PROJ_DIR/de/cp_sys/sdc/impl_guide/cp_sys_pwr_wrap.func.dont_touch.tcl
}

if {! $IS_CHIP} {
    source $PROJ_DIR/de/common/sdc/clk_group.sdc
}
}
