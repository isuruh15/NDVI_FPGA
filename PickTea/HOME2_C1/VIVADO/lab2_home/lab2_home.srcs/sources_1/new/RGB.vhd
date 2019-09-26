----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/19/2019 12:35:09 AM
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RGB is
    Port ( Din 	: in	STD_LOGIC_VECTOR (7 downto 0);	
--           Din_r 	: in	STD_LOGIC_VECTOR (3 downto 0);		-- niveau de gris du pixels sur 8 bits
		   Nblank : in	STD_LOGIC;										-- signal indique les zone d'affichage, hors la zone d'affichage
																					-- les trois couleurs prendre 0
           R,G,B 	: out	STD_LOGIC_VECTOR (7 downto 0));
end RGB;

architecture Behavioral of RGB is

--signal Gray : std_logic_vector(7 downto 0);
begin
        --Gray  <= (Din_r(3 downto 0) & Din_r(3 downto 0));
--        Gray  <= std_logic_vector( (unsigned(Din_r(3 downto 0)  & Din_r(3 downto 0)) + unsigned(Din_l(3 downto 0)  & Din_l(3 downto 0)))/2);--((Din(11 downto 8) & Din(11 downto 8))+(Din(7 downto 4)  & Din(7 downto 4))+(Din(3 downto 0)  & Din(3 downto 0)));
        --Gray  <= std_logic_vector(unsigned(Din(11 downto 8) & Din(11 downto 8)) + unsigned(Din(7 downto 4)  & Din(7 downto 4)) + unsigned(Din(3 downto 0)  & Din(3 downto 0))/3);--((Din(11 downto 8) & Din(11 downto 8))+(Din(7 downto 4)  & Din(7 downto 4))+(Din(3 downto 0)  & Din(3 downto 0)));
		R <= (Din) when Nblank='1'  else "00000000";
		G <= (Din)  when Nblank='1' else "00000000";
		B <= (Din)  when Nblank='1' else "00000000";
		
end Behavioral;
