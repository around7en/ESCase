if {! $IS_CHIP} {
    set_case_analysis 0 ptest_scan_en

    create_clock -name ${PUB_SYS_NAME}_ijtag_tck -period $CYCLE_SCAN [get_ports ptest_ijtag_tck] -add
    set CLOCK_GROUP(${PUB_SYS_NAME}_ijtag_tck)    [list ${PUB_SYS_NAME}_ijtag_tck]
    
    create_clock -name ${PUB_SYS_NAME}_scan_clk         -period $CYCLE_SCAN  -waveform $WAVEF_SCAN -add [get_ports ptest_scan_clock]
    set CLOCK_GROUP(${PUB_SYS_NAME}_scan_clk)           [list ${PUB_SYS_NAME}_scan_clk  ]    

    create_clock -name ${PUB_SYS_NAME}_edt_clock  -period $CYCLE_SCAN -waveform $WAVEF_SCAN [get_ports ptest_edt_clock] -add
    set CLOCK_GROUP(${PUB_SYS_NAME}_edt_clock)    [list ${PUB_SYS_NAME}_edt_clock]

    set_input_delay  [expr 0.4* $CYCLE_SCAN] -clock  ${PUB_SYS_NAME}_ijtag_tck  -add_delay [remove_from_collection [get_ports  ptest_ijtag_* -filter {@port_direction == in}] ptest_ijtag_tck] 
    set_output_delay [expr 0.4* $CYCLE_SCAN] -clock  ${PUB_SYS_NAME}_ijtag_tck  -add_delay [get_ports  ptest_ijtag_so]

    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_icg_mode      ] 
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_mbist_mode    ] 
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_scan_mode     ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_dc_mode       ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_ac_mode       ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_mem_bypass_en ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_scan_en       ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_tck_occ_en    ]

    set_input_delay  [expr 0.2 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_scan_rst_n    ]
    set_input_delay  [expr 0.2 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_scan_clk -add_delay [get_ports  ptest_ltest_en      ]

    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_edt_clock -add_delay [get_ports  ptest_edt_update    ]
    set_input_delay  [expr 0.5 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_edt_clock -add_delay [get_ports  ptest_edt_ch_in     ]
    set_output_delay [expr 0.5 * $CYCLE_SCAN] -clock ${PUB_SYS_NAME}_edt_clock -add_delay [get_ports  ptest_edt_ch_out    ]

    set_false_path -from [get_ports ptest_scan_mode]
    #set_multicycle_path -setup 2 -from [get_ports ptest_mem_bypass_en]
    set_false_path -from [get_ports ptest_mem_bypass_en] -hold

}


