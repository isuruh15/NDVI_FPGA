-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Thu Sep 12 15:13:21 2019
-- Host        : DESKTOP-N9SHNS0 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               F:/UOM/Semester7/FYP/NDVI_Camera/PickTea/HOME2_C1/VIVADO/lab2_home/lab2_home.srcs/sources_1/ip/AXI4Stream_RS232_0/AXI4Stream_RS232_0_stub.vhdl
-- Design      : AXI4Stream_RS232_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AXI4Stream_RS232_0 is
  Port ( 
    clk_uart : in STD_LOGIC;
    rst : in STD_LOGIC;
    RS232_TX : out STD_LOGIC;
    RS232_RX : in STD_LOGIC;
    m00_axis_rx_aclk : in STD_LOGIC;
    m00_axis_rx_aresetn : in STD_LOGIC;
    m00_axis_rx_tvalid : out STD_LOGIC;
    m00_axis_rx_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m00_axis_rx_tready : in STD_LOGIC;
    s00_axis_tx_aclk : in STD_LOGIC;
    s00_axis_tx_aresetn : in STD_LOGIC;
    s00_axis_tx_tready : out STD_LOGIC;
    s00_axis_tx_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s00_axis_tx_tvalid : in STD_LOGIC
  );

end AXI4Stream_RS232_0;

architecture stub of AXI4Stream_RS232_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_uart,rst,RS232_TX,RS232_RX,m00_axis_rx_aclk,m00_axis_rx_aresetn,m00_axis_rx_tvalid,m00_axis_rx_tdata[7:0],m00_axis_rx_tready,s00_axis_tx_aclk,s00_axis_tx_aresetn,s00_axis_tx_tready,s00_axis_tx_tdata[7:0],s00_axis_tx_tvalid";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "AXI4Stream_RS232_v1_0,Vivado 2017.3";
begin
end;
