set_input_delay  [expr $CYCLE_102M4 * 0.5] -clock $name_clk_top_ahb -add_delay [get_ports h*to_top -filter {@port_direction == in}]
set_output_delay [expr $CYCLE_102M4 * 0.4] -clock $name_clk_top_ahb -add_delay [get_ports h*to_top -filter {@port_direction == out}]

set_input_delay  [expr $CYCLE_102M4 * 0.5] -clock $name_clk_top_ahb -add_delay [get_ports h*from_top -filter {@port_direction == in}]
set_output_delay [expr $CYCLE_102M4 * 0.4] -clock $name_clk_top_ahb -add_delay [get_ports h*from_top -filter {@port_direction == out}]

set_input_delay  [expr $CYCLE_26M * 0.5] -clock ptest_scan_clock  -add_delay [remove_from_collection [get_ports ptest_* -filter {@port_direction == in}] [list ptest_slow_occ_clock ptest_scan_clock]]
set_input_delay  [expr $CYCLE_26M * 0.5] -clock V_CLK_26M -add_delay [get_ports dbgbus* -filter {@port_direction == in}]
set_output_delay [expr $CYCLE_26M * 0.4] -clock V_CLK_26M -add_delay [get_ports dbgbus* -filter {@port_direction == out}]
set_output_delay [expr $CYCLE_26M * 0.4] -clock V_CLK_26M -add_delay [get_ports dbg_deep_sleep_req]
set_input_delay  [expr $CYCLE_26M * 0.4] -clock V_CLK_26M -add_delay [get_ports hw_sel_clk_dbg_uart]

set_input_delay  [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports cpu* -filter {@port_direction == in}]
set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports cpu* -filter {@port_direction == out}]
set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports sw*rst -filter {@port_direction == out}]
set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports cp2*rst -filter {@port_direction == out}]

set out_glb_cfg_list {
    top2cp_dbg_rst                    
    cp2sysram_dbg_rst
    cp2psram_dbg_rst
    adc_ecl_dn_dbg_rst
    cp_mtx_dbg_rst
    cpsys_glb_dbg_rst
    rft_dbg_rst
    top_main_mtx_soft_rst
    top_main_mtx_eb
    clk_top_mtx_force_eb
    soft_rst_pub_glb_rf
    soft_rst_top_glb_reg
    clk_top_mtx_eb
    ext_anti_cond_top2dbg
}

set in_glb_list {
    ext_anti_cond_dbg2top
    wakeup_anti_cond_dbgsys
}
set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports $out_glb_cfg_list]
set_input_delay  [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports $in_glb_list]

set_input_delay  [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports uart_rxd ]
set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports uart_txd ]
set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports uart_dbg_int ]

set_input_delay  [expr $CYCLE_26M * 0.5] -clock $name_clk_tlb_pad_in -add_delay [get_ports tlb* -filter {@port_direction == in}]
set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_tlb_pad_in -add_delay [get_ports tlb* -filter {@port_direction == out}]

set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_32k_aon_dbg_sys -add_delay [get_ports busy_clk_32k_aon_dbg_sys -filter {@port_direction == out}]
set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_32k_aon_dbg_sys -add_delay [get_ports lock_clk_32k_aon_dbg_sys_dbg_uart -filter {@port_direction == out}]
set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_26m_xo_dbg_sys -add_delay [get_ports busy_clk_26m_xo_dbg_sys -filter {@port_direction == out}]
set_output_delay [expr $CYCLE_26M * 0.5] -clock $name_clk_dbg_uart -add_delay [get_ports *_dbg_ready -filter {@port_direction == out}]

set_input_delay  [expr 0.7 * $CYCLE_26M] -clock  $name_clk_swdtck_pad_in  -add_delay [get_ports    SWDITMS]
set_input_delay  [expr 0.4 * $CYCLE_26M] -clock  $name_clk_swdtck_pad_in  -add_delay [get_ports    star_swdoen]
set_input_delay  [expr 0.4 * $CYCLE_26M] -clock  $name_clk_swdtck_pad_in  -add_delay [get_ports    star_swdo]
set_output_delay [expr 0.5 * $CYCLE_26M] -clock  $name_clk_swdtck_pad_in  -add_delay [get_ports    SWDO]
set_output_delay [expr 0.5 * $CYCLE_26M] -clock  $name_clk_swdtck_pad_in  -add_delay [get_ports    SWDOEN]

#set_output_delay [expr 0.4 * $CYCLE_26M] -clock  $name_ptest_slow_occ_clock  -add_delay [remove_from_collection [all_output] [list h*from_top h*to_top clk*]]
#set_input_delay  [expr 0.4 * $CYCLE_26M] -clock  $name_ptest_slow_occ_clock  -add_delay [remove_from_collection [all_input] [list h*from_top h*to_top clk*]]

