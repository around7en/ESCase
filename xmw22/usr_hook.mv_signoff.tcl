#  Mode                  Top-Only       AON         RTC       CP/CPU/AP/PUB
# -------------------------------------------------------------------------
#  func                    0.8v        0.8v        0.8v          0.8v
#  func_0p7v_0p7v          0.7v        0.7v        0.7v          0.8v
#  func_0p8v_0p7v          0.8v        0.7v        0.7v          0.8v

# Scenario name convention
# <MODE>.<TOP_DEFAULT_CORNER>.<RC>.<CHECK>
# Example:
# func_0p7v_0p7v.ssg0p630vm40c.cworst_T_m40c.setup

# V T derate for LVL shifters
source /scratch2/nanh/impl/rev0p9/users/yz.chen/proj_top/ctrl/lvl_derate_hook.tcl

cust_hook_location -name loc_link_design -point before -flow sta_pt {
    global scenario
    global link_path link_path_per_instance
    set link_path_per_instance ""
    regexp {(ssg|ffg|tt)(0p\d+v)(m?\d+c)} $scenario(pvt) -> p v t
    switch $p {
        ssg {
            set l2h_v "0p63v0p72v"
            set h2l_v "0p72v0p63v"
            set pvt_0p7v "ssg0p630v$t"
            set pvt_0p8v "ssg0p720v$t"
        }
        ffg {
            set l2h_v "0p77v0p88v"
            set h2l_v "0p88v0p77v"
            set pvt_0p7v "ffg0p770v$t"
            set pvt_0p8v "ffg0p880v$t"
        }
        tt {
            set l2h_v "0p7v0p8v"
            set h2l_v "0p8v0p7v"
            set pvt_0p7v "tt0p700v$t"
            set pvt_0p8v "tt0p700v$t"
        }
    }
    
    # -----------------
    # LINK AON/RTC
    # -----------------
    if {$scenario(mode) eq "func_0p8v_0p7v"} {
        # In this mode, the libs of aon/rtc are different than default libs used by top, seperately linking aon/rtc
        # In other modes, the libs of aon/rtc of are same to top's, nothing need to do
        set libs_0p7v [cust_mcmm_cfg_get_lib_files $pvt_0p7v.$scenario(rc) -file_type db -mode $scenario(mode)]
        puts "%LVSTA: Set link_path_per_instance for aon/rtc, scenario: $scenario(name), PVT 0p7v: $pvt_0p7v"
        puts "%LVSTA: Libs for 0p7v"
        foreach libname $libs_0p7v {
            puts "  \[0p7v\] $libname"
        }
        lappend link_path_per_instance [list {u_digital_top/u_aon_sys_pwr_wrap} [concat {*} $libs_0p7v]]
        lappend link_path_per_instance [list {u_digital_top/u_xmw_rtc_pwr_wrap} [concat {*} $libs_0p7v]]
    }
    
    # -----------------
    # LINK LVL SHIFTER
    # -----------------
    set v [cust_format_corner_voltage $v -1]
    if {$scenario(mode) in "func_0p8v_0p7v"} {
        # Different LVL voltages
        set l2h_libs [glob -nocomplain /tech/tsmc/tsmc22ull/CLN22ULL/IP/STD/TSMCHOME/digital/Front_End/LVF/CCS/tcbn22ullbwp7t*p140lvlsg*/tcbn22ullbwp7t*p140lvlsg*${p}${l2h_v}${t}_lvf_p_ccs.db]
        set h2l_libs [glob -nocomplain /tech/tsmc/tsmc22ull/CLN22ULL/IP/STD/TSMCHOME/digital/Front_End/LVF/CCS/tcbn22ullbwp7t*p140lvlsg*/tcbn22ullbwp7t*p140lvlsg*${p}${h2l_v}${t}_lvf_p_ccs.db]
    } else {
        # func/func_0p7v_0p7v, LVL voltages are equal
        set l2h_libs [glob -nocomplain /tech/tsmc/tsmc22ull/CLN22ULL/IP/STD/TSMCHOME/digital/Front_End/LVF/CCS/tcbn22ullbwp7t*p140lvlsg*/tcbn22ullbwp7t*p140lvlsg*${p}${v}${v}${t}_lvf_p_ccs.db]
        set h2l_libs [glob -nocomplain /tech/tsmc/tsmc22ull/CLN22ULL/IP/STD/TSMCHOME/digital/Front_End/LVF/CCS/tcbn22ullbwp7t*p140lvlsg*/tcbn22ullbwp7t*p140lvlsg*${p}${v}${v}${t}_lvf_p_ccs.db]
    }
    # Before link-design, we cannot get the LVL instances by get_cell command, we have to prepare the LVL inst list in advance
    redirect -variable lvl_l2h_insts {exec cat /scratch2/nanh/impl/rev0p9/release/proj_top/lvl_insts/l2h_lvl_insts.list}
    redirect -variable lvl_h2l_insts {exec cat /scratch2/nanh/impl/rev0p9/release/proj_top/lvl_insts/h2l_lvl_insts.list}
    set lvl_l2h_insts [join $lvl_l2h_insts " "]
    set lvl_h2l_insts [join $lvl_h2l_insts " "]
    lappend link_path_per_instance [list $lvl_l2h_insts $l2h_libs]
    lappend link_path_per_instance [list $lvl_h2l_insts $h2l_libs]
    
    # -------------------
    # LINK CP/CPU/AP/PUB
    # -------------------
    if {$scenario(mode) eq "func_0p7v_0p7v"} {
        # In this mode, top and aon/rtc are on low voltage 0p7v, need to link othe SYS to 0p8v
        set libs_0p8v [cust_mcmm_cfg_get_lib_files $pvt_0p8v.$scenario(rc) -file_type db -mode $scenario(mode)]
        puts "%LVSTA: Set link_path_per_instance for CP/CPU/AP/PUB, scenario: $scenario(name), PVT 0p8v: $pvt_0p8v"
        puts "%LVSTA: Libs for 0p8v"
        foreach libname $libs_0p8v {
            puts "  \[0p8v\] $libname"
        }
        lappend link_path_per_instance [list u_digital_top/u_cp_sys_pwr_wrap  [concat {*} $libs_0p8v]]
        lappend link_path_per_instance [list u_digital_top/u_cpu_sys_pwr_wrap [concat {*} $libs_0p8v]]
        lappend link_path_per_instance [list u_digital_top/u_ap_sys_pwr_wrap  [concat {*} $libs_0p8v]]
        lappend link_path_per_instance [list u_digital_top/u_pub_sys_pwr_wrap [concat {*} $libs_0p8v]]
    }
    puts "%LVSTA: link_path_per_instance:\n[join $link_path_per_instance \n]"
}

