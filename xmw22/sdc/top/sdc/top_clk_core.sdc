if {! $IS_CHIP} {
    create_clock -name vclk -period $CYCLE_26M
    lappend CLOCK_GROUP(vclk) vclk
    set name_clk_32k_top clk_32k_top
    set hier_clk_32k_top [get_ports clk_32k_top]
    create_clock -name $name_clk_32k_top -period $CYCLE_32K -add $hier_clk_32k_top
    lappend CLOCK_GROUP(clk_32k_top) $name_clk_32k_top
    set name_clk_26m_top clk_26m_top
    set hier_clk_26m_top [get_ports clk_26m_top]
    create_clock -name $name_clk_26m_top -period $CYCLE_26M -add $hier_clk_26m_top
    lappend CLOCK_GROUP(clk_26m_top) $name_clk_26m_top
    set name_clk_51_2m_top clk_51_2m_top
    set hier_clk_51_2m_top [get_ports clk_51_2m_top]
    create_clock -name $name_clk_51_2m_top -period $CYCLE_51M2 -add $hier_clk_51_2m_top
    lappend CLOCK_GROUP(clk_51_2m_top) $name_clk_51_2m_top
    set name_clk_76_8m_top clk_76_8m_top
    set hier_clk_76_8m_top [get_ports clk_76_8m_top]
    create_clock -name $name_clk_76_8m_top -period $CYCLE_76M8 -add $hier_clk_76_8m_top
    lappend CLOCK_GROUP(clk_76_8m_top) $name_clk_76_8m_top
    set name_clk_102_4m_top clk_102_4m_top
    set hier_clk_102_4m_top [get_ports clk_102_4m_top]
    create_clock -name $name_clk_102_4m_top -period $CYCLE_102M4 -add $hier_clk_102_4m_top
    lappend CLOCK_GROUP(clk_102_4m_top) $name_clk_102_4m_top
    set name_clk_153_6m_top clk_153_6m_top
    set hier_clk_153_6m_top [get_ports clk_153_6m_top]
    create_clock -name $name_clk_153_6m_top -period $CYCLE_153M6 -add $hier_clk_153_6m_top
    lappend CLOCK_GROUP(clk_153_6m_top) $name_clk_153_6m_top
    set name_clk_204_8m_top clk_204_8m_top
    set hier_clk_204_8m_top [get_ports clk_204_8m_top]
    create_clock -name $name_clk_204_8m_top -period $CYCLE_204M8 -add $hier_clk_204_8m_top
    lappend CLOCK_GROUP(clk_204_8m_top) $name_clk_204_8m_top
    set name_clk_245_76m_top clk_245_76m_top
    set hier_clk_245_76m_top [get_ports clk_245_76m_top]
    create_clock -name $name_clk_245_76m_top -period $CYCLE_245M76 -add $hier_clk_245_76m_top
    lappend CLOCK_GROUP(clk_245_76m_top) $name_clk_245_76m_top
    set name_clk_15k_top clk_15k_top
    set hier_clk_15k_top [get_ports clk_15k_top]
    create_clock -name $name_clk_15k_top -period $CYCLE_15K -add $hier_clk_15k_top
    lappend CLOCK_GROUP(clk_15k_top) $name_clk_15k_top
    set name_ptest_slow_occ_clock ptest_slow_occ_clock
    set hier_ptest_slow_occ_clock [get_ports ptest_slow_occ_clock]
    create_clock -name $name_ptest_slow_occ_clock -period $CYCLE_26M -add $hier_ptest_slow_occ_clock
    lappend CLOCK_GROUP(ptest_slow_occ_clock) $name_ptest_slow_occ_clock
    set name_clk_61_44m_top clk_61_44m_top
    set hier_clk_61_44m_top [get_ports clk_61_44m_top]
    create_clock -name $name_clk_61_44m_top -period $CYCLE_61M44 -add $hier_clk_61_44m_top
    lappend CLOCK_GROUP(clk_61_44m_top) $name_clk_61_44m_top
    set name_clk_26m_efuse clk_26m_efuse
    set hier_clk_26m_efuse [get_ports clk_26m_efuse]
    create_clock -name $name_clk_26m_efuse -period $CYCLE_26M -add $hier_clk_26m_efuse
    lappend CLOCK_GROUP(clk_26m_efuse) $name_clk_26m_efuse
    set name_clk_rtc32k_top clk_rtc32k_top
    set hier_clk_rtc32k_top [get_ports clk_rtc32k_top]
    create_clock -name $name_clk_rtc32k_top -period $CYCLE_26M -add $hier_clk_rtc32k_top
    lappend CLOCK_GROUP(clk_rtc32k_top) $name_clk_rtc32k_top
    set name_clk_ana_auxadc clk_ana_auxadc
    set hier_clk_ana_auxadc [get_ports clk_ana_auxadc]
    create_clock -name $name_clk_ana_auxadc -period $CYCLE_26M -add $hier_clk_ana_auxadc
    lappend CLOCK_GROUP(clk_ana_auxadc) $name_clk_ana_auxadc
    set name_clk_aon_top_pmu clk_aon_top_pmu
    set hier_clk_aon_top_pmu [get_ports clk_aon_top_pmu]
    create_clock -name $name_clk_aon_top_pmu -period $CYCLE_26M -add $hier_clk_aon_top_pmu
    lappend CLOCK_GROUP(clk_aon_top_pmu) $name_clk_aon_top_pmu
    set name_rftop_cpll_ds_26m_clk rftop_cpll_ds_26m_clk
    set hier_rftop_cpll_ds_26m_clk [get_ports rftop_cpll_ds_26m_clk]
    create_clock -name $name_rftop_cpll_ds_26m_clk -period $CYCLE_26M -add $hier_rftop_cpll_ds_26m_clk
    lappend CLOCK_GROUP(rftop_cpll_ds_26m_clk) $name_rftop_cpll_ds_26m_clk
    set name_anlg_rc32k_clk anlg_rc32k_clk
    set hier_anlg_rc32k_clk [get_ports anlg_rc32k_clk]
    create_clock -name $name_anlg_rc32k_clk -period $CYCLE_26M -add $hier_anlg_rc32k_clk
    lappend CLOCK_GROUP(anlg_rc32k_clk) $name_anlg_rc32k_clk
    set name_clk_26m clk_26m
    set hier_clk_26m [get_ports clk_26m]
    create_clock -name $name_clk_26m -period $CYCLE_26M -add $hier_clk_26m
    lappend CLOCK_GROUP(clk_26m) $name_clk_26m
    set name_clk_cali_32k_src clk_cali_32k_src
    set hier_clk_cali_32k_src [get_ports clk_cali_32k_src]
    create_clock -name $name_clk_cali_32k_src -period $CYCLE_26M -add $hier_clk_cali_32k_src
    lappend CLOCK_GROUP(clk_cali_32k_src) $name_clk_cali_32k_src
    set name_clk_cali_26m_src clk_cali_26m_src
    set hier_clk_cali_26m_src [get_ports clk_cali_26m_src]
    create_clock -name $name_clk_cali_26m_src -period $CYCLE_26M -add $hier_clk_cali_26m_src
    lappend CLOCK_GROUP(clk_cali_26m_src) $name_clk_cali_26m_src
}
#----------------------------------------------------------------------------
#clk_top_mtx
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_mtx \
        -master_clock $name_clk_102_4m_top \
        -source $hier_clk_102_4m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_mtx_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_clk_top_mtx) top_clk_top_mtx
