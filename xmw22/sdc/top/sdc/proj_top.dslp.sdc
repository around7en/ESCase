#-----------------------------------------------------------------
#common func
#-----------------------------------------------------------------
#-----------------------------------------------------------------
#var
#-----------------------------------------------------------------
#global var
if {![info exist PROJ_DIR]} {
    set PROJ_DIR $env(PROJ_DIR)
}
set IS_CHIP 1
if {![info exist IS_FLAT]} {
    if {[info exist env(IS_FLAT)]} {
        set IS_FLAT $env(IS_FLAT)
    } else {
        set IS_FLAT 0
    }
}
if {![info exist VDD_AON]} {
    if {[info exist env(VDD_AON)]} {
        set VDD_AON $env(VDD_AON)
    } else {
        set VDD_AON 0.7
    }
}

source $PROJ_DIR/de/common/sdc/clk_period.sdc

set CPU_SYS_NAME cpu_sys
set CPU_SYS_HIER "u_digital_top/u_cpu_sys_pwr_wrap/"
set AP_SYS_NAME ap_sys
set AP_SYS_HIER "u_digital_top/u_ap_sys_pwr_wrap/"
set AON_SYS_NAME aon_sys
set AON_SYS_HIER "u_digital_top/u_aon_sys_pwr_wrap/"
set RTC_SYS_NAME rtc_sys
set RTC_SYS_HIER "u_digital_top/u_xmw_rtc_pwr_wrap/"
set DBG_SYS_NAME dbg_sys
set DBG_SYS_HIER "u_digital_top/u_dbg_sys_top/"
set CP_SYS_NAME cp_sys
set CP_SYS_HIER "u_digital_top/u_cp_sys_pwr_wrap/"
set PUB_SYS_NAME pub_sys
set PUB_SYS_HIER "u_digital_top/u_pub_sys_pwr_wrap/"
set PSRAM_CTRL_HIER "${PUB_SYS_HIER}u_pub_sys_top/u_psram_ctrl"

#-----------------------------------------------------------------
#virtual clock
#-----------------------------------------------------------------
create_clock -name vclk            -period $CYCLE_26M
lappend CLOCK_GROUP(vclk) vclk

#-----------------------------------------------------------------
#clock from/to pad
#-----------------------------------------------------------------
set IO_TOP_HIER u_digital_top/u_io_top
source $PROJ_DIR/de/top/sdc/io_top.var.sdc

#-----------------------------------------------------------------
#clock source
#-----------------------------------------------------------------
#   group                        name                           cycle                hier
set clk_src_msgs "
    clk_rc32k_anlg               clk_rc32k_anlg                 $CYCLE_32K           u_analog_top/rc32k_clk
    clk_xo32k_anlg               clk_xo32k_anlg                 $CYCLE_32K           u_analog_top/xo32k_clk
    clk_rtc32k_anlg              clk_rtc32k_anlg                $CYCLE_32K           u_analog_top/rtc32k_clk
"

foreach {group name cycle hier} $clk_src_msgs {
    create_clock -name $name -period $cycle -add [get_pins $hier]
    lappend CLOCK_GROUP($group) $name
    set name_$name $name
    set hier_$name $hier
}

#-----------------------------------------------------------------
#usb pll
#-----------------------------------------------------------------

#-----------------------------------------------------------------
#aon div
#-----------------------------------------------------------------
#aon_sys
if {$IS_FLAT} {
    source $PROJ_DIR/de/aon_sys/sdc/aon_sys_pwr_wrap.func.TT0P70V.sdc
    source $PROJ_DIR/de/aon_sys/sdc/xmw_rtc_pwr_wrap.func.TT0P70V.sdc
} else {
    source  $PROJ_DIR/de/top/sdc/subsys_group/aon_sys_group.dslp.tcl
    source  $PROJ_DIR/de/top/sdc/subsys_group/rtc_sys_group.dslp.tcl
    
    #impl guide
    source $PROJ_DIR/de/aon_sys/sdc/impl_guide/aon_sys_pwr_wrap.func.dont_touch.tcl
    source $PROJ_DIR/de/aon_sys/sdc/impl_guide/xmw_rtc_pwr_wrap.func.dont_touch.tcl
}

#-----------------------------------------------------------------
#clock for aon
#-----------------------------------------------------------------
#set name_clk_26m_top_for_aon $name_clk_dig_26m_rftop
#set hier_clk_26m_top_for_aon $hier_clk_dig_26m_rftop
if {$IS_FLAT} {
    set name_clk_32k_top_for_aon clk_rtc32k_anlg
    set hier_clk_32k_top_for_aon u_analog_top/rtc32k_clk
} else {
    set name_clk_32k_top_for_aon ${RTC_SYS_HIER}clk_rtc32k_top
    set hier_clk_32k_top_for_aon ${RTC_SYS_HIER}clk_rtc32k_top
}
set TOP_FOR_AON_CLK_CORE_HIER "u_digital_top/u_top_for_aon_clk_core"

source $PROJ_DIR/de/top/sdc/top_for_aon_clk_core.dslp.sdc

#-----------------------------------------------------------------
#clock prediv
#-----------------------------------------------------------------
set name_clk_32k_top_pre_div top_for_aon_clk_32k
set hier_clk_32k_top_pre_div ${TOP_FOR_AON_CLK_CORE_HIER}/u_clk_32k_mux/$CKOUTZ_HIER
set name_clk_32k_dbg_src top_for_aon_clk_32k
set hier_clk_32k_dbg_src ${TOP_FOR_AON_CLK_CORE_HIER}/u_clk_32k_mux/$CKOUTZ_HIER
set TOP_PRE_DIV_CLK_CORE_HIER "u_digital_top/u_top_pre_div_clk_core"

source $PROJ_DIR/de/top/sdc/top_pre_div_clk_core.dslp.sdc

#-----------------------------------------------------------------
#topsys clock
#-----------------------------------------------------------------
#clock core
set TOP_CLK_CORE_HIER "u_digital_top/u_top_clk_core"
source $PROJ_DIR/de/top/sdc/top_clk_core.dslp.sdc

#-----------------------------------------------------------------
#subsys
#-----------------------------------------------------------------
#dbg_sys
source  $PROJ_DIR/de/dbg_sys/sdc/dbg_sys_top.func.TT0P70V.sdc

#-----------------------------------------------------------------
#IO
#-----------------------------------------------------------------

#----------------------------------
#tlb
#----------------------------------
#-----------------------------------------------------------------
#exception
#-----------------------------------------------------------------

#-----------------------------------------------------------------
#exception
#-----------------------------------------------------------------
set_case_analysis 0 u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_ptest_scan_en/cmind_uj_cell/Z


set_false_path -from [get_ports PTEST]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_ptest_ctrl/u_ptest_dec/u_buf_ptest_mbist_mode/cmind_uj_cell/Z]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_ptest_ctrl/u_ptest_dec/u_buf_ptest_scan_mode/cmind_uj_cell/Z]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_ptest_ctrl/u_ptest_dec/u_buf_ptest_icg_mode/cmind_uj_cell/Z]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_ptest_ctrl/u_ptest_dec/u_buf_ptest_dc_mode/cmind_uj_cell/Z]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_ptest_ctrl/u_ptest_dec/u_buf_ptest_ac_mode/cmind_uj_cell/Z]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_ptest_ctrl/u_ptest_dec/u_buf_ptest_lp_mode/cmind_uj_cell/Z]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_ptest_ctrl/u_ptest_dec/u_buf_ptest_func_mode/cmind_uj_cell/Z]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_ptest_ctrl/u_ptest_dec/u_buf_ptest_usbphy_mode/cmind_uj_cell/Z]
#set_false_path -through [get_pins ${DBG_SYS_HIER}dbgbus_data]
#set_false_path -through [get_pins ${DBG_SYS_HIER}dbgbus_*_data]

set_false_path -through [get_pins u_digital_top/u_top_dbgbus/data_bit*u_cmind_cell_buf/cmind_uj_cell/I]

#set_false_path -through [get_pins u_digital_top/u_top_pmu/*shutdown*]

#iomux
set_disable_clock_gating_check [get_cells -hierarchical -filter "full_name =~ u_digital_top/u_io_top/u_io_group_digital_mux/* && is_hierarchical == false"]

#dont touch
source $PROJ_DIR/de/top/sdc/impl_guide/proj_top.func.dont_touch.tcl

#false_path to async rst
set_false_path -to [get_pins -hierarchical -filter "full_name =~ */u_cmind_sig_sync_rst_n/cmind_sync_buf2*bit*0*sync2_rst0*sig_in_sync*_reg/cmind_uj_cell/CDN"]
#false_path to async clk gate
set_false_path -to [get_pins -hierarchical -filter "full_name =~ */async_clk_gate*u_cmind_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D"]
#false_path to clk_sw en
set_false_path -to [get_pins -hierarchical -filter "full_name =~ */u_cmind_sig_sync_clk_in*_en/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D"]
#false_path to clk div en
set_false_path -to [get_pins -hierarchical -filter "full_name =~ */u_cmind_sig_sync_clk_en/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D"]

#if {$IS_FLAT} {
#    set_clock_sense -stop_propagation u_digital_top/u_aon_sys_pwr_wrap/u_aon_sys_top/u_aon_clk_top/u_clk_26m_gate/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#} else {
#    set_clock_sense -stop_propagation ${AON_SYS_HIER}clk_26m
#}

#set_clock_sense -stop_propagation ${TOP_CLK_CORE_HIER}/u_clk_sysram_mux/$CKOUTZ_HIER

