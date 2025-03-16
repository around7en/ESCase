set CPU_SYS_HIER    u_digital_top/u_cpu_sys_pwr_wrap/
set AP_SYS_HIER     u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/
set CP_SYS_TOP_HIER u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/
set DBG_SYS_HIER    u_digital_top/u_dbg_sys_top/
set PUB_SYS_HIER    u_digital_top/u_pub_sys_pwr_wrap/

set SKEW_CHK      0.4

set ALL_ASYNC_BRG [ list \
                ap2cpu_ahb_async          ${CPU_SYS_HIER}u_cpu_sys_top/u_ap2cpu_ahb_async       $CYCLE_204M8   $CYCLE_491M52 \
                cp2cpu_ahb_async          ${CPU_SYS_HIER}u_cpu_sys_top/u_cp2cpu_ahb_async       $CYCLE_245M76  $CYCLE_491M52 \
                cpu2sysram_ahb_async      ${CPU_SYS_HIER}u_cpu_sys_top/u_cpu2sysram_ahb_async   $CYCLE_491M52  $CYCLE_245M76 \
                cpu2pram_ahb_async        ${CPU_SYS_HIER}u_cpu_sys_top/u_cpu2pram_ahb_async     $CYCLE_491M52  $CYCLE_204M8 \
                cpu2flash_ahb_async       ${CPU_SYS_HIER}u_cpu_sys_top/u_cpu2flash_ahb_async    $CYCLE_491M52  $CYCLE_307M2 \
                aptoflash_eahb_async      ${AP_SYS_HIER}u_aptoflash_eahb_async                  $CYCLE_204M8   $CYCLE_307M2 \
                aptopub_eahb_async        ${AP_SYS_HIER}u_aptopub_eahb_async                    $CYCLE_204M8   $CYCLE_204M8 \
                ptosysram_eahb_async      ${AP_SYS_HIER}u_aptosysram_eahb_async                 $CYCLE_204M8   $CYCLE_245M76 \
                cp2sysram_eahb_async      ${CP_SYS_TOP_HIER}u_cp_bus_cp2sysram_eahb_asb         $CYCLE_245M76  $CYCLE_245M76 \
                cp2psram_eahb_async       ${CP_SYS_TOP_HIER}u_cp_bus_cp2psram_eahb_asb          $CYCLE_245M76  $CYCLE_204M8  \
                 ]

set all_async_brg_list [list ]
foreach {group mtx_hier CYCLE_CLK_SAHB CYCLE_CLK_MAHB} $ALL_ASYNC_BRG {
#set_max_delay [expr 0.8*$CYCLE_CLK_SAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                         -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
       
     set tmp_l [list ${group}_cmdfifo_waddr_latency  [expr 1.5*$CYCLE_CLK_SAHB]  ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP  ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D None None ]
     set all_async_brg_list [concat $all_async_brg_list $tmp_l]
     tproc_stc_latency_report $tmp_l
     set tmp_l [list ${group}_cmdfifo_waddr_skew  $SKEW_CHK  ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP  ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D None None ]
     tproc_stc_skew_report $tmp_l

     set tmp_l [list ${group}_cmdfifo_raddr_latency  [expr 1.5*$CYCLE_CLK_MAHB] ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP  ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D  None None ]
     set all_async_brg_list [concat $all_async_brg_list $tmp_l]
     tproc_stc_latency_report $tmp_l
     set tmp_l [list ${group}_cmdfifo_raddr_skew  $SKEW_CHK ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP  ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D  None None ]
     tproc_stc_skew_report $tmp_l

     set tmp_l [list ${group}_wdatafifo_raddr_latency  [expr 1.5*$CYCLE_CLK_MAHB] ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP  ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D None None ]
     set all_async_brg_list [concat $all_async_brg_list $tmp_l]
     tproc_stc_latency_report $tmp_l
     set tmp_l [list ${group}_wdatafifo_raddr_skew  $SKEW_CHK ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP  ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D None None ]
     tproc_stc_skew_report $tmp_l
     
     set tmp_l [list ${group}_wdatafifo_waddr_latency  [expr 1.5*$CYCLE_CLK_SAHB]     ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP      ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D    None None ]                               
     set all_async_brg_list [concat $all_async_brg_list $tmp_l]
     tproc_stc_latency_report $tmp_l
     set tmp_l [list ${group}_wdatafifo_waddr_skew  $SKEW_CHK     ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP      ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D    None None ]                               
     tproc_stc_skew_report $tmp_l
     
     set tmp_l [list ${group}_rdatafifo_waddr_latency  [expr 1.5*$CYCLE_CLK_MAHB]  ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D  None None ]    
     set all_async_brg_list [concat $all_async_brg_list $tmp_l]
     tproc_stc_latency_report $tmp_l
     set tmp_l [list ${group}_rdatafifo_waddr_skew  $SKEW_CHK  ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D  None None ]    
     tproc_stc_skew_report $tmp_l
     
     set tmp_l [list ${group}_rdatafifo_raddr_latency  [expr 1.5*$CYCLE_CLK_SAHB] ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP  ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D  None None ]
     set all_async_brg_list [concat $all_async_brg_list $tmp_l]
     tproc_stc_latency_report $tmp_l
     set tmp_l [list ${group}_rdatafifo_raddr_skew  $SKEW_CHK ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP  ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D  None None ]
     tproc_stc_skew_report $tmp_l


}