#----------------------------------------------------------------------------
#clk_sysram
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_sysram \
        -master_clock $name_clk_245_76m_top \
        -source $hier_clk_245_76m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_sysram_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_clk_sysram) top_clk_sysram
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
    create_generated_clock  \
        -name top_clk_top_glb_wdg0_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_glb_wdg0_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_glb_wdg0_scan) top_clk_top_glb_wdg0_scan
#----------------------------------------------------------------------------
#clk_top_cpu_wdg1
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_cpu_wdg1 \
        -master_clock $name_clk_26m_top \
        -source $hier_clk_26m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_cpu_wdg1_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_top_cpu_wdg1) top_clk_top_cpu_wdg1
    create_generated_clock  \
        -name top_clk_top_cpu_wdg1_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_cpu_wdg1_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_cpu_wdg1_scan) top_clk_top_cpu_wdg1_scan
#----------------------------------------------------------------------------
#clk_top_cp_wdg2
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_cp_wdg2 \
        -master_clock $name_clk_26m_top \
        -source $hier_clk_26m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_cp_wdg2_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_top_cp_wdg2) top_clk_top_cp_wdg2
    create_generated_clock  \
        -name top_clk_top_cp_wdg2_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_cp_wdg2_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_cp_wdg2_scan) top_clk_top_cp_wdg2_scan
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
    create_generated_clock  \
        -name top_clk_top_ttmr0_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_ttmr0_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_ttmr0_scan) top_clk_top_ttmr0_scan
