#global config
#1:axi interface, 0:ahb interface
set bus_interface 0
set use_ext_sram 1
set psram_x16mode $psram_x16mode

#clock period 
set ctrl_ck_period $CYCLE_PSRAM_CTRL
set ctrl_ck_period_max $CYCLE_102M4
set bus_ck_period $CYCLE_PSRAM_BUS
set apb_ck_period 15.15

#other clock setting
#ck_o_skew value equal max corner NAND2 cell delay + min corner NAND2 cell delay
#qingxin.luo#set ck_o_skew 0.12
set ck_o_skew 0.092
set ck_o_uncertainty 0.05
set ctrl_ck_shift_90 [expr $ctrl_ck_period/4.00 - $ck_o_skew]

#input/output delay setting
set delay_base [expr $ctrl_ck_period/4.00]
set ctrl_delay_per 0.7
set apb_delay_per 0.7
set bus_delay_per 0.7

#for input dq
set input_setup_margin 0.10
set input_hold_margin 0.10

#for signal output to psram
set output_setup_margin [expr $ck_o_uncertainty + 0.01]
set output_hold_margin [expr $ck_o_uncertainty + 0.01]

#dq input delay setting
#qingxin.luo#set input_setup_delay [expr $delay_base - $input_setup_margin]
#qingxin.luo#set input_hold_delay  [expr $delay_base - $input_hold_margin]
set input_setup_delay 0.4
set input_hold_delay  0.4
set input_hold_delay_inv [expr -$input_hold_delay]

#signal output to psram output delay setting
#qingxin.luo#set output_setup_delay [expr $delay_base - $output_setup_margin]
#qingxin.luo#set output_hold_delay  [expr $delay_base - $output_hold_margin]
set output_setup_delay 0.7
set output_hold_delay  0.7
set output_hold_delay_inv [expr -$output_hold_delay]

set cs_output_setup_delay 0.8
set cs_output_hold_delay  1.6
set cs_output_hold_delay_inv [expr -$cs_output_hold_delay]

#other signal input/output delay setting
set ctrl_io_delay [expr $ctrl_delay_per*$ctrl_ck_period]
set apb_io_delay [expr $apb_delay_per*$apb_ck_period]
set bus_io_delay [expr $bus_delay_per*$bus_ck_period]

set edge_shift_list [list $ctrl_ck_shift_90 \
                          $ctrl_ck_shift_90 \
                          $ctrl_ck_shift_90]

