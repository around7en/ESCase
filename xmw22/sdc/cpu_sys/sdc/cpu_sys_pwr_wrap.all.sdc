#if {![info exist IS_CHIP]} {
#    set IS_CHIP 0
#}
#
#if {! $IS_CHIP} {
#    set CPU_SYS_HIER ""
#    set CPU_SYS_NAME cpu_sys
#    set PROJ_DIR $env(PROJ_DIR)
#}
if {$IS_CHIP && !$IS_FLAT} {
    set CPU_LIB_HIER $CPU_SYS_HIER
} else {
    set CPU_LIB_HIER ""
}

set CPU_SYS_TOP_HIER ${CPU_SYS_HIER}u_cpu_sys_top/

source  $PROJ_DIR/de/common/sdc/clk_period.sdc
#mbist.sdc must create before alll generate clk , because of tools

source $PROJ_DIR/de/cpu_sys/sdc/cpu_sys_pwr_wrap.clk.sdc

if {! $IS_CHIP} {
    source $PROJ_DIR/de/cpu_sys/sdc/cpu_sys_pwr_wrap.io.sdc
} else {

    create_clock -name ${CPU_SYS_NAME}_jtag_clk             -period $CYCLE_26M      -add [get_ports $func_pad_names(swclk)]
    set CLOCK_GROUP(${CPU_SYS_NAME}_jtag_clk)           [list ${CPU_SYS_NAME}_jtag_clk  ]    

    #jtag
    set_input_delay [expr 0.7 * $CYCLE_26M]     -max -clock  ${CPU_SYS_NAME}_jtag_clk  -add_delay [get_ports    $func_pad_names(swdio) ];#SWDITMS
    set_input_delay [expr 0.5 * $CYCLE_26M]     -min -clock  ${CPU_SYS_NAME}_jtag_clk  -add_delay [get_ports    $func_pad_names(swdio) ];#SWDITMS


    set_output_delay [expr 0.5 * $CYCLE_26M]    -max -clock  ${CPU_SYS_NAME}_jtag_clk  -add_delay [get_ports    $func_pad_names(swdio) ];#SWDO
    set_output_delay [expr 0 * $CYCLE_26M]      -min -clock  ${CPU_SYS_NAME}_jtag_clk  -add_delay [get_ports    $func_pad_names(swdio) ];#SWDO

}

if {!$IS_CHIP || $IS_FLAT} {
source $PROJ_DIR/de/cpu_sys/sdc/cpu_sys_pwr_wrap.exception.sdc
#source $PROJ_DIR/de/cpu_sys/sdc/cpu_sys_pwr_wrap.bus_exception.sdc
if {[info exist synopsys_program_name] && ${synopsys_program_name} == "dc_shell"} {
} else {
    source $PROJ_DIR/de/cpu_sys/sdc/cpu_sys_pwr_wrap.data_chk.sdc
}
if {[file exist $PROJ_DIR/de/cpu_sys/sdc/cpu_sys_pwr_wrap.mbist.sdc]} {
    source $PROJ_DIR/de/cpu_sys/sdc/cpu_sys_pwr_wrap.mbist.sdc  
}

if {! $IS_CHIP} {
    source  $PROJ_DIR/de/common/sdc/clk_group.sdc
}
}

