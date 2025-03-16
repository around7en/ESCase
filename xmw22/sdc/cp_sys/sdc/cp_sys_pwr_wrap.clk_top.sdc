if {![info exist CP_SYS_TOP_HIER]} {
set CP_SYS_TOP_HIER     "${CP_SYS_HIER}u_cp_sys_top/"
}
if {![info exist CP_SYS_CLK_CORE_HIER]} {
set CP_SYS_CLK_CORE_HIER    "${CP_SYS_HIER}u_cp_sys_top/u_cp_sys_clk_top/u_cp_clk_core_wrap/u_cp_clk_core/"
}
if {![info exist CP_SYS_CLK_MANUAL_HIER]} {
set CP_SYS_CLK_MANUAL_HIER  "${CP_SYS_HIER}u_cp_sys_top/u_cp_sys_clk_top/u_cp_clk_manual/"
}

if {! $IS_CHIP} {


    create_clock -name cp_sys_V_CLK_26M            -period $CYCLE_26M
    lappend CLOCK_GROUP(cp_sys_V_CLK_26M) cp_sys_V_CLK_26M


    create_clock -name cp_sys_clk_102_4m_cpll_cp_sys -period $CYCLE_102M4 -add [get_ports clk_102_4m_cpll_cp_sys]
    lappend CLOCK_GROUP(cp_sys_clk_102_4m_cpll_cp_sys)    cp_sys_clk_102_4m_cpll_cp_sys
    set name_clk_102_4m_cpll_cp_sys cp_sys_clk_102_4m_cpll_cp_sys
    set hier_clk_102_4m_cpll_cp_sys [get_ports clk_102_4m_cpll_cp_sys]

    create_clock -name cp_sys_clk_122_88m_cpll_cp_sys -period $CYCLE_122M88 -add [get_ports clk_122_88m_cpll_cp_sys]
    lappend CLOCK_GROUP(cp_sys_clk_122_88m_cpll_cp_sys)    cp_sys_clk_122_88m_cpll_cp_sys
    set name_clk_122_88m_cpll_cp_sys cp_sys_clk_122_88m_cpll_cp_sys
    set hier_clk_122_88m_cpll_cp_sys [get_ports clk_122_88m_cpll_cp_sys]

    create_clock -name cp_sys_clk_204_8m_cpll_cp_sys -period $CYCLE_204M8 -add [get_ports clk_204_8m_cpll_cp_sys]
    lappend CLOCK_GROUP(cp_sys_clk_204_8m_cpll_cp_sys)    cp_sys_clk_204_8m_cpll_cp_sys
    set name_clk_204_8m_cpll_cp_sys cp_sys_clk_204_8m_cpll_cp_sys
    set hier_clk_204_8m_cpll_cp_sys [get_ports clk_204_8m_cpll_cp_sys]

    create_clock -name cp_sys_clk_245_76m_cpll_cp_sys -period $CYCLE_245M76 -waveform "0 [expr $CYCLE_245M76*0.4]" -add [get_ports clk_245_76m_cpll_cp_sys]
    #lappend CLOCK_GROUP(cp_sys_clk_245_76m_cpll_cp_sys)    cp_sys_clk_245_76m_cpll_cp_sys
    lappend CLOCK_GROUP(clk_245m76_cp_src)    cp_sys_clk_245_76m_cpll_cp_sys
    set name_clk_245_76m_cpll_cp_sys cp_sys_clk_245_76m_cpll_cp_sys
    set hier_clk_245_76m_cpll_cp_sys [get_ports clk_245_76m_cpll_cp_sys]

    create_clock -name cp_sys_clk_26m_xo_cp_sys -period $CYCLE_26M -add [get_ports clk_26m_xo_cp_sys]
    lappend CLOCK_GROUP(cp_sys_clk_26m_xo_cp_sys)    cp_sys_clk_26m_xo_cp_sys
    set name_clk_26m_xo_cp_sys cp_sys_clk_26m_xo_cp_sys
    set hier_clk_26m_xo_cp_sys [get_ports clk_26m_xo_cp_sys]

    create_clock -name cp_sys_clk_30_72m_cpll_cp_sys -period $CYCLE_30M72 -add [get_ports clk_30_72m_cpll_cp_sys]
    #lappend CLOCK_GROUP(cp_sys_clk_30_72m_cpll_cp_sys)    cp_sys_clk_30_72m_cpll_cp_sys
    lappend CLOCK_GROUP(clk_245m76_cp_src)    cp_sys_clk_30_72m_cpll_cp_sys
    set name_clk_30_72m_cpll_cp_sys cp_sys_clk_30_72m_cpll_cp_sys
    set hier_clk_30_72m_cpll_cp_sys [get_ports clk_30_72m_cpll_cp_sys]

    create_clock -name cp_sys_clk_51_2m_cpll_cp_sys -period $CYCLE_51M2 -add [get_ports clk_51_2m_cpll_cp_sys]
    lappend CLOCK_GROUP(cp_sys_clk_51_2m_cpll_cp_sys)    cp_sys_clk_51_2m_cpll_cp_sys
    set name_clk_51_2m_cpll_cp_sys cp_sys_clk_51_2m_cpll_cp_sys
    set hier_clk_51_2m_cpll_cp_sys [get_ports clk_51_2m_cpll_cp_sys]

    create_clock -name cp_sys_clk_adc_1x_i_ana_in -period $CYCLE_122M88  -add [get_ports rxadc_ck_sar_latch_i]
    lappend CLOCK_GROUP(clk_dig_122p88m_rftop)    cp_sys_clk_adc_1x_i_ana_in
    set name_clk_adc_1x_i_ana_in cp_sys_clk_adc_1x_i_ana_in
    set hier_clk_adc_1x_i_ana_in [get_ports rxadc_ck_sar_latch_i]

    create_clock -name cp_sys_clk_adc_1x_q_ana_in -period $CYCLE_122M88 -add [get_ports rxadc_ck_sar_latch_q]
    lappend CLOCK_GROUP(clk_dig_122p88m_rftop)    cp_sys_clk_adc_1x_q_ana_in
    set name_clk_adc_1x_q_ana_in cp_sys_clk_adc_1x_q_ana_in
    set hier_clk_adc_1x_q_ana_in [get_ports rxadc_ck_sar_latch_q]

    create_clock -name cp_sys_clk_adc_2x_ana_in -period $CYCLE_245M76 -add [get_ports rxadc_clk245m]
    lappend CLOCK_GROUP(rftop_rxadc_clk245m)    cp_sys_clk_adc_2x_ana_in
    set name_clk_adc_2x_ana_in cp_sys_clk_adc_2x_ana_in
    set hier_clk_adc_2x_ana_in [get_ports rxadc_clk245m]

    create_clock -name cp_sys_clk_adc_2x_ana_in_res -period [expr $CYCLE_1228M8*5.5] -waveform "0 [expr  $CYCLE_1228M8*5.5*0.36]" -add [get_ports rxadc_clk245m]
    lappend CLOCK_GROUP(rftop_rxadc_clk245m_res)    cp_sys_clk_adc_2x_ana_in_res
    set name_clk_adc_2x_ana_in_res cp_sys_clk_adc_2x_ana_in_res
    set hier_clk_adc_2x_ana_in_res [get_ports rxadc_clk245m]

    create_clock -name cp_sys_clk_dac_ana_in -period $CYCLE_122M88 -add [get_ports clk_dig_122p88m]
    lappend CLOCK_GROUP(cp_sys_clk_dac)    cp_sys_clk_dac_ana_in
    set name_clk_dac_ana_in cp_sys_clk_dac_ana_in
    set hier_clk_dac_ana_in [get_ports clk_dig_122p88m]

    create_clock -name cp_sys_clk_psram_ahb -period $CYCLE_204M8 -add [get_ports clk_psram_ahb]
    lappend CLOCK_GROUP(cp_sys_clk_psram_ahb)    cp_sys_clk_psram_ahb
    set name_clk_psram_ahb cp_sys_clk_psram_ahb
    set hier_clk_psram_ahb [get_ports clk_psram_ahb]
    create_clock -name cp_sys_clk_sysram_ahb -period $CYCLE_245M76 -add [get_ports clk_sysram_ahb]
    lappend CLOCK_GROUP(cp_sys_clk_sysram_ahb)    cp_sys_clk_sysram_ahb
    set name_clk_sysram_ahb cp_sys_clk_sysram_ahb
    set hier_clk_sysram_ahb [get_ports clk_sysram_ahb]

    create_clock -name cp_sys_clk_top_ahb -period $CYCLE_102M4 -add [get_ports clk_top_ahb]
    lappend CLOCK_GROUP(cp_sys_clk_top_ahb)    cp_sys_clk_top_ahb
    set name_clk_top_ahb cp_sys_clk_top_ahb
    set hier_clk_top_ahb [get_ports clk_top_ahb]

    create_clock -name cp_sys_clk_txpll_mash_ana_in -period $CYCLE_102M4 -waveform "0 [expr $CYCLE_102M4*0.1]" -add [get_ports txpll_ds_26m_clk]
    lappend CLOCK_GROUP(cp_sys_clk_txpll_mash)    cp_sys_clk_txpll_mash_ana_in
    set name_clk_txpll_mash_ana_in cp_sys_clk_txpll_mash_ana_in
    set hier_clk_txpll_mash_ana_in [get_ports txpll_ds_26m_clk]

    create_clock -name cp_sys_clk_rxpll_mash_ana_in -period $CYCLE_102M4 -waveform "0 [expr $CYCLE_102M4*0.1]" -add [get_ports rxpll_ds_26m_clk]
    lappend CLOCK_GROUP(cp_sys_clk_rxpll_mash)    cp_sys_clk_rxpll_mash_ana_in
    set name_clk_rxpll_mash_ana_in cp_sys_clk_rxpll_mash_ana_in
    set hier_clk_rxpll_mash_ana_in [get_ports rxpll_ds_26m_clk]


}

