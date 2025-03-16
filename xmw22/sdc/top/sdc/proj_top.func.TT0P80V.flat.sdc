#-----------------------------------------------------------------
#var
#-----------------------------------------------------------------
#global var
set PROJ_DIR $env(PROJ_DIR)
set IS_CHIP 1
if {[info exist env(IS_FLAT)]} {
    set IS_FLAT $env(IS_FLAT)
} else {
    set IS_FLAT 1
}
if {[info exist env(VDD_AON)]} {
    set VDD_AON $env(VDD_AON)
} else {
    set VDD_AON 0.8
}
if {[info exist env(VDD_CORE)]} {
    set VDD_CORE $env(VDD_CORE)
} else {
    set VDD_CORE 0.8
}

if {$VDD_AON==0.7 && $VDD_CORE==0.7} {
    source $PROJ_DIR/de/top/sdc/proj_top.dslp.sdc
} elseif {$VDD_AON==0.7 && $VDD_CORE==0.8} {
    source $PROJ_DIR/de/top/sdc/proj_top.corett0p8.dslp.sdc
} elseif {$VDD_AON==0.8 && $VDD_CORE==0.8} {
    source $PROJ_DIR/de/top/sdc/proj_top.all.sdc
}

