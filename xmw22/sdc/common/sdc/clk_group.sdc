##############################################################
foreach clk_list [array names CLOCK_GROUP] {
    set_clock_groups -asynchronous -name clock_async_$clk_list \
        -group [get_clocks $CLOCK_GROUP($clk_list)]
}

if {[info exist CLOCK_GROUP_1] && [llength [array names CLOCK_GROUP_1]]>1} {
    set cmd_tmp "set_clock_groups -logically_exclusive "
    foreach clk_list [array names CLOCK_GROUP_1] {
        set cmd_tmp "$cmd_tmp -group \[get_clocks {$CLOCK_GROUP_1($clk_list)}]"
    }
    eval $cmd_tmp
}
    
