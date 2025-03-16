if {! $IS_CHIP} {
    create_clock -name vclk -period $CYCLE_26M
    lappend CLOCK_GROUP(vclk) vclk
    set name_clk_245_76m_top_pre_div clk_245_76m_top_pre_div
    set hier_clk_245_76m_top_pre_div [get_ports clk_245_76m_top_pre_div]
    create_clock -name $name_clk_245_76m_top_pre_div -period $CYCLE_245M76 -add $hier_clk_245_76m_top_pre_div
    lappend CLOCK_GROUP(clk_245_76m_top_pre_div) $name_clk_245_76m_top_pre_div
    set name_clk_409_6m_top_pre_div clk_409_6m_top_pre_div
    set hier_clk_409_6m_top_pre_div [get_ports clk_409_6m_top_pre_div]
    create_clock -name $name_clk_409_6m_top_pre_div -period $CYCLE_409M6 -add $hier_clk_409_6m_top_pre_div
    lappend CLOCK_GROUP(clk_409_6m_top_pre_div) $name_clk_409_6m_top_pre_div
    set name_clk_307_2m_top_pre_div clk_307_2m_top_pre_div
    set hier_clk_307_2m_top_pre_div [get_ports clk_307_2m_top_pre_div]
    create_clock -name $name_clk_307_2m_top_pre_div -period $CYCLE_307M2 -add $hier_clk_307_2m_top_pre_div
    lappend CLOCK_GROUP(clk_307_2m_top_pre_div) $name_clk_307_2m_top_pre_div
    set name_clk_26m_top_pre_div clk_26m_top_pre_div
    set hier_clk_26m_top_pre_div [get_ports clk_26m_top_pre_div]
    create_clock -name $name_clk_26m_top_pre_div -period $CYCLE_26M -add $hier_clk_26m_top_pre_div
    lappend CLOCK_GROUP(clk_26m_top_pre_div) $name_clk_26m_top_pre_div
    set name_clk_32k_top_pre_div clk_32k_top_pre_div
    set hier_clk_32k_top_pre_div [get_ports clk_32k_top_pre_div]
    create_clock -name $name_clk_32k_top_pre_div -period $CYCLE_32K -add $hier_clk_32k_top_pre_div
    lappend CLOCK_GROUP(clk_32k_top_pre_div) $name_clk_32k_top_pre_div
    set name_clk_15k_top_pre_div clk_15k_top_pre_div
    set hier_clk_15k_top_pre_div [get_ports clk_15k_top_pre_div]
    create_clock -name $name_clk_15k_top_pre_div -period $CYCLE_15K -add $hier_clk_15k_top_pre_div
    lappend CLOCK_GROUP(clk_15k_top_pre_div) $name_clk_15k_top_pre_div
    set name_clk_26m clk_26m
    set hier_clk_26m [get_ports clk_26m]
    create_clock -name $name_clk_26m -period $CYCLE_26M -add $hier_clk_26m
    lappend CLOCK_GROUP(clk_26m) $name_clk_26m
    set name_clk_480m_top_pre_div clk_480m_top_pre_div
    set hier_clk_480m_top_pre_div [get_ports clk_480m_top_pre_div]
    create_clock -name $name_clk_480m_top_pre_div -period $CYCLE_480M -add $hier_clk_480m_top_pre_div
    lappend CLOCK_GROUP(clk_480m_top_pre_div) $name_clk_480m_top_pre_div
    set name_clk_491_52m_top_pre_div clk_491_52m_top_pre_div
    set hier_clk_491_52m_top_pre_div [get_ports clk_491_52m_top_pre_div]
    create_clock -name $name_clk_491_52m_top_pre_div -period $CYCLE_491M52 -add $hier_clk_491_52m_top_pre_div
    lappend CLOCK_GROUP(clk_491_52m_top_pre_div) $name_clk_491_52m_top_pre_div
    set name_clk_32k_dbg_src clk_32k_dbg_src
    set hier_clk_32k_dbg_src [get_ports clk_32k_dbg_src]
    create_clock -name $name_clk_32k_dbg_src -period $CYCLE_32K -add $hier_clk_32k_dbg_src
    lappend CLOCK_GROUP(clk_32k_dbg_src) $name_clk_32k_dbg_src
    set name_clk_26m_dbg_src clk_26m_dbg_src
    set hier_clk_26m_dbg_src [get_ports clk_26m_dbg_src]
    create_clock -name $name_clk_26m_dbg_src -period $CYCLE_26M -add $hier_clk_26m_dbg_src
    lappend CLOCK_GROUP(clk_26m_dbg_src) $name_clk_26m_dbg_src
    set name_ptest_slow_occ_clock ptest_slow_occ_clock
    set hier_ptest_slow_occ_clock [get_ports ptest_slow_occ_clock]
    create_clock -name $name_ptest_slow_occ_clock -period $CYCLE_26M -add $hier_ptest_slow_occ_clock
    lappend CLOCK_GROUP(ptest_slow_occ_clock) $name_ptest_slow_occ_clock
}
#----------------------------------------------------------------------------
#clk_122_88m_top_pre_div
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_122_88m_top_pre_div \
        -master_clock $name_clk_245_76m_top_pre_div \
        -source $hier_clk_245_76m_top_pre_div \
        -divide_by 2  \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_122_88m_top_pre_div_div/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_122_88m_top_pre_div) top_pre_div_clk_122_88m_top_pre_div
