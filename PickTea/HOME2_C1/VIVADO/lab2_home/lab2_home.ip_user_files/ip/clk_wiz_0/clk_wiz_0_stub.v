// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Wed Sep 18 20:25:28 2019
// Host        : DESKTOP-N9SHNS0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               F:/UOM/Semester7/FYP/NDVI_Camera/PickTea/HOME2_C1/VIVADO/lab2_home/lab2_home.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(CLK100MHz, CLK25MHz, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="CLK100MHz,CLK25MHz,reset,locked,clk_in1" */;
  output CLK100MHz;
  output CLK25MHz;
  input reset;
  output locked;
  input clk_in1;
endmodule
