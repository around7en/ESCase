if {! $IS_CHIP} {
    create_clock -name vclk -period $CYCLE_26M
    lappend CLOCK_GROUP(vclk) vclk
    set name_clk_26m_top_for_aon clk_26m_top_for_aon
    set hier_clk_26m_top_for_aon [get_ports clk_26m_top_for_aon]
    create_clock -name $name_clk_26m_top_for_aon -period $CYCLE_26M -add $hier_clk_26m_top_for_aon
    lappend CLOCK_GROUP(clk_26m_top_for_aon) $name_clk_26m_top_for_aon
    set name_clk_32k_top_for_aon clk_32k_top_for_aon
    set hier_clk_32k_top_for_aon [get_ports clk_32k_top_for_aon]
    create_clock -name $name_clk_32k_top_for_aon -period $CYCLE_32K -add $hier_clk_32k_top_for_aon
    lappend CLOCK_GROUP(clk_32k_top_for_aon) $name_clk_32k_top_for_aon
    set name_ptest_slow_occ_clock ptest_slow_occ_clock
    set hier_ptest_slow_occ_clock [get_ports ptest_slow_occ_clock]
    create_clock -name $name_ptest_slow_occ_clock -period $CYCLE_26M -add $hier_ptest_slow_occ_clock
    lappend CLOCK_GROUP(ptest_slow_occ_clock) $name_ptest_slow_occ_clock
}
##----------------------------------------------------------------------------
##clk_xo26m_32k
##----------------------------------------------------------------------------
#    create_generated_clock  \
#        -name top_for_aon_clk_xo26m_32k \
#        -master_clock $name_clk_26m_top_for_aon \
#        -source $hier_clk_26m_top_for_aon \
#        -divide_by 396  \
#        -add \
#        ${TOP_FOR_AON_CLK_CORE_HIER}/u_clk_xo26m_32k_div/$CKOUTZ_HIER
#    lappend CLOCK_GROUP(top_for_aon_clk_xo26m_32k) top_for_aon_clk_xo26m_32k
##----------------------------------------------------------------------------
##clk_3_25m_top_for_aon
##----------------------------------------------------------------------------
#    create_generated_clock  \
#        -name top_for_aon_clk_3_25m_top_for_aon \
#        -master_clock $name_clk_26m_top_for_aon \
#        -source $hier_clk_26m_top_for_aon \
#        -divide_by 8  \
#        -add \
#        ${TOP_FOR_AON_CLK_CORE_HIER}/u_clk_3_25m_top_for_aon_div/$CKOUTZ_HIER
#    lappend CLOCK_GROUP(top_for_aon_clk_3_25m_top_for_aon) top_for_aon_clk_3_25m_top_for_aon
#----------------------------------------------------------------------------
#clk_32k
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_for_aon_clk_32k \
        -master_clock $name_clk_32k_top_for_aon \
        -source $hier_clk_32k_top_for_aon \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_FOR_AON_CLK_CORE_HIER}/u_clk_32k_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_for_aon_clk_32k) top_for_aon_clk_32k
##----------------------------------------------------------------------------
##clk_aon_top_pmu
##----------------------------------------------------------------------------
#    create_generated_clock  \
#        -name top_for_aon_clk_aon_top_pmu \
#        -master_clock top_for_aon_clk_3_25m_top_for_aon \
#        -source ${TOP_FOR_AON_CLK_CORE_HIER}/u_clk_3_25m_top_for_aon_div/$CKOUTZ_HIER \
#        -combinational \
#        -divide_by 1 \
#        -add \
#        ${TOP_FOR_AON_CLK_CORE_HIER}/u_clk_aon_top_pmu_mux/$CKOUTZ_HIER
#    lappend CLOCK_GROUP(top_for_aon_clk_aon_top_pmu) top_for_aon_clk_aon_top_pmu