#----------------------------------------------------------------------------
#clk_61_44m_top_pre_div
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_61_44m_top_pre_div \
        -master_clock top_pre_div_clk_122_88m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_122_88m_top_pre_div_div/$CKOUTZ_HIER \
        -divide_by 2  \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_61_44m_top_pre_div_div/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_61_44m_top_pre_div) top_pre_div_clk_61_44m_top_pre_div
#----------------------------------------------------------------------------
#clk_30_72m_top_pre_div
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_30_72m_top_pre_div \
        -master_clock top_pre_div_clk_61_44m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_61_44m_top_pre_div_div/$CKOUTZ_HIER \
        -divide_by 2  \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_30_72m_top_pre_div_div/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_30_72m_top_pre_div) top_pre_div_clk_30_72m_top_pre_div
#----------------------------------------------------------------------------
#clk_12_288m_top_pre_div
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_12_288m_top_pre_div \
        -master_clock top_pre_div_clk_122_88m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_122_88m_top_pre_div_div/$CKOUTZ_HIER \
        -divide_by 10  \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_12_288m_top_pre_div_div/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_12_288m_top_pre_div) top_pre_div_clk_12_288m_top_pre_div
#----------------------------------------------------------------------------
#clk_204_8m_top_pre_div
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_204_8m_top_pre_div \
        -master_clock $name_clk_409_6m_top_pre_div \
        -source $hier_clk_409_6m_top_pre_div \
        -divide_by 2  \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_top_pre_div_div/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_204_8m_top_pre_div) top_pre_div_clk_204_8m_top_pre_div
#----------------------------------------------------------------------------
#clk_102_4m_top_pre_div
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_102_4m_top_pre_div \
        -master_clock top_pre_div_clk_204_8m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_top_pre_div_div/$CKOUTZ_HIER \
        -divide_by 2  \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_top_pre_div_div/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_102_4m_top_pre_div) top_pre_div_clk_102_4m_top_pre_div
#----------------------------------------------------------------------------
#clk_51_2m_top_pre_div
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_51_2m_top_pre_div \
        -master_clock top_pre_div_clk_102_4m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_top_pre_div_div/$CKOUTZ_HIER \
        -divide_by 2  \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_top_pre_div_div/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_51_2m_top_pre_div) top_pre_div_clk_51_2m_top_pre_div
#----------------------------------------------------------------------------
#clk_153_6m_top_pre_div
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_153_6m_top_pre_div \
        -master_clock $name_clk_307_2m_top_pre_div \
        -source $hier_clk_307_2m_top_pre_div \
        -divide_by 2  \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_153_6m_top_pre_div_div/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_153_6m_top_pre_div) top_pre_div_clk_153_6m_top_pre_div
#----------------------------------------------------------------------------
#clk_76_8m_top_pre_div
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_76_8m_top_pre_div \
        -master_clock top_pre_div_clk_153_6m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_153_6m_top_pre_div_div/$CKOUTZ_HIER \
        -divide_by 2  \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_76_8m_top_pre_div_div/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_76_8m_top_pre_div) top_pre_div_clk_76_8m_top_pre_div
#----------------------------------------------------------------------------
#clk_38_4m_top_pre_div
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_38_4m_top_pre_div \
        -master_clock top_pre_div_clk_76_8m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_76_8m_top_pre_div_div/$CKOUTZ_HIER \
        -divide_by 2  \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_38_4m_top_pre_div_div/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_38_4m_top_pre_div) top_pre_div_clk_38_4m_top_pre_div
#----------------------------------------------------------------------------
#clk_19_2m_top_pre_div
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_19_2m_top_pre_div \
        -master_clock top_pre_div_clk_38_4m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_38_4m_top_pre_div_div/$CKOUTZ_HIER \
        -divide_by 2  \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_19_2m_top_pre_div_div/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_19_2m_top_pre_div) top_pre_div_clk_19_2m_top_pre_div
