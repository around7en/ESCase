#-----------------------------------------------------------------
#var
#-----------------------------------------------------------------
#if {![info exist IS_CHIP]} {
#    set IS_CHIP 0
#}

if {! $IS_CHIP} {
    set PUB_SYS_HIER ""
    set PUB_SYS_NAME pub_sys
    #set PROJ_DIR $env(PROJ_DIR)
    source  $PROJ_DIR/de/common/sdc/clk_period.sdc
    set VCLK_CYCLE $CYCLE_26M
}
if {$IS_CHIP && !$IS_FLAT} {
    set PUB_LIB_HIER $PUB_SYS_HIER
} else {
    set PUB_LIB_HIER ""
}
set PUB_SYS_CLK_CORE_HIER "${PUB_SYS_HIER}u_pub_sys_top/u_pub_sys_clk_core"
#--------------------
#for third part ip
#--------------------
#psram ctrl
set PSRAM_CTRL_HIER "${PUB_SYS_HIER}u_pub_sys_top/u_psram_ctrl"
set CYCLE_PSRAM_CTRL $CYCLE_204M8
set CYCLE_PSRAM_BUS $CYCLE_PSRAM_CTRL
set psram_x16mode 0
if {! $IS_CHIP} {
    #dqs i
    set func_pad_names(psram_dqs_i_0)         "psram_ctrl_dqs_i_0"
    #dq_i
    for {set i 0} {$i < 8} {incr i 1} {
        set func_pad_names(psram_dq_i_${i})         "psram_ctrl_dq_i\[$i\]"
    }
    #ck
    set func_pad_names(psram_ck)            "psram_ctrl_ck_o"
    #dqs o
    set func_pad_names(psram_dqs_o_0)         "psram_ctrl_dqs_o"
    #dq_o
    for {set i 0} {$i < 8} {incr i 1} {
        set func_pad_names(psram_dq_o_${i})         "psram_ctrl_dq_o\[$i\]"
    }
    #dm reset cs n
    set func_pad_names(psram_dm)            "psram_ctrl_dm_o"
    set func_pad_names(psram_reset)         "psram_ctrl_reset_o"
    set func_pad_names(psram_cs_n)          "psram_ctrl_cs_n_o"
} else {
    #dqs i
    set func_pad_names(psram_dqs_i_0)         $func_pad_names(psram_dqs)
    #dq_i
    for {set i 0} {$i < 8} {incr i 1} {
        set func_pad_names(psram_dq_i_${i})         $func_pad_names(psram_dq${i})
    }
    #dqs o
    set func_pad_names(psram_dqs_o_0)         $func_pad_names(psram_dqs)
    #dq_o
    for {set i 0} {$i < 8} {incr i 1} {
        set func_pad_names(psram_dq_o_${i})         $func_pad_names(psram_dq${i})
    }
    set func_pad_names(psram_reset)         "$func_pad_names(psram_reset0_n) $func_pad_names(psram_reset1_n)"
}
#dq_i
set func_pad_names(psram_dq_i0_7)         ""
for {set i 0} {$i < 8} {incr i 1} {
    set func_pad_names(psram_dq_i0_7)           "$func_pad_names(psram_dq_i0_7) $func_pad_names(psram_dq_i_${i})"
}
set func_pad_names(psram_dqs_os)          "$func_pad_names(psram_dqs_o_0)"
#dq_o
set func_pad_names(psram_dq_o0_7)        ""
for {set i 0} {$i < 8} {incr i 1} {
    set func_pad_names(psram_dq_o0_7)           "$func_pad_names(psram_dq_o0_7) $func_pad_names(psram_dq_o_${i})"
}
set func_pad_names(psram_dq_os)        "$func_pad_names(psram_dq_o0_7)"