#############################################################################
###Clock Mux Generate
#############################################################################
###generate mux clock clk_mipi_rffe:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_mipi_rffe -add \
                      -master_clock $name_clk_51_2m_cpll_cp_sys \
                      -source $hier_clk_51_2m_cpll_cp_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_cmind_clk_mux2_clk_mipi_rffe/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(cp_sys_clk_mipi_rffe) ${CP_LIB_HIER}cp_sys_clk_mipi_rffe                                            
set name_clk_mipi_rffe cp_sys_clk_mipi_rffe
set hier_clk_mipi_rffe ${CP_SYS_CLK_CORE_HIER}u_cmind_clk_mux2_clk_mipi_rffe/$CKOUTZ_HIER
# mipi
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_mipi_div2 -add \
                       -master_clock $name_clk_mipi_rffe \
                       -source $hier_clk_mipi_rffe \
                       -divide_by 2 \
                       [get_pins ${CP_SYS_TOP_HIER}u_cp_ip_mipi_rffe/U_prescalar/u_cmind_o_pre_com_scl_mux/cmind_uj_ckcell/I0]
}
lappend CLOCK_GROUP(cp_sys_clk_mipi_rffe) ${CP_LIB_HIER}cp_sys_clk_mipi_div2
set name_clk_mipi_div2 cp_sys_clk_mipi_div2
set hier_clk_mipi_div2 ${CP_SYS_TOP_HIER}u_cp_ip_mipi_rffe/U_prescalar/u_cmind_o_pre_com_scl_mux/cmind_uj_ckcell/I0

