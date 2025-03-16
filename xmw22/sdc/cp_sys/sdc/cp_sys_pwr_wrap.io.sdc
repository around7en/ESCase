if {! $IS_CHIP} {

# -----------------------
# dbg ports
# -----------------------
set dbg_ports [ list \
dbgbus_cpsys_chain_sel i  0.7 \
dbgbus_cpsys_data      o 0.7 \
adc_ecl_dn_dbg_rst     i  0.7 \
cp2psram_dbg_rst       i  0.7 \
cp2sysram_dbg_rst      i  0.7 \
top2cp_dbg_rst         i  0.2 \
cp_mtx_dbg_rst         i  0.7 \
cpsys_glb_dbg_rst      i  0.7 \
rft_dbg_rst            i  0.7 \
cp_sys_dbg_ready       i  0.7 \
]
foreach {port_name direction percent} $dbg_ports {
    if { $direction == "i"} {
        set_input_delay  [expr $CYCLE_26M*${percent}] -clock ${CP_SYS_NAME}_V_CLK_26M [get_ports ${port_name}]
    } else {
        set_output_delay [expr $CYCLE_26M*${percent}] -clock ${CP_SYS_NAME}_V_CLK_26M [get_ports ${port_name}]
    }
}

# -----------------------
# scan ports
# -----------------------
set scan_ports [ list\
    ptest_icg_mode       i 0.7 \
    ptest_mbist_mode     i 0.7 \
    ptest_scan_mode      i 0.7 \
    ptest_dc_mode        i 0.7 \
    ptest_ac_mode        i 0.7 \
    ptest_ijtag_ce       i 0.7 \
    ptest_ijtag_reset    i 0.7 \
    ptest_ijtag_se       i 0.7 \
    ptest_ijtag_sel      i 0.7 \
    ptest_ijtag_si       i 0.7 \
    ptest_ijtag_so       o 0.7 \
    ptest_ijtag_tck      i 0.7 \
    ptest_ijtag_ue       i 0.7 \
    ptest_mem_bypass_en  i 0.7 \
    ptest_scan_en        i 0.7 \
    ptest_scan_rst_n     i 0.7 \
    ptest_ltest_en       i 0.7 \
    ptest_edt_update     i 0.7 \
    ptest_tck_occ_en     i 0.7 \
    ptest_scan_clock     i 0.7 \
    ptest_edt_clock      i 0.7 \
    ptest_edt_ch_in      i 0.7 \
    ptest_edt_ch_out     o 0.7 \
    ptest_slow_occ_clock i 0.7 \
    ]
# move to mbist sdc
#foreach {port_name direction percent} $scan_ports {
#    if {$direction == "i"} {
#        set_input_delay  [expr $CYCLE_26M*${percent}] -clock ${CP_SYS_NAME}_V_CLK_26M [get_ports  ${port_name}]
#    } else {
#        set_output_delay [expr $CYCLE_26M*${percent}] -clock ${CP_SYS_NAME}_V_CLK_26M [get_ports  ${port_name}]
#    }
#}

# -----------------------
# lp ports
# -----------------------
set lp_ports [ list\
        cp_sys_root_clk_en               i 0.2 \
        cp_shutdown_n                    i 0.3 \
        rst_cp_por_n                     i 0.7 \
        cp_deep_sleep_req                o 0.7 \
        cp_shutdown_ack_n                o 0.3 \
        cgm_busy_clk_dac                 o 0.7 \
        cgm_busy_clk_adc_1x_i            o 0.7 \
        cgm_busy_clk_adc_1x_q            o 0.7 \
        cgm_busy_clk_adc_2x              o 0.7 \
        cgm_busy_clk_top_ahb_scan        o 0.7 \
        cgm_busy_clk_psram_ahb_scan      o 0.7 \
        cgm_busy_clk_sysram_ahb_scan     o 0.7 \
        cgm_busy_clk_26m_xo_cp_sys       o 0.7 \
        cgm_busy_clk_245_76m_cpll_cp_sys o 0.7 \
        cgm_busy_clk_30_72m_cpll_cp_sys  o 0.7 \
        cgm_busy_clk_51_2m_cpll_cp_sys   o 0.7 \
        cgm_busy_clk_102_4m_cpll_cp_sys  o 0.7 \
        cgm_busy_clk_cp2cpu              i 0.2 \
    ]
foreach {port_name direction percent} $lp_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_26M*${percent}] -clock ${CP_SYS_NAME}_V_CLK_26M [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_26M*${percent}] -clock ${CP_SYS_NAME}_V_CLK_26M [get_ports  ${port_name}] -add_delay
    }
}