#----------------------------------------------------------------------------
#clk_top_ttmr1
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_ttmr1 \
        -master_clock $name_clk_26m_top \
        -source $hier_clk_26m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_ttmr1_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_top_ttmr1) top_clk_top_ttmr1
    create_generated_clock  \
        -name top_clk_top_ttmr1_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_ttmr1_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_ttmr1_scan) top_clk_top_ttmr1_scan
#----------------------------------------------------------------------------
#clk_top_io_rf0
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_io_rf0 \
        -master_clock $name_clk_26m_top \
        -source $hier_clk_26m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_io_rf0_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_top_io_rf0) top_clk_top_io_rf0
    create_generated_clock  \
        -name top_clk_top_io_rf0_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_io_rf0_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_io_rf0_scan) top_clk_top_io_rf0_scan
#----------------------------------------------------------------------------
#clk_top_anlg_rf0
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_anlg_rf0 \
        -master_clock $name_clk_26m_top \
        -source $hier_clk_26m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_anlg_rf0_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_top_anlg_rf0) top_clk_top_anlg_rf0
    create_generated_clock  \
        -name top_clk_top_anlg_rf0_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_anlg_rf0_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_anlg_rf0_scan) top_clk_top_anlg_rf0_scan
#----------------------------------------------------------------------------
#clk_top_uart0
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_uart0 \
        -master_clock $name_clk_51_2m_top \
        -source $hier_clk_51_2m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_uart0_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_clk_top_uart0) top_clk_top_uart0
#----------------------------------------------------------------------------
#clk_top_uart2
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_uart2 \
        -master_clock $name_clk_51_2m_top \
        -source $hier_clk_51_2m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_uart2_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_clk_top_uart2) top_clk_top_uart2
#----------------------------------------------------------------------------
#clk_top_uart3
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_uart3 \
        -master_clock $name_clk_51_2m_top \
        -source $hier_clk_51_2m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_uart3_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_clk_top_uart3) top_clk_top_uart3
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
    create_generated_clock  \
        -name top_clk_top_kpd_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_kpd_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_kpd_scan) top_clk_top_kpd_scan
#----------------------------------------------------------------------------
#clk_top_i2c0
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_i2c0 \
        -master_clock $name_clk_61_44m_top \
        -source $hier_clk_61_44m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_i2c0_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_clk_top_i2c0) top_clk_top_i2c0
#----------------------------------------------------------------------------
#clk_top_pwm0
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_pwm0 \
        -master_clock $name_clk_26m_top \
        -source $hier_clk_26m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_pwm0_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_top_pwm0) top_clk_top_pwm0
    create_generated_clock  \
        -name top_clk_top_pwm0_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_pwm0_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_pwm0_scan) top_clk_top_pwm0_scan
#----------------------------------------------------------------------------
#clk_top_pwm1
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_pwm1 \
        -master_clock $name_clk_26m_top \
        -source $hier_clk_26m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_pwm1_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_top_pwm1) top_clk_top_pwm1
    create_generated_clock  \
        -name top_clk_top_pwm1_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_pwm1_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_pwm1_scan) top_clk_top_pwm1_scan
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
    create_generated_clock  \
        -name top_clk_top_eic0_32k_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_eic0_32k_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_eic0_32k_scan) top_clk_top_eic0_32k_scan
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
    create_generated_clock  \
        -name top_clk_top_eic1_32k_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_eic1_32k_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_eic1_32k_scan) top_clk_top_eic1_32k_scan
#----------------------------------------------------------------------------
#clk_top_efuse_ctrl
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_top_efuse_ctrl_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_top_efuse_ctrl_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_top_efuse_ctrl_scan) top_clk_top_efuse_ctrl_scan
#----------------------------------------------------------------------------
#clk_ana_auxadc_26m
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_ana_auxadc_26m \
        -master_clock $name_clk_26m_top \
        -source $hier_clk_26m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_ana_auxadc_26m_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_ana_auxadc_26m) top_clk_ana_auxadc_26m
    create_generated_clock  \
        -name top_clk_ana_auxadc_26m_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_ana_auxadc_26m_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_ana_auxadc_26m_scan) top_clk_ana_auxadc_26m_scan
