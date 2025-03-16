###########################################################################################
#for debugbus
if {! $IS_CHIP} {
    set_false_path -from [get_ports dbgbus_chain_sel]
    set_false_path -to   [get_ports dbgbus_cpusys_data]
    set_false_path -from [get_ports cpusys_shutdown_n]
    set_false_path -from [get_ports cpusys_ram_slp_n]
    set_false_path -from [get_ports cpusys_ram_dslp_n]
    set_false_path -from [get_ports cpusys_ram_sd]
    set_false_path -from [get_ports cpusys_rom_slp]
    set_false_path -to   [get_ports cpusys_ram_sd_ack]
    set_false_path -to   [get_ports cpusys_shutdown_ack_n]
    set_false_path -from [get_ports CFGNSSTCALIB  ]
    set_false_path -from [get_ports CFGFPU        ]
    set_false_path -from [get_ports CFGDSP        ]
    set_false_path -from [get_ports CFGSECEXT     ]
    set_false_path -from [get_ports MPUNSDISABLE  ]
    set_false_path -from [get_ports MPUSDISABLE   ]
    set_false_path -from [get_ports SAUDISABLE    ]
    set_false_path -from [get_ports CFGITCMSZ     ]
    set_false_path -from [get_ports CFGDTCMSZ     ]
    set_false_path -from [get_ports CFGMEMALIAS   ]
    set_false_path -from [get_ports CFGNOCDECP    ]
    set_false_path -from [get_ports INITTCMEN     ]
    set_false_path -from [get_ports INITL1RSTDIS  ]
    set_false_path -from [get_ports LOCKITGU      ]
    set_false_path -from [get_ports LOCKDTGU      ]
    set_false_path -from [get_ports LOCKTCM       ]
    set_false_path -from [get_ports dbg_hready_cpu]
    set_false_path -from [get_ports INITNSVTOR    ]
} else {
    set_false_path -through [get_pins ${CPU_SYS_HIER}dbgbus_chain_sel]
    set_false_path -through [get_pins ${CPU_SYS_HIER}dbgbus_cpusys_data]
    set_false_path -through [get_pins ${CPU_SYS_HIER}cpusys_shutdown_n]
    set_false_path -through [get_pins ${CPU_SYS_HIER}cpusys_ram_slp_n]
    set_false_path -through [get_pins ${CPU_SYS_HIER}cpusys_ram_dslp_n]
    set_false_path -through [get_pins ${CPU_SYS_HIER}cpusys_ram_sd]
    set_false_path -through [get_pins ${CPU_SYS_HIER}cpusys_rom_slp]
    set_false_path -through [get_pins ${CPU_SYS_HIER}cpusys_ram_sd_ack]
    set_false_path -through [get_pins ${CPU_SYS_HIER}cpusys_shutdown_ack_n]
    set_false_path -through [get_pins ${CPU_SYS_HIER}CFGNSSTCALIB  ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}CFGFPU        ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}CFGDSP        ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}CFGSECEXT     ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}MPUNSDISABLE  ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}MPUSDISABLE   ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}SAUDISABLE    ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}CFGITCMSZ     ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}CFGDTCMSZ     ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}CFGMEMALIAS   ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}CFGNOCDECP    ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}INITTCMEN     ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}INITL1RSTDIS  ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}LOCKITGU      ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}LOCKDTGU      ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}LOCKTCM       ]
    set_false_path -through [get_pins ${CPU_SYS_HIER}dbg_hready_cpu]
    set_false_path -through [get_pins ${CPU_SYS_HIER}INITNSVTOR]
}