#qingxin.luo#if {$bus_interface == 1} {
#qingxin.luo#set axi_inputs [get_ports {awid[*] \
#qingxin.luo#                           awaddr[*] \
#qingxin.luo#                           awlen[*] \
#qingxin.luo#                           awsize[*] \
#qingxin.luo#                           awburst[*] \
#qingxin.luo#                           awlock[*] \
#qingxin.luo#                           awcache[*] \
#qingxin.luo#                           awprot[*] \
#qingxin.luo#                           awvalid \
#qingxin.luo#                           wid[*] \
#qingxin.luo#                           wdata[*] \
#qingxin.luo#                           wstrb[*] \
#qingxin.luo#                           wlast \
#qingxin.luo#                           wvalid \
#qingxin.luo#                           bready \
#qingxin.luo#                           arid[*] \
#qingxin.luo#                           araddr[*] \
#qingxin.luo#                           arlen[*] \
#qingxin.luo#                           arsize[*] \
#qingxin.luo#                           arburst[*] \
#qingxin.luo#                           arlock[*] \
#qingxin.luo#                           arcache[*] \
#qingxin.luo#                           arprot[*] \
#qingxin.luo#                           arvalid \
#qingxin.luo#                           rready}]
#qingxin.luo#
#qingxin.luo#set axi_outputs [get_ports {awready \
#qingxin.luo#                            wready \
#qingxin.luo#                            bid[*] \
#qingxin.luo#                            bresp[*] \
#qingxin.luo#                            bvalid \
#qingxin.luo#                            arready \
#qingxin.luo#                            rid[*] \
#qingxin.luo#                            rdata[*] \
#qingxin.luo#                            rresp[*] \
#qingxin.luo#                            rlast \
#qingxin.luo#                            rvalid}]
#qingxin.luo#
#qingxin.luo#} else {
#qingxin.luo#set ahb_inputs [get_ports {haddr[*] \
#qingxin.luo#                           htrans[*] \
#qingxin.luo#                           hwrite \
#qingxin.luo#                           hsize[*] \
#qingxin.luo#                           hburst[*] \
#qingxin.luo#                           hwdata[*] \
#qingxin.luo#                           hsel \
#qingxin.luo#                           hprot[*] \
#qingxin.luo#                           hlock \
#qingxin.luo#                           hmaster[*] \
#qingxin.luo#                           hmasterlock}]
#qingxin.luo#
#qingxin.luo#set ahb_outputs [get_ports {hrdata[*] \
#qingxin.luo#                            hready \
#qingxin.luo#                            hresp[*]}]
#qingxin.luo#}
#qingxin.luo#
#qingxin.luo#if {$use_ext_sram == 1} {
#qingxin.luo#set wdata_sram_outputs [get_ports {wdata_sram_wr_en \
#qingxin.luo#                                   wdata_sram_rd_en \
#qingxin.luo#                                   wdata_sram_wr_addr[*] \
#qingxin.luo#                                   wdata_sram_rd_addr[*] \
#qingxin.luo#                                   wdata_sram_wdata[*]}]
#qingxin.luo#
#qingxin.luo#set wdata_sram_inputs [get_ports {wdata_sram_rdata[*]}]
#qingxin.luo#
#qingxin.luo#  if {$bus_interface == 1} {
#qingxin.luo#    set rdata_sram_outputs [get_ports {rdata_sram_wr_en \
#qingxin.luo#                                       rdata_sram_rd_en \
#qingxin.luo#                                       rdata_sram_wr_addr[*] \
#qingxin.luo#                                       rdata_sram_rd_addr[*] \
#qingxin.luo#                                       rdata_sram_wdata[*]}]
#qingxin.luo#
#qingxin.luo#    set rdata_sram_inputs [get_ports {rdata_sram_rdata[*]}]
#qingxin.luo#  }
#qingxin.luo#}
#qingxin.luo#
#qingxin.luo#create_clock -name CTRL_CLK -period $ctrl_ck_period -waveform "0.00 [expr $ctrl_ck_period/2]" [get_ports ctrl_clk]
#qingxin.luo#create_clock -name PCLK -period $apb_ck_period -waveform "0.00 [expr $apb_ck_period/2]" [get_ports pclk]
#qingxin.luo#if {$bus_interface == 1} {
#qingxin.luo#create_clock -name BUS_CLK  -period $bus_ck_period -waveform "0.00 [expr $bus_ck_period/2.00]" [get_ports axi_clk]
#qingxin.luo#} else {
#qingxin.luo#create_clock -name BUS_CLK -period $bus_ck_period -waveform "0.00 [expr $bus_ck_period/2.00]" [get_ports hclk]
#qingxin.luo#}
create_clock -name DQS0 -period $ctrl_ck_period -waveform "0.00 [expr $ctrl_ck_period/2]" [get_ports $func_pad_names(psram_dqs_i_0)]
if {$psram_x16mode == 1} {
create_clock -name DQS1 -period $ctrl_ck_period -waveform "0.00 [expr $ctrl_ck_period/2]" [get_ports $func_pad_names(psram_dqs_i_1)]
}

##create_clock -name DM0 -period $ctrl_ck_period -waveform "0.00 [expr $ctrl_ck_period/2.00]" [get_ports dm_i_0]
##create_clock -name DM1 -period $ctrl_ck_period -waveform "0.00 [expr $ctrl_ck_period/2.00]" [get_ports dm_i_1]

