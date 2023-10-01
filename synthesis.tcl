file mkdir ./syn
file mkdir ./work
define_design_lib WORK -path ./work
#analyze -format sverilog  {./top.sv}
#elaborate top
analyze -format sverilog {
./src/butterfly.sv \
./src/radix2_bf_v2.sv \
./src/radix4_bf.sv \
./src/radix4_l1_bf.sv \
./src/radix4_l2_bf.sv \
./src/radix4_l3_bf.sv \
./src/reduce.sv \
./src/mul_quarter.sv \
}

elaborate butterfly

uplevel #0 source ./DC.sdc
#compile -exact_map
compile_ultra

#set_clock_gating_style -sequential_cell latch
#compile_ultra  -gate_clock -scan
#compile -exact_map -gate_clock -scan

uplevel #0 { report_area }
write_file -format verilog -hier -output ./syn/butterfly_syn.v

write_sdf -version 2.1  ./syn/butterfly_syn.sdf
write -hierarchy -format ddc -output ./syn/butterfly_syn.ddc
report_timing > ./syn/timing.log
report_area > ./syn/area.log
