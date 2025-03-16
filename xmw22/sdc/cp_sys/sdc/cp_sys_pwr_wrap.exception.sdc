# stop clock propogate and timing check
set_false_path -through [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_dbgbus/*u_cmind_cell_buf/cmind_uj_cell/Z]
set_sense -stop_propagation [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_dbgbus/u_*_cka/cmind_uj_ckcell/A1]

#set_multicycle_path -setup 4 -from  [get_clocks cp_sys_clk_rft] -to [get_clocks cp_sys_clk_dfe] -end
#set_multicycle_path -hold  3 -from  [get_clocks cp_sys_clk_rft] -to [get_clocks cp_sys_clk_dfe] -end
#
#set_multicycle_path -setup 4 -from  [get_clocks cp_sys_clk_dfe] -to [get_clocks cp_sys_clk_rft] -start
#set_multicycle_path -hold  3 -from  [get_clocks cp_sys_clk_dfe] -to [get_clocks cp_sys_clk_rft] -start
#
#set_multicycle_path -setup 8 -from  [get_clocks cp_sys_clk_rft] -to [get_clocks cp_sys_clk_modem] -end
#set_multicycle_path -hold  7 -from  [get_clocks cp_sys_clk_rft] -to [get_clocks cp_sys_clk_modem] -end
#
#set_multicycle_path -setup 8 -from  [get_clocks cp_sys_clk_modem] -to [get_clocks cp_sys_clk_rft] -start
#set_multicycle_path -hold  7 -from  [get_clocks cp_sys_clk_modem] -to [get_clocks cp_sys_clk_rft] -start
#
#set_multicycle_path -setup 4 -from  [get_clocks cp_sys_clk_30_72m_cpll_cp_sys] -to [get_clocks cp_sys_clk_dfe] -end
#set_multicycle_path -hold  3 -from  [get_clocks cp_sys_clk_30_72m_cpll_cp_sys] -to [get_clocks cp_sys_clk_dfe] -end
#
#set_multicycle_path -setup 4 -from  [get_clocks cp_sys_clk_dfe] -to [get_clocks cp_sys_clk_30_72m_cpll_cp_sys] -start
#set_multicycle_path -hold  3 -from  [get_clocks cp_sys_clk_dfe] -to [get_clocks cp_sys_clk_30_72m_cpll_cp_sys] -start

set_multicycle_path -setup 8 -from  [get_clocks cp_sys_clk_rft] -through [get_pins ${CP_SYS_TOP_HIER}u_cp_ip_dbg_dump_chn_mux/u_stream_collect/frc_cur_val_out_reg*/*] -to [get_clocks $name_clk_dlink_src_mux_modem] -end
set_multicycle_path -hold  7 -from  [get_clocks cp_sys_clk_rft] -through [get_pins ${CP_SYS_TOP_HIER}u_cp_ip_dbg_dump_chn_mux/u_stream_collect/frc_cur_val_out_reg*/*] -to [get_clocks $name_clk_dlink_src_mux_modem] -end

set_multicycle_path -setup 4 -from  [get_clocks cp_sys_clk_rft] -through [get_pins ${CP_SYS_TOP_HIER}u_cp_ip_dbg_dump_chn_mux/u_stream_collect/frc_cur_val_out_reg*/*] -to [get_clocks $name_clk_dlink_src_mux_dfe] -end
set_multicycle_path -hold  3 -from  [get_clocks cp_sys_clk_rft] -through [get_pins ${CP_SYS_TOP_HIER}u_cp_ip_dbg_dump_chn_mux/u_stream_collect/frc_cur_val_out_reg*/*] -to [get_clocks $name_clk_dlink_src_mux_dfe] -end
set_multicycle_path -setup 8 -from  [get_clocks cp_sys_clk_modem] -through [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_dbg_eb*/CP] -to [get_clocks $name_clk_30_72m_cpll_cp_sys] -start
set_multicycle_path -hold  7 -from  [get_clocks cp_sys_clk_modem] -through [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_dbg_eb*/CP] -to [get_clocks $name_clk_30_72m_cpll_cp_sys] -start

