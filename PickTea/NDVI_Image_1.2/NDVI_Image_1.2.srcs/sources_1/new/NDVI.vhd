----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/22/2019 11:18:32 AM
-- Design Name: 
-- Module Name: RGB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NDVI is
  Port ( 
    clock: in std_logic;
    addrInRAM: in std_logic_vector(6 downto 0);  --ram addres
    addrOutRAM: in std_logic_vector(6 downto 0)  --ram addres - out
  );
end NDVI;

architecture Behavioral of NDVI is


COMPONENT blk_mem_gen_img
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END COMPONENT;

component clk_wiz_base
	port (
	clk_in1    :in std_logic;
	reset:in std_logic;
	locked :out std_logic;
    clk_out1         : out     std_logic;
    -- Clock out ports
    clk_out2          : out    std_logic);
end component;


signal clk_vga    : std_logic;
signal clock100   : std_logic;

signal dOut : std_logic_vector(7 downto 0);

signal rgb_r_out : std_logic_vector(7 downto 0);
signal RAMoutNIR : std_logic_vector(7 downto 0);

begin

clock_controller : clk_wiz_base
     port map
      (-- Clock in ports
      reset => '0',
      clk_in1 => clock,
       -- Clock out ports
       clk_out1 => clock100,
       clk_out2 => clk_vga);

Inst_frame_buffer_rgb_r: blk_mem_gen_img PORT MAP(
		clka  => clock100,
		ena   => '1',
		wea   => "1",
		addra => addrInRAM,
		dina  => dOut,
		clkb  => clk_vga,
		enb   => '1',
		addrb => addrOutRAM,
		doutb => rgb_r_out
	);



end Behavioral;