# -----------------------
# async ports
# -----------------------
set async_ports [ list\
        int_txdfe_pwr_meas         o   0.7 \
        int_adc_cali               o   0.7 \
        wakeup_psram               i   0.7 \
        cp2psram_anti_ext          i   0.7 \
        wakeup_sysram              i   0.7 \
        cp2sysram_anti_ext         i   0.7 \
        wakeup_cpu                 i   0.7 \
        cp2cpu_anti_ext            i   0.7 \
        top2cp_anti_ext            o   0.7 \
        rxadc_ready                o   0.7 \
        dummy_in                   i   0.7 \
        dummy_out[63]              o   0.7 \
        dummy_out[62]              o   0.7 \
        dummy_out[61]              o   0.7 \
        dummy_out[60]              o   0.7 \
        dummy_out[59]              o   0.7 \
        dummy_out[58]              o   0.7 \
        dummy_out[57]              o   0.7 \
        dummy_out[56]              o   0.7 \
        dummy_out[55]              o   0.7 \
        dummy_out[54]              o   0.7 \
        dummy_out[53]              o   0.7 \
        dummy_out[52]              o   0.7 \
        dummy_out[51]              o   0.7 \
        dummy_out[50]              o   0.7 \
        dummy_out[49]              o   0.7 \
        dummy_out[48]              o   0.7 \
        dummy_out[47]              o   0.7 \
        dummy_out[46]              o   0.7 \
        dummy_out[45]              o   0.7 \
        dummy_out[44]              o   0.7 \
        dummy_out[43]              o   0.7 \
        dummy_out[42]              o   0.7 \
        dummy_out[41]              o   0.7 \
        dummy_out[40]              o   0.7 \
        dummy_out[39]              o   0.7 \
        dummy_out[38]              o   0.7 \
        dummy_out[37]              o   0.7 \
        dummy_out[36]              o   0.7 \
        dummy_out[35]              o   0.7 \
        dummy_out[34]              o   0.7 \
        dummy_out[33]              o   0.7 \
        dummy_out[32]              o   0.7 \
        dummy_out[31]              o   0.7 \
        dummy_out[30]              o   0.7 \
        dummy_out[29]              o   0.7 \
        dummy_out[28]              o   0.7 \
        dummy_out[27]              o   0.7 \
        dummy_out[26]              o   0.7 \
        dummy_out[25]              o   0.7 \
        dummy_out[24]              o   0.7 \
        dummy_out[23]              o   0.7 \
        dummy_out[22]              o   0.7 \
        dummy_out[21]              o   0.7 \
        dummy_out[20]              o   0.7 \
        dummy_out[19]              o   0.7 \
        dummy_out[18]              o   0.7 \
        dummy_out[17]              o   0.7 \
        dummy_out[16]              o   0.7 \
        dummy_out[15]              o   0.7 \
        dummy_out[14]              o   0.7 \
        dummy_out[13]              o   0.7 \
        dummy_out[12]              o   0.7 \
        dummy_out[11]              o   0.7 \
        dummy_out[10]              o   0.7 \
        dummy_out[ 9]              o   0.7 \
        dummy_out[ 8]              o   0.7 \
    ]
foreach {port_name direction percent} $async_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_26M*${percent}] -clock ${CP_SYS_NAME}_V_CLK_26M [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_26M*${percent}] -clock ${CP_SYS_NAME}_V_CLK_26M [get_ports  ${port_name}] -add_delay
    }
}