#----------------------------------------------------------------------------
#clk_245_76m_top
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_245_76m_top \
        -master_clock $name_clk_245_76m_top_pre_div \
        -source $hier_clk_245_76m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_245_76m_top_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_245_76m_top) top_pre_div_clk_245_76m_top
#----------------------------------------------------------------------------
#clk_204_8m_top
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_204_8m_top \
        -master_clock top_pre_div_clk_204_8m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_top_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_204_8m_top) top_pre_div_clk_204_8m_top
#----------------------------------------------------------------------------
#clk_153_6m_top
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_153_6m_top \
        -master_clock top_pre_div_clk_153_6m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_153_6m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_153_6m_top_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_153_6m_top) top_pre_div_clk_153_6m_top
#----------------------------------------------------------------------------
#clk_102_4m_top
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_102_4m_top \
        -master_clock top_pre_div_clk_102_4m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_top_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_102_4m_top) top_pre_div_clk_102_4m_top
#----------------------------------------------------------------------------
#clk_76_8m_top
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_76_8m_top \
        -master_clock top_pre_div_clk_76_8m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_76_8m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_76_8m_top_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_76_8m_top) top_pre_div_clk_76_8m_top
#----------------------------------------------------------------------------
#clk_61_44m_top
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_61_44m_top \
        -master_clock top_pre_div_clk_61_44m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_61_44m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_61_44m_top_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_61_44m_top) top_pre_div_clk_61_44m_top
#----------------------------------------------------------------------------
#clk_51_2m_top
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_51_2m_top \
        -master_clock top_pre_div_clk_51_2m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_top_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_51_2m_top) top_pre_div_clk_51_2m_top
#----------------------------------------------------------------------------
#clk_26m_top
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_26m_top \
        -master_clock $name_clk_26m_top_pre_div \
        -source $hier_clk_26m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_top_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_26m_top) top_pre_div_clk_26m_top
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
#----------------------------------------------------------------------------
#clk_15k_top
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_15k_top \
        -master_clock $name_clk_15k_top_pre_div \
        -source $hier_clk_15k_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_15k_top_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_15k_top) top_pre_div_clk_15k_top
#----------------------------------------------------------------------------
#clk_26m_efuse
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_26m_efuse \
        -master_clock $name_clk_26m \
        -source $hier_clk_26m \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_efuse_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_26m_efuse) top_pre_div_clk_26m_efuse
#----------------------------------------------------------------------------
#clk_204_8m_pub
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_204_8m_pub \
        -master_clock top_pre_div_clk_204_8m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_pub_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_204_8m_pub) top_pre_div_clk_204_8m_pub
#----------------------------------------------------------------------------
#clk_153_6m_pub
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_153_6m_pub \
        -master_clock top_pre_div_clk_153_6m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_153_6m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_153_6m_pub_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_153_6m_pub) top_pre_div_clk_153_6m_pub
#----------------------------------------------------------------------------
#clk_122_88m_pub
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_122_88m_pub \
        -master_clock top_pre_div_clk_122_88m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_122_88m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_122_88m_pub_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_122_88m_pub) top_pre_div_clk_122_88m_pub
#----------------------------------------------------------------------------
#clk_102_4m_pub
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_102_4m_pub \
        -master_clock top_pre_div_clk_102_4m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_pub_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_102_4m_pub) top_pre_div_clk_102_4m_pub
#----------------------------------------------------------------------------
#clk_76_8m_pub
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_76_8m_pub \
        -master_clock top_pre_div_clk_76_8m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_76_8m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_76_8m_pub_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_76_8m_pub) top_pre_div_clk_76_8m_pub
#----------------------------------------------------------------------------
#clk_61_44m_pub
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_61_44m_pub \
        -master_clock top_pre_div_clk_61_44m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_61_44m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_61_44m_pub_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_61_44m_pub) top_pre_div_clk_61_44m_pub
#----------------------------------------------------------------------------
#clk_26m_pub
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_26m_pub \
        -master_clock $name_clk_26m_top_pre_div \
        -source $hier_clk_26m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_pub_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_26m_pub) top_pre_div_clk_26m_pub
#----------------------------------------------------------------------------
#clk_32k_aon_cpu_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_32k_aon_cpu_sys \
        -master_clock $name_clk_32k_top_pre_div \
        -source $hier_clk_32k_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_32k_aon_cpu_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_32k_aon_cpu_sys) top_pre_div_clk_32k_aon_cpu_sys
