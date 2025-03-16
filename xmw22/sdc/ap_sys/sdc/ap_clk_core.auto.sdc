if {![info exist AP_SYS_CLK_CORE_HIER]} {
    set AP_SYS_CLK_CORE_HIER "u_ap_sys_top/u_ap_clk_core_wrap/u_ap_clk_core/"
}
    
if {! $IS_CHIP} {
    create_clock -name ap_sys_clk_102_4m_cpll_ap_sys -period $CYCLE_102M4 -add [get_ports clk_102_4m_cpll_ap_sys]
    lappend CLOCK_GROUP(ap_sys_clk_102_4m_cpll_ap_sys)    ap_sys_clk_102_4m_cpll_ap_sys
    set name_clk_102_4m_cpll_ap_sys ap_sys_clk_102_4m_cpll_ap_sys
    set hier_clk_102_4m_cpll_ap_sys [get_ports clk_102_4m_cpll_ap_sys]

    create_clock -name ap_sys_clk_153_6m_cpll_ap_sys -period $CYCLE_153M6 -add [get_ports clk_153_6m_cpll_ap_sys]
    lappend CLOCK_GROUP(ap_sys_clk_153_6m_cpll_ap_sys)    ap_sys_clk_153_6m_cpll_ap_sys
    set name_clk_153_6m_cpll_ap_sys ap_sys_clk_153_6m_cpll_ap_sys
    set hier_clk_153_6m_cpll_ap_sys [get_ports clk_153_6m_cpll_ap_sys]

    create_clock -name ap_sys_clk_204_8m_cpll_ap_sys -period $CYCLE_204M8 -add [get_ports clk_204_8m_cpll_ap_sys]
    lappend CLOCK_GROUP(ap_sys_clk_204_8m_cpll_ap_sys)    ap_sys_clk_204_8m_cpll_ap_sys
    set name_clk_204_8m_cpll_ap_sys ap_sys_clk_204_8m_cpll_ap_sys
    set hier_clk_204_8m_cpll_ap_sys [get_ports clk_204_8m_cpll_ap_sys]

    create_clock -name ap_sys_clk_245_76m_cpll_ap_sys -period $CYCLE_245M76 -add [get_ports clk_245_76m_cpll_ap_sys]
    lappend CLOCK_GROUP(ap_sys_clk_245_76m_cpll_ap_sys)    ap_sys_clk_245_76m_cpll_ap_sys
    set name_clk_245_76m_cpll_ap_sys ap_sys_clk_245_76m_cpll_ap_sys
    set hier_clk_245_76m_cpll_ap_sys [get_ports clk_245_76m_cpll_ap_sys]

    create_clock -name ap_sys_clk_26m_xo_ap_sys -period $CYCLE_26M -add [get_ports clk_26m_xo_ap_sys]
    lappend CLOCK_GROUP(ap_sys_clk_26m_xo_ap_sys)    ap_sys_clk_26m_xo_ap_sys
    set name_clk_26m_xo_ap_sys ap_sys_clk_26m_xo_ap_sys
    set hier_clk_26m_xo_ap_sys [get_ports clk_26m_xo_ap_sys]

    create_clock -name ap_sys_clk_307_2m_cpll_ap_sys -period $CYCLE_307M2 -add [get_ports clk_307_2m_cpll_ap_sys]
    lappend CLOCK_GROUP(ap_sys_clk_307_2m_cpll_ap_sys)    ap_sys_clk_307_2m_cpll_ap_sys
    set name_clk_307_2m_cpll_ap_sys ap_sys_clk_307_2m_cpll_ap_sys
    set hier_clk_307_2m_cpll_ap_sys [get_ports clk_307_2m_cpll_ap_sys]

    create_clock -name ap_sys_clk_30_72m_cpll_ap_sys -period $CYCLE_30M72 -add [get_ports clk_30_72m_cpll_ap_sys]
    lappend CLOCK_GROUP(ap_sys_clk_30_72m_cpll_ap_sys)    ap_sys_clk_30_72m_cpll_ap_sys
    set name_clk_30_72m_cpll_ap_sys ap_sys_clk_30_72m_cpll_ap_sys
    set hier_clk_30_72m_cpll_ap_sys [get_ports clk_30_72m_cpll_ap_sys]

    create_clock -name ap_sys_clk_51_2m_cpll_ap_sys -period $CYCLE_51M2 -add [get_ports clk_51_2m_cpll_ap_sys]
    lappend CLOCK_GROUP(ap_sys_clk_51_2m_cpll_ap_sys)    ap_sys_clk_51_2m_cpll_ap_sys
    set name_clk_51_2m_cpll_ap_sys ap_sys_clk_51_2m_cpll_ap_sys
    set hier_clk_51_2m_cpll_ap_sys [get_ports clk_51_2m_cpll_ap_sys]

    create_clock -name ap_sys_clk_61_44m_cpll_ap_sys -period $CYCLE_61M44 -add [get_ports clk_61_44m_cpll_ap_sys]
    lappend CLOCK_GROUP(ap_sys_clk_61_44m_cpll_ap_sys)    ap_sys_clk_61_44m_cpll_ap_sys
    set name_clk_61_44m_cpll_ap_sys ap_sys_clk_61_44m_cpll_ap_sys
    set hier_clk_61_44m_cpll_ap_sys [get_ports clk_61_44m_cpll_ap_sys]

    create_clock -name ap_sys_clk_76_8m_cpll_ap_sys -period $CYCLE_76M8 -add [get_ports clk_76_8m_cpll_ap_sys]
    lappend CLOCK_GROUP(ap_sys_clk_76_8m_cpll_ap_sys)    ap_sys_clk_76_8m_cpll_ap_sys
    set name_clk_76_8m_cpll_ap_sys ap_sys_clk_76_8m_cpll_ap_sys
    set hier_clk_76_8m_cpll_ap_sys [get_ports clk_76_8m_cpll_ap_sys]

    create_clock -name ap_sys_clk_pub_ahb -period $CYCLE_204M8 -add [get_ports clk_pub_ahb]
    lappend CLOCK_GROUP(ap_sys_clk_pub_ahb)    ap_sys_clk_pub_ahb
    set name_clk_pub_ahb ap_sys_clk_pub_ahb
    set hier_clk_pub_ahb [get_ports clk_pub_ahb]

    create_clock -name ap_sys_clk_sysram_ahb -period $CYCLE_245M76 -add [get_ports clk_sysram_ahb]
    lappend CLOCK_GROUP(ap_sys_clk_sysram_ahb)    ap_sys_clk_sysram_ahb
    set name_clk_sysram_ahb ap_sys_clk_sysram_ahb
    set hier_clk_sysram_ahb [get_ports clk_sysram_ahb]

    create_clock -name ap_sys_clk_top_ahb -period $CYCLE_102M4 -add [get_ports clk_top_ahb]
    lappend CLOCK_GROUP(ap_sys_clk_top_ahb)    ap_sys_clk_top_ahb
    set name_clk_top_ahb ap_sys_clk_top_ahb
    set hier_clk_top_ahb [get_ports clk_top_ahb]

    create_clock -name ap_sys_ptest_slow_occ_clock -period $CYCLE_26M -add [get_ports ptest_slow_occ_clock]
    lappend CLOCK_GROUP(ap_sys_ptest_slow_occ_clock)    ap_sys_ptest_slow_occ_clock
    set name_ptest_slow_occ_clock ap_sys_ptest_slow_occ_clock
    set hier_ptest_slow_occ_clock [get_ports ptest_slow_occ_clock]
}
create_clock -name ${AP_SYS_NAME}_V_CLK_26M            -period $CYCLE_26M
set CLOCK_GROUP(${AP_SYS_NAME}_V_CLK_26M)           [list ${AP_SYS_NAME}_V_CLK_26M]    
#############################################################################
###Clock Mux Generate
#############################################################################
###generate mux clock clk_ap_ahb:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_ap_ahb -add \
                      -master_clock $name_clk_204_8m_cpll_ap_sys \
                      -source $hier_clk_204_8m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_sw5_clk_ap_ahb/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_ap_ahb) ${AP_LIB_HIER}ap_sys_clk_ap_ahb                                            
