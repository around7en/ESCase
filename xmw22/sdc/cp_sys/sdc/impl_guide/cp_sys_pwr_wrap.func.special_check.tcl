set hsdl_output_skew_list [list \
hsdl_output_skew 1.5  u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_dlink_dbg/u_dlink_hsdl/u_hsdl_core/dout_reg_3_0_/CP           $func_pad_names(hsdl_d0)       None None \
hsdl_output_skew 1.5  u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_dlink_dbg/u_dlink_hsdl/u_hsdl_core/dout_reg_3_0_/CP           $func_pad_names(hsdl_d1)       None None \
hsdl_output_skew 1.5  u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_dlink_dbg/u_dlink_hsdl/u_hsdl_core/dout_reg_3_0_/CP           $func_pad_names(hsdl_d2)       None None \
hsdl_output_skew 1.5  u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_dlink_dbg/u_dlink_hsdl/u_hsdl_core/dout_reg_3_0_/CP           $func_pad_names(hsdl_d3)       None None \
hsdl_output_skew 1.5  u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_dlink_dbg/u_dlink_hsdl/u_hsdl_core/dout_reg_7_4_/CP           $func_pad_names(hsdl_d4)       None None \
hsdl_output_skew 1.5  u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_dlink_dbg/u_dlink_hsdl/u_hsdl_core/dout_reg_7_4_/CP           $func_pad_names(hsdl_d5)       None None \
hsdl_output_skew 1.5  u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_dlink_dbg/u_dlink_hsdl/u_hsdl_core/dout_reg_7_4_/CP           $func_pad_names(hsdl_d6)       None None \
hsdl_output_skew 1.5  u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_dlink_dbg/u_dlink_hsdl/u_hsdl_core/dout_reg_7_4_/CP           $func_pad_names(hsdl_d7)       None None \
hsdl_output_skew 1.5  u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_dlink_dbg/u_dlink_hsdl/u_hsdl_core/dout_vld_reg/CP            $func_pad_names(hsdl_valid)    None None \
]
tproc_stc_skew_report $hsdl_output_skew_list
tproc_stc_array2csv   $hsdl_output_skew_list stc_check_skew.csv


set rxadc_list [list \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_i[0]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_i[1]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_i[2]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_i[3]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_i[4]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_i[5]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_i[6]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_i[7]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_q[0]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_q[1]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_q[2]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_q[3]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_q[4]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_q[5]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_q[6]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch1_q[7]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_i[0]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_i[1]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_i[2]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_i[3]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_i[4]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_i[5]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_i[6]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_i[7]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_q[0]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_q[1]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_q[2]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_q[3]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_q[4]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_q[5]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_q[6]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_cal_dac_ctr_ch3_q[7]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_i[0]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_i[1]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_i[2]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_i[3]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_i[4]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_i[5]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_i[6]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_i[7]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_q[0]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_q[1]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_q[2]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_q[3]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_q[4]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_q[5]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_q[6]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch1_q[7]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_i[0]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_i[1]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_i[2]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_i[3]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_i[4]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_i[5]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_i[6]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_i[7]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_q[0]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_q[1]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_q[2]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_q[3]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_q[4]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_q[5]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_q[6]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_caln_ch3_q[7]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_i[0]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_i[1]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_i[2]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_i[3]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_i[4]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_i[5]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_i[6]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_i[7]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_q[0]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_q[1]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_q[2]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_q[3]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_q[4]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_q[5]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_q[6]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch1_q[7]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_i[0]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_i[1]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_i[2]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_i[3]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_i[4]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_i[5]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_i[6]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_i[7]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_q[0]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_q[1]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_q[2]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_q[3]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_q[4]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_q[5]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_q[6]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_calp_ch3_q[7]  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_en_ch1_i  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_en_ch1_q  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/i_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_en_ch3_i  None None \
rxadc 4 u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_ip_adc_top/q_saradc_cal_ecl/u_saradc_cal_top/cal_state_reg_1_/CP  u_rftop/rxadc_en_ch3_q  None None \
]

tproc_stc_skew_report $rxadc_list
tproc_stc_array2csv   $rxadc_list stc_check_skew.csv