##### generate wdll clock begin, for safe, generated pin chose handcode cell output pin
if {!$IS_CHIP || $IS_FLAT} {
create_generated_clock -name WDLL_CK -master_clock $name_pub_sys_clk_pub_psram_ctrl -source $hier_pub_sys_clk_pub_psram_ctrl -divide_by 1 -invert \
                       [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_m/szc_nand2/$psram_ctrl_cell_nand_o] -add -combinational

create_generated_clock -name WDLL_CK_90 -master_clock WDLL_CK -source [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_m/szc_nand2/$psram_ctrl_cell_nand_o] \
                       -invert -edges {1 2 3} -edge_shift $edge_shift_list \
                       [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o] -add

create_generated_clock -name CK_O -master_clock WDLL_CK_90 -source [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o] \
                       -divide_by 1 [get_ports $func_pad_names(psram_ck)] -add

create_generated_clock -name DQS_CK -master_clock WDLL_CK_90 -source [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o] \
                       -divide_by 1 [get_ports $func_pad_names(psram_dqs_o_0)] -add

} else {
#top only
lappend CLOCK_GROUP($pub_sys_clk_pub_psram_ctrl) ${PUB_LIB_HIER}psram_ctrl_ck_o ${PUB_LIB_HIER}psram_ctrl_dqs_o
create_generated_clock -name CK_O -master_clock ${PUB_LIB_HIER}psram_ctrl_ck_o -source [get_pins ${PUB_LIB_HIER}psram_ctrl_ck_o] \
                       -divide_by 1 [get_ports $func_pad_names(psram_ck)] -add

create_generated_clock -name DQS_CK -master_clock ${PUB_LIB_HIER}psram_ctrl_dqs_o -source [get_pins ${PUB_LIB_HIER}psram_ctrl_dqs_o] \
                       -divide_by 1 [get_ports $func_pad_names(psram_dqs_o_0)] -add
}