if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_mipi_o_pre_com_scl -add \
                       -master_clock $name_clk_mipi_div2 \
                       -source $hier_clk_mipi_div2 \
                       -divide_by 1 \
                       -combinational \
                       [get_pins ${CP_SYS_TOP_HIER}u_cp_ip_mipi_rffe/U_prescalar/u_cmind_o_pre_com_scl_mux/cmind_uj_ckcell/Z]
}
lappend CLOCK_GROUP(cp_sys_clk_mipi_rffe) ${CP_LIB_HIER}cp_sys_clk_mipi_o_pre_com_scl
set name_clk_mipi_o_pre_com_scl cp_sys_clk_mipi_o_pre_com_scl
set hier_clk_mipi_o_pre_com_scl ${CP_SYS_TOP_HIER}u_cp_ip_mipi_rffe/U_prescalar/u_cmind_o_pre_com_scl_mux/cmind_uj_ckcell/Z

if {!$IS_CHIP} {
create_generated_clock -name cp_sys_clk_mipi_o_scl  -add \
                       -master_clock $name_clk_mipi_o_pre_com_scl \
                       -source $hier_clk_mipi_o_pre_com_scl \
                       -divide_by 1 \
                       -combinational \
                       [get_ports mipi_o_scl]
} elseif {$IS_CHIP && !$IS_FLAT} {
lappend CLOCK_GROUP(cp_sys_clk_mipi_rffe) ${CP_LIB_HIER}mipi_o_scl
create_generated_clock -name cp_sys_clk_mipi_o_scl  -add \
                       -master_clock ${CP_LIB_HIER}mipi_o_scl \
                       -source ${CP_LIB_HIER}mipi_o_scl \
                       -divide_by 1 \
                       -combinational \
                       [get_ports $func_pad_names(rffe_clk)]
} elseif {$IS_CHIP} {
create_generated_clock -name cp_sys_clk_mipi_o_scl  -add \
                       -master_clock $name_clk_mipi_o_pre_com_scl \
                       -source $hier_clk_mipi_o_pre_com_scl \
                       -divide_by 1 \
                       -combinational \
                       [get_ports $func_pad_names(rffe_clk)]
}
lappend CLOCK_GROUP(cp_sys_clk_mipi_rffe) cp_sys_clk_mipi_o_scl                                            


