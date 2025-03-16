######################################################################
###############################Create source Clock
######################################################################
if {!$IS_CHIP} {
    create_clock -name ${AON_SYS_NAME}_clk_rtc32k_aon       -period $CYCLE_1M      -add [get_ports clk_rtc32k_aon]
    create_clock -name ${AON_SYS_NAME}_clk_rstkey_dbnc      -period $CYCLE_1M      -add [get_ports clk_rstkey_dbnc]
    create_clock -name ${AON_SYS_NAME}_clk_xo26m_32k        -period $CYCLE_1M      -add [get_ports clk_xo26m_32k]
    create_clock -name ${AON_SYS_NAME}_clk_30_72m           -period $CYCLE_30M72   -add [get_ports clk_30_72m]
    create_clock -name ${AON_SYS_NAME}_clk_3_25m            -period $CYCLE_3M25    -add [get_ports clk_3_25m]
    create_clock -name ${AON_SYS_NAME}_V_CLK_1M92           -period $CYCLE_1M92

    lappend CLOCK_GROUP(clk_rtc32k_anlg)                    [list ${AON_SYS_NAME}_clk_rtc32k_aon]
    lappend CLOCK_GROUP(clk_rtc32k_anlg)                    [list ${AON_SYS_NAME}_clk_rstkey_dbnc]
    set CLOCK_GROUP(${AON_SYS_NAME}_clk_xo26m_32k)          [list ${AON_SYS_NAME}_clk_xo26m_32k]
    set CLOCK_GROUP(${AON_SYS_NAME}_clk_30_72m)             [list ${AON_SYS_NAME}_clk_30_72m]
    lappend CLOCK_GROUP(top_for_aon_clk_3_25m_top_for_aon)  [list ${AON_SYS_NAME}_clk_3_25m]
    set CLOCK_GROUP(${AON_SYS_NAME}_V_CLK_1M92)             [list ${AON_SYS_NAME}_V_CLK_1M92]


    create_generated_clock -name ${AON_SYS_NAME}_clk_32k -add \
                      -master_clock ${AON_SYS_NAME}_clk_rtc32k_aon \
                      -source [get_ports clk_rtc32k_aon] \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_cksw2_32k/$CKOUTZ_HIER]
    set CLOCK_GROUP(${AON_SYS_NAME}_clk_32k)     [ list ${AON_SYS_NAME}_clk_32k]

#####################################################################

    create_generated_clock -name ${AON_SYS_NAME}_clk_aon_frc_30_72m \
                       -master_clock ${AON_SYS_NAME}_clk_30_72m \
                       -source [get_ports clk_30_72m]\
                       -divide_by 1 -add \
                       [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_clk_frc_switch/$CKOUTZ_HIER]

    lappend CLOCK_GROUP(${AON_SYS_NAME}_clk_30_72m)     [ list ${AON_SYS_NAME}_clk_aon_frc_30_72m]

    create_generated_clock -name ${AON_SYS_NAME}_clk_aon_frc_32k \
                       -master_clock ${AON_SYS_NAME}_clk_32k \
                       -source [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_cksw2_32k/$CKOUTZ_HIER]\
                       -divide_by 1 -add \
                       [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_clk_frc_switch/$CKOUTZ_HIER]

    lappend CLOCK_GROUP(${AON_SYS_NAME}_clk_32k)     [ list ${AON_SYS_NAME}_clk_aon_frc_32k]

    create_generated_clock -name ${AON_SYS_NAME}_clk_aon_pmu_3_25m \
                       -master_clock ${AON_SYS_NAME}_clk_3_25m \
                       -source [get_ports clk_3_25m]\
                       -divide_by 1 -add \
                       [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_cksw2_pmu/$CKOUTZ_HIER]

    lappend CLOCK_GROUP(top_for_aon_clk_3_25m_top_for_aon)     [ list ${AON_SYS_NAME}_clk_aon_pmu_3_25m]

    create_generated_clock -name ${AON_SYS_NAME}_clk_frc_15k -add \
                      -master_clock ${AON_SYS_NAME}_clk_aon_frc_32k \
                      -source [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_clk_frc_switch/$CKOUTZ_HIER] \
                      -divide_by 2 \
                      [get_ports clk_15k]
    
    set CLOCK_GROUP(${AON_SYS_NAME}_clk_15k)     [ list ${AON_SYS_NAME}_clk_frc_15k]

    create_generated_clock -name ${AON_SYS_NAME}_clk_1_875k -add \
                      -master_clock ${AON_SYS_NAME}_clk_aon_frc_32k \
                      -source [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_clk_frc_switch/$CKOUTZ_HIER] \
                      -divide_by 16 \
                      [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_clk_1_875k/cmind_uj_ckcell/Z]
    
    set CLOCK_GROUP(${AON_SYS_NAME}_clk_1_875k)     [ list ${AON_SYS_NAME}_clk_1_875k]


