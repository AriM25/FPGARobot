set_property IOSTANDARD LVCMOS33 [get_ports fpgaclk]
set_property PACKAGE_PIN L1 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports echo]
set_property PACKAGE_PIN C15 [get_ports trigger]
set_property IOSTANDARD LVCMOS33 [get_ports trigger]
create_clock -period 20.000 -name fpgaclk -waveform {0.000 10.000} [get_ports fpgaclk]

set_property PACKAGE_PIN W5 [get_ports fpgaclk]


set_property PACKAGE_PIN A14 [get_ports Motor_L_pwm]
set_property PACKAGE_PIN A15 [get_ports Motor_L_in_1]
set_property PACKAGE_PIN A16 [get_ports Motor_L_in_2]
set_property IOSTANDARD LVCMOS33 [get_ports Motor_L_in_1]
set_property IOSTANDARD LVCMOS33 [get_ports Motor_L_in_2]
set_property IOSTANDARD LVCMOS33 [get_ports Motor_L_pwm]
set_property PACKAGE_PIN A17 [get_ports Motor_R_pwm]
set_property IOSTANDARD LVCMOS33 [get_ports Motor_R_pwm]
set_property IOSTANDARD LVCMOS33 [get_ports Motor_R_in_3]
set_property PACKAGE_PIN B16 [get_ports Motor_R_in_4]
set_property IOSTANDARD LVCMOS33 [get_ports Motor_R_in_4]

set_property PACKAGE_PIN B15 [get_ports Motor_R_in_3]

set_property PACKAGE_PIN C16 [get_ports echo]
