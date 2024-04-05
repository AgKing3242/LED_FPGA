set_property IOSTANDARD LVCMOS18 [get_ports {led_array[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_array[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_array[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_array[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_array[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_array[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_array[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {led_array[0]}]
set_property PACKAGE_PIN U14 [get_ports {led_array[7]}]
set_property PACKAGE_PIN U19 [get_ports {led_array[6]}]
set_property PACKAGE_PIN W22 [get_ports {led_array[5]}]
set_property PACKAGE_PIN V22 [get_ports {led_array[4]}]
set_property PACKAGE_PIN U21 [get_ports {led_array[3]}]
set_property PACKAGE_PIN U22 [get_ports {led_array[2]}]
set_property PACKAGE_PIN T21 [get_ports {led_array[1]}]
set_property PACKAGE_PIN T22 [get_ports {led_array[0]}]
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS18 [get_ports clk]
set_property PACKAGE_PIN F22 [get_ports reset]
set_property PACKAGE_PIN N15 [get_ports sel]

create_clock -period 10.000 -name clk -waveform {0.000 5.000} clk


set_property IOSTANDARD LVCMOS18 [get_ports reset]
set_property IOSTANDARD LVCMOS18 [get_ports sel]




