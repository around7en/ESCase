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
        set VDD_AON 0.8
    }
}

set WITH_ANLG_DELAY 1

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

#-----------------------------------------------------------------
#virtual clock
#-----------------------------------------------------------------
create_clock -name vclk            -period $CYCLE_26M
lappend CLOCK_GROUP(vclk) vclk

#-----------------------------------------------------------------
#clock from/to pad
#-----------------------------------------------------------------
set IO_TOP_HIER u_digital_top/u_io_top
set IO_AON_HIER $AON_SYS_HIER/u_aon_sys_top/u_aon_io_top
source $PROJ_DIR/de/top/sdc/io_top.var.sdc

#-----------------------------------------------------------------
#clock source
#-----------------------------------------------------------------
#   group                        name                           cycle                hier
set clk_src_msgs "
    clk_dig_122p88m_rftop        rxadc_ck_sar_latch_i_rftop     $CYCLE_122M88        u_rftop/rxadc_ck_sar_latch_i
    clk_dig_122p88m_rftop        rxadc_ck_sar_latch_q_rftop     $CYCLE_122M88        u_rftop/rxadc_ck_sar_latch_q
    rftop_rxadc_clk245m          rftop_rxadc_clk245m            $CYCLE_245M76        u_rftop/rxadc_clk245m
    clk_dig_122p88m_rftop        clk_dig_122p88m_rftop          $CYCLE_122M88        u_rftop/clk_dig_122p88m
    clk_dig_245p76m_rftop        clk_dig_245p76m_rftop          $CYCLE_245M76        u_rftop/clk_dig_245p76m
    clk_dig_26m_rftop            clk_dig_26m_rftop              $CYCLE_26M           u_rftop/clk_dig_26m
    rxpll_ds_26m_clk_rftop       rxpll_ds_26m_clk_rftop         $CYCLE_26M           u_rftop/rxpll_ds_26m_clk
    txpll_ds_26m_clk_rftop       txpll_ds_26m_clk_rftop         $CYCLE_26M           u_rftop/txpll_ds_26m_clk
    cpll_ds_26m_clk_rftop        cpll_ds_26m_clk_rftop          $CYCLE_26M           u_rftop/cpll_ds_26m_clk
    clk_dig_307p2m_rftop         clk_dig_307p2m_rftop           $CYCLE_307M2         u_rftop/clk_dig_307p2m
    clk_dig_409p6m_rftop         clk_dig_409p6m_rftop           $CYCLE_409M6         u_rftop/clk_dig_409p6m
    clk_dig_491p52m_rftop        clk_dig_491p52m_rftop          $CYCLE_491M52        u_rftop/clk_dig_491p52m
    clk_rc32k_anlg               clk_rc32k_anlg                 $CYCLE_1M            u_analog_top/rc32k_clk
    clk_xo32k_anlg               clk_xo32k_anlg                 $CYCLE_1M            u_analog_top/xo32k_clk
    clk_rtc32k_anlg              clk_rtc32k_anlg                $CYCLE_1M            u_analog_top/rtc32k_clk
    analog_auxadc_clk            analog_auxadc_clk              $CYCLE_26M           u_analog_top/auxadc_clk
"

foreach {group name cycle hier} $clk_src_msgs {
    create_clock -name $name -period $cycle -add [get_pins $hier]
    lappend CLOCK_GROUP($group) $name
    set name_$name $name
    set hier_$name $hier
}

#misc clock
#   group                  name                     mstclk                        src                                div     hier
set clk_topsys_msgs "
    ptest_slow_occ_clock   ptest_slow_occ_clock     clk_dig_26m_rftop             u_rftop/clk_dig_26m                1       u_digital_top/u_ptest_slow_occ_clock/cmind_uj_ckcell/Z
"
foreach {group name mstclk src div hier} $clk_topsys_msgs {
    create_generated_clock  \
        -name $name \
        -master_clock $mstclk \
        -source [get_pins $src] \
        -divide_by $div  \
        -add  \
        [get_pins $hier] 
    lappend CLOCK_GROUP($group) $name
    set name_$name $name
    set hier_$name $hier
}

#-----------------------------------------------------------------
#usb pll
#-----------------------------------------------------------------
if {$IS_FLAT} {
    source $PROJ_DIR/de/ap_sys/sdc/ap_sys_pwr_wrap.usbphy_clk.sdc
} else {
    create_clock -name "${AP_SYS_NAME}_SYSCLK240" -period 4 -waveform {0 2} [get_pins "${AP_SYS_HIER}ap_sys_SYSCLK240"]
    set CLOCK_GROUP(${AP_SYS_NAME}_SYSCLK240)        [list ${AP_SYS_NAME}_SYSCLK240]

    #create_clock -name "${AP_SYS_NAME}_PLLCK480M" -period 2 -waveform {0 1} [get_pins "${AP_SYS_HIER}usb2_phy_pllck480"]
    create_clock -name "${AP_SYS_NAME}_PLLCK480M" -period 2 -waveform {0 1} [get_pins "${AP_SYS_HIER}ap_sys_PLLCK480M"]
    set CLOCK_GROUP(${AP_SYS_NAME}_PLLCK480M)        [list ${AP_SYS_NAME}_PLLCK480M]

    create_clock -name "${AP_SYS_NAME}_CLKOSCO_U2_240M_CAL" -period 25 -waveform {0 12.5} [get_pins "${AP_SYS_HIER}${AP_SYS_NAME}_CLKOSCO_U2_240M_CAL"]

    lappend CLOCK_GROUP(ap_sys_SYSCLK240)  ${AP_SYS_HIER}u_ap_sys_top_u_ap_sys_usb2_wrap_u_M31USBH225TL022V_00223601_SYSCLK120 \
                                           ${AP_SYS_HIER}u_ap_sys_top_u_ap_sys_usb2_wrap_u_M31USBH225TL022V_00223601_U20_CLK60 
    lappend CLOCK_GROUP(ap_sys_CLKOSCO_U2_240M_CAL)  ${AP_SYS_NAME}_CLKOSCO_U2_240M_CAL \
                                                     ${AP_SYS_HIER}u_ap_sys_top_u_ap_sys_usb2_wrap_u_M31USBH225TL022V_00223601_CLKOSCO_U2_120M_CAL
}

