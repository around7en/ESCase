if {! $IS_CHIP} {
    create_clock -name vclk -period $CYCLE_26M
    lappend CLOCK_GROUP(vclk) vclk
    set name_clk_26m_pub clk_26m_pub
    set hier_clk_26m_pub [get_ports clk_26m_pub]
    create_clock -name $name_clk_26m_pub -period $CYCLE_26M -add $hier_clk_26m_pub
    lappend CLOCK_GROUP(clk_26m_pub) $name_clk_26m_pub
    set name_clk_61_44m_pub clk_61_44m_pub
    set hier_clk_61_44m_pub [get_ports clk_61_44m_pub]
    create_clock -name $name_clk_61_44m_pub -period $CYCLE_61M44 -add $hier_clk_61_44m_pub
    lappend CLOCK_GROUP(clk_61_44m_pub) $name_clk_61_44m_pub
    set name_clk_76_8m_pub clk_76_8m_pub
    set hier_clk_76_8m_pub [get_ports clk_76_8m_pub]
    create_clock -name $name_clk_76_8m_pub -period $CYCLE_76M8 -add $hier_clk_76_8m_pub
    lappend CLOCK_GROUP(clk_76_8m_pub) $name_clk_76_8m_pub
    set name_clk_102_4m_pub clk_102_4m_pub
    set hier_clk_102_4m_pub [get_ports clk_102_4m_pub]
    create_clock -name $name_clk_102_4m_pub -period $CYCLE_102M4 -add $hier_clk_102_4m_pub
    lappend CLOCK_GROUP(clk_102_4m_pub) $name_clk_102_4m_pub
    set name_clk_122_88m_pub clk_122_88m_pub
    set hier_clk_122_88m_pub [get_ports clk_122_88m_pub]
    create_clock -name $name_clk_122_88m_pub -period $CYCLE_122M88 -add $hier_clk_122_88m_pub
    lappend CLOCK_GROUP(clk_122_88m_pub) $name_clk_122_88m_pub
    set name_clk_153_6m_pub clk_153_6m_pub
    set hier_clk_153_6m_pub [get_ports clk_153_6m_pub]
    create_clock -name $name_clk_153_6m_pub -period $CYCLE_153M6 -add $hier_clk_153_6m_pub
    lappend CLOCK_GROUP(clk_153_6m_pub) $name_clk_153_6m_pub
    set name_clk_204_8m_pub clk_204_8m_pub
    set hier_clk_204_8m_pub [get_ports clk_204_8m_pub]
    create_clock -name $name_clk_204_8m_pub -period $CYCLE_204M8 -add $hier_clk_204_8m_pub
    lappend CLOCK_GROUP(clk_204_8m_pub) $name_clk_204_8m_pub
    set name_clk_top_mtx clk_top_mtx
    set hier_clk_top_mtx [get_ports clk_top_mtx]
    create_clock -name $name_clk_top_mtx -period $CYCLE_102M4 -add $hier_clk_top_mtx
    lappend CLOCK_GROUP(clk_top_mtx) $name_clk_top_mtx
    set name_ptest_slow_occ_clock ptest_slow_occ_clock
    set hier_ptest_slow_occ_clock [get_ports ptest_slow_occ_clock]
    create_clock -name $name_ptest_slow_occ_clock -period $CYCLE_26M -add $hier_ptest_slow_occ_clock
    lappend CLOCK_GROUP(ptest_slow_occ_clock) $name_ptest_slow_occ_clock
}
#----------------------------------------------------------------------------
#clk_pub_main_mtx
#----------------------------------------------------------------------------
if {!$IS_CHIP || $IS_FLAT} {
    create_generated_clock  \
        -name pub_sys_clk_pub_main_mtx \
        -master_clock $name_clk_204_8m_pub \
        -source $hier_clk_204_8m_pub \
        -combinational \
        -divide_by 1 \
        -add \
        ${PUB_SYS_CLK_CORE_HIER}/u_clk_pub_main_mtx_mux/$CKOUTZ_HIER
}
    lappend CLOCK_GROUP(pub_sys_clk_pub_main_mtx) ${PUB_LIB_HIER}pub_sys_clk_pub_main_mtx
#----------------------------------------------------------------------------
#clk_pub_psram_ctrl
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_pub_ahb_for_cpu
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_pub_ahb_for_ap
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_pub_ahb_for_cp
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_pub_cfg
#----------------------------------------------------------------------------
if {!$IS_CHIP || $IS_FLAT} {
    create_generated_clock  \
        -name pub_sys_clk_pub_cfg_scan \
        -master_clock $name_clk_102_4m_pub \
        -source $hier_clk_102_4m_pub \
        -combinational \
        -divide_by 1 \
        -add \
        ${PUB_SYS_CLK_CORE_HIER}/u_clk_pub_cfg_scan/cmind_uj_ckcell/I1
}
    lappend CLOCK_GROUP(pub_sys_clk_pub_cfg_scan) ${PUB_LIB_HIER}pub_sys_clk_pub_cfg_scan
#----------------------------------------------------------------------------
#clk_top_mtx_scan
#----------------------------------------------------------------------------
