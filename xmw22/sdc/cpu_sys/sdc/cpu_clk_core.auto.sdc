if {![info exist CPU_SYS_CLK_CORE_HIER]} {
    set CPU_SYS_CLK_CORE_HIER "${CPU_SYS_TOP_HIER}u_cpu_sys_clk_top/u_cpu_clk_core_wrap/u_cpu_clk_core/"
}
    
if {! $IS_CHIP} {
    create_clock -name cpu_sys_clk_102_4m_cpll_cpu_sys -period $CYCLE_102M4 -add [get_ports clk_102_4m_cpll_cpu_sys]
    lappend CLOCK_GROUP(cpu_sys_clk_102_4m_cpll_cpu_sys)    cpu_sys_clk_102_4m_cpll_cpu_sys
    set name_clk_102_4m_cpll_cpu_sys cpu_sys_clk_102_4m_cpll_cpu_sys
    set hier_clk_102_4m_cpll_cpu_sys [get_ports clk_102_4m_cpll_cpu_sys]

    create_clock -name cpu_sys_clk_204_8m_cpll_cpu_sys -period $CYCLE_204M8 -add [get_ports clk_204_8m_cpll_cpu_sys]
    lappend CLOCK_GROUP(cpu_sys_clk_204_8m_cpll_cpu_sys)    cpu_sys_clk_204_8m_cpll_cpu_sys
    set name_clk_204_8m_cpll_cpu_sys cpu_sys_clk_204_8m_cpll_cpu_sys
    set hier_clk_204_8m_cpll_cpu_sys [get_ports clk_204_8m_cpll_cpu_sys]

    create_clock -name cpu_sys_clk_245_76m_cpll_cpu_sys -period $CYCLE_245M76 -add [get_ports clk_245_76m_cpll_cpu_sys]
    lappend CLOCK_GROUP(cpu_sys_clk_245_76m_cpll_cpu_sys)    cpu_sys_clk_245_76m_cpll_cpu_sys
    set name_clk_245_76m_cpll_cpu_sys cpu_sys_clk_245_76m_cpll_cpu_sys
    set hier_clk_245_76m_cpll_cpu_sys [get_ports clk_245_76m_cpll_cpu_sys]

    create_clock -name cpu_sys_clk_26m_xo_cpu_sys -period $CYCLE_26M -add [get_ports clk_26m_xo_cpu_sys]
    lappend CLOCK_GROUP(cpu_sys_clk_26m_xo_cpu_sys)    cpu_sys_clk_26m_xo_cpu_sys
    set name_clk_26m_xo_cpu_sys cpu_sys_clk_26m_xo_cpu_sys
    set hier_clk_26m_xo_cpu_sys [get_ports clk_26m_xo_cpu_sys]

    create_clock -name cpu_sys_clk_307_2m_cpll_cpu_sys -period $CYCLE_307M2 -add [get_ports clk_307_2m_cpll_cpu_sys]
    lappend CLOCK_GROUP(cpu_sys_clk_307_2m_cpll_cpu_sys)    cpu_sys_clk_307_2m_cpll_cpu_sys
    set name_clk_307_2m_cpll_cpu_sys cpu_sys_clk_307_2m_cpll_cpu_sys
    set hier_clk_307_2m_cpll_cpu_sys [get_ports clk_307_2m_cpll_cpu_sys]

    create_clock -name cpu_sys_clk_32k_aon_cpu_sys -period $CYCLE_32K -add [get_ports clk_32k_aon_cpu_sys]
    lappend CLOCK_GROUP(cpu_sys_clk_32k_aon_cpu_sys)    cpu_sys_clk_32k_aon_cpu_sys
    set name_clk_32k_aon_cpu_sys cpu_sys_clk_32k_aon_cpu_sys
    set hier_clk_32k_aon_cpu_sys [get_ports clk_32k_aon_cpu_sys]

    create_clock -name cpu_sys_clk_409_6m_cpll_cpu_sys -period $CYCLE_409M6 -add [get_ports clk_409_6m_cpll_cpu_sys]
    lappend CLOCK_GROUP(cpu_sys_clk_409_6m_cpll_cpu_sys)    cpu_sys_clk_409_6m_cpll_cpu_sys
    set name_clk_409_6m_cpll_cpu_sys cpu_sys_clk_409_6m_cpll_cpu_sys
    set hier_clk_409_6m_cpll_cpu_sys [get_ports clk_409_6m_cpll_cpu_sys]

    create_clock -name cpu_sys_clk_480m_usbphy_pll_cpu_sys -period $CYCLE_480M -add [get_ports clk_480m_usbphy_pll_cpu_sys]
    lappend CLOCK_GROUP(cpu_sys_clk_480m_usbphy_pll_cpu_sys)    cpu_sys_clk_480m_usbphy_pll_cpu_sys
    set name_clk_480m_usbphy_pll_cpu_sys cpu_sys_clk_480m_usbphy_pll_cpu_sys
    set hier_clk_480m_usbphy_pll_cpu_sys [get_ports clk_480m_usbphy_pll_cpu_sys]

    create_clock -name cpu_sys_clk_491_52m_cpll_cpu_sys -period $CYCLE_491M52 -add [get_ports clk_491_52m_cpll_cpu_sys]
    lappend CLOCK_GROUP(cpu_sys_clk_491_52m_cpll_cpu_sys)    cpu_sys_clk_491_52m_cpll_cpu_sys
    set name_clk_491_52m_cpll_cpu_sys cpu_sys_clk_491_52m_cpll_cpu_sys
    set hier_clk_491_52m_cpll_cpu_sys [get_ports clk_491_52m_cpll_cpu_sys]

    create_clock -name cpu_sys_clk_51_2m_cpll_cpu_sys -period $CYCLE_51M2 -add [get_ports clk_51_2m_cpll_cpu_sys]
    lappend CLOCK_GROUP(cpu_sys_clk_51_2m_cpll_cpu_sys)    cpu_sys_clk_51_2m_cpll_cpu_sys
    set name_clk_51_2m_cpll_cpu_sys cpu_sys_clk_51_2m_cpll_cpu_sys
    set hier_clk_51_2m_cpll_cpu_sys [get_ports clk_51_2m_cpll_cpu_sys]

    create_clock -name cpu_sys_clk_ap_ahb -period $CYCLE_204M8 -add [get_ports clk_ap_ahb]
    lappend CLOCK_GROUP(cpu_sys_clk_ap_ahb)    cpu_sys_clk_ap_ahb
    set name_clk_ap_ahb cpu_sys_clk_ap_ahb
    set hier_clk_ap_ahb [get_ports clk_ap_ahb]

    create_clock -name cpu_sys_clk_cp_ahb -period $CYCLE_245M76 -add [get_ports clk_cp_ahb]
    lappend CLOCK_GROUP(cpu_sys_clk_cp_ahb)    cpu_sys_clk_cp_ahb
    set name_clk_cp_ahb cpu_sys_clk_cp_ahb
    set hier_clk_cp_ahb [get_ports clk_cp_ahb]

    create_clock -name cpu_sys_clk_cpu_mtck_pad_in -period $CYCLE_26M -add [get_ports clk_cpu_mtck_pad_in]
    lappend CLOCK_GROUP(cpu_sys_clk_cpu_mtck)    cpu_sys_clk_cpu_mtck_pad_in
    set name_clk_cpu_mtck_pad_in cpu_sys_clk_cpu_mtck_pad_in
    set hier_clk_cpu_mtck_pad_in [get_ports clk_cpu_mtck_pad_in]

    create_clock -name cpu_sys_clk_flash_ahb -period $CYCLE_307M2 -add [get_ports clk_flash_ahb]
    lappend CLOCK_GROUP(cpu_sys_clk_flash_ahb)    cpu_sys_clk_flash_ahb
    set name_clk_flash_ahb cpu_sys_clk_flash_ahb
    set hier_clk_flash_ahb [get_ports clk_flash_ahb]

    create_clock -name cpu_sys_clk_pub_ahb -period $CYCLE_204M8 -add [get_ports clk_pub_ahb]
    lappend CLOCK_GROUP(cpu_sys_clk_pub_ahb)    cpu_sys_clk_pub_ahb
    set name_clk_pub_ahb cpu_sys_clk_pub_ahb
    set hier_clk_pub_ahb [get_ports clk_pub_ahb]

    create_clock -name cpu_sys_clk_sys_ram -period $CYCLE_245M76 -add [get_ports clk_sys_ram]
    lappend CLOCK_GROUP(cpu_sys_clk_sys_ram)    cpu_sys_clk_sys_ram
    set name_clk_sys_ram cpu_sys_clk_sys_ram
    set hier_clk_sys_ram [get_ports clk_sys_ram]

    create_clock -name cpu_sys_clk_top_ahb -period $CYCLE_102M4 -add [get_ports clk_top_ahb]
    lappend CLOCK_GROUP(cpu_sys_clk_top_ahb)    cpu_sys_clk_top_ahb
    set name_clk_top_ahb cpu_sys_clk_top_ahb
    set hier_clk_top_ahb [get_ports clk_top_ahb]

    create_clock -name cpu_sys_ptest_slow_occ_clock -period $CYCLE_26M -add [get_ports ptest_slow_occ_clock]
    lappend CLOCK_GROUP(cpu_sys_ptest_slow_occ_clock)    cpu_sys_ptest_slow_occ_clock
    set name_ptest_slow_occ_clock cpu_sys_ptest_slow_occ_clock
    set hier_ptest_slow_occ_clock [get_ports ptest_slow_occ_clock]
}