# -----------------------
# async ports
# -----------------------
set rf_ports [ list\
        rxpll_ldo0p9_en                     o       0.7 \
        rxvco_ldo_en                        o       0.7 \
        rxpll_vco_bias_en                   o       0.7 \
        rxpll_vco_en                        o       0.7 \
        rxpll_dpll_rst_n                    o       0.7 \
        txpll_ldo0p9_en                     o       0.7 \
        txvco_ldo_en                        o       0.7 \
        txpll_vco_bias_en                   o       0.7 \
        txpll_vco_en                        o       0.7 \
        txpll_dpll_rst_n                    o       0.7 \
        rx_PWR_SATDET                       o       0.7 \
        rx_bb_PWR_BIAS                      o       0.7 \
        rx_bb_PWR_VCMREF                    o       0.7 \
        rx_lna_ldo_en                       o       0.7 \
        rx_ldo_en                           o       0.7 \
        rx_lo_en                            o       0.7 \
        rx_mix_p_en                         o       0.7 \
        rx_mix_n_en                         o       0.7 \
        rx_mix_resetb                       o       0.7 \
        rx_dcoc_en                          o       0.7 \
        rx_i2v_en                           o       0.7 \
        rx_fil1_en                          o       0.7 \
        rx_fil2_en                          o       0.7 \
        rx_pga_en                           o       0.7 \
        rxadc_ldo_en                        o       0.7 \
        rxadc_pu_i                          o       0.7 \
        rxadc_pu_q                          o       0.7 \
        tx_bb_bias_en                       o       0.7 \
        txi2v_pwr                           o       0.7 \
        dac_ldo_en                          o       0.7 \
        txdac_en                            o       0.7 \
        tx_ldo_en                           o       0.7 \
        tx_lpf_en                           o       0.7 \
        tx_lo_en                            o       0.7 \
        tx_mix_en                           o       0.7 \
        tx_mix_resetb                       o       0.7 \
        tx_ppa_bias_en                      o       0.7 \
        tx_ppa_en                           o       0.7 \
        tx_pa_bias_en                       o       0.7 \
        tx_pa_en                            o       0.7 \
        rx_BA_C                             o       0.7 \
        rx_BA_R                             o       0.7 \
        rx_IB_FIL                           o       0.7 \
        rx_BW_I2V                           o       0.7 \
        rx_H_PREDEF_L_FREEDEF_I2V           o       0.7 \
        rx_C_FREEDEF_LPF                    o       0.7 \
        rx_fil_bw                           o       0.7 \
        tx_lpf_h_predef_l_freedef           o       0.7 \
        tx_lpf_freedef_cc                   o       0.7 \
        tx_lpf_rc_r1                        o       0.7 \
        tx_lpf_rc_r3                        o       0.7 \
        tx_fil_bw                           o       0.7 \
        tx_mod_h_hg_l_lg                    o       0.7 \
        txi2v_gain                          o       0.7 \
        tx_lpf_gain_rc                      o       0.7 \
        tx_ppa_h_hg_l_lg                    o       0.7 \
        tx_ppa_gc_hg                        o       0.7 \
        tx_ppa_gc_lg                        o       0.7 \
        rxpll_en_gear_shift                 o       0.7 \
        rxpll_lpf_gear_shift_en             o       0.7 \
        rxpll_lpf_fcal_filt_override        o       0.7 \
        rxpll_lpf_mux_ctrl                  o       0.7 \
        rxpll_lpf_c3_ctrl                   o       0.7 \
        rxpll_lpf_r3_ctrl                   o       0.7 \
        rxpll_lpf_c2_ctrl                   o       0.7 \
        rxpll_lpf_r1_ctrl                   o       0.7 \
        rxpll_lpf_c1_ctrl                   o       0.7 \
        txpll_en_gear_shift                 o       0.7 \
        txpll_lpf_gear_shift_en             o       0.7 \
        txpll_lpf_fcal_filt_override        o       0.7 \
        txpll_lpf_mux_ctrl                  o       0.7 \
        txpll_lpf_c3_ctrl                   o       0.7 \
        txpll_lpf_r3_ctrl                   o       0.7 \
        txpll_lpf_c2_ctrl                   o       0.7 \
        txpll_lpf_r1_ctrl                   o       0.7 \
        txpll_lpf_c1_ctrl                   o       0.7 \
        rx_H_DIV4_L_DIV2_3                  o       0.7 \
        rx_H_DIV4_L_DIV2_4                  o       0.7 \
        rx_H_DIV4_L_DIV2_5                  o       0.7 \
        rx_MX_BAND_SEL                      o       0.7 \
        rxadc_en_clk                        o       0.7 \
        tx_cal_en                           o       0.7 \
        rx_iqcal_loopback_band_sel          o       0.7 \
        tx_cal_att_tune                     o       0.7 \
        rx_rccal_rstn                       o       0.7 \
        rx_pwr_rccal                        o       0.7 \
        rx_hen_rccal                        o       0.7 \
        rx_ib_rccal_op                      o       0.7 \
        rx_ib_rccal_cm                      o       0.7 \
        rx_vb_rccal_cm                      o       0.7 \
        rx_ib_rccal_comp                    o       0.7 \
        dacpa_data                          o       0.7 \
        tdd_rxpll_txpll_sw                  o       0.7 \
        tx_port_lb1_en                      o       0.7 \
        tx_port_hmb1_en                     o       0.7 \
        tx_port_hmb2_en                     o       0.7 \
        tx_ppa_band_sel                     o       0.7 \
        txpll_prediv                        o       0.7 \
        rxpll_prediv                        o       0.7 \
        rxvco_ldo_byp                       o       0.7 \
        rxvco_ldo_opa_cs_buf                o       0.7 \
        rxvco_ldo_opa_ib_bst                o       0.7 \
        rxvco_ldo_opa_cs                    o       0.7 \
        rxvco_ldo_ref_off                   o       0.7 \
        rxvco_ldo_filt_en                   o       0.7 \
        rxvco_ldo_bleed                     o       0.7 \
        rxvco_ldo_fb                        o       0.7 \
        rxpll_ldo0p9_byp                    o       0.7 \
        rxpll_ldo0p9_rz_ctrl                o       0.7 \
        rxpll_ldo0p9_opa_ib_bst             o       0.7 \
        rxpll_ldo0p9_opa_cs                 o       0.7 \
        rxpll_ldo0p9_ref_off                o       0.7 \
        rxpll_ldo0p9_filt_en                o       0.7 \
        rxpll_ldo0p9_bleed                  o       0.7 \
        rxpll_ldo0p9_fb                     o       0.7 \
        txvco_ldo_byp                       o       0.7 \
        txvco_ldo_opa_cs_buf                o       0.7 \
        txvco_ldo_opa_ib_bst                o       0.7 \
        txvco_ldo_opa_cs                    o       0.7 \
        txvco_ldo_ref_off                   o       0.7 \
        txvco_ldo_filt_en                   o       0.7 \
        txvco_ldo_bleed                     o       0.7 \
        txvco_ldo_fb                        o       0.7 \
        txpll_ldo0p9_byp                    o       0.7 \
        txpll_ldo0p9_rz_ctrl                o       0.7 \
        txpll_ldo0p9_opa_ib_bst             o       0.7 \
        txpll_ldo0p9_opa_cs                 o       0.7 \
        txpll_ldo0p9_ref_off                o       0.7 \
        txpll_ldo0p9_filt_en                o       0.7 \
        txpll_ldo0p9_bleed                  o       0.7 \
        txpll_ldo0p9_fb                     o       0.7 \
        rxpll_pfd_sel_enopt                 o       0.7 \
        rxpll_pfd_tdel                      o       0.7 \
        rxpll_cp_opa_boost                  o       0.7 \
        rxpll_cp_mirror_size                o       0.7 \
        rxpll_cp_iboost                     o       0.7 \
        rxpll_cp_biassel_bgcgm              o       0.7 \
        rxpll_cp_ipcode                     o       0.7 \
        rxpll_cp_incode                     o       0.7 \
        txpll_pfd_sel_enopt                 o       0.7 \
        txpll_pfd_tdel                      o       0.7 \
        txpll_cp_opa_boost                  o       0.7 \
        txpll_cp_mirror_size                o       0.7 \
        txpll_cp_iboost                     o       0.7 \
        txpll_cp_biassel_bgcgm              o       0.7 \
        txpll_cp_ipcode                     o       0.7 \
        txpll_cp_incode                     o       0.7 \
        rxpll_lpf_c3_pre                    o       0.7 \
        rxpll_lpf_r3_pre                    o       0.7 \
        rxpll_lpf_c2_pre                    o       0.7 \
        rxpll_lpf_r1_pre                    o       0.7 \
        rxpll_lpf_c1_pre                    o       0.7 \
        txpll_lpf_c3_pre                    o       0.7 \
        txpll_lpf_r3_pre                    o       0.7 \
        txpll_lpf_c2_pre                    o       0.7 \
        txpll_lpf_r1_pre                    o       0.7 \
        txpll_lpf_c1_pre                    o       0.7 \
        rxpll_dpll_rst_gate_b               o       0.7 \
        rxpll_dpll_vco_ctrl_override        o       0.7 \
        rxpll_dpll_done                     i       0.7 \
        rxpll_dpll_ideal_count              o       0.7 \
        rxpll_dpll_ref_div                  o       0.7 \
        rxpll_vco_freq_override             o       0.7 \
        txpll_dpll_rst_gate_b               o       0.7 \
        txpll_dpll_vco_ctrl_override        o       0.7 \
        txpll_dpll_done                     i       0.7 \
        txpll_dpll_ideal_count              o       0.7 \
        txpll_dpll_ref_div                  o       0.7 \
        txpll_vco_freq_override             o       0.7 \
        rxpll_mash_clk_sw                   o       0.7 \
        txpll_mash_clk_sw                   o       0.7 \
        rxpll_lock_det_en                   o       0.7 \
        txpll_lock_det_en                   o       0.7 \
        rxpll_vco_en_filt                   o       0.7 \
        rxpll_vco_vpbias_mode               o       0.7 \
        rxpll_vco_bias_mode                 o       0.7 \
        rxpll_vco_var_sel                   o       0.7 \
        rxpll_vco_var                       o       0.7 \
        rxpll_vco_en_ical                   o       0.7 \
        rxpll_vco_ical                      o       0.7 \
        rxpll_vco_ibuf                      o       0.7 \
        rxpll_vco_ib                        o       0.7 \
        rxpll_vco_icore                     o       0.7 \
        rxpll_vco_read_freq                 i       0.7 \
        txpll_vco_en_filt                   o       0.7 \
        txpll_vco_vpbias_mode               o       0.7 \
        txpll_vco_bias_mode                 o       0.7 \
        txpll_vco_var_sel                   o       0.7 \
        txpll_vco_var                       o       0.7 \
        txpll_vco_en_ical                   o       0.7 \
        txpll_vco_ical                      o       0.7 \
        txpll_vco_ibuf                      o       0.7 \
        txpll_vco_ib                        o       0.7 \
        txpll_vco_icore                     o       0.7 \
        txpll_vco_read_freq                 i       0.7 \
        rxadc_ldo_byp                       o       0.7 \
        rxadc_ldo_opa_cs_buf                o       0.7 \
        rxadc_ldo_rz_ctrl                   o       0.7 \
        rxadc_ldo_opa_ib_bst                o       0.7 \
        rxadc_ldo_opa_cs                    o       0.7 \
        rxadc_ldo_ref_off                   o       0.7 \
        rxadc_ldo_filt_en                   o       0.7 \
        rxadc_ldo_bleed                     o       0.7 \
        rxadc_ldo_fb                        o       0.7 \
        rxadc_del_ctr_ch1_i                 o       0.7 \
        rxadc_del_ctr_ch3_i                 o       0.7 \
        rxadc_del_ctr_ch1_q                 o       0.7 \
        rxadc_del_ctr_ch3_q                 o       0.7 \
        rx_ldo_byp                          o       0.7 \
        rx_ldo_opa_cs_buf                   o       0.7 \
        rx_ldo_rz_ctrl                      o       0.7 \
        rx_ldo_opa_ib_bst                   o       0.7 \
        rx_ldo_opa_cs                       o       0.7 \
        rx_ldo_ref_off                      o       0.7 \
        rx_ldo_filt_en                      o       0.7 \
        rx_ldo_bleed                        o       0.7 \
        rx_ldo_fb                           o       0.7 \
        rxbb_rsv1                           o       0.7 \
        rx_VTH_SEL                          o       0.7 \
        rx_IB_SATDET                        o       0.7 \
        rx_HEN_DCOS                         o       0.7 \
        rx_Q_RCCAL                          o       0.7 \
        rx_IB_DCOS_REF                      o       0.7 \
        rx_IB_I2V                           o       0.7 \
        rx_IB_PGA                           o       0.7 \
        rx_bb_VCM_SEL                       o       0.7 \
        rx_H_PREDEF_L_FREEDEF_LPF           o       0.7 \
        rx_C_FREEDEF_I2V                    o       0.7 \
        rx_DCOS_POL_Q                       o       0.7 \
        rx_DCOS_POL_I                       o       0.7 \
        rx_DCOS_Q                           o       0.7 \
        rx_DCOS_I                           o       0.7 \
        rx_MXBIAS_STEP                      o       0.7 \
        rx_H_FINE_L_COARSE                  o       0.7 \
        rx_LODC_COARSE                      o       0.7 \
        rx_LODC_INXN                        o       0.7 \
        rx_LODC_INXP                        o       0.7 \
        rx_LODC_IPXN                        o       0.7 \
        rx_LODC_IPXP                        o       0.7 \
        rx_LODC_QNXN                        o       0.7 \
        rx_LODC_QNXP                        o       0.7 \
        rx_LODC_QPXN                        o       0.7 \
        rx_LODC_QPXP                        o       0.7 \
        tx_ldo_byp                          o       0.7 \
        tx_ldo_opa_cs_buf                   o       0.7 \
        tx_ldo_rz_ctrl                      o       0.7 \
        tx_ldo_ib_bst                       o       0.7 \
        tx_ldo_opa_cs                       o       0.7 \
        tx_ldo_ref_off                      o       0.7 \
        tx_ldo_filt_en                      o       0.7 \
        tx_ldo_bleed                        o       0.7 \
        tx_ldo_vout_ctrl                    o       0.7 \
        txdac_clkendg_ctrl2                 o       0.7 \
        txi2v_qrccal                        o       0.7 \
        tx_bb_q_rccal                       o       0.7 \
        tx_lo_dc                            o       0.7 \
        tx_mod_selfbias                     o       0.7 \
        tx_ib_i2v                           o       0.7 \
        tx_ib_fil                           o       0.7 \
        tx_vcm_sel                          o       0.7 \
        tx_ib_mod                           o       0.7 \
        txbb_rsv3                           o       0.7 \
        txmix_rsv1                          o       0.7 \
        tx_logen_h_div4_l_div2              o       0.7 \
        dac_ldo_byp                         o       0.7 \
        dac_ldo_rz_ctrl                     o       0.7 \
        dac_ldo_opa_ib_bst                  o       0.7 \
        dac_ldo_opa_cs                      o       0.7 \
        dac_ldo_ref_off                     o       0.7 \
        dac_ldo_filt_en                     o       0.7 \
        dac_ldo_bleed                       o       0.7 \
        dac_ldo_fb                          o       0.7 \
        txdac_clk_edge                      o       0.7 \
        txdac_bias                          o       0.7 \
        txdac_biasres                       o       0.7 \
        txdac_load_res_i                    o       0.7 \
        txdac_half_mir                      o       0.7 \
        txdac_inv_ck                        o       0.7 \
        txdac_msb_tog                       o       0.7 \
        txdac_load_res_q                    o       0.7 \
        rx_lna_ldo_byp                      o       0.7 \
        rx_lna_ldo_opa_cs_buf               o       0.7 \
        rx_lna_ldo_rz_ctrl                  o       0.7 \
        rx_lna_ldo_opa_ib_bst               o       0.7 \
        rx_lna_ldo_opa_cs                   o       0.7 \
        rx_lna_ldo_ref_off                  o       0.7 \
        rx_lna_ldo_filt_en                  o       0.7 \
        rx_lna_ldo_bleed                    o       0.7 \
        rx_lna_ldo_fb                       o       0.7 \
        rx_lna_pc_ascode_en                 o       0.7 \
        rx_lna_protect_en                   o       0.7 \
        rx_lna_cgm_sel                      o       0.7 \
        rx_lna_bias                         o       0.7 \
        txpa3                               o       0.7 \
        txppa_ldo_en                        o       0.7 \
        txppa_ldo_byp                       o       0.7 \
        txppa_ldo_opa_cs_buf                o       0.7 \
        txppa_ldo_ib_bst                    o       0.7 \
        txppa_ldo_opa_cs                    o       0.7 \
        txppa_ldo_ref_off                   o       0.7 \
        txppa_ldo_filt_en                   o       0.7 \
        txppa_ldo_bleed                     o       0.7 \
        txppa_ldo_vout_ctrl                 o       0.7 \
        tx_ppa_vbcas_lg                     o       0.7 \
        tx_ppa_vbcas_hg                     o       0.7 \
        txppa_vbcore_lg                     o       0.7 \
        txppa_vbcore1_hg                    o       0.7 \
        txppa_vbcore2_hg                    o       0.7 \
        tx_notch_filter_ctune               o       0.7 \
        tx_ppa_ctune                        o       0.7 \
        rxadc_ref_vadjI                     o       0.7 \
        rxadc_ref_vadjQ                     o       0.7 \
        rxadc_en_hspd                       o       0.7 \
        Test_sel                            o       0.7 \
        Test_block_sel                      o       0.7 \
        satdet                              i       0.7 \
        rx_rccal_q_cap                      i       0.7 \
        SATDET_DIGOUT_PGA                   i       0.7 \
        SATDET_DIGOUT_I2V                   i       0.7 \
        spare1                              o       0.7 \
        clk_dig_122p88m_en                  o       0.7 \
        rxpll_lock_gate_vhi                 o       0.7 \
        rxpll_lock_gate_vlow                o       0.7 \
        txpll_lock_gate_vhi                 o       0.7 \
        txpll_lock_gate_vlow                o       0.7 \
        rxpll_ld_lock                       i       0.7 \
        rxpll_ld_vh                         i       0.7 \
        rxpll_ld_vl                         i       0.7 \
        txpll_ld_lock                       i       0.7 \
        txpll_ld_vh                         i       0.7 \
        txpll_ld_vl                         i       0.7 \
    ]
