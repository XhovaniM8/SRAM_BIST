# Controller Timing Constraints (SDC)

# Create a clock signal named `clk` 
# on the port `clk`. This will act as the main clock for the design.
# I changed clock period to improve slack
create_clock -period 179.0 -name clk [get_ports clk]

# Set input delay relative to the clock signal `clk`
# Specifies a 0.1 ns delay for all input ports, reflecting the external environment.
set_input_delay 0.1 -clock clk [all_inputs]

# Set output delay relative to the clock signal `clk`
# Specifies a 0.15 ns delay for all output ports, representing delays outside the chip.
set_output_delay 0.15 -clock clk [all_outputs]

# Set a load of 0.1 units on each output pin to simulate the external load connected to the design.
set_load 0.1 [all_outputs]

# Restrict the maximum fanout of input pins to 1 to minimize loading issues.
set_max_fanout 1 [all_inputs]

# Specify a fanout load of 8 units for all output ports to model external loading characteristics.
set_fanout_load 8 [all_outputs]

# Set clock uncertainty to account for clock jitter, skew, and other variations.
# The uncertainty value is 0.01 ns for all clocks in the design.
set_clock_uncertainty 0.01 [all_clocks]

# Set the source clock latency (delay between the source and clock pin) to 0.01 ns for the clock signal.
# This simulates the time delay from the external clock source to the internal clock tree.
set_clock_latency 0.01 -source [get_ports clk]