#-----------------------------------------------------------------
#mbist
#-----------------------------------------------------------------
source  $PROJ_DIR/de/top/sdc/proj_top.mbist.sdc

#-----------------------------------------------------------------
#clock for aon
#-----------------------------------------------------------------
set name_clk_26m_top_for_aon $name_clk_dig_26m_rftop
set hier_clk_26m_top_for_aon $hier_clk_dig_26m_rftop
set TOP_FOR_AON_CLK_CORE_HIER "u_digital_top/u_top_for_aon_clk_core"
if {$IS_FLAT} {
    set name_clk_32k_top_for_aon clk_rtc32k_anlg
    set hier_clk_32k_top_for_aon u_analog_top/rtc32k_clk
} else {
    set name_clk_32k_top_for_aon ${RTC_SYS_HIER}clk_rtc32k_top
    set hier_clk_32k_top_for_aon ${RTC_SYS_HIER}clk_rtc32k_top
}
source $PROJ_DIR/de/top/sdc/top_for_aon_clk_core.sdc

#-----------------------------------------------------------------
#aon div
#-----------------------------------------------------------------
#aon_sys
if {$IS_FLAT} {
    if {$VDD_AON==0.8} {
        source $PROJ_DIR/de/aon_sys/sdc/aon_sys_pwr_wrap.func.TT0P80V.sdc
        source $PROJ_DIR/de/aon_sys/sdc/xmw_rtc_pwr_wrap.func.TT0P80V.sdc
    } else {
        source $PROJ_DIR/de/aon_sys/sdc/aon_sys_pwr_wrap.func.TT0P70V.sdc
        source $PROJ_DIR/de/aon_sys/sdc/xmw_rtc_pwr_wrap.func.TT0P70V.sdc
    }
} else {
    if {$VDD_AON==0.8} {
        source  $PROJ_DIR/de/top/sdc/subsys_group/aon_sys_group.tcl
        source  $PROJ_DIR/de/top/sdc/subsys_group/rtc_sys_group.tcl
    } else {
        source  $PROJ_DIR/de/top/sdc/subsys_group/aon_sys_group.dslp.tcl
        source  $PROJ_DIR/de/top/sdc/subsys_group/rtc_sys_group.dslp.tcl
    }
    ##   group                     name                          mstclk                        src                                div     hier
    #set clk_aonsys_msgs "
    #    ${AON_SYS_NAME}_clk_26m   ${AON_SYS_NAME}_clk_26m       $name_clk_dig_26m_rftop       u_rftop/clk_dig_26m                1       ${AON_SYS_HIER}clk_26m
    #    ${AON_SYS_NAME}_clk_32k   ${AON_SYS_NAME}_clk_32k       $name_clk_rtc32k_anlg         u_analog_top/rtc32k_clk            1       ${AON_SYS_HIER}clk_32k
    #    ${AON_SYS_NAME}_clk_15k   ${AON_SYS_NAME}_clk_15k       $name_clk_rtc32k_anlg         u_analog_top/rtc32k_clk            1       ${AON_SYS_HIER}clk_15k
    #"
    #foreach {group name mstclk src div hier} $clk_aonsys_msgs {
    #    create_generated_clock  \
    #        -name $name \
    #        -master_clock $mstclk \
    #        -source [get_pins $src] \
    #        -divide_by $div  \
    #        -add  \
    #        [get_pins $hier] 
    #    lappend CLOCK_GROUP($group) $name
    #}
    #impl guide
    source $PROJ_DIR/de/aon_sys/sdc/impl_guide/aon_sys_pwr_wrap.func.dont_touch.tcl
    source $PROJ_DIR/de/aon_sys/sdc/impl_guide/xmw_rtc_pwr_wrap.func.dont_touch.tcl
}

