if {! $IS_CHIP} {
    #set_case_analysis 0 ptest_scan_mode
    set_case_analysis 0 ptest_scan_en
    #set_case_analysis 0 ptest_mem_bypass_en

    #create_clock -name ${CPU_SYS_NAME}_ijtag_tck -period $CYCLE_20M [get_ports ptest_ijtag_tck] -add
    #set CLOCK_GROUP(${CPU_SYS_NAME}_ijtag_tck)    [list ${CPU_SYS_NAME}_ijtag_tck]

    #create_clock -name ${CPU_SYS_NAME}_scan_clk         -period $CYCLE_26M      -add [get_ports ptest_scan_clock]
    #set CLOCK_GROUP(${CPU_SYS_NAME}_scan_clk)           [list ${CPU_SYS_NAME}_scan_clk  ]    

    #create_clock -name ${PUB_SYS_NAME}_edt_clock  -period $CYCLE_SCAN -waveform $WAVEF_SCAN [get_ports ptest_edt_clock] -add
    #set CLOCK_GROUP(${PUB_SYS_NAME}_edt_clock)    [list ${PUB_SYS_NAME}_edt_clock]


    set_input_delay  [expr 0.4* $CYCLE_SCAN] -clock  ${CPU_SYS_NAME}_ijtag_tck  -add_delay [get_ports  ptest_ijtag_ce]
    set_input_delay  [expr 0.4* $CYCLE_SCAN] -clock  ${CPU_SYS_NAME}_ijtag_tck  -add_delay [get_ports  ptest_ijtag_reset]
    set_input_delay  [expr 0.4* $CYCLE_SCAN] -clock  ${CPU_SYS_NAME}_ijtag_tck  -add_delay [get_ports  ptest_ijtag_se]
    set_input_delay  [expr 0.4* $CYCLE_SCAN] -clock  ${CPU_SYS_NAME}_ijtag_tck  -add_delay [get_ports  ptest_ijtag_sel]
    set_input_delay  [expr 0.4* $CYCLE_SCAN] -clock  ${CPU_SYS_NAME}_ijtag_tck  -add_delay [get_ports  ptest_ijtag_si]
    set_input_delay  [expr 0.4* $CYCLE_SCAN] -clock  ${CPU_SYS_NAME}_ijtag_tck  -add_delay [get_ports  ptest_ijtag_ue]
    set_output_delay [expr 0.4* $CYCLE_SCAN] -clock  ${CPU_SYS_NAME}_ijtag_tck  -add_delay [get_ports  ptest_ijtag_so]

    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_icg_mode      ] 
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_mbist_mode    ] 
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_scan_mode     ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_dc_mode     ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_ac_mode     ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_mem_bypass_en ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_scan_en       ]
    set_input_delay  [expr 0.2 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_scan_rst_n    ]
    set_input_delay  [expr 0.2 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_ltest_en      ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_edt_update    ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_tck_occ_en    ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_edt_ch_in     ]
    set_output_delay [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_edt_ch_out    ]
    
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_edt_clock -add_delay [get_ports  ptest_edt_update    ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_edt_clock -add_delay [get_ports  ptest_edt_ch_in     ]
    set_output_delay [expr 0.5 * $CYCLE_SCAN] -clock ${CPU_SYS_NAME}_edt_clock -add_delay [get_ports  ptest_edt_ch_out    ]

    set_false_path -from [get_ports ptest_scan_mode]
    #set_multicycle_path -setup 2 -from [get_ports ptest_mem_bypass_en]
    set_false_path -from [get_ports ptest_mem_bypass_en] -hold
    
}