#############################################################################
###Clock Mux Generate
#############################################################################
###generate mux clock clk_cpu_arm:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cpu_sys_clk_cpu_arm -add \
                      -master_clock $name_clk_491_52m_cpll_cpu_sys \
                      -source $hier_clk_491_52m_cpll_cpu_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CPU_SYS_CLK_CORE_HIER}u_cmind_clk_sw8_clk_cpu_arm/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(cpu_sys_clk_cpu_arm) ${CPU_LIB_HIER}cpu_sys_clk_cpu_arm                                            
set name_clk_cpu_arm cpu_sys_clk_cpu_arm
set hier_clk_cpu_arm ${CPU_SYS_CLK_CORE_HIER}u_cmind_clk_sw8_clk_cpu_arm/$CKOUTZ_HIER

#############################################################################
###OCC scanmux I1 pin Clock Generate
#############################################################################
###generate clk clk_cpu_arm_rtc_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cpu_sys_clk_cpu_arm_rtc_scan -add \
                      -master_clock $name_ptest_slow_occ_clock \
                      -source $hier_ptest_slow_occ_clock \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CPU_SYS_CLK_CORE_HIER}u_clk_cpu_arm_rtc_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cpu_sys_clk_cpu_arm_rtc_scan) ${CPU_LIB_HIER}cpu_sys_clk_cpu_arm_rtc_scan   