#----------------------------------------------------------------------------
#clk_26m_xo_cpu_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_26m_xo_cpu_sys \
        -master_clock $name_clk_26m_top_pre_div \
        -source $hier_clk_26m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_xo_cpu_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_26m_xo_cpu_sys) top_pre_div_clk_26m_xo_cpu_sys
#----------------------------------------------------------------------------
#clk_51_2m_cpll_cpu_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_51_2m_cpll_cpu_sys \
        -master_clock top_pre_div_clk_51_2m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_51_2m_cpll_cpu_sys) top_pre_div_clk_51_2m_cpll_cpu_sys
#----------------------------------------------------------------------------
#clk_102_4m_cpll_cpu_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_102_4m_cpll_cpu_sys \
        -master_clock top_pre_div_clk_102_4m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_102_4m_cpll_cpu_sys) top_pre_div_clk_102_4m_cpll_cpu_sys
#----------------------------------------------------------------------------
#clk_204_8m_cpll_cpu_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_204_8m_cpll_cpu_sys \
        -master_clock top_pre_div_clk_204_8m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_204_8m_cpll_cpu_sys) top_pre_div_clk_204_8m_cpll_cpu_sys
#----------------------------------------------------------------------------
#clk_245_76m_cpll_cpu_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_245_76m_cpll_cpu_sys \
        -master_clock $name_clk_245_76m_top_pre_div \
        -source $hier_clk_245_76m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_245_76m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_245_76m_cpll_cpu_sys) top_pre_div_clk_245_76m_cpll_cpu_sys
#----------------------------------------------------------------------------
#clk_307_2m_cpll_cpu_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_307_2m_cpll_cpu_sys \
        -master_clock $name_clk_307_2m_top_pre_div \
        -source $hier_clk_307_2m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_307_2m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_307_2m_cpll_cpu_sys) top_pre_div_clk_307_2m_cpll_cpu_sys
#----------------------------------------------------------------------------
#clk_409_6m_cpll_cpu_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_409_6m_cpll_cpu_sys \
        -master_clock $name_clk_409_6m_top_pre_div \
        -source $hier_clk_409_6m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_409_6m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_409_6m_cpll_cpu_sys) top_pre_div_clk_409_6m_cpll_cpu_sys
#----------------------------------------------------------------------------
#clk_480m_usbphy_pll_cpu_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_480m_usbphy_pll_cpu_sys \
        -master_clock $name_clk_480m_top_pre_div \
        -source $hier_clk_480m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_480m_usbphy_pll_cpu_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_480m_usbphy_pll_cpu_sys) top_pre_div_clk_480m_usbphy_pll_cpu_sys
#----------------------------------------------------------------------------
#clk_491_52m_cpll_cpu_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_491_52m_cpll_cpu_sys \
        -master_clock $name_clk_491_52m_top_pre_div \
        -source $hier_clk_491_52m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_491_52m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_491_52m_cpll_cpu_sys) top_pre_div_clk_491_52m_cpll_cpu_sys
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
#clk_26m_xo_dbg_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_26m_xo_dbg_sys \
        -master_clock $name_clk_26m_dbg_src \
        -source $hier_clk_26m_dbg_src \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_xo_dbg_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_26m_xo_dbg_sys) top_pre_div_clk_26m_xo_dbg_sys
#----------------------------------------------------------------------------
#clk_26m_xo_cp_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_26m_xo_cp_sys \
        -master_clock $name_clk_26m_top_pre_div \
        -source $hier_clk_26m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_xo_cp_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_26m_xo_cp_sys) top_pre_div_clk_26m_xo_cp_sys
#----------------------------------------------------------------------------
#clk_30_72m_cpll_cp_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_30_72m_cpll_cp_sys \
        -master_clock top_pre_div_clk_30_72m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_30_72m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_30_72m_cpll_cp_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(clk_245m76_cp_src) top_pre_div_clk_30_72m_cpll_cp_sys
#----------------------------------------------------------------------------
#clk_51_2m_cpll_cp_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_51_2m_cpll_cp_sys \
        -master_clock top_pre_div_clk_51_2m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_cpll_cp_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_51_2m_cpll_cp_sys) top_pre_div_clk_51_2m_cpll_cp_sys
#----------------------------------------------------------------------------
#clk_102_4m_cpll_cp_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_102_4m_cpll_cp_sys \
        -master_clock top_pre_div_clk_102_4m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_cpll_cp_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_102_4m_cpll_cp_sys) top_pre_div_clk_102_4m_cpll_cp_sys
