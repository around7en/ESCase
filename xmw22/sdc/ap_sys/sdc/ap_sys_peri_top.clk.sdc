if {! $IS_CHIP} {
    create_clock -name ${AP_SYS_NAME}_usbphy_test_clk   -period $CYCLE_26M -add [get_ports usbphy_test_clk]
    set CLOCK_GROUP(${AP_SYS_NAME}_usbphy_test_clk)      [list ${AP_SYS_NAME}_usbphy_test_clk]
} else {
    create_clock -name ${AP_SYS_NAME}_usbphy_test_clk   -period $CYCLE_26M -add [get_ports $func_pad_names(usbphy_test_clk)]
    set CLOCK_GROUP(${AP_SYS_NAME}_usbphy_test_clk)      [list ${AP_SYS_NAME}_usbphy_test_clk]
}

##################spi0_sck_in and spi0_sclk_generated#####################
if {! $IS_CHIP} {
    create_clock -name ${AP_SYS_NAME}_spi0_sclk_in   -period $CYCLE_26M -add [get_ports spi0_sclk_in]
    set CLOCK_GROUP(${AP_SYS_NAME}_spi0_sclk_in)      [list ${AP_SYS_NAME}_spi0_sclk_in]
} else {
    create_clock -name ${AP_SYS_NAME}_spi0_sclk_in   -period $CYCLE_26M -add [get_ports $func_pad_names(cam_spi_clk)]
    set CLOCK_GROUP(${AP_SYS_NAME}_spi0_sclk_in)      [list ${AP_SYS_NAME}_spi0_sclk_in]
}

##################spi1_sck_in and spi1_sclk_generated#####################
######spi1_apb_gate#########
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_spi1_apb_gate -add \
                      -master_clock $name_clk_spi1_apb \
                      -source $hier_clk_spi1_apb \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_clk_core_top/u_ap_clk_core_wrap/u_ap_clk_core/u_icg_clk_spi1_apb_occin/u_cmind_cell_ckout/cmind_uj_ckcell/Q]
}
lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb) ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi1_apb_gate 
set name_clk_spi1_apb_gate ap_sys_clk_spi1_apb_gate
set hier_clk_spi1_apb_gate ${AP_SYS_HIER}u_ap_sys_top/u_ap_clk_core_top/u_ap_clk_core_wrap/u_ap_clk_core/u_icg_clk_spi1_apb_occin/u_cmind_cell_ckout/cmind_uj_ckcell/Q

######spi1_sclk_out#########
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_spi1_sclk_out -add \
                      -master_clock $name_clk_spi1_apb_gate \
                      -source $hier_clk_spi1_apb_gate \
                      -divide_by 2 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi1/i_spi_display_control/sclk_out_reg/Q]
}
lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb) ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi1_sclk_out 
set name_clk_spi1_sclk_out ap_sys_clk_spi1_sclk_out
set hier_clk_spi1_sclk_out ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi1/i_spi_display_control/sclk_out_reg/Q

if {! $IS_CHIP} {
    #sys only
    create_generated_clock -name ${AP_SYS_NAME}_spi1_sclk_generated -add \
                      -master_clock $name_clk_spi1_sclk_out \
                      -source $hier_clk_spi1_sclk_out \
                      -divide_by 1 \
                      -combinational \
                      [get_ports spi1_sclk_out]
    lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb)       ${AP_SYS_NAME}_spi1_sclk_generated
} elseif {$IS_CHIP && !$IS_FLAT} {
    lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb)       ${AP_LIB_HIER}spi1_sclk_out
    #top only
    set spi1_sclk_gen_num 1 
    foreach i $func_pad_names(lcd_spi_clk) {
        create_generated_clock -name ${AP_SYS_NAME}_spi1_sclk_generated_$i -add \
                          -master_clock ${AP_LIB_HIER}spi1_sclk_out \
                          -source ${AP_LIB_HIER}spi1_sclk_out \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $i]
        #set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb_$i)    [list ${AP_SYS_NAME}_clk_spi1_apb ${AP_SYS_NAME}_spi1_sclk_generated_$i]
        set CLOCK_GROUP_1(SPI1_SCK_GEN$spi1_sclk_gen_num)    [list ${AP_SYS_NAME}_spi1_sclk_generated_$i]
        lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb)     $CLOCK_GROUP_1(SPI1_SCK_GEN$spi1_sclk_gen_num)
        incr spi1_sclk_gen_num 
    }
} elseif {$IS_FLAT} {
    #flat
    set spi1_sclk_gen_num 1 
    foreach i $func_pad_names(lcd_spi_clk) {
        create_generated_clock -name ${AP_SYS_NAME}_spi1_sclk_generated_$i -add \
                          -master_clock $name_clk_spi1_sclk_out \
                          -source $hier_clk_spi1_sclk_out \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $i]
        #set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb_$i)    [list ${AP_SYS_NAME}_clk_spi1_apb ${AP_SYS_NAME}_spi1_sclk_generated_$i]
        set CLOCK_GROUP_1(SPI1_SCK_GEN$spi1_sclk_gen_num)    [list ${AP_SYS_NAME}_spi1_sclk_generated_$i]
        lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb)    $CLOCK_GROUP_1(SPI1_SCK_GEN$spi1_sclk_gen_num)
        incr spi1_sclk_gen_num 
    }
}

