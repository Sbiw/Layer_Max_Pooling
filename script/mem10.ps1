#Header
Write-Output "Start VHDL script"

# Configuration
$src_list_file="packageMem.vhd","mem10.vhd"
$tb_list_file="mem10_tb.vhd"
$test_bench_entity_name="mem10_tb"

##################################################################
# Body
##################################################################

# Modelsim initialization
vlib ../modelsim/work
vmap ../modelsim/work

# Compilation VHDL file
# SRC file compilation

foreach ($src_file in $src_list_file) {
	vcom -reportprogress 300 -work ../modelsim/work ../src/${src_file}
}

# TB compilation
foreach ($tb_file in $tb_list_file) {
	vcom -reportprogress 300 -work ../modelsim/work ../tb/${tb_file}
}

vsim ../modelsim/work.${test_bench_entity_name}

##################################################################
# vorrei far partire add wave del dut e stoppare la simulazione
##################################################################

#add wave -position insertpoint  \
#sim:/mem10_tb/dut/clk \
#sim:/mem10_tb/dut/d \
#sim:/mem10_tb/dut/q1 \
#sim:/mem10_tb/dut/q2 \
#sim:/mem10_tb/dut/q3 \
#sim:/mem10_tb/dut/q4 \
#sim:/mem10_tb/dut/j \
#sim:/mem10_tb/dut/k

#run -all # fa partire la simulazione nella wave