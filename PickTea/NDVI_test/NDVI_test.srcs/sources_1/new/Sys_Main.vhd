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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sys_Main is
    port(
        addr: in std_logic_vector(6 downto 0);
        CLOCK: in std_logic; -- clock input for RAM
        enable: in std_logic -- clock input for RAM 
    );
--  Port ( );
end Sys_Main;

architecture Behavioral of Sys_Main is

signal dOut : std_logic_vector(7 downto 0);

begin

--instantiate and do port map for the first RAM.
READER : entity work.ImageRead port map(
    clock => CLOCK,
    data => addr,
    rdaddress => addr,
    wraddress => addr,
    we => CLOCK,
    re => CLOCK,
    q => dOut
    
);

--instantiate and do port map for the first RAM.
RAM1 : entity work.RamSinglePort port map(
    RAM_ADDR => addr,
    RAM_DATA_IN => addr,
    RAM_WR => CLOCK,
    RAM_CLOCK => CLOCK,
    RAM_DATA_OUT => dOut
    
);


end Behavioral;