#-----------------------------------------------------------------
#clock prediv
#-----------------------------------------------------------------
set name_clk_245_76m_top_pre_div $name_clk_dig_245p76m_rftop
set hier_clk_245_76m_top_pre_div $hier_clk_dig_245p76m_rftop
set name_clk_409_6m_top_pre_div $name_clk_dig_409p6m_rftop
set hier_clk_409_6m_top_pre_div $hier_clk_dig_409p6m_rftop
set name_clk_307_2m_top_pre_div $name_clk_dig_307p2m_rftop
set hier_clk_307_2m_top_pre_div $hier_clk_dig_307p2m_rftop
set name_clk_26m_top_pre_div $name_clk_dig_26m_rftop
set hier_clk_26m_top_pre_div $hier_clk_dig_26m_rftop
set name_clk_26m_dbg_src $name_clk_dig_26m_rftop
set hier_clk_26m_dbg_src $hier_clk_dig_26m_rftop
set name_clk_32k_top_pre_div top_for_aon_clk_32k
set hier_clk_32k_top_pre_div ${TOP_FOR_AON_CLK_CORE_HIER}/u_clk_32k_mux/$CKOUTZ_HIER
set name_clk_32k_dbg_src top_for_aon_clk_32k
set hier_clk_32k_dbg_src ${TOP_FOR_AON_CLK_CORE_HIER}/u_clk_32k_mux/$CKOUTZ_HIER
set name_clk_26m $name_clk_dig_26m_rftop
set hier_clk_26m $hier_clk_dig_26m_rftop

if {$IS_FLAT} {
    set name_clk_15k_top_pre_div ${AON_SYS_NAME}_clk_15k
    set hier_clk_15k_top_pre_div ${AON_SYS_HIER}u_aon_sys_els_wrap/AON2TOP_LVL*120*u_LVLSRLHSGD4BWP7T40P140HVT/Z
} else {
    set name_clk_15k_top_pre_div ${AON_SYS_HIER}clk_15k
    set hier_clk_15k_top_pre_div ${AON_SYS_HIER}clk_15k
}
set name_clk_491_52m_top_pre_div $name_clk_dig_491p52m_rftop
set hier_clk_491_52m_top_pre_div $hier_clk_dig_491p52m_rftop
set name_clk_480m_top_pre_div ap_sys_PLLCK480M
if {$IS_FLAT} {
    set hier_clk_480m_top_pre_div [get_pins "u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_usb2_wrap/u_M31USBH225TL022V_00223601/PLLCK480M"]
} else {
    #set hier_clk_480m_top_pre_div ${AP_SYS_HIER}usb2_phy_pllck480
    set hier_clk_480m_top_pre_div ${AP_SYS_HIER}ap_sys_PLLCK480M
}
set TOP_PRE_DIV_CLK_CORE_HIER "u_digital_top/u_top_pre_div_clk_core"

source $PROJ_DIR/de/top/sdc/top_pre_div_clk_core.sdc
source $PROJ_DIR/de/aon_sys/sdc/aon_sys_pwr_wrap.frc_top.TT0P80V.sdc

#-----------------------------------------------------------------
#topsys clock
#-----------------------------------------------------------------
#clock core
set TOP_CLK_CORE_HIER "u_digital_top/u_top_clk_core"
source $PROJ_DIR/de/top/sdc/top_clk_core.sdc

#clk aux
#set name_clk_rfdac_122_88m $name_clk_dig_122p88m_rftop
#set hier_clk_rfdac_122_88m $hier_clk_dig_122p88m_rftop
#set name_clk_rfadci_122_88m $name_rxadc_ck_sar_latch_i_rftop
#set hier_clk_rfadci_122_88m $hier_rxadc_ck_sar_latch_i_rftop
#set name_clk_rfadcq_122_88m $name_rxadc_ck_sar_latch_q_rftop
#set hier_clk_rfadcq_122_88m $hier_rxadc_ck_sar_latch_q_rftop
#set name_clk_rfadc2x_245_76m $name_rftop_rxadc_clk245m
#set hier_clk_rfadc2x_245_76m $hier_rftop_rxadc_clk245m
#for {set i 0} {$i < 3} {incr i 1} {
set name_clk_aon_frc $name_clk_19_2m_top_pre_div
set hier_clk_aon_frc $hier_clk_19_2m_top_pre_div
set TOP_AUX_CLK_CORE_HIER "u_digital_top/u_top_aux_clk_core"
source $PROJ_DIR/de/top/sdc/top_aux_clk_core.sdc
#}

#misc clock
#   group                     name                     mstclk                        src                                                                                            div     hier
set clk_topsys_msgs "
    top_pre_div_clk_26m_efuse clk_efuse_strobe         $name_clk_26m_efuse           ${TOP_PRE_DIV_CLK_CORE_HIER}/u_clk_26m_efuse_cg/$CKOUTQ_HIER                                   6       u_digital_top/u_top_efuse_ctrl/u_efuse_ctrl/STROBE_reg/Q
"
foreach {group name mstclk src div hier} $clk_topsys_msgs {
    create_generated_clock  \
        -name $name \
        -master_clock $mstclk \
        -source [get_pins $src] \
        -divide_by $div  \
        -add  \
        [get_pins $hier] 
    lappend CLOCK_GROUP($group) $name
}

##clk from auxadc
#create_clock -name analog_auxadc_clk -period $CYCLE_26M -add [get_pins u_analog_top/auxadc_clk]
#lappend CLOCK_GROUP(analog_auxadc_clk) analog_auxadc_clk

