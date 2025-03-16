if {! $IS_CHIP} {
    create_clock -name vclk -period $CYCLE_26M
    set name_clk_15k_top clk_15k_top
    set hier_clk_15k_top [get_ports clk_15k_top]
    create_clock -name $name_clk_15k_top -period $CYCLE_15K -add $hier_clk_15k_top
    lappend CLOCK_GROUP(clk_15k_top) $name_clk_15k_top
    set name_clk_32k_top clk_32k_top
    set hier_clk_32k_top [get_ports clk_32k_top]
    create_clock -name $name_clk_32k_top -period $CYCLE_32K -add $hier_clk_32k_top
    lappend CLOCK_GROUP(clk_32k_top) $name_clk_32k_top
    set name_clk_rtc32k_top clk_rtc32k_top
    set hier_clk_rtc32k_top [get_ports clk_rtc32k_top]
    create_clock -name $name_clk_rtc32k_top -period $CYCLE_26M -add $hier_clk_rtc32k_top
    lappend CLOCK_GROUP(clk_rtc32k_top) $name_clk_rtc32k_top
}
#----------------------------------------------------------------------------
#clk_top_mtx
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_mtx \
        -master_clock $name_clk_32k_top \
        -source $hier_clk_32k_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_mtx_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_clk_top_mtx) top_clk_top_mtx
#----------------------------------------------------------------------------
#clk_top_glb_wdg0
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_glb_wdg0 \
        -master_clock $name_clk_32k_top \
        -source $hier_clk_32k_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_glb_wdg0_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_clk_top_glb_wdg0) top_clk_top_glb_wdg0
#----------------------------------------------------------------------------
#clk_top_ttmr0
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_ttmr0 \
        -master_clock $name_clk_32k_top \
        -source $hier_clk_32k_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_ttmr0_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_clk_top_ttmr0) top_clk_top_ttmr0
#----------------------------------------------------------------------------
#clk_top_kpd
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_kpd \
        -master_clock $name_clk_32k_top \
        -source $hier_clk_32k_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_kpd_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_top_kpd) top_clk_top_kpd
#----------------------------------------------------------------------------
#clk_top_eic0_32k
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_eic0_32k \
        -master_clock $name_clk_32k_top \
        -source $hier_clk_32k_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_eic0_32k_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_top_eic0_32k) top_clk_top_eic0_32k
#----------------------------------------------------------------------------
#clk_top_eic1_32k
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_eic1_32k \
        -master_clock $name_clk_32k_top \
        -source $hier_clk_32k_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_eic1_32k_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_top_eic1_32k) top_clk_top_eic1_32k
#----------------------------------------------------------------------------
#clk_32k_ocp
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_32k_ocp \
        -master_clock $name_clk_32k_top \
        -source $hier_clk_32k_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_32k_ocp_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_32k_ocp) top_clk_32k_ocp
##----------------------------------------------------------------------------
##clk_32k_cali
##----------------------------------------------------------------------------
#    create_generated_clock  \
#        -name top_clk_32k_cali \
#        -master_clock $name_clk_32k_top \
#        -source $hier_clk_32k_top \
#        -combinational \
#        -divide_by 1 \
#        -add \
#        ${TOP_CLK_CORE_HIER}/u_clk_32k_cali_scan/cmind_uj_ckcell/I0
#    lappend CLOCK_GROUP(top_clk_32k_cali) top_clk_32k_cali