#set_max_delay [expr 0.8*$CYCLE_CLK_MAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                         -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_cmd_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
 #wdata fifo
#set_max_delay [expr 0.8*$CYCLE_CLK_SAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                         -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]

                                          
                                         
#set_max_delay [expr 0.8*$CYCLE_CLK_MAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                         -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_wdata_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
#rdata fifo
#set_max_delay [expr 0.8*$CYCLE_CLK_MAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                         -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
#set_max_delay [expr 0.8*$CYCLE_CLK_SAHB] -from [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/Q] \
#                                         -to   [get_pins ${mtx_hier}/u_buffer_ctrl/u_rdata_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D]
#}
# tproc_stc_latency_report $all_async_brg_list


set ALL_ASYNC_FIFO [ list \
                txdfe_afifo               ${CP_SYS_TOP_HIER}u_cp_ip_txdfe_top/u_txdfe_resample/inst_fifo                  $CYCLE_122M88  $CYCLE_122M88 \
                rxdfe_afifo               ${CP_SYS_TOP_HIER}u_cp_ip_adc_top/u_rxdfe_resample/inst_fifo                    $CYCLE_245M76  $CYCLE_122M88 \
                dlink_afifo               ${CP_SYS_TOP_HIER}u_cp_ip_dlink_dbg/u_dlink_dbg_async_fifo                      $CYCLE_245M76  $CYCLE_245M76 \
                apb2apb_async_rtcsys      u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_rtcsys_total/u_async_fifo   $CYCLE_102M4   $CYCLE_26M \
                apb2apb_async_glb_wdg0    u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_top_glb_wdg0/u_async_fifo   $CYCLE_102M4   $CYCLE_26M \
                apb2apb_async_glb_ttmr0   u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_top_ttmr0/u_async_fifo      $CYCLE_102M4   $CYCLE_26M \
                 ]
set all_async_fifo_list [list ]
foreach {group hier CYCLE_WCLK CYCLE_RCLK} $ALL_ASYNC_FIFO {

     set tmp_l [list ${group}_waddr_latency  [expr 1.5*$CYCLE_WCLK]  ${hier}/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP  ${hier}/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D None None ]
     set all_async_fifo_list [concat $all_async_fifo_list $tmp_l]
     tproc_stc_latency_report $tmp_l
     set tmp_l [list ${group}_waddr_skew  $SKEW_CHK  ${hier}/u_write_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP  ${hier}/u_read_ctrl/u_waddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D None None ]
     tproc_stc_skew_report $tmp_l

     set tmp_l [list ${group}_raddr_latency  [expr 1.5*$CYCLE_RCLK] ${hier}/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP  ${hier}/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D  None None ]
     set all_async_fifo_list [concat $all_async_fifo_list $tmp_l]
     tproc_stc_latency_report $tmp_l
     set tmp_l [list ${group}_raddr_skew  $SKEW_CHK ${hier}/u_read_ctrl/gray_bit*u_cell_dfcn/cmind_uj_cell/CP  ${hier}/u_write_ctrl/u_raddr_gray_sync/cmind_sync*sig_in_sync0_reg/cmind_uj_cell/D  None None ]
     tproc_stc_skew_report $tmp_l

}
