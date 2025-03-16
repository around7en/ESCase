######################################################
###all sdc
######################################################

set DBG_SYS_CLK_CORE_HIER "${DBG_SYS_HIER}u_dbg_clk_core_top/u_dbg_clk_core_wrap/u_dbg_clk_core/"

if {! $IS_CHIP} {
    source  $PROJ_DIR/de/common/sdc/clk_period.sdc

    create_clock -name ptest_scan_clock -period $CYCLE_26M [get_ports ptest_scan_clock] -add
    lappend CLOCK_GROUP(clk_scan) ptest_scan_clock
    
    create_clock -name V_CLK_26M         -period $CYCLE_26M  -add
    set CLOCK_GROUP(V_CLK_26M)           [list V_CLK_26M]  
}

source $PROJ_DIR/de/dbg_sys/sdc/dbg_clk_core.auto.sdc

if {! $IS_CHIP} {
    source $PROJ_DIR/de/dbg_sys/sdc/dbg_sys_top.io.sdc
} else {
    set_input_delay  [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports $func_pad_names(dbg_rxd)]
    set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports $func_pad_names(dbg_txd)]
}

source $PROJ_DIR/de/dbg_sys/sdc/dbg_sys_top.exception.sdc
#source $PROJ_DIR/de/dbg_sys/sdc/dbg_sys_top.bus_exception.sdc
#source $PROJ_DIR/de/dbg_sys/sdc/dbg_sys_top.data_chk.sdc

if {! $IS_CHIP} {
    source  $PROJ_DIR/de/common/sdc/clk_group.sdc
}