set name_clk_cpu_arm_rtc_scan cpu_sys_clk_cpu_arm_rtc_scan
set hier_clk_cpu_arm_rtc_scan ${CPU_SYS_CLK_CORE_HIER}u_clk_cpu_arm_rtc_scanmux/cmind_uj_ckcell/I1

###generate clk clk_cpu_arm_rtc for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cpu_sys_clk_cpu_arm_rtc -add \
                      -master_clock $name_clk_32k_aon_cpu_sys \
                      -source $hier_clk_32k_aon_cpu_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CPU_SYS_CLK_CORE_HIER}u_clk_cpu_arm_rtc_scanmux/cmind_uj_ckcell/I0]
}
lappend CLOCK_GROUP(cpu_sys_clk_cpu_arm_rtc) ${CPU_LIB_HIER}cpu_sys_clk_cpu_arm_rtc   
set name_clk_cpu_arm_rtc cpu_sys_clk_cpu_arm_rtc
set hier_clk_cpu_arm_rtc ${CPU_SYS_CLK_CORE_HIER}u_clk_cpu_arm_rtc_scanmux/cmind_uj_ckcell/I0

###generate clk clk_cpu_mtck_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cpu_sys_clk_cpu_mtck_scan -add \
                      -master_clock $name_ptest_slow_occ_clock \
                      -source $hier_ptest_slow_occ_clock \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CPU_SYS_CLK_CORE_HIER}u_clk_cpu_mtck_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cpu_sys_clk_cpu_mtck_scan) ${CPU_LIB_HIER}cpu_sys_clk_cpu_mtck_scan   
set name_clk_cpu_mtck_scan cpu_sys_clk_cpu_mtck_scan
set hier_clk_cpu_mtck_scan ${CPU_SYS_CLK_CORE_HIER}u_clk_cpu_mtck_scanmux/cmind_uj_ckcell/I1

###generate clk clk_top_ahb_scan_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cpu_sys_clk_top_ahb_scan_scan -add \
                      -master_clock $name_clk_102_4m_cpll_cpu_sys \
                      -source $hier_clk_102_4m_cpll_cpu_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CPU_SYS_CLK_CORE_HIER}u_clk_top_ahb_scan_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cpu_sys_clk_top_ahb_scan_scan) ${CPU_LIB_HIER}cpu_sys_clk_top_ahb_scan_scan   
set name_clk_top_ahb_scan_scan cpu_sys_clk_top_ahb_scan_scan
set hier_clk_top_ahb_scan_scan ${CPU_SYS_CLK_CORE_HIER}u_clk_top_ahb_scan_scanmux/cmind_uj_ckcell/I1

