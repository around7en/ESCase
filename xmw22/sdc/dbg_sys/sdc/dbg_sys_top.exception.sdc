set_sense -stop_propagation [get_pins ${DBG_SYS_HIER}u_dbgsys_dbg_bus/u_clk_*_ckmux2/cmind_uj_ckcell/I0]
set_false_path -th [get_pins ${DBG_SYS_HIER}u_dbgsys_dbg_bus/data_bit*u_cmind_cell_buf/cmind_uj_cell/Z]
set_false_path -th [get_pins ${DBG_SYS_HIER}data_bit*u_cmind_cell_buf/cmind_uj_cell/Z]

#set_false_path -to ${DBG_SYS_HIER}u_tlb2ahb_top/tlb_wdat_buf_neg_reg*
#set_false_path -to ${DBG_SYS_HIER}u_tlb2ahb_top/tlb_cs_n_buf_neg_reg
set_max_delay [expr 2*$CYCLE_26M] -from [get_pins ${DBG_SYS_HIER}u_star_dap/u_dap_top/u_dap_dp/u_dap_dp_cdc/gen_reg_dp_data*u_reg_dp_data/gen_non_rar*u_cmind_cell_sdf/cmind_uj_cell/Q]
set_max_delay [expr 2*$CYCLE_26M] -from [get_pins ${DBG_SYS_HIER}u_star_dap/u_dap_top/u_dap_dp/u_dap_dp_cdc/gen_reg_dp_regaddr*u_reg_dp_regaddr/gen_non_rar*u_cmind_cell_sdf/cmind_uj_cell/Q]
set_max_delay [expr 2*$CYCLE_26M] -from [get_pins ${DBG_SYS_HIER}u_star_dap/u_dap_top/u_dap_dp/u_dap_dp_cdc/u_reg_dp_rnw/gen_non_rar*u_cmind_cell_sdf/cmind_uj_cell/Q]
set_max_delay [expr 2*$CYCLE_26M] -from [get_pins ${DBG_SYS_HIER}u_star_dap/u_dap_top/u_dap_ap/u_dap_ap_cdc/gen_reg_ap_data*u_reg_ap_data/gen_non_rar*u_cmind_cell_sdf/cmind_uj_cell/Q]
set_max_delay [expr 2*$CYCLE_26M] -from [get_pins ${DBG_SYS_HIER}u_star_dap/u_dap_top/u_dap_ap/u_dap_ap_cdc/u_reg_ap_err/gen_non_rar*u_cmind_cell_sdf/cmind_uj_cell/Q]

