lappend CLOCK_GROUP(pub_psram_ctrl_dqs0)  ${PUB_SYS_HIER}RDLL0_DQS_CK ${PUB_SYS_HIER}RDLL0_DQS_CK_90
lappend CLOCK_GROUP(pub_sys_clk_pub_cfg_scan)  ${PUB_SYS_HIER}pub_sys_clk_pub_cfg_scan
lappend CLOCK_GROUP(pub_sys_clk_pub_main_mtx)  ${PUB_SYS_HIER}pub_sys_clk_pub_main_mtx ${PUB_SYS_HIER}clk_pub_ahb_for_cpu ${PUB_SYS_HIER}clk_pub_ahb_for_cp ${PUB_SYS_HIER}clk_pub_ahb_for_ap ${PUB_SYS_HIER}WDLL_CK ${PUB_SYS_HIER}WDLL_CK_90 ${PUB_SYS_HIER}psram_ctrl_ck_o ${PUB_SYS_HIER}psram_ctrl_dqs_o
