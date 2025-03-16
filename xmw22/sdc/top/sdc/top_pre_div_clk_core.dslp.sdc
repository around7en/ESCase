if {! $IS_CHIP} {
    create_clock -name vclk -period $CYCLE_26M
    lappend CLOCK_GROUP(vclk) vclk
    set name_clk_32k_top_pre_div clk_32k_top_pre_div
    set hier_clk_32k_top_pre_div [get_ports clk_32k_top_pre_div]
    create_clock -name $name_clk_32k_top_pre_div -period $CYCLE_32K -add $hier_clk_32k_top_pre_div
    lappend CLOCK_GROUP(clk_32k_top_pre_div) $name_clk_32k_top_pre_div
    set name_clk_32k_dbg_src clk_32k_dbg_src
    set hier_clk_32k_dbg_src [get_ports clk_32k_dbg_src]
    create_clock -name $name_clk_32k_dbg_src -period $CYCLE_32K -add $hier_clk_32k_dbg_src
    lappend CLOCK_GROUP(clk_32k_dbg_src) $name_clk_32k_dbg_src
}
#----------------------------------------------------------------------------
#clk_32k_top
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_32k_top \
        -master_clock $name_clk_32k_top_pre_div \
        -source $hier_clk_32k_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_32k_top_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_32k_top) top_pre_div_clk_32k_top
##----------------------------------------------------------------------------
##clk_32k_aon_cpu_sys
##----------------------------------------------------------------------------
#    create_generated_clock  \
#        -name top_pre_div_clk_32k_aon_cpu_sys \
#        -master_clock $name_clk_32k_top_pre_div \
#        -source $hier_clk_32k_top_pre_div \
#        -combinational \
#        -divide_by 1 \
#        -add \
#        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_32k_aon_cpu_sys_cg/$CKOUTQ_HIER
#    lappend CLOCK_GROUP(top_pre_div_clk_32k_aon_cpu_sys) top_pre_div_clk_32k_aon_cpu_sys
#----------------------------------------------------------------------------
#clk_32k_aon_dbg_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_32k_aon_dbg_sys \
        -master_clock $name_clk_32k_dbg_src \
        -source $hier_clk_32k_dbg_src \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_32k_aon_dbg_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_32k_aon_dbg_sys) top_pre_div_clk_32k_aon_dbg_sys
#----------------------------------------------------------------------------
#for sub sys
#----------------------------------------------------------------------------
    set name_clk_32k_top top_pre_div_clk_32k_top
    set hier_clk_32k_top ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_32k_top_cg/$CKOUTQ_HIER
    #set name_clk_32k_aon_cpu_sys top_pre_div_clk_32k_aon_cpu_sys
    #set hier_clk_32k_aon_cpu_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_32k_aon_cpu_sys_cg/$CKOUTQ_HIER
    set name_clk_32k_aon_dbg_sys top_pre_div_clk_32k_aon_dbg_sys
    set hier_clk_32k_aon_dbg_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_32k_aon_dbg_sys_cg/$CKOUTQ_HIER