#-----------------------------------------------------------------
#subsys
#-----------------------------------------------------------------
#dbg_sys
source  $PROJ_DIR/de/dbg_sys/sdc/dbg_sys_top.func.TT0P80V.sdc
#if {$IS_FLAT} {
    #cpu_sys
    source  $PROJ_DIR/de/cpu_sys/sdc/cpu_sys_pwr_wrap.func.TT0P80V.sdc
    #ap_sys
    source  $PROJ_DIR/de/ap_sys/sdc/ap_sys_pwr_wrap.func.TT0P80V.sdc
    #cp_sys 
    set name_clk_adc_1x_i_ana_in $name_rxadc_ck_sar_latch_i_rftop
    set hier_clk_adc_1x_i_ana_in $hier_rxadc_ck_sar_latch_i_rftop
    set name_clk_adc_1x_q_ana_in $name_rxadc_ck_sar_latch_q_rftop
    set hier_clk_adc_1x_q_ana_in $hier_rxadc_ck_sar_latch_q_rftop
    set name_clk_adc_2x_ana_in   $name_rftop_rxadc_clk245m
    set hier_clk_adc_2x_ana_in   $hier_rftop_rxadc_clk245m
    set name_clk_dac_ana_in      $name_clk_dig_122p88m_rftop
    set hier_clk_dac_ana_in      $hier_clk_dig_122p88m_rftop
    source  $PROJ_DIR/de/cp_sys/sdc/cp_sys_pwr_wrap.func.TT0P80V.sdc
    #pub_sys
    source  $PROJ_DIR/de/pub_sys/sdc/pub_sys_pwr_wrap.func.TT0P80V.sdc
#} else {
#    #cpu_sys
#    source  $PROJ_DIR/de/top/sdc/subsys_group/cpu_sys_group.tcl
#    #ap_sys
#    source  $PROJ_DIR/de/top/sdc/subsys_group/ap_sys_group.tcl
#    #cp_sys
#    source  $PROJ_DIR/de/top/sdc/subsys_group/cp_sys_group.tcl
#    #pub_sys
#    #create_clock -name psram_ctrl_dqs_i_0            -period $CYCLE_204M8          -add [get_ports DQS]
#    #lappend CLOCK_GROUP(pub_psram_ctrl_dqs0)  psram_ctrl_dqs_i_0
#    source  $PROJ_DIR/de/top/sdc/subsys_group/pub_sys_group.tcl
#
#    #impl_guide
#    source $PROJ_DIR/de/cp_sys/sdc/impl_guide/cp_sys_pwr_wrap.func.dont_touch.tcl
#}

#-----------------------------------------------------------------
#IO
#-----------------------------------------------------------------
#----------------------------------
#tlb
#----------------------------------
set clk_tlb_sclk_pad_in            clk_tlb_sclk_pad_in
create_clock -name $clk_tlb_sclk_pad_in            -period $CYCLE_26M          -add [get_ports $func_pad_names(tlb_sclk)]
lappend CLOCK_GROUP($clk_tlb_sclk_pad_in) $clk_tlb_sclk_pad_in
#-max
set_input_delay  -max -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.5]        [get_ports $func_pad_names(tlb_sd2)];#tlb_sd2
set_output_delay -max -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.32]       [get_ports $func_pad_names(tlb_sd2)];#tlb_sd2
set_input_delay  -max -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.5]        [get_ports $func_pad_names(tlb_sd3)];#tlb_sd3
set_output_delay -max -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.32]       [get_ports $func_pad_names(tlb_sd3)];#tlb_sd3
set_input_delay  -max -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.5]        [get_ports $func_pad_names(tlb_scs)];#tlb_scs
set_input_delay  -max -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.5]        [get_ports $func_pad_names(tlb_sd0)];#tlb_sd0
set_output_delay -max -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.32]       [get_ports $func_pad_names(tlb_sd0)];#tlb_sd0
set_input_delay  -max -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.5]        [get_ports $func_pad_names(tlb_sd1)];#tlb_sd1
set_output_delay -max -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.32]       [get_ports $func_pad_names(tlb_sd1)];#tlb_sd1
#-min
set_input_delay  -min -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.05]       [get_ports $func_pad_names(tlb_sd2)];#tlb_sd2
set_output_delay -min -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.0]        [get_ports $func_pad_names(tlb_sd2)];#tlb_sd2
set_input_delay  -min -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.05]       [get_ports $func_pad_names(tlb_sd3)];#tlb_sd3
set_output_delay -min -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.0]        [get_ports $func_pad_names(tlb_sd3)];#tlb_sd3
set_input_delay  -min -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.05]       [get_ports $func_pad_names(tlb_scs)];#tlb_scs
set_input_delay  -min -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.05]       [get_ports $func_pad_names(tlb_sd0)];#tlb_sd0
set_output_delay -min -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.0]        [get_ports $func_pad_names(tlb_sd0)];#tlb_sd0
set_input_delay  -min -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.05]       [get_ports $func_pad_names(tlb_sd1)];#tlb_sd1
set_output_delay -min -clock $clk_tlb_sclk_pad_in            -add_delay [expr $CYCLE_26M*0.0]        [get_ports $func_pad_names(tlb_sd1)];#tlb_sd1

source $PROJ_DIR/de/top/sdc/io_top.clk.sdc

##add virtual clk io delay,just for remove rtlcheck error
#set_input_delay  -clock vclk       -add_delay 0.1        [get_ports -filter "@port_direction == in" *]
#set_input_delay  -clock vclk       -add_delay 0.1        [get_ports -filter "@port_direction == inout" *]
##set_output_delay -clock vclk       -add_delay 0.1        [get_ports -filter "@port_direction == out" *]
#set_output_delay -clock vclk       -add_delay 0.1        [get_ports -filter "@port_direction == inout" *]