#####################################################################

    create_generated_clock -name ${AON_SYS_NAME}_clk_strappin -add \
                      -master_clock ${AON_SYS_NAME}_clk_aon_pmu_3_25m \
                      -source [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_cksw2_pmu/$CKOUTZ_HIER] \
                      -divide_by 10 \
                      [get_ports clk_strappin]
    
    set CLOCK_GROUP(${AON_SYS_NAME}_clk_strappin)     [ list ${AON_SYS_NAME}_clk_strappin]

}


if {$IS_CHIP} {
    create_generated_clock -name ${AON_SYS_NAME}_clk_strappin -add \
                      -master_clock $name_clk_rtc32k_anlg\
                      -source $hier_clk_rtc32k_anlg \
                      -divide_by 2 \
                      [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_pmu/u_clk_strappin/cmind_uj_ckcell/Z]
    
    set CLOCK_GROUP(${AON_SYS_NAME}_clk_strappin)     [ list ${AON_SYS_NAME}_clk_strappin]

    create_generated_clock -name ${AON_SYS_NAME}_clk_32k -add \
                      -master_clock $name_clk_rtc32k_anlg \
                      -source [get_pins $hier_clk_rtc32k_anlg] \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_cksw2_32k/$CKOUTZ_HIER]
    set CLOCK_GROUP(${AON_SYS_NAME}_clk_32k)     [ list ${AON_SYS_NAME}_clk_32k]

    create_generated_clock -name ${AON_SYS_NAME}_clk_aon_frc_32k \
                       -master_clock ${AON_SYS_NAME}_clk_32k \
                       -source [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_cksw2_32k/$CKOUTZ_HIER]\
                       -divide_by 1 -add \
                       [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_clk_frc_switch/$CKOUTZ_HIER]

    lappend CLOCK_GROUP(${AON_SYS_NAME}_clk_32k)     [ list ${AON_SYS_NAME}_clk_aon_frc_32k]

    create_generated_clock -name ${AON_SYS_NAME}_clk_frc_15k -add \
                      -master_clock ${AON_SYS_NAME}_clk_aon_frc_32k \
                      -source [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_clk_frc_switch/$CKOUTZ_HIER] \
                      -divide_by 2 \
                      [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_clk_15k/cmind_uj_ckcell/Z]

    set CLOCK_GROUP(${AON_SYS_NAME}_clk_15k)     [ list ${AON_SYS_NAME}_clk_frc_15k]

    create_generated_clock -name ${AON_SYS_NAME}_clk_15k -add \
                      -master_clock ${AON_SYS_NAME}_clk_frc_15k \
                      -source [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_clk_15k/cmind_uj_ckcell/Z] \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AON_SYS_HIER}u_aon_sys_els_wrap/AON2TOP_LVL*120*u_LVLSRLHSGD4BWP7T40P140HVT/Z]

    lappend CLOCK_GROUP(${AON_SYS_NAME}_clk_15k)     [ list ${AON_SYS_NAME}_clk_15k]

    create_generated_clock -name ${AON_SYS_NAME}_clk_1_875k -add \
                      -master_clock ${AON_SYS_NAME}_clk_aon_frc_32k \
                      -source [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_clk_frc_switch/$CKOUTZ_HIER] \
                      -divide_by 16 \
                      [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_frc_top/u_clk_1_875k/cmind_uj_ckcell/Z]
    
    set CLOCK_GROUP(${AON_SYS_NAME}_clk_1_875k)     [ list ${AON_SYS_NAME}_clk_1_875k]

}


if {!$IS_CHIP} {
    create_generated_clock -name ${AON_SYS_NAME}_clk_aon_frc_aux -add \
                      -master_clock ${AON_SYS_NAME}_clk_aon_frc_30_72m \
                      -source [get_pins ${AON_SYS_HIER}u_aon_sys_top/u_aon_clk_top/u_clk_frc_switch/$CKOUTZ_HIER] \
                      -divide_by 1 \
                      -combinational \
                      [get_ports clk_aon_frc_aux]
    
    set CLOCK_GROUP(${AON_SYS_NAME}_clk_aon_frc_aux)     [ list ${AON_SYS_NAME}_clk_aon_frc_aux]
}

#for {set eic_i 0} {$eic_i < 3} {incr eic_i 1} {
#    set_case_analysis 1 ${AON_SYS_HIER}u_aon_sys_top/u_eic_top/EIC_SUB_MODULE*${eic_i}*u_eic_async/u_eic_in_scanmux/cmind_uj_ckcell/S
#}
