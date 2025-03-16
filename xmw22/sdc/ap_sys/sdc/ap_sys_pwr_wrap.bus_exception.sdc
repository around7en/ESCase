#-----------------------------------------------------------------
#exception
#-----------------------------------------------------------------
# need add async fifo gray code set_max_delay constraints
# ref in async_fifo IP sdc
# cmd fifo
set AP_ASYNC_BRG [ list \
                    ${AP_SYS_HIER}u_ap_sys_top/u_aptoflash_eahb_async   $CYCLE_204M8   $CYCLE_307M2 \
                    ${AP_SYS_HIER}u_ap_sys_top/u_aptopub_eahb_async     $CYCLE_204M8   $CYCLE_204M8 \
                    ${AP_SYS_HIER}u_ap_sys_top/u_aptosysram_eahb_async  $CYCLE_204M8   $CYCLE_245M76 \
                 ]

foreach {mtx_hier CYCLE_CLK_SAHB CYCLE_CLK_MAHB} $AP_ASYNC_BRG {
set_max_delay [expr 0.8*$CYCLE_CLK_SAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
                                         -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
set_max_delay [expr 0.8*$CYCLE_CLK_MAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
                                         -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]

#wdata fifo
set_max_delay [expr 0.8*$CYCLE_CLK_SAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
                                         -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
set_max_delay [expr 0.8*$CYCLE_CLK_MAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
                                         -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]

#rdata fifo
set_max_delay [expr 0.8*$CYCLE_CLK_MAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
                                         -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
set_max_delay [expr 0.8*$CYCLE_CLK_SAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
                                         -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
}
