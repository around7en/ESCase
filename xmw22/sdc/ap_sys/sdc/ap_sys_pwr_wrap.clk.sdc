if {! $IS_CHIP} {

    create_clock -name ${AP_SYS_NAME}_clk_cpll_307_2m_ap -period $CYCLE_307M2 -add [get_ports  clk_cpll_307_2m_ap]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_cpll_307_2m_ap)    [list ${AP_SYS_NAME}_clk_cpll_307_2m_ap]

    create_clock -name ${AP_SYS_NAME}_clk_cpll_245_76m_ap -period $CYCLE_245M76 -add [get_ports clk_cpll_245_76m_ap]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_cpll_245_76m_ap)    [list ${AP_SYS_NAME}_clk_cpll_245_76m_ap]

    create_clock -name ${AP_SYS_NAME}_clk_cpll_204_8m_ap -period $CYCLE_204M8 -add [get_ports clk_cpll_204_8m_ap]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_cpll_204_8m_ap)    [list ${AP_SYS_NAME}_clk_cpll_204_8m_ap]

    create_clock -name ${AP_SYS_NAME}_clk_cpll_153_6m_ap -period $CYCLE_153M6 -add [get_ports clk_cpll_153_6m_ap]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_cpll_153_6m_ap)    [list ${AP_SYS_NAME}_clk_cpll_153_6m_ap]

    create_clock -name ${AP_SYS_NAME}_clk_cpll_102_4m_ap -period $CYCLE_102M4 -add [get_ports clk_cpll_102_4m_ap]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_cpll_102_4m_ap)    [list ${AP_SYS_NAME}_clk_cpll_102_4m_ap]

    create_clock -name ${AP_SYS_NAME}_clk_cpll_76_8m_ap -period $CYCLE_76M8 -add [get_ports clk_cpll_76_8m_ap]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_cpll_76_8m_ap)    [list ${AP_SYS_NAME}_clk_cpll_76_8m_ap]

    create_clock -name ${AP_SYS_NAME}_clk_cpll_61_44m_ap  -period $CYCLE_61M44  -add [get_ports clk_cpll_61_44m_ap]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_cpll_61_44m_ap)     [list ${AP_SYS_NAME}_clk_cpll_61_44m_ap]

    create_clock -name ${AP_SYS_NAME}_clk_cpll_51_2m_ap  -period $CYCLE_51M2  -add [get_ports clk_cpll_51_2m_ap]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_cpll_51_2m_ap)     [list ${AP_SYS_NAME}_clk_cpll_51_2m_ap]

    create_clock -name ${AP_SYS_NAME}_clk_cpll_30_72m_ap  -period $CYCLE_30M72  -add [get_ports clk_cpll_30_72m_ap]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_cpll_30_72m_ap)     [list ${AP_SYS_NAME}_clk_cpll_30_72m_ap]

    create_clock -name ${AP_SYS_NAME}_clk_cpll_19_2m_ap  -period $CYCLE_19M2  -add [get_ports clk_cpll_19_2m_ap]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_cpll_19_2m_ap)     [list ${AP_SYS_NAME}_clk_cpll_19_2m_ap]

    create_clock -name ${AP_SYS_NAME}_clk_xo_26m_ap       -period $CYCLE_26M  -add [get_ports clk_xo_26m_ap]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_xo_26m_ap)          [list ${AP_SYS_NAME}_clk_xo_26m_ap]

    create_clock -name ${AP_SYS_NAME}_clk_top_ahb      -period $CYCLE_102M4 -add [get_ports clk_top_ahb_in]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_top_ahb)         [list ${AP_SYS_NAME}_clk_top_ahb]

    create_clock -name ${AP_SYS_NAME}_clk_pub_ahb      -period $CYCLE_204M8 -add [get_ports clk_pub_ahb_in]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_pub_ahb)         [list ${AP_SYS_NAME}_clk_pub_ahb]

    create_clock -name ${AP_SYS_NAME}_clk_sysram_ahb   -period $CYCLE_245M76 -add [get_ports clk_sysram_ahb_in]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_sysram_ahb)      [list ${AP_SYS_NAME}_clk_sysram_ahb]

}
    create_clock -name ${AP_SYS_NAME}_V_CLK_26M            -period $CYCLE_26M
    set CLOCK_GROUP(${AP_SYS_NAME}_V_CLK_26M)           [list ${AP_SYS_NAME}_V_CLK_26M]    