set name_clk_ap_ahb ap_sys_clk_ap_ahb
set hier_clk_ap_ahb ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_sw5_clk_ap_ahb/$CKOUTZ_HIER

###generate mux clock clk_spi0_apb:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_spi0_apb -add \
                      -master_clock $name_clk_102_4m_cpll_ap_sys \
                      -source $hier_clk_102_4m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux4_clk_spi0_apb/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_spi0_apb) ${AP_LIB_HIER}ap_sys_clk_spi0_apb                                            
set name_clk_spi0_apb ap_sys_clk_spi0_apb
set hier_clk_spi0_apb ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux4_clk_spi0_apb/$CKOUTZ_HIER

###generate mux clock clk_spi1_apb:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_spi1_apb -add \
                      -master_clock $name_clk_102_4m_cpll_ap_sys \
                      -source $hier_clk_102_4m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux4_clk_spi1_apb/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_spi1_apb) ${AP_LIB_HIER}ap_sys_clk_spi1_apb                                            
set name_clk_spi1_apb ap_sys_clk_spi1_apb
set hier_clk_spi1_apb ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux4_clk_spi1_apb/$CKOUTZ_HIER

###generate mux clock clk_spi2_apb:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_spi2_apb -add \
                      -master_clock $name_clk_102_4m_cpll_ap_sys \
                      -source $hier_clk_102_4m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux4_clk_spi2_apb/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_spi2_apb) ${AP_LIB_HIER}ap_sys_clk_spi2_apb                                            