set psram_ctrl_cell_nand_o "ZN"
#set synopsys_program_name "dc_shell"
#set synopsys_program_name "";#exist in synopsys
#-----------------------------------------------------------------
#clock
#-----------------------------------------------------------------
#clk in
#if {! $IS_CHIP} {
#    #create_clock -name vclk -period $VCLK_CYCLE
#    #lappend CLOCK_GROUP(vclk) vclk
#    create_clock -name clk_top_mtx -period $CYCLE_102M4 [get_ports clk_top_mtx]
#    lappend CLOCK_GROUP(clk_top_mtx) clk_top_mtx
#    set name_clk_top_mtx clk_top_mtx
#    set hier_clk_top_mtx [get_ports clk_top_mtx]
#    #create_clock -name ptest_scan_clock -period $CYCLE_26M [get_ports ptest_scan_clock]
#    #lappend CLOCK_GROUP(ptest_scan_clock) ptest_scan_clock
#}
#clk core
source  $PROJ_DIR/de/pub_sys/sdc/pub_sys_pwr_wrap.mbist.sdc
source  $PROJ_DIR/de/pub_sys/sdc/pub_sys_clk_core.sdc
#clk out
foreach clk_i {cpu cp ap} {
    if {! $IS_CHIP} {
        create_generated_clock  \
            -name clk_pub_ahb_for_${clk_i} \
            -master_clock pub_sys_clk_pub_main_mtx \
            -source [get_pins $PUB_SYS_CLK_CORE_HIER/u_clk_pub_main_mtx_mux/$CKOUTZ_HIER] \
            -combinational \
            -add \
            [get_ports clk_pub_ahb_for_${clk_i}] 
        lappend CLOCK_GROUP(pub_sys_clk_pub_main_mtx) ${PUB_LIB_HIER}clk_pub_ahb_for_${clk_i}
    } elseif {$IS_CHIP && !$IS_FLAT} {
        lappend CLOCK_GROUP(pub_sys_clk_pub_main_mtx) ${PUB_LIB_HIER}clk_pub_ahb_for_${clk_i}
    }
}

#--------------------
#third part ip
#--------------------
set pub_sys_clk_pub_psram_ctrl pub_sys_clk_pub_main_mtx
set name_pub_sys_clk_pub_psram_ctrl pub_sys_clk_pub_main_mtx
#set hier_pub_sys_clk_pub_psram_ctrl [get_object_name ${PUB_SYS_CLK_CORE_HIER}/u_clk_pub_psram_ctrl_cg/$CKOUTQ_HIER]
set hier_pub_sys_clk_pub_psram_ctrl ${PUB_SYS_CLK_CORE_HIER}/u_clk_pub_main_mtx_mux/$CKOUTZ_HIER
source $PROJ_DIR/de/pub_sys/sdc/psram_ctrl_func.sdc

