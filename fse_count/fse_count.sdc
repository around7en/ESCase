set period(clk) 1

create_clock [get_ports clk] -name clk -period $period(clk)

set_input_delay -max [expr 0.4*$period(clk)] -clock clk [all_inputs]
set_input_delay -min [expr 0*$period(clk)] -clock clk [all_inputs]
set_output_delay -max [expr 0.4*$period(clk)] -clock clk [all_outputs]
set_output_delay -min [expr 0*$period(clk)] -clock clk [all_outputs]

set_false_path -from [get_ports rst]