#----------------------------------------------------------------------------
#clk_122_88m_cpll_cp_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_122_88m_cpll_cp_sys \
        -master_clock top_pre_div_clk_122_88m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_122_88m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_122_88m_cpll_cp_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_122_88m_cpll_cp_sys) top_pre_div_clk_122_88m_cpll_cp_sys
#----------------------------------------------------------------------------
#clk_204_8m_cpll_cp_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_204_8m_cpll_cp_sys \
        -master_clock top_pre_div_clk_204_8m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_cpll_cp_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_204_8m_cpll_cp_sys) top_pre_div_clk_204_8m_cpll_cp_sys
#----------------------------------------------------------------------------
#clk_245_76m_cpll_cp_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_245_76m_cpll_cp_sys \
        -master_clock $name_clk_245_76m_top_pre_div \
        -source $hier_clk_245_76m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_245_76m_cpll_cp_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(clk_245m76_cp_src) top_pre_div_clk_245_76m_cpll_cp_sys
#----------------------------------------------------------------------------
#clk_307_2m_cpll_ap_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_307_2m_cpll_ap_sys \
        -master_clock $name_clk_307_2m_top_pre_div \
        -source $hier_clk_307_2m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_307_2m_cpll_ap_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_307_2m_cpll_ap_sys) top_pre_div_clk_307_2m_cpll_ap_sys
#----------------------------------------------------------------------------
#clk_245_76m_cpll_ap_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_245_76m_cpll_ap_sys \
        -master_clock $name_clk_245_76m_top_pre_div \
        -source $hier_clk_245_76m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_245_76m_cpll_ap_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_245_76m_cpll_ap_sys) top_pre_div_clk_245_76m_cpll_ap_sys
#----------------------------------------------------------------------------
#clk_204_8m_cpll_ap_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_204_8m_cpll_ap_sys \
        -master_clock top_pre_div_clk_204_8m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_cpll_ap_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_204_8m_cpll_ap_sys) top_pre_div_clk_204_8m_cpll_ap_sys
#----------------------------------------------------------------------------
#clk_153_6m_cpll_ap_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_153_6m_cpll_ap_sys \
        -master_clock top_pre_div_clk_153_6m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_153_6m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_153_6m_cpll_ap_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_153_6m_cpll_ap_sys) top_pre_div_clk_153_6m_cpll_ap_sys
#----------------------------------------------------------------------------
#clk_102_4m_cpll_ap_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_102_4m_cpll_ap_sys \
        -master_clock top_pre_div_clk_102_4m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_cpll_ap_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_102_4m_cpll_ap_sys) top_pre_div_clk_102_4m_cpll_ap_sys
#----------------------------------------------------------------------------
#clk_76_8m_cpll_ap_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_76_8m_cpll_ap_sys \
        -master_clock top_pre_div_clk_76_8m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_76_8m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_76_8m_cpll_ap_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_76_8m_cpll_ap_sys) top_pre_div_clk_76_8m_cpll_ap_sys
#----------------------------------------------------------------------------
#clk_61_44m_cpll_ap_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_61_44m_cpll_ap_sys \
        -master_clock top_pre_div_clk_61_44m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_61_44m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_61_44m_cpll_ap_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_61_44m_cpll_ap_sys) top_pre_div_clk_61_44m_cpll_ap_sys
#----------------------------------------------------------------------------
#clk_51_2m_cpll_ap_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_51_2m_cpll_ap_sys \
        -master_clock top_pre_div_clk_51_2m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_cpll_ap_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_51_2m_cpll_ap_sys) top_pre_div_clk_51_2m_cpll_ap_sys
#----------------------------------------------------------------------------
#clk_30_72m_cpll_ap_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_30_72m_cpll_ap_sys \
        -master_clock top_pre_div_clk_30_72m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_30_72m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_30_72m_cpll_ap_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_30_72m_cpll_ap_sys) top_pre_div_clk_30_72m_cpll_ap_sys
#----------------------------------------------------------------------------
#clk_26m_xo_ap_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_26m_xo_ap_sys \
        -master_clock $name_clk_26m_top_pre_div \
        -source $hier_clk_26m_top_pre_div \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_xo_ap_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_26m_xo_ap_sys) top_pre_div_clk_26m_xo_ap_sys
#----------------------------------------------------------------------------
#clk_19_2m_cpll_ap_sys
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_19_2m_cpll_ap_sys \
        -master_clock top_pre_div_clk_19_2m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_19_2m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_19_2m_cpll_ap_sys_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_19_2m_cpll_ap_sys) top_pre_div_clk_19_2m_cpll_ap_sys
