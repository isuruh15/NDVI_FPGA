----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/15/2019 11:32:45 PM
-- Design Name: 
-- Module Name: tb_SysMain - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_NDVI is
--  Port ( );
end tb_NDVI;

architecture Behavioral of tb_NDVI is
    COMPONENT NDVI
    PORT(
        clock: in std_logic; -- clock input for RAM
        we: in std_logic; -- write enable for buffer
        re: in std_logic; -- read enable for buffer
        addressBuffer: in std_logic_vector(3 downto 0);  --buffer addres
        addressBufferOut: in std_logic_vector(3 downto 0);  --buffer addres - out
        dataIn: in std_logic_vector(7 downto 0);
        addrInRAM: in std_logic_vector(16 downto 0);  --ram addres
        addrOutRAM: in std_logic_vector(16 downto 0);  --ram addres - out
        
        --RAMaddr: in std_logic_vector(6 downto 0);
        
        --enable: in std_logic; -- clock input for RAM 
--        RAMout: out std_logic_vector(7 downto 0);
--        RAMoutNIR: out std_logic_vector(7 downto 0)
        R,G,B: out std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    
    --Inputs
   signal clock : std_logic := '0';
   signal dataIn : std_logic_vector(7 downto 0) := (others => '0');
   signal addressBufferOut : std_logic_vector(3 downto 0) := (others => '0');
   signal addressBuffer : std_logic_vector(3 downto 0) := (others => '0');
   signal addrOutRAM : std_logic_vector(16 downto 0) := (others => '0');
   signal addrInRAM : std_logic_vector(16 downto 0) := (others => '0');
   signal we : std_logic := '0';
   signal re : std_logic := '0';
   
   --Outputs
--   signal RAMout : std_logic_vector(7 downto 0);
--   signal RAMoutNIR : std_logic_vector(7 downto 0);
    signal R,G,B : std_logic_vector(7 downto 0);
   
   -- Clock period definitions
   constant clock_period : time := 10 ns;
	signal i: integer;
   
   

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: NDVI PORT MAP (
          clock => clock,
          dataIn => dataIn,
          addressBufferOut => addressBufferOut,
          addressBuffer => addressBuffer,
          addrOutRAM => addrOutRAM,
          addrInRAM => addrInRAM,
          we => we,
          re => re
           
--          RAMout => RAMout,
--          RAMoutNIR => RAMoutNIR
          
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		dataIn <= x"00";
	  addressBufferOut <= x"0";
	  addressBuffer <= x"0";
	  we <= '0';
	  re <= '0';
      -- hold reset state for 100 ns.
      wait for 10 ns;
      re <= '1';	

      --wait for clock_period*10;
		  
	  for i in 0 to 15 loop
	  addressBufferOut <= std_logic_vector(to_unsigned(i, 4));
	  wait for 20 ns;
	  addrInRAM <= std_logic_vector(to_unsigned(i, 17));
	  wait for 40 ns;
	  addrOutRAM <= std_logic_vector(to_unsigned(i, 17));
	  wait for 20 ns;
	  end loop;

      -- insert stimulus here 

      wait;
   end process;

END;
