create_clock -name {pixclk} -period 6.73401 -waveform {0 3.367 } [ get_ports { pixel_clk_i } ]
create_clock -name {ddrclk} -period 5 -waveform {0 2.5 } [ get_ports { ddr_clk_i } ]