if {!$IS_CHIP || $IS_FLAT} {
##### generate rdll0 clock begin
##### from DQS0 
create_generated_clock -name RDLL0_DQS_CK -master_clock DQS0 -source [get_ports $func_pad_names(psram_dqs_i_0)] -divide_by 1 -invert \
                       [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_m/szc_nand2/$psram_ctrl_cell_nand_o] -add -combinational

create_generated_clock -name RDLL0_DQS_CK_90 -master_clock RDLL0_DQS_CK -source [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_m/szc_nand2/$psram_ctrl_cell_nand_o] \
                       -invert -edges {1 2 3} -edge_shift $edge_shift_list \
                       [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o] -add

#### from DM0
#create_generated_clock -name RDLL0_DM_CK -master_clock DM0 -source [get_ports dm_i_0] -divide_by 1 -invert \
#                       [get_pins u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_m/szc_nand2/$psram_ctrl_cell_nand_o] -add -combinational

#create_generated_clock -name RDLL0_DM_CK_90 -master_clock RDLL0_DM_CK -source [get_pins u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_m/szc_nand2/$psram_ctrl_cell_nand_o] \
#                       -invert -edges {1 2 3} -edge_shift $edge_shift_list \
#                       [get_pins u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o] -add

##### generate rdll1 clock begin
##### from DQS1
if {$psram_x16mode == 1} {
create_generated_clock -name RDLL1_DQS_CK -master_clock DQS1 -source [get_ports $func_pad_names(psram_dqs_i_1)] -divide_by 1 -invert \
                       [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_m/szc_nand2/$psram_ctrl_cell_nand_o] -add -combinational

create_generated_clock -name RDLL1_DQS_CK_90 -master_clock RDLL1_DQS_CK -source [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_m/szc_nand2/$psram_ctrl_cell_nand_o] \
                       -invert -edges {1 2 3} -edge_shift $edge_shift_list \
                       [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o] -add
}
#create_generated_clock -name RDLL1_DM_CK -master_clock DM1 -source [get_ports dm_i_1] -divide_by 1 -invert \
#                       [get_pins u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_m/szc_nand2/$psram_ctrl_cell_nand_o] -add -combinational

#create_generated_clock -name RDLL1_DM_CK_90 -master_clock RDLL1_DM_CK -source [get_pins u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_m/szc_nand2/$psram_ctrl_cell_nand_o] \
#                       -invert -edges {1 2 3} -edge_shift $edge_shift_list \
#                       [get_pins u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o] -add

#below dont touch network and ideal network setting just for syn and pre STA
#for PnR flow and post STA, should remove these setting
#if {[info exist synopsys_program_name] && ${synopsys_program_name} == "dc_shell"} {
#qingxin.luo#set_ideal_network      [get_ports *rst_n]
#qingxin.luo#set_dont_touch_network [get_ports *rst_n]
#qingxin.luo#set_ideal_network      [get_ports ctrl_clk]
#qingxin.luo#set_dont_touch_network [get_ports ctrl_clk]
#qingxin.luo#set_ideal_network      [get_ports pclk]
#qingxin.luo#set_dont_touch_network [get_ports pclk]
#qingxin.luo#if {$bus_interface == 1} {
#qingxin.luo#set_ideal_network      [get_ports axi_clk]
#qingxin.luo#set_dont_touch_network [get_ports axi_clk]
#qingxin.luo#} else {
#qingxin.luo#set_ideal_network      [get_ports hclk]
#qingxin.luo#set_dont_touch_network [get_ports hclk]
#qingxin.luo#set_ideal_network      [get_ports hresetn]
#qingxin.luo#set_dont_touch_network [get_ports hresetn]
#qingxin.luo#}
#qingxin.luo#set_ideal_network      [get_ports $func_pad_names(psram_dqs_i_0)]
#qingxin.luo#set_dont_touch_network [get_ports $func_pad_names(psram_dqs_i_0)]
#qingxin.luo#if {$psram_x16mode == 1} {
#qingxin.luo#set_ideal_network      [get_ports $func_pad_names(psram_dqs_i_1)]
#qingxin.luo#set_dont_touch_network [get_ports $func_pad_names(psram_dqs_i_1)]
#qingxin.luo#}
#qingxin.luo#
#qingxin.luo#set_dont_touch_network [get_ports $func_pad_names(psram_dq_os)]
#qingxin.luo#set_dont_touch_network [get_ports $func_pad_names(psram_dm)]
#qingxin.luo#set_dont_touch_network [get_ports $func_pad_names(psram_dqs_os)]
#qingxin.luo#set_dont_touch_network [get_ports $func_pad_names(psram_ck)]
#qingxin.luo#set_dont_touch_network [get_ports $func_pad_names(psram_cs_n_o)]
#}

set_dont_touch         [get_cells -hierarchical dtc_*]

#in digital phy module, all of nets and cells (except NAND2 cell) should dont touch
#NAND2 cells are size only for min delay constraint
set_dont_touch         [get_cells -hierarchical u_dphy_delay_chain*]
#qingxin.luo#set_size_only -all_instances [get_cells -hierarchical szc_*]
set_size_only [get_cells -hierarchical -filter "full_name =~ */szc_*"]

#disable the clock gating check on nand gate for delay chain
set_disable_clock_gating_check [get_cells ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs*_dll/u_dphy_delay_chain/*dtc_delay_cell_*/dtc_nand_*/szc_nand2]
set_disable_clock_gating_check [get_cells ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/*dtc_delay_cell_*/dtc_nand_*/szc_nand2]

}
#qingxin.luo#set_clock_uncertainty -setup 0.30 [get_clocks CTRL_CLK]
#qingxin.luo#set_clock_uncertainty -hold  0.30 [get_clocks CTRL_CLK]
#qingxin.luo#
#qingxin.luo#set_clock_uncertainty -setup 0.30 [get_clocks BUS_CLK]
#qingxin.luo#set_clock_uncertainty -hold  0.30 [get_clocks BUS_CLK]
#qingxin.luo#
#qingxin.luo#set_clock_uncertainty -setup 0.30 [get_clocks PCLK]
#qingxin.luo#set_clock_uncertainty -hold  0.30 [get_clocks PCLK]

#qingxin.luo#set_clock_uncertainty -setup $ck_o_uncertainty [get_clocks CK_O]
#qingxin.luo#set_clock_uncertainty -hold  $ck_o_uncertainty [get_clocks CK_O]

#function mode
#qingxin.luo#set_case_analysis 0 [get_ports scan_mode]