##################spi2_sck_in and spi2_sclk_generated#####################
######spi2_apb_gate#########
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_spi2_apb_gate -add \
                      -master_clock $name_clk_spi2_apb \
                      -source $hier_clk_spi2_apb \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_clk_core_top/u_ap_clk_core_wrap/u_ap_clk_core/u_icg_clk_spi2_apb_occin/u_cmind_cell_ckout/cmind_uj_ckcell/Q]
}
lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb) ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi2_apb_gate 
set name_clk_spi2_apb_gate ap_sys_clk_spi2_apb_gate
set hier_clk_spi2_apb_gate ${AP_SYS_HIER}u_ap_sys_top/u_ap_clk_core_top/u_ap_clk_core_wrap/u_ap_clk_core/u_icg_clk_spi2_apb_occin/u_cmind_cell_ckout/cmind_uj_ckcell/Q

######spi2_sclk_out#########
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_spi2_sclk_out -add \
                      -master_clock $name_clk_spi2_apb_gate \
                      -source $hier_clk_spi2_apb_gate \
                      -divide_by 2 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_control/sclk_out_reg/Q]

}
lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb) ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi2_sclk_out 
set name_clk_spi2_sclk_out ap_sys_clk_spi2_sclk_out
set hier_clk_spi2_sclk_out ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi2/i_cdnsspi_control/sclk_out_reg/Q
if {! $IS_CHIP} {
    create_clock -name ${AP_SYS_NAME}_spi2_sclk_in   -period $CYCLE_26M -add [get_ports spi2_sclk_in]
    set CLOCK_GROUP(${AP_SYS_NAME}_spi2_sclk_in)      [list ${AP_SYS_NAME}_spi2_sclk_in]

    create_generated_clock -name ${AP_SYS_NAME}_spi2_sclk_generated -add \
                      -master_clock $name_clk_spi2_sclk_out \
                      -source $hier_clk_spi2_sclk_out \
                      -divide_by 1 \
                      -combinational \
                      [get_ports spi2_sclk_out]
    lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb)        ${AP_SYS_NAME}_spi2_sclk_generated
} elseif {$IS_CHIP && !$IS_FLAT} {
    lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb)        ${AP_LIB_HIER}spi2_sclk_out 
    set spi2_sclk_gen_num 1 
    foreach i $func_pad_names(spi2_clk) {
        create_clock -name ${AP_SYS_NAME}_spi2_sclk_in_$i   -period $CYCLE_26M -add [get_ports $i]
        set CLOCK_GROUP(${AP_SYS_NAME}_spi2_sclk_in_$i)      [list ${AP_SYS_NAME}_spi2_sclk_in_$i]
    
        create_generated_clock -name ${AP_SYS_NAME}_spi2_sclk_generated_$i -add \
                          -master_clock ${AP_LIB_HIER}spi2_sclk_out \
                          -source ${AP_LIB_HIER}spi2_sclk_out \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $i]
        #set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb_$i)    [list ${AP_SYS_NAME}_clk_spi2_apb ${AP_SYS_NAME}_spi2_sclk_generated_$i]
        set CLOCK_GROUP_1(SPI2_SCK_GEN$spi2_sclk_gen_num)    [list ${AP_SYS_NAME}_spi2_sclk_generated_$i]
        set CLOCK_GROUP_1(SPI2_SCK_IN$spi2_sclk_gen_num)    [list ${AP_SYS_NAME}_spi2_sclk_in_$i]
        lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb)    $CLOCK_GROUP_1(SPI2_SCK_GEN$spi2_sclk_gen_num)
        incr spi2_sclk_gen_num 
    }
} elseif {$IS_FLAT} {
    set spi2_sclk_gen_num 1 
    foreach i $func_pad_names(spi2_clk) {
        create_clock -name ${AP_SYS_NAME}_spi2_sclk_in_$i   -period $CYCLE_26M -add [get_ports $i]
        set CLOCK_GROUP(${AP_SYS_NAME}_spi2_sclk_in_$i)      [list ${AP_SYS_NAME}_spi2_sclk_in_$i]
    
        create_generated_clock -name ${AP_SYS_NAME}_spi2_sclk_generated_$i -add \
                          -master_clock $name_clk_spi2_sclk_out \
                          -source $hier_clk_spi2_sclk_out \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $i]
        #set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb_$i)    [list ${AP_SYS_NAME}_clk_spi2_apb ${AP_SYS_NAME}_spi2_sclk_generated_$i]
        set CLOCK_GROUP_1(SPI2_SCK_GEN$spi2_sclk_gen_num)    [list ${AP_SYS_NAME}_spi2_sclk_generated_$i]
        set CLOCK_GROUP_1(SPI2_SCK_IN$spi2_sclk_gen_num)    [list ${AP_SYS_NAME}_spi2_sclk_in_$i]
        lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb)    $CLOCK_GROUP_1(SPI2_SCK_GEN$spi2_sclk_gen_num)
        incr spi2_sclk_gen_num 
    }
}