if {! $IS_CHIP} {
    set name_clk_307_2m_ap [get_clocks ${AP_SYS_NAME}_clk_cpll_307_2m_ap]
    set hier_clk_307_2m_ap [get_ports clk_cpll_307_2m_ap]

    set name_clk_204_8m_ap [get_clocks ${AP_SYS_NAME}_clk_cpll_204_8m_ap]
    set hier_clk_204_8m_ap [get_ports clk_cpll_204_8m_ap]

    set name_clk_102_4m_ap [get_clocks ${AP_SYS_NAME}_clk_cpll_102_4m_ap]
    set hier_clk_102_4m_ap [get_ports clk_cpll_102_4m_ap]

    set name_clk_76_8m_ap [get_clocks ${AP_SYS_NAME}_clk_cpll_76_8m_ap]
    set hier_clk_76_8m_ap [get_ports clk_cpll_76_8m_ap]

    set name_clk_61_44m_ap [get_clocks ${AP_SYS_NAME}_clk_cpll_61_44m_ap]
    set hier_clk_61_44m_ap [get_ports clk_cpll_61_44m_ap]
}

set AP_CLK_CORE_HIER ${AP_SYS_HIER}u_ap_sys_top/u_ap_clk_top/u_ap_clk_core_wrap/u_ap_clk_core/

create_generated_clock -name ${AP_SYS_NAME}_clk_uart1 -add \
                      -master_clock $name_clk_76_8m_ap \
                      -source $hier_clk_76_8m_ap \
                      -divide_by 1 \
                      [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw3_uart1/$CKOUTZ_HIER]

create_generated_clock -name ${AP_SYS_NAME}_clk_uart4 -add \
                      -master_clock $name_clk_76_8m_ap \
                      -source $hier_clk_76_8m_ap \
                      -divide_by 1 \
                      [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw3_uart4/$CKOUTZ_HIER]

create_generated_clock -name ${AP_SYS_NAME}_clk_uart5 -add \
                      -master_clock $name_clk_76_8m_ap \
                      -source $hier_clk_76_8m_ap \
                      -divide_by 1 \
                      [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_mux3_uart5/$CKOUTZ_HIER]

create_generated_clock -name ${AP_SYS_NAME}_clk_spi0_apb -add \
                      -master_clock $name_clk_102_4m_ap \
                      -source $hier_clk_102_4m_ap \
                      -divide_by 1 \
                      [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi0_apb/$CKOUTZ_HIER]

create_generated_clock -name ${AP_SYS_NAME}_clk_spi1_apb -add \
                      -master_clock $name_clk_102_4m_ap \
                      -source $hier_clk_102_4m_ap \
                      -divide_by 1 \
                      [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi1_apb/$CKOUTZ_HIER]
create_generated_clock -name ${AP_SYS_NAME}_clk_spi2_apb -add \
                      -master_clock $name_clk_102_4m_ap \
                      -source $hier_clk_102_4m_ap \
                      -divide_by 1 \
                      [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi2_apb/$CKOUTZ_HIER]

create_generated_clock -name ${AP_SYS_NAME}_clk_ap_ahb -add \
                      -master_clock $name_clk_204_8m_ap \
                      -source $hier_clk_204_8m_ap \
                      -divide_by 1 \
                      [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw5_ap_ahb/$CKOUTZ_HIER]

create_generated_clock -name ${AP_SYS_NAME}_clk_spi_flash -add \
                      -master_clock $name_clk_307_2m_ap \
                      -source $hier_clk_307_2m_ap \
                      -divide_by 1 \
                      [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi_flash/$CKOUTZ_HIER]

create_generated_clock -name ${AP_SYS_NAME}_clk_i2c1_apb -add \
                      -master_clock $name_clk_61_44m_ap \
                      -source $hier_clk_61_44m_ap \
                      -divide_by 1 \
                      [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw2_i2c1/$CKOUTZ_HIER]

