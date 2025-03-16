#-----------------------------------------------------------------
#STC example
#need add to STC
#-----------------------------------------------------------------
# wburst resp need arriver later less than 1 cycle
# resp_ack_sema need sync 1 cycles

set DATACHK_CP_ASYNC_BRG [ list \
                    ${CP_SYS_TOP_HIER}u_cp_bus_cp2sysram_eahb_asb   $CYCLE_245M76  $CYCLE_245M76 \
                    ${CP_SYS_TOP_HIER}u_cp_bus_cp2psram_eahb_asb    $CYCLE_245M76  $CYCLE_204M8  \
                 ]


foreach {mtx_hier CYCLE_CLK_SAHB CYCLE_CLK_MAHB} $DATACHK_CP_ASYNC_BRG {
    if {[sizeof_collection [get_pins -quiet ${mtx_hier}/u_slave/wburst_resp_sync_reg/D**]] > 0 } {
        set_data_check [expr 0 - 1 * $CYCLE_CLK_MAHB] -from [get_pins ${mtx_hier}/u_slave/u_resp_ack_sync/cmind_sync_buf2?bit2?0??genblk1_sync2_rst0?sig_in_sync0_reg/cmind_uj_cell/D*] -to  [get_pins  ${mtx_hier}/u_slave/wburst_resp_sync_reg/D*] -setup
    } else {
        echo "SDC_Warning: cannot find specified point! DATACHK_CP_ASYNC_BRG BLK0 ..."
    }

    foreach pointer [get_object_name [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D*]] {
        if  {[sizeof_collection [get_pins  -quiet ${mtx_hier}/u_mem/u_cmd_fifo_mem/Q_reg*/D*]]> 0} {
            foreach payload [get_object_name [get_pins  -quiet ${mtx_hier}/u_mem/u_cmd_fifo_mem/Q_reg*/D*]] {
                set_data_check [expr 0-1*$CYCLE_CLK_MAHB] -from $pointer -to $payload -setup 
            }
        } else {
            echo "SDC_Warning: cannot find specified point! DATACHK_CP_ASYNC_BRG BLK1 ..."
        }
    }
    
    foreach pointer [get_object_name [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D*]] {
        if  {[sizeof_collection [get_pins  -quiet ${mtx_hier}/u_mem/u_wdata_fifo_mem/Q_reg*/D*]]> 0} {
            foreach payload [get_object_name [get_pins  -quiet ${mtx_hier}/u_mem/u_wdata_fifo_mem/Q_reg*/D*]] {
                set_data_check [expr 0-1*$CYCLE_CLK_MAHB] -from $pointer -to $payload -setup 
            }
        } else {
            echo "SDC_Warning: cannot find specified point! DATACHK_CP_ASYNC_BRG BLK2 ..."
        }
    }
    
    foreach pointer [get_object_name [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D*]] {
        if  {[sizeof_collection [get_pins -quiet ${mtx_hier}/u_mem/u_rdata_fifo_mem/Q_reg*/D*]]> 0} {
            foreach payload [get_object_name [get_pins -quiet ${mtx_hier}/u_mem/u_rdata_fifo_mem/Q_reg*/D*]] {
                set_data_check [expr 0-1*$CYCLE_CLK_SAHB] -from $pointer -to $payload -setup 
            }
        } else {
            echo "SDC_Warning: cannot find specified point! DATACHK_CP_ASYNC_BRG BLK3 ..."
        }
    }

}


#async FIFO REGFILE
set DATACHK_CP_ASYNC_FIFO_REGF [ list \
                    ${CP_SYS_TOP_HIER}u_cp_ip_txdfe_top/u_txdfe_resample   $CYCLE_122M88  $CYCLE_122M88 \
                    ${CP_SYS_TOP_HIER}u_cp_ip_adc_top/u_rxdfe_resample     $CYCLE_245M76  $CYCLE_122M88  \
                 ]

foreach {hier CYCLE_WCLK CYCLE_RCLK} $DATACHK_CP_ASYNC_FIFO_REGF {

    
    foreach pointer [get_object_name [get_pins ${hier}/inst_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D*]] {
        if  {[sizeof_collection [get_pins  -quiet ${hier}/inst_ram/Q_reg*/D*]]> 0} {
            foreach payload [get_object_name [get_pins  -quiet ${hier}/inst_ram/Q_reg*/D*]] {
                set_data_check [expr 0-1*$CYCLE_RCLK] -from $pointer -to $payload -setup 
            }
        } else {
            echo "SDC_Warning: cannot find specified point! DATACHK_CP_ASYNC_FIFO_REGF ..."
        }

    }
}

#async FIFO SRAM

foreach pointer [get_object_name [get_pins ${CP_SYS_TOP_HIER}u_cp_ip_dlink_dbg/u_dlink_dbg_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D*]] {
    if  {[sizeof_collection [get_pins  -quiet ${CP_SYS_TOP_HIER}u_cp_mem_dlink_dbg/u_dlink_dbg_ram_top_dlink_dbg_ram_64x32_wrap_0/u_T22ARF2HP64X32K2M2H_0/DB]]> 0} {
        foreach payload [get_object_name [get_pins  -quiet ${CP_SYS_TOP_HIER}u_cp_mem_dlink_dbg/u_dlink_dbg_ram_top_dlink_dbg_ram_64x32_wrap_0/u_T22ARF2HP64X32K2M2H_0/DB]] {
            set_data_check [expr 0-1*$CYCLE_245M76] -from $pointer -to $payload -setup 
        }
    } else {
        echo "SDC_Warning: cannot find specified point! dlink dbg data check ..."
    }

}



















