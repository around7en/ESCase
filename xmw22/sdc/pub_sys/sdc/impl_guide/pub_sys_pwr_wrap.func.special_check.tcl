set psram_output_dat_list [list \
    psram_output_dat 0.5 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/dm_low_n_reg/CP       DM   None None \
    psram_output_dat 0.5 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/dm_low_p_reg/CP       DM   None None \
    psram_output_dat 0.5 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/dm_oe_reg/CP          DM   None None \
    psram_output_dat 0.5 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ0  None None \
    psram_output_dat 0.5 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ1  None None \
    psram_output_dat 0.5 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ2  None None \
    psram_output_dat 0.5 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ3  None None \
    psram_output_dat 0.5 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ4  None None \
    psram_output_dat 0.5 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ5  None None \
    psram_output_dat 0.5 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ6  None None \
    psram_output_dat 0.5 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ7  None None \
]

tproc_stc_skew_report $psram_output_dat_list
tproc_stc_array2csv   $psram_output_dat_list stc_check_skew.csv

set psram_output_list [list \
    psram_output 1 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/cs_n_reg/CP           CE   None None \
    psram_output 1 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/dm_low_n_reg/CP       DM   None None \
    psram_output 1 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/dm_low_p_reg/CP       DM   None None \
    psram_output 1 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/dm_oe_reg/CP          DM   None None \
    psram_output 1 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ0  None None \
    psram_output 1 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ1  None None \
    psram_output 1 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ2  None None \
    psram_output 1 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ3  None None \
    psram_output 1 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ4  None None \
    psram_output 1 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ5  None None \
    psram_output 1 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ6  None None \
    psram_output 1 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/*/CP                  DQ7  None None \
]

tproc_stc_skew_report $psram_output_list
tproc_stc_array2csv   $psram_output_list stc_check_skew.csv

set psram_input_list [list \
    psram_input 0.3 DQ0  u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dqs_low_afifo/mem_reg*/D*       None None \
    psram_input 0.3 DQ1  u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dqs_low_afifo/mem_reg*/D*       None None \
    psram_input 0.3 DQ2  u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dqs_low_afifo/mem_reg*/D*       None None \
    psram_input 0.3 DQ3  u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dqs_low_afifo/mem_reg*/D*       None None \
    psram_input 0.3 DQ4  u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dqs_low_afifo/mem_reg*/D*       None None \
    psram_input 0.3 DQ5  u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dqs_low_afifo/mem_reg*/D*       None None \
    psram_input 0.3 DQ6  u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dqs_low_afifo/mem_reg*/D*       None None \
    psram_input 0.3 DQ7  u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_rd_ctrl/u_dqs_low_afifo/mem_reg*/D*       None None \
]

tproc_stc_skew_report $psram_input_list
tproc_stc_array2csv   $psram_input_list stc_check_skew.csv

set psram_ck_output_list [list \
    psram_ck_output 0.2 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_dl/szc_nand2/ZN   CLK   None None \
    psram_ck_output 0.2 u_digital_top/u_pub_sys_pwr_wrap/u_pub_sys_top/u_psram_ctrl/u_digital_phy/dphy_ctrl_top/u_dphy_wr_ctrl/u_dphy_wr_dll/u_dphy_delay_chain/dtc_delay_cell_0/dtc_nand_dl/szc_nand2/ZN   CLKB  None None \
]

tproc_stc_skew_report $psram_ck_output_list
tproc_stc_array2csv   $psram_ck_output_list stc_check_skew.csv