#----------------------------------------------------------------------------
#clk_ana_bk_pa_26m
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_ana_bk_pa_26m \
        -master_clock $name_clk_26m_top \
        -source $hier_clk_26m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_ana_bk_pa_26m_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_ana_bk_pa_26m) top_clk_ana_bk_pa_26m
    create_generated_clock  \
        -name top_clk_ana_bk_pa_26m_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_ana_bk_pa_26m_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_ana_bk_pa_26m_scan) top_clk_ana_bk_pa_26m_scan
#----------------------------------------------------------------------------
#clk_ana_bk_gen_26m
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_ana_bk_gen_26m \
        -master_clock $name_clk_26m_top \
        -source $hier_clk_26m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_ana_bk_gen_26m_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_ana_bk_gen_26m) top_clk_ana_bk_gen_26m
    create_generated_clock  \
        -name top_clk_ana_bk_gen_26m_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_ana_bk_gen_26m_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_ana_bk_gen_26m_scan) top_clk_ana_bk_gen_26m_scan
#----------------------------------------------------------------------------
#clk_ana_bk_core_26m
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_ana_bk_core_26m \
        -master_clock $name_clk_26m_top \
        -source $hier_clk_26m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_ana_bk_core_26m_scan/cmind_uj_ckcell/I0
    lappend CLOCK_GROUP(top_clk_ana_bk_core_26m) top_clk_ana_bk_core_26m
    create_generated_clock  \
        -name top_clk_ana_bk_core_26m_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_ana_bk_core_26m_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_ana_bk_core_26m_scan) top_clk_ana_bk_core_26m_scan
#----------------------------------------------------------------------------
#clk_top_intc0
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_top_intc1
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_top_intc2
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_top_kpd_apb
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_top_eic0
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_top_eic1
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_ana_auxadc_mtx
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_top_gpio_ctrl
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_top_uart0_apb
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_top_uart2_apb
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_top_uart3_apb
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_top_mtx_wdg0_asbm_rst
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_top_mtx_ttmr0_asbm_rst
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_rtc32k_top_scan
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_rtc32k_top_scan_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_rtc32k_top_scan_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_rtc32k_top_scan_scan) top_clk_rtc32k_top_scan_scan
#----------------------------------------------------------------------------
#clk_ana_auxadc_scan
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_ana_auxadc_scan_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_ana_auxadc_scan_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_ana_auxadc_scan_scan) top_clk_ana_auxadc_scan_scan
#----------------------------------------------------------------------------
#clk_aon_top_pmu_scan
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_aon_top_pmu_scan_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_aon_top_pmu_scan_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_aon_top_pmu_scan_scan) top_clk_aon_top_pmu_scan_scan
#----------------------------------------------------------------------------
#rftop_cpll_ds_26m_clk_scan
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_rftop_cpll_ds_26m_clk_scan_scan \
        -master_clock $name_clk_76_8m_top \
        -source $hier_clk_76_8m_top \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_rftop_cpll_ds_26m_clk_scan_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_rftop_cpll_ds_26m_clk_scan_scan) top_rftop_cpll_ds_26m_clk_scan_scan
#----------------------------------------------------------------------------
#clk_cmash_rft
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
#clk_rc32k_pmu
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_rc32k_pmu_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_rc32k_pmu_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_rc32k_pmu_scan) top_clk_rc32k_pmu_scan
#----------------------------------------------------------------------------
#clk_26m_pmu
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_26m_pmu_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_26m_pmu_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_26m_pmu_scan) top_clk_26m_pmu_scan
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
    create_generated_clock  \
        -name top_clk_32k_ocp_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_32k_ocp_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_32k_ocp_scan) top_clk_32k_ocp_scan
#----------------------------------------------------------------------------
#clk_32k_cali
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_32k_cali_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_32k_cali_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_32k_cali_scan) top_clk_32k_cali_scan
#----------------------------------------------------------------------------
#clk_xo26m_cali
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_clk_xo26m_cali_scan \
        -master_clock $name_ptest_slow_occ_clock \
        -source $hier_ptest_slow_occ_clock \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_CLK_CORE_HIER}/u_clk_xo26m_cali_scan/cmind_uj_ckcell/I1
    lappend CLOCK_GROUP(top_clk_xo26m_cali_scan) top_clk_xo26m_cali_scan