####### qspi clock #########
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_qspi_sck_div -add \
                      -master_clock $name_clk_spi_flash \
                      -source $hier_clk_spi_flash \
                      -divide_by 2 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/u_sck_out/cmind_uj_ckcell/Z]
set name_clk_qspi_sck_div ap_sys_clk_qspi_sck_div
set hier_clk_qspi_sck_div ${AP_SYS_HIER}u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/u_sck_out/cmind_uj_ckcell/Z
}
lappend CLOCK_GROUP(ap_sys_clk_spi_flash)  ${AP_LIB_HIER}ap_sys_clk_qspi_sck_div

if {! $IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_QSPI_SCK -add \
                          -master_clock $name_clk_qspi_sck_div \
                          -source $hier_clk_qspi_sck_div \
                          -divide_by 1 \
                          -combinational \
                          [get_ports qspi_sck_o]
    
    create_generated_clock -name ${AP_SYS_NAME}_QSPI_SCK_D3 -add \
                          -master_clock $name_clk_qspi_sck_div \
                          -source $hier_clk_qspi_sck_div \
                          -divide_by 1 \
                          -combinational \
                          [get_ports qspi_do_o?3?]
} elseif {$IS_CHIP && !$IS_FLAT} {
    #lappend CLOCK_GROUP(ap_sys_clk_spi_flash) ${AP_LIB_HIER}qspi_do_o\[3\] ${AP_LIB_HIER}qspi_sck_o
    set CLOCK_GROUP(ap_sys_clk_spi_flash) [concat $CLOCK_GROUP(ap_sys_clk_spi_flash) ${AP_LIB_HIER}qspi_sck_o ${AP_LIB_HIER}qspi_do_o\[3\]]
    create_generated_clock -name ${AP_SYS_NAME}_QSPI_SCK -add \
                          -master_clock ${AP_LIB_HIER}qspi_sck_o \
                          -source ${AP_LIB_HIER}qspi_sck_o \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $func_pad_names(qspi_sck_d3)]
    
    create_generated_clock -name ${AP_SYS_NAME}_QSPI_SCK_D3 -add \
                          -master_clock ${AP_LIB_HIER}qspi_do_o\[3\] \
                          -source ${AP_LIB_HIER}qspi_do_o\[3\] \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $func_pad_names(qspi_d3_sck)]
} elseif {$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_QSPI_SCK -add \
                          -master_clock $name_clk_qspi_sck_div \
                          -source $hier_clk_qspi_sck_div \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $func_pad_names(qspi_sck_d3)]
    
    create_generated_clock -name ${AP_SYS_NAME}_QSPI_SCK_D3 -add \
                          -master_clock $name_clk_qspi_sck_div \
                          -source $hier_clk_qspi_sck_div \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $func_pad_names(qspi_d3_sck)]
}
lappend CLOCK_GROUP(ap_sys_clk_spi_flash) ${AP_SYS_NAME}_QSPI_SCK  ${AP_SYS_NAME}_QSPI_SCK_D3
lappend CLOCK_GROUP_1(ap_sys_clk_spi_flash_sck) ${AP_SYS_NAME}_QSPI_SCK  
lappend CLOCK_GROUP_1(ap_sys_clk_spi_flash_d3) ${AP_SYS_NAME}_QSPI_SCK_D3
####### sim0 clock #########
if {! $IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_sim0_clk -add \
                      -master_clock $name_clk_sim0_apb \
                      -source $hier_clk_sim0_apb \
                      -divide_by 8 \
                      [get_ports o_sim0_clk]
} elseif {$IS_CHIP && !$IS_FLAT} {
    lappend CLOCK_GROUP(ap_sys_clk_sim0_apb) ${AP_LIB_HIER}o_sim0_clk
    create_generated_clock -name ${AP_SYS_NAME}_sim0_clk -add \
                      -master_clock ${AP_LIB_HIER}o_sim0_clk \
                      -source ${AP_LIB_HIER}o_sim0_clk \
                      -divide_by 8 \
                      [get_ports $func_pad_names(sim0_clk)]
} elseif {$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_sim0_clk -add \
                      -master_clock $name_clk_sim0_apb \
                      -source $hier_clk_sim0_apb \
                      -divide_by 8 \
                      [get_ports $func_pad_names(sim0_clk)]
}
lappend CLOCK_GROUP(ap_sys_clk_sim0_apb) ${AP_SYS_NAME}_sim0_clk
####### sim1 clock #########
if {! $IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_sim1_clk -add \
                      -master_clock $name_clk_sim1_apb \
                      -source $hier_clk_sim1_apb \
                      -divide_by 8 \
                      [get_ports o_sim1_clk]
} elseif {$IS_CHIP && !$IS_FLAT} {
    lappend CLOCK_GROUP(ap_sys_clk_sim1_apb) ${AP_LIB_HIER}o_sim1_clk
    create_generated_clock -name ${AP_SYS_NAME}_sim1_clk -add \
                      -master_clock ${AP_LIB_HIER}o_sim1_clk \
                      -source ${AP_LIB_HIER}o_sim1_clk \
                      -divide_by 8 \
                      [get_ports $func_pad_names(sim1_clk)]
} elseif {$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_sim1_clk -add \
                      -master_clock $name_clk_sim1_apb \
                      -source $hier_clk_sim1_apb \
                      -divide_by 8 \
                      [get_ports $func_pad_names(sim1_clk)]
}
lappend CLOCK_GROUP(ap_sys_clk_sim1_apb) ${AP_SYS_NAME}_sim1_clk