#############################################################################
###Clock Gate Generate
#############################################################################
###generate gates clock clk_modem:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_modem -add \
                      -master_clock $name_clk_245_76m_cpll_cp_sys \
                      -source $hier_clk_245_76m_cpll_cp_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_cmind_ckmux_clk_modem/cmind_uj_ckcell/Z]
}
lappend CLOCK_GROUP(clk_245m76_cp_src) ${CP_LIB_HIER}cp_sys_clk_modem   
set name_clk_modem cp_sys_clk_modem
set hier_clk_modem ${CP_SYS_CLK_CORE_HIER}u_cmind_ckmux_clk_modem/cmind_uj_ckcell/Z

###generate gates clock clk_rft:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_rft -add \
                      -master_clock $name_clk_30_72m_cpll_cp_sys \
                      -source $hier_clk_30_72m_cpll_cp_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_cmind_ckmux_clk_rft/cmind_uj_ckcell/Z]
}
lappend CLOCK_GROUP(clk_245m76_cp_src) ${CP_LIB_HIER}cp_sys_clk_rft   
set name_clk_rft cp_sys_clk_rft
set hier_clk_rft ${CP_SYS_CLK_CORE_HIER}u_cmind_ckmux_clk_rft/cmind_uj_ckcell/Z

#############################################################################
###Clock Divider Generate
#############################################################################
###generate divider clock clk_dfe:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_dfe -add \
                      -master_clock $name_clk_modem \
                      -source $hier_clk_modem \
                      -divide_by 2 \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_clk_dfe_div2/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(clk_245m76_cp_src) ${CP_LIB_HIER}cp_sys_clk_dfe   
