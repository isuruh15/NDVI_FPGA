----------------------------------------------------------------------------------
-- Company: University of Moratuwa
-- Engineer: Isuru Samaranayake
-- 
-- Create Date: 08/15/2019 10:12:21 AM
-- Design Name: 
-- Module Name: Sys_Main - Behavioral
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

entity Sys_Main is
    port(
        dataIn: in std_logic_vector(7 downto 0);
        addrIn: in std_logic_vector(3 downto 0);  --buffer addres
        addrOut: in std_logic_vector(3 downto 0);  --buffer addres - out
        addrInRAM: in std_logic_vector(6 downto 0);  --ram addres
        addrOutRAM: in std_logic_vector(6 downto 0);  --ram addres - out
        we: in STD_LOGIC_VECTOR(0 DOWNTO 0); -- write enable for ram
        re: in std_logic; -- read enable for RAM()
        --RAMaddr: in std_logic_vector(6 downto 0);
        clock: in std_logic; -- clock input for RAM
        --enable: in std_logic; -- clock input for RAM 
        RAMout: out std_logic_vector(7 downto 0)
    );
--  Port ( );
end Sys_Main;

architecture Behavioral of Sys_Main is

COMPONENT blk_mem_gen_read
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
signal read_address_reg: std_logic_vector(3 downto 0) := (others=>'0');


signal dOut : std_logic_vector(7 downto 0);
--signal RAMaddr : std_logic_vector(6 downto 0);
--signal weRAM : std_logic;
--signal reRAM : std_logic;


begin

--instantiate and do port map for the reader buffer.
--READER : entity work.ImageRead port map(
--    clock => clock,
--    data => dataIn,
--    rdaddress => addrOut,
--    wraddress => addrIn,
--    we => '1',
--    re => re,
--    q => dOut
    
--);

--instantiate and do port map for the first RAM.
--RAM1 : entity work.RamSinglePort port map(
--    RAM_ADDR => RAMaddr,
--    RAM_DATA_IN => dOut,
--    RAM_WR => weRAM,
--    RAM_CLOCK => clock,
--    RAM_DATA_OUT => RAMout
    
--);

Inst_frame_buffer_r: blk_mem_gen_read PORT MAP(
		clka  => clock,
		ena   => '1',
		wea   => "1",
		addra => addrInRAM,
		dina  => dOut,
		clkb  => clock,
		enb   => re,
		addrb => addrOutRAM,
		doutb => RAMout
	);



process (clock)
	  begin
		if (rising_edge(clock)) then
			if (we ="1") then
			  ram_block(to_integer(unsigned(addrIn))) <= dataIn;
			end if;
			if (re = '1') then
			  dOut <= ram_block(to_integer(unsigned(addrOut)));
			end if;
		 end if;
	  end process;


end Behavioral;