####### ext qspi clock #########
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_ext_qspi_sck_div -add \
                      -master_clock $name_clk_ap_apb \
                      -source $hier_clk_ap_apb \
                      -divide_by 2 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_ext_qspi_flashc/u_qspi_flashc_fsm/u_sck_out/cmind_uj_ckcell/Z]
set name_clk_ext_qspi_sck_div ap_sys_clk_ext_qspi_sck_div
set hier_clk_ext_qspi_sck_div ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_ext_qspi_flashc/u_qspi_flashc_fsm/u_sck_out/cmind_uj_ckcell/Z
}
lappend CLOCK_GROUP(ap_sys_clk_ap_ahb) ${AP_LIB_HIER}${AP_SYS_NAME}_clk_ext_qspi_sck_div 

if {! $IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_EXT_QSPI_SCK -add \
                          -master_clock $name_clk_ext_qspi_sck_div \
                          -source $hier_clk_ext_qspi_sck_div \
                          -divide_by 1 \
                          -combinational \
                          [get_ports ext_spi_sck_o]
} elseif {$IS_CHIP && !$IS_FLAT} {
    lappend CLOCK_GROUP(ap_sys_clk_ap_ahb) ${AP_LIB_HIER}ext_spi_sck_o
    create_generated_clock -name ${AP_SYS_NAME}_EXT_QSPI_SCK -add \
                          -master_clock ${AP_LIB_HIER}ext_spi_sck_o \
                          -source ${AP_LIB_HIER}ext_spi_sck_o \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $func_pad_names(sf1_clk)]
} elseif {$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_EXT_QSPI_SCK -add \
                          -master_clock $name_clk_ext_qspi_sck_div \
                          -source $hier_clk_ext_qspi_sck_div \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $func_pad_names(sf1_clk)]

}
lappend CLOCK_GROUP(ap_sys_clk_ap_ahb) ${AP_SYS_NAME}_EXT_QSPI_SCK 

######clk_i2s0_sck_generated##########
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_i2s0_sck_generated -add \
                      -master_clock $name_clk_i2s0 \
                      -source $hier_clk_i2s0 \
                      -divide_by 6 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_cmind_cell_i2s_sck/cmind_uj_ckcell/Z]
}
lappend CLOCK_GROUP(ap_sys_clk_i2s0) ${AP_LIB_HIER}${AP_SYS_NAME}_clk_i2s0_sck_generated 
set name_clk_i2s0_sck_generated ap_sys_clk_i2s0_sck_generated
set hier_clk_i2s0_sck_generated ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_cmind_cell_i2s_sck/cmind_uj_ckcell/Z

######clk_i2s0_sck_generated_div2##########
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_i2s0_sck_generated_div2 -add \
                      -master_clock $name_clk_i2s0_sck_generated \
                      -source $hier_clk_i2s0_sck_generated \
                      -divide_by 2 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_pdm_clk_gen/u_clk_i2s_div2/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_i2s0) ${AP_LIB_HIER}${AP_SYS_NAME}_clk_i2s0_sck_generated_div2 