#constrain max delay for PAD
set_input_delay  -clock top_clk_top_mtx      -add_delay 0        [get_ports -filter "@port_direction == in" *]
set_input_delay  -clock top_clk_top_mtx      -add_delay 0        [get_ports -filter "@port_direction == inout" *]
#set_output_delay -clock top_clk_top_mtx       -add_delay 0        [get_ports -filter "@port_direction == out" *]
set_output_delay -clock top_clk_top_mtx      -add_delay 0        [get_ports -filter "@port_direction == inout" *]
set_multicycle_path  2 -setup -end -from [get_ports -filter "@port_direction == in" *]     -to [get_clocks top_clk_top_mtx]
#set_multicycle_path  1 -hold  -end -from [get_ports -filter "@port_direction == in" *]     -to [get_clocks top_clk_top_mtx]
set_multicycle_path  2 -setup -end -from [get_ports -filter "@port_direction == inout" *]  -to [get_clocks top_clk_top_mtx]
#set_multicycle_path  1 -hold  -end -from [get_ports -filter "@port_direction == inout" *]  -to [get_clocks top_clk_top_mtx]
#set_multicycle_path  2 -setup -end -from [get_clocks top_clk_top_mtx]     -to [get_ports -filter "@port_direction == out" *]
#set_multicycle_path  1 -hold  -end -from [get_clocks top_clk_top_mtx]     -to [get_ports -filter "@port_direction == out" *]
set_multicycle_path  2 -setup -end -from [get_clocks top_clk_top_mtx]     -to [get_ports -filter "@port_direction == inout" *]
#set_multicycle_path  1 -hold  -end -from [get_clocks top_clk_top_mtx]     -to [get_ports -filter "@port_direction == inout" *]

set_false_path -hold -from [get_ports -filter "@port_direction == in" *]     -to [get_clocks top_clk_top_mtx]
set_false_path -hold -from [get_ports -filter "@port_direction == inout" *]  -to [get_clocks top_clk_top_mtx]
set_false_path -hold -from [get_clocks top_clk_top_mtx]     -to [get_ports -filter "@port_direction == inout" *]

#-----------------------------------------------------------------
#exception
#-----------------------------------------------------------------
if {$WITH_ANLG_DELAY} {
    set_output_delay -clock $name_clk_26m_top      -max       -add_delay 0.2        [get_pins u_analog_top/dacpa_data]
    set_input_delay  -clock analog_auxadc_clk      -max       -add_delay 0.5        [get_pins u_analog_top/auxadc_data]
    set_input_delay  -clock analog_auxadc_clk      -max       -add_delay 0.5        [get_pins u_analog_top/auxadc_data_valid]

    set_output_delay -clock $name_clk_26m_top      -min       -add_delay 0.0        [get_pins u_analog_top/dacpa_data]
    set_input_delay  -clock analog_auxadc_clk      -min       -add_delay 0.0        [get_pins u_analog_top/auxadc_data]
    set_input_delay  -clock analog_auxadc_clk      -min       -add_delay 0.0        [get_pins u_analog_top/auxadc_data_valid]
    source $PROJ_DIR/de/top/sdc/rftop.io.sdc
}

#-----------------------------------------------------------------
#exception
#-----------------------------------------------------------------
set_case_analysis 0 u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_ptest_scan_en/cmind_uj_cell/Z

#top memory
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_ra1up_ema_0/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_ra1up_ema_1/cmind_uj_cell/Z]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_ra1up_ema_2/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_ra1up_emaw_0/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_ra1up_emaw_1/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_ra1up_emas/cmind_uj_cell/Z]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_ra1up_rawl/cmind_uj_cell/Z]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_ra1up_rawlm_0/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_ra1up_rawlm_1/cmind_uj_cell/Z]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_ra1up_wabl/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_ra1up_wablm_0/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_ra1up_wablm_1/cmind_uj_cell/Z]

set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_ra1up_ema_0/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_ra1up_ema_1/cmind_uj_cell/Z]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_ra1up_ema_2/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_ra1up_emaw_0/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_ra1up_emaw_1/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_ra1up_emas/cmind_uj_cell/Z]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_ra1up_rawl/cmind_uj_cell/Z]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_ra1up_rawlm_0/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_ra1up_rawlm_1/cmind_uj_cell/Z]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_ra1up_wabl/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_ra1up_wablm_0/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_ra1up_wablm_1/cmind_uj_cell/Z]

set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_ra1up_ema_0/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_ra1up_ema_1/cmind_uj_cell/Z]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_ra1up_ema_2/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_ra1up_emaw_0/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_ra1up_emaw_1/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_ra1up_emas/cmind_uj_cell/Z]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_ra1up_rawl/cmind_uj_cell/Z]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_ra1up_rawlm_0/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_ra1up_rawlm_1/cmind_uj_cell/Z]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_ra1up_wabl/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_ra1up_wablm_0/cmind_uj_cell/Z]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_ra1up_wablm_1/cmind_uj_cell/Z]

