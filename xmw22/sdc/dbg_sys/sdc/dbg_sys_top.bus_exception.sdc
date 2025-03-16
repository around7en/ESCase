#-----------------------------------------------------------------
#exception
#-----------------------------------------------------------------
# need add async fifo gray code set_max_delay constraints
# ref in async_fifo IP sdc
# cmd fifo

set DBG_ASYNC_BRG [ list \
                    ${DBG_SYS_HIER}u_tlb_ahb_async     $CYCLE_51M2   $CYCLE_100M \
                 ]

foreach {mtx_hier CYCLE_CLK_SAHB CYCLE_CLK_MAHB} $DBG_ASYNC_BRG {
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