set name_clk_i2s0_sck_generated_div2 ap_sys_clk_i2s0_sck_generated_div2
set hier_clk_i2s0_sck_generated_div2 ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_pdm_clk_gen/u_clk_i2s_div2/$CKOUTZ_HIER

######clk_pdm_clk##########

if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_pdm_clk_mux_div2 -add \
                      -master_clock $name_clk_i2s0_sck_generated_div2 \
                      -source $hier_clk_i2s0_sck_generated_div2 \
                      -divide_by 1 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_pdm_clk_gen/u_cmind_clk_mux2_pdm_clk/$CKOUTZ_HIER]

}
lappend CLOCK_GROUP(ap_sys_clk_i2s0) ${AP_LIB_HIER}${AP_SYS_NAME}_clk_pdm_clk_mux_div2
lappend CLOCK_GROUP_1(${AP_SYS_NAME}_clk_pdm_clk_mux_div2) ${AP_LIB_HIER}${AP_SYS_NAME}_clk_pdm_clk_mux_div2
set name_clk_pdm_clk_mux_div2 ap_sys_clk_pdm_clk_mux_div2
set hier_clk_pdm_clk_mux_div2 ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_pdm_clk_gen/u_cmind_clk_mux2_pdm_clk/$CKOUTZ_HIER

if {! $IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_clk_pdm_clk_mux_div2_pad -add \
                          -master_clock $name_clk_pdm_clk_mux_div2 \
                          -source $hier_clk_pdm_clk_mux_div2 \
                          -divide_by 1 \
                          -combinational \
                          [get_ports pdm_clk]
    lappend CLOCK_GROUP(ap_sys_clk_i2s0) ${AP_SYS_NAME}_clk_pdm_clk_mux_div2_pad
} elseif {$IS_CHIP && !$IS_FLAT} {
    lappend CLOCK_GROUP(ap_sys_clk_i2s0) ${AP_LIB_HIER}pdm_clk_1
    set pdm_clk_num 1 
    foreach i $func_pad_names(pdm_clk) {
        create_generated_clock -name ${AP_SYS_NAME}_clk_pdm_clk_mux_div2_pad_$i -add \
                          -master_clock ${AP_LIB_HIER}pdm_clk_1 \
                          -source ${AP_LIB_HIER}pdm_clk_1 \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $i]
        set CLOCK_GROUP_1(PDM_CLK_MUX_DIV2_PAD$pdm_clk_num)    [list ${AP_SYS_NAME}_clk_pdm_clk_mux_div2_pad_$i]
        lappend CLOCK_GROUP(ap_sys_clk_i2s0)  $CLOCK_GROUP_1(PDM_CLK_MUX_DIV2_PAD$pdm_clk_num)
        incr pdm_clk_num 
    }

} elseif {$IS_FLAT} {
    set pdm_clk_num 1 
    foreach i $func_pad_names(pdm_clk) {
        create_generated_clock -name ${AP_SYS_NAME}_clk_pdm_clk_mux_div2_pad_$i -add \
                          -master_clock $name_clk_pdm_clk_mux_div2 \
                          -source $hier_clk_pdm_clk_mux_div2 \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $i]
        set CLOCK_GROUP_1(PDM_CLK_MUX_DIV2_PAD$pdm_clk_num)    [list ${AP_SYS_NAME}_clk_pdm_clk_mux_div2_pad_$i]
        lappend CLOCK_GROUP(ap_sys_clk_i2s0)  $CLOCK_GROUP_1(PDM_CLK_MUX_DIV2_PAD$pdm_clk_num)
        incr pdm_clk_num 
    }
}
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_pdm_clk_mux_div1 -add \
                      -master_clock $name_clk_i2s0_sck_generated \
                      -source $hier_clk_i2s0_sck_generated \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_pdm_clk_gen/u_cmind_clk_mux2_pdm_clk/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_i2s0) ${AP_LIB_HIER}${AP_SYS_NAME}_clk_pdm_clk_mux_div1