set name_clk_spi2_apb ap_sys_clk_spi2_apb
set hier_clk_spi2_apb ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux4_clk_spi2_apb/$CKOUTZ_HIER

###generate mux clock clk_spi_flash:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_spi_flash -add \
                      -master_clock $name_clk_307_2m_cpll_ap_sys \
                      -source $hier_clk_307_2m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_sw4_clk_spi_flash/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_spi_flash) ${AP_LIB_HIER}ap_sys_clk_spi_flash                                            
set name_clk_spi_flash ap_sys_clk_spi_flash
set hier_clk_spi_flash ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_sw4_clk_spi_flash/$CKOUTZ_HIER

###generate mux clock clk_uart1:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_uart1 -add \
                      -master_clock $name_clk_76_8m_cpll_ap_sys \
                      -source $hier_clk_76_8m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_uart1/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_uart1) ${AP_LIB_HIER}ap_sys_clk_uart1                                            
set name_clk_uart1 ap_sys_clk_uart1
set hier_clk_uart1 ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_uart1/$CKOUTZ_HIER

###generate mux clock clk_uart4:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_uart4 -add \
                      -master_clock $name_clk_76_8m_cpll_ap_sys \
                      -source $hier_clk_76_8m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_uart4/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_uart4) ${AP_LIB_HIER}ap_sys_clk_uart4                                            
set name_clk_uart4 ap_sys_clk_uart4
set hier_clk_uart4 ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_uart4/$CKOUTZ_HIER

###generate mux clock clk_uart5:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_uart5 -add \
                      -master_clock $name_clk_76_8m_cpll_ap_sys \
                      -source $hier_clk_76_8m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_uart5/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_uart5) ${AP_LIB_HIER}ap_sys_clk_uart5                                            
set name_clk_uart5 ap_sys_clk_uart5
set hier_clk_uart5 ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_uart5/$CKOUTZ_HIER

###generate mux clock clk_i2c1_apb:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_i2c1_apb -add \
                      -master_clock $name_clk_61_44m_cpll_ap_sys \
                      -source $hier_clk_61_44m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux2_clk_i2c1_apb/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_i2c1_apb) ${AP_LIB_HIER}ap_sys_clk_i2c1_apb                                            
set name_clk_i2c1_apb ap_sys_clk_i2c1_apb
set hier_clk_i2c1_apb ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux2_clk_i2c1_apb/$CKOUTZ_HIER

###generate mux clock clk_i2c2_apb:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_i2c2_apb -add \
                      -master_clock $name_clk_61_44m_cpll_ap_sys \
                      -source $hier_clk_61_44m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux2_clk_i2c2_apb/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_i2c2_apb) ${AP_LIB_HIER}ap_sys_clk_i2c2_apb                                            