foreach {port_name direction percent} $rf_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_30M72*${percent}] -clock ${CP_SYS_NAME}_clk_30_72m_cpll_${CP_SYS_NAME} [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_30M72*${percent}] -clock ${CP_SYS_NAME}_clk_30_72m_cpll_${CP_SYS_NAME} [get_ports  ${port_name}] -add_delay
    }
}

set mash_txpll_ports [ list\
        txpll_mash_rst_n                    o       0.7 \
        txpll_mash2                         o       0.7 \
        txpll_mash_dith_shape               o       0.7 \
        txpll_mash_dith_lsb                 o       0.7 \
        txpll_mash_int_mode_en              o       0.7 \
        txpll_mash_update                   o       0.7 \
        txpll_mash_select                   o       0.7 \
        txpll_mash_int                      o       0.7 \
        txpll_mash_frac                     o       0.7 \
]
foreach {port_name direction percent} $mash_txpll_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_102M4*${percent}] -clock ${CP_SYS_NAME}_clk_txpll_mash_ana_in [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_102M4*${percent}] -clock ${CP_SYS_NAME}_clk_txpll_mash_ana_in [get_ports  ${port_name}] -add_delay
    }
}


set mash_rxpll_ports [ list\
        rxpll_mash_rst_n                    o       0.7 \
        rxpll_mash2                         o       0.7 \
        rxpll_mash_dith_shape               o       0.7 \
        rxpll_mash_dith_lsb                 o       0.7 \
        rxpll_mash_int_mode_en              o       0.7 \
        rxpll_mash_update                   o       0.7 \
        rxpll_mash_select                   o       0.7 \
        rxpll_mash_int                      o       0.7 \
        rxpll_mash_frac                     o       0.7 \
]
foreach {port_name direction percent} $mash_rxpll_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_102M4*${percent}] -clock ${CP_SYS_NAME}_clk_rxpll_mash_ana_in [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_102M4*${percent}] -clock ${CP_SYS_NAME}_clk_rxpll_mash_ana_in [get_ports  ${port_name}] -add_delay
    }
}