#----------------------------------------------------------------------------
#clk_30_72m_aon
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_30_72m_aon \
        -master_clock top_pre_div_clk_30_72m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_30_72m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_30_72m_aon_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(clk_245m76_cp_src) top_pre_div_clk_30_72m_aon
#----------------------------------------------------------------------------
#clk_12_288m_to_aux
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_pre_div_clk_12_288m_to_aux \
        -master_clock top_pre_div_clk_12_288m_top_pre_div \
        -source ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_12_288m_top_pre_div_div/$CKOUTZ_HIER \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_12_288m_to_aux_cg/$CKOUTQ_HIER
    lappend CLOCK_GROUP(top_pre_div_clk_12_288m_to_aux) top_pre_div_clk_12_288m_to_aux
#----------------------------------------------------------------------------
#for sub sys
#----------------------------------------------------------------------------
    set name_clk_122_88m_top_pre_div top_pre_div_clk_122_88m_top_pre_div
    set hier_clk_122_88m_top_pre_div ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_122_88m_top_pre_div_div/$CKOUTZ_HIER
    set name_clk_61_44m_top_pre_div top_pre_div_clk_61_44m_top_pre_div
    set hier_clk_61_44m_top_pre_div ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_61_44m_top_pre_div_div/$CKOUTZ_HIER
    set name_clk_30_72m_top_pre_div top_pre_div_clk_30_72m_top_pre_div
    set hier_clk_30_72m_top_pre_div ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_30_72m_top_pre_div_div/$CKOUTZ_HIER
    set name_clk_12_288m_top_pre_div top_pre_div_clk_12_288m_top_pre_div
    set hier_clk_12_288m_top_pre_div ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_12_288m_top_pre_div_div/$CKOUTZ_HIER
    set name_clk_204_8m_top_pre_div top_pre_div_clk_204_8m_top_pre_div
    set hier_clk_204_8m_top_pre_div ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_top_pre_div_div/$CKOUTZ_HIER
    set name_clk_102_4m_top_pre_div top_pre_div_clk_102_4m_top_pre_div
    set hier_clk_102_4m_top_pre_div ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_top_pre_div_div/$CKOUTZ_HIER
    set name_clk_51_2m_top_pre_div top_pre_div_clk_51_2m_top_pre_div
    set hier_clk_51_2m_top_pre_div ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_top_pre_div_div/$CKOUTZ_HIER
    set name_clk_153_6m_top_pre_div top_pre_div_clk_153_6m_top_pre_div
    set hier_clk_153_6m_top_pre_div ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_153_6m_top_pre_div_div/$CKOUTZ_HIER
    set name_clk_76_8m_top_pre_div top_pre_div_clk_76_8m_top_pre_div
    set hier_clk_76_8m_top_pre_div ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_76_8m_top_pre_div_div/$CKOUTZ_HIER
    set name_clk_38_4m_top_pre_div top_pre_div_clk_38_4m_top_pre_div
    set hier_clk_38_4m_top_pre_div ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_38_4m_top_pre_div_div/$CKOUTZ_HIER
    set name_clk_19_2m_top_pre_div top_pre_div_clk_19_2m_top_pre_div
    set hier_clk_19_2m_top_pre_div ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_19_2m_top_pre_div_div/$CKOUTZ_HIER
    set name_clk_245_76m_top top_pre_div_clk_245_76m_top
    set hier_clk_245_76m_top ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_245_76m_top_cg/$CKOUTQ_HIER
    set name_clk_204_8m_top top_pre_div_clk_204_8m_top
    set hier_clk_204_8m_top ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_top_cg/$CKOUTQ_HIER
    set name_clk_153_6m_top top_pre_div_clk_153_6m_top
    set hier_clk_153_6m_top ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_153_6m_top_cg/$CKOUTQ_HIER
    set name_clk_102_4m_top top_pre_div_clk_102_4m_top
    set hier_clk_102_4m_top ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_top_cg/$CKOUTQ_HIER
    set name_clk_76_8m_top top_pre_div_clk_76_8m_top
    set hier_clk_76_8m_top ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_76_8m_top_cg/$CKOUTQ_HIER
    set name_clk_61_44m_top top_pre_div_clk_61_44m_top
    set hier_clk_61_44m_top ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_61_44m_top_cg/$CKOUTQ_HIER
    set name_clk_51_2m_top top_pre_div_clk_51_2m_top
    set hier_clk_51_2m_top ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_top_cg/$CKOUTQ_HIER
    set name_clk_26m_top top_pre_div_clk_26m_top
    set hier_clk_26m_top ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_top_cg/$CKOUTQ_HIER
    set name_clk_32k_top top_pre_div_clk_32k_top
    set hier_clk_32k_top ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_32k_top_cg/$CKOUTQ_HIER
    set name_clk_15k_top top_pre_div_clk_15k_top
    set hier_clk_15k_top ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_15k_top_cg/$CKOUTQ_HIER
    set name_clk_26m_efuse top_pre_div_clk_26m_efuse
    set hier_clk_26m_efuse ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_efuse_cg/$CKOUTQ_HIER
    set name_clk_204_8m_pub top_pre_div_clk_204_8m_pub
    set hier_clk_204_8m_pub ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_pub_cg/$CKOUTQ_HIER
    set name_clk_153_6m_pub top_pre_div_clk_153_6m_pub
    set hier_clk_153_6m_pub ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_153_6m_pub_cg/$CKOUTQ_HIER
    set name_clk_122_88m_pub top_pre_div_clk_122_88m_pub
    set hier_clk_122_88m_pub ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_122_88m_pub_cg/$CKOUTQ_HIER
    set name_clk_102_4m_pub top_pre_div_clk_102_4m_pub
    set hier_clk_102_4m_pub ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_pub_cg/$CKOUTQ_HIER
    set name_clk_76_8m_pub top_pre_div_clk_76_8m_pub
    set hier_clk_76_8m_pub ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_76_8m_pub_cg/$CKOUTQ_HIER
    set name_clk_61_44m_pub top_pre_div_clk_61_44m_pub
    set hier_clk_61_44m_pub ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_61_44m_pub_cg/$CKOUTQ_HIER
    set name_clk_26m_pub top_pre_div_clk_26m_pub
    set hier_clk_26m_pub ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_pub_cg/$CKOUTQ_HIER
    set name_clk_32k_aon_cpu_sys top_pre_div_clk_32k_aon_cpu_sys
    set hier_clk_32k_aon_cpu_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_32k_aon_cpu_sys_cg/$CKOUTQ_HIER
    set name_clk_26m_xo_cpu_sys top_pre_div_clk_26m_xo_cpu_sys
    set hier_clk_26m_xo_cpu_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_xo_cpu_sys_cg/$CKOUTQ_HIER
    set name_clk_51_2m_cpll_cpu_sys top_pre_div_clk_51_2m_cpll_cpu_sys
    set hier_clk_51_2m_cpll_cpu_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    set name_clk_102_4m_cpll_cpu_sys top_pre_div_clk_102_4m_cpll_cpu_sys
    set hier_clk_102_4m_cpll_cpu_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    set name_clk_204_8m_cpll_cpu_sys top_pre_div_clk_204_8m_cpll_cpu_sys
    set hier_clk_204_8m_cpll_cpu_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    set name_clk_245_76m_cpll_cpu_sys top_pre_div_clk_245_76m_cpll_cpu_sys
    set hier_clk_245_76m_cpll_cpu_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_245_76m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    set name_clk_307_2m_cpll_cpu_sys top_pre_div_clk_307_2m_cpll_cpu_sys
    set hier_clk_307_2m_cpll_cpu_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_307_2m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    set name_clk_409_6m_cpll_cpu_sys top_pre_div_clk_409_6m_cpll_cpu_sys
    set hier_clk_409_6m_cpll_cpu_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_409_6m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    set name_clk_480m_usbphy_pll_cpu_sys top_pre_div_clk_480m_usbphy_pll_cpu_sys
    set hier_clk_480m_usbphy_pll_cpu_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_480m_usbphy_pll_cpu_sys_cg/$CKOUTQ_HIER
    set name_clk_491_52m_cpll_cpu_sys top_pre_div_clk_491_52m_cpll_cpu_sys
    set hier_clk_491_52m_cpll_cpu_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_491_52m_cpll_cpu_sys_cg/$CKOUTQ_HIER
    set name_clk_32k_aon_dbg_sys top_pre_div_clk_32k_aon_dbg_sys
    set hier_clk_32k_aon_dbg_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_32k_aon_dbg_sys_cg/$CKOUTQ_HIER
    set name_clk_26m_xo_dbg_sys top_pre_div_clk_26m_xo_dbg_sys
    set hier_clk_26m_xo_dbg_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_xo_dbg_sys_cg/$CKOUTQ_HIER
    set name_clk_26m_xo_cp_sys top_pre_div_clk_26m_xo_cp_sys
    set hier_clk_26m_xo_cp_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_xo_cp_sys_cg/$CKOUTQ_HIER
    set name_clk_30_72m_cpll_cp_sys top_pre_div_clk_30_72m_cpll_cp_sys
    set hier_clk_30_72m_cpll_cp_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_30_72m_cpll_cp_sys_cg/$CKOUTQ_HIER
    set name_clk_51_2m_cpll_cp_sys top_pre_div_clk_51_2m_cpll_cp_sys
    set hier_clk_51_2m_cpll_cp_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_cpll_cp_sys_cg/$CKOUTQ_HIER
    set name_clk_102_4m_cpll_cp_sys top_pre_div_clk_102_4m_cpll_cp_sys
    set hier_clk_102_4m_cpll_cp_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_cpll_cp_sys_cg/$CKOUTQ_HIER
    set name_clk_122_88m_cpll_cp_sys top_pre_div_clk_122_88m_cpll_cp_sys
    set hier_clk_122_88m_cpll_cp_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_122_88m_cpll_cp_sys_cg/$CKOUTQ_HIER
    set name_clk_204_8m_cpll_cp_sys top_pre_div_clk_204_8m_cpll_cp_sys
    set hier_clk_204_8m_cpll_cp_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_cpll_cp_sys_cg/$CKOUTQ_HIER
    set name_clk_245_76m_cpll_cp_sys top_pre_div_clk_245_76m_cpll_cp_sys
    set hier_clk_245_76m_cpll_cp_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_245_76m_cpll_cp_sys_cg/$CKOUTQ_HIER
    set name_clk_307_2m_cpll_ap_sys top_pre_div_clk_307_2m_cpll_ap_sys
    set hier_clk_307_2m_cpll_ap_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_307_2m_cpll_ap_sys_cg/$CKOUTQ_HIER
    set name_clk_245_76m_cpll_ap_sys top_pre_div_clk_245_76m_cpll_ap_sys
    set hier_clk_245_76m_cpll_ap_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_245_76m_cpll_ap_sys_cg/$CKOUTQ_HIER
    set name_clk_204_8m_cpll_ap_sys top_pre_div_clk_204_8m_cpll_ap_sys
    set hier_clk_204_8m_cpll_ap_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_204_8m_cpll_ap_sys_cg/$CKOUTQ_HIER
    set name_clk_153_6m_cpll_ap_sys top_pre_div_clk_153_6m_cpll_ap_sys
    set hier_clk_153_6m_cpll_ap_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_153_6m_cpll_ap_sys_cg/$CKOUTQ_HIER
    set name_clk_102_4m_cpll_ap_sys top_pre_div_clk_102_4m_cpll_ap_sys
    set hier_clk_102_4m_cpll_ap_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_102_4m_cpll_ap_sys_cg/$CKOUTQ_HIER
    set name_clk_76_8m_cpll_ap_sys top_pre_div_clk_76_8m_cpll_ap_sys
    set hier_clk_76_8m_cpll_ap_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_76_8m_cpll_ap_sys_cg/$CKOUTQ_HIER
    set name_clk_61_44m_cpll_ap_sys top_pre_div_clk_61_44m_cpll_ap_sys
    set hier_clk_61_44m_cpll_ap_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_61_44m_cpll_ap_sys_cg/$CKOUTQ_HIER
    set name_clk_51_2m_cpll_ap_sys top_pre_div_clk_51_2m_cpll_ap_sys
    set hier_clk_51_2m_cpll_ap_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_51_2m_cpll_ap_sys_cg/$CKOUTQ_HIER
    set name_clk_30_72m_cpll_ap_sys top_pre_div_clk_30_72m_cpll_ap_sys
    set hier_clk_30_72m_cpll_ap_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_30_72m_cpll_ap_sys_cg/$CKOUTQ_HIER
    set name_clk_26m_xo_ap_sys top_pre_div_clk_26m_xo_ap_sys
    set hier_clk_26m_xo_ap_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_xo_ap_sys_cg/$CKOUTQ_HIER
    set name_clk_19_2m_cpll_ap_sys top_pre_div_clk_19_2m_cpll_ap_sys
    set hier_clk_19_2m_cpll_ap_sys ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_19_2m_cpll_ap_sys_cg/$CKOUTQ_HIER
    set name_clk_30_72m_aon top_pre_div_clk_30_72m_aon
    set hier_clk_30_72m_aon ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_30_72m_aon_cg/$CKOUTQ_HIER
    set name_clk_12_288m_to_aux top_pre_div_clk_12_288m_to_aux
    set hier_clk_12_288m_to_aux ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_12_288m_to_aux_cg/$CKOUTQ_HIER