set_sense -stop_propagation [get_pins -hierarchical -filter "full_name =~ */occ_control/tessent_persistent_clk_cgc_SHIFT_REG_CLK/cmind_uj_ckcell/CP"]
set_sense -stop_propagation [get_pins -hierarchical -filter "full_name =~ */occ_control/tessent_persistent_cell_ltest_ntc_sync_cell/q_reg/CP"]
set_sense -stop_propagation [get_pins -hierarchical -filter "full_name =~ */occ_control/tessent_persistent_cell_ltest_ntc_sync_cell/ntc_retiming_q_reg_reg/CP"]

#stop ahb monitor clk
set_sense -stop_propagation u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_m2_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_s1_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_m0_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_s6_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_s4_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_m3_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_s2_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_m1_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_s0_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_s5_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_s3_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_dbg_sys_top/a_dbg_main_mtx_lite_wrap/u_dbg_main_mtx_lite_m3_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_dbg_sys_top/a_dbg_main_mtx_lite_wrap/u_dbg_main_mtx_lite_m2_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_dbg_sys_top/a_dbg_main_mtx_lite_wrap/u_dbg_main_mtx_lite_m1_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_dbg_sys_top/a_dbg_main_mtx_lite_wrap/u_dbg_main_mtx_lite_m0_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_dbg_sys_top/a_dbg_main_mtx_lite_wrap/u_dbg_main_mtx_lite_s0_mon/u_ahb_monitor_ckgate/cmind_uj_ckcell/Q

set_false_path -th u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_cpusys_ram_sd/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_top_pmu/u_top_pmu_dft/u_cpu_ram_sd/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_top_pmu/u_top_pmu_dft/u_top_ram0_sd/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_top_pmu/u_top_pmu_dft/u_top_ram1_sd/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_top_pmu/u_top_pmu_dft/u_top_ram0_slp_n/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_top_pmu/u_top_pmu_dft/u_top_ram1_slp_n/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_top_pmu/u_top_pmu_dft/u_top_ram2_sd/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_top_pmu/u_top_pmu_dft/u_top_ram2_slp_n/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_sysram0_ram_sd/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_sysram0_ram_dslp/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_sysram0_ram_slp/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_sysram1_ram_sd/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_sysram1_ram_dslp/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_sysram1_ram_slp/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_sysram2_ram_dslp/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_sysram2_ram_sd/cmind_uj_cell/Z
set_false_path -th u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_sysram2_ram_slp/cmind_uj_cell/Z
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.dubhe.sdc

set_disable_timing [get_pins -of [get_cells u_digital_top/u_efuse_macro]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d0tcm_ram_4096x32_wrap_0/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d0tcm_ram_4096x32_wrap_0/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d0tcm_ram_4096x32_wrap_1/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d0tcm_ram_4096x32_wrap_1/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d0tcm_ram_4096x32_wrap_2/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d0tcm_ram_4096x32_wrap_2/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d0tcm_ram_4096x32_wrap_3/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d0tcm_ram_4096x32_wrap_3/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d1tcm_ram_4096x32_wrap_0/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d1tcm_ram_4096x32_wrap_0/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d1tcm_ram_4096x32_wrap_1/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d1tcm_ram_4096x32_wrap_1/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d1tcm_ram_4096x32_wrap_2/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d1tcm_ram_4096x32_wrap_2/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d1tcm_ram_4096x32_wrap_3/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_d1tcm_ram_4096x32_wrap_3/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_0/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_0/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_0/u_T22ARF1HP2048X32K1M8BLAP_2]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_0/u_T22ARF1HP2048X32K1M8BLAP_3]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_1/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_1/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_1/u_T22ARF1HP2048X32K1M8BLAP_2]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_1/u_T22ARF1HP2048X32K1M8BLAP_3]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_2/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_2/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_2/u_T22ARF1HP2048X32K1M8BLAP_2]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_2/u_T22ARF1HP2048X32K1M8BLAP_3]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_3/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_3/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_3/u_T22ARF1HP2048X32K1M8BLAP_2]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_3/u_T22ARF1HP2048X32K1M8BLAP_3]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_4/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_4/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_4/u_T22ARF1HP2048X32K1M8BLAP_2]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_4/u_T22ARF1HP2048X32K1M8BLAP_3]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_5/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_5/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_5/u_T22ARF1HP2048X32K1M8BLAP_2]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_5/u_T22ARF1HP2048X32K1M8BLAP_3]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_6/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_6/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_6/u_T22ARF1HP2048X32K1M8BLAP_2]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_6/u_T22ARF1HP2048X32K1M8BLAP_3]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_7/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_7/u_T22ARF1HP2048X32K1M8BLAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_7/u_T22ARF1HP2048X32K1M8BLAP_2]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_tcm_glue/u_cpusys_tcmram_top/u_cpusys_tcmram_top_itcm_ram_8192x32_wrap_7/u_T22ARF1HP2048X32K1M8BLAP_3]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpusys_irom_top/u_cpusys_irom_top_cpusys_irom_12800x32_wrap_0/u_T22TROM12800X32K1M16MSPCPUSYSIROM_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_dcache_data_ram_2048x32_wrap_0/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_dcache_data_ram_2048x32_wrap_1/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_dcache_data_ram_2048x32_wrap_2/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_dcache_data_ram_2048x32_wrap_3/u_T22ARF1HP2048X32K1M8BLAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_dcache_dirty_ram_256x4_wrap_0/u_T22ARF1HP256X4K1M8BSAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_dcache_tag_ram_256x21_wrap_0/u_T22ARF1HP256X21K1M4SAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_dcache_tag_ram_256x21_wrap_1/u_T22ARF1HP256X21K1M4SAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_dcache_tag_ram_256x21_wrap_2/u_T22ARF1HP256X21K1M4SAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_dcache_tag_ram_256x21_wrap_3/u_T22ARF1HP256X21K1M4SAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_icache_data_ram_4096x32_wrap_0/u_T22ARF1HP2048X32K1M8LAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_icache_data_ram_4096x32_wrap_0/u_T22ARF1HP2048X32K1M8LAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_icache_data_ram_4096x32_wrap_1/u_T22ARF1HP2048X32K1M8LAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_icache_data_ram_4096x32_wrap_1/u_T22ARF1HP2048X32K1M8LAP_1]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_icache_tag_ram_512x19_wrap_0/u_T22ARF1HP512X19K1M4SAP_0]]
set_disable_timing [get_pins -of [get_cells u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_starmcu/u_STAR/gen_rams_u_pd_rams/u_cpusys_cacheram_top/u_cpusys_cacheram_top_icache_tag_ram_512x19_wrap_1/u_T22ARF1HP512X19K1M4SAP_0]]

