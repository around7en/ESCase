if {! $IS_CHIP} {
    set_output_delay [expr 0.7 * $CYCLE_307M2]   -clock ${AP_SYS_NAME}_clk_307_2m_cpll_ap_sys        -add_delay [get_ports  busy_clk_307_2m_cpll_ap_sys]
    set_output_delay [expr 0.7 * $CYCLE_245M76]  -clock ${AP_SYS_NAME}_clk_245_76m_cpll_ap_sys       -add_delay [get_ports  busy_clk_245_76m_cpll_ap_sys]
    set_output_delay [expr 0.7 * $CYCLE_204M8]   -clock ${AP_SYS_NAME}_clk_204_8m_cpll_ap_sys        -add_delay [get_ports  busy_clk_204_8m_cpll_ap_sys]
    set_output_delay [expr 0.7 * $CYCLE_153M6]   -clock ${AP_SYS_NAME}_clk_153_6m_cpll_ap_sys        -add_delay [get_ports  busy_clk_153_6m_cpll_ap_sys]
    set_output_delay [expr 0.7 * $CYCLE_102M4]   -clock ${AP_SYS_NAME}_clk_102_4m_cpll_ap_sys        -add_delay [get_ports  busy_clk_102_4m_cpll_ap_sys]
    set_output_delay [expr 0.7 * $CYCLE_76M8]    -clock ${AP_SYS_NAME}_clk_76_8m_cpll_ap_sys         -add_delay [get_ports  busy_clk_76_8m_cpll_ap_sys]
    set_output_delay [expr 0.7 * $CYCLE_61M44]   -clock ${AP_SYS_NAME}_clk_61_44m_cpll_ap_sys        -add_delay [get_ports  busy_clk_61_44m_cpll_ap_sys]
    set_output_delay [expr 0.7 * $CYCLE_51M2]    -clock ${AP_SYS_NAME}_clk_51_2m_cpll_ap_sys         -add_delay [get_ports  busy_clk_51_2m_cpll_ap_sys]
    set_output_delay [expr 0.7 * $CYCLE_30M72]   -clock ${AP_SYS_NAME}_clk_30_72m_cpll_ap_sys        -add_delay [get_ports  busy_clk_30_72m_cpll_ap_sys]
    set_output_delay [expr 0.7 * $CYCLE_26M]     -clock ${AP_SYS_NAME}_clk_26m_xo_ap_sys             -add_delay [get_ports  busy_clk_26m_xo_ap_sys]

    set ap2top_ahb_ports {
        HADDRM_TOP*        
        HBURSTM_TOP*        
        HMASTLOCKM_TOP*     
        HPROTM_TOP*         
        HSIZEM_TOP*         
        HTRANSM_TOP*        
        HWDATAM_TOP*        
        HWRITEM_TOP*        
        HRDATAM_TOP*        
        HREADYM_TOP*        
        HRESPM_TOP*         
    }
    set top2ap_ahb_ports {
        HADDRS_TOP*             
        HBURSTS_TOP*            
        HMASTLOCKS_TOP*         
        HPROTS_TOP*            
        HREADYMUXS_TOP*         
        HSIZES_TOP*             
        HTRANSS_TOP*            
        HSELS_TOP*              
        HWDATAS_TOP*            
        HWRITES_TOP*            
        HRDATAS_TOP*            
        HREADYOUTS_TOP*         
        HRESPS_TOP*             
    }
    set_input_delay  [expr $CYCLE_102M4 * 0.7] -clock ${AP_SYS_NAME}_clk_top_ahb -add_delay [get_ports "$top2ap_ahb_ports $ap2top_ahb_ports" -filter {@port_direction == in}]
    set_output_delay [expr $CYCLE_102M4 * 0.7] -clock ${AP_SYS_NAME}_clk_top_ahb -add_delay [get_ports "$top2ap_ahb_ports $ap2top_ahb_ports" -filter {@port_direction == out}]

    set cpu2flash_ahb_ports {
        HADDRS_CPU*                      
        HBURSTS_CPU*                     
        HMASTLOCKS_CPU*                  
        HPROTS_CPU*                      
        HSIZES_CPU*                      
        HTRANSS_CPU*                     
        HWDATAS_CPU*                     
        HWRITES_CPU*                     
        HRDATAS_CPU*                     
        HREADYOUTS_CPU*                  
        HRESPS_CPU*                     
        cgm_busy_clk_spi_flash_cpu 
    }
    set_input_delay  [expr $CYCLE_307M2 * 0.7] -clock ${AP_SYS_NAME}_clk_spi_flash -add_delay [get_ports $cpu2flash_ahb_ports -filter {@port_direction == in}]
    set_output_delay [expr $CYCLE_307M2 * 0.7] -clock ${AP_SYS_NAME}_clk_spi_flash -add_delay [get_ports $cpu2flash_ahb_ports -filter {@port_direction == out}]

    set ap2cpu_ahb_ports {
        HADDRM_CPU*                      
        HBURSTM_CPU*                     
        HSELM_CPU*                       
        HMASTLOCKM_CPU*                  
        HPROTM_CPU*                      
        HSIZEM_CPU*                      
        HTRANSM_CPU*                     
        HWDATAM_CPU*                     
        HWRITEM_CPU*                     
        HREADYMUXM_CPU*                                     
        HAUSERM_CPU*                                        
        HRDATAM_CPU*                     
        HRESPM_CPU*                      
        cgm_busy_clk_ap_ahb_cpu
    }
    set_input_delay  [expr $CYCLE_204M8 * 0.7] -clock ${AP_SYS_NAME}_clk_ap_ahb -add_delay [get_ports $ap2cpu_ahb_ports -filter {@port_direction == in}]
    set_output_delay [expr $CYCLE_204M8 * 0.7] -clock ${AP_SYS_NAME}_clk_ap_ahb -add_delay [get_ports $ap2cpu_ahb_ports -filter {@port_direction == out}]

    set_input_delay  [expr $CYCLE_204M8 * 0.6] -clock ${AP_SYS_NAME}_clk_ap_ahb -add_delay [get_ports HREADYM_CPU]
   # set_output_delay [expr $CYCLE_204M8 * 0.5] -clock ${AP_SYS_NAME}_clk_ap_ahb -add_delay [get_ports HREADYMUXM_CPU]
   # set_output_delay [expr $CYCLE_204M8 * 0.5] -clock ${AP_SYS_NAME}_clk_ap_ahb -add_delay [get_ports HTRANSM_CPU*]

    set ap2sysram_ahb_ports {
        HADDRM_SYS_RAM*                  
        HBURSTM_SYS_RAM*                 
        HMASTLOCKM_SYS_RAM*              
        HPROTM_SYS_RAM*                  
        HSIZEM_SYS_RAM*                  
        HTRANSM_SYS_RAM*                 
        HWDATAM_SYS_RAM*                 
        HWRITEM_SYS_RAM*                 
        HRDATAM_SYS_RAM*                 
        HREADYM_SYS_RAM*                 
        HRESPM_SYS_RAM*                  
    }
    set_input_delay  [expr $CYCLE_245M76 * 0.7] -clock ${AP_SYS_NAME}_clk_sysram_ahb -add_delay [get_ports $ap2sysram_ahb_ports -filter {@port_direction == in}]
    set_output_delay [expr $CYCLE_245M76 * 0.7] -clock ${AP_SYS_NAME}_clk_sysram_ahb -add_delay [get_ports $ap2sysram_ahb_ports -filter {@port_direction == out}]

    set ap2pub_ahb_ports {
        HADDRM_PUB*                      
        HBURSTM_PUB*                     
        HMASTLOCKM_PUB*                  
        HPROTM_PUB*                      
        HSIZEM_PUB*                      
        HTRANSM_PUB*                     
        HWDATAM_PUB*                     
        HWRITEM_PUB*                     
        HRDATAM_PUB*                     
        HREADYM_PUB*                     
        HRESPM_PUB*                      
    }
    set_input_delay  [expr $CYCLE_204M8 * 0.7] -clock ${AP_SYS_NAME}_clk_pub_ahb -add_delay [get_ports $ap2pub_ahb_ports -filter {@port_direction == in}]
    set_output_delay [expr $CYCLE_204M8 * 0.7] -clock ${AP_SYS_NAME}_clk_pub_ahb -add_delay [get_ports $ap2pub_ahb_ports -filter {@port_direction == out}]

    set async_ports {
        rst_ap_por_n                    
        sw_ap2flash_dbg_rst
        sw_ap2pub_dbg_rst
        sw_ap2sysram_dbg_rst
        sw_ap2top_dbg_rst
        sw_ap_main_mtx_dbg_rst
        sw_flash_main_mtx_dbg_rst
        sw_top2ap_dbg_rst
        huk_word0                       
        huk_word1                       
        huk_word2                       
        huk_word3                       
        huk_lock_en                     
        sm_disable                      
        uart0_dmaclr_tx                       
        uart0_dmaclr_rx                  
        uart0_dmacbreq_rx               
        uart0_dmacsreq_rx               
        uart0_dmacbreq_tx               
        uart2_dmaclr_tx                       
        uart2_dmaclr_rx                  
        uart2_dmacbreq_rx               
        uart2_dmacsreq_rx               
        uart2_dmacbreq_tx               
        uart3_dmaclr_tx                       
        uart3_dmaclr_rx                  
        uart3_dmacbreq_rx               
        uart3_dmacsreq_rx               
        uart3_dmacbreq_tx               
        dbgbus_apsys_chain_sel          
        dbgbus_apsys_data               
        ua1_int                         
        ua4_int                         
        ua5_int                         
        pwm2_pwm_int                    
        pwm3_pwm_int                    
        i2s0_interrupt                  
        spi0_interrupt                  
        spi1_interrupt                  
        spi2_interrupt                  
        qspi_flashc_int                           
        ce_intr                          
        DMACINTR                        
        o_sim0_irq                                       
        o_sim1_irq                           
        i2c1_irq                         
        i2c2_irq                         
        o_can0_irq                      
        o_can1_irq                      
        sdio0_int_to_arm                    
        ext_spi_flashc_int
        wuintreq                        
        usbintreq                       
        phy_ponrst 
        io_remap_type_ext
        ap_deep_sleep_req
        hw_en_clk_top_ahb               
        hw_en_clk_pub_ahb               
        hw_en_clk_sysram_ahb  
        cgm_busy_clk_pub_ahb            
        cgm_busy_clk_top_ahb            
        cgm_busy_clk_sysram_ahb         
        dbg_hready_ap
        busy_clk_19_2m_cpll_ap_sys
        spi0_miso_in
        spi0_mosi_out
        spi1_nss_in
        spi1_miso_out
        spi1_sclk_in
        sdcd_n
        hw_en_clk_cpu_ahb
        ap2top_anti_ext
        ap2sysram_anti_ext
        ap2pub_anti_ext
        ap2cpu_anti_ext
        top2ap_anti_ext
        cpu2flash_anti_ext
        usbphy_ponrst 
        ptest_usbphy_mode 
        usbphy_ls_en
        usbphy_test_rst
        usbphy_hs_bist_mode
        usbphy_vcontrol
        usbphy_utmilinestate
        usbphy_bist_ok
        i2s0_ws_oen
        i2s0_sck_oen
    }
    set_input_delay [expr $CYCLE_26M*0.5] -clock ${AP_SYS_NAME}_V_CLK_26M  [get_ports -filter "@port_direction == in" $async_ports]
    set_output_delay [expr $CYCLE_26M*0.4] -clock ${AP_SYS_NAME}_V_CLK_26M [get_ports -filter "@port_direction == out" $async_ports]
}
##uart1/uart4/uart5 io delay
set IP_NAME uart1
set PAD_INDEX u1
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.uart.sdc