create_generated_clock -name ${AP_SYS_NAME}_clk_i2c2_apb -add \
                      -master_clock $name_clk_61_44m_ap \
                      -source $hier_clk_61_44m_ap \
                      -divide_by 1 \
                      [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_mux2_i2c2/$CKOUTZ_HIER]

create_generated_clock -name ${AP_SYS_NAME}_clk_i2s0 -add \
                      -master_clock $name_clk_61_44m_ap \
                      -source $hier_clk_61_44m_ap \
                      -divide_by 1 \
                      [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_i2s0/$CKOUTZ_HIER]

create_generated_clock -name ${AP_SYS_NAME}_clk_ap_apb -add \
                      -master_clock ${AP_SYS_NAME}_clk_ap_ahb \
                      -source [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw5_ap_ahb/$CKOUTZ_HIER] \
                      -divide_by 2 \
                      [get_pins ${AP_CLK_CORE_HIER}u_clk_ap_ahb_div2/$CKOUTZ_HIER]

##################spi0_sck_in and spi0_sclk_generated#####################
if {! $IS_CHIP} {
    create_clock -name ${AP_SYS_NAME}_spi0_sclk_in   -period $CYCLE_51M2 -add [get_ports spi0_sclk_in]
    set CLOCK_GROUP(${AP_SYS_NAME}_spi0_sclk_in)      [list ${AP_SYS_NAME}_spi0_sclk_in]

    create_generated_clock -name ${AP_SYS_NAME}_spi0_sclk_generated -add \
                      -master_clock ${AP_SYS_NAME}_clk_spi0_apb \
                      -source [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi0_apb/$CKOUTZ_HIER] \
                      -divide_by 2 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi0_clk_out_ckbuf/cmind_uj_ckcell/Z]
} elseif {$IS_CHIP && !$IS_FLAT} {
    create_clock -name ${AP_SYS_NAME}_spi0_sclk_in   -period $CYCLE_51M2 -add [get_ports $func_pad_names(cam_spi_clk)]
    set CLOCK_GROUP(${AP_SYS_NAME}_spi0_sclk_in)      [list ${AP_SYS_NAME}_spi0_sclk_in]

    create_generated_clock -name ${AP_SYS_NAME}_spi0_sclk_generated -add \
                      -master_clock ${AP_SYS_HIER}${AP_SYS_NAME}_spi0_sclk_generated \
                      -source [get_pins ${AP_SYS_HIER}${AP_SYS_NAME}_spi0_sclk_generated] \
                      -divide_by 2 \
                      [get_ports $func_pad_names(cam_spi_clk)]
} elseif {$IS_FLAT} {
    create_clock -name ${AP_SYS_NAME}_spi0_sclk_in   -period $CYCLE_51M2 -add [get_ports $func_pad_names(cam_spi_clk)]
    set CLOCK_GROUP(${AP_SYS_NAME}_spi0_sclk_in)      [list ${AP_SYS_NAME}_spi0_sclk_in]

    create_generated_clock -name ${AP_SYS_NAME}_spi0_sclk_generated -add \
                      -master_clock ${AP_SYS_NAME}_clk_spi0_apb \
                      -source [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi0_apb/$CKOUTZ_HIER] \
                      -divide_by 2 \
                      [get_ports $func_pad_names(cam_spi_clk)]
}
set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi0_apb)       [list ${AP_SYS_NAME}_clk_spi0_apb ${AP_SYS_NAME}_spi0_sclk_generated]
##################spi1_sck_in and spi1_sclk_generated#####################
if {! $IS_CHIP} {
    create_clock -name ${AP_SYS_NAME}_spi1_sclk_in   -period $CYCLE_51M2 -add [get_ports spi1_sclk_in]
    set CLOCK_GROUP(${AP_SYS_NAME}_spi1_sclk_in)      [list ${AP_SYS_NAME}_spi1_sclk_in]

    create_generated_clock -name ${AP_SYS_NAME}_spi1_sclk_generated -add \
                      -master_clock ${AP_SYS_NAME}_clk_spi1_apb \
                      -source [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi1_apb/$CKOUTZ_HIER] \
                      -divide_by 2 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi1_clk_out_ckbuf/cmind_uj_ckcell/Z]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb)       [list ${AP_SYS_NAME}_clk_spi1_apb ${AP_SYS_NAME}_spi1_sclk_generated]
} elseif {$IS_CHIP && !$IS_FLAT} {
    set spi1_sclk_gen_num 1 
    foreach i $func_pad_names(lcd_spi_clk) {
        create_clock -name ${AP_SYS_NAME}_spi1_sclk_in_$i   -period $CYCLE_51M2 -add [get_ports $i]
        set CLOCK_GROUP(${AP_SYS_NAME}_spi1_sclk_in_$i)      [list ${AP_SYS_NAME}_spi1_sclk_in_$i]
    
        create_generated_clock -name ${AP_SYS_NAME}_spi1_sclk_generated_$i -add \
                          -master_clock ${AP_SYS_HIER}${AP_SYS_NAME}_spi1_sclk_generated \
                          -source [get_pins ${AP_SYS_HIER}${AP_SYS_NAME}_spi1_sclk_generated] \
                          -divide_by 2 \
                          [get_ports $i]
        #set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb_$i)    [list ${AP_SYS_NAME}_clk_spi1_apb ${AP_SYS_NAME}_spi1_sclk_generated_$i]
        set CLOCK_GROUP_SPI1_SCK_GEN($spi1_sclk_gen_num)    [list ${AP_SYS_NAME}_spi1_sclk_generated_$i]
        set CLOCK_GROUP_SPI1_SCK_IN($spi1_sclk_gen_num)    [list ${AP_SYS_NAME}_spi1_sclk_in_$i]
        incr spi1_sclk_gen_num 
    }
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb)    [list ${AP_SYS_NAME}_clk_spi1_apb $CLOCK_GROUP_SPI1_SCK_GEN(1) $CLOCK_GROUP_SPI1_SCK_GEN(2) $CLOCK_GROUP_SPI1_SCK_GEN(3)]
} elseif {$IS_CHIP && !$IS_FLAT} {
    set spi1_sclk_gen_num 1 
    foreach i $func_pad_names(lcd_spi_clk) {
        create_clock -name ${AP_SYS_NAME}_spi1_sclk_in_$i   -period $CYCLE_51M2 -add [get_ports $i]
        set CLOCK_GROUP(${AP_SYS_NAME}_spi1_sclk_in_$i)      [list ${AP_SYS_NAME}_spi1_sclk_in_$i]
    
        create_generated_clock -name ${AP_SYS_NAME}_spi1_sclk_generated_$i -add \
                          -master_clock ${AP_SYS_NAME}_clk_spi1_apb \
                          -source [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi1_apb/$CKOUTZ_HIER] \
                          -divide_by 2 \
                          [get_ports $i]
        #set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb_$i)    [list ${AP_SYS_NAME}_clk_spi1_apb ${AP_SYS_NAME}_spi1_sclk_generated_$i]
        set CLOCK_GROUP_SPI1_SCK_GEN($spi1_sclk_gen_num)    [list ${AP_SYS_NAME}_spi1_sclk_generated_$i]
        set CLOCK_GROUP_SPI1_SCK_IN($spi1_sclk_gen_num)    [list ${AP_SYS_NAME}_spi1_sclk_in_$i]
        incr spi1_sclk_gen_num 
    }
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi1_apb)    [list ${AP_SYS_NAME}_clk_spi1_apb $CLOCK_GROUP_SPI1_SCK_GEN(1) $CLOCK_GROUP_SPI1_SCK_GEN(2) $CLOCK_GROUP_SPI1_SCK_GEN(3)]
}
##################spi2_sck_in and spi2_sclk_generated#####################
if {! $IS_CHIP} {
    create_clock -name ${AP_SYS_NAME}_spi2_sclk_in   -period $CYCLE_51M2 -add [get_ports spi2_sclk_in]
    set CLOCK_GROUP(${AP_SYS_NAME}_spi2_sclk_in)      [list ${AP_SYS_NAME}_spi2_sclk_in]

    create_generated_clock -name ${AP_SYS_NAME}_spi2_sclk_generated -add \
                      -master_clock ${AP_SYS_NAME}_clk_spi2_apb \
                      -source [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi2_apb/$CKOUTZ_HIER] \
                      -divide_by 2 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_spi2_clk_out_ckbuf/cmind_uj_ckcell/Z]
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb)       [list ${AP_SYS_NAME}_clk_spi2_apb ${AP_SYS_NAME}_spi2_sclk_generated]
} elseif {$IS_CHIP && !$IS_FLAT} {
    set spi2_sclk_gen_num 1 
    foreach i $func_pad_names(spi2_clk) {
        create_clock -name ${AP_SYS_NAME}_spi2_sclk_in_$i   -period $CYCLE_51M2 -add [get_ports $i]
        set CLOCK_GROUP(${AP_SYS_NAME}_spi2_sclk_in_$i)      [list ${AP_SYS_NAME}_spi2_sclk_in_$i]
    
        create_generated_clock -name ${AP_SYS_NAME}_spi2_sclk_generated_$i -add \
                          -master_clock ${AP_SYS_HIER}${AP_SYS_NAME}_spi2_sclk_generated \
                          -source [get_pins ${AP_SYS_HIER}${AP_SYS_NAME}_spi2_sclk_generated] \
                          -divide_by 2 \
                          [get_ports $i]
        #set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb_$i)    [list ${AP_SYS_NAME}_clk_spi2_apb ${AP_SYS_NAME}_spi2_sclk_generated_$i]
        set CLOCK_GROUP_SPI2_SCK_GEN($spi2_sclk_gen_num)    [list ${AP_SYS_NAME}_spi2_sclk_generated_$i]
        set CLOCK_GROUP_SPI2_SCK_IN($spi2_sclk_gen_num)    [list ${AP_SYS_NAME}_spi2_sclk_in_$i]
        incr spi2_sclk_gen_num 
    }
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb)    [list ${AP_SYS_NAME}_clk_spi2_apb $CLOCK_GROUP_SPI2_SCK_GEN(1) $CLOCK_GROUP_SPI2_SCK_GEN(2) $CLOCK_GROUP_SPI2_SCK_GEN(3)]
} elseif {$IS_CHIP && !$IS_FLAT} {
    set spi2_sclk_gen_num 1 
    foreach i $func_pad_names(spi2_clk) {
        create_clock -name ${AP_SYS_NAME}_spi2_sclk_in_$i   -period $CYCLE_51M2 -add [get_ports $i]
        set CLOCK_GROUP(${AP_SYS_NAME}_spi2_sclk_in_$i)      [list ${AP_SYS_NAME}_spi2_sclk_in_$i]
    
        create_generated_clock -name ${AP_SYS_NAME}_spi2_sclk_generated_$i -add \
                          -master_clock ${AP_SYS_NAME}_clk_spi2_apb \
                          -source [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi2_apb/$CKOUTZ_HIER] \
                          -divide_by 2 \
                          [get_ports $i]
        #set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb_$i)    [list ${AP_SYS_NAME}_clk_spi2_apb ${AP_SYS_NAME}_spi2_sclk_generated_$i]
        set CLOCK_GROUP_SPI2_SCK_GEN($spi2_sclk_gen_num)    [list ${AP_SYS_NAME}_spi2_sclk_generated_$i]
        set CLOCK_GROUP_SPI2_SCK_IN($spi2_sclk_gen_num)    [list ${AP_SYS_NAME}_spi2_sclk_in_$i]
        incr spi2_sclk_gen_num 
    }
    set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi2_apb)    [list ${AP_SYS_NAME}_clk_spi2_apb $CLOCK_GROUP_SPI2_SCK_GEN(1) $CLOCK_GROUP_SPI2_SCK_GEN(2) $CLOCK_GROUP_SPI2_SCK_GEN(3)]
}
####### sim0 clock #########
if {! $IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_sim0_clk -add \
                      -master_clock ${AP_SYS_NAME}_clk_ap_apb \
                      -source [get_pins ${AP_CLK_CORE_HIER}u_clk_ap_ahb_div2/$CKOUTZ_HIER] \
                      -divide_by 8 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_sim0_clk_ckbuf/cmind_uj_ckcell/Z]
} elseif {$IS_CHIP && !$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_sim0_clk -add \
                      -master_clock ${AP_SYS_HIER}${AP_SYS_NAME}_sim0_clk \
                      -source [get_pins ${AP_SYS_HIER}${AP_SYS_NAME}_sim0_clk] \
                      -divide_by 8 \
                      [get_ports $func_pad_names(sim0_clk)]
} elseif {$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_sim0_clk -add \
                      -master_clock ${AP_SYS_NAME}_clk_ap_apb \
                      -source [get_pins ${AP_CLK_CORE_HIER}u_clk_ap_ahb_div2/$CKOUTZ_HIER] \
                      -divide_by 8 \
                      [get_ports $func_pad_names(sim0_clk)]
}