set name_clk_dfe cp_sys_clk_dfe
set hier_clk_dfe ${CP_SYS_CLK_CORE_HIER}u_clk_dfe_div2/$CKOUTZ_HIER

#############################################################################
###OCC scanmux I1 pin Clock Generate
#############################################################################
###generate clk clk_dac_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_dac_scan -add \
                      -master_clock $name_clk_122_88m_cpll_cp_sys \
                      -source $hier_clk_122_88m_cpll_cp_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_clk_dac_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cp_sys_clk_dac_scan) ${CP_LIB_HIER}cp_sys_clk_dac_scan   
set name_clk_dac_scan cp_sys_clk_dac_scan
set hier_clk_dac_scan ${CP_SYS_CLK_CORE_HIER}u_clk_dac_scanmux/cmind_uj_ckcell/I1

###generate clk clk_adc_1x_i_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_adc_1x_i_scan -add \
                      -master_clock $name_clk_122_88m_cpll_cp_sys \
                      -source $hier_clk_122_88m_cpll_cp_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_clk_adc_1x_i_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cp_sys_clk_adc_1x_i_scan) ${CP_LIB_HIER}cp_sys_clk_adc_1x_i_scan   
set name_clk_adc_1x_i_scan cp_sys_clk_adc_1x_i_scan
set hier_clk_adc_1x_i_scan ${CP_SYS_CLK_CORE_HIER}u_clk_adc_1x_i_scanmux/cmind_uj_ckcell/I1

###generate clk clk_adc_1x_q_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_adc_1x_q_scan -add \
                      -master_clock $name_clk_122_88m_cpll_cp_sys \
                      -source $hier_clk_122_88m_cpll_cp_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_clk_adc_1x_q_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cp_sys_clk_adc_1x_q_scan) ${CP_LIB_HIER}cp_sys_clk_adc_1x_q_scan   
set name_clk_adc_1x_q_scan cp_sys_clk_adc_1x_q_scan
set hier_clk_adc_1x_q_scan ${CP_SYS_CLK_CORE_HIER}u_clk_adc_1x_q_scanmux/cmind_uj_ckcell/I1

###generate clk clk_adc_2x_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_adc_2x_scan -add \
                      -master_clock $name_clk_245_76m_cpll_cp_sys \
                      -source $hier_clk_245_76m_cpll_cp_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_clk_adc_2x_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cp_sys_clk_adc_2x_scan) ${CP_LIB_HIER}cp_sys_clk_adc_2x_scan   
set name_clk_adc_2x_scan cp_sys_clk_adc_2x_scan
set hier_clk_adc_2x_scan ${CP_SYS_CLK_CORE_HIER}u_clk_adc_2x_scanmux/cmind_uj_ckcell/I1

###generate clk clk_txpll_mash_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_txpll_mash_scan -add \
                      -master_clock $name_clk_102_4m_cpll_cp_sys \
                      -source $hier_clk_102_4m_cpll_cp_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_clk_txpll_mash_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cp_sys_clk_txpll_mash_scan) ${CP_LIB_HIER}cp_sys_clk_txpll_mash_scan   
set name_clk_txpll_mash_scan cp_sys_clk_txpll_mash_scan
set hier_clk_txpll_mash_scan ${CP_SYS_CLK_CORE_HIER}u_clk_txpll_mash_scanmux/cmind_uj_ckcell/I1

###generate clk clk_rxpll_mash_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_rxpll_mash_scan -add \
                      -master_clock $name_clk_102_4m_cpll_cp_sys \
                      -source $hier_clk_102_4m_cpll_cp_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_clk_rxpll_mash_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cp_sys_clk_rxpll_mash_scan) ${CP_LIB_HIER}cp_sys_clk_rxpll_mash_scan   