set_multicycle_path 2 -setup -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/cp2psram_eb_reg/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_main_mtx/u_ahb_anti_hang_s1/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 1 -hold -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/cp2psram_eb_reg/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_main_mtx/u_ahb_anti_hang_s1/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 2 -setup -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/cp2sysram_eb_reg/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_main_mtx/u_ahb_anti_hang_s2/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 1 -hold -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/cp2sysram_eb_reg/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_main_mtx/u_ahb_anti_hang_s2/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 2 -setup -from [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_top2modem_ahb_asb/u_resp/q_q_reg_0_/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_pmu/u_cp_mtx_ahb_lpc/GEN_AHB_IDLE_SYNC_u_ahb_idle_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 1 -hold -from [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_top2modem_ahb_asb/u_resp/q_q_reg_0_/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_pmu/u_cp_mtx_ahb_lpc/GEN_AHB_IDLE_SYNC_u_ahb_idle_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 2 -setup -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/frc_on_clk_psram_ahb_reg/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_main_mtx/u_ahb_anti_hang_s1/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 1 -hold  -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/frc_on_clk_psram_ahb_reg/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_main_mtx/u_ahb_anti_hang_s1/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 2 -setup -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/frc_off_clk_psram_ahb_reg/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_main_mtx/u_ahb_anti_hang_s1/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 1 -hold  -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/frc_off_clk_psram_ahb_reg/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_main_mtx/u_ahb_anti_hang_s1/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]


# clk dac busy
# can set false path
set_multicycle_path -setup 8 -from  [get_clocks cp_sys_clk_dlink_dst_mux_modem] -through [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_clk_manual/u_cmind_clk_gate_clk_dlink_dbg_dst_gate/async_clk_gate?u_cmind_sig_sync/cmind_sync_buf2?bit2?0??genblk1?sync2_rst0?sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_clocks $name_clk_30_72m_cpll_cp_sys] -start
set_multicycle_path -hold  7 -from  [get_clocks cp_sys_clk_dlink_dst_mux_modem] -through [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_clk_manual/u_cmind_clk_gate_clk_dlink_dbg_dst_gate/async_clk_gate?u_cmind_sig_sync/cmind_sync_buf2?bit2?0??genblk1?sync2_rst0?sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_clocks $name_clk_30_72m_cpll_cp_sys] -start


if {! $IS_CHIP} {
    set_false_path -from [get_ports dbgbus_cpsys_chain_sel]
    set_false_path -to   [get_ports dbgbus_cpsys_data]
    set_false_path -from [get_ports cp_shutdown_n]
    set_false_path -to   [get_ports cp_shutdown_ack_n]
    set_multicycle_path 8 -setup -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_grp_sel_reg*/CP]     -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_grp_sel_reg*/CP]     -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_sub_grp_sel_reg*/CP] -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_sub_grp_sel_reg*/CP] -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/dlink_dst_sel_sw_en_reg*/CP] -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/dlink_dst_sel_sw_en_reg*/CP] -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/dlink_dbg_dst_sw_sel_reg*/CP] -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/dlink_dbg_dst_sw_sel_reg*/CP] -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dac_eb_reg*/CP] -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dac_eb_reg*/CP] -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/frc_on_clk_dac_reg*/CP]  -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/frc_on_clk_dac_reg*/CP]  -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/frc_off_clk_dac_reg*/CP]  -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/frc_off_clk_dac_reg*/CP]  -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/clk_dac_aux_en_reg*/CP]  -to [get_ports clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/clk_dac_aux_en_reg*/CP]  -to [get_ports clk_dig_122p88m_en]
    #set_multicycle_path 8 -setup -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_grp_sel_reg*/CP]     -to [get_ports rxadc_clk245m_en]
    #set_multicycle_path 7 -hold  -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_grp_sel_reg*/CP]     -to [get_ports rxadc_clk245m_en]
    #set_multicycle_path 8 -setup -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_sub_grp_sel_reg*/CP] -to [get_ports rxadc_clk245m_en]
    #set_multicycle_path 7 -hold  -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_sub_grp_sel_reg*/CP] -to [get_ports rxadc_clk245m_en]
    set_multicycle_path 8 -setup -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/adc_ecl_eb_reg*/CP]        -to [get_ports rxadc_clk245m_en]
    set_multicycle_path 7 -hold  -start -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/adc_ecl_eb_reg*/CP]        -to [get_ports rxadc_clk245m_en]
    

} else {
    set_false_path -through [get_pins ${CP_SYS_HIER}dbgbus_cpsys_chain_sel]
    set_false_path -through [get_pins ${CP_SYS_HIER}dbgbus_cpsys_data]
    set_false_path -through [get_pins ${CP_SYS_HIER}cp_shutdown_n]
    set_false_path -through [get_pins ${CP_SYS_HIER}cp_shutdown_ack_n]
    set_multicycle_path 8 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_grp_sel_reg*/CP]     -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_grp_sel_reg*/CP]     -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_sub_grp_sel_reg*/CP] -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_sub_grp_sel_reg*/CP] -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/dlink_dst_sel_sw_en_reg*/CP] -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/dlink_dst_sel_sw_en_reg*/CP] -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/dlink_dbg_dst_sw_sel_reg*/CP] -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/dlink_dbg_dst_sw_sel_reg*/CP] -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dac_eb_reg*/CP] -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dac_eb_reg*/CP] -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/frc_on_clk_dac_reg*/CP]  -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/frc_on_clk_dac_reg*/CP]  -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/frc_off_clk_dac_reg*/CP]  -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/frc_off_clk_dac_reg*/CP]  -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 8 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/clk_dac_aux_en_reg*/CP]  -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    set_multicycle_path 7 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/clk_dac_aux_en_reg*/CP]  -th [get_pins ${CP_SYS_HIER}clk_dig_122p88m_en]
    #set_multicycle_path 8 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_grp_sel_reg*/CP]     -th [get_pins ${CP_SYS_HIER}rxadc_clk245m_en]
    #set_multicycle_path 7 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_grp_sel_reg*/CP]     -th [get_pins ${CP_SYS_HIER}rxadc_clk245m_en]
    #set_multicycle_path 8 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_sub_grp_sel_reg*/CP] -th [get_pins ${CP_SYS_HIER}rxadc_clk245m_en]
    #set_multicycle_path 7 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_sub_grp_sel_reg*/CP] -th [get_pins ${CP_SYS_HIER}rxadc_clk245m_en]
    set_multicycle_path 8 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/adc_ecl_eb_reg*/CP]        -th [get_pins ${CP_SYS_HIER}rxadc_clk245m_en]
    set_multicycle_path 7 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/adc_ecl_eb_reg*/CP]        -th [get_pins ${CP_SYS_HIER}rxadc_clk245m_en]
    
    set_multicycle_path 2 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/clk_rf_aux_sel_reg*/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 1 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/clk_rf_aux_sel_reg*/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 2 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_sub_grp_sel_reg*/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 1 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_sub_grp_sel_reg*/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 2 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_grp_sel_reg*/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 1 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_grp_sel_reg*/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 2 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/dlink_src_sel_sw_en_reg/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 1 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/dlink_src_sel_sw_en_reg/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 2 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/dlink_dbg_src_sw_sel_reg*/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 1 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/dlink_dbg_src_sw_sel_reg*/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 2 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/clk_adc_2x_aux_en_reg*/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 1 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_clk_top/u_cp_main_clk_reg/clk_adc_2x_aux_en_reg*/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 2 -setup -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_dbg_eb_reg/CP] -th [get_pins u_rftop/rxadc_clk245m_en]
    set_multicycle_path 1 -hold  -start -th [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/dlink_dbg_eb_reg/CP] -th [get_pins u_rftop/rxadc_clk245m_en]

}