####### sim1 clock #########
if {! $IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_sim1_clk -add \
                      -master_clock ${AP_SYS_NAME}_clk_ap_apb \
                      -source [get_pins ${AP_CLK_CORE_HIER}u_clk_ap_ahb_div2/$CKOUTZ_HIER] \
                      -divide_by 8 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_ap_sys_peri_top/u_sim1_clk_ckbuf/cmind_uj_ckcell/Z]
} elseif {$IS_CHIP && !$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_sim1_clk -add \
                      -master_clock ${AP_SYS_HIER}${AP_SYS_NAME}_sim1_clk \
                      -source [get_pins ${AP_SYS_HIER}${AP_SYS_NAME}_sim1_clk] \
                      -divide_by 8 \
                      [get_ports $func_pad_names(sim1_clk)]
} elseif {$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_sim1_clk -add \
                      -master_clock ${AP_SYS_NAME}_clk_ap_apb \
                      -source [get_pins ${AP_CLK_CORE_HIER}u_clk_ap_ahb_div2/$CKOUTZ_HIER] \
                      -divide_by 8 \
                      [get_ports $func_pad_names(sim1_clk)]
}

####### qspi clock #########
create_generated_clock -name ${AP_SYS_NAME}_QSPI_SCK -add \
                      -master_clock ${AP_SYS_NAME}_clk_spi_flash \
                      -source [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi_flash/$CKOUTZ_HIER] \
                      -divide_by 2 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/qspi_sck_o_reg/Q]

