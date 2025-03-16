if {!$IS_CHIP} {
    set_false_path -through [get_ports ${AON_SYS_HIER}rst_aon_por_n]
} else {
    set_false_path -through [get_pins ${AON_SYS_HIER}rst_aon_por_n]
}
#set_disable_clock_gating_check ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_top_els_nsleep/cmind_uj_cell
#set_disable_clock_gating_check ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_mux2_ptest_pwr_rdy_els_nsleep/cmind_uj_cell
set_disable_clock_gating_check ${AON_SYS_HIER}u_aon_sys_els_wrap/TOP2AON_ELS_ISO0*73*u_LVLHLCLOSGD4BWP7T40P140HVT
set_disable_clock_gating_check ${AON_SYS_HIER}u_aon_sys_els_wrap/TOP2AON_ELS_ISO0*74*u_LVLHLCLOSGD4BWP7T40P140HVT
set_disable_clock_gating_check ${AON_SYS_HIER}u_aon_sys_els_wrap/TOP2AON_ELS_ISO0*75*u_LVLHLCLOSGD4BWP7T40P140HVT

#set_false_path -from [get_clocks ${AON_SYS_NAME}_clk_rstkey_dbnc] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_glb_reg/prdata_reg_*/D]


#set_false_path -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_clk_frc_switch/clk_32k_sync_0_reg/D]

set_false_path -through [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_aon_io_deep_sleep/cmind_uj_cell/Z]

set_false_path -through [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_top_els_nsleep/cmind_uj_cell/Z]

set_sense -stop_propagation [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_sys_dbgbus/*u_cmind_cell_buf/cmind_uj_cell/I]
set_sense -stop_propagation [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_clk_frc_switch/clk_32k_sync_0_reg/D]

#for hold vio fix
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_int_pol_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/cur_state_reg_*_/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_int_pol_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/int_eic_dbnc_raw_reg/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_int_pol_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/genblk1_dbnc_cnt_reg_*_/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_int_pol_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/clk_gate_genblk1_dbnc_cnt_reg_*/latch/E]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_int_pol_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/eic_dbnc_data_reg/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_int_en_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/eic_dbnc_start_reg/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/dbnc_trig_s_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/u_trig_s_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/dbnc_int_clr_s_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/u_int_clr_s_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/u_trig_s_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/u_trig_cap_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/u_int_clr_s_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/u_int_clr_cap_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/u_eic_rf/eic_dbnc_reg_dbnc_en_reg_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/u_eic_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_io_top/u_io_group_aon_reg/AONINT*_sel_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/u_eic_in_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_io_top/u_io_group_aon_reg/AONINT*_dslp_IE_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/u_eic_in_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_aon_pmu_glb_reg/aon_io_deep_sleep_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_aon_io_deep_sleep_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_rtc/i_regmap/event_*_map_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_alarm_irq_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/aon_deep_sleep_req_pre_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_aon_dslp_req_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_rtc/i_regmap/mask_*_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_alarm_irq_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_io_top/u_io_group_aon_reg/AONINT1_dslp_en_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE_1__eic_dbnc_u_eic_dbnc/u_eic_in_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_aon_ocp_wrap/u_*_mon/ocp_alarm_int_trig_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_aon_ocp_wrap/u_ocp_alarm_int_trig_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_aon_ocp_wrap/u_bk_core_scp_mon/mon_finish_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_aon_ocp_wrap/u_bk_core_ocp_out_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]

if {$IS_FLAT} {
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/int_power_off_out_raw_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_dslp_clr_cond_a_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_turn_on_off_ctrl/u_turn_on_ctrl/fastoff_mask_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_dslp_clr_cond_a_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_rtc_pmu_glb_reg/rstkey_op_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_rstkey_toppwrctrl_rst_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_rtc_pmu_glb_reg/rstkey_op_reg_*_/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_rst_top_por_n_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_turn_on_off_ctrl/u_turn_off_mon/frc_turnoff_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_force_turnoff_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_turn_on_off_ctrl/u_turn_on_ctrl/rstkey_turnon_mask_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_rstkey_ctrl/u_aon_rstkey_dbnc/u_key_in_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_key_manage/u_key_priority/rc32k_cali_trig_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_rc32k_cali_trig_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_key_manage/u_key_priority/cali_intc_mask_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_dslp_clr_cond_a_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_key_manage/u_detect_rstkey/rst_key_det_n_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_rstkey_toppwrctrl_rst_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_key_manage/u_detect_rstkey/rst_key_det_n_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_rst_top_por_n_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_key_manage/u_key_priority/rc32k_cali_trig_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_dslp_clr_cond_a_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_turn_on_off_ctrl/u_turn_off_ctrl/turnoff_mask_reg_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_rstkey_ctrl/u_aon_rstkey_dbnc/u_key_in_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_turn_on_off_ctrl/u_turn_off_ctrl/turnoff_mask_reg_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_dslp_clr_cond_a_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_turn_on_off_ctrl/u_turn_off_ctrl/int_pwr_dn_req_raw_reg/CP] -to [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_dslp_clr_cond_a_sync/*sig_in_sync0_reg/cmind_uj_cell/D]
}