#dq input delay setting
set_input_delay $input_setup_delay    -max -clock DQS0 $func_pad_names(psram_dq_i0_7)
set_input_delay $input_hold_delay_inv -min -clock DQS0 $func_pad_names(psram_dq_i0_7) -add_delay
set_input_delay $input_setup_delay    -max -clock DQS0 $func_pad_names(psram_dq_i0_7) -add_delay -clock_fall
set_input_delay $input_hold_delay_inv -min -clock DQS0 $func_pad_names(psram_dq_i0_7) -add_delay -clock_fall

if {$psram_x16mode == 1} {
set_input_delay $input_setup_delay    -max -clock DQS1 $func_pad_names(psram_dq_i8_15)
set_input_delay $input_hold_delay_inv -min -clock DQS1 $func_pad_names(psram_dq_i8_15) -add_delay
set_input_delay $input_setup_delay    -max -clock DQS1 $func_pad_names(psram_dq_i8_15) -add_delay -clock_fall
set_input_delay $input_hold_delay_inv -min -clock DQS1 $func_pad_names(psram_dq_i8_15) -add_delay -clock_fall
}

#set_input_delay $input_setup_delay    -max -clock DM0 {dq_i[0] dq_i[1] dq_i[2] dq_i[3] dq_i[4] dq_i[5] dq_i[6] dq_i[7]} -add_delay
#set_input_delay $input_hold_delay_inv -min -clock DM0 {dq_i[0] dq_i[1] dq_i[2] dq_i[3] dq_i[4] dq_i[5] dq_i[6] dq_i[7]} -add_delay
#set_input_delay $input_setup_delay    -max -clock DM0 {dq_i[0] dq_i[1] dq_i[2] dq_i[3] dq_i[4] dq_i[5] dq_i[6] dq_i[7]} -add_delay -clock_fall
#set_input_delay $input_hold_delay_inv -min -clock DM0 {dq_i[0] dq_i[1] dq_i[2] dq_i[3] dq_i[4] dq_i[5] dq_i[6] dq_i[7]} -add_delay -clock_fall

#set_input_delay $input_setup_delay    -max -clock DM1 {dq_i[8] dq_i[9] dq_i[10] dq_i[11] dq_i[12] dq_i[13] dq_i[14] dq_i[15]} -add_delay
#set_input_delay $input_hold_delay_inv -min -clock DM1 {dq_i[8] dq_i[9] dq_i[10] dq_i[11] dq_i[12] dq_i[13] dq_i[14] dq_i[15]} -add_delay
#set_input_delay $input_setup_delay    -max -clock DM1 {dq_i[8] dq_i[9] dq_i[10] dq_i[11] dq_i[12] dq_i[13] dq_i[14] dq_i[15]} -add_delay -clock_fall
#set_input_delay $input_hold_delay_inv -min -clock DM1 {dq_i[8] dq_i[9] dq_i[10] dq_i[11] dq_i[12] dq_i[13] dq_i[14] dq_i[15]} -add_delay -clock_fall

#signal output psram output delay setting, not for timing just for CK_O phase constraint
set_output_delay $cs_output_setup_delay    -max -clock CK_O $func_pad_names(psram_cs_n)
set_output_delay $cs_output_hold_delay_inv -min -clock CK_O $func_pad_names(psram_cs_n) -add_delay
#set_output_delay $cs_output_setup_delay    -max -clock CK_O $func_pad_names(psram_cs_n) -add_delay -clock_fall
#set_output_delay $cs_output_hold_delay_inv -min -clock CK_O $func_pad_names(psram_cs_n) -add_delay -clock_fall

set_output_delay $output_setup_delay    -max -clock CK_O $func_pad_names(psram_dq_os)
set_output_delay $output_hold_delay_inv -min -clock CK_O $func_pad_names(psram_dq_os) -add_delay
set_output_delay $output_setup_delay    -max -clock CK_O $func_pad_names(psram_dq_os) -add_delay -clock_fall
set_output_delay $output_hold_delay_inv -min -clock CK_O $func_pad_names(psram_dq_os) -add_delay -clock_fall

