if (![info exist freq_factor]) {
    set freq_factor 1.0
}
puts "synthesis clock period margin $freq_factor"

#set FREQ_491M52  [expr 491.52 * $freq_factor]
##set FREQ_307M2   [expr 307.2 * $freq_factor]
#set FREQ_204M8   [expr 204.8 * $freq_factor]
#set FREQ_100M    [expr 100.0 * $freq_factor]
#set FREQ_52M     [expr 52.0 * $freq_factor]
#set FREQ_32K     [expr 0.032768 * $freq_factor]

###1228.8M##################################
set CYCLE_1228M8 [expr 0.812 * $freq_factor]            

set CYCLE_491M52 [expr $CYCLE_1228M8 * 2.5]
set CYCLE_245M76 [expr $CYCLE_491M52 * 2]
set CYCLE_122M88 [expr $CYCLE_245M76 * 2]
set CYCLE_81M92  [expr $CYCLE_245M76 * 3]
set CYCLE_61M44  [expr $CYCLE_122M88 * 2]
set CYCLE_30M72  [expr $CYCLE_61M44 * 2]
set CYCLE_15M36  [expr $CYCLE_30M72 * 2]
set CYCLE_12M288 [expr $CYCLE_122M88 * 10]
set CYCLE_10M24  [expr $CYCLE_30M72 * 3]
set CYCLE_7M68   [expr $CYCLE_15M36 * 2]
set CYCLE_5M12   [expr $CYCLE_10M24 * 2]
set CYCLE_3M84   [expr $CYCLE_7M68 * 2]
set CYCLE_2M56   [expr $CYCLE_5M12 * 2]
set CYCLE_1M92   [expr $CYCLE_3M84 * 2]

set CYCLE_307M2  [expr $CYCLE_1228M8 * 4]
set CYCLE_153M6  [expr $CYCLE_307M2 * 2]
set CYCLE_76M8   [expr $CYCLE_153M6 * 2]
set CYCLE_19M2   [expr $CYCLE_76M8 * 4]

set CYCLE_409M6  [expr $CYCLE_1228M8 * 3]
set CYCLE_204M8  [expr $CYCLE_409M6 * 2]
set CYCLE_102M4  [expr $CYCLE_204M8 * 2]
set CYCLE_51M2   [expr $CYCLE_102M4 * 2]
set CYCLE_25M6   [expr $CYCLE_51M2 * 2]

###480M####################################
set CYCLE_480M   [expr 2.082 * $freq_factor]   
set CYCLE_60M   [expr $CYCLE_480M * 8]

###52M#####################################
set CYCLE_52M    [expr 19.230 * $freq_factor]

set CYCLE_26M    [expr $CYCLE_52M * 2]
set CYCLE_3M25   [expr $CYCLE_26M * 8]

###32K#####################################
#set CYCLE_32K    [expr 30517.578 * $freq_factor]
set CYCLE_32K    [expr 15625.0 * $freq_factor]
set CYCLE_15K    [expr $CYCLE_32K * 2]

###100M#####################################
set CYCLE_100M   [expr 10.0 * $freq_factor]

set CYCLE_50M    [expr $CYCLE_100M * 2]
set CYCLE_20M    [expr $CYCLE_100M * 5]
set CYCLE_1M     [expr $CYCLE_20M * 20]
set CYCLE_500K   [expr $CYCLE_1M * 2]
set CYCLE_100K   [expr $CYCLE_1M * 10]

### DFT ####################################
set CYCLE_SCAN   $CYCLE_52M
set WAVEF_SCAN   [list 10 15]

set CYCLE_DC     $CYCLE_26M
set WAVEF_DC     [list 10 20]
##############################################
####CKOUTZ_HIER: ckout hier for mux/or
set CKOUTZ_HIER "u_cmind_cell_ckout/cmind_uj_ckcell/Z"

####CKOUTQ_HIER: ckout hier for icg
set CKOUTQ_HIER "u_cmind_cell_ckout/cmind_uj_ckcell/Q"