#set_case_analysis 0 [get_pins u_digital_top/u_analog_dm_core_wrap/u_analog_rf_top/dacwpa_buf_arb_reg/Q]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_topsys_sysram_typea_sysram_32768x32_wrap_0/u_T22ARA1UP8192X32K2M16BSAP_*/RET1N]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_topsys_sysram_typea_sysram_32768x32_wrap_0/u_T22ARA1UP8192X32K2M16BSAP_*/RET2N]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank0/u_topsys_sysram_typea/u_topsys_sysram_typea_sysram_32768x32_wrap_0/u_T22ARA1UP8192X32K2M16BSAP_*/PGEN]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_topsys_sysram_typea_sysram_32768x32_wrap_0/u_T22ARA1UP8192X32K2M16BSAP_*/RET1N]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_topsys_sysram_typea_sysram_32768x32_wrap_0/u_T22ARA1UP8192X32K2M16BSAP_*/RET2N]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typea/u_topsys_sysram_typea_sysram_32768x32_wrap_0/u_T22ARA1UP8192X32K2M16BSAP_*/PGEN]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_topsys_sysram_typeb_sysram_2048x32_wrap_0/u_T22ARA1UP2048X32K2M4BHAP_0/RET1N]
set_case_analysis 1 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_topsys_sysram_typeb_sysram_2048x32_wrap_0/u_T22ARA1UP2048X32K2M4BHAP_0/RET2N]
set_case_analysis 0 [get_pins u_digital_top/u_sysram_top/u_sys_spram_bank1/u_topsys_sysram_typeb/u_topsys_sysram_typeb_sysram_2048x32_wrap_0/u_T22ARA1UP2048X32K2M4BHAP_0/PGEN]

#check posedge clk timing only,negedge is backup
set_case_analysis 1 [get_pins u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/u_rx_dat_ckmux2/cmind_uj_ckcell/S]

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
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_top_pmu_dft/u_*_shutdown_n/cmind_uj_cell/Z]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_io_deep_sleep/u_*_io_deep_sleep/cmind_uj_cell/Z]

#set_false_path -to [get_pins $TOP_PRE_DIV_CLK_CORE_HIER/u_clk_src_cpll_491_52m_div5/u_cmind_cell_icg_clk_in/cmind_uj_ckcell/*]
#set_false_path -to [get_pins $TOP_PRE_DIV_CLK_CORE_HIER/u_clk_src_cpll_491_52m_div5/clk_cnt_reg_1_/*]
#set_false_path -to [get_pins $TOP_PRE_DIV_CLK_CORE_HIER/u_clk_src_cpll_491_52m_div5/clk_cnt_reg_0_/*]
#set_false_path -to [get_pins $TOP_PRE_DIV_CLK_CORE_HIER/u_clk_src_cpll_491_52m_div5/clk_cnt_reg_2_/*]
#set_false_path -to [get_pins $TOP_PRE_DIV_CLK_CORE_HIER/u_clk_src_cpll_491_52m_div5/clk_div_f_reg/*]
#set_false_path -to [get_pins $TOP_PRE_DIV_CLK_CORE_HIER/u_clk_src_cpll_491_52m_div5/clk_div_r_reg/*]
#set_false_path -to [get_pins $TOP_PRE_DIV_CLK_CORE_HIER/u_clk_src_cpll_491_52m_div5/u_cmind_sig_sync_clk_en/cmind_sync_buf2_genblk1_0__cmind_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/*]
#set_false_path -to [get_pins $TOP_PRE_DIV_CLK_CORE_HIER/u_clk_src_cpll_491_52m_div5/u_cmind_rst_sync_rst_n/u_cmind_sig_sync_rst_n/cmind_sync_buf2_genblk1_0__cmind_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/*]

#set_clock_sense -stop_propagation [get_pins ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_IISMCK_C_buf/cmind_uj_cell/Z]
#set_clock_sense -stop_propagation [get_pins ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_IISCLK_C_buf/cmind_uj_cell/Z]
#set_clock_sense -stop_propagation [get_pins ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_SIM1_CLK_C_buf/cmind_uj_cell/Z]
#set_clock_sense -stop_propagation [get_pins ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_SIM0_CLK_C_buf/cmind_uj_cell/Z]
#set_clock_sense -stop_propagation [get_pins ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_CAM_SPI_CLK_C_buf/cmind_uj_cell/Z]
#set_clock_sense -stop_propagation [get_pins ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_CAM_MCLK_C_buf/cmind_uj_cell/Z]
#set_clock_sense -stop_propagation [get_pins ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_SWCLK_C_buf/cmind_uj_cell/Z]
#set_clock_sense -stop_propagation [get_pins ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_AUXCLK0_C_buf/cmind_uj_cell/Z]
#set_clock_sense -stop_propagation [get_pins ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_EXTINT3_C_buf/cmind_uj_cell/Z]
#set_clock_sense -stop_propagation [get_pins ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_SPI2_CLK_C_buf/cmind_uj_cell/Z]
#set_clock_sense -stop_propagation [get_pins ${IO_TOP_HIER}/u_io_group_digital_mux/u_buf_FEIO0_C_buf/cmind_uj_cell/Z]

#set_sense -stop_propagation -clocks [get_clock ap_sys_spi1_sclk_in_SPI2_CLK] u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_tlb_sclk/cmind_uj_ckcell/I0

#efuse muticycle
set_multicycle_path 6 -setup -end -from [get_clocks clk_efuse_strobe] -to [get_clocks $name_clk_26m_efuse]
set_multicycle_path 5 -hold -end -from [get_clocks clk_efuse_strobe] -to [get_clocks $name_clk_26m_efuse]

set_false_path -to [get_pins u_digital_top/u_efuse_macro/PD]
set_false_path -to [get_pins u_digital_top/u_efuse_macro/PS]

