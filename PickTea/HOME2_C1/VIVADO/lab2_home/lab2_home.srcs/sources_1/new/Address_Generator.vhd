----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/18/2019 07:10:51 PM
-- Design Name: 
-- Module Name: Address_Generator - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Address_Generator is
    Port ( 	CLK,enable : in  STD_LOGIC;								-- horloge de 25 MHz et signal d'activation respectivement
            rez_160x120  : IN std_logic;
            rez_320x240  : IN std_logic;
            vsync        : in  STD_LOGIC;
				address 		 : out STD_LOGIC_VECTOR (15 downto 0));	-- adresse généré
end Address_Generator;

architecture Behavioral of Address_Generator is
    signal val: STD_LOGIC_VECTOR(address'range):= (others => '0');		-- signal intermidiaire

begin
    address <= val;																		-- adresse généré

	process(CLK)
		begin
         if rising_edge(CLK) then
            if (enable='1') then													-- si enable = 0 on arrete la génération d'adresses
               if rez_160x120 = '1' then
                  if (val < 160*120) then										-- si l'espace mémoire est balayé complétement				
                     val <= val + 1 ;
                  end if;
               elsif rez_320x240 = '1' then
                  if (val < 320*240) then										-- si l'espace mémoire est balayé complétement				
                     val <= val + 1 ;
                  end if;
               else
                  if (val < 640*480) then										-- si l'espace mémoire est balayé complétement				
                     val <= val + 1 ;
                  end if;
               end if;
				end if;
            if vsync = '0' then 
               val <= (others => '0');
            end if;
			end if;	
		end process;


end Behavioral;
