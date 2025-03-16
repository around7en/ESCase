
proc tproc_stc_skew_report {stc_skew_list} {
    set_app_var timing_report_unconstrained_paths true

    set path_col_stc_skew ""
    set idx      0
    set skew_req 0
    set gpn      ""
    foreach {gp skew sp  ep th0 th1 } $stc_skew_list {
        if {$sp  == "None"} {set sp_line   ""} else {set sp_line  " -from     $sp  "}
        if {$ep  == "None"} {set ep_line   ""} else {set ep_line  " -to       $ep  "}
        if {$th0 == "None"} {set th0_line  ""} else {set th0_line " -through  $th0 "}
        if {$th1 == "None"} {set th1_line  ""} else {set th1_line " -through  $th1 "}
        append_to_collection path_col_stc_skew [ eval get_timing_paths $sp_line $th0_line $th1_line $ep_line -slack_lesser_than inf -max_path 100]
        set idx [expr $idx + 1]
        set skew_req $skew
        set gpn $gp

    }

    set max_dar  0
    set min_dar  100
    set max_clat 0
    set min_clat 100
    set max_slk  0
    set min_slk  100

    if {[sizeof_collection $path_col_stc_skew] == 0} { puts "Error: No path for $gp skew check, pls check "; return}
    foreach_in_collection path_col $path_col_stc_skew {
        set sp   [get_object_name [get_attribute   $path_col startpoint]]
        set ep   [get_object_name [get_attribute   $path_col endpoint]]
        #data arrival
        set dar  [get_attribute   $path_col  arrival]
        set llat [get_attribute   $path_col startpoint_clock_latency]
        if {$llat == ""} {set llat 0.0}   
        if {$dar > $max_dar} {set max_dar $dar}
        if {$dar < $min_dar} {set min_dar $dar}


        #endpoint_clock_latency
        set clat [get_attribute   $path_col endpoint_clock_latency]
        if {$clat == ""} {set clat 0.0}
        if {$clat > $max_clat} {set max_clat $clat}
        if {$clat < $min_clat} {set min_clat $clat}
        #slack
        set slk  [get_attribute   $path_col slack]
        puts [format "startpoint:%-50s  endpoint: %-50s  data arrival: %6f  startpoint clock latency : %6f  endpoint clock latency : %6f     slack: %6f" $sp $ep $dar $llat  $clat $slk]

    }
    set grp_skew  [expr $max_dar  - $min_dar ]
    if {$grp_skew <= $skew_req} {
        puts [format ""]
        puts [format ""]
        puts [format "#######################  $gpn check    #############################################################"]
        puts [format "#"]
        puts [format "# Pass:$gpn ->    data arrival max : %6f , min : %6f , group skew : %6f ,   require skew  : %6f" $max_dar  $min_dar  [expr $max_dar  - $min_dar ]  $skew_req]
        puts [format "# captrure lat max : %6f , min : %6f , skew : %6f" $max_clat $min_clat [expr $max_clat - $min_clat]]
        puts [format "#"]
        puts [format "####################################################################################################"]
    } else {
        puts [format ""]
        puts [format ""]
        puts [format "#######################  $gpn check    #############################################################"]
        puts [format "#"]
        puts [format "# Fail:$gpn ->    data arrival max : %6f , min : %6f , group skew : %6f ,   require skew : %6f " $max_dar  $min_dar  [expr $max_dar  - $min_dar ]  $skew_req]
        puts [format "# captrure lat max : %6f , min : %6f , skew : %6f" $max_clat $min_clat [expr $max_clat - $min_clat]]
        puts [format "#"]
        puts [format "####################################################################################################"]
    }
}


