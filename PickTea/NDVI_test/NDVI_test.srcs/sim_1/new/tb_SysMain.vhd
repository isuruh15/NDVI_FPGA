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

entity tb_SysMain is
--  Port ( );
end tb_SysMain;

architecture Behavioral of tb_SysMain is
    COMPONENT Sys_Main
    PORT(
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
--        RAMout: out std_logic_vector(7 downto 0);
--        RAMoutNIR: out std_logic_vector(7 downto 0)
        R,G,B: out std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    
    --Inputs
   signal clock : std_logic := '0';
   signal dataIn : std_logic_vector(7 downto 0) := (others => '0');
   signal addrOut : std_logic_vector(3 downto 0) := (others => '0');
   signal addrIn : std_logic_vector(3 downto 0) := (others => '0');
   signal addrOutRAM : std_logic_vector(6 downto 0) := (others => '0');
   signal addrInRAM : std_logic_vector(6 downto 0) := (others => '0');
   signal we : std_logic_vector(0 downto 0) := (others => '0');
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
   uut: Sys_Main PORT MAP (
          clock => clock,
          dataIn => dataIn,
          addrOut => addrOut,
          addrIn => addrIn,
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
	  addrOut <= x"0";
	  addrIn <= x"0";
	  we <= "0";
	  re <= '0';
      -- hold reset state for 100 ns.
      wait for 10 ns;	

      --wait for clock_period*10;
		
	  re <= '1';  
	  for i in 0 to 15 loop
	  addrOut <= std_logic_vector(to_unsigned(i, 4));
	  wait for 20 ns;
	  addrInRAM <= std_logic_vector(to_unsigned(i+1, 7));
	  wait for 20 ns;
	  addrOutRAM <= std_logic_vector(to_unsigned(i, 7));
	  wait for 20 ns;
	  end loop;

      -- insert stimulus here 

      wait;
   end process;

END;