set adc_ch1_1x_i_ports [ list\
        rxadc_B1_i                          i       0.4 \
        rxadc_ready_ch1_i                   i       0.4 \
]
foreach {port_name direction percent} $adc_ch1_1x_i_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_122M88*${percent}] -clock_fall -clock ${CP_SYS_NAME}_clk_adc_1x_i_ana_in [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_122M88*${percent}] -clock_fall -clock ${CP_SYS_NAME}_clk_adc_1x_i_ana_in [get_ports  ${port_name}] -add_delay
    }
}

set adc_ch3_1x_i_ports [ list\
        rxadc_B3_i                          i       0.4 \
        rxadc_ready_ch3_i                   i       0.4 \
]
foreach {port_name direction percent} $adc_ch3_1x_i_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_122M88*${percent}]  -clock ${CP_SYS_NAME}_clk_adc_1x_i_ana_in [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_122M88*${percent}]  -clock ${CP_SYS_NAME}_clk_adc_1x_i_ana_in [get_ports  ${port_name}] -add_delay
    }
}
# -----------------------
# adc_1x_q ports
# -----------------------
set adc_ch1_1x_q_ports [ list\
        rxadc_B1_q                          i       0.4 \
        rxadc_ready_ch1_q                   i       0.4 \
    ]

foreach {port_name direction percent} $adc_ch1_1x_q_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_122M88*${percent}] -clock_fall -clock ${CP_SYS_NAME}_clk_adc_1x_q_ana_in [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_122M88*${percent}] -clock_fall -clock ${CP_SYS_NAME}_clk_adc_1x_q_ana_in [get_ports  ${port_name}] -add_delay
    }
}
set adc_ch3_1x_q_ports [ list\
        rxadc_B3_q                          i       0.4 \
        rxadc_ready_ch3_q                   i       0.4 \
    ]