create_generated_clock -name ${AP_SYS_NAME}_QSPI_SCK_D3 -add \
                      -master_clock ${AP_SYS_NAME}_clk_spi_flash \
                      -source [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi_flash/$CKOUTZ_HIER] \
                      -divide_by 2 \
                      [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/qspi_sck_o_reg/Q]

set CLOCK_GROUP(${AP_SYS_NAME}_clk_uart1)          [list ${AP_SYS_NAME}_clk_uart1]
set CLOCK_GROUP(${AP_SYS_NAME}_clk_uart4)          [list ${AP_SYS_NAME}_clk_uart4]
set CLOCK_GROUP(${AP_SYS_NAME}_clk_uart5)          [list ${AP_SYS_NAME}_clk_uart5]
set CLOCK_GROUP(${AP_SYS_NAME}_clk_i2c1_apb)       [list ${AP_SYS_NAME}_clk_i2c1_apb]
set CLOCK_GROUP(${AP_SYS_NAME}_clk_i2c2_apb)       [list ${AP_SYS_NAME}_clk_i2c2_apb]
set CLOCK_GROUP(${AP_SYS_NAME}_clk_i2s0)           [list ${AP_SYS_NAME}_clk_i2s0]
set CLOCK_GROUP(${AP_SYS_NAME}_clk_spi_flash)      [list ${AP_SYS_NAME}_clk_spi_flash ${AP_SYS_NAME}_QSPI_SCK ${AP_SYS_NAME}_QSPI_SCK_D3]
set CLOCK_GROUP(${AP_SYS_NAME}_clk_ap_ahb)         [list ${AP_SYS_NAME}_clk_ap_ahb ${AP_SYS_NAME}_clk_ap_apb]
set CLOCK_GROUP(${AP_SYS_NAME}_sim1_clk)           [list ${AP_SYS_NAME}_sim1_clk]
set CLOCK_GROUP(${AP_SYS_NAME}_sim0_clk)           [list ${AP_SYS_NAME}_sim0_clk]

