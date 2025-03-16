######################################################################
###############################Create source Clock
######################################################################
if {$IS_FLAT} {
    create_generated_clock -name ${AON_SYS_NAME}_clk_aon_frc_30_72m \
                       -master_clock top_pre_div_clk_30_72m_top_pre_div\
                       -source [get_pins ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_30_72m_top_pre_div_div/$CKOUTZ_HIER] \
                       -divide_by 1 -add \
                       [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_clk_frc_switch/$CKOUTZ_HIER]

    lappend CLOCK_GROUP(clk_245m76_cp_src)     [ list ${AON_SYS_NAME}_clk_aon_frc_30_72m]
}