foreach {port_name direction percent} $adc_ch3_1x_q_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_122M88*${percent}]  -clock ${CP_SYS_NAME}_clk_adc_1x_q_ana_in [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_122M88*${percent}]  -clock ${CP_SYS_NAME}_clk_adc_1x_q_ana_in [get_ports  ${port_name}] -add_delay
    }
}
set adc_2x_ports [list\
        int_adc_cali                        o       0.7 \
        rxadc_en_ch1_i                      o       0.7 \
        rxadc_en_ch3_i                      o       0.7 \
        rxadc_en_ch1_q                      o       0.7 \
        rxadc_en_ch3_q                      o       0.7 \
        rxadc_cal_dac_ctr_ch1_i             o       0.7 \
        rxadc_cal_dac_ctr_ch3_i             o       0.7 \
        rxadc_cal_dac_ctr_ch1_q             o       0.7 \
        rxadc_cal_dac_ctr_ch3_q             o       0.7 \
        rxadc_calp_ch1_i                    o       0.7 \
        rxadc_calp_ch3_i                    o       0.7 \
        rxadc_caln_ch1_i                    o       0.7 \
        rxadc_caln_ch3_i                    o       0.7 \
        rxadc_calp_ch1_q                    o       0.7 \
        rxadc_calp_ch3_q                    o       0.7 \
        rxadc_caln_ch1_q                    o       0.7 \
        rxadc_caln_ch3_q                    o       0.7 \
        rxadc_clk245m_en                    o       0.7 \
]
foreach {port_name direction percent} $adc_2x_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_245M76*${percent}] -clock ${CP_SYS_NAME}_clk_adc_2x_ana_in [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_245M76*${percent}] -clock ${CP_SYS_NAME}_clk_adc_2x_ana_in [get_ports  ${port_name}] -add_delay
    }
}

set hsdl_ports [list\
        hsdl_valid                          o       0.7 \
        hsdl_data                           o       0.7 \
]
foreach {port_name direction percent} $hsdl_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_102M4*${percent}] -clock ${CP_SYS_NAME}_clk_hsdl [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_102M4*${percent}] -clock ${CP_SYS_NAME}_clk_hsdl [get_ports  ${port_name}] -add_delay
    }
}


