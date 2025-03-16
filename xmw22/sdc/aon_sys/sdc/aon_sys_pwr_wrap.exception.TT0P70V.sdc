#for hold vio fix
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_int_pol_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/cur_state_reg_*_/D]

    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_int_pol_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/int_eic_dbnc_raw_reg/D]

    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_cnt_sel_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/eic_dbnc_data_reg/D]

    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_cnt_sel_reg_reg_*_/CP] -to  [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE*eic_dbnc*u_eic_dbnc/*dbnc_cnt_reg_*_/D]

    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_cnt_sel_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/cur_state_reg_*_/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_cnt_sel_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/int_eic_dbnc_raw_reg/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_int_pol_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/genblk1_dbnc_cnt_reg_*_/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_int_pol_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/clk_gate_genblk1_dbnc_cnt_reg_0/latch/E]

    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_int_en_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/eic_dbnc_start_reg/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_trig_start_reg_reg_0_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_0__eic_dbnc_u_eic_dbnc/dbnc_trig_s_reg/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_int_clr_reg_reg_0_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_0__eic_dbnc_u_eic_dbnc/dbnc_int_clr_s_reg/D]

    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_cnt_sel_reg_reg_*_/CP]

    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_glb_reg/intc_en_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_intc_top/u_intc_rf/int_irq_soft_reg/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_glb_reg/intc_en_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_intc_top/u_intc_rf/int_irq_enable_reg_*_/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_glb_reg/eic_en_reg/CP]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_frc_reg/cali_gpt_int_clr_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_frc_cali_gpt/int_frc_cali_raw_reg/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_frc_reg/cali_gpt_en_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_frc_cali_gpt/gpt_thr_mask_reg/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_frc_reg/cali_gpt_op0_hi_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_frc_cali_gpt/gpt_cur_thr_reg_38_/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_frc_reg/ratio_frac_step_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_apb2apb_async_frc/s_prdata_reg_reg_*_/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_frc_reg/phy_gpt_time_a_hi_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_frc_phy_gpt/cnt_match_reg/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_aon_pmu_glb_reg/intclr_top_sd_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_aon_pmu_glb_reg/intclr_top_sd_reg/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_rtc/i_regmap/mask_month_reg/CP]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/frc_inte_curval_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_apb2apb_async_frc/s_prdata_reg_reg_*_/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*eic_dbnc*u_eic_dbnc/u_eic_eb_sync/cmind_sync_buf2*bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_0__eic_dbnc_u_eic_dbnc/cur_state_reg_*_/D]

if {$IS_FLAT} {
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_rtc_pmu_glb_reg/rstkey_dbnc_start_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_rstkey_ctrl/u_aon_rstkey_dbnc/cur_state_reg_*_/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_rtc_pmu_glb_reg/rstkey_dbnc_int_clr_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_rstkey_ctrl/u_aon_rstkey_dbnc/int_key_*_dbnc_raw_reg/D]
}
