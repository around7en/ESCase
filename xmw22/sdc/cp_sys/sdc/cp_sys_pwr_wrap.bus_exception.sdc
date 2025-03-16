#-----------------------------------------------------------------
#exception
#-----------------------------------------------------------------
# need add async fifo gray code set_max_delay constraints
# ref in async_fifo IP sdc
# cmd fifo

# ======================================
# delete reason:
# max delay will break up the Q->D path, although not all Q->D paths are async in FIFO design
# So, use data check to replace max delay constraints
# ======================================



# set CP_ASYNC_BRG [ list \
#                     ${CP_SYS_TOP_HIER}u_cp_bus_cp2psram_eahb_asb   $CYCLE_245M76  $CYCLE_245M76 \
#                     ${CP_SYS_TOP_HIER}u_cp_bus_cp2sysram_eahb_asb    $CYCLE_245M76  $CYCLE_204M8  \
#                     
#                  ]
# 
# foreach {mtx_hier CYCLE_CLK_SAHB CYCLE_CLK_MAHB} $CP_ASYNC_BRG {
# set_max_delay [expr 0.8*$CYCLE_CLK_SAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                          -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
# set_max_delay [expr 0.8*$CYCLE_CLK_MAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                          -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
# 
# #wdata fifo
# set_max_delay [expr 0.8*$CYCLE_CLK_SAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                          -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
# set_max_delay [expr 0.8*$CYCLE_CLK_MAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                          -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
# 
# #rdata fifo
# set_max_delay [expr 0.8*$CYCLE_CLK_MAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                          -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
# set_max_delay [expr 0.8*$CYCLE_CLK_SAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                          -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
# }
# 
# #async FIFO
# set CP_ASYNC_FIFO [ list \
#                     ${CP_SYS_TOP_HIER}u_cp_ip_txdfe_top/u_txdfe_resample/inst_fifo   $CYCLE_122M88  $CYCLE_122M88 \
#                     ${CP_SYS_TOP_HIER}u_cp_ip_adc_top/u_rxdfe_resample/inst_fifo     $CYCLE_245M76  $CYCLE_122M88  \
#                     ${CP_SYS_TOP_HIER}u_cp_ip_dlink_dbg/u_dlink_dbg_async_fifo     $CYCLE_245M76  $CYCLE_245M76  \
#                  ]
# 
# foreach {hier CYCLE_WCLK CYCLE_RCLK} $CP_ASYNC_FIFO {
# set_max_delay [expr 0.8*$CYCLE_WCLK] -from [get_pins ${hier}/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                      -to   [get_pins ${hier}/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
# set_max_delay [expr 0.8*$CYCLE_RCLK] -from [get_pins ${hier}/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                      -to   [get_pins ${hier}/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
# }

set_multicycle_path 2 -setup -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/cp2psram_eb_reg/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_main_mtx/u_ahb_anti_hang_s1/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 1 -hold -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/cp2psram_eb_reg/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_main_mtx/u_ahb_anti_hang_s1/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 2 -setup -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/cp2sysram_eb_reg/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_main_mtx/u_ahb_anti_hang_s2/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 1 -hold -from [get_pins ${CP_SYS_TOP_HIER}u_cp_regf_main_glb/cp2sysram_eb_reg/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_main_mtx/u_ahb_anti_hang_s2/GEN_EB_SYNC_u_s_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]

set_multicycle_path 2 -setup -from [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_top2modem_ahb_asb/u_resp/q_q_reg_0_/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_pmu/u_cp_mtx_ahb_lpc/GEN_AHB_IDLE_SYNC_u_ahb_idle_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
set_multicycle_path 1 -hold -from [get_pins ${CP_SYS_TOP_HIER}u_cp_bus_top2modem_ahb_asb/u_resp/q_q_reg_0_/CP] -to [get_pins ${CP_SYS_TOP_HIER}u_cp_sys_pmu/u_cp_mtx_ahb_lpc/GEN_AHB_IDLE_SYNC_u_ahb_idle_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst1_sig_in_sync0_reg/cmind_uj_cell/D]