###generate clk clk_sys_ram_scan_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cpu_sys_clk_sys_ram_scan_scan -add \
                      -master_clock $name_clk_245_76m_cpll_cpu_sys \
                      -source $hier_clk_245_76m_cpll_cpu_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CPU_SYS_CLK_CORE_HIER}u_clk_sys_ram_scan_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cpu_sys_clk_sys_ram_scan_scan) ${CPU_LIB_HIER}cpu_sys_clk_sys_ram_scan_scan   
set name_clk_sys_ram_scan_scan cpu_sys_clk_sys_ram_scan_scan
set hier_clk_sys_ram_scan_scan ${CPU_SYS_CLK_CORE_HIER}u_clk_sys_ram_scan_scanmux/cmind_uj_ckcell/I1

###generate clk clk_pub_ahb_scan_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cpu_sys_clk_pub_ahb_scan_scan -add \
                      -master_clock $name_clk_204_8m_cpll_cpu_sys \
                      -source $hier_clk_204_8m_cpll_cpu_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CPU_SYS_CLK_CORE_HIER}u_clk_pub_ahb_scan_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cpu_sys_clk_pub_ahb_scan_scan) ${CPU_LIB_HIER}cpu_sys_clk_pub_ahb_scan_scan   
set name_clk_pub_ahb_scan_scan cpu_sys_clk_pub_ahb_scan_scan
set hier_clk_pub_ahb_scan_scan ${CPU_SYS_CLK_CORE_HIER}u_clk_pub_ahb_scan_scanmux/cmind_uj_ckcell/I1

###generate clk clk_ap_ahb_scan_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cpu_sys_clk_ap_ahb_scan_scan -add \
                      -master_clock $name_clk_204_8m_cpll_cpu_sys \
                      -source $hier_clk_204_8m_cpll_cpu_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CPU_SYS_CLK_CORE_HIER}u_clk_ap_ahb_scan_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cpu_sys_clk_ap_ahb_scan_scan) ${CPU_LIB_HIER}cpu_sys_clk_ap_ahb_scan_scan   
set name_clk_ap_ahb_scan_scan cpu_sys_clk_ap_ahb_scan_scan
set hier_clk_ap_ahb_scan_scan ${CPU_SYS_CLK_CORE_HIER}u_clk_ap_ahb_scan_scanmux/cmind_uj_ckcell/I1

###generate clk clk_cp_ahb_scan_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cpu_sys_clk_cp_ahb_scan_scan -add \
                      -master_clock $name_clk_245_76m_cpll_cpu_sys \
                      -source $hier_clk_245_76m_cpll_cpu_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CPU_SYS_CLK_CORE_HIER}u_clk_cp_ahb_scan_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cpu_sys_clk_cp_ahb_scan_scan) ${CPU_LIB_HIER}cpu_sys_clk_cp_ahb_scan_scan   
set name_clk_cp_ahb_scan_scan cpu_sys_clk_cp_ahb_scan_scan
set hier_clk_cp_ahb_scan_scan ${CPU_SYS_CLK_CORE_HIER}u_clk_cp_ahb_scan_scanmux/cmind_uj_ckcell/I1

###generate clk clk_flash_ahb_scan_scan for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cpu_sys_clk_flash_ahb_scan_scan -add \
                      -master_clock $name_clk_307_2m_cpll_cpu_sys \
                      -source $hier_clk_307_2m_cpll_cpu_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CPU_SYS_CLK_CORE_HIER}u_clk_flash_ahb_scan_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cpu_sys_clk_flash_ahb_scan_scan) ${CPU_LIB_HIER}cpu_sys_clk_flash_ahb_scan_scan   
set name_clk_flash_ahb_scan_scan cpu_sys_clk_flash_ahb_scan_scan
set hier_clk_flash_ahb_scan_scan ${CPU_SYS_CLK_CORE_HIER}u_clk_flash_ahb_scan_scanmux/cmind_uj_ckcell/I1

###generate clk clk_rom_scan for scan mux: added by yan.wang
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name cpu_sys_clk_rom_scan -add \
                      -master_clock $name_clk_204_8m_cpll_cpu_sys \
                      -source $hier_clk_204_8m_cpll_cpu_sys \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${CPU_SYS_CLK_CORE_HIER}u_clk_rom_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(cpu_sys_clk_rom_scan) ${CPU_LIB_HIER}cpu_sys_clk_rom_scan   
set name_cpu_sys_clk_rom_scan cpu_sys_clk_rom_scan
set hier_cpu_sys_clk_rom_scan ${CPU_SYS_CLK_CORE_HIER}u_clk_rom_scanmux/cmind_uj_ckcell/I1

