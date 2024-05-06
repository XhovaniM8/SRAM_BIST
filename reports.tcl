# Set the module name (replace with the actual name)
set module_name muxd

# Timing Analysis
set timing_report "${module_name}_timing_worst_25.rpt"
report_timing -nworst 25 > $timing_report

# Timing Analysis
set timing_report "${module_name}_timing.rpt"
report_timing > $timing_report

# Power Analysis
set power_report "${module_name}_power.rpt"
report_power > $power_report

# Area Analysis
set area_report "${module_name}_area.rpt"
report_area > $area_report

# Quality of Results (QoR) Analysis
set qor_report "${module_name}_qor.rpt"
report_qor > $qor_report

# Export the synthesized design
set design_file "${module_name}_synthesized_design.v"
write -format verilog -hierarchy -output $design_filou