set_output_delay $output_setup_delay    -max -clock CK_O $func_pad_names(psram_dm)
set_output_delay $output_hold_delay_inv -min -clock CK_O $func_pad_names(psram_dm) -add_delay
set_output_delay $output_setup_delay    -max -clock CK_O $func_pad_names(psram_dm) -add_delay -clock_fall
set_output_delay $output_hold_delay_inv -min -clock CK_O $func_pad_names(psram_dm) -add_delay -clock_fall

set_output_delay $output_setup_delay    -max -clock CK_O $func_pad_names(psram_dqs_os)
set_output_delay $output_hold_delay_inv -min -clock CK_O $func_pad_names(psram_dqs_os) -add_delay
set_output_delay $output_setup_delay    -max -clock CK_O $func_pad_names(psram_dqs_os) -add_delay -clock_fall
set_output_delay $output_hold_delay_inv -min -clock CK_O $func_pad_names(psram_dqs_os) -add_delay -clock_fall

#qingxin.luo##normal input/output delay for timing
#qingxin.luo#set_input_delay  $apb_io_delay -clock PCLK {psel penable pwrite pwdata[*] paddr[*]}
#qingxin.luo#set_output_delay $apb_io_delay -clock PCLK {pready prdata[*]}
#qingxin.luo#
#qingxin.luo#if {$bus_interface == 1} {
#qingxin.luo#set_input_delay  $bus_io_delay -clock BUS_CLK $axi_inputs
#qingxin.luo#set_output_delay $bus_io_delay -clock BUS_CLK $axi_outputs
#qingxin.luo#} else {
#qingxin.luo#set_input_delay  $bus_io_delay -clock BUS_CLK $ahb_inputs
#qingxin.luo#set_output_delay $bus_io_delay -clock BUS_CLK $ahb_outputs
#qingxin.luo#}
#qingxin.luo#
#qingxin.luo#if {$use_ext_sram == 1} {
#qingxin.luo#set_input_delay  $bus_io_delay -clock CTRL_CLK $wdata_sram_inputs
#qingxin.luo#set_output_delay $bus_io_delay -clock CTRL_CLK $wdata_sram_outputs
#qingxin.luo#  if {$bus_interface == 1} {
#qingxin.luo#  set_input_delay  $bus_io_delay -clock CTRL_CLK $rdata_sram_inputs
#qingxin.luo#  set_output_delay $bus_io_delay -clock CTRL_CLK $rdata_sram_outputs
#qingxin.luo#  }
#qingxin.luo#}