#eic related
for {set eic_i 0} {$eic_i < 2} {incr eic_i 1} {
    foreach_in_collection cell [get_cells u_digital_top/u_top_eic${eic_i}/EIC_SUB_MODULE*u_eic_latch/u_lat_int/cmind_uj_cell] {
        set_disable_timing $cell -from CDN -to SDN
        set_disable_timing $cell -from SDN -to CDN
    }
    #for {set eic_j 0} {$eic_j < 5} {incr eic_j 1} {
    #    #create_clock -name top_clk_eic${eic_i}_async${eic_j} -add \
    #    #             -period $CYCLE_1M92 \
    #    #             [get_pins u_digital_top/u_top_eic${eic_i}/EIC_SUB_MODULE*${eic_j}*u_eic_async/u_eic_in_async/cmind_uj_cell/CP]
    #    #set CLOCK_GROUP(top_clk_eic${eic_i}_async${eic_j})         [list top_clk_eic${eic_i}_async${eic_j}]
    #    set_case_analysis 1 u_digital_top/u_top_eic${eic_i}/EIC_SUB_MODULE*${eic_j}*u_eic_async/u_eic_in_scanmux/S
    #}
    foreach_in_collection mpin [get_pins u_digital_top/u_top_eic${eic_i}/EIC_SUB_MODULE*u_eic_async/*u_eic_in_scanmux/cmind_uj_ckcell/S] {
        set_case_analysis 1 $mpin
    }
}

#pub
set sdfcsnq_lists "
    $PSRAM_CTRL_HIER/u_digital_phy/dqs1_gating_d3_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs1_gating_d4_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs0_gating_d1_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs0_gating_d2_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs0_gating_d3_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs0_gating_d4_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs1_gating_d1_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs1_gating_d2_reg
"
foreach sdfcsnq_list $sdfcsnq_lists {
    set_disable_timing $sdfcsnq_list -from CDN -to SDN
    set_disable_timing $sdfcsnq_list -from SDN -to CDN
}

#stop clock
set_sense -stop_propagation u_digital_top/u_top_clk_core/u_clk_cmash_rft_cg/u_cmind_cell_ckout/cmind_uj_ckcell/CP
#set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_top_clk_core/u_clk_top_uart0_apb_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_top_clk_core/u_clk_top_uart2_apb_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_top_clk_core/u_clk_top_uart3_apb_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_top_clk_core/u_clk_top_gpio_ctrl_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_top_clk_core/u_clk_top_intc0_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_top_clk_core/u_clk_top_intc1_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_top_clk_core/u_clk_top_intc2_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_top_clk_core/u_clk_top_eic0_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_top_clk_core/u_clk_top_eic1_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_top_clk_core/u_clk_top_kpd_apb_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_top_clk_core/u_clk_ana_auxadc_mtx_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_clk_core_top/u_ap_clk_core_wrap/u_ap_clk_core/u_clk_top_ahb_scan_scanmux/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_cp_sys_pwr_wrap/u_cp_sys_top/u_cp_sys_clk_top/u_cp_clk_core_wrap/u_cp_clk_core/u_clk_top_ahb_scan_scanmux/cmind_uj_ckcell/Z
set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_cpu_sys_pwr_wrap/u_cpu_sys_top/u_cpu_sys_clk_top/u_cpu_clk_core_wrap/u_cpu_clk_core/u_clk_top_ahb_scan_scanmux/cmind_uj_ckcell/Z
#set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_wrap/u_dbg_clk_core/u_icg_clk_top_ahb_scan/u_cmind_cell_ckout/Q
set_sense -stop_propagation -clocks top_clk_top_mtx u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_pub_sys_clk_core/u_clk_pub_cfg_scan/cmind_uj_ckcell/Z
set_sense -stop_propagation u_digital_top/u_top_pre_div_clk_core/u_clk_32k_aon_cpu_sys_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_clk_core/u_clk_top_uart0_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_clk_core/u_clk_top_uart0_apb_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_clk_core/u_clk_top_uart2_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_clk_core/u_clk_top_uart2_apb_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_clk_core/u_clk_top_uart3_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_clk_core/u_clk_top_uart3_apb_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q

#set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_topsys_peri_wrap/u_top_uart0/*/CP && is_hierarchical == false"]
#set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_topsys_peri_wrap/u_top_uart2/*/CP && is_hierarchical == false"]
#set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_topsys_peri_wrap/u_top_uart3/*/CP && is_hierarchical == false"]
set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_top_io_rf0/*/CP && is_hierarchical == false"]
set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_top_anlg_rf0/*/CP && is_hierarchical == false"]
set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_top_cpu_wdg1/*/CP && is_hierarchical == false"]
set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_top_cp_wdg2/*/CP && is_hierarchical == false"]
set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_top_efuse_ctrl/*/CP && is_hierarchical == false"]
set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_top_ttmr1/*/CP && is_hierarchical == false"]
set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_topsys_peri_wrap/u_topsys_peri_apb_dec/u_apb2apb_async_top_pwm0/*/CP && is_hierarchical == false"]
set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_topsys_peri_wrap/u_topsys_peri_apb_dec/u_apb2apb_async_top_pwm1/*/CP && is_hierarchical == false"]
set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_topsys_peri_wrap/u_topsys_peri_apb_dec/u_apb2apb_async_top_i2c0/*/CP && is_hierarchical == false"]
set_sense -stop_propagation [get_pins -hier -fil "full_name =~ u_digital_top/u_sysram_top/u_ahb_to_ahb_async/*/CP && is_hierarchical == false"]

set_sense -stop_propagation [get_pins ${CPU_SYS_HIER}u_cpu_sys_top/u_cpu_sys_dbgbus/*u_*cka/cmind_uj_ckcell/A1]
set_sense -stop_propagation [get_pins ${CP_SYS_HIER}u_cp_sys_top/u_cp_sys_dbgbus/u_*_cka/cmind_uj_ckcell/A1]

#for hold
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_mpdec_top_glb_wdg0_asb_m_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_mpdec_top_ttmr0_asb_m_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_top_gpio0_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_top_gpio1_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_top_uart0_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_top_uart0_apb_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_top_uart2_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_top_uart2_apb_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_top_kpd_apb_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_top_eic0_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_top_eic1_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_top_intc0_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_top_intc1_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP
set_false_path -hold -from u_digital_top/u_top_rst_core/u_cmind_rst_top_intc2_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP

set_false_path -hold -from u_digital_top/u_top_for_aon_clk_core/u_clk_aon_top_pmu_mux/u_cmind_sig_sync_clk_in0_en/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP -to u_digital_top/u_top_for_aon_clk_core/u_clk_aon_top_pmu_mux/clk_in0_en_sync3_reg/D
set_false_path -hold -from u_digital_top/u_top_glb_reg/clk_top_gpio_ctrl_eb_dslp_mask_reg/CP -to u_digital_top/u_top_glb_reg/prdata_reg_18_/D
set_false_path -hold -from u_digital_top/u_topsys_peri_wrap/u_keypad/g_event_int_0__u_event_release_int/event_int_raw_reg/CP -to u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/prdata_reg_4_/D

#dbg sys hold vio fix
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/dbg_dap_soft_rst_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_dbg_rst_core_wrap/u_dbg_rst_core/u_cmind_apresetn_syn3/u_cmind_sig_sync_rst_n/cmind_sync_buf3_bit3_0__sync3_rst0_sig_in_sync*_reg/cmind_uj_cell/CDN]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/dbg_dap_soft_rst_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_dbg_rst_core_wrap/u_dbg_rst_core/u_cmind_rst_uart_dbg_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync*_reg/cmind_uj_cell/CDN]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_dbg_reg/dbg_main_mtx_soft_rst_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_dbg_rst_core_wrap/u_dbg_rst_core/u_cmind_rst_uart_dbg_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync*_reg/cmind_uj_cell/CDN]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/tlb2dbg_soft_rst_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_dbg_rst_core_wrap/u_dbg_rst_core/u_cmind_rst_tlb2dbg_dbg_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync*_reg/cmind_uj_cell/CDN]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/top2dbg_soft_rst_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_dbg_rst_core_wrap/u_dbg_rst_core/u_cmind_rst_top2dbg_dbg_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync*_reg/cmind_uj_cell/CDN]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/dbg2top_soft_rst_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_dbg_rst_core_wrap/u_dbg_rst_core/u_cmind_rst_dbg2top_dbg_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync*_reg/cmind_uj_cell/CDN]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/apb_mtx_soft_rst_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_dbg_rst_core_wrap/u_dbg_rst_core/u_cmind_rst_apb_mtx_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync*_reg/cmind_uj_cell/CDN]
set_false_path -hold -from [get_pins ${DBG_SYS_HIER}u_dbg_clk_core_top/u_dbg_clk_core_wrap/u_dbg_clk_core/u_icg_clk_top_ahb_scan/async_clk_gate_reset_sync_u_cmind_rst_sync_rst_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins ${DBG_SYS_HIER}u_dbg_clk_core_top/u_dbg_clk_core_wrap/u_dbg_clk_core/u_icg_clk_top_ahb_scan/async_clk_gate_u_cmind_sig_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync*_reg/cmind_uj_cell/CDN]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/uartdbg_apb_cpu_en_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart_decoder/uart_data_reg_*_/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_dbg_reg/dbgbus_io_en_reg_*_/CP] -to [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_dbg_reg/prdata_reg_*_/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_dbg_reg/top_dbg_ready_reg_*_/CP] -to [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_dbg_reg/prdata_reg_*_/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/err_clr_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/err_clr_reg/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/monitor_en_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/prdata_reg_*_/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/monitor_en_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/monitor_en_reg/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/uartdbg_apb_cpu_en_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_brg1/uart_brg_reg_reg_*_/D]

set_false_path -from [get_pins u_digital_top/u_top_intc*/u_intc_rf/int_irq_enable_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_bypass_ana2_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_sd_frc_start_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/deep_sleep_dbg_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_cpu_sys_dslp_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_pfd_tdel_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_cpu_sys_wakeup_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_ipcode_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_ipcode_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_r1_pre_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_incode_reg_4_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_reset_req_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c1_pre_reg_4_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dpll_ideal_count_reg_9_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_io_deep_sleep_sel_pre_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c2_pre_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c1_pre_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_reset_req_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana1_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_usb33_ocp_alarm_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dpll_rst_gate_b_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_ipcode_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/slow_cnt_step_reg_5_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_sys_soft_reset_req_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_r3_pre_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dpll_ideal_count_reg_5_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bypass_cnt_rtc_vtrim_lo_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_r1_ctrl_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_incode_reg_6_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_reset_req_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pwr_bypass_ana3_pwrdn_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_r1_pre_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_pll_off_bypass_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/slow_cnt_step_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dpll_ideal_count_reg_10_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dbg_reset_req_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_ap_sys_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_r1_pre_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_opa_boost_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_vco_freq_override_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_bleed_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c2_ctrl_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_9_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c1_pre_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_ipcode_reg_6_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_r1_ctrl_reg_4_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sys_deep_sleep_req_mask_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pwr_bypass_ana1_pwrdn_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_cp_sys_sd_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_cp_sys_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_r3_pre_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pwr_bypass_ana3_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_32k_sel_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_16_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/amux_reg_7_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_on_st_dly_reg_9_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_bg_ldo_on_reg_9_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_xo_off_bypass_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_17_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_soft_reset_req_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c2_pre_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_r1_ctrl_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_6_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_mirror_size_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c1_ctrl_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_ap_sys_dslp_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_ldo_fb_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c2_pre_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_incode_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_dslp_req_dly_hold_reg_7_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/amux_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_dslp_req_dly_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_gear_shift_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_pub_sys_sd_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bk_gen_scp_alarm_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_fb_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_opa_cs_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_io_deep_sleep_sw_pre_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_pll_off_bypass_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_opa_ib_bst_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_io_deep_sleep_sel_pre_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_4_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_io_ocp_alarm_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_opa_cs_buf_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana11_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dbg_sys_soft_reset_req_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_on_st_dly_reg_5_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_byp_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_sys_reset_req_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_cp_sys_wakeup_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_on_st_dly_reg_4_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_on_st_dly_reg_8_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/amux_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_on_st_dly_reg_9_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_fem_ocp_alarm_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_io_deep_sleep_sel_pre_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_xo_off_bypass_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_int_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_off_st_dly_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_bypass_ana3_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_io_deep_sleep_sw_pre_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_adcclk_div_reg_4_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_dslp_req_dly_hold_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_int_reg_8_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_int_reg_6_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_io_deep_sleep_sel_pre_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pwr_bypass_ana2_pwrdn_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_on_st_dly_reg_6_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_frc_deep_sleep_req_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_cpu_sys_sd_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_anap1_off2en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_dslp_req_dly_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_ldo_fb_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_bypass_ana1_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sys_soft_reset_req_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pwr_bypass_ana0_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram1_lp_sw_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana0_pwrdn_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_32k_off_bypass_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_io_deep_sleep_sw_pre_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_bypass_ana2_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_io_deep_sleep_sel_pre_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_r3_ctrl_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_io_deep_sleep_sel_pre_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_io_deep_sleep_sel_pre_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_bypass_ana3_pwrdn_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_dslp_req_dly_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_bypass_ana2_pwrdn_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_bypass_ana1_pwrdn_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_on_st_dly_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_io_deep_sleep_sel_pre_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_dslp_req_dly_hold_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dacclk_div_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_mash_clk_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_adcclk_div_bypassn_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana00_pwrdn_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_io_deep_sleep_sel_pre_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/clk_dig_409p6m_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_bypass_ana0_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_fem_ocp_alarm_int_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_vco_vpbias_mode_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_io_deep_sleep_sw_pre_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_auto_deep_sleep_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram1_lp_sw_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_r1_pre_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_io_deep_sleep_sel_pre_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_sw_ctrl_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_ldo_fb_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_on_st_dly_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_xo_off_bypass_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_auto_deep_sleep_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_sd_ocp_alarm_int_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/slow_cnt_step_reg_5_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pll_off_bypass_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_pwr_ana_sel_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_io_deep_sleep_sel_pre_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana00_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_io_deep_sleep_sel_pre_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ana13_pwrdn_st_dly_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_fcal_filt_override_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_ram_slp_mode_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_sim1_ocp_alarm_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pwr_bypass_ana1_pwrdn_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/clk_19_2m_usb_en_sw_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_ref_off_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_cpu_sys_wakeup_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_int_mode_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_res1_trim_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_ponrst_sw_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/busy_clk_30_72m_aon_byp_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sys_soft_reset_req_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_slp_bypass_ana2_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_res1_trim_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_dith_lsb_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_dith_shape_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_pfd_sel_enopt_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dacclk_div_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_cpu_sys_dslp_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c1_pre_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_sys_sd_frc_start_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_select_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pmu_sel_3_25m_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_xo_off_bypass_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash2_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_res2_trim_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram2_lp_sw_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_slp_ana_sel_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_soft_reset_req_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_mash_rst_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/clk_dig_491p52m_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_ap_sys_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_res2_trim_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/clk_dig_307p2m_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_vco_en_sw_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_pub_sys_wakeup_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_mash_clk_sw_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_pub_sys_dslp_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_vco_bias_mode_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_io_deep_sleep_sw_pre_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_sys_clk_en_sw_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_ldo_byp_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ana13_pwrdn_st_dly_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram1_lp_sw_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_io_deep_sleep_sel_pre_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/amux_reg_5_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_res2_trim_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/amux_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram1_slp_mode_reg_0_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ana13_pwrdn_st_dly_reg_3_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_sim1_ocp_alarm_int_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ana12_pwrdn_st_dly_reg_4_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_slp_bypass_ana0_pwron_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_res1_trim_reg_2_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dbg_reset_req_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_en_sw_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/amux_reg_1_/CP]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_deep_sleep_req_mask_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_eic*/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/u_eic_eb_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_eic*/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/cur_state_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/u_boot_mon/mon_cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/u_boot_mon/mon_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/u_boot_mon/reboot_trig_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/u_boot_mon/mon_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/reboot_trig_d2_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/cpu_pc_capture_reg_*_/D]
#cpll ctrl
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_done_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_targ_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_done_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_dpll_rst_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/nsleep_cpll_clk_pin_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_bg_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_targ_reg_7_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_dpll_rst_off_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_cpll_mash_clk_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_done_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_cpll_reg_iso_off_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_done_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_bg_ldo_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_cpll_clk_iso_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cpll_en_pin_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_cpll_mash_clk_off_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_cpll_mash_clk_off_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cpll_mash_update_pin_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cpll_mash_update_pin_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_ams_iso_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_ams_iso_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/u_cpll_mash_sync/u_cmind_dmux_sync/din_vld_toggle_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/u_cpll_mash_sync/u_cmind_dmux_sync/din_vld_toggle_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cpll_mash_clk_on_pin_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cpll_mash_clk_on_pin_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_cpll_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_cpll_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_cpll_mash_update_b_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_cpll_mash_update_b_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_cpll_ldo_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_cpll_ldo_on_reg/D]
#ana rc32k cali
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ana_rc32k_cali_wrap/u_ana_rc32k_cali/rc32k_wait_cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_ana_rc32k_cali_wrap/u_ana_rc32k_cali/rc32k_wait_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ana_rc32k_cali_wrap/u_ana_rc32k_cali/u_rc32k_cali_start_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_ana_rc32k_cali_wrap/u_ana_rc32k_cali/rc32k_wait_done_reg/D]
#eic rf
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_int_clr_reg_reg_*_/CP] -to [get_pins u_digital_top/u_top_eic*/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/dbnc_int_clr_s_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_clr_reg_reg_*_/CP] -to [get_pins u_digital_top/u_top_eic*/EIC_SUB_MODULE_*__eic_sync_u_eic_sync/int_eic_sync_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_clr_reg_reg_*_/CP] -to [get_pins u_digital_top/u_top_eic*/EIC_SUB_MODULE_*__eic_async_u_eic_async/async_int_clr_s_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_latch_reg_latch_int_clr_reg_reg_*_/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_latch_reg_latch_int_clr_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_int_clr_reg_reg_*_/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_int_clr_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_clr_reg_reg_*_/CP] -to [get_pins u_digital_top/u_top_eic*/EIC_SUB_MODULE_*__eic_sync_u_eic_sync/int_eic_sync_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_en_reg_reg_*_/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_en_reg_reg_*_/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_pol_reg_reg_*_/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_pol_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_pol_reg_reg_*_/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_pol_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_trig_start_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/EIC_SUB_MODULE_*__eic_dbnc_u_eic_dbnc/dbnc_trig_s_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_cnt_sel_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_cnt_sel_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_clr_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_clr_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_trig_start_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_trig_start_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_latch_reg_latch_int_pol_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_latch_reg_latch_int_pol_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_latch_reg_latch_int_en_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_latch_reg_latch_int_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_int_pol_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_int_pol_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_en_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_int_en_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_int_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_both_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_both_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_both_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_both_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_latch_reg_latch_en_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic0/u_eic_rf/eic_latch_reg_latch_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_en_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_mode_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_mode_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_mode_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_mode_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_en_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_clr_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_clr_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_cnt_sel_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/EIC_SUB_MODULE*eic_dbnc*u_eic_dbnc/*dbnc_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_en_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_latch_reg_latch_en_reg_reg_*_/CP] -to  [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_latch_reg_latch_en_reg_reg_*_/D]
#top pmu glb reg
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/busy_clk_245_76m_pre_div_byp_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_aon_pll_en_vote_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_reset_req_eb_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/u_*_rst_ctrl/u_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dpll_ref_div_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dpll_ref_div_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_off_st_dly_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/cnt_done_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CORE_CUR_LP_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CORE_CUR_LP_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_pub_sys_pwron_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/int_pub_sys_pwron_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/slow_cnt_step_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_BUF_ANA_CUR_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_BUF_ANA_CUR_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_ap_sys_sd_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/int_ap_sys_sd_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_BUF_ANA_RES_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_BUF_ANA_RES_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_bg_ldo_on_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_targ_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana2_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/reg_ana2_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c3_pre_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c3_pre_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CORE_CUR_HP_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CORE_CUR_HP_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_xo_off_bypass_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_xo_off_bypass_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dpll_vco_ctrl_override_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dpll_vco_ctrl_override_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_21_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/amux_reg_4_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/amux_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/VB_XO_ADJ_LP_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/VB_XO_ADJ_LP_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_14_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana11_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana11_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_IN_FIXED_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_IN_FIXED_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_IN_reg_5_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_IN_reg_5_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_ap_sys_wakeup_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/int_ap_sys_wakeup_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_vco_freq_override_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_vco_freq_override_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c2_pre_reg_4_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c2_pre_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pwr_iso_deassert_st_dly_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_pub_sys_pwron_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/clk_req_xohp_byp_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/clk_req_xohp_byp_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c3_pre_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c3_pre_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_IN_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_IN_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_6_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pll_off_bypass_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pll_off_bypass_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_5_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_slp_bypass_ana0_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_slp_bypass_ana0_pwrdn_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cnt_rtc_vtrim_dly_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/IB_XO_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/IB_XO_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_ipcode_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_ipcode_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_r1_pre_reg_4_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_r1_pre_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_incode_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_incode_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_opa_cs_buf_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_opa_cs_buf_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_cpll_reg_iso_on_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_targ_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_fb_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_fb_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bypass_cnt_rtc_vtrim_hi_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_rtc_vtrim0p8_wen_hi_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_en_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_en_sw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_ipcode_reg_4_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_ipcode_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_pub_sys_wakeup_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/int_pub_sys_wakeup_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CORE_CUR_HP_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CORE_CUR_HP_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_deep_sleep_hold_cnt_thr_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/top_deep_sleep_hold_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/IB_XO_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/IB_XO_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cali_byp_deep_sleep_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_29_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/clk_xo26m_32k_busy_xohp_byp_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/clk_xo26m_32k_busy_xohp_byp_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_4_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bypass_cnt_rtc_vtrim_hi_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_rtc_vtm_high_sel_ldo_on_match_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_OUT_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_OUT_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_clk_en_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_IN_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_IN_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pmu_sel_32k_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pmu_sel_32k_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_por_auto_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bootrom_slp_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bootrom_slp_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_sd_frc_start_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_sd_frc_start_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_pswoff_st_dly_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pwr_bypass_ana1_pwron_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/cur_anapwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_ref_off_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_ref_off_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_5_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_fb_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_fb_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_en_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_en_sw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_top_sys_dslp_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/int_top_sys_dslp_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_8_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dpll_ideal_count_reg_11_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dpll_ideal_count_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_sd_ocp_alarm_int_clr_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_ocp_wrap/int_ldo_sd_ocp_alarm_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_slp_bypass_ana2_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_slp_bypass_ana2_pwrdn_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_slp_bypass_ana1_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_slp_bypass_ana1_pwrdn_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_ldo_opa_cs_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_ldo_opa_cs_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_gear_shift_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_gear_shift_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_vco_freq_override_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_vco_freq_override_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bypass_cnt_rtc_vtrim_hi_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_rtc_vtm_high_sel_ldo_on_busy_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_byp_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_byp_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana3_pwron_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana3_pwron_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_cp_sys_dslp_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/int_cp_sys_dslp_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/nsleep_cpll_clk_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/nsleep_cpll_clk_sw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_BUF_ANA_CUR_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_BUF_ANA_CUR_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c2_ctrl_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c2_ctrl_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sys_frc_deep_sleep_req_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sys_frc_deep_sleep_req_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_dslp_req_dly_hold_reg_5_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_dslp_req_dly_hold_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c1_ctrl_reg_4_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c1_ctrl_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_rst_deassert_st_dly_reg_9_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c3_pre_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c3_pre_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/slow_cnt_step_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_*_sys_pmu/u_pwr_ctrl/pwr_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_bg_ldo_on_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_IN_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_IN_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dpll_ideal_count_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_dpll_ideal_count_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana12_pwron_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana12_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_slp_mode_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_slp_mode_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_incode_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_incode_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_bypass_ana0_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_bypass_ana0_pwrdn_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_sd_frc_start_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_sd_frc_start_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_ana0_pwr_st_dly_reg_9_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/cur_anapwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c2_ctrl_reg_4_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c2_ctrl_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bk_pa_scp_alarm_int_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bk_pa_scp_alarm_int_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xvlo_alarm_int_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xvlo_alarm_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_pwr_ana_sel_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_pwr_ana_sel_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_clk_en_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_clk_en_sw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_incode_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_incode_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bootmon_start_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/u_boot_mon/mon_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_pub_sys_dslp_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_pub_sys_dslp_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_pwr_ana_sel_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_pwr_ana_sel_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana3_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana3_pwrdn_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_clk_out_en_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_clk_out_en_sw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_OUT_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_OUT_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_opa_cs_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ams_ldo_opa_cs_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_clk_en_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_clk_en_sw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_ams_iso_off_reg_8_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_targ_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_sd_ocp_alarm_int_clr_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_sd_ocp_alarm_int_clr_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bk_pa_scp_alarm_int_clr_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bk_pa_scp_alarm_int_clr_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_vco_ib_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_vco_ib_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo26mhp_32k_div_frac_reg_13_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_cpll_mash_update_b_reg_4_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_targ_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram0_lp_sw_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram0_lp_sw_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ana11_pwron_st_dly_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram0_lp_sw_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram0_lp_sw_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_sys_auto_deep_sleep_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_sys_auto_deep_sleep_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana2_pwron_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana2_pwron_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bootmon_start_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/u_boot_mon/mon_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_cp_sys_wakeup_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_cp_sys_wakeup_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram0_lp_sw_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram0_lp_sw_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/VB_XO_BLEED_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/VB_XO_BLEED_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dig_rc32k_cali_clk_frc_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dig_rc32k_cali_clk_frc_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bootmon_start_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/u_boot_mon/mon_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dbg_root_clk_en_keep_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dbg_root_clk_en_keep_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_cp_sys_dslp_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_cp_sys_dslp_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_slp_ana_sel_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_slp_ana_sel_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_io_ocp_alarm_int_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_sim0_ocp_alarm_int_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_sim0_ocp_alarm_int_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dig_rc32k_cali_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dig_rc32k_cali_sw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_fb_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_fb_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_IN_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_IN_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_io_deep_sleep_sel_pre_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_io_deep_sleep_sel_pre_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dig_rc32k_cali_int_clr_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dig_rc32k_cali_int_clr_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ana_rc32k_wait_num_sel_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/IB_XO_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/IB_XO_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_pswoff_st_dly_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_slp_ana_sel_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_slp_ana_sel_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/frc_ratio_vld_clr_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_frc_ratio_vld_clr/pls_etd_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_cpll_mash_clk_on_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_targ_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c2_pre_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c2_pre_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana02_pwron_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana02_pwr_on_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CORE_RES_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CORE_RES_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c3_ctrl_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c3_ctrl_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_lp_auto_en_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_ap_sys_pmu/cur_st_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_cpll_ldo_off_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_targ_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/clk_26m_top_busy_xohp_byp_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/clk_26m_top_busy_xohp_byp_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_cpll_mash_update_b_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_targ_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana11_pwrdn_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana11_pwrdn_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_off_st_dly_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_off_st_dly_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_ldo_opa_cs_buf_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bgap_ldo_opa_cs_buf_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/amux_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/amux_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_off_st_dly_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/usb_phy_pwr_off_st_dly_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_deep_sleep_hold_cnt_thr_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/top_deep_sleep_hold_cnt_en_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana2_pwrdn_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana2_pwrdn_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_BUF_ANA_RES_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_29_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram2_slp_mode_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram2_slp_mode_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_iso_en_sw_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_iso_en_sw_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/HEN_XO_BUF_ANA_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/HEN_XO_BUF_ANA_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_clk_en_sw_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_clk_en_sw_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bootmon_clr_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bootmon_clr_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_deep_sleep_req_mask_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_dslp_clr_sync/*sig_in_sync0_reg/cmind_uj_cell/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/clk_dig_26m_en_sel_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_dslp_req_dly_hold_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_dslp_req_dly_hold_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_irq_sw_mask_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_irq_sw_mask_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana13_pwron_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana1_pon_cnt_go_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ana_rc32k_cali_soft_rst_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ana_rc32k_cali_soft_rst_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cali_byp_deep_sleep_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cali_byp_deep_sleep_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_adcclk_div_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_adcclk_div_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_iboost_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_cp_iboost_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana1_pwrdn_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana1_pwrdn_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_int_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_int_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_slp_ana3_pwr_st_dly_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/cur_anapwr_st_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xvlo_alarm_int_en_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xvlo_alarm_int_en_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana13_pwron_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana13_pwr_on_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_sys_deep_sleep_req_mask_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_cp_sys_pmu/u_dslp_clr_sync/*sig_in_sync0_reg/cmind_uj_cell/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana03_pwrdn_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana0_poff_cnt_go_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram2_lp_sw_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram2_lp_sw_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ana*_pwrdn_st_dly_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana_cnt_targ_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_top_sys_dslp_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_top_sys_dslp_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo_off_st_byp_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo_off_st_byp_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xo_hp_keep_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_12_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sys_deep_sleep_hold_intl_sw_en_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_sys_pmu/top_sys_deep_sleep_clr_d2_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_deep_sleep_req_mask_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_ap_sys_pmu/u_dslp_clr_sync/*sig_in_sync0_reg/cmind_uj_cell/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_cpu_sys_sd_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_cpu_sys_sd_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_ams_iso_off_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_targ_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_sd_frc_start_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/cur_pwr_st_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana03_pwrdn_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana03_pwr_on_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana0_pwron_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/reg_ana0_pwr_on_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_pub_sys_pwron_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_pub_sys_pwron_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ana_rc32k_cali_en_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ana_rc32k_cali_en_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_frc_deep_sleep_req_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_frc_deep_sleep_req_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/nsleep_rf_data_sw_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/nsleep_rf_data_sw_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_pwr_iso_assert_st_dly_reg_*_/CP] -to [get_pins  u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pwr_ctrl/pwr_ctrl_cnt_reg_*_/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/nsleep_rf_reg_sw_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/nsleep_rf_reg_sw_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/nsleep_ldoams_reg_sw_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/nsleep_ldoams_reg_sw_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_soft_reset_req_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_soft_reset_req_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_iso_en_sw_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_iso_en_sw_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_pub_sys_sd_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_pub_sys_sd_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_cp_sys_pwron_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_cp_sys_pwron_reg/D  ]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana01_pwron_reg/CP] -to [get_pins  u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana01_pwr_on_reg/D  ]
#xo ctrl
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_ldo_off_sel_rtc_vtm_low_match_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_ldo_off_sel_rtc_vtm_low_match_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cur_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_ldo_on_sel_iso_dasrt_busy_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/dig_26m_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/dig_26m_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_ldo_off_sel_rtc_vtm_low_busy_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_ldo_off_sel_rtc_vtm_low_busy_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cur_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/pls_ldo_off_sel_rtc_vtm_low_d_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/count_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/count_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/count_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_done_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/xo_en_req_sync_d1_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/xo_en_start_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cur_st_reg_1_/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/ldo_dcxo_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_rtc_vtm_low_sel_xo_off_match_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_rtc_vtm_low_sel_xo_off_match_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_ldo_on_sel_iso_dasrt_match_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_ldo_on_sel_iso_dasrt_match_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/xo_nsleep_reg_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/xo_nsleep_reg_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_rtc_vtm_low_sel_xo_off_busy_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_rtc_vtm_low_sel_xo_off_busy_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_en_start_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_en_start_sync/genblk1_genblk1_sig_in_sync1_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cur_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/pls_xo_off_sel_rtc_vtm_high_d_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_hp2lp_condition_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_hp2lp_condition_sync/genblk1_genblk1_sig_in_sync1_reg/cmind_uj_cell/D]
#dbgsys glb dbg reg
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/cp_sys_dbg_ready_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/cp_sys_dbg_ready_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/top_dbg_ready_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/top_dbg_ready_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/ap_sys_dbg_ready_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/ap_sys_dbg_ready_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/dummy*_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/pub_sys_dbg_ready_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/pub_sys_dbg_ready_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/ap_sys_dbg_ready_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_arm_por_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_arm_por_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/cp_sys_dbg_ready_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ap_main_mtx_dbg_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ap_main_mtx_dbg_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_cpu_main_mtx_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_cpu_main_mtx_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_top2ap_dbg_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_top2ap_dbg_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/top2cp_dbg_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/top2cp_dbg_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_cfg_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_cfg_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ahb2ahba_cpu2flash_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/dummy*_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/dummy*_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ahb2ahba_ap2cpu_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/cp2psram_dbg_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/cp2psram_dbg_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ap2flash_dbg_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ap2flash_dbg_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_arm_sys_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_arm_sys_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ahb2ahba_top2cpu_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ahb2ahba_top2cpu_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/dbg_main_mtx_soft_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/dbg_main_mtx_soft_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/cpsys_glb_dbg_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/cpsys_glb_dbg_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/cpu_sys_dbg_ready_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/cpu_sys_dbg_ready_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ahb2ahba_cp2cpu_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ahb2ahba_cp2cpu_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/top_dbg_ready_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/pub_sys_dbg_ready_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/prdata_reg_*_/D]
#dbgsys glb reg rf
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/dummy*_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/dummy*_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/dummy*_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/apb_mtx_soft_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/top2dbg_soft_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/lpc_threshold_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/lpc_threshold_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/uart_dbg_soft_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/uart_dbg_soft_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/lpc_en_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/lpc_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/tlb2dbg_soft_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/tlb2dbg_soft_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/lpc_threshold_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_reg_rf_top/prdata_reg_*_/D]
#dbgsys clk core
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_reg/dummy*_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_reg/dummy*_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_reg/dummy*_reg_*_/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_reg/frc_on_clk_top_ahb_scan_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_reg/frc_off_clk_tlb_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_reg/frc_off_clk_tlb_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_reg/frc_on_clk_tlb_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_reg/frc_on_clk_tlb_reg/D]

#dig rc32k cali
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_rc32k_cali_wrap/u_rc32k_cali/cali_trig_vld_d_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_rc32k_cali_wrap/u_rc32k_cali/cali_start_32k_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_rc32k_cali_wrap/u_rc32k_cali/cali_lenth_curval_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_rc32k_cali_wrap/u_rc32k_cali/cali_lenth_curval_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_rc32k_cali_wrap/u_rc32k_cali/u_ratio_calc/u_frc_ratio_vld/u_pls_etd_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_rc32k_cali_wrap/u_rc32k_cali/u_ratio_calc/u_frc_ratio_vld/pls_etd_sync_d1_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_rc32k_cali_wrap/u_rc32k_cali/u_ratio_calc/u_frc_ratio_vld/u_pls_etd_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_rc32k_cali_wrap/u_rc32k_cali/u_ratio_calc/frc_ratio_vld_pls_d_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_rc32k_cali_wrap/u_rc32k_cali/u_cali_trig_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_rc32k_cali_wrap/u_rc32k_cali/cali_trig_vld_d_reg/D]

#misc
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_wrap/u_dbg_clk_core/u_icg_clk_top_ahb_scan/async_clk_gate_reset_sync_u_cmind_rst_sync_rst_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_*__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbg_clk_core_top/u_dbg_clk_core_wrap/u_dbg_clk_core/u_icg_clk_top_ahb_scan/async_clk_gate_reset_sync_u_cmind_rst_sync_rst_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_bit2_*__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/ap_sys_deep_sleep_clr_d1_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/ap_sys_deep_sleep_clr_d2_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/cnt_done_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/cur_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/int_ap_sys_pwron_raw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/int_ap_sys_pwron_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/cur_anapwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/cur_anapwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/cur_anapwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/reg_ana*_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/cur_anapwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/pwr_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/cur_pwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/reg_rst_n_o_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/pwr_ctrl_cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/pwr_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/reg_pwr_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/reg_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/cur_anapwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/cur_anapwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/cur_anapwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/sleep_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/cur_sleep_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/cur_sleep_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/reg_ana*_pwr_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/reg_ana*_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/reg_sd_start_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/cur_pwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/reg_xo_en_vote_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/reg_xo_en_vote_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/sleep_ctrl_cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/sleep_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/int_cp_sys_pwron_raw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/int_cp_sys_pwron_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/int_cp_sys_sd_raw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/int_cp_sys_sd_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/int_cp_sys_wakeup_raw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/int_cp_sys_wakeup_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_dslp_clr_sync/genblk1_genblk1_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/cp_sys_deep_sleep_clr_d1_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_pwr_ctrl/cur_pwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_pwr_ctrl/cur_pwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_pwr_ctrl/reg_pwr_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_pwr_ctrl/reg_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_slp_ctrl/cur_anapwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_slp_ctrl/cur_anapwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_slp_ctrl/cur_sleep_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_slp_ctrl/cur_sleep_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_slp_ctrl/reg_pll_en_vote_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_slp_ctrl/reg_pll_en_vote_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_slp_ctrl/reg_root_clk_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_slp_ctrl/reg_root_clk_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/int_cpu_sys_sd_raw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/int_cpu_sys_sd_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_dslp_clr_sync/genblk1_genblk1_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/cpu_sys_deep_sleep_clr_d1_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/cur_pwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/cur_pwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/pwr_ctrl_cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/pwr_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/reg_ana*_pwr_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/reg_ana*_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/reg_pwr_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/reg_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/reg_rst_n_o_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/reg_rst_n_o_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/reg_shutdown_n_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/reg_shutdown_n_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/cur_anapwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/cur_anapwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/cur_anapwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/reg_ana*_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/cur_anapwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/sleep_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/cur_sleep_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/int_cpu_sys_wakeup_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/cur_sleep_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/cur_sleep_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/reg_xo_en_vote_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/reg_xo_en_vote_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/sleep_ctrl_cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/sleep_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/ap_soft_reset_req_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/ap_soft_reset_req_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/top_soft_reset_req_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/top_soft_reset_req_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_frc_ratio_vld_clr/pls_etd_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_frc_ratio_vld_clr/pls_etd_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ptest_ctrl/u_ptest_pwr_rdy_sync/genblk1_genblk1_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_ptest_ctrl/ptest_pwr_rdy_d1_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/int_pub_sys_dslp_raw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/int_pub_sys_dslp_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/int_pub_sys_sd_raw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/int_pub_sys_sd_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/pub_sys_deep_sleep_clr_d1_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_slp_ctrl/cur_sleep_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pub_delay_dslp_req/cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pub_delay_dslp_req/cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pub_delay_dslp_req/u_dslp_req_sync/cmind_sync_buf2_bit2_*__genblk1_sync2_rst1_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pub_delay_dslp_req/cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pub_delay_dslp_req/u_dslp_req_sync/cmind_sync_buf2_bit2_*__genblk1_sync2_rst1_sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pub_delay_dslp_req/cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pwr_ctrl/cur_pwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pwr_ctrl/cur_pwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pwr_ctrl/pwr_ctrl_cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pwr_ctrl/pwr_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_slp_ctrl/cur_anapwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_slp_ctrl/cur_anapwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_slp_ctrl/reg_pll_en_vote_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cpll_hw_enable_d1_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_slp_ctrl/reg_root_clk_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_slp_ctrl/reg_root_clk_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_slp_ctrl/reg_xo_en_vote_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_slp_ctrl/reg_xo_en_vote_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_slp_ctrl/sleep_ctrl_cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_slp_ctrl/sleep_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_dslp_clr_sync/genblk1_genblk1_sig_in_sync0_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_dslp_clr_sync/genblk1_genblk1_sig_in_sync1_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana*_poff_cnt_go_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana*_poff_cnt_go_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana*_pon_cnt_go_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana*_pwr_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana*_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana*_pon_cnt_go_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana*_pon_cnt_go_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana_cnt_done_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/cnt_ana*_poff_match_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana_cnt_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana_cnt_targ_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana_cnt_done_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana_cnt_targ_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/cnt_ana*_poff_match_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/cnt_ana*_poff_match_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/cnt_ana*_pon_match_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/cur_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/cnt_ana*_poff_match_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/cur_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/cur_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana*_poff_cnt_go_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/xo_en_vote_o_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/xo_en_vote_o_reg/D]


#false path for static rf
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_102_4m_cpll_cp_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_102_4m_pub_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_122_88m_cpll_cp_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_122_88m_pub_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_19_2m_cpll_ap_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_204_8m_cpll_cp_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_204_8m_cpll_cpu_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_204_8m_top_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_245_76m_cpll_cpu_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_245_76m_top_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_26m_pub_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_26m_xo_cp_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_26m_xo_dbg_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_32k_aon_cpu_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_409_6m_cpll_cpu_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_491_52m_cpll_cpu_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_51_2m_cpll_cp_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_51_2m_cpll_cpu_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_51_2m_top_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_61_44m_pub_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_61_44m_top_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_76_8m_top_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_ana_auxadc_26m_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_ana_auxadc_mtx_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_ana_bk_gen_26m_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_cmash_rft_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_sysram_afd_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_sysram_sel_afd_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_sysram_sel_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_cp_wdg2_eb_dslp_mask_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_cp_wdg2_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_cpu_wdg1_eb_dslp_mask_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_cpu_wdg1_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_i2c0_eb_dslp_mask_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_i2c0_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_i2c0_sel_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_mtx_sel_afd_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_mtx_sel_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_pwm0_eb_dslp_mask_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_pwm0_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_pwm1_eb_dslp_mask_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_pwm1_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_pwm1_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart0_apb_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart0_apb_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart0_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart2_apb_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart2_apb_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart2_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart2_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart3_apb_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart3_eb_dslp_mask_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart3_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart3_sel_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/main_mtx_err_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/ptest_cpu_rstn_reg_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_adc_ctrl_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_auxadc_test_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_anlg_rf0_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_cp_wdg2_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_cpu_wdg1_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_i2c0_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_io_rf0_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_ttmr1_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_uart2_apb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_uart3_apb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_top_pmu_cali_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/sysram_dslp_req_mask_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/sysram_lpc_threshold_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/sysram_mtx_monitor_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/sysram_ra1up_ema_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/sysram_ra1up_emas_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/sysram_ra1up_rawlm_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/sysram_ra1up_wablm_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/top_uart0_byte_sel_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/top_uart2_byte_sel_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_102_4m_top_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_102_4m_top_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_153_6m_top_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_204_8m_pub_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_245_76m_cpll_cp_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_26m_top_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_26m_xo_ap_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_26m_xo_cpu_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_307_2m_cpll_cpu_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_30_72m_aon_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_30_72m_cpll_cp_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_480m_usbphy_pll_cpu_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_76_8m_pub_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_ana_bk_gen_26m_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_sysram_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_cpu_wdg1_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_i2c0_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_ttmr1_eb_dslp_mask_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart0_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart0_sel_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart2_sel_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart3_apb_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_uart2_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_uart3_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_sysram_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/CFGDTCMSZ_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/CFGNSSTCALIB_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_102_4m_cpll_ap_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_153_6m_cpll_ap_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_153_6m_pub_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_245_76m_cpll_ap_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_76_8m_cpll_ap_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_ana_bk_core_26m_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_ana_bk_pa_26m_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_anlg_rf0_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_ttmr1_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_uart3_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/dummy1_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_pwm1_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_uart0_apb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/soft_rst_top_uart0_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/top_main_lpc_threshold_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_102_4m_cpll_cpu_sys_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_122_88m_pub_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_245_76m_top_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_26m_xo_cp_sys_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_26m_xo_dbg_sys_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_307_2m_cpll_ap_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_30_72m_cpll_cp_sys_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_491_52m_cpll_cpu_sys_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_51_2m_cpll_ap_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_61_44m_cpll_ap_sys_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_ana_auxadc_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_ana_bk_core_26m_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_anlg_rf0_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_io_rf0_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/clk_top_pwm0_force_eb_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/dummy0_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/main_mtx_monitor_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_reg/top_uart3_byte_sel_reg/CP]

set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/dbnc_cnt_num_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event0_longkey_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event0_press_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event0_release_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event1_longkey_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event1_press_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event1_release_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event2_longkey_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event2_press_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event2_release_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event3_longkey_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event3_press_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event3_release_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/ghostdet_int_clr_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/keyin_en_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/keyout_en_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/longkey_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/sleep_cnt_num_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/clk_div_num_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event_release_int_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/longkey_cnt_num_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/sleep_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event_press_int_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/event_longkey_int_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_topsys_peri_wrap/u_keypad/u_keypad_reg/ghostdet_int_en_reg/CP]

set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_1/i_cdnsttc_prescaler/clk_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_2/i_cdnsttc_prescaler/clk_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_3/i_cdnsttc_prescaler/clk_en_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_syncprotect/i_cdns_syncflop_ext_clk_1/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_syncprotect/i_cdns_syncflop_ext_clk_2/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_syncprotect/i_cdns_syncflop_ext_clk_3/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_1/i_cdnsttc_counter/interval_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_1/i_cdnsttc_counter/match_1_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_1/i_cdnsttc_counter/match_2_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_1/i_cdnsttc_counter/match_3_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_1/i_cdnsttc_interrupt/interrupt_en_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_1/i_cdnsttc_prescaler/clk_ctrl_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_2/i_cdnsttc_counter/interval_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_2/i_cdnsttc_counter/match_1_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_2/i_cdnsttc_counter/match_2_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_2/i_cdnsttc_counter/match_3_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_2/i_cdnsttc_interrupt/interrupt_en_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_2/i_cdnsttc_prescaler/clk_ctrl_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_3/i_cdnsttc_counter/interval_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_3/i_cdnsttc_counter/match_1_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_3/i_cdnsttc_counter/match_2_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_3/i_cdnsttc_counter/match_3_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_3/i_cdnsttc_interrupt/interrupt_en_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_3/i_cdnsttc_prescaler/clk_ctrl_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_syncprotect/i_cdns_syncflop_ext_clk_1/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_*/i_cdnsttc_counter/cntr_ctrl_reg_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_*/i_cdnsttc_counter/counting_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_*/i_cdnsttc_counter/restart_temp_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_*/i_cdnsttc_event_timer/event_timer_tm_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_*/i_cdnsttc_event_timer/event_timer_ctrl_reg_*_/CP]
#set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_1/i_cdnsttc_event_timer/event_timer_ctrl_reg_2_/CP]
#set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_2/i_cdnsttc_event_timer/event_timer_ctrl_reg_1_/CP]
#set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_2/i_cdnsttc_event_timer/event_timer_ctrl_reg_2_/CP]
#set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_3/i_cdnsttc_event_timer/event_timer_ctrl_reg_0_/CP]
#set_false_path -from [get_pins u_digital_top/u_top_lp_ttmr0/i_cdnsttc_timer_counter_3/i_cdnsttc_event_timer/event_timer_ctrl_reg_1_/CP]