lappend CLOCK_GROUP_1(${AP_SYS_NAME}_clk_pdm_clk_mux_div1) ${AP_LIB_HIER}${AP_SYS_NAME}_clk_pdm_clk_mux_div1
set name_clk_pdm_clk_mux_div1 ap_sys_clk_pdm_clk_mux_div1
set hier_clk_pdm_clk_mux_div1 ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_pdm_clk_gen/u_cmind_clk_mux2_pdm_clk/$CKOUTZ_HIER
if {! $IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_clk_pdm_clk_mux_div1_pad -add \
                          -master_clock $name_clk_pdm_clk_mux_div1 \
                          -source $hier_clk_pdm_clk_mux_div1 \
                          -divide_by 1 \
                          -combinational \
                          [get_ports pdm_clk]
    lappend CLOCK_GROUP(ap_sys_clk_i2s0) ${AP_SYS_NAME}_clk_pdm_clk_mux_div1_pad
} elseif {$IS_CHIP && !$IS_FLAT} {
    lappend CLOCK_GROUP(ap_sys_clk_i2s0) ${AP_LIB_HIER}pdm_clk_2
    set pdm_clk_num 1 
    foreach i $func_pad_names(pdm_clk) {
        create_generated_clock -name ${AP_SYS_NAME}_clk_pdm_clk_mux_div1_pad_$i -add \
                          -master_clock ${AP_LIB_HIER}pdm_clk_2 \
                          -source ${AP_LIB_HIER}pdm_clk_2 \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $i]
        set CLOCK_GROUP_1(PDM_CLK_MUX_DIV1_PAD$pdm_clk_num)    [list ${AP_SYS_NAME}_clk_pdm_clk_mux_div1_pad_$i]
        lappend CLOCK_GROUP(ap_sys_clk_i2s0) $CLOCK_GROUP_1(PDM_CLK_MUX_DIV1_PAD$pdm_clk_num)
        incr pdm_clk_num 
    }
} elseif {$IS_FLAT} {
    set pdm_clk_num 1 
    foreach i $func_pad_names(pdm_clk) {
        create_generated_clock -name ${AP_SYS_NAME}_clk_pdm_clk_mux_div1_pad_$i -add \
                          -master_clock $name_clk_pdm_clk_mux_div1 \
                          -source $hier_clk_pdm_clk_mux_div1 \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $i]
        set CLOCK_GROUP_1(PDM_CLK_MUX_DIV1_PAD$pdm_clk_num)    [list ${AP_SYS_NAME}_clk_pdm_clk_mux_div1_pad_$i]
        lappend CLOCK_GROUP(ap_sys_clk_i2s0) $CLOCK_GROUP_1(PDM_CLK_MUX_DIV1_PAD$pdm_clk_num)
        incr pdm_clk_num 
    }
}
######clk_i2s0_sck_generated_pad##########
if {! $IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_clk_i2s0_sck_generated_pad -add \
                          -master_clock $name_clk_i2s0_sck_generated \
                          -source $hier_clk_i2s0_sck_generated \
                          -divide_by 1 \
                          -combinational \
                          [get_ports i2s0_scko]
} elseif {$IS_CHIP && !$IS_FLAT} {
    lappend CLOCK_GROUP(ap_sys_clk_i2s0) ${AP_LIB_HIER}i2s0_scko 
    create_generated_clock -name ${AP_SYS_NAME}_clk_i2s0_sck_generated_pad -add \
                          -master_clock ${AP_LIB_HIER}i2s0_scko \
                          -source ${AP_LIB_HIER}i2s0_scko \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $func_pad_names(iisclk)]
} elseif {$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_clk_i2s0_sck_generated_pad -add \
                          -master_clock $name_clk_i2s0_sck_generated \
                          -source $hier_clk_i2s0_sck_generated \
                          -divide_by 1 \
                          -combinational \
                          [get_ports $func_pad_names(iisclk)]
}
lappend CLOCK_GROUP(ap_sys_clk_i2s0) ${AP_SYS_NAME}_clk_i2s0_sck_generated_pad 
### clock clk_sdio0_sleep_in:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_sleep_in -add \
                      -master_clock $name_clk_sdio0 \
                      -source $hier_clk_sdio0 \
                      -divide_by 1500 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_cmind_cell_clk_sleep_out/cmind_uj_ckcell/Z]
}
lappend CLOCK_GROUP(ap_sys_clk_sdio0) ${AP_LIB_HIER}ap_sys_clk_sdio0_sleep_in                                            
set name_clk_sdio0_sleep_in ap_sys_clk_sdio0_sleep_in
set hier_clk_sdio0_sleep_in ${AP_SYS_CLK_CORE_HIER}u_cmind_clk_mux4_clk_sdio0/$CKOUTZ_HIER
#############################################################################
###OCC scanmux I1 pin Clock Generate
#############################################################################
###generate clk clk_sdio0_sleep_out for scan mux:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ap_sys_clk_sdio0_sleep_out_scan -add \
                      -master_clock $name_ptest_slow_occ_clock \
                      -source $hier_ptest_slow_occ_clock \
                      -divide_by 1 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_clk_sleep_out_scanmux/cmind_uj_ckcell/I1]
}
lappend CLOCK_GROUP(ap_sys_clk_sdio0_sleep_out_scan) ${AP_LIB_HIER}ap_sys_clk_sdio0_sleep_out_scan   
set name_clk_sdio0_sleep_out_scan ap_sys_clk_sdio0_sleep_out_scan
set hier_clk_sdio0_sleep_out_scan ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_clk_sleep_out_scanmux/cmind_uj_ckcell/I1

