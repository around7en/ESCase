#-----------------------------------------------------------------
#STC example
#need add to STC
#-----------------------------------------------------------------
# wburst resp need arriver later less than 1 M cycle
# resp_ack_sema need sync 1 cycles

set DATACHK_ASYNC_BRG [ list \
                 ]
                 

foreach {mtx_hier CYCLE_CLK_SAHB CYCLE_CLK_MAHB} $DATACHK_ASYNC_BRG {
    set_data_check [expr 0 - 1 * $CYCLE_CLK_MAHB] -from [get_pins ${mtx_hier}/u_slave/u_resp_ack_sync/cmind_sync_buf2?bit2?0??sync2_rst0?sig_in_sync0_reg/cmind_uj_cell/D] -to  [get_pins  ${mtx_hier}/u_slave/wburst_resp_sync_reg/D] -setup

    foreach pointer [get_object_name [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]] {
        foreach payload [get_object_name [get_pins ${mtx_hier}/u_mem/u_cmd_fifo_mem/Q_reg*/D]] {
            set_data_check [expr 0-1*$CYCLE_CLK_MAHB] -from $pointer -to $payload -setup 
        }
    }
    
    foreach pointer [get_object_name [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]] {
        foreach payload [get_object_name [get_pins ${mtx_hier}/u_mem/u_wdata_fifo_mem/Q_reg*/D]] {
            set_data_check [expr 0-1*$CYCLE_CLK_MAHB] -from $pointer -to $payload -setup 
        }
    }
    
    foreach pointer [get_object_name [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]] {
        foreach payload [get_object_name [get_pins ${mtx_hier}/u_mem/u_rdata_fifo_mem/Q_reg*/D]] {
            set_data_check [expr 0-1*$CYCLE_CLK_SAHB] -from $pointer -to $payload -setup 
        }
    }
}

#async FIFO REGFILE
set DATACHK_TOP_ASYNC_FIFO_REGF [ list \
                u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_rtcsys_total   $CYCLE_102M4   $CYCLE_26M \
                u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_top_glb_wdg0   $CYCLE_102M4   $CYCLE_26M \
                u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_top_ttmr0      $CYCLE_102M4   $CYCLE_26M \
            ]

foreach {hier CYCLE_WCLK CYCLE_RCLK} $DATACHK_TOP_ASYNC_FIFO_REGF {

    
    foreach pointer [get_object_name [get_pins ${hier}/u_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D*]] {
        if  {[sizeof_collection [get_pins  -quiet ${hier}/u_mem/Q_reg*/D*]]> 0} {
            foreach payload [get_object_name [get_pins  -quiet ${hier}/u_mem/Q_reg*/D*]] {
                set_data_check [expr 0-1*$CYCLE_RCLK] -from $pointer -to $payload -setup 
            }
        }
    }
}