set_false_path -from [get_pins u_digital_top/u_top_glb_wdg0/u_apb_watchdog_frc/int_clr_tog_p_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_wdg0/u_apb_watchdog_frc/load_en_reg_reg/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_wdg0/u_apb_watchdog_frc/wdog_control_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_wdg0/u_apb_watchdog_frc/wdog_load_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_top_glb_wdg0/wdog_itop_reg_*_/CP]

set_false_path -from [get_pins u_digital_top/u_gpio_ctrl*/i_cdnsgpio_subunit/bypass_mode_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_gpio_ctrl*/i_cdnsgpio_subunit/direction_mode_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_gpio_ctrl*/i_cdnsgpio_subunit/output_enable_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_gpio_ctrl*/i_cdnsgpio_subunit/output_value_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_gpio_ctrl*/i_cdnsgpio_subunit/int_type_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_gpio_ctrl*/i_cdnsgpio_subunit/int_value_reg_*_/CP]
set_false_path -from [get_pins u_digital_top/u_gpio_ctrl*/i_cdnsgpio_subunit/int_on_any_reg_*_/CP]

set_false_path -from [get_pins u_digital_top/u_top_clk_core/u_clk_top_mtx_mux/u_cmind_sig_sync_clk_in0_en/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP]
set_false_path -from [get_pins u_digital_top/u_top_clk_core/u_clk_top_mtx_wdg0_asbm_rst_cg/async_clk_gate_u_cmind_sig_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/CP]
set_false_path -from [get_pins u_digital_top/u_top_clk_core/u_clk_top_uart2_apb_cg/async_clk_gate_u_cmind_sig_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/CP]
set_false_path -from [get_pins u_digital_top/u_top_clk_core/u_clk_top_uart3_apb_cg/async_clk_gate_u_cmind_sig_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/CP]