#two port sram constraint 
set mem_lists [get_object_name [get_cells * -hierarchical -filter "(is_memory_cell == true) && (ref_name =~ *RF2*)"]]
foreach mem_list $mem_lists {
    set_disable_timing $mem_list -from CLKA -to CLKB
    set_disable_timing $mem_list -from CLKB -to CLKA
}

#adc chn0 choose posedge 
#adc chn2 choose negedge 
set_case_analysis 0 [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_ckmux2_clk_adc_ilatch_ch0/u_cmind_cell_ckout/cmind_uj_ckcell/S]
set_case_analysis 1 [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_ckmux2_clk_adc_ilatch_ch2/u_cmind_cell_ckout/cmind_uj_ckcell/S]
set_case_analysis 0 [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_ckmux2_clk_adc_qlatch_ch0/u_cmind_cell_ckout/cmind_uj_ckcell/S]
set_case_analysis 1 [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_ckmux2_clk_adc_qlatch_ch2/u_cmind_cell_ckout/cmind_uj_ckcell/S]

#dac clk
set_case_analysis 0 [get_pins ${CP_SYS_CLK_MANUAL_HIER}u_ckmux2_clk_dac/u_cmind_cell_ckout/cmind_uj_ckcell/S]



# mem
set MEM_DBG_CTRL [ list \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_cch_top/u_cch_ram_top                RA1UP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_cch_top/u_cch_ram_top                RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_cch_top/u_cch_rom_top                ROM   \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_ce_top/u_ce_fft_ram_top              RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_ce_top/u_ce_ram_top                  RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_ce_top/u_ce_ram_top                  RF2HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_ce_top/u_ce_rom_top                  ROM   \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_chain_ctrl/u_f_ram_top               RA1UP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_cs_top/u_cs_ram_top                  RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_cs_top/u_cs_ram_top                  RF2HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_cs_top/u_cs_ram_top                  RA1UP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_cs_top/u_cs_ram_top                  RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_cs_top/u_cs_ram_top                  RA1UP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_cs_top/u_cs_rom_top                  ROM   \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_cs_top/u_psram_wbuff_top             RF2HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_chain_ctrl/u_tfc_psram_wbuff_top     RF2HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_chain_ctrl/u_dbg_psram_wbuff_top     RF2HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_dch_top/u_dch_ram_top                RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_dch_top/u_dch_ram_top                RF2HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_dch_top/u_dch_ram_top                RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_dch_top/u_dch_ram_top                RA1UP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_dch_top/u_dch_rom_top                ROM   \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_meas_top/u_meas_ram_top              RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_meas_top/u_meas_ram_top              RA1UP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_meas_top/u_meas_ram_top              RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_meas_top/u_psram_wbuff_top           RF2HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_share_ram/u_share_ram_top            RA1UP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_tfc_top/u_tfc_ram_top                RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_tfc_top/u_tfc_ram_top                RA1UP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_tfc_top/u_tfc_ram_top                RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_rx_top/u_rx_tfc_top/u_tfc_ram_top                RA1UP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_tx_top/u_ul_ram_top                              RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_tx_top/u_ul_ram_top                              RA1UP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_tx_top/u_ul_ram_top                              RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_tx_top/u_ul_ram_top                              RA1UP \
        ${CP_SYS_TOP_HIER}u_cp_ip_modem_top/u_modem_tx_top/u_uni_ft_ram_top                          RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_mem_dfe_ram_top                                                       RF1HP \
        ${CP_SYS_TOP_HIER}u_cp_mem_dfe_ram_top                                                       RF2HP \
        ${CP_SYS_TOP_HIER}u_cp_mem_dlink_dbg                                                         RF2HP \
                 
                 ]


