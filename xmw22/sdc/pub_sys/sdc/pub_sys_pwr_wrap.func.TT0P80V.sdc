#-----------------------------------------------------------------
#var
#-----------------------------------------------------------------
#global var
if {![info exist IS_CHIP]} {
    set IS_CHIP 0
}
if {![info exist PROJ_DIR]} {
    set PROJ_DIR /proj/NanH/release/v0p9/me/to_be/pub_sys_pwr_wrap/scan_20231214_1323/sdc
    if [regexp "/impl/rev" [info script]] {
        regsub "^.*/release/v" $PROJ_DIR "[regsub "/impl/.*" [info script] ""]/impl/rev" PROJ_DIR
        regsub "/me/to_be" $PROJ_DIR "/exchange" PROJ_DIR
    }
}
if {![info exist IS_FLAT]} {
    set IS_FLAT 0
}
if {![info exist VDD_CORE]} {
    set VDD_CORE 0.8
}

if {$VDD_CORE==0.8} {
    source $PROJ_DIR/de/pub_sys/sdc/pub_sys_pwr_wrap.all.sdc
}