set name_clk_rxpll_mash_scan cp_sys_clk_rxpll_mash_scan
set hier_clk_rxpll_mash_scan ${CP_SYS_CLK_CORE_HIER}u_clk_rxpll_mash_scanmux/cmind_uj_ckcell/I1

###generate clk clk_top_ahb_scan_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_top_ahb_scan_scan -add \
                      -master_clock $name_clk_102_4m_cpll_cp_sys \
                      -source $hier_clk_102_4m_cpll_cp_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_clk_top_ahb_scan_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cp_sys_clk_top_ahb_scan_scan) ${CP_LIB_HIER}cp_sys_clk_top_ahb_scan_scan   
set name_clk_top_ahb_scan_scan cp_sys_clk_top_ahb_scan_scan
set hier_clk_top_ahb_scan_scan ${CP_SYS_CLK_CORE_HIER}u_clk_top_ahb_scan_scanmux/cmind_uj_ckcell/I1

###generate clk clk_psram_ahb_scan_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_psram_ahb_scan_scan -add \
                      -master_clock $name_clk_204_8m_cpll_cp_sys \
                      -source $hier_clk_204_8m_cpll_cp_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_clk_psram_ahb_scan_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cp_sys_clk_psram_ahb_scan_scan) ${CP_LIB_HIER}cp_sys_clk_psram_ahb_scan_scan   
set name_clk_psram_ahb_scan_scan cp_sys_clk_psram_ahb_scan_scan
set hier_clk_psram_ahb_scan_scan ${CP_SYS_CLK_CORE_HIER}u_clk_psram_ahb_scan_scanmux/cmind_uj_ckcell/I1

###generate clk clk_sysram_ahb_scan_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_sysram_ahb_scan_scan -add \
                      -master_clock $name_clk_245_76m_cpll_cp_sys \
                      -source $hier_clk_245_76m_cpll_cp_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CP_SYS_CLK_CORE_HIER}u_clk_sysram_ahb_scan_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cp_sys_clk_sysram_ahb_scan_scan) ${CP_LIB_HIER}cp_sys_clk_sysram_ahb_scan_scan   
set name_clk_sysram_ahb_scan_scan cp_sys_clk_sysram_ahb_scan_scan
set hier_clk_sysram_ahb_scan_scan ${CP_SYS_CLK_CORE_HIER}u_clk_sysram_ahb_scan_scanmux/cmind_uj_ckcell/I1