set top_ahb_ports [list\
    hsel_top2cp      i 0.7 \
    hwrite_top2cp    i 0.7 \
    haddr_top2cp     i 0.7 \
    hwdata_top2cp    i 0.7 \
    hrdata_top2cp    o 0.7 \
    htrans_top2cp    i 0.7 \
    hburst_top2cp    i 0.7 \
    hsize_top2cp     i 0.7 \
    hprot_top2cp     i 0.7 \
    hresp_top2cp     o 0.7 \
    hreadyin_top2cp  i 0.7 \
    hreadyout_top2cp o 0.7 \
    ]
foreach {port_name direction percent} $top_ahb_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_102M4*${percent}] -clock ${CP_SYS_NAME}_clk_top_ahb [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_102M4*${percent}] -clock ${CP_SYS_NAME}_clk_top_ahb [get_ports  ${port_name}] -add_delay
    }
}

set psram_ahb_ports [list\
    haddr_cp2psram     o 0.7 \
    hburst_cp2psram    o 0.7 \
    hmastlock_cp2psram o 0.7 \
    hprot_cp2psram     o 0.7 \
    hsize_cp2psram     o 0.7 \
    htrans_cp2psram    o 0.7 \
    hwdata_cp2psram    o 0.7 \
    hwrite_cp2psram    o 0.7 \
    hmaster_cp2psram   o 0.7 \
    hrdata_cp2psram    i 0.7 \
    hready_cp2psram    i 0.7 \
    hresp_cp2psram     i 0.7 \
    ]
foreach {port_name direction percent} $psram_ahb_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_204M8*${percent}] -clock ${CP_SYS_NAME}_clk_psram_ahb [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_204M8*${percent}] -clock ${CP_SYS_NAME}_clk_psram_ahb [get_ports  ${port_name}] -add_delay
    }
}

set sysram_ahb_ports [list\
    haddr_cp2sysram     o 0.7 \
    hburst_cp2sysram    o 0.7 \
    hmastlock_cp2sysram o 0.7 \
    hprot_cp2sysram     o 0.7 \
    hsize_cp2sysram     o 0.7 \
    htrans_cp2sysram    o 0.7 \
    hwdata_cp2sysram    o 0.7 \
    hwrite_cp2sysram    o 0.7 \
    hmaster_cp2sysram   o 0.7 \
    hrdata_cp2sysram    i 0.7 \
    hready_cp2sysram    i 0.7 \
    hresp_cp2sysram     i 0.7 \
    ]
foreach {port_name direction percent} $sysram_ahb_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_245M76*${percent}] -clock ${CP_SYS_NAME}_clk_sysram_ahb [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_245M76*${percent}] -clock ${CP_SYS_NAME}_clk_sysram_ahb [get_ports  ${port_name}] -add_delay
    }
}

set cpu_ahb_ports [list\
    hsel_cp2cpu      o 0.6 \
    haddr_cp2cpu     o 0.7 \
    hburst_cp2cpu    o 0.6 \
    hmastlock_cp2cpu o 0.7 \
    hprot_cp2cpu     o 0.7 \
    hsize_cp2cpu     o 0.7 \
    htrans_cp2cpu    o 0.6 \
    hwdata_cp2cpu    o 0.7 \
    hwrite_cp2cpu    o 0.7 \
    hreadyin_cp2cpu  o 0.7 \
    hrdata_cp2cpu    i 0.7 \
    hreadyout_cp2cpu i 0.6 \
    hresp_cp2cpu     i 0.7 \
    ]
foreach {port_name direction percent} $cpu_ahb_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_245M76*${percent}] -clock ${CP_SYS_NAME}_clk_modem [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_245M76*${percent}] -clock ${CP_SYS_NAME}_clk_modem [get_ports  ${port_name}] -add_delay
    }
}

set clk_modem_ports [list \
    int_cpdma   o 0.7 \
    int_modem_cs               o   0.7 \
    int_modem_meas             o   0.7 \
    int_modem_rchain           o   0.7 \
    int_modem_ce               o   0.7 \
    int_modem_cch              o   0.7 \
    int_modem_dch              o   0.7 \
    int_modem_ul_brp           o   0.7 \
    int_modem_ul_srp           o   0.7 \
]
foreach {port_name direction percent} $clk_modem_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_245M76*${percent}] -clock ${CP_SYS_NAME}_clk_modem [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_245M76*${percent}] -clock ${CP_SYS_NAME}_clk_modem [get_ports  ${port_name}] -add_delay
    }
}

