set_units -capacitance 1000fF
set_units -time 1000ps

set period 5

create_clock -name "clk" -period $period -waveform "0 [expr $period / 2]" [get_ports clk]
set_clock_gating_check -setup 0.0

set_input_delay  -clock [get_clocks clk] -add_delay [expr $period * 0.5] [get_ports -filter direction==in]
set_output_delay -clock [get_clocks clk] -add_delay [expr $period * 0.5] [get_ports -filter direction==out]