proc tproc_stc_latency_report {stc_latency_list} {
    set_app_var timing_report_unconstrained_paths true

    set path_col_stc_latency ""
    set idx      0
    set latency_req 0
    set gpn      ""
    foreach {gp latency sp  ep th0 th1 } $stc_latency_list {
        if {$sp  == "None"} {set sp_line   ""} else {set sp_line  " -from     $sp  "}
        if {$ep  == "None"} {set ep_line   ""} else {set ep_line  " -to       $ep  "}
        if {$th0 == "None"} {set th0_line  ""} else {set th0_line " -through  $th0 "}
        if {$th1 == "None"} {set th1_line  ""} else {set th1_line " -through  $th1 "}
        append_to_collection path_col_stc_latency [ eval get_timing_paths $sp_line $th0_line $th1_line $ep_line -slack_lesser_than inf -max_path 100]
        set idx [expr $idx + 1]
        set latency_req $latency
        set gpn $gp

    }

    set max_dar  0
    set min_dar  100
    set max_clat 0
    set min_clat 100
    set max_slk  0
    set min_slk  100

    if {[sizeof_collection $path_col_stc_latency] == 0} { puts "Error: No path for $gp latency check, pls check "; return}
    foreach_in_collection path_col $path_col_stc_latency {
        set sp   [get_object_name [get_attribute   $path_col startpoint]]
        set ep   [get_object_name [get_attribute   $path_col endpoint]]
        
        set llat [get_attribute   $path_col startpoint_clock_latency]
        if {$llat == ""} {set llat 0.0}      
        #data arrival
        set dar  [get_attribute   $path_col  arrival]

        if {$dar > $max_dar} {set max_dar $dar}
        if {$dar < $min_dar} {set min_dar $dar}


        #endpoint_clock_latency
        set clat [get_attribute   $path_col endpoint_clock_latency]
        if {$clat == ""} {set clat 0.0}
        if {$clat > $max_clat} {set max_clat $clat}
        if {$clat < $min_clat} {set min_clat $clat}
        #slack
        set slk  [get_attribute   $path_col slack]
        puts [format "startpoint:%-50s  endpoint: %-50s  data arrival: %6f  startpoint clock latency : %6f  endpoint clock latency : %6f     slack: %6f" $sp $ep $dar $llat  $clat $slk]

    }
    set grp_latency  $max_dar 
    if {$grp_latency <= $latency_req} {
        puts [format ""]
        puts [format ""]
        puts [format "#######################  $gpn check    #############################################################"]
        puts [format "#"]
        puts [format "# Pass:$gpn ->    data arrival max : %6f , min : %6f , group latency : %6f ,   require latency  : %6f" $max_dar  $min_dar    $max_dar   $latency_req]
        puts [format "# captrure lat max : %6f , min : %6f , latency : %6f" $max_clat $min_clat [expr $max_clat - $min_clat]]
        puts [format "#"]
        puts [format "####################################################################################################"]
    } else {
        puts [format ""]
        puts [format ""]
        puts [format "#######################  $gpn check    #############################################################"]
        puts [format "#"]
        puts [format "# Fail:$gpn ->    data arrival max : %6f , min : %6f , group latency : %6f ,   require latency : %6f " $max_dar  $min_dar   $max_dar   $latency_req]
        puts [format "# captrure lat max : %6f , min : %6f , latency : %6f" $max_clat $min_clat [expr $max_clat - $min_clat]]
        puts [format "#"]
        puts [format "####################################################################################################"]
    }
}

set stc_skip_csv 1

proc tproc_stc_array2csv {stc_skew_list stc_csv} {
    global stc_skip_csv
    if {$stc_skip_csv} {return}
    set fo [open $stc_csv a]
    foreach {group value sp ep th0 th1} $stc_skew_list {
        if {$th0 == "None"} {set th0 " "} 
        if {$th1 == "None"} {set th1 " "} 
        puts $fo [join [list  $group $value $sp $ep $th0 $th1] ","]   
    }
    close $fo
}


if {!$stc_skip_csv} {
    set fo [open ./stc_check_skew.csv w]
    puts $fo "group_name,skew_value,startpoint,endpiont,through0,through1"
    close $fo
    
    set fo [open ./stc_check_latency.csv w]
    puts $fo "group_name,latency_value,startpoint,endpiont,through0,through1"
    close $fo
}

set tlbs_output_list [list \
    tlbs_output 2 u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_rdat_out_reg_0_/CP     SPI2_MISO None None \
    tlbs_output 2 u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_rdat_out_reg_1_/CP     SPI2_MOSI None None \
    tlbs_output 2 u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_rdat_out_reg_2_/CP     KEYIN1    None None \
    tlbs_output 2 u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_rdat_out_reg_3_/CP     KEYOUT1   None None \
    tlbs_output 2 u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_rdat_vld_reg/CP        SPI2_MISO None None \
    tlbs_output 2 u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_rdat_vld_reg/CP        SPI2_MOSI None None \
    tlbs_output 2 u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_rdat_vld_reg/CP        KEYIN1    None None \
    tlbs_output 2 u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_rdat_vld_reg/CP        KEYOUT1   None None \
]

tproc_stc_skew_report $tlbs_output_list
tproc_stc_array2csv   $tlbs_output_list stc_check_skew.csv

