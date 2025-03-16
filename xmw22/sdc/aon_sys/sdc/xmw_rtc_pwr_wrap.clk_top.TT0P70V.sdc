######################################################################
###############################Create source Clock
######################################################################
if {! $IS_CHIP} {
    create_clock -name ${RTC_SYS_NAME}_rtc32k_clk           -period $CYCLE_32K      -add [get_ports rtc32k_clk]
    create_clock -name ${RTC_SYS_NAME}_V_CLK_32K            -period $CYCLE_32K

    lappend CLOCK_GROUP(clk_rtc32k_anlg)                    [list ${RTC_SYS_NAME}_rtc32k_clk]
    set CLOCK_GROUP(${RTC_SYS_NAME}_V_CLK_32K)              [list ${RTC_SYS_NAME}_V_CLK_32K]

    create_generated_clock -name ${RTC_SYS_NAME}_clk_rtc32k_aon_inte -add \
                      -master_clock ${RTC_SYS_NAME}_rtc32k_clk \
                      -source [get_ports rtc32k_clk] \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${XMW_RTC_TOP_HIER}u_xmw_rtc_top/u_xmw_rtc_clk/u_clk_rtc32k_aon/cmind_uj_ckcell/Q]

    lappend CLOCK_GROUP(clk_rtc32k_anlg)                    [ list ${RTC_SYS_NAME}_clk_rtc32k_aon_inte]

    create_generated_clock -name ${RTC_SYS_NAME}_clk_rtc32k_aon -add \
                      -master_clock ${RTC_SYS_NAME}_clk_rtc32k_aon_inte \
                      -source [get_pins ${XMW_RTC_TOP_HIER}u_xmw_rtc_top/u_xmw_rtc_clk/u_clk_rtc32k_aon/cmind_uj_ckcell/Q] \
                      -divide_by 1 \
                      -combinational \
                      [get_ports clk_rtc32k_aon]
    
    lappend CLOCK_GROUP(clk_rtc32k_anlg)                    [ list ${RTC_SYS_NAME}_clk_rtc32k_aon]

    create_generated_clock -name ${RTC_SYS_NAME}_clk_rtc32k_top -add \
                      -master_clock ${RTC_SYS_NAME}_clk_rtc32k_aon_inte \
                      -source [get_pins ${XMW_RTC_TOP_HIER}u_xmw_rtc_top/u_xmw_rtc_clk/u_clk_rtc32k_aon/cmind_uj_ckcell/Q] \
                      -divide_by 1 \
                      -combinational \
                      [get_ports clk_rtc32k_top]
    
    lappend CLOCK_GROUP(clk_rtc32k_anlg)                    [ list ${RTC_SYS_NAME}_clk_rtc32k_top]

    create_generated_clock -name ${RTC_SYS_NAME}_clk_rstkey_dbnc -add \
                      -master_clock ${RTC_SYS_NAME}_rtc32k_clk \
                      -source [get_ports rtc32k_clk] \
                      -divide_by 1 \
                      -combinational \
                      [get_ports clk_rstkey_dbnc]
    
    lappend CLOCK_GROUP(clk_rtc32k_anlg)                    [ list ${RTC_SYS_NAME}_clk_rstkey_dbnc]

}
