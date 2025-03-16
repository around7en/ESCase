set VDD_DBG 0P7

if (![info exist IS_CHIP]) {
    set IS_CHIP 0
}

if (![info exist IS_FLAT]) {
    set IS_FLAT 0
}

if {! $IS_CHIP} {
    set DBG_SYS_HIER ""

    set DBG_SYS_NAME dbg_sys
    set CPU_SYS_NAME cpu_sys
    set PROJ_DIR $env(PROJ_DIR)
    source  $PROJ_DIR/de/common/sdc/clk_period.sdc
}

set DBG_SYS_CLK_CORE_HIER "${DBG_SYS_HIER}u_dbg_clk_core_top/u_dbg_clk_core_wrap/u_dbg_clk_core/"

if {! $IS_CHIP} {
    create_clock -name dbg_sys_clk_32k_aon_dbg_sys -period $CYCLE_32K -add [get_ports clk_32k_aon_dbg_sys]
    lappend CLOCK_GROUP(dbg_sys_clk_32k_aon_dbg_sys)    dbg_sys_clk_32k_aon_dbg_sys
    set name_clk_32k_aon_dbg_sys [get_clocks dbg_sys_clk_32k_aon_dbg_sys]
    set hier_clk_32k_aon_dbg_sys [get_ports clk_32k_aon_dbg_sys]
} else {
    create_clock -name ${CPU_SYS_NAME}_jtag_clk         -period $CYCLE_100K      -add [get_ports $func_pad_names(swclk)]
    set CLOCK_GROUP(${CPU_SYS_NAME}_jtag_clk)           [list ${CPU_SYS_NAME}_jtag_clk  ]    

    set clk_swclk_SWCLK_in                       ${CPU_SYS_NAME}_jtag_clk

    set_sense -stop_propagation -clocks [get_clocks $clk_swclk_SWCLK_in    ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_dbg_rxd/cmind_uj_cell/Z
    set_sense -stop_propagation -clocks [get_clocks $clk_swclk_SWCLK_in    ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_u3rxd/cmind_uj_cell/Z
    set_sense -stop_propagation -clocks [get_clocks $clk_swclk_SWCLK_in    ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_gpio29/cmind_uj_cell/Z
    set_sense -stop_propagation -clocks [get_clocks $clk_swclk_SWCLK_in    ] ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_ptest_jtag_tck/cmind_uj_ckcell/Z
    if {$IS_FLAT} {
        set_sense -stop_propagation -clocks [get_clocks $clk_swclk_SWCLK_in    ] ${CPU_SYS_HIER}u_cpu_sys_top/u_cpu_sys_clk_top/u_cpu_clk_core_wrap/u_cpu_clk_core/u_clk_cpu_mtck_scanmux/cmind_uj_ckcell/I0
        set_sense -stop_propagation -clocks [get_clocks $clk_swclk_SWCLK_in    ] ${CPU_SYS_HIER}u_cpu_sys_top/u_cpu_sys_dbgbus/u_clk_cpu_mtck_pad_in_cka/cmind_uj_ckcell/A1
    }

}

create_generated_clock -name dbg_sys_clk_dbg_uart -add \
                      -master_clock $name_clk_32k_aon_dbg_sys \
                      -source $hier_clk_32k_aon_dbg_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${DBG_SYS_CLK_CORE_HIER}u_cmind_clk_sw2_clk_dbg_uart/$CKOUTZ_HIER]
lappend CLOCK_GROUP(dbg_sys_clk_dbg_uart) dbg_sys_clk_dbg_uart                                            
set name_clk_dbg_uart [get_clocks dbg_sys_clk_dbg_uart]
set hier_clk_dbg_uart [get_pins ${DBG_SYS_CLK_CORE_HIER}u_cmind_clk_sw2_clk_dbg_uart/$CKOUTZ_HIER]
set_input_delay  [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports $func_pad_names(dbg_rxd)]
set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports $func_pad_names(dbg_txd)]

set_clock_sense -stop_propagation [get_pins ${DBG_SYS_HIER}u_dbgsys_dbg_bus/u_clk*_cka/cmind_uj_ckcell/A1]
set_false_path -th [get_pins ${DBG_SYS_HIER}u_dbgsys_dbg_bus/data_bit*u_cmind_cell_buf/cmind_uj_cell/Z]
set_false_path -th [get_pins ${DBG_SYS_HIER}data_bit*u_cmind_cell_buf/cmind_uj_cell/Z]

if {! $IS_CHIP} {
    source  $PROJ_DIR/de/common/sdc/clk_group.sdc
}