set_false_path -from [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/rtc_vtrim0p8_wen_*_reg_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_rtc_vtrim0p8_wen_*_sync/*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sys_deep_sleep_req_mask_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_dslp_clr_sync/*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/err_clr_reg/CP] -to [get_pins ${DBG_SYS_HIER}a_dbg_main_mtx_lite_wrap/u_dbg_main_mtx_lite_*_mon/GEN_CFG_SYNC*u_err_clr_sync/cmind_sync_buf2*bit2*1*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/monitor_en_reg/CP] -to [get_pins ${DBG_SYS_HIER}a_dbg_main_mtx_lite_wrap/u_dbg_main_mtx_lite_*_mon/GEN_CFG_SYNC*u_err_clr_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_reset_req_eb_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/u_ap_sys_rst_ctrl/u_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_reset_req_eb_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/u_cpu_sys_rst_ctrl/u_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bypass_cnt_rtc_vtrim_*_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_rtc_vtrim0p8_wen_*_sync/*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/ctrl_txres_d1_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/cdnsua_txres_pclk_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_reset_req_eb_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/u_pub_sys_rst_ctrl/u_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dbg_reset_req_eb_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/u_dbg_sys_rst_ctrl/u_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_sys_reset_req_eb_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/u_cp_sys_rst_ctrl/u_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/ctrl_rxres_d1_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/cdnsua_rxres_pclk_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/ctrl_rst_to_d1_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/cdnsua_rst_to_pclk_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_txmtr1/sr_loaded_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_txmtr1/cdnsua_sr_loaded_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_rcvr1/rx_ovre_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_int_ctrl1/cdnsua_uart_int_meta_5/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/int_xvlo_alarm_raw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xvlo_alarm_sync/*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_star_dap/u_dap_top/u_dap_dp/u_dap_dp_pwr/u_cdbgpwrupreq_commit/u_cmind_cell_sdfcn/cmind_uj_cell/CP] -to [get_pins ${DBG_SYS_HIER}u_star_dap/u_dap_top/u_dap_dp/u_dap_dp_pwr/u_cdbgpwrupack_sync/u_cmind_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_mod_ctrl1/uart_ctstx_reg_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_txmtr1/cdnsua_mo_cts_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_rcvr1/inc_rfifo_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_rx_fifo1/cdnsua_inc_rfifo_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/ctrl_rxen_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_rcvr1/cdnsua_ctrl_rxen_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/ctrl_txen_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_txmtr1/cdnsua_ctrl_txen_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_rcvr1/rx_frame_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_int_ctrl1/cdnsua_uart_int_meta_6/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_rcvr1/rx_pare_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_int_ctrl1/cdnsua_uart_int_meta_7/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_dbgsys_glb_reg_rf_top/lpc_en_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_dbg_sys_pmu_top/u_dbg_sys_lpc/GEN_CFG_SYNC*u_err_clr_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/ctrl_txbrk_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_txmtr1/cdnsua_ctrl_txbrk_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/ctrl_rxres_pclk_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/cdnsua_ctrl_rxres_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_rcvr1/rx_timeout_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_int_ctrl1/cdnsua_uart_int_meta_8/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_*_mon/cur_cmd*/CP] -to [get_pins u_digital_top/u_top_main_ahb_mtx_lite_wrap/u_top_main_ahb_mtx_lite_*_mon/u_ahb_rst_n_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_rcvr1/rx_break_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_int_ctrl1/cdnsua_uart_int_meta_13/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_rcvr1/rx_active_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_int_ctrl1/cdnsua_rx_active_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/ctrl_txres_pclk_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/cdnsua_ctrl_txres_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_rx_fifo1/char_to_fifo_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_mode_sw1/cdnsua_char_to_fifo_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/ctrl_rst_to_pclk_reg/CP] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_ctrl1/cdnsua_ctrl_rst_to_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_txmtr1/tx_active_reg/CP ] -to [get_pins ${DBG_SYS_HIER}u_uart_dbg/u_uart/cdnsua_int_ctrl1/cdnsua_tx_active_meta/i_cdns_syncflop/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/busy_clk_245_76m_pre_div_byp_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_aon_pll_en_vote_sync/*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_reset_req_eb_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/u_top_rst_ctrl/u_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/ap_soft_reset_req_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/u_ap_sys_rst_ctrl/u_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/xvlo_alarm_int_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_xvlo_alarm_sync/*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/*_soft_reset_req_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/u_*_sys_rst_ctrl/u_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/*_deep_sleep_req_mask_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_dslp_clr_sync/*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sys_deep_sleep_hold_intl_sw_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_dslp_clr_sync/*sig_in_sync0_reg/cmind_uj_cell/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_pol_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ana*_pwrdn_st_dly_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_topsys_main_apb_dec/u_apb2apb_async_top_top_pmu/s_pactive_reg_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ana*_pwrdn_st_dly_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_latch_reg_latch_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_both_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_mode_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_int_both_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_sync_reg_sync_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/pulse_type_wen_set_d1_reg/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_async_reg_async_int_clr_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_int_pol_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_int_en_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_dbnc_reg_dbnc_trig_start_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_ahb_to_apb_main/wr_reg_reg/CP] -to [get_pins u_digital_top/u_top_eic*/u_eic_rf/eic_latch_reg_latch_int_pol_reg_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_dslp_clr_sync/*sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_rst_core/u_cmind_rst_top_glb_reg_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_glb_reg/prdata_reg_*_/CDN]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_cpll_clk_iso_on_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/intclr_cpu_sys_pwron_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/int_cpu_sys_pwron_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cnt_rtc_vtrim_dly_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_xo_26m_ctrl/u_xo_pwr_ctrl/u_xo_pwr_ctrl_fsm/cnt_done_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_auto_sd_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/cur_pwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana*_pwron_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/reg_ana*_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pwr_bypass_ana*_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pwr_bypass_ana*_pwrdn_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bk_pa_scp_alarm_int_clr_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_ocp_wrap/int_bk_pa_scp_alarm_raw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ana*_pwrdn_st_dly_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_dpll_rst_on_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ldorf_ana_p*_sel_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ldorf_ana_p*_sel_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana*_pwron_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/reg_ana*_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_BUF_ANA_LPF_R_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_BUF_ANA_LPF_R_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_frac_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sys_dummy_pin_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/HEN_VB_XO_IN_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/HEN_VB_XO_IN_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram*_ana_p1_sel_reg_0_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana*_pwron_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana*_pon_cnt_go_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c1_pre_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_lpf_c1_pre_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana*_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/cnt_ana1_poff_match_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_slp_bypass_ana*_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/reg_ana*_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana*_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana*_poff_cnt_go_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ana*_pwrdn_st_dly_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_slp_bypass_ana*_pwron_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_slp_ctrl/reg_ana1_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/hen_xo_buf_sel_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/hen_xo_buf_sel_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/time_dly_cpll_clk_iso_off_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_targ_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sys_dummy_pin_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dig_rc32k_cali_sel_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dig_rc32k_cali_sel_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_pwr_bypass_ana*_pwron_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_ap_sys_pmu/u_pwr_ctrl/cur_anapwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana*_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana1_poff_cnt_go_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bk_pa_scp_alarm_int_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/prdata_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bootmon_start_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/u_boot_mon/cnt_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_bleed_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_bleed_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram*_ana_p1_sel_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram*_ana_p1_sel_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_soft_reset_req_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/pub_sys_soft_reset_req_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_deep_sleep_req_mask_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ap_sys_deep_sleep_req_mask_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana*_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/cnt_ana*_poff_match_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bootmon_num_sel_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/u_boot_mon/reboot_trig_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_ap_sys_wakeup_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_ap_sys_wakeup_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_pwr_bypass_ana*_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana*_poff_cnt_go_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_usb33_en_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_usb33_en_sw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pll_off_bypass_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/reg_pll_en_vote_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_sys_iso_en_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cp_sys_iso_en_sw_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bootmon_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/bootmon_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_ana*_pwr_st_dly_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/sleep_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/hen_xo_buf_ana_sel_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/hen_xo_buf_ana_sel_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram*_slp_mode_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_sysram*_slp_mode_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/nsleep_bgap_reg_sw_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_bg_iso_off_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_OUT_FIXED_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/XO_CAP_OUT_FIXED_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_io_ocp_alarm_int_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ldo_io_ocp_alarm_int_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_pwr_bypass_ana*_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/cur_anapwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_opa_cs_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpll_ldo_opa_cs_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_ap_sys_dslp_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/inten_ap_sys_dslp_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ana_rc32k_cali_start_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/ana_rc32k_cali_start_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_xo_off_bypass_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/reg_xo_en_vote_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_dith_lsb_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cfg_cpll_mash_dith_lsb_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/top_ana*_pwrdn_st_dly_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_sys_pmu/u_top_sys_slp_ctrl/ana_cnt_targ_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_ram_lp_sw_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_sys_ram_lp_sw_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_bypass_ana*_pwrdn_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/reg_ana*_pwr_on_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dig_rc32k_cali_int_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/dig_rc32k_cali_int_en_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_top_pmu_glb_reg/cpu_slp_ana*_pwr_st_dly_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_slp_ctrl/sleep_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/clk_top_mtx_force_eb_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/clk_top_mtx_force_eb_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ahb2ahba_cpu2flash_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ahb2ahba_cpu2flash_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ap2sysram_dbg_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ap2sysram_dbg_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/rft_dbg_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/rft_dbg_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ahb2ahba_ap2cpu_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/sw_ahb2ahba_ap2cpu_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/soft_rst_pub_glb_rf_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/soft_rst_pub_glb_rf_reg/D]
set_false_path -from [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/adc_ecl_dn_dbg_rst_reg/CP] -to [get_pins u_digital_top/u_dbg_sys_top/u_dbgsys_glb_dbg_reg/adc_ecl_dn_dbg_rst_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/u_boot_mon/cnt_en_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_boot_mon_wrap/u_boot_mon/mon_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_en_bg_on_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpll_ctrl/cnt_targ_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/cur_anapwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/cur_anapwr_st_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_pwr_ctrl/cur_pwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cp_sys_pmu/u_pwr_ctrl/reg_shutdown_n_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pwr_ctrl/cur_pwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_pub_sys_pmu/u_pwr_ctrl/pwr_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/cur_anapwr_st_reg_*_/CP] -to [get_pins u_digital_top/u_top_pmu/u_cpu_sys_pmu/u_pwr_ctrl/pwr_ctrl_cnt_reg_*_/D]
set_false_path -from [get_pins u_digital_top/u_top_intc1/u_intc_rf/int_irq_soft_reg/CP] -to [get_pins u_digital_top/u_top_intc1/u_intc_rf/int_irq_soft_reg/D]
set_false_path -from [get_pins u_digital_top/u_top_pmu/u_ana_rc32k_cali_wrap/u_ana_rc32k_cali/u_cali_cnt_comp_pls_sync/cmind_sync_buf2*bit2*1*sync2_rst0*sig_in_sync1_reg/cmind_uj_cell/CP] -to [get_pins u_digital_top/u_top_pmu/u_ana_rc32k_cali_wrap/u_ana_rc32k_cali/rc32k_wait_cnt_reg_*_/D]

if {$IS_FLAT} {
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_key_manage/u_detect_rstkey/rst_key_det_n_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/u_top_rst_ctrl/u_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_turn_on_off_ctrl/u_turn_on_ctrl/fastoff_mask_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_*_sys_pmu/u_dslp_clr_sync/*sig_in_sync0_reg/cmind_uj_cell/D]
}


#-----------------------------------------------------------------
#clock group
#-----------------------------------------------------------------
source $PROJ_DIR/de/common/sdc/clk_group.sdc