### clock clk_sdio0_div2:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_div2 -add \
                      -master_clock $name_clk_sdio0 \
                      -source $hier_clk_sdio0 \
                      -divide_by 2 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_cmind_cell_test_sig_sdclk/cmind_uj_ckcell/Z]
}
lappend CLOCK_GROUP(ap_sys_clk_sdio0) ${AP_LIB_HIER}ap_sys_clk_sdio0_div2                                            
set name_clk_sdio0_div2 ap_sys_clk_sdio0_div2
set hier_clk_sdio0_div2 ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_cmind_cell_test_sig_sdclk/cmind_uj_ckcell/Z

### clock clk_sdio0_mux_div2:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_mux_div2 -add \
                      -master_clock $name_clk_sdio0_div2 \
                      -source $hier_clk_sdio0_div2 \
                      -divide_by 1 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_cksw2_clk_sd_out/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_sdio0) ${AP_LIB_HIER}ap_sys_clk_sdio0_mux_div2                                            
set name_clk_sdio0_mux_div2 ap_sys_clk_sdio0_mux_div2
set hier_clk_sdio0_mux_div2 ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_cksw2_clk_sd_out/$CKOUTZ_HIER

### clock clk_sdio0_div4:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_div4 -add \
                      -master_clock $name_clk_sdio0 \
                      -source $hier_clk_sdio0 \
                      -divide_by 4 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_cmind_cell_test_sig_sdclk/cmind_uj_ckcell/Z]
}
lappend CLOCK_GROUP(ap_sys_clk_sdio0) ${AP_LIB_HIER}ap_sys_clk_sdio0_div4                                            
set name_clk_sdio0_div4 ap_sys_clk_sdio0_div4
set hier_clk_sdio0_div4 ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_cmind_cell_test_sig_sdclk/cmind_uj_ckcell/Z

### clock clk_sdio0_mux_div4:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_mux_div4 -add \
                      -master_clock $name_clk_sdio0_div4 \
                      -source $hier_clk_sdio0_div4 \
                      -divide_by 1 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_cksw2_clk_sd_out/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_sdio0) ${AP_LIB_HIER}ap_sys_clk_sdio0_mux_div4                                            
set name_clk_sdio0_mux_div4 ap_sys_clk_sdio0_mux_div4
set hier_clk_sdio0_mux_div4 ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_cksw2_clk_sd_out/$CKOUTZ_HIER
### clock clk_sdio0_mux_div1:
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_mux_div1 -add \
                      -master_clock $name_clk_sdio0 \
                      -source $hier_clk_sdio0 \
                      -divide_by 1 \
                      -combinational \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_cksw2_clk_sd_out/$CKOUTZ_HIER]
}
lappend CLOCK_GROUP(ap_sys_clk_sdio0) ${AP_LIB_HIER}ap_sys_clk_sdio0_mux_div1                                            
set name_clk_sdio0_mux_div1 ap_sys_clk_sdio0_mux_div1
set hier_clk_sdio0_mux_div1 ${AP_SYS_HIER}u_ap_sys_top/u_sd3_top/u_sd3_ctrl/u_clk_gen1/u_cksw2_clk_sd_out/$CKOUTZ_HIER

### clock clk_sdio0_mux_div2_pad:
if {! $IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_mux_div2_pad -add \
                      -master_clock $name_clk_sdio0_mux_div2 \
                      -source $hier_clk_sdio0_mux_div2 \
                      -divide_by 1 \
                      -combinational \
                      [get_ports clk_sdcard]
} elseif {$IS_CHIP && !$IS_FLAT} {
    lappend CLOCK_GROUP(ap_sys_clk_sdio0) ${AP_LIB_HIER}clk_sdcard_1                                            
    lappend CLOCK_GROUP_1(ap_sys_clk_sdio0_div2) ${AP_LIB_HIER}clk_sdcard_1                                            
    create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_mux_div2_pad -add \
                      -master_clock ${AP_LIB_HIER}clk_sdcard_1 \
                      -source ${AP_LIB_HIER}clk_sdcard_1 \
                      -divide_by 1 \
                      -combinational \
                      [get_ports $func_pad_names(sd_clk)]
} elseif {$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_mux_div2_pad -add \
                      -master_clock $name_clk_sdio0_mux_div2 \
                      -source $hier_clk_sdio0_mux_div2 \
                      -divide_by 1 \
                      -combinational \
                      [get_ports $func_pad_names(sd_clk)]

}
set name_clk_sdio0_mux_div2_pad ap_sys_clk_sdio0_mux_div2_pad
#set hier_clk_sdio0_mux_div2_pad [get_ports clk_sdcard] 
lappend CLOCK_GROUP(ap_sys_clk_sdio0) ap_sys_clk_sdio0_mux_div2_pad                                            
lappend CLOCK_GROUP_1(ap_sys_clk_sdio0_div2) ap_sys_clk_sdio0_mux_div2_pad ${AP_LIB_HIER}$name_clk_sdio0_mux_div2                                            