foreach {MEM_HIER TYPE} $MEM_DBG_CTRL {
    if {$TYPE == "RF1HD"} {
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hd_ema_0/cmind_uj_cell/Z]       
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hd_ema_1/cmind_uj_cell/Z]       
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rf1hd_ema_2/cmind_uj_cell/Z]       
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hd_emaw_0/cmind_uj_cell/Z]      
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hd_emaw_1/cmind_uj_cell/Z]      
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hd_emas/cmind_uj_cell/Z]      
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hd_rawl/cmind_uj_cell/Z]      
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hd_rawlm_0/cmind_uj_cell/Z]      
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hd_rawlm_1/cmind_uj_cell/Z]      
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rf1hd_wabl/cmind_uj_cell/Z]      
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rf1hd_wablm_0/cmind_uj_cell/Z]      
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hd_wablm_1/cmind_uj_cell/Z] 
    } elseif {$TYPE == "RF2HP"} {
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rf2hp_emaa_0/cmind_uj_cell/Z]        
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rf2hp_emaa_1/cmind_uj_cell/Z]        
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf2hp_emaa_2/cmind_uj_cell/Z]        
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf2hp_emab_0/cmind_uj_cell/Z]        
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf2hp_emab_1/cmind_uj_cell/Z]        
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rf2hp_emab_2/cmind_uj_cell/Z]        
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf2hp_emasa/cmind_uj_cell/Z]          
    } elseif {$TYPE == "RA1UP"} {
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1up_emas/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1up_emaw_0/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1up_emaw_1/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1up_ema_0/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1up_ema_1/cmind_uj_cell/Z]
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_ra1up_ema_2/cmind_uj_cell/Z]
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_ra1up_rawl/cmind_uj_cell/Z]
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_ra1up_rawlm_0/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1up_rawlm_1/cmind_uj_cell/Z]
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_ra1up_wabl/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1up_wablm_0/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1up_wablm_1/cmind_uj_cell/Z]
    } elseif {$TYPE == "RA1UD"} {
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_ra1ud_ema_0/cmind_uj_cell/Z]       
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_ra1ud_ema_1/cmind_uj_cell/Z]       
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1ud_ema_2/cmind_uj_cell/Z]       
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1ud_emaw_0/cmind_uj_cell/Z]      
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1ud_emaw_1/cmind_uj_cell/Z]      
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1ud_emas/cmind_uj_cell/Z]      
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_ra1ud_rawl/cmind_uj_cell/Z]      
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1ud_rawlm_0/cmind_uj_cell/Z]      
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_ra1ud_rawlm_1/cmind_uj_cell/Z]      
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_ra1ud_wabl/cmind_uj_cell/Z]      
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_ra1ud_wablm_0/cmind_uj_cell/Z]      
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1ud_wablm_1/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_ra1ud_wablm_2/cmind_uj_cell/Z]
    } elseif {$TYPE == "RF1HP"} {
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hp_ema_0/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hp_ema_1/cmind_uj_cell/Z]
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rf1hp_ema_2/cmind_uj_cell/Z]
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rf1hp_emaw_0/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hp_emaw_1/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hp_emas/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hp_rawl/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hp_rawlm_0/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hp_rawlm_1/cmind_uj_cell/Z]
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rf1hp_wabl/cmind_uj_cell/Z]
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rf1hp_wablm_0/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rf1hp_wablm_1/cmind_uj_cell/Z]
    } elseif {$TYPE == "ROM"} {
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rom_rtsel_0/cmind_uj_cell/Z]
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rom_rtsel_1/cmind_uj_cell/Z]
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rom_ptsel_0/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rom_ptsel_1/cmind_uj_cell/Z]
        set_case_analysis 1 [get_pins ${MEM_HIER}/u_rom_trb_0/cmind_uj_cell/Z]
        set_case_analysis 0 [get_pins ${MEM_HIER}/u_rom_trb_1/cmind_uj_cell/Z]
    }
}

