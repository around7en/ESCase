if {![info exist DBG_SYS_CLK_CORE_HIER]} {
    set DBG_SYS_CLK_CORE_HIER "u_dbg_clk_core_wrap/u_dbg_clk_core/"
}
    
if {! $IS_CHIP} {
    create_clock -name dbg_sys_clk_26m_xo_dbg_sys -period $CYCLE_26M -add [get_ports clk_26m_xo_dbg_sys]
    lappend CLOCK_GROUP(dbg_sys_clk_26m_xo_dbg_sys)    dbg_sys_clk_26m_xo_dbg_sys
    set name_clk_26m_xo_dbg_sys dbg_sys_clk_26m_xo_dbg_sys
    set hier_clk_26m_xo_dbg_sys [get_ports clk_26m_xo_dbg_sys]

    create_clock -name dbg_sys_clk_32k_aon_dbg_sys -period $CYCLE_32K -add [get_ports clk_32k_aon_dbg_sys]
    lappend CLOCK_GROUP(dbg_sys_clk_32k_aon_dbg_sys)    dbg_sys_clk_32k_aon_dbg_sys
    set name_clk_32k_aon_dbg_sys dbg_sys_clk_32k_aon_dbg_sys
    set hier_clk_32k_aon_dbg_sys [get_ports clk_32k_aon_dbg_sys]

    create_clock -name dbg_sys_clk_swdtck_pad_in -period $CYCLE_26M -add [get_ports SWCLKTCK]
    lappend CLOCK_GROUP(dbg_sys_clk_swdtck)    dbg_sys_clk_swdtck_pad_in
    set name_clk_swdtck_pad_in dbg_sys_clk_swdtck_pad_in
    set hier_clk_swdtck_pad_in [get_ports SWCLKTCK]

    create_clock -name dbg_sys_clk_tlb_pad_in -period $CYCLE_26M -add [get_ports clk_tlb_pad_in]
    lappend CLOCK_GROUP(dbg_sys_clk_tlb)    dbg_sys_clk_tlb_pad_in
    set name_clk_tlb_pad_in dbg_sys_clk_tlb_pad_in
    set hier_clk_tlb_pad_in [get_ports clk_tlb_pad_in]

    create_clock -name dbg_sys_clk_top_ahb -period $CYCLE_102M4 -add [get_ports clk_top_ahb]
    lappend CLOCK_GROUP(dbg_sys_clk_top_ahb)    dbg_sys_clk_top_ahb
    set name_clk_top_ahb dbg_sys_clk_top_ahb
    set hier_clk_top_ahb [get_ports clk_top_ahb]

    create_clock -name dbg_sys_ptest_slow_occ_clock -period $CYCLE_26M -add [get_ports ptest_slow_occ_clock]
    lappend CLOCK_GROUP(dbg_sys_ptest_slow_occ_clock)    dbg_sys_ptest_slow_occ_clock
    set name_ptest_slow_occ_clock dbg_sys_ptest_slow_occ_clock
    set hier_ptest_slow_occ_clock [get_ports ptest_slow_occ_clock]
}

#############################################################################
###Clock Mux Generate
#############################################################################
###generate mux clock clk_dbg_uart:
create_generated_clock -name dbg_sys_clk_dbg_uart -add \
                      -master_clock $name_clk_26m_xo_dbg_sys \
                      -source $hier_clk_26m_xo_dbg_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${DBG_SYS_CLK_CORE_HIER}u_cmind_clk_sw2_clk_dbg_uart/$CKOUTZ_HIER]
lappend CLOCK_GROUP(dbg_sys_clk_dbg_uart) ${DBG_SYS_LIB_HIER}dbg_sys_clk_dbg_uart                                            
set name_clk_dbg_uart dbg_sys_clk_dbg_uart
set hier_clk_dbg_uart ${DBG_SYS_CLK_CORE_HIER}u_cmind_clk_sw2_clk_dbg_uart/$CKOUTZ_HIER

#lidan #############################################################################
#lidan ###OCC scanmux I1 pin Clock Generate
#lidan #############################################################################
#lidan ###generate clk clk_tlb_scan for scan mux:
#lidan create_generated_clock -name dbg_sys_clk_tlb_scan -add \
#lidan                       -master_clock $name_ptest_slow_occ_clock \
#lidan                       -source $hier_ptest_slow_occ_clock \
#lidan                       -divide_by 1 \
#lidan                       -combinational \
#lidan                       [get_pins ${DBG_SYS_CLK_CORE_HIER}u_clk_tlb_scanmux/cmind_uj_ckcell/I1]
#lidan lappend CLOCK_GROUP(dbg_sys_clk_tlb_scan) ${DBG_SYS_LIB_HIER}dbg_sys_clk_tlb_scan   
#lidan set name_clk_tlb_scan dbg_sys_clk_tlb_scan
#lidan set hier_clk_tlb_scan ${DBG_SYS_CLK_CORE_HIER}u_clk_tlb_scanmux/cmind_uj_ckcell/I1
#lidan 
#lidan ###generate clk clk_dbg_uart_scan for scan mux:
#lidan create_generated_clock -name dbg_sys_clk_dbg_uart_scan -add \
#lidan                       -master_clock $name_ptest_slow_occ_clock \
#lidan                       -source $hier_ptest_slow_occ_clock \
#lidan                       -divide_by 1 \
#lidan                       -combinational \
#lidan                       [get_pins ${DBG_SYS_CLK_CORE_HIER}u_clk_dbg_uart_scanmux/cmind_uj_ckcell/I1]
#lidan lappend CLOCK_GROUP(dbg_sys_clk_dbg_uart_scan) ${DBG_SYS_LIB_HIER}dbg_sys_clk_dbg_uart_scan   
#lidan set name_clk_dbg_uart_scan dbg_sys_clk_dbg_uart_scan
#lidan set hier_clk_dbg_uart_scan ${DBG_SYS_CLK_CORE_HIER}u_clk_dbg_uart_scanmux/cmind_uj_ckcell/I1
#lidan 
#lidan ###generate clk clk_swdtck_scan for scan mux:
#lidan create_generated_clock -name dbg_sys_clk_swdtck_scan -add \
#lidan                       -master_clock $name_ptest_slow_occ_clock \
#lidan                       -source $hier_ptest_slow_occ_clock \
#lidan                       -divide_by 1 \
#lidan                       -combinational \
#lidan                       [get_pins ${DBG_SYS_CLK_CORE_HIER}u_clk_swdtck_scanmux/cmind_uj_ckcell/I1]
#lidan lappend CLOCK_GROUP(dbg_sys_clk_swdtck_scan) ${DBG_SYS_LIB_HIER}dbg_sys_clk_swdtck_scan   
#lidan set name_clk_swdtck_scan dbg_sys_clk_swdtck_scan
#lidan set hier_clk_swdtck_scan ${DBG_SYS_CLK_CORE_HIER}u_clk_swdtck_scanmux/cmind_uj_ckcell/I1
#lidan 