set name_clk_i2c2_apb ap_sys_clk_i2c2_apb
set hier_clk_i2c2_apb ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux2_clk_i2c2_apb/$CKOUTZ_HIER

###generate mux clock clk_i2s0:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_i2s0 -add \
                      -master_clock $name_clk_51_2m_cpll_ap_sys \
                      -source $hier_clk_51_2m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_i2s0/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_i2s0) ${AP_LIB_HIER}ap_sys_clk_i2s0                                            
set name_clk_i2s0 ap_sys_clk_i2s0
set hier_clk_i2s0 ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_i2s0/$CKOUTZ_HIER

###generate mux clock clk_can0_apb:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_can0_apb -add \
                      -master_clock $name_clk_76_8m_cpll_ap_sys \
                      -source $hier_clk_76_8m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_can0_apb/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_can0_apb) ${AP_LIB_HIER}ap_sys_clk_can0_apb                                            
set name_clk_can0_apb ap_sys_clk_can0_apb
set hier_clk_can0_apb ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_can0_apb/$CKOUTZ_HIER

###generate mux clock clk_can1_apb:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_can1_apb -add \
                      -master_clock $name_clk_76_8m_cpll_ap_sys \
                      -source $hier_clk_76_8m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_can1_apb/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_can1_apb) ${AP_LIB_HIER}ap_sys_clk_can1_apb                                            
set name_clk_can1_apb ap_sys_clk_can1_apb
set hier_clk_can1_apb ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_can1_apb/$CKOUTZ_HIER

###generate mux clock clk_sdio0:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_sdio0 -add \
                      -master_clock $name_clk_102_4m_cpll_ap_sys \
                      -source $hier_clk_102_4m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux4_clk_sdio0/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_sdio0) ${AP_LIB_HIER}ap_sys_clk_sdio0                                            
set name_clk_sdio0 ap_sys_clk_sdio0
set hier_clk_sdio0 ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux4_clk_sdio0/$CKOUTZ_HIER

###generate mux clock clk_sim0_apb:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_sim0_apb -add \
                      -master_clock $name_clk_51_2m_cpll_ap_sys \
                      -source $hier_clk_51_2m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux2_clk_sim0_apb/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_sim0_apb) ${AP_LIB_HIER}ap_sys_clk_sim0_apb                                            
set name_clk_sim0_apb ap_sys_clk_sim0_apb
set hier_clk_sim0_apb ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux2_clk_sim0_apb/$CKOUTZ_HIER

###generate mux clock clk_sim1_apb:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_sim1_apb -add \
                      -master_clock $name_clk_51_2m_cpll_ap_sys \
                      -source $hier_clk_51_2m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux2_clk_sim1_apb/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_sim1_apb) ${AP_LIB_HIER}ap_sys_clk_sim1_apb                                            
set name_clk_sim1_apb ap_sys_clk_sim1_apb
set hier_clk_sim1_apb ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux2_clk_sim1_apb/$CKOUTZ_HIER

###generate mux clock clk_pwm3_apb:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_pwm3_apb -add \
                      -master_clock $name_clk_76_8m_cpll_ap_sys \
                      -source $hier_clk_76_8m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_pwm3_apb/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_pwm3_apb) ${AP_LIB_HIER}ap_sys_clk_pwm3_apb                                            
set name_clk_pwm3_apb ap_sys_clk_pwm3_apb
set hier_clk_pwm3_apb ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux3_clk_pwm3_apb/$CKOUTZ_HIER

#############################################################################
###Clock Divider Generate
#############################################################################
###generate divider clock clk_ap_apb:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_ap_apb -add \
                      -master_clock $name_clk_ap_ahb \
                      -source $hier_clk_ap_ahb \
                      -divide_by 2 \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_clk_ap_apb_div2/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_ap_ahb) ${AP_LIB_HIER}ap_sys_clk_ap_apb   
set name_clk_ap_apb ap_sys_clk_ap_apb
set hier_clk_ap_apb ${AP_SYS_CLK_CORE_HIER}u_clk_ap_apb_div2/$CKOUTZ_HIER

