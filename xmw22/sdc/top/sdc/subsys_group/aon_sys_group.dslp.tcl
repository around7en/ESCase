lappend CLOCK_GROUP(aon_sys_pwr_wrap_clk_1_875k)  ${AON_SYS_HIER}aon_sys_pwr_wrap_clk_1_875k
lappend CLOCK_GROUP(aon_sys_pwr_wrap_clk_32k)  ${AON_SYS_HIER}aon_sys_pwr_wrap_clk_32k ${AON_SYS_HIER}aon_sys_pwr_wrap_clk_aon_frc_32k
lappend CLOCK_GROUP(aon_sys_pwr_wrap_clk_aon_frc_aux)  ${AON_SYS_HIER}clk_aon_frc_aux
lappend CLOCK_GROUP(aon_sys_pwr_wrap_clk_strappin)  ${AON_SYS_HIER}clk_strappin
lappend CLOCK_GROUP(aon_sys_pwr_wrap_clk_15k)  ${AON_SYS_HIER}clk_15k
lappend CLOCK_GROUP(clk_rtc32k_anlg)  ${AON_SYS_HIER}aon_sys_pwr_wrap_clk_aon_pmu_32k