# when !$IS_CHIP generate clk for spy sdc check
if {!$IS_CHIP} {
    create_generated_clock -name ${AP_SYS_NAME}_clk_spi_flash_pad -add \
                      -master_clock ${AP_SYS_NAME}_clk_spi_flash \
                      -source [get_pins ${AP_CLK_CORE_HIER}u_cmind_clk_sw4_spi_flash/$CKOUTZ_HIER] \
                      -divide_by 1 \
                      [get_ports clk_spi_flash]
    lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi_flash)        [ list ${AP_SYS_NAME}_clk_spi_flash_pad]
} elseif {$IS_CHIP && !$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_QSPI_SCK_PAD -add \
                      -master_clock ${AP_SYS_HIER}${AP_SYS_NAME}_QSPI_SCK \
                      -source [get_pins ${AP_SYS_HIER}${AP_SYS_NAME}_QSPI_SCK] \
                      -divide_by 1 \
                      [get_ports $func_pad_names(qspi_sck_d3)]
    lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi_flash)        [ list ${AP_SYS_NAME}_QSPI_SCK_PAD]
    create_generated_clock -name ${AP_SYS_NAME}_QSPI_SCK_PAD_D3 -add \
                      -master_clock ${AP_SYS_HIER}${AP_SYS_NAME}_QSPI_SCK_D3 \
                      -source [get_pins ${AP_SYS_HIER}${AP_SYS_NAME}_QSPI_SCK_D3] \
                      -divide_by 1 \
                      [get_ports $func_pad_names(qspi_d3_sck)]
    #lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi_flash_d3)        [ list ${AP_SYS_NAME}_QSPI_SCK_PAD_D3]
    lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi_flash)        [ list ${AP_SYS_NAME}_QSPI_SCK_PAD_D3]

} elseif {$IS_FLAT} {
    create_generated_clock -name ${AP_SYS_NAME}_QSPI_SCK_PAD -add \
                      -master_clock ${AP_SYS_NAME}_QSPI_SCK \
                      -source [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/qspi_sck_o_reg/Q] \
                      -divide_by 1 \
                      [get_ports $func_pad_names(qspi_sck_d3)]
    lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi_flash)        [ list ${AP_SYS_NAME}_QSPI_SCK_PAD]
    create_generated_clock -name ${AP_SYS_NAME}_QSPI_SCK_PAD_D3 -add \
                      -master_clock ${AP_SYS_NAME}_QSPI_SCK_D3 \
                      -source [get_pins ${AP_SYS_HIER}u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/qspi_sck_o_reg/Q] \
                      -divide_by 1 \
                      [get_ports $func_pad_names(qspi_d3_sck)]
    #lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi_flash_d3)        [ list ${AP_SYS_NAME}_QSPI_SCK_PAD_D3]
    lappend CLOCK_GROUP(${AP_SYS_NAME}_clk_spi_flash)        [ list ${AP_SYS_NAME}_QSPI_SCK_PAD_D3]
} 

if {! $IS_CHIP} {
    create_clock -name "UTMI_CLK_EXTERNAL" -period 16 -waveform {0 8}  -add [get_ports ext_phy_utmiclk]
    set CLOCK_GROUP(UTMI_CLK_EXTERNAL)    [list UTMI_CLK_EXTERNAL]
} else {
    create_clock -name "UTMI_CLK_EXTERNAL" -period 16 -waveform {0 8}  -add [get_ports $func_pad_names(utmi_clk)]
    set CLOCK_GROUP(UTMI_CLK_EXTERNAL)    [list UTMI_CLK_EXTERNAL]
}