set IP_NAME uart4
set PAD_INDEX u4
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.uart.sdc

set IP_NAME uart5
set PAD_INDEX u5
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.uart.sdc

##spi2 io delay
set IP_NAME spi2
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.spi2.sdc
##spi0 io delay
set IP_NAME spi0
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.spi0.sdc
##spi1 io delay
set IP_NAME spi1
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.spi1.sdc

##spi flash io delay
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.flash.sdc
##ext spi flash io delay
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.ext_flash.sdc

##i2c1/i2c2 io delay
set IP_NAME i2c1
set PAD_INDEX iic1
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.i2c.sdc
set PAD_INDEX iic2
set IP_NAME i2c2
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.i2c.sdc

##sim0/sim1 io delay
set IP_NAME sim0
set PAD_INDEX sim0
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.sim.sdc
set IP_NAME sim1
set PAD_INDEX sim1
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.sim.sdc

##pwm2/pwm3 io delay
set IP_NAME pwm2
set PAD_INDEX pwm2
set CLK1_PERIOD $CYCLE_26M
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.pwm.sdc
set IP_NAME pwm3
set PAD_INDEX pwm3
set CLK1_PERIOD $CYCLE_76M8 
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.pwm.sdc

##i2s0 io delay
set IP_NAME i2s0
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.i2s.sdc

##can0/can1 io delay
set IP_NAME can0
set PAD_INDEX 0
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.can.sdc
set IP_NAME can1
set PAD_INDEX 1
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.can.sdc

##sdio io delay
set IP_NAME sdio0
set PAD_INDEX sdio0
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.sdio.sdc

##usb io delay
source $PROJ_DIR/de/ap_sys/sdc/ip_sdc/ap_sys_pwr_wrap.usb.sdc
