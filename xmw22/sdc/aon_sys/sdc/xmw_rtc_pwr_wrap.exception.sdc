set_disable_clock_gating_check ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/aon_iso_en_reg
#set_disable_clock_gating_check ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_top_els_nsleep/cmind_uj_cell
#set_sense -stop_propagation ${RTC_SYS_HIER}top_iso_en
set_false_path -through [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_top_els_nsleep/cmind_uj_cell/ZN]
#set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_xmw_rtc_glue/u_rtc_vtrim0p8_wen_wide/cmind_uj_cell/CP]
#for hold vio fix
if {$IS_FLAT} {
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_key_manage/u_key_priority/rc32k_cali_trig_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_en_start_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_turn_on_off_ctrl/u_turn_off_mon/frc_turnoff_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_force_turnoff_top_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_key_manage/u_key_priority/cali_intc_mask_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_*_sys_pmu/u_dslp_clr_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_key_manage/u_detect_rstkey/rst_key_det_n_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/u_dbg_sys_rst_ctrl/u_sig_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_rtc_pmu_glb_reg/rstkey_deassert_int_en_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_dslp_clr_cond_a_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_turn_on_off_ctrl/u_turn_off_ctrl/turnoff_mask_reg_reg/CP] -to [get_pins u_digital_top/u_*_pmu/u_*_sys_pmu/u_dslp_clr_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_turn_on_off_ctrl/u_turn_off_ctrl/int_pwr_dn_req_raw_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_rstkey_ctrl/u_aon_rstkey_dbnc/u_key_in_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
}