set_false_path -to [get_pins u_digital_top/u_efuse_macro/A*] -hold
set_false_path -to [get_pins u_digital_top/u_efuse_macro/MR] -hold
set_false_path -to [get_pins u_digital_top/u_efuse_macro/CSB] -hold
set_false_path -to [get_pins u_digital_top/u_efuse_macro/PGENB] -hold
set_false_path -to [get_pins u_digital_top/u_efuse_macro/LOAD] -hold

set_sense -stop_propagation -clocks clk_efuse_strobe u_digital_top/u_top_efuse_ctrl/u_efuse_ctrl/STROBE_reg/D

##iomux exp
#set_false_path -from clk_tlb_sclk_pad_in -th u_digital_top/u_ap_sys_pwr_wrap/spi2_miso_oen
#set_false_path -from clk_tlb_sclk_pad_in -th u_digital_top/u_ap_sys_pwr_wrap/spi1_miso_oen
#set_false_path -from clk_tlb_sclk_pad_in -th u_digital_top/u_ap_sys_pwr_wrap/spi1_miso_out
#set_false_path -from clk_tlb_sclk_pad_in -th u_digital_top/u_ap_sys_pwr_wrap/spi2_miso_out
#set_false_path -from clk_tlb_sclk_pad_in -th u_digital_top/u_ap_sys_pwr_wrap/spi2_nss_in
#set_false_path -from clk_tlb_sclk_pad_in -th u_digital_top/u_ap_sys_pwr_wrap/spi1_nss_in

if {!$IS_FLAT} {
    #TODO:move to apsys
    #set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi0_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi0_miso_out -to u_digital_top/u_ap_sys_pwr_wrap/spi0_sclk_out
    #set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi0_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi0_mosi_out -to u_digital_top/u_ap_sys_pwr_wrap/spi0_sclk_out
    #set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi0_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi0_mosi_oen -to u_digital_top/u_ap_sys_pwr_wrap/spi0_sclk_out
    #set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi0_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi0_miso_oen -to u_digital_top/u_ap_sys_pwr_wrap/spi0_sclk_out
    #set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi0_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi0_nss_oen  -to u_digital_top/u_ap_sys_pwr_wrap/spi0_sclk_out
    #set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi0_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi0_nss_out  -to u_digital_top/u_ap_sys_pwr_wrap/spi0_sclk_out
    #set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi0_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi0_miso_out -to u_digital_top/u_ap_sys_pwr_wrap/spi0_sclk_out
    #set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi0_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi0_mosi_out -to u_digital_top/u_ap_sys_pwr_wrap/spi0_sclk_out
    #set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi0_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi0_mosi_oen -to u_digital_top/u_ap_sys_pwr_wrap/spi0_sclk_out
    #set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi0_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi0_miso_oen -to u_digital_top/u_ap_sys_pwr_wrap/spi0_sclk_out
    #set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi0_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi0_nss_oen  -to u_digital_top/u_ap_sys_pwr_wrap/spi0_sclk_out
    #set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi0_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi0_nss_out  -to u_digital_top/u_ap_sys_pwr_wrap/spi0_sclk_out
    
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi1_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi1_miso_out -to u_digital_top/u_ap_sys_pwr_wrap/spi1_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi1_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi1_mosi_out -to u_digital_top/u_ap_sys_pwr_wrap/spi1_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi1_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi1_mosi_oen -to u_digital_top/u_ap_sys_pwr_wrap/spi1_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi1_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi1_miso_oen -to u_digital_top/u_ap_sys_pwr_wrap/spi1_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi1_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi1_nss_oen  -to u_digital_top/u_ap_sys_pwr_wrap/spi1_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi1_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi1_nss_out  -to u_digital_top/u_ap_sys_pwr_wrap/spi1_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi1_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi1_miso_out -to u_digital_top/u_ap_sys_pwr_wrap/spi1_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi1_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi1_mosi_out -to u_digital_top/u_ap_sys_pwr_wrap/spi1_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi1_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi1_mosi_oen -to u_digital_top/u_ap_sys_pwr_wrap/spi1_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi1_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi1_miso_oen -to u_digital_top/u_ap_sys_pwr_wrap/spi1_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi1_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi1_nss_oen  -to u_digital_top/u_ap_sys_pwr_wrap/spi1_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi1_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi1_nss_out  -to u_digital_top/u_ap_sys_pwr_wrap/spi1_sclk_out
    
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi2_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi2_miso_out -to u_digital_top/u_ap_sys_pwr_wrap/spi2_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi2_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi2_mosi_out -to u_digital_top/u_ap_sys_pwr_wrap/spi2_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi2_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi2_mosi_oen -to u_digital_top/u_ap_sys_pwr_wrap/spi2_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi2_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi2_miso_oen -to u_digital_top/u_ap_sys_pwr_wrap/spi2_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi2_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi2_nss_oen  -to u_digital_top/u_ap_sys_pwr_wrap/spi2_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi2_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi2_nss_out  -to u_digital_top/u_ap_sys_pwr_wrap/spi2_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi2_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi2_miso_out -to u_digital_top/u_ap_sys_pwr_wrap/spi2_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi2_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi2_mosi_out -to u_digital_top/u_ap_sys_pwr_wrap/spi2_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi2_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi2_mosi_oen -to u_digital_top/u_ap_sys_pwr_wrap/spi2_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi2_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi2_miso_oen -to u_digital_top/u_ap_sys_pwr_wrap/spi2_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi2_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi2_nss_oen  -to u_digital_top/u_ap_sys_pwr_wrap/spi2_sclk_out
    set_false_path -from u_digital_top/u_ap_sys_pwr_wrap/ap_sys_clk_spi2_apb -th u_digital_top/u_ap_sys_pwr_wrap/spi2_nss_out  -to u_digital_top/u_ap_sys_pwr_wrap/spi2_sclk_out
}

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