### clock clk_sdio0_mux_div1_pad:
if {! $IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_mux_div1_pad -add \
                      -master_clock $name_clk_sdio0_mux_div1 \
                      -source $hier_clk_sdio0_mux_div1 \
                      -divide_by 1 \
                      -combinational \
                      [get_ports clk_sdcard]
} elseif {$IS_CHIP && !$IS_FLAT} {
    lappend CLOCK_GROUP(ap_sys_clk_sdio0) ${AP_LIB_HIER}clk_sdcard_2 
    lappend CLOCK_GROUP_1(ap_sys_clk_sdio0_div1) ${AP_LIB_HIER}clk_sdcard_2                                             
    create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_mux_div1_pad -add \
                      -master_clock ${AP_LIB_HIER}clk_sdcard_2 \
                      -source ${AP_LIB_HIER}clk_sdcard_2 \
                      -divide_by 1 \
                      -combinational \
                      [get_ports $func_pad_names(sd_clk)]
} elseif {$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_mux_div1_pad -add \
                      -master_clock $name_clk_sdio0_mux_div1 \
                      -source $hier_clk_sdio0_mux_div1 \
                      -divide_by 1 \
                      -combinational \
                      [get_ports $func_pad_names(sd_clk)]
}
set name_clk_sdio0_mux_div1_pad ap_sys_clk_sdio0_mux_div1_pad
#set hier_clk_sdio0_mux_div1_pad [get_ports clk_sdcard] 
lappend CLOCK_GROUP(ap_sys_clk_sdio0) ap_sys_clk_sdio0_mux_div1_pad                                            
lappend CLOCK_GROUP_1(ap_sys_clk_sdio0_div1) ap_sys_clk_sdio0_mux_div1_pad ${AP_LIB_HIER}$name_clk_sdio0_mux_div1                                            

### clock clk_sdio0_mux_div4_pad:
if {! $IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_mux_div4_pad -add \
                      -master_clock $name_clk_sdio0_mux_div4 \
                      -source $hier_clk_sdio0_mux_div4 \
                      -divide_by 1 \
                      -combinational \
                      [get_ports clk_sdcard]
} elseif {$IS_CHIP && !$IS_FLAT} {
    lappend CLOCK_GROUP(ap_sys_clk_sdio0) ${AP_LIB_HIER}clk_sdcard_3                                            
    lappend CLOCK_GROUP_1(ap_sys_clk_sdio0_div4) ${AP_LIB_HIER}clk_sdcard_3                                            
    create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_mux_div4_pad -add \
                      -master_clock ${AP_LIB_HIER}clk_sdcard_3 \
                      -source ${AP_LIB_HIER}clk_sdcard_3 \
                      -divide_by 1 \
                      -combinational \
                      [get_ports $func_pad_names(sd_clk)]
} elseif {$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_clk_sdio0_mux_div4_pad -add \
                      -master_clock $name_clk_sdio0_mux_div4 \
                      -source $hier_clk_sdio0_mux_div4 \
                      -divide_by 1 \
                      -combinational \
                      [get_ports $func_pad_names(sd_clk)]

}
set name_clk_sdio0_mux_div4_pad ap_sys_clk_sdio0_mux_div4_pad
#set hier_clk_sdio0_mux_div2_pad [get_ports clk_sdcard] 
lappend CLOCK_GROUP(ap_sys_clk_sdio0) ap_sys_clk_sdio0_mux_div4_pad                                            
lappend CLOCK_GROUP_1(ap_sys_clk_sdio0_div4) ap_sys_clk_sdio0_mux_div4_pad ${AP_LIB_HIER}$name_clk_sdio0_mux_div4                                            

if {! $IS_CHIP} {
    create_clock -name ap_sys_clk_19_2m_cpll_ap_sys -period $CYCLE_19M2 -add [get_ports clk_19_2m_cpll_ap_sys]
    lappend CLOCK_GROUP(ap_sys_clk_19_2m_cpll_ap_sys)    ap_sys_clk_19_2m_cpll_ap_sys
    set name_clk_19_2m_cpll_ap_sys ap_sys_clk_19_2m_cpll_ap_sys
    set hier_clk_19_2m_cpll_ap_sys [get_ports clk_19_2m_cpll_ap_sys]
}