#-----------------------------------------------------------------
#IO
#-----------------------------------------------------------------
if {! $IS_CHIP} {
    set async_ports {
        soft_rst_pub_glb_rf
        pub_deep_sleep_req
        dbgbus_data
        dbgbus_chain_sel
        clk_26m_pub_busy_out
        clk_61_44m_pub_busy_out
        clk_76_8m_pub_busy_out
        clk_102_4m_pub_busy_out
        clk_122_88m_pub_busy_out
        clk_153_6m_pub_busy_out
        clk_204_8m_pub_busy_out
        pub_dummy_in
        pub_dummy_out
        clk_pub_cfg_eb
        hmtx_dbg_ready
        sys2pub_anti_ext
        cpu2pub_anti_ext
        ap2pub_anti_ext
        cp2pub_anti_ext
        clk_top_mtx_busy_ext
        clk_pub_ahb_for_cpu_busy_ext
        clk_pub_ahb_for_ap_busy_ext
        clk_pub_ahb_for_cp_busy_ext
        rst_pub_pwr_n
    }
    set_input_delay [expr $VCLK_CYCLE*0.1] -clock vclk [get_ports -filter "@port_direction == in" $async_ports]
    set_output_delay [expr $VCLK_CYCLE*0.1] -clock vclk [get_ports -filter "@port_direction == out" $async_ports]

    set rst_ports {
        rst_pub_pwr_n
    }

    set pubsys_total_apb_ports {
        pubsys_total_psel    
        pubsys_total_penable 
        pubsys_total_pwrite  
        pubsys_total_paddr   
        pubsys_total_pwdata  
        pubsys_total_prdata  
        pubsys_total_pprot   
        pubsys_total_pstrb   
        pubsys_total_pready  
        pubsys_total_pslverr 
    }
    set top2psram_ahb_ports {
        top2psram_haddr      
        top2psram_hburst     
        top2psram_hmastlock  
        top2psram_hprot      
        top2psram_hready     
        top2psram_hsel       
        top2psram_hsize      
        top2psram_htrans     
        top2psram_hwdata     
        top2psram_hwrite     
        top2psram_hrdata     
        top2psram_hreadyout  
        top2psram_hresp      
    }
    set cpu2psram_ahb_ports {
        cpu2psram_haddr      
        cpu2psram_htrans     
        cpu2psram_hwrite     
        cpu2psram_hsize      
        cpu2psram_hburst     
        cpu2psram_hprot      
        cpu2psram_hwdata     
        cpu2psram_hmastlock  
        cpu2psram_hrdata     
        cpu2psram_hready     
        cpu2psram_hresp      
    }
    set ap2psram_ahb_ports {
        ap2psram_haddr       
        ap2psram_htrans      
        ap2psram_hwrite      
        ap2psram_hsize       
        ap2psram_hburst      
        ap2psram_hprot       
        ap2psram_hwdata      
        ap2psram_hmastlock   
        ap2psram_hrdata      
        ap2psram_hready      
        ap2psram_hresp       
    }
    set cp2psram_ahb_ports {
        cp2psram_haddr       
        cp2psram_htrans      
        cp2psram_hwrite      
        cp2psram_hsize       
        cp2psram_hburst      
        cp2psram_hprot       
        cp2psram_hwdata      
        cp2psram_hmastlock   
        cp2psram_hrdata      
        cp2psram_hready      
        cp2psram_hresp       
    }
    set_input_delay [expr $CYCLE_102M4*0.5] -clock $name_clk_top_mtx [get_ports -filter "@port_direction == in" "$pubsys_total_apb_ports $top2psram_ahb_ports"]
    set_output_delay [expr $CYCLE_102M4*0.5] -clock $name_clk_top_mtx [get_ports -filter "@port_direction == out" "$pubsys_total_apb_ports $top2psram_ahb_ports"]
    #set_input_delay [expr $CYCLE_204M8*0.5] -clock clk_pub_main_mtx_o [get_ports -filter "@port_direction == in" "$cpu2psram_ahb_ports $ap2psram_ahb_ports $cp2psram_ahb_ports"]
    #set_output_delay [expr $CYCLE_204M8*0.5] -clock clk_pub_main_mtx_o [get_ports -filter "@port_direction == out" "$cpu2psram_ahb_ports $ap2psram_ahb_ports $cp2psram_ahb_ports"]
    set_input_delay [expr $CYCLE_204M8*0.5] -clock clk_pub_ahb_for_cpu [get_ports -filter "@port_direction == in" "$cpu2psram_ahb_ports"]
    set_output_delay [expr $CYCLE_204M8*0.5] -clock clk_pub_ahb_for_cpu [get_ports -filter "@port_direction == out" "$cpu2psram_ahb_ports"]
    set_input_delay [expr $CYCLE_204M8*0.5] -clock clk_pub_ahb_for_ap [get_ports -filter "@port_direction == in" "$ap2psram_ahb_ports"]
    set_output_delay [expr $CYCLE_204M8*0.5] -clock clk_pub_ahb_for_ap [get_ports -filter "@port_direction == out" "$ap2psram_ahb_ports"]
    set_input_delay [expr $CYCLE_204M8*0.5] -clock clk_pub_ahb_for_cp [get_ports -filter "@port_direction == in" "$cp2psram_ahb_ports"]
    set_output_delay [expr $CYCLE_204M8*0.5] -clock clk_pub_ahb_for_cp [get_ports -filter "@port_direction == out" "$cp2psram_ahb_ports"]

    set psram_ctrl_io_ports {
        psram_ctrl_dqs_i_0   
        psram_ctrl_dqs_i_1   
        psram_ctrl_dq_i      
        psram_ctrl_ck_o      
        psram_ctrl_ck_n_o    
        psram_ctrl_cs_n_o    
        psram_ctrl_dqs_o     
        psram_ctrl_dq_o      
        psram_ctrl_dm_o      
        psram_ctrl_reset_o   
        psram_ctrl_dm_oe     
        psram_ctrl_dqs_oe    
        psram_ctrl_dqs_adl_oe
        psram_ctrl_dq_oe     
        psram_ctrl_ck_adl_oe 
        psram_ctrl_cs_n_adl_oe
    }
    #unconstraint in psram_ctrl_func.sdc
    set psram_ctrl_unconst_ports {
        psram_ctrl_ck_n_o    
        psram_ctrl_reset_o   
        psram_ctrl_dm_oe     
        psram_ctrl_dqs_adl_oe
        psram_ctrl_ck_adl_oe 
        psram_ctrl_cs_n_adl_oe
    }
    #set_input_delay [expr $CYCLE_204M8*0.1] -clock CK_O [get_ports -filter "@port_direction == in" "$psram_ctrl_unconst_ports"]
    set_output_delay [expr $CYCLE_204M8*0.1] -clock CK_O [get_ports -filter "@port_direction == out" "$psram_ctrl_unconst_ports"]
}
#-----------------------------------------------------------------
#exception
#-----------------------------------------------------------------
if {!$IS_CHIP || $IS_FLAT} {
#clr/set false path
#set_false_path -from [get_pins ${PUB_SYS_HIER}u_pub_sys_top/u_pub_sys_rst_core/u_cmind_rst_psram_ctrl_n/u_cmind_cell_ckmux2_o_rst_n/cmind_uj_ckcell/Z] -to [get_pins ${PUB_SYS_HIER}u_pub_sys_top/u_psram_ctrl/u_digital_phy/dtc_dqs0_aset_mux/dtc_mx2/Z]
#set_false_path -from [get_pins ${PUB_SYS_HIER}u_pub_sys_top/u_pub_sys_rst_core/u_cmind_rst_psram_ctrl_n/u_cmind_cell_ckmux2_o_rst_n/cmind_uj_ckcell/Z] -to [get_pins ${PUB_SYS_HIER}u_pub_sys_top/u_psram_ctrl/u_digital_phy/dtc_dqs1_aset_mux/dtc_mx2/Z]
set mem_lists [get_object_name [get_cells * -hierarchical -filter "(is_memory_cell == true) && (ref_name =~ *T22ARF2*)"]]
foreach mem_list $mem_lists {
    set_disable_timing $mem_list -from CLKA -to CLKB
    set_disable_timing $mem_list -from CLKB -to CLKA
}

set sdfcsnq_lists "
    $PSRAM_CTRL_HIER/u_digital_phy/dqs1_gating_d3_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs1_gating_d4_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs0_gating_d1_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs0_gating_d2_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs0_gating_d3_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs0_gating_d4_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs1_gating_d1_reg
    $PSRAM_CTRL_HIER/u_digital_phy/dqs1_gating_d2_reg
"
foreach sdfcsnq_list $sdfcsnq_lists {
    set_disable_timing $sdfcsnq_list -from CDN -to SDN
    set_disable_timing $sdfcsnq_list -from SDN -to CDN
}
#source $PROJ_DIR/de/pub_sys/sdc/pub_sys_pwr_wrap.data_chk.sdc

#set_sense -stop_propagation -clocks DQS_CK $PSRAM_CTRL_HIER/u_psram_ctrl_th/e_wcmd_rwds_flag_reg/D
#set_sense -stop_propagation -clocks DQS_CK $PSRAM_CTRL_HIER/u_psram_ctrl_th/mr_rwds_flag_reg/D
#set_sense -stop_propagation -clocks DQS_CK $PSRAM_CTRL_HIER/u_psram_ctrl_th/e_rcmd_rwds_flag_reg/D
#set_sense -stop_propagation -clocks WDLL_CK_90 $PSRAM_CTRL_HIER/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_pd/tmp_result_reg/D
#set_sense -stop_propagation -clocks RDLL0_DQS_CK_90 $PSRAM_CTRL_HIER/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_pd/tmp_result_reg/D

set_false_path -from [get_pins $PSRAM_CTRL_HIER/u_psram_ctrl_reg/reg_psram_type_reg*/CP] -to DQS_CK
set_false_path -from [get_pins $PSRAM_CTRL_HIER/u_psram_ctrl_reg/reg_psram_type_reg*/CP] -to CK_O

set_false_path -th ${PUB_SYS_HIER}dbgbus_data

#if {$IS_CHIP} {
#    set_false_path -from DQS_CK -th u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_psram_dqs/cmind_uj_ckcell/I0
#}
}

if {$IS_FLAT} {
    set_false_path -from [get_ports DQS] -to $PSRAM_CTRL_HIER/u_psram_ctrl_th/e_wcmd_rwds_flag_reg/D
    set_false_path -from [get_ports DQS] -to $PSRAM_CTRL_HIER/u_psram_ctrl_th/mr_rwds_flag_reg/D
    set_false_path -from [get_ports DQS] -to $PSRAM_CTRL_HIER/u_psram_ctrl_th/e_rcmd_rwds_flag_reg/D
}

#-----------------------------------------------------------------
#clock group
#-----------------------------------------------------------------
if {! $IS_CHIP} {
    source  $PROJ_DIR/de/common/sdc/clk_group.sdc
}
