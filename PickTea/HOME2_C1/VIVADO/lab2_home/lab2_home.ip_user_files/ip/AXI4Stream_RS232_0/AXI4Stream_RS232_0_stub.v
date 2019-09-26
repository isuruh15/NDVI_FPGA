// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu Sep 12 15:13:21 2019
// Host        : DESKTOP-N9SHNS0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               F:/UOM/Semester7/FYP/NDVI_Camera/PickTea/HOME2_C1/VIVADO/lab2_home/lab2_home.srcs/sources_1/ip/AXI4Stream_RS232_0/AXI4Stream_RS232_0_stub.v
// Design      : AXI4Stream_RS232_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "AXI4Stream_RS232_v1_0,Vivado 2017.3" *)
module AXI4Stream_RS232_0(clk_uart, rst, RS232_TX, RS232_RX, 
  m00_axis_rx_aclk, m00_axis_rx_aresetn, m00_axis_rx_tvalid, m00_axis_rx_tdata, 
  m00_axis_rx_tready, s00_axis_tx_aclk, s00_axis_tx_aresetn, s00_axis_tx_tready, 
  s00_axis_tx_tdata, s00_axis_tx_tvalid)
/* synthesis syn_black_box black_box_pad_pin="clk_uart,rst,RS232_TX,RS232_RX,m00_axis_rx_aclk,m00_axis_rx_aresetn,m00_axis_rx_tvalid,m00_axis_rx_tdata[7:0],m00_axis_rx_tready,s00_axis_tx_aclk,s00_axis_tx_aresetn,s00_axis_tx_tready,s00_axis_tx_tdata[7:0],s00_axis_tx_tvalid" */;
  input clk_uart;
  input rst;
  output RS232_TX;
  input RS232_RX;
  input m00_axis_rx_aclk;
  input m00_axis_rx_aresetn;
  output m00_axis_rx_tvalid;
  output [7:0]m00_axis_rx_tdata;
  input m00_axis_rx_tready;
  input s00_axis_tx_aclk;
  input s00_axis_tx_aresetn;
  output s00_axis_tx_tready;
  input [7:0]s00_axis_tx_tdata;
  input s00_axis_tx_tvalid;
endmodule
