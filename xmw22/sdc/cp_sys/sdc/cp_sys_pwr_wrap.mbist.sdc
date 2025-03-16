if {! $IS_CHIP} {
    set_case_analysis 0 ptest_scan_en

    create_clock -name ${CP_SYS_NAME}_ijtag_tck -period $CYCLE_SCAN [get_ports ptest_ijtag_tck] -add
    set CLOCK_GROUP(${CP_SYS_NAME}_ijtag_tck)    [list ${CP_SYS_NAME}_ijtag_tck]
    
    create_clock -name ${CP_SYS_NAME}_scan_clk         -period $CYCLE_SCAN  -waveform $WAVEF_SCAN -add [get_ports ptest_scan_clock]
    set CLOCK_GROUP(${CP_SYS_NAME}_scan_clk)           [list ${CP_SYS_NAME}_scan_clk  ]    
    set period_clk_scan_clk $CYCLE_SCAN

    create_clock -name ${CP_SYS_NAME}_edt_clock  -period $CYCLE_SCAN -waveform $WAVEF_SCAN [get_ports ptest_edt_clock] -add
    set CLOCK_GROUP(${CP_SYS_NAME}_edt_clock)    [list ${CP_SYS_NAME}_edt_clock]

    set_input_delay  [expr 0.4* $CYCLE_SCAN] -clock  ${CP_SYS_NAME}_ijtag_tck  -add_delay [remove_from_collection [get_ports  ptest_ijtag_* -filter {@port_direction == in}] ptest_ijtag_tck] 
    set_output_delay [expr 0.4* $CYCLE_SCAN] -clock  ${CP_SYS_NAME}_ijtag_tck  -add_delay [get_ports  ptest_ijtag_so]

    set_input_delay  [expr 0.5 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_icg_mode      ] 
    set_input_delay  [expr 0.5 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_mbist_mode    ] 
    set_input_delay  [expr 0.5 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_scan_mode     ]
    set_input_delay  [expr 0.5 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_dc_mode       ]
    set_input_delay  [expr 0.5 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_ac_mode       ]
    set_input_delay  [expr 0.5 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_mem_bypass_en ]
    set_input_delay  [expr 0.5 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_scan_en       ]
    set_input_delay  [expr 0.5 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_tck_occ_en    ]

    set_input_delay  [expr 0.2 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_scan_rst_n    ]
    set_input_delay  [expr 0.2 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_ltest_en      ]

    set_input_delay  [expr 0.5 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_edt_clock -add_delay [get_ports  ptest_edt_update    ]
    set_input_delay  [expr 0.5 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_edt_clock -add_delay [get_ports  ptest_edt_ch_in     ]
    set_output_delay [expr 0.5 * $period_clk_scan_clk] -clock ${CP_SYS_NAME}_edt_clock -add_delay [get_ports  ptest_edt_ch_out    ]

    set_false_path -from [get_ports ptest_scan_mode]
    set_multicycle_path -setup 2 -from [get_ports ptest_mem_bypass_en]
    set_false_path -from [get_ports ptest_mem_bypass_en] -hold
    
    if {[sizeof_collection [get_cells -hierarchical  -filter "full_name =~ *occ_edt_tessent*tessent_persistent_clk_clock_out_mux" -quiet]] > 0} {
        set_sense -stop_propagation [get_pins -hierarchical  -filter "full_name =~ *occ_edt_tessent*tessent_persistent_clk_clock_out_mux/I1" -quiet] -clocks ${CP_SYS_NAME}_ijtag_tck
        set_sense -stop_propagation [get_pins -hierarchical  -filter "full_name =~ *occ_edt_tessent*tessent_persistent_clk_clock_out_mux/I1"] -clocks ${CP_SYS_NAME}_scan_clk
    }
}

    if {!$IS_CHIP || $IS_FLAT} {
        create_generated_clock -name cp_sys_clk_rft_mem -add \
                          -master_clock $name_clk_rft \
                          -source $hier_clk_rft \
                          -divide_by 1 \
                          -combinational \
                          [get_pins ${CP_SYS_HIER}u_cp_sys_top/u_cp_mem_dfe_ram_top/u_spram_clk_agc_tbl_0/cmind_uj_ckcell/Z]
    }
    lappend CLOCK_GROUP(clk_245m76_cp_src) ${CP_LIB_HIER}cp_sys_clk_rft_mem   
    
    
    if {!$IS_CHIP || $IS_FLAT} {
        create_generated_clock -name cp_sys_clk_dfe_mem -add \
                          -master_clock $name_clk_dfe \
                          -source $hier_clk_dfe \
                          -divide_by 1 \
                          [get_pins ${CP_SYS_HIER}u_cp_sys_top/u_cp_mem_dfe_ram_top/u_spram_clk_agc_tbl_0/cmind_uj_ckcell/Z]
    }
    lappend CLOCK_GROUP(clk_245m76_cp_src) ${CP_LIB_HIER}cp_sys_clk_dfe_mem   
    set_clock_groups -physically_exclusive -group [get_clocks ${CP_LIB_HIER}cp_sys_clk_rft_mem] -group [get_clocks ${CP_LIB_HIER}cp_sys_clk_dfe_mem]
    set_clock_groups -asynchronous -group [get_clocks ${CP_LIB_HIER}cp_sys_clk_rft] -group [get_clocks ${CP_LIB_HIER}cp_sys_clk_dfe_mem]