set tlbs_input_list [list \
    tlbs_input 2 SPI2_CSN    u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_cs_n_buf_reg/D    None None \
    tlbs_input 2 SPI2_MISO   u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_wdat_in_reg_0_/D  None None \
    tlbs_input 2 SPI2_MOSI   u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_wdat_in_reg_1_/D  None None \
    tlbs_input 2 KEYIN1      u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_wdat_in_reg_2_/D  None None \
    tlbs_input 2 KEYOUT1     u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_wdat_in_reg_3_/D  None None \
    tlbs_input 2 SPI2_CLK    u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_cs_n_buf_reg/D    None None \
    tlbs_input 2 SPI2_CLK    u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_wdat_in_reg_0_/D  None None \
    tlbs_input 2 SPI2_CLK    u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_wdat_in_reg_1_/D  None None \
    tlbs_input 2 SPI2_CLK    u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_wdat_in_reg_2_/D  None None \
    tlbs_input 2 SPI2_CLK    u_digital_top/u_dbg_sys_top/u_tlb2ahb_top/tlb_wdat_in_reg_3_/D  None None \
]

tproc_stc_skew_report $tlbs_input_list
tproc_stc_array2csv   $tlbs_input_list stc_check_skew.csv

set auxadc_neg_list [list \
auxadc_neg 10 u_analog_top/auxadc_clk u_digital_top/u_analog_dm_core_wrap/u_analog_auxadc_test_ctrl/auxadc_data_valid_buf_neg_reg/D None None \
auxadc_neg 10 u_analog_top/auxadc_clk u_digital_top/u_analog_dm_core_wrap/u_analog_auxadc_test_ctrl/auxadc_data_buf_neg_reg_*_/D None None \
auxadc_neg 10 u_analog_top/auxadc_data_valid    u_digital_top/u_analog_dm_core_wrap/u_analog_auxadc_test_ctrl/auxadc_data_valid_buf_neg_reg/D None None \
auxadc_neg 10 u_analog_top/auxadc_data[*]        u_digital_top/u_analog_dm_core_wrap/u_analog_auxadc_test_ctrl/auxadc_data_buf_neg_reg_*_/D None None \
]

tproc_stc_skew_report $auxadc_neg_list
tproc_stc_array2csv   $auxadc_neg_list stc_check_skew.csv


set auxadc_pos_list [list \
auxadc_pos 10 u_analog_top/auxadc_clk        u_digital_top/u_analog_dm_core_wrap/u_analog_auxadc_test_ctrl/auxadc_data_valid_buf_reg/D  None None \
auxadc_pos 10 u_analog_top/auxadc_clk        u_digital_top/u_analog_dm_core_wrap/u_analog_auxadc_test_ctrl/auxadc_data_buf_reg_*_/D     None None \
auxadc_pos 10 u_analog_top/auxadc_data_valid u_digital_top/u_analog_dm_core_wrap/u_analog_auxadc_test_ctrl/auxadc_data_valid_buf_reg/D  None None \
auxadc_pos 10 u_analog_top/auxadc_data[*]    u_digital_top/u_analog_dm_core_wrap/u_analog_auxadc_test_ctrl/auxadc_data_buf_reg_*_/D     None None \
]

tproc_stc_skew_report $auxadc_pos_list
tproc_stc_array2csv   $auxadc_pos_list stc_check_skew.csv

#------------------------------------------
#i2c0
#------------------------------------------
set i2c0_output_list [list \
    i2c0_output 15 u_digital_top/u_topsys_peri_wrap/u_top_i2c0/i_cdnsi2c_if/sda_enable_reg/CP     $func_pad_names(iic0_sda) None None \
    i2c0_output 15 u_digital_top/u_topsys_peri_wrap/u_top_i2c0/i_cdnsi2c_if/scl_enable_reg/CP     $func_pad_names(iic0_sck) None None \
]

tproc_stc_skew_report $i2c0_output_list
tproc_stc_array2csv   $i2c0_output_list stc_check_skew.csv

set i2c0_input_list [list \
    i2c0_input 15 $func_pad_names(iic0_sda)   u_digital_top/u_topsys_peri_wrap/u_top_i2c0/i_cdnsi2c_syncprotect/i_cdn_syncflop_sda/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D  None None \
    i2c0_input 15 $func_pad_names(iic0_sck)   u_digital_top/u_topsys_peri_wrap/u_top_i2c0/i_cdnsi2c_syncprotect/i_cdn_syncflop_scl/gen_sync_0__inst_async_reset_i_cdns_syncflop/cmind_sync_buf2_bit2_0__genblk1_sync2_rst0_sig_in_sync0_reg/cmind_uj_cell/D  None None \
]

tproc_stc_skew_report $i2c0_input_list
tproc_stc_array2csv   $i2c0_input_list stc_check_skew.csv


