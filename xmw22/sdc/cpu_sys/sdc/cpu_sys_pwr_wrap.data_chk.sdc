#-----------------------------------------------------------------
#STC example
#need add to STC
#-----------------------------------------------------------------
# wburst resp need arriver later less than 1 M cycle
# resp_ack_sema need sync 1 cycles

set DATACHK_CPU_ASYNC_BRG [ list \
                    ${CPU_SYS_TOP_HIER}u_ap2cpu_ahb_async       $CYCLE_204M8   $CYCLE_491M52 \
                    ${CPU_SYS_TOP_HIER}u_cp2cpu_ahb_async       $CYCLE_245M76  $CYCLE_491M52 \
                    ${CPU_SYS_TOP_HIER}u_cpu2sysram_ahb_async   $CYCLE_491M52  $CYCLE_245M76 \
                    ${CPU_SYS_TOP_HIER}u_cpu2pram_ahb_async     $CYCLE_491M52  $CYCLE_204M8 \
                    ${CPU_SYS_TOP_HIER}u_cpu2flash_ahb_async    $CYCLE_491M52  $CYCLE_307M2 \
                 ]
                 

foreach {mtx_hier CYCLE_CLK_SAHB CYCLE_CLK_MAHB} $DATACHK_CPU_ASYNC_BRG {
    set_data_check [expr 0 - 1 * $CYCLE_CLK_MAHB] -from [get_pins ${mtx_hier}/u_slave/u_resp_ack_sync/cmind_sync_buf2?bit2?0??genblk1_sync2_rst0?sig_in_sync0_reg/cmind_uj_cell/D] -to  [get_pins  ${mtx_hier}/u_slave/wburst_resp_sync_reg/D] -setup

    foreach pointer [get_object_name [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]] {
        foreach payload [get_object_name [get_pins ${mtx_hier}/u_mem/u_cmd_fifo_mem/Q_reg*/D*]] {
            set_data_check [expr 0-1*$CYCLE_CLK_MAHB] -from $pointer -to $payload -setup 
        }
    }
    
    foreach pointer [get_object_name [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]] {
        foreach payload [get_object_name [get_pins ${mtx_hier}/u_mem/u_wdata_fifo_mem/Q_reg*/D*]] {
            set_data_check [expr 0-1*$CYCLE_CLK_MAHB] -from $pointer -to $payload -setup 
        }
    }
    
    foreach pointer [get_object_name [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]] {
        foreach payload [get_object_name [get_pins ${mtx_hier}/u_mem/u_rdata_fifo_mem/Q_reg*/D*]] {
            set_data_check [expr 0-1*$CYCLE_CLK_SAHB] -from $pointer -to $payload -setup 
        }
    }
}