#set_clock_sense -stop_propagation [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_dbgbus/*u_*cka/cmind_uj_ckcell/A1]
set_sense -stop_propagation [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_dbgbus/*u_*cka/cmind_uj_ckcell/A1]

###########################################################################################
#for dap
set_max_delay [expr 2*$CYCLE_491M52] -from [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_stardap/u_dap_top/u_dap_dp/u_dap_dp_cdc/gen_reg_dp_data*u_reg_dp_data/gen_non_rar*u_cmind_cell_sdf/cmind_uj_cell/Q]
set_max_delay [expr 2*$CYCLE_491M52] -from [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_stardap/u_dap_top/u_dap_dp/u_dap_dp_cdc/gen_reg_dp_regaddr*u_reg_dp_regaddr/gen_non_rar*u_cmind_cell_sdf/cmind_uj_cell/Q]
set_max_delay [expr 2*$CYCLE_491M52] -from [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_stardap/u_dap_top/u_dap_dp/u_dap_dp_cdc/u_reg_dp_rnw/gen_non_rar*u_cmind_cell_sdf/cmind_uj_cell/Q]
set_max_delay [expr 2*$CYCLE_26M] -from [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_stardap/u_dap_top/u_dap_ap/u_dap_ap_cdc/gen_reg_ap_data*u_reg_ap_data/gen_non_rar*u_cmind_cell_sdf/cmind_uj_cell/Q]
set_max_delay [expr 2*$CYCLE_26M] -from [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_stardap/u_dap_top/u_dap_ap/u_dap_ap_cdc/u_reg_ap_err/gen_non_rar*u_cmind_cell_sdf/cmind_uj_cell/Q]

#add to special check table
#set_max_delay [expr 2*$CYCLE_491M52] -from [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_stardap/u_dap_top/u_dap_dp/u_dap_dp_cdc/u_reg_dp_req_dp/u_cmind_cell_sdfcn/cmind_uj_cell/Q] \
#                                      -to [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_stardap/u_dap_top/u_dap_ap/u_dap_ap_cdc/u_dp_req_sync/u_cmind_sig_sync/cmind_sync_buf2_genblk1_0__cmind_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
#
#set_max_delay [expr 2*$CYCLE_491M52] -from [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_stardap/u_dap_top/u_dap_ap/u_dap_ap_cdc/u_reg_ap_ack/u_cmind_cell_sdfcn/cmind_uj_cell/Q] \
#                                     -to [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_stardap/u_dap_top/u_dap_dp/u_dap_dp_cdc/u_ap_ack_sync/u_cmind_sig_sync/cmind_sync_buf2_genblk1_0__cmind_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 2 -setup -from  $name_clk_cpu_arm -to [get_pins ${CPU_SYS_TOP_HIER}u_cpusys_irom_top/u_cpusys_irom_top_cpusys_irom_12800x32_wrap_0/u_T22TROM12800X32K1M16MSPCPUSYSIROM_0/CEB]
set_multicycle_path 1 -hold  -from  $name_clk_cpu_arm -to [get_pins ${CPU_SYS_TOP_HIER}u_cpusys_irom_top/u_cpusys_irom_top_cpusys_irom_12800x32_wrap_0/u_T22TROM12800X32K1M16MSPCPUSYSIROM_0/CEB]
set_multicycle_path 2 -setup -from  $name_clk_cpu_arm -to [get_pins ${CPU_SYS_TOP_HIER}u_cpusys_irom_top/u_cpusys_irom_top_cpusys_irom_12800x32_wrap_0/u_T22TROM12800X32K1M16MSPCPUSYSIROM_0/A*]
set_multicycle_path 1 -hold  -from  $name_clk_cpu_arm -to [get_pins ${CPU_SYS_TOP_HIER}u_cpusys_irom_top/u_cpusys_irom_top_cpusys_irom_12800x32_wrap_0/u_T22TROM12800X32K1M16MSPCPUSYSIROM_0/A*]

set_multicycle_path 2 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpusys_irom_top/u_cpusys_irom_top_cpusys_irom_12800x32_wrap_0/u_T22TROM12800X32K1M16MSPCPUSYSIROM_0/CLK] -to $name_clk_cpu_arm 
set_multicycle_path 1 -hold  -from [get_pins ${CPU_SYS_TOP_HIER}u_cpusys_irom_top/u_cpusys_irom_top_cpusys_irom_12800x32_wrap_0/u_T22TROM12800X32K1M16MSPCPUSYSIROM_0/CLK] -to $name_clk_cpu_arm
###########################################################################################
#for anti-hang signal
set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_on_clk_pub_ahb_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s5/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 2 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_on_clk_pub_ahb_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s5/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_on_clk_flash_ahb_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s6/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 2 -hold  -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_on_clk_flash_ahb_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s6/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_off_clk_pub_ahb_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s5/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 2 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_off_clk_pub_ahb_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s5/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_off_clk_flash_ahb_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s6/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 2 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_off_clk_flash_ahb_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s6/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_on_clk_top_ahb_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 2 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_on_clk_top_ahb_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_off_clk_top_ahb_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 2 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_off_clk_top_ahb_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_on_clk_sys_ram_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s4/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 2 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_on_clk_sys_ram_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s4/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 2 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_off_clk_sys_ram_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s4/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 1 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_reg/frc_off_clk_sys_ram_scan_reg/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s4/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]


set_multicycle_path 2 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_top2cpu_ahb_async/u_resp/q_q_reg_0_/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_mtx_lpc/GEN_AHB_IDLE_SYNC_u_ahb_idle_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 1 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_top2cpu_ahb_async/u_resp/q_q_reg_0_/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_mtx_lpc/GEN_AHB_IDLE_SYNC_u_ahb_idle_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_top2cpu_ahb_async/u_resp/q_q_reg_0_/CP]  -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]  
set_multicycle_path 2 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_top2cpu_ahb_async/u_resp/q_q_reg_0_/CP]  -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

#set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_23_20_/CP]  -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#set_multicycle_path 2 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_23_20_/CP]  -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#
#set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_31_28_/CP]  -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#set_multicycle_path 2 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_31_28_/CP]  -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#
#set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_19_16_/CP]  -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#set_multicycle_path 2 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_19_16_/CP]  -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#
#set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_27_24_/CP]  -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#set_multicycle_path 2 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_27_24_/CP]  -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#
#set_multicycle_path 2 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_19_16_/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#set_multicycle_path 1 -hold -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_19_16_/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#
#set_multicycle_path 2 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_27_24_/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#set_multicycle_path 1 -hold  -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_27_24_/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#
#set_multicycle_path 2 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_23_20_/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
#set_multicycle_path 1 -hold  -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg_23_20_/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 3 -setup -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg*/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 2 -hold  -from [get_pins ${CPU_SYS_TOP_HIER}u_cpu2top_ahb_async/u_haddr/q_q_reg*/CP] -to [get_pins ${CPU_SYS_TOP_HIER}u_cpu_main_mtx_lite_wrap/u_ahb_anti_hang_s3/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
###########################################################################################
##for QSPI
##QSPI_SCK is div 6 from clk_arm_mux, but QSPI can set to ddr mode
#set_multicycle_path 3 -setup -start -from [get_clocks ${CPU_SYS_NAME}_clk_arm_mux] -to [get_clocks ${CPU_SYS_NAME}_QSPI_SCK]
#set_multicycle_path 2 -hold -start -from [get_clocks ${CPU_SYS_NAME}_clk_arm_mux] -to [get_clocks ${CPU_SYS_NAME}_QSPI_SCK]
#
#set_multicycle_path 3 -setup -end -from [get_clocks ${CPU_SYS_NAME}_QSPI_SCK] -to [get_clocks ${CPU_SYS_NAME}_clk_arm_mux]
#set_multicycle_path 2 -hold -end -from [get_clocks ${CPU_SYS_NAME}_QSPI_SCK] -to [get_clocks ${CPU_SYS_NAME}_clk_arm_mux]
#
#if { $IS_CHIP} {
#
#set_multicycle_path 3 -setup -start -from [get_clocks ${CPU_SYS_NAME}_clk_arm_mux] -to [get_clocks ${CPU_SYS_NAME}_QSPI_SCK_PAD]
#set_multicycle_path 2 -hold -start -from [get_clocks ${CPU_SYS_NAME}_clk_arm_mux] -to [get_clocks ${CPU_SYS_NAME}_QSPI_SCK_PAD]
#
#set_multicycle_path 3 -setup -end -from [get_clocks ${CPU_SYS_NAME}_QSPI_SCK_PAD] -to [get_clocks ${CPU_SYS_NAME}_clk_arm_mux]
#set_multicycle_path 2 -hold -end -from [get_clocks ${CPU_SYS_NAME}_QSPI_SCK_PAD] -to [get_clocks ${CPU_SYS_NAME}_clk_arm_mux]
#}
###########################################################################################
#
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_rf1hp_ema_0/cmind_uj_cell/Z]       
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_rf1hp_ema_1/cmind_uj_cell/Z]       
set_case_analysis 1 [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_rf1hp_ema_2/cmind_uj_cell/Z]       
set_case_analysis 1 [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_rf1hp_emaw_0/cmind_uj_cell/Z]      
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_rf1hp_emaw_1/cmind_uj_cell/Z]      
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_rf1hp_emas/cmind_uj_cell/Z]        
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_rf1hp_rawl/cmind_uj_cell/Z]        
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_rf1hp_rawlm_0/cmind_uj_cell/Z]     
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_rf1hp_rawlm_1/cmind_uj_cell/Z]     
set_case_analysis 1 [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_rf1hp_wabl/cmind_uj_cell/Z]        
set_case_analysis 1 [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_rf1hp_wablm_0/cmind_uj_cell/Z]     
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_rf1hp_wablm_1/cmind_uj_cell/Z]     
#
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_STAR/gen_rams?u_pd_rams/u_cpusys_cacheram_top/u_rf1hp_ema_0/cmind_uj_cell/Z]         
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_STAR/gen_rams?u_pd_rams/u_cpusys_cacheram_top/u_rf1hp_ema_1/cmind_uj_cell/Z]         
set_case_analysis 1 [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_STAR/gen_rams?u_pd_rams/u_cpusys_cacheram_top/u_rf1hp_ema_2/cmind_uj_cell/Z]         
set_case_analysis 1 [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_STAR/gen_rams?u_pd_rams/u_cpusys_cacheram_top/u_rf1hp_emaw_0/cmind_uj_cell/Z]        
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_STAR/gen_rams?u_pd_rams/u_cpusys_cacheram_top/u_rf1hp_emaw_1/cmind_uj_cell/Z]        
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_STAR/gen_rams?u_pd_rams/u_cpusys_cacheram_top/u_rf1hp_emas/cmind_uj_cell/Z]          
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_STAR/gen_rams?u_pd_rams/u_cpusys_cacheram_top/u_rf1hp_rawl/cmind_uj_cell/Z]          
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_STAR/gen_rams?u_pd_rams/u_cpusys_cacheram_top/u_rf1hp_rawlm_0/cmind_uj_cell/Z]       
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_STAR/gen_rams?u_pd_rams/u_cpusys_cacheram_top/u_rf1hp_rawlm_1/cmind_uj_cell/Z]       
set_case_analysis 1 [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_STAR/gen_rams?u_pd_rams/u_cpusys_cacheram_top/u_rf1hp_wabl/cmind_uj_cell/Z]          
set_case_analysis 1 [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_STAR/gen_rams?u_pd_rams/u_cpusys_cacheram_top/u_rf1hp_wablm_0/cmind_uj_cell/Z]       
set_case_analysis 0 [get_pins ${CPU_SYS_TOP_HIER}u_starmcu/u_STAR/gen_rams?u_pd_rams/u_cpusys_cacheram_top/u_rf1hp_wablm_1/cmind_uj_cell/Z]       
