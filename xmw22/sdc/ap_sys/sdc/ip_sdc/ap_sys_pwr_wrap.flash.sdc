if {! $IS_CHIP} {
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports qspi_cs_n_o]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports qspi_do_o]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports qspi_do_en_o]
    set_input_delay  [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports qspi_di_i]
    #fall edge
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports qspi_cs_n_o]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports qspi_do_o]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports qspi_do_en_o]
    set_input_delay  [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports qspi_di_i]

    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_cs_n_o]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_do_o\[2\]]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_do_o\[1\]]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_do_o\[0\]]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_sck_o]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_sck_en_o]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_do_en_o]
    set_input_delay  [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_di_i\[2\]]
    set_input_delay  [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_di_i\[1\]]
    set_input_delay  [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_di_i\[0\]]
    set_input_delay  [expr 0.25 * $CYCLE_307M2] -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_sck_i]
    #fall edge
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_cs_n_o]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_do_o\[2\]]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_do_o\[1\]]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_do_o\[0\]]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_sck_o]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_sck_en_o]
    set_output_delay [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_do_en_o]
    set_input_delay  [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_di_i\[2\]]
    set_input_delay  [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_di_i\[1\]]
    set_input_delay  [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_di_i\[0\]]
    set_input_delay  [expr 0.25 * $CYCLE_307M2] -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_sck_i]

    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports qspi_cs_n_o]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports qspi_do_o]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports qspi_do_en_o]
    set_input_delay  [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports qspi_di_i]
    #fall edge
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports qspi_cs_n_o]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports qspi_do_o]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports qspi_do_en_o]
    set_input_delay  [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports qspi_di_i]
                                                  
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_cs_n_o]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_do_o\[2\]]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_do_o\[1\]]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_do_o\[0\]]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_sck_o]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_sck_en_o]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_do_en_o]
    set_input_delay  [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_di_i\[2\]]
    set_input_delay  [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_di_i\[1\]]
    set_input_delay  [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_di_i\[0\]]
    set_input_delay  [expr 0.05 * $CYCLE_307M2] -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports qspi_sck_i]
    #fall edge
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_cs_n_o]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_do_o\[2\]]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_do_o\[1\]]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_do_o\[0\]]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_sck_o]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_sck_en_o]
    set_output_delay [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_do_en_o]
    set_input_delay  [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_di_i\[2\]]
    set_input_delay  [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_di_i\[1\]]
    set_input_delay  [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_di_i\[0\]]
    set_input_delay  [expr 0.05 * $CYCLE_307M2] -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports qspi_sck_i]
} else {
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_cs_n)];#QSPICSn, change 5ns to 1 cycle, guaranteed by design 
    set_output_delay  0.6   -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_cs_n)];#QSPICSn, change 5ns to 1 cycle, guaranteed by design
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDO
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDO
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDO
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d3_sck)];#QSPIDO
    set_output_delay -2   -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDO
    set_output_delay -2   -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDO
    set_output_delay -2   -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDO
    set_output_delay -2   -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d3_sck)];#QSPIDO
    set_input_delay   7   -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDI, 7-2cycle=3ns, guaranteed by design sample point delay
    set_input_delay   7   -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDI, 7-2cycle=3ns, guaranteed by design sample point delay
    set_input_delay   7   -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDI, 7-2cycle=3ns, guaranteed by design sample point delay
    set_input_delay   7   -max -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d3_sck)];#QSPIDI, 7-2cycle=3ns, guaranteed by design sample point delay
    set_input_delay   1.5 -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDI 
    set_input_delay   1.5 -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDI
    set_input_delay   1.5 -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDI
    set_input_delay   1.5 -min -clock ${AP_SYS_NAME}_QSPI_SCK -add_delay [get_ports $func_pad_names(qspi_d3_sck)];#QSPIDI
    #fall edge
    set_output_delay  2   -max -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDO
    set_output_delay  2   -max -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDO
    set_output_delay  2   -max -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDO
    set_output_delay  2   -max -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d3_sck)];#QSPIDO
    set_output_delay -2   -min -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDO
    set_output_delay -2   -min -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDO
    set_output_delay -2   -min -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDO
    set_output_delay -2   -min -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d3_sck)];#QSPIDO
    set_input_delay   7   -max -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDI, guaranteed by design sample point delay
    set_input_delay   7   -max -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDI, guaranteed by design sample point delay
    set_input_delay   7   -max -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDI, guaranteed by design sample point delay
    set_input_delay   7   -max -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d3_sck)];#QSPIDI, guaranteed by design sample point delay
    set_input_delay   1.5 -min -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDI
    set_input_delay   1.5 -min -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDI
    set_input_delay   1.5 -min -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDI
    set_input_delay   1.5 -min -clock  ${AP_SYS_NAME}_QSPI_SCK -clock_fall -add_delay [get_ports $func_pad_names(qspi_d3_sck)];#QSPIDI


    set_output_delay  2   -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_cs_n)];#QSPICSn, change 5ns to 1 cycle, guaranteed by design 
    set_output_delay 0.6   -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_cs_n)];#QSPICSn, change 5ns to 1 cycle, guaranteed by design
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDO
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDO
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDO
    set_output_delay  2   -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_sck_d3)];#QSPIDO
    set_output_delay -2   -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDO
    set_output_delay -2   -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDO
    set_output_delay -2   -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDO
    set_output_delay -2   -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_sck_d3)];#QSPIDO
    set_input_delay   7   -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDI, 7-2cycle=3ns, guaranteed by design sample point delay
    set_input_delay   7   -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDI, 7-2cycle=3ns, guaranteed by design sample point delay
    set_input_delay   7   -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDI, 7-2cycle=3ns, guaranteed by design sample point delay
    set_input_delay   7   -max -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_sck_d3)];#QSPIDI, 7-2cycle=3ns, guaranteed by design sample point delay
    set_input_delay   1.5 -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDI 
    set_input_delay   1.5 -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDI
    set_input_delay   1.5 -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDI
    set_input_delay   1.5 -min -clock ${AP_SYS_NAME}_QSPI_SCK_D3 -add_delay [get_ports $func_pad_names(qspi_sck_d3)];#QSPIDI
    #fall edge
    set_output_delay  2   -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDO
    set_output_delay  2   -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDO
    set_output_delay  2   -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDO
    set_output_delay  2   -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_sck_d3)];#QSPIDO
    set_output_delay -2   -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDO
    set_output_delay -2   -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDO
    set_output_delay -2   -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDO
    set_output_delay -2   -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_sck_d3)];#QSPIDO
    set_input_delay   7   -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDI, guaranteed by design sample point delay
    set_input_delay   7   -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDI, guaranteed by design sample point delay
    set_input_delay   7   -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDI, guaranteed by design sample point delay
    set_input_delay   7   -max -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_sck_d3)];#QSPIDI, guaranteed by design sample point delay
    set_input_delay   1.5 -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_d0)];#QSPIDI
    set_input_delay   1.5 -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_d1)];#QSPIDI
    set_input_delay   1.5 -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_d2)];#QSPIDI
    set_input_delay   1.5 -min -clock  ${AP_SYS_NAME}_QSPI_SCK_D3 -clock_fall -add_delay [get_ports $func_pad_names(qspi_sck_d3)];#QSPIDI


    #set_multicycle_path  5 -setup -end -from SF0_SCK -to [get_clocks ${AP_SYS_NAME}_clk_spi_flash] -th u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_qspi_sck_d3/cmind_uj_ckcell/I0
    #set_multicycle_path  4 -hold -end -from SF0_SCK -to [get_clocks ${AP_SYS_NAME}_clk_spi_flash] -th u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_qspi_sck_d3/cmind_uj_ckcell/I0
    #set_multicycle_path  5 -setup -end -from SF0_IO3 -to [get_clocks ${AP_SYS_NAME}_clk_spi_flash] -th u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_qspi_d3_sck/cmind_uj_cell/I0 
    #set_multicycle_path  4 -hold -end -from SF0_IO3 -to [get_clocks ${AP_SYS_NAME}_clk_spi_flash] -th u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_qspi_d3_sck/cmind_uj_cell/I0
    #set_multicycle_path  5 -setup -end -from SF0_IO1 -to [get_clocks ${AP_SYS_NAME}_clk_spi_flash] -th u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_qspi_d1/cmind_uj_cell/I0 
    #set_multicycle_path  4 -hold -end -from SF0_IO1 -to [get_clocks ${AP_SYS_NAME}_clk_spi_flash] -th u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_qspi_d1/cmind_uj_cell/I0
    #set_multicycle_path  5 -setup -end -from SF0_IO0 -to [get_clocks ${AP_SYS_NAME}_clk_spi_flash] -th u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_qspi_d0/cmind_uj_cell/I0
    #set_multicycle_path  4 -hold -end -from SF0_IO0 -to [get_clocks ${AP_SYS_NAME}_clk_spi_flash] -th u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_qspi_d0/cmind_uj_cell/I0
    #set_multicycle_path  5 -setup -end -from SF0_IO2 -to [get_clocks ${AP_SYS_NAME}_clk_spi_flash] -th u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_qspi_d2/cmind_uj_cell/I0
    #set_multicycle_path  4 -hold -end -from SF0_IO2 -to [get_clocks ${AP_SYS_NAME}_clk_spi_flash] -th u_digital_top/u_io_top/u_io_group_digital_mux/u_mux2_qspi_d2/cmind_uj_cell/I0

   set_multicycle_path 1     -setup -start -from [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]     -to $func_pad_names(qspi_sck_d3)
   set_multicycle_path 1     -hold  -start -from [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]     -to $func_pad_names(qspi_sck_d3)
   set_multicycle_path 1     -setup -start -from [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]     -to $func_pad_names(qspi_d3_sck)
   set_multicycle_path 1     -hold  -start -from [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]     -to $func_pad_names(qspi_d3_sck)
   set_multicycle_path 1     -setup -start -from [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]     -to $func_pad_names(qspi_d0)
   set_multicycle_path 1     -hold  -start -from [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]     -to $func_pad_names(qspi_d0)
   set_multicycle_path 1     -setup -start -from [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]     -to $func_pad_names(qspi_d1)
   set_multicycle_path 1     -hold  -start -from [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]     -to $func_pad_names(qspi_d1)
   set_multicycle_path 1     -setup -start -from [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]     -to $func_pad_names(qspi_d2)
   set_multicycle_path 1     -hold  -start -from [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]     -to $func_pad_names(qspi_d2)


   set_multicycle_path  5 -setup -end -from $func_pad_names(qspi_sck_d3) -to [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]
   set_multicycle_path  4 -hold  -end -from $func_pad_names(qspi_sck_d3) -to [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]
   set_multicycle_path  5 -setup -end -from $func_pad_names(qspi_d3_sck) -to [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]
   set_multicycle_path  4 -hold  -end -from $func_pad_names(qspi_d3_sck) -to [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]
   set_multicycle_path  5 -setup -end -from $func_pad_names(qspi_d0)     -to [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]
   set_multicycle_path  4 -hold  -end -from $func_pad_names(qspi_d0)     -to [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]
   set_multicycle_path  5 -setup -end -from $func_pad_names(qspi_d1)     -to [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]
   set_multicycle_path  4 -hold  -end -from $func_pad_names(qspi_d1)     -to [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]
   set_multicycle_path  5 -setup -end -from $func_pad_names(qspi_d2)     -to [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]
   set_multicycle_path  4 -hold  -end -from $func_pad_names(qspi_d2)     -to [get_clocks ${AP_LIB_HIER}${AP_SYS_NAME}_clk_spi_flash]
if {$IS_FLAT} {    
   set_multicycle_path  2 -setup -end -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_apb/d23_force_en_reg/CP -to [get_clocks ${AP_SYS_NAME}_QSPI_SCK]
   set_multicycle_path  1 -hold -end -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_apb/d23_force_en_reg/CP -to [get_clocks ${AP_SYS_NAME}_QSPI_SCK]
   set_multicycle_path  2 -setup -end -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_apb/d23_force_en_reg/CP -to [get_clocks ${AP_SYS_NAME}_QSPI_SCK_D3]
   set_multicycle_path  1 -hold -end -from u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_apb/d23_force_en_reg/CP -to [get_clocks ${AP_SYS_NAME}_QSPI_SCK_D3]
   #set_false_path -th u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/u_buf_cr_sckscale_eq0/cmind_uj_cell/Z
   set_case_analysis 0 u_digital_top/u_ap_sys_pwr_wrap/u_ap_sys_top/u_qspi_flashc/u_qspi_flashc_fsm/u_clk_ckmux2/cmind_uj_ckcell/S
   }
}
