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
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use ieee.std_logic_unsigned.all;

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
    we: in std_logic;
    re: in std_logic;
    addressBuffer: in std_logic_vector(3 downto 0);    --buffer address
    addressBufferOut: in std_logic_vector(3 downto 0);    --buffer address out
    dataIn: in std_logic_vector(7 downto 0);
    addrInRAM: in std_logic_vector(16 downto 0);  --ram addres
    addrOutRAM: in std_logic_vector(16 downto 0);  --ram addres - out
    R,G,B: out std_logic_vector(7 downto 0)
  );
end NDVI;

architecture Behavioral of NDVI is


COMPONENT blk_mem_gen_img
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END COMPONENT;

component clk_wiz_0
	port (
	clk_in1    :in std_logic;
	reset:in std_logic;
	locked :out std_logic;
    clk_out1         : out     std_logic;
    -- Clock out ports
    clk_out2          : out    std_logic);
end component;

TYPE mem_type IS ARRAY(0 TO 15) OF std_logic_vector(7 DOWNTO 0); --number of rows, data width
-- function to read image from binary file
impure function init_mem(mif_file_name : in string) return mem_type is
    file mif_file : text open read_mode is mif_file_name;
    variable mif_line : line;
    variable temp_bv : bit_vector(7 downto 0);  --data width
    variable temp_mem : mem_type;
begin
    for i in mem_type'range loop
        readline(mif_file, mif_line);
        read(mif_line, temp_bv);
        temp_mem(i) := to_stdlogicvector(temp_bv);
    end loop;
    return temp_mem;
end function;


signal ram_block: mem_type := init_mem("IMAGE_FILE.MIF");

signal clk_vga    : std_logic;
signal clock100   : std_logic;

signal dOut : std_logic_vector(7 downto 0);

--signal rgb_r_out : std_logic_vector(7 downto 0);
--signal rgb_g_out : std_logic_vector(7 downto 0);
--signal rgb_b_out : std_logic_vector(7 downto 0);
--signal RAMoutNIR : std_logic_vector(7 downto 0);

begin

clock_controller : clk_wiz_0
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
--		doutb => rgb_r_out
        doutb => R
	);
	
Inst_frame_buffer_rgb_g: blk_mem_gen_img PORT MAP(
		clka  => clock100,
		ena   => '1',
		wea   => "1",
		addra => addrInRAM,
		dina  => dOut,
		clkb  => clk_vga,
		enb   => '1',
		addrb => addrOutRAM,
--		doutb => rgb_g_out
        doutb => G
	);

Inst_frame_buffer_rgb_b: blk_mem_gen_img PORT MAP(
		clka  => clock100,
		ena   => '1',
		wea   => "1",
		addra => addrInRAM,
		dina  => dOut,
		clkb  => clk_vga,
		enb   => '1',
		addrb => addrOutRAM,
--		doutb => rgb_b_out
        doutb => B
	);
	
process (clock)
	  begin
		if (rising_edge(clock)) then
			if (we ='1') then
			  ram_block(to_integer(unsigned(addressBuffer))) <= dataIn;
			end if;
			if (re = '1') then
			  dOut <= ram_block(to_integer(unsigned(addressBufferOut)));
			end if;
		 end if;
end process;




end Behavioral;
