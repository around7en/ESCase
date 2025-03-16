if {! $IS_CHIP} {
    create_clock -name vclk -period $CYCLE_26M
    lappend CLOCK_GROUP(vclk) vclk
    set name_anlg_rc32k_clk anlg_rc32k_clk
    set hier_anlg_rc32k_clk [get_ports anlg_rc32k_clk]
    create_clock -name $name_anlg_rc32k_clk -period $CYCLE_26M -add $hier_anlg_rc32k_clk
    lappend CLOCK_GROUP(anlg_rc32k_clk) $name_anlg_rc32k_clk
    set name_anlg_xo32k_clk anlg_xo32k_clk
    set hier_anlg_xo32k_clk [get_ports anlg_xo32k_clk]
    create_clock -name $name_anlg_xo32k_clk -period $CYCLE_26M -add $hier_anlg_xo32k_clk
    lappend CLOCK_GROUP(anlg_xo32k_clk) $name_anlg_xo32k_clk
    set name_anlg_rtc32k_clk anlg_rtc32k_clk
    set hier_anlg_rtc32k_clk [get_ports anlg_rtc32k_clk]
    create_clock -name $name_anlg_rtc32k_clk -period $CYCLE_26M -add $hier_anlg_rtc32k_clk
    lappend CLOCK_GROUP(anlg_rtc32k_clk) $name_anlg_rtc32k_clk
    set name_clk_xo26m_32k clk_xo26m_32k
    set hier_clk_xo26m_32k [get_ports clk_xo26m_32k]
    create_clock -name $name_clk_xo26m_32k -period $CYCLE_26M -add $hier_clk_xo26m_32k
    lappend CLOCK_GROUP(clk_xo26m_32k) $name_clk_xo26m_32k
    set name_clk_15k clk_15k
    set hier_clk_15k [get_ports clk_15k]
    create_clock -name $name_clk_15k -period $CYCLE_26M -add $hier_clk_15k
    lappend CLOCK_GROUP(clk_15k) $name_clk_15k
    set name_clk_32k clk_32k
    set hier_clk_32k [get_ports clk_32k]
    create_clock -name $name_clk_32k -period $CYCLE_26M -add $hier_clk_32k
    lappend CLOCK_GROUP(clk_32k) $name_clk_32k
    set name_clk_dig_26m clk_dig_26m
    set hier_clk_dig_26m [get_ports clk_dig_26m]
    create_clock -name $name_clk_dig_26m -period $CYCLE_26M -add $hier_clk_dig_26m
    lappend CLOCK_GROUP(clk_dig_26m) $name_clk_dig_26m
    set name_clk_rfdac_adc_cp clk_rfdac_adc_cp
    set hier_clk_rfdac_adc_cp [get_ports clk_rfdac_adc_cp]
    create_clock -name $name_clk_rfdac_adc_cp -period $CYCLE_26M -add $hier_clk_rfdac_adc_cp
    lappend CLOCK_GROUP(clk_rfdac_adc_cp) $name_clk_rfdac_adc_cp
    set name_clk_auxadc_26m clk_auxadc_26m
    set hier_clk_auxadc_26m [get_ports clk_auxadc_26m]
    create_clock -name $name_clk_auxadc_26m -period $CYCLE_26M -add $hier_clk_auxadc_26m
    lappend CLOCK_GROUP(clk_auxadc_26m) $name_clk_auxadc_26m
    set name_clk_12_288m clk_12_288m
    set hier_clk_12_288m [get_ports clk_12_288m]
    create_clock -name $name_clk_12_288m -period $CYCLE_26M -add $hier_clk_12_288m
    lappend CLOCK_GROUP(clk_12_288m) $name_clk_12_288m
    set name_clk_19_2m clk_19_2m
    set hier_clk_19_2m [get_ports clk_19_2m]
    create_clock -name $name_clk_19_2m -period $CYCLE_26M -add $hier_clk_19_2m
    lappend CLOCK_GROUP(clk_19_2m) $name_clk_19_2m
    set name_clk_usb2_utmi clk_usb2_utmi
    set hier_clk_usb2_utmi [get_ports clk_usb2_utmi]
    create_clock -name $name_clk_usb2_utmi -period $CYCLE_26M -add $hier_clk_usb2_utmi
    lappend CLOCK_GROUP(clk_usb2_utmi) $name_clk_usb2_utmi
    set name_clk_aon_frc clk_aon_frc
    set hier_clk_aon_frc [get_ports clk_aon_frc]
    create_clock -name $name_clk_aon_frc -period $CYCLE_26M -add $hier_clk_aon_frc
    lappend CLOCK_GROUP(clk_aon_frc) $name_clk_aon_frc
    set name_ptest_slow_occ_clock ptest_slow_occ_clock
    set hier_ptest_slow_occ_clock [get_ports ptest_slow_occ_clock]
    create_clock -name $name_ptest_slow_occ_clock -period $CYCLE_26M -add $hier_ptest_slow_occ_clock
    lappend CLOCK_GROUP(ptest_slow_occ_clock) $name_ptest_slow_occ_clock
}
#----------------------------------------------------------------------------
#clk_top_aux0
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_aux_clk_top_aux0 \
        -master_clock $name_clk_aon_frc \
        -source $hier_clk_aon_frc \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_AUX_CLK_CORE_HIER}/u_clk_top_aux0_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_aux_clk_top_aux0) top_aux_clk_top_aux0
#----------------------------------------------------------------------------
#clk_top_aux1
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_aux_clk_top_aux1 \
        -master_clock $name_clk_aon_frc \
        -source $hier_clk_aon_frc \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_AUX_CLK_CORE_HIER}/u_clk_top_aux1_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_aux_clk_top_aux1) top_aux_clk_top_aux1
#----------------------------------------------------------------------------
#clk_top_aux2
#----------------------------------------------------------------------------
    create_generated_clock  \
        -name top_aux_clk_top_aux2 \
        -master_clock $name_clk_aon_frc \
        -source $hier_clk_aon_frc \
        -combinational \
        -divide_by 1 \
        -add \
        ${TOP_AUX_CLK_CORE_HIER}/u_clk_top_aux2_mux/$CKOUTZ_HIER
    lappend CLOCK_GROUP(top_aux_clk_top_aux2) top_aux_clk_top_aux2