#---------------------------
# aux clk
#---------------------------
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_rf_aux_mux -add \
                       -master_clock $name_clk_adc_2x_ana_in\
                       -source $hier_clk_adc_2x_ana_in \
                       -divide_by 1 \
                       -combinational \
                       [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_aux_clk_mux4/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(cp_sys_clk_rf_aux_mux) ${CP_LIB_HIER}cp_sys_clk_rf_aux_mux
set name_clk_rf_aux_mux cp_sys_clk_rf_aux_mux
set hier_clk_rf_aux_mux ${CP_SYS_CLK_MANUAL_HIER}u_aux_clk_mux4/$CKOUTZ_HIER

if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_rf_aux -add \
                       -master_clock $name_clk_rf_aux_mux\
                       -source [get_pins $hier_clk_rf_aux_mux] \
                       -divide_by 4 \
                       [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_rf_clk_aux_div4/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(cp_sys_clk_rf_aux) ${CP_LIB_HIER}cp_sys_clk_rf_aux
set name_clk_rf_aux cp_sys_clk_rf_aux
set hier_clk_rf_aux ${CP_SYS_CLK_MANUAL_HIER}u_rf_clk_aux_div4/$CKOUTZ_HIER

#---------------------------
# dlink clk
#---------------------------

# ---------------
# SRC: mux0 dfe
# ---------------
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_dlink_src_mux_dfe -add \
                       -master_clock $name_clk_dfe\
                       -source [get_pins $hier_clk_dfe] \
                       -divide_by 1 \
                       -combinational \
                       [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_ckmux3_clk_dlink_dbg_src/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(clk_245m76_cp_src) ${CP_LIB_HIER}cp_sys_clk_dlink_src_mux_dfe   

lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_src_mux_dfe) ${CP_LIB_HIER}cp_sys_clk_dlink_src_mux_dfe
lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_src_mux_dfe) ${CP_LIB_HIER}cp_sys_clk_dfe
set name_clk_dlink_src_mux_dfe cp_sys_clk_dlink_src_mux_dfe
set hier_clk_dlink_src_mux_dfe ${CP_SYS_CLK_MANUAL_HIER}u_ckmux3_clk_dlink_dbg_src/$CKOUTZ_HIER

# ---------------
# SRC: mux1 adc 2x
# ---------------
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_dlink_src_mux_adc -add \
                       -master_clock $name_clk_adc_2x_ana_in\
                       -source $hier_clk_adc_2x_ana_in \
                       -divide_by 1 \
                       -combinational \
                       [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_ckmux3_clk_dlink_dbg_src/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(rftop_rxadc_clk245m)    ${CP_LIB_HIER}cp_sys_clk_dlink_src_mux_adc

lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_src_mux_adc) ${CP_LIB_HIER}cp_sys_clk_dlink_src_mux_adc
if {!$IS_CHIP} {
lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_src_mux_adc) ${CP_LIB_HIER}cp_sys_clk_adc_2x_ana_in
} else {
# TOP name
lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_src_mux_adc) rftop_rxadc_clk245m
}
set name_clk_dlink_src_mux_adc cp_sys_clk_dlink_src_mux_adc
set hier_clk_dlink_src_mux_adc ${CP_SYS_CLK_MANUAL_HIER}u_ckmux3_clk_dlink_dbg_src/$CKOUTZ_HIER

# ---------------
# SRC: mux2 modem
# ---------------
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_dlink_src_mux_modem -add \
                       -master_clock $name_clk_modem\
                       -source [get_pins $hier_clk_modem] \
                       -divide_by 1 \
                       -combinational \
                       [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_ckmux3_clk_dlink_dbg_src/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(clk_245m76_cp_src) ${CP_LIB_HIER}cp_sys_clk_dlink_src_mux_modem   

lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_src_mux_modem) ${CP_LIB_HIER}cp_sys_clk_dlink_src_mux_modem
lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_src_mux_modem) ${CP_LIB_HIER}cp_sys_clk_modem
set name_clk_dlink_src_mux_modem cp_sys_clk_dlink_src_mux_modem
set hier_clk_dlink_src_mux_modem ${CP_SYS_CLK_MANUAL_HIER}u_ckmux3_clk_dlink_dbg_src/$CKOUTZ_HIER

# exclusive group
set_clock_groups -physically_exclusive \
    -group $EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_src_mux_dfe) \
    -group $EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_src_mux_adc) \
    -group $EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_src_mux_modem)



# ---------------
# DST: mux0 cpll 102m4
# ---------------
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_dlink_dst_mux_102m4 -add \
                       -master_clock $name_clk_102_4m_cpll_cp_sys\
                       -source $hier_clk_102_4m_cpll_cp_sys \
                       -divide_by 1 \
                       -combinational \
                       [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_ckmux3_clk_dlink_dbg_dst/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(cp_sys_clk_102_4m_cpll_cp_sys)    ${CP_LIB_HIER}cp_sys_clk_dlink_dst_mux_102m4

lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_dst_mux_102m4) ${CP_LIB_HIER}cp_sys_clk_dlink_dst_mux_102m4
lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_dst_mux_102m4) $name_clk_102_4m_cpll_cp_sys
set name_clk_dlink_dst_mux_102m4 cp_sys_clk_dlink_dst_mux_102m4
set hier_clk_dlink_dst_mux_102m4 ${CP_SYS_CLK_MANUAL_HIER}u_ckmux3_clk_dlink_dbg_dst/$CKOUTZ_HIER

