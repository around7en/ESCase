if {$IS_FLAT} {
    set dont_touch_insts [list \
        ]
        #u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_VDD_IO0    \
        #u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_VDDIO_SIM1 \
        #u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_VDDIO_SIM0 \
        #u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_VDD_IO1   \
        #u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_VDD_IO33   \
        #u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_VDDIO_SD   \
        #u_digital_top/u_aon_sys_pwr_wrap/u_aon_sys_top/u_aon_io_top/u_io_group_aon_inst_wrap/u_VDD_AONIO 
} else {
    set dont_touch_insts [list \
    ]
        #u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_VDD_IO0    \
        #u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_VDDIO_SIM1 \
        #u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_VDDIO_SIM0 \
        #u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_VDD_IO1   \
        #u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_VDD_IO33   \
        #u_digital_top/u_io_top/u_io_group_digital_inst_wrap/u_VDDIO_SD   
}

set dont_touch_cells {
}

set dont_touch_nets {
}

set dont_touch_networks [list  \
    u_rftop/IN_XO \
    u_rftop/OUT_XO \
    u_rftop/RX_HB0 \
    u_rftop/RX_HB1 \
    u_rftop/RX_HMB0 \
    u_rftop/RX_HMB1 \
    u_rftop/RX_HMB2 \
    u_rftop/RX_LB0 \
    u_rftop/RX_LB1 \
    u_rftop/RX_MLB0 \
    u_rftop/RX_MLB1 \
    u_rftop/RX_MLB2 \
    u_rftop/TEST_POINT_N \
    u_rftop/TEST_POINT_P \
    u_rftop/TX_HMB0 \
    u_rftop/TX_HMB1 \
    u_rftop/TX_LB \
    u_rftop/XO_CLK_OUT \
    u_analog_top/ADC_INPUT2 \
    u_analog_top/XTAL32K_I \
    u_analog_top/PBINT \
    u_analog_top/EXT_RSTN \
    u_analog_top/XTAL32K_O \
    u_analog_top/PDET \
    u_analog_top/ADC_INPUT0 \
    u_analog_top/ADC_INPUT1 \
    u_analog_top/ADC_INPUT3 \
    u_analog_top/VBUS \
    u_analog_top/LDO_IO_SET_PAD \
]

if {$IS_FLAT} {
    lappend dont_touch_networks      u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_usb2_wrap/u_M31USBH225TL022V_00223601/DM 
    lappend dont_touch_networks      u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_ap_sys_usb2_wrap/u_M31USBH225TL022V_00223601/DP 
}

foreach mnet $dont_touch_networks {
    #IO use set_dont_touch_network,others use set_dont_touch
    set_dont_touch_network $mnet
}
foreach minst $dont_touch_insts {
    set_dont_touch $minst
}
