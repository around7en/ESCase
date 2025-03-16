

set PROJ_DIR $env(PROJ_DIR)


set_app_var timing_report_unconstrained_paths true

if {![info exist scenario(name)]} {set  scenario(name) presta}
if {![file exist ../reports/$scenario(name)]} {sh mkdir -p ../reports/$scenario(name)}

source $PROJ_DIR/de/common/sdc/clk_period.sdc
source $PROJ_DIR/de/top/sdc/io_top.var.sdc                                         
source $PROJ_DIR/de/top/sdc/impl_guide/proj_top.func.special_check.tcl             >  ../reports/$scenario(name)/$scenario(name).stc_check.rpt
source $PROJ_DIR/de/ap_sys/sdc/impl_guide/ap_sys_pwr_wrap.func.special_check.tcl   >> ../reports/$scenario(name)/$scenario(name).stc_check.rpt
source $PROJ_DIR/de/cp_sys/sdc/impl_guide/cp_sys_pwr_wrap.func.special_check.tcl   >> ../reports/$scenario(name)/$scenario(name).stc_check.rpt
source $PROJ_DIR/de/top/sdc/impl_guide/proj_top.func.bus_latency.tcl               >> ../reports/$scenario(name)/$scenario(name).stc_check.rpt
source $PROJ_DIR/de/pub_sys/sdc/impl_guide/pub_sys_pwr_wrap.func.special_check.tcl >> ../reports/$scenario(name)/$scenario(name).stc_check.rpt

