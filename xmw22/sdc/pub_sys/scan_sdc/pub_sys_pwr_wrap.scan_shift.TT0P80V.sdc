
if {![info exist IS_CHIP]} {
    set IS_CHIP 0
}

if {! $IS_CHIP} {
    set PUB_SYS_HIER ""
    set PUB_SYS_NAME pub_sys
    set PSRAM_CTRL_HIER "${PUB_SYS_HIER}u_pub_sys_top/u_psram_ctrl"
    set PROJ_DIR /proj/NanH/release/v0p9/me/to_be/pub_sys_pwr_wrap/scan_20231214_1323/sdc
    if [regexp "/impl/rev" [info script]] {
        regsub "^.*/release/v" $PROJ_DIR "[regsub "/impl/.*" [info script] ""]/impl/rev" PROJ_DIR
        regsub "/me/to_be" $PROJ_DIR "/exchange" PROJ_DIR
    }
}

source  $PROJ_DIR/de/common/sdc/clk_period.sdc
set_case_analysis 1 ptest_scan_mode
set_case_analysis 1 ptest_dc_mode
set_case_analysis 1 ptest_ac_mode
set_case_analysis 1 ptest_icg_mode
set_case_analysis 1 ptest_mem_bypass_en
set_case_analysis 1 ptest_scan_en
set_case_analysis 1 ptest_ltest_en

create_clock -name ${PUB_SYS_NAME}_scan_shift_edt_clock  -period $CYCLE_SCAN -waveform $WAVEF_SCAN [get_ports ptest_edt_clock] -add
#set CLOCK_GROUP(${PUB_SYS_NAME}_scan_shift_edt_clock)    [list ${PUB_SYS_NAME}_scan_shift_edt_clock]
create_clock -name ${PUB_SYS_NAME}_scan_shift_scan_clock -period $CYCLE_SCAN -waveform $WAVEF_SCAN [get_ports ptest_scan_clock] -add
#set CLOCK_GROUP(${PUB_SYS_NAME}_scan_shift_scan_clock)    [list ${PUB_SYS_NAME}_scan_shift_scan_clock ${PUB_SYS_NAME}_scan_shift_edt_clock]

create_clock -name ${PUB_SYS_NAME}_scan_shift_ijtag_tck  -period $CYCLE_SCAN -waveform $WAVEF_SCAN [get_ports ptest_ijtag_tck] -add
#set CLOCK_GROUP(${PUB_SYS_NAME}_scan_shift_ijtag_tck)    [list ${PUB_SYS_NAME}_scan_shift_ijtag_tck]

set_input_delay  [expr 0.5* $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_shift_edt_clock  [remove_from_collection [get_ports ptest* -filter {@port_direction == in}] [list ptest_edt_clock ptest_scan_clock ptest_slow_occ_clock ptest_ijtag_* ptest_scan_rst_n]] -add
set_input_delay  [expr 0.2* $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_shift_edt_clock [get_ports ptest_scan_rst_n] -add
set_output_delay [expr 0.5* $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_shift_edt_clock  [get_ports ptest_edt_ch_out*] -add 

set_input_delay  [expr 0.5* $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_shift_scan_clock [remove_from_collection [get_ports ptest* -filter {@port_direction == in}] [list ptest_edt_clock ptest_scan_clock ptest_slow_occ_clock ptest_ijtag_* ptest_scan_rst_n]] -add 
set_input_delay  [expr 0.2* $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_shift_scan_clock [get_ports ptest_scan_rst_n] -add

set_input_delay  [expr 0.45* $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_shift_ijtag_tck [remove_from_collection [get_ports  ptest_ijtag_* -filter {@port_direction == in}] [list ptest_ijtag_tck ptest_ijtag_reset ptest_ijtag_sel ptest_ijtag_ue]] -add
set_input_delay  [expr 0.2* $CYCLE_SCAN]  -clock ${PUB_SYS_NAME}_scan_shift_ijtag_tck [get_ports  ptest_ijtag_reset] -add
set_input_delay  [expr 0.2* $CYCLE_SCAN]  -clock ${PUB_SYS_NAME}_scan_shift_ijtag_tck [get_ports  ptest_ijtag_sel] -add
set_input_delay  [expr 0.2* $CYCLE_SCAN]  -clock ${PUB_SYS_NAME}_scan_shift_ijtag_tck [get_ports  ptest_ijtag_ue] -add
set_output_delay [expr 0.4* $CYCLE_SCAN]  -clock ${PUB_SYS_NAME}_scan_shift_ijtag_tck [get_ports  ptest_ijtag_so] -add

#disable the clock gating check on nand gate for delay chain
set_disable_clock_gating_check [get_cells ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs*_dll/u_dphy_delay_chain/*dtc_delay_cell_*/dtc_nand_*/szc_nand2]
set_disable_clock_gating_check [get_cells ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/*dtc_delay_cell_*/dtc_nand_*/szc_nand2]

#source  $PROJ_DIR/de/common/sdc/clk_group.sdc
set_clock_groups -asynchronous -group [list ${PUB_SYS_NAME}_scan_shift_scan_clock ${PUB_SYS_NAME}_scan_shift_edt_clock] -group [get_clocks ${PUB_SYS_NAME}_scan_shift_ijtag_tck]