# dummy_out[7:0] -- pin_out_val
set clk_rft_ports [list \
    txpll_en                            o       0.7 \
    rxpll_en                            o       0.7 \
    frc_curval                          i       0.7 \
    int_txdfe_pwr_meas                  o       0.7 \
    rx_lna_cmatch                       o       0.7 \
    rx_lna_gm                           o       0.7 \
    rx_lna_attn_tune                    o       0.7 \
    rx_lna_rmatch                       o       0.7 \
    rx_lna_attn_stp                     o       0.7 \
    rx_i2v                              o       0.7 \
    rx_pga                              o       0.7 \
    int_rxdfe_data                      o       0.7 \
    int_rxdfe_meas                      o       0.7 \
    int_rxdfe_sync                      o       0.7 \
    int_rxdfe_wb                        o       0.7 \
    int_rxdfe_dcest                     o       0.7 \
    int_rft_free_tmr                    o       0.7 \
    int_rft_gpt_high                    o       0.7 \
    int_rft_gpt_low                     o       0.7 \
    int_rf_dig_rft_conflict             o       0.7 \
    int_dfe_rft_conflict                o       0.7 \
    rxpll_mash_clk_en                   o       0.7 \
    txpll_mash_clk_en                   o       0.7 \
    dummy_out[ 7]                       o       0.7 \
    dummy_out[ 6]                       o       0.7 \
    dummy_out[ 5]                       o       0.7 \
    dummy_out[ 4]                       o       0.7 \
    dummy_out[ 3]                       o       0.7 \
    dummy_out[ 2]                       o       0.7 \
    dummy_out[ 1]                       o       0.7 \
    dummy_out[ 0]                       o       0.7 \
]
foreach {port_name direction percent} $clk_rft_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_30M72*${percent}] -clock ${CP_SYS_NAME}_clk_rft [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_30M72*${percent}] -clock ${CP_SYS_NAME}_clk_rft [get_ports  ${port_name}] -add_delay
    }
}

set clk_dlink_dst_ports [list \
    int_dlink_udflw_err         o       0.7 \
]
foreach {port_name direction percent} $clk_dlink_dst_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_245M76*${percent}] -clock ${CP_SYS_NAME}_clk_dlink_dst_mux_dac [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_245M76*${percent}] -clock ${CP_SYS_NAME}_clk_dlink_dst_mux_dac [get_ports  ${port_name}] -add_delay
    }
}


set dac_ports [list\
    tx_data_in_i   o 0.7 \
    tx_data_in_q   o 0.7 \
    ]
foreach {port_name direction percent} $dac_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_122M88*${percent}] -clock ${CP_SYS_NAME}_clk_dac_ana_in [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_122M88*${percent}] -clock ${CP_SYS_NAME}_clk_dac_ana_in [get_ports  ${port_name}] -add_delay
    }
}

set mipi_ports [list\
    int_mipi_rffe   o 0.7 \
]
foreach {port_name direction percent} $mipi_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_51M2*${percent}] -clock ${CP_SYS_NAME}_clk_mipi_rffe [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_51M2*${percent}] -clock ${CP_SYS_NAME}_clk_mipi_rffe [get_ports  ${port_name}] -add_delay
    }
}

set mipi_scl_ports [list\
    mipi_o_scl_en   o 0.3 \
    mipi_i_sda      i 0.3 \
    mipi_o_sda      o 0.3 \
    mipi_o_sda_en   o 0.3\
]
foreach {port_name direction percent} $mipi_scl_ports {
    if {$direction == "i"} {
        set_input_delay  -max [expr $CYCLE_25M6*${percent}] -clock ${CP_SYS_NAME}_clk_mipi_o_scl [get_ports  ${port_name}] -add_delay
        set_input_delay  -min [expr 0]                      -clock ${CP_SYS_NAME}_clk_mipi_o_scl [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay -max [expr $CYCLE_25M6*${percent}] -clock_fall -clock ${CP_SYS_NAME}_clk_mipi_o_scl [get_ports  ${port_name}] -add_delay
        set_output_delay -min [expr 0]                      -clock_fall -clock ${CP_SYS_NAME}_clk_mipi_o_scl [get_ports  ${port_name}] -add_delay
    }
}
#!IS_CHIP
} else {
# IS_CHIP

set mipi_scl_ports [list\
    $func_pad_names(rffe_data)      i 0.3 \
    $func_pad_names(rffe_data)      o 0.3 \
]
foreach {port_name direction percent} $mipi_scl_ports {
    if {$direction == "i"} {
        set_input_delay  -max [expr $CYCLE_25M6*${percent}] -clock ${CP_SYS_NAME}_clk_mipi_o_scl [get_ports  ${port_name}] -add_delay
        set_input_delay  -min [expr 0]                      -clock ${CP_SYS_NAME}_clk_mipi_o_scl [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay -max [expr $CYCLE_25M6*${percent}] -clock_fall -clock ${CP_SYS_NAME}_clk_mipi_o_scl [get_ports  ${port_name}] -add_delay
        set_output_delay -min [expr 0]                      -clock_fall -clock ${CP_SYS_NAME}_clk_mipi_o_scl [get_ports  ${port_name}] -add_delay
    }
}

set hsdl_ports [list\
        $func_pad_names(hsdl_valid)                          o       0.7 \
        $func_pad_names(hsdl_d0)                             o       0.7 \
        $func_pad_names(hsdl_d1)                             o       0.7 \
        $func_pad_names(hsdl_d2)                             o       0.7 \
        $func_pad_names(hsdl_d3)                             o       0.7 \
        $func_pad_names(hsdl_d4)                             o       0.7 \
        $func_pad_names(hsdl_d5)                             o       0.7 \
        $func_pad_names(hsdl_d6)                             o       0.7 \
        $func_pad_names(hsdl_d7)                             o       0.7 \
]
foreach {port_name direction percent} $hsdl_ports {
    if {$direction == "i"} {
        set_input_delay  [expr $CYCLE_102M4*${percent}] -clock ${CP_SYS_NAME}_clk_hsdl [get_ports  ${port_name}] -add_delay
    } else {
        set_output_delay [expr $CYCLE_102M4*${percent}] -clock ${CP_SYS_NAME}_clk_hsdl [get_ports  ${port_name}] -add_delay
    }
}


}