# ---------------
# DST: mux1 dac
# ---------------
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_dlink_dst_mux_dac -add \
                       -master_clock $name_clk_dac_ana_in\
                       -source $hier_clk_dac_ana_in \
                       -divide_by 1 \
                       -combinational \
                       [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_ckmux3_clk_dlink_dbg_dst/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(cp_sys_clk_dac)    ${CP_LIB_HIER}cp_sys_clk_dlink_dst_mux_dac

lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_dst_mux_dac) ${CP_LIB_HIER}cp_sys_clk_dlink_dst_mux_dac

if {!$IS_CHIP} {
lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_dst_mux_dac) ${CP_LIB_HIER}cp_sys_clk_dac_ana_in
} else {
# TOP name
lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_dst_mux_dac) clk_dig_122p88m_rftop
}
set name_clk_dlink_dst_mux_dac cp_sys_clk_dlink_dst_mux_dac
set hier_clk_dlink_dst_mux_dac ${CP_SYS_CLK_MANUAL_HIER}u_ckmux3_clk_dlink_dbg_dst/$CKOUTZ_HIER

# ---------------
# DST: mux2 modem
# ---------------
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cp_sys_clk_dlink_dst_mux_modem -add \
                       -master_clock $name_clk_modem\
                       -source [get_pins $hier_clk_modem] \
                       -divide_by 1 \
                       -combinational \
                       [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_ckmux3_clk_dlink_dbg_dst/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(clk_245m76_cp_src) ${CP_LIB_HIER}cp_sys_clk_dlink_dst_mux_modem   

lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_dst_mux_modem) ${CP_LIB_HIER}cp_sys_clk_dlink_dst_mux_modem
lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_dst_mux_modem) ${CP_LIB_HIER}cp_sys_clk_modem
set name_clk_dlink_dst_mux_modem cp_sys_clk_dlink_dst_mux_modem
set hier_clk_dlink_dst_mux_modem ${CP_SYS_CLK_MANUAL_HIER}u_ckmux3_clk_dlink_dbg_dst/$CKOUTZ_HIER

# ------------------------------
# hsdl
# ------------------------------
if {!$IS_CHIP} {
create_generated_clock -name cp_sys_clk_hsdl  -add \
                       -master_clock $name_clk_dlink_dst_mux_102m4 \
                       -source [get_pins $hier_clk_dlink_dst_mux_102m4] \
                       -divide_by 1 \
                       -combinational \
                       [get_ports hsdl_clk]
} elseif {$IS_CHIP && !$IS_FLAT} {
lappend CLOCK_GROUP(cp_sys_clk_102_4m_cpll_cp_sys) ${CP_LIB_HIER}hsdl_clk
create_generated_clock -name cp_sys_clk_hsdl  -add \
                       -master_clock ${CP_LIB_HIER}hsdl_clk \
                       -source ${CP_LIB_HIER}hsdl_clk \
                       -divide_by 1 \
                       -combinational \
                       [get_ports $func_pad_names(hsdl_clk)]
} elseif {$IS_CHIP && $IS_FLAT} {
create_generated_clock -name cp_sys_clk_hsdl -add \
                       -master_clock $name_clk_dlink_dst_mux_102m4 \
                       -source [get_pins $hier_clk_dlink_dst_mux_102m4] \
                       -divide_by 1 \
                       -combinational \
                       [get_ports $func_pad_names(hsdl_clk)]
}
lappend CLOCK_GROUP(cp_sys_clk_102_4m_cpll_cp_sys) cp_sys_clk_hsdl    
lappend EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_dst_mux_102m4) cp_sys_clk_hsdl    

# exclusive group
set_clock_groups -physically_exclusive \
    -group $EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_dst_mux_102m4) \
    -group $EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_dst_mux_dac) \
    -group $EXCLUSIVE_CLOCK_GROUP(cp_sys_clk_dlink_dst_mux_modem)