if {!$IS_CHIP || $IS_FLAT} {
if {! $IS_CHIP} {
    set_output_delay $ctrl_io_delay -clock $name_pub_sys_clk_pub_psram_ctrl {psram_ctrl_dqs_oe psram_ctrl_dq_oe[*]}
}

#phase detect, dont care timing
set_false_path -through [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/dtc_pd_scan_mux/dtc_mx2/Z]

set_false_path -through [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/dtc_pd_scan_mux/dtc_mx2/Z]

if {$psram_x16mode == 1} {set_false_path -through [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/dtc_pd_scan_mux/dtc_mx2/Z]}

if {[info exist synopsys_program_name] && ${synopsys_program_name} == "pt_shell"} {
} else {
    set_false_path -through [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o] \
                   -through [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/dtc_dqs_gen/dtc_icg/Q] \
                   -to      [get_ports $func_pad_names(psram_dqs_o_0)]

if {$psram_x16mode == 1} {
set_false_path -through [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o] \
               -through [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/dtc_dqs_gen/dtc_icg/Q] \
               -to      [get_ports $func_pad_names(psram_dqs_o_1)]
}
}
#used as data
#qingxin.luo#if {[info exist synopsys_program_name] && ${synopsys_program_name} == "dc_shell"} {
#qingxin.luo#set_clock_sense -stop_propagation [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_pd/tmp_result_reg/next_state] -clocks $name_pub_sys_clk_pub_psram_ctrl
#qingxin.luo#
#qingxin.luo#set_clock_sense -stop_propagation [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_pd/tmp_result_reg/next_state] -clocks DQS0
#qingxin.luo#
#qingxin.luo#set_clock_sense -stop_propagation [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dtc_rwds_gating_gen/hc_i0] -clocks DQS0
#qingxin.luo#
#qingxin.luo#if {$psram_x16mode == 1} {set_clock_sense -stop_propagation [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_pd/tmp_result_reg/next_state] -clocks DQS1}
#qingxin.luo#
#qingxin.luo##set_clock_sense -stop_propagation [get_pins u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_pd/tmp_result_reg/next_state] -clocks DM0
#qingxin.luo#
#qingxin.luo##set_clock_sense -stop_propagation [get_pins u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_pd/tmp_result_reg/next_state] -clocks DM1
#qingxin.luo#} else {
set_clock_sense -stop_propagation [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_pd/tmp_result_reg/D] -clocks $name_pub_sys_clk_pub_psram_ctrl

set_clock_sense -stop_propagation [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_pd/tmp_result_reg/D] -clocks DQS0

set_clock_sense -stop_propagation [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dtc_rwds_gating_gen/dtc_and2/A1] -clocks DQS0

if {$psram_x16mode == 1} {set_clock_sense -stop_propagation [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_pd/tmp_result_reg/D] -clocks DQS1}

#set_clock_sense -stop_propagation [get_pins u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_pd/tmp_result_reg/D] -clocks DM0

#set_clock_sense -stop_propagation [get_pins u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_pd/tmp_result_reg/D] -clocks DM1
#qingxin.luo#}

#qingxin.luo#set_clock_groups -asynchronous \
#qingxin.luo#  -group {CTRL_CLK WDLL_CK_90 CK_O DQS_CK} \
#qingxin.luo#  -group {PCLK} \
#qingxin.luo#  -group {BUS_CLK} \
#qingxin.luo#  -group {DQS0 RDLL0_DQS_CK RDLL0_DQS_CK_90} \
#qingxin.luo#  -group {DQS1 RDLL1_DQS_CK RDLL1_DQS_CK_90} 
#qingxin.luo##  -group {DM0  RDLL0_DM_CK  RDLL0_DM_CK_90} \
#qingxin.luo##  -group {DM1  RDLL1_DM_CK  RDLL1_DM_CK_90}

#min delay is about 1.2*min ctrl_clock_period

set min_d [expr 1.2*$ctrl_ck_period_max]
#set min_d 7.8
set_min_delay $min_d -from    [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_ur/szc_nand2/$psram_ctrl_cell_nand_o] \
                -through [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/dtc_delay_cell_255/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o] \
                -to      [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/dtc_delay_cell_1/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o]

set_min_delay $min_d -from    [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_ur/szc_nand2/$psram_ctrl_cell_nand_o] \
                -through [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_delay_chain/dtc_delay_cell_255/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o] \
                -to      [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs0_dll/u_dphy_delay_chain/dtc_delay_cell_1/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o]

if {$psram_x16mode == 1} {
set_min_delay $min_d -from    [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_ur/szc_nand2/$psram_ctrl_cell_nand_o] \
                -through [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_delay_chain/dtc_delay_cell_255/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o] \
                -to      [get_pins ${PSRAM_CTRL_HIER}/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dphy_dqs1_dll/u_dphy_delay_chain/dtc_delay_cell_1/dtc_nand_dl/szc_nand2/$psram_ctrl_cell_nand_o]
}
}
lappend CLOCK_GROUP($pub_sys_clk_pub_psram_ctrl) ${PUB_LIB_HIER}WDLL_CK ${PUB_LIB_HIER}WDLL_CK_90 CK_O DQS_CK
set CLOCK_GROUP(pub_psram_ctrl_dqs0) "DQS0 ${PUB_LIB_HIER}RDLL0_DQS_CK ${PUB_LIB_HIER}RDLL0_DQS_CK_90"
if {$psram_x16mode == 1} {
set CLOCK_GROUP(pub_psram_ctrl_dqs1) "DQS1 ${PUB_LIB_HIER}RDLL1_DQS_CK ${PUB_LIB_HIER}RDLL1_DQS_CK_90"
}
