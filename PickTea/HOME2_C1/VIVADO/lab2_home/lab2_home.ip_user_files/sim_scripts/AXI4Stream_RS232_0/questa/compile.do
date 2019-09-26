vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv \
"C:/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"C:/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2017.3/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../lab2_home.srcs/sources_1/ip/AXI4Stream_RS232_0/hdl/AXI4Stream_RS232_v1_0_M00_AXIS_RX.vhd" \
"../../../../lab2_home.srcs/sources_1/ip/AXI4Stream_RS232_0/hdl/AXI4Stream_RS232_v1_0_S00_AXIS_TX.vhd" \
"../../../../lab2_home.srcs/sources_1/ip/AXI4Stream_RS232_0/hdl/AXI4Stream_RS232_v1_0.vhd" \
"../../../../lab2_home.srcs/sources_1/ip/AXI4Stream_RS232_0/hdl/UART_Engine.vhd" \
"../../../../lab2_home.srcs/sources_1/ip/AXI4Stream_RS232_0/hdl/RS232_Manager.vhd" \
"../../../../lab2_home.srcs/sources_1/ip/AXI4Stream_RS232_0/sim/AXI4Stream_RS232_0.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

