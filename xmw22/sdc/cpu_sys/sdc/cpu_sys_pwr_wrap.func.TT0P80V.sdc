set VDD_CPU 0P80

if {![info exist IS_CHIP]} {
    set IS_CHIP 0
}

if {! $IS_CHIP} {
    set CPU_SYS_HIER ""
    set CPU_SYS_NAME cpu_sys
    set PROJ_DIR $env(PROJ_DIR)
}

source $PROJ_DIR/de/cpu_sys/sdc/cpu_sys_pwr_wrap.all.sdc
