
if {! $IS_CHIP} {
###########virtual clk#######################
create_clock -name cpu_sys_V_CLK_26M            -period $CYCLE_26M -add
set CLOCK_GROUP(cpu_sys_V_CLK_26M)           [list cpu_sys_V_CLK_26M]    


create_clock -name ${CPU_SYS_NAME}_ijtag_tck -period $CYCLE_SCAN [get_ports ptest_ijtag_tck] -add
set CLOCK_GROUP(${CPU_SYS_NAME}_ijtag_tck)    [list ${CPU_SYS_NAME}_ijtag_tck]

create_clock -name ${CPU_SYS_NAME}_scan_clk         -period $CYCLE_SCAN      -add [get_ports ptest_scan_clock]
set CLOCK_GROUP(${CPU_SYS_NAME}_scan_clk)           [list ${CPU_SYS_NAME}_scan_clk  ]    

create_clock -name ${CPU_SYS_NAME}_edt_clock  -period $CYCLE_SCAN -waveform $WAVEF_SCAN [get_ports ptest_edt_clock] -add
set CLOCK_GROUP(${CPU_SYS_NAME}_edt_clock)    [list ${CPU_SYS_NAME}_edt_clock]

}

source $PROJ_DIR/de/cpu_sys/sdc/cpu_clk_core.auto.sdc