#############################################################################
###OCC scanmux I1 pin Clock Generate
#############################################################################
###generate clk clk_pwm2_apb_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_pwm2_apb_scan -add \
                      -master_clock $name_ptest_slow_occ_clock \
                      -source $hier_ptest_slow_occ_clock \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_clk_pwm2_apb_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(ap_sys_clk_pwm2_apb_scan) ${AP_LIB_HIER}ap_sys_clk_pwm2_apb_scan   
set name_clk_pwm2_apb_scan ap_sys_clk_pwm2_apb_scan
set hier_clk_pwm2_apb_scan ${AP_SYS_CLK_CORE_HIER}u_clk_pwm2_apb_scanmux/cmind_uj_ckcell/I1

###generate clk clk_pwm2_apb for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_pwm2_apb -add \
                      -master_clock $name_clk_26m_xo_ap_sys \
                      -source $hier_clk_26m_xo_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_clk_pwm2_apb_scanmux/cmind_uj_ckcell/I0]
}
lappend CLOCK_GROUP(ap_sys_clk_pwm2_apb) ${AP_LIB_HIER}ap_sys_clk_pwm2_apb   
set name_clk_pwm2_apb ap_sys_clk_pwm2_apb
set hier_clk_pwm2_apb ${AP_SYS_CLK_CORE_HIER}u_clk_pwm2_apb_scanmux/cmind_uj_ckcell/I0


###generate clk utmi_clk_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_utmi_clk_scan -add \
                      -master_clock $name_clk_61_44m_cpll_ap_sys \
                      -source $hier_clk_61_44m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_utmi_clk_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(ap_sys_utmi_clk_scan) ${AP_LIB_HIER}ap_sys_utmi_clk_scan   
set name_utmi_clk_scan ap_sys_utmi_clk_scan
set hier_utmi_clk_scan ${AP_SYS_CLK_CORE_HIER}u_utmi_clk_scanmux/cmind_uj_ckcell/I1

###generate clk clk_top_ahb_scan_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_top_ahb_scan_scan -add \
                      -master_clock $name_clk_102_4m_cpll_ap_sys \
                      -source $hier_clk_102_4m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_clk_top_ahb_scan_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(ap_sys_clk_top_ahb_scan_scan) ${AP_LIB_HIER}ap_sys_clk_top_ahb_scan_scan   
set name_clk_top_ahb_scan_scan ap_sys_clk_top_ahb_scan_scan
set hier_clk_top_ahb_scan_scan ${AP_SYS_CLK_CORE_HIER}u_clk_top_ahb_scan_scanmux/cmind_uj_ckcell/I1

###generate clk clk_pub_ahb_scan_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_pub_ahb_scan_scan -add \
                      -master_clock $name_clk_204_8m_cpll_ap_sys \
                      -source $hier_clk_204_8m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_clk_pub_ahb_scan_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(ap_sys_clk_pub_ahb_scan_scan) ${AP_LIB_HIER}ap_sys_clk_pub_ahb_scan_scan   
set name_clk_pub_ahb_scan_scan ap_sys_clk_pub_ahb_scan_scan
set hier_clk_pub_ahb_scan_scan ${AP_SYS_CLK_CORE_HIER}u_clk_pub_ahb_scan_scanmux/cmind_uj_ckcell/I1

###generate clk clk_sysram_ahb_scan_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_sysram_ahb_scan_scan -add \
                      -master_clock $name_clk_245_76m_cpll_ap_sys \
                      -source $hier_clk_245_76m_cpll_ap_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_CLK_CORE_HIER}u_clk_sysram_ahb_scan_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(ap_sys_clk_sysram_ahb_scan_scan) ${AP_LIB_HIER}ap_sys_clk_sysram_ahb_scan_scan   
set name_clk_sysram_ahb_scan_scan ap_sys_clk_sysram_ahb_scan_scan
set hier_clk_sysram_ahb_scan_scan ${AP_SYS_CLK_CORE_HIER}u_clk_sysram_ahb_scan_scanmux/cmind_uj_ckcell/I1