#iomux
set_disable_clock_gating_check [get_cells -hierarchical -filter "full_name =~ u_digital_top/u_io_top/u_io_group_digital_mux/* && is_hierarchical == false"]
#set_sense -stop_propagation -clocks [get_clock DQS_CK] u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_psram_dqs/cmind_uj_ckcell/I0
#set_sense -stop_propagation -clocks [get_clock DQS_CK] u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_DQS_C_ckbuf/cmind_uj_ckcell/I 

#foreach mpin [get_pins u_digital_top/u_gpio_ctrl?/i_cdnsgpio_subunit/gen_sync_*__i_cdns_syncflop/cmind_sync_buf2_bit2_0__sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D] {
#    set_sense -stop_propagation $mpin
#}

#iso en & bootrom slp
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_top_pmu_dft/u_cpu_iso_en/cmind_uj_cell/Z]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_top_pmu_dft/u_ap_iso_en/cmind_uj_cell/Z]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_top_pmu_dft/u_cp_iso_en/cmind_uj_cell/Z]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_top_pmu_dft/u_pub_iso_en/cmind_uj_cell/Z]
set_false_path -through [get_pins u_digital_top/u_top_pmu/u_top_pmu_dft/u_bootrom_slp/cmind_uj_cell/Z]

#sys shutdown n
set_false_path -through [get_pins u_digital_top/u_cpu_sys_pwr_wrap/cpusys_shutdown_n]
set_false_path -through [get_pins u_digital_top/u_ap_sys_pwr_wrap/apsys_shutdown_n]
set_false_path -through [get_pins u_digital_top/u_cp_sys_pwr_wrap/cp_shutdown_n]
set_false_path -through [get_pins u_digital_top/u_pub_sys_pwr_wrap/pubsys_shutdown_n]

set_false_path -through [get_pins u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_ptest_scan_rst_n/cmind_uj_cell/I]
set_sense -stop_propagation u_digital_top/u_io_top/u_io_group_digital_mux/u_buf_sysram1_ram_slp/cmind_uj_cell/I
set_sense -stop_propagation u_digital_top/u_analog_dm_core_wrap/u_analog_auxadc_ctrl/u_clk_adc_mux/cmind_uj_cell/Z
set_sense -stop_propagation u_digital_top/u_top_pmu/u_clk_strappin_dbuf/cmind_uj_cell/I
set_sense -stop_propagation u_digital_top/u_top_pmu/u_ana_rc32k_cali_wrap/u_ana_rc32k_cali/u_clk_rc32k_dand/cmind_uj_cell/Z

#dont touch
source $PROJ_DIR/de/top/sdc/impl_guide/proj_top.func.dont_touch.tcl

source $PROJ_DIR/de/top/sdc/proj_top.data_chk.sdc

#false_path to async rst
set_false_path -to [get_pins -hierarchical -filter "full_name =~ */u_cmind_sig_sync_rst_n/cmind_sync_buf2*bit*0*sync2_rst0*sig_in_sync*_reg/cmind_uj_cell/CDN"]
#false_path to async clk gate
set_false_path -to [get_pins -hierarchical -filter "full_name =~ */async_clk_gate*u_cmind_sig_sync/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D"]
#false_path to clk_sw en
set_false_path -to [get_pins -hierarchical -filter "full_name =~ */u_cmind_sig_sync_clk_in*_en/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D"]
#false_path to clk div en
set_false_path -to [get_pins -hierarchical -filter "full_name =~ */u_cmind_sig_sync_clk_en/cmind_sync_buf2*bit2*0*sync2_rst0*sig_in_sync0_reg/cmind_uj_cell/D"]

##set_false_path -th u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/u_clk_ckmux2/cmind_uj_ckcell/S
#set_case_analysis 1 u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/u_clk_ckmux2/cmind_uj_ckcell/S
##set_case_analysis 0 u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_iomap/U2/S 
#set_disable_timing  u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_iomap/U2 -from S -to Z

#hold vio fix
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

    set_multicycle_path 2 -setup -from [get_pins ${CPU_SYS_HIER}u_cpu_sys_top/u_cpu2flash_ahb_async/u_buffer_ctrl/u_rdata_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync_buf2_bit2_3__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to  [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_flash_main_mtx_wrap/u_flash_main_mtx_lite_m0_mon/u_ahb_rst_n_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
    set_multicycle_path 1 -hold -from [get_pins ${CPU_SYS_HIER}u_cpu_sys_top/u_cpu2flash_ahb_async/u_buffer_ctrl/u_rdata_async_fifo/u_write_ctrl/u_raddr_gray_sync/cmind_sync_buf2_bit2_3__genblk1_sync2_rst0_sig_in_sync1_reg/cmind_uj_cell/CP] -to  [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_flash_main_mtx_wrap/u_flash_main_mtx_lite_m0_mon/u_ahb_rst_n_sync/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D]
}

#-----------------------------------------------------------------
#clock group
#-----------------------------------------------------------------
source $PROJ_DIR/de/common/sdc/clk_group.sdc

