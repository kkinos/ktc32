# CLOCK
# 12MHz
set_property -dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS33 } [get_ports { clk }]; 
create_clock -add -name sys_clk_pin -period 83.333 -waveform {0 41.667} [get_ports { clk }];
# 100MHz
# set_property -dict { PACKAGE_PIN R2    IOSTANDARD SSTL135 } [get_ports { clk }];
# create_clock -add -name sys_clk_pin -period 10.000 -waveform {0 5.000}  [get_ports { clk }];

# LED
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports {led[0]}];
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports {led[1]}];
set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVCMOS33} [get_ports {led[2]}];
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {led[3]}];

# RESET
set_property -dict {PACKAGE_PIN C18 IOSTANDARD LVCMOS33} [get_ports {n_reset}];

# UART
set_property -dict { PACKAGE_PIN R12   IOSTANDARD LVCMOS33 } [get_ports { txd }];
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { rxd }];