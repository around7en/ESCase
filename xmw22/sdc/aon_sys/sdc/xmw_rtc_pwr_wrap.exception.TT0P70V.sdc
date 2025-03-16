#for hold vio fix
if {$IS_FLAT} {
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_key_manage/u_detect_rstkey/rst_key_det_vld1_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/int_power_off_out_raw_reg/CP] -to [get_pins u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_aonsys_total/s_prdata_reg_reg_*_/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_rtc_pmu_glb_reg/rstkey_deassert_int_en_reg/CP] -to [get_pins u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_aonsys_total/s_prdata_reg_reg_4_/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_rtc_pmu_glb_reg/rstkey_dbnc_int_clr_reg/CP] -to [get_pins u_digital_top/u_aon_sys_pwr_wrap/u_aon_sys_top/u_rstkey_ctrl/u_aon_rstkey_dbnc/int_key_*_dbnc_raw_reg/D]
}
