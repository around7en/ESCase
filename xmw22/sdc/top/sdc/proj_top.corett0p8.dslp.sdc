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
    clk_dig_26m_rftop            clk_dig_26m_rftop              $CYCLE_26M           u_rftop/clk_dig_26m
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
#stop dbg source0:26m
set_sense -stop_propagation u_digital_top/u_top_pre_div_src_gate/u_clk_dbg_src_cgs_0_/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#stop dig source3:26m (Not provided to rc33k cali,xo26m_32k)
set_sense -stop_propagation u_digital_top/u_top_pre_div_src_gate/u_clk_src_cgs_3_/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#stop efuse 26m
set_sense -stop_propagation u_digital_top/u_top_pre_div_clk_core/u_clk_26m_efuse_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#stop cpu 32k
set_sense -stop_propagation u_digital_top/u_top_pre_div_clk_core/u_clk_32k_aon_cpu_sys_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#stop pmu 26m,3.25m
set_sense -stop_propagation u_digital_top/u_top_clk_core/u_clk_26m_pmu_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
set_sense -stop_propagation u_digital_top/u_top_for_aon_clk_core/u_clk_3_25m_top_for_aon_div/u_cmind_cell_ckout/cmind_uj_ckcell/Z
#stop mash clk
set_sense -stop_propagation u_digital_top/u_top_clk_core/u_clk_cmash_rft_cg/u_cmind_cell_ckout/cmind_uj_ckcell/CP
#stop slow occ clk
set_sense -stop_propagation u_digital_top/u_ptest_slow_occ_clock/cmind_uj_ckcell/Z
set_sense -stop_propagation u_digital_top/u_ptest_slow_occ_clock_aonrtc_occ_buf/cmind_uj_ckcell/Z
set_sense -stop_propagation u_digital_top/u_ptest_slow_occ_clock_gpio_occ_buf/cmind_uj_ckcell/Z
#stop occ ctrl
set_sense -stop_propagation [get_pins -hierarchical -filter "full_name =~ */occ_control/tessent_persistent_clk_cgc_SHIFT_REG_CLK/cmind_uj_ckcell/CP"]
set_sense -stop_propagation [get_pins -hierarchical -filter "full_name =~ */occ_control/tessent_persistent_cell_ltest_ntc_sync_cell/q_reg/CP"]
set_sense -stop_propagation [get_pins -hierarchical -filter "full_name =~ */occ_control/tessent_persistent_cell_ltest_ntc_sync_cell/ntc_retiming_q_reg_reg/CP"]

#set_sense -stop_propagation -clocks u_digital_top/u_top_pre_div_clk_core/u_clk_26m_xo_cpu_sys_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks u_digital_top/u_top_pre_div_clk_core/u_clk_26m_xo_cp_sys_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks u_digital_top/u_top_pre_div_clk_core/u_clk_26m_pub_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks u_digital_top/u_top_pre_div_clk_core/u_clk_26m_xo_ap_sys_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks u_digital_top/u_top_pre_div_clk_core/u_clk_26m_xo_dbg_sys_cg/u_cmind_cell_ckout/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks u_digital_topu_top_clk_core/u_clk_top_mtx_mux/u_cmind_cell_icg_clk_in1/cmind_uj_ckcell/Q
#set_sense -stop_propagation -clocks u_digital_top/u_top_clk_core/u_clk_sysram_mux/u_cmind_cell_icg_clk_in0/cmind_uj_ckcell/Q
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

if {$IS_FLAT} {
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_key_manage/u_detect_rstkey/rst_key_det_n_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_digtop_por_ctrl/u_top_rst_ctrl/u_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D]
    set_false_path -from [get_pins ${RTC_SYS_HIER}u_xmw_rtc_top/u_rtc_pmu/u_turn_on_off_ctrl/u_turn_on_ctrl/fastoff_mask_reg/CP] -to [get_pins u_digital_top/u_top_pmu/u_*_sys_pmu/u_dslp_clr_sync/*sig_in_sync0_reg/cmind_uj_cell/D]
}

#-----------------------------------------------------------------
#clock group
#-----------------------------------------------------------------
source $PROJ_DIR/de/common/sdc/clk_group.sdc

