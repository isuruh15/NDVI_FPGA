library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rgb2bw is
    Port (
        red : in STD_LOGIC_VECTOR (7 downto 0);     -- ingresso canale rosso
        green : in STD_LOGIC_VECTOR (7 downto 0);   -- ingresso canale verde
        blue : in STD_LOGIC_VECTOR (7 downto 0);    -- ingresso canale blu
        bw : out STD_LOGIC_VECTOR (7 downto 0);     -- uscita bianco nero
        clk : in STD_LOGIC);                        -- clock
end rgb2bw;

architecture Behavioral of rgb2bw is
begin
    process (clk)
        -- sum variable. maximum = 43 * 3 * 255 = 32895 then 16 bits needed.
        -- use a variable to write the code in a "sequential" way (more readable)
        variable sum : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
        
    begin
        if rising_edge(clk) then
            -- I have to perform the arithmetic mean of the signals r, g, b.
            -- you want to avoid performing a division (high use of resources)
            -- A possible (approximate) solution is to add the data,
            -- multiply the sum obtained by 43, and finally divide by 128 (using shift)
            -- the solution is obviously approximate (equivalent to dividing by about 2,977), but
            -- returns acceptable results to achieve the intended purpose
            sum := (others => '0');
            sum := std_logic_vector(unsigned(sum) + (unsigned(red)));
            sum := std_logic_vector(unsigned(sum) + (unsigned(green)));
            sum := std_logic_vector(unsigned(sum) + (unsigned(blue)));
            sum := std_logic_vector(unsigned(sum(9 downto 0)) * to_unsigned(43,6));
            -- I have to check that I have not exceeded the limit of 128 * 255 = 32640
            -- I optimize: I only check bit 15. If it is 1, I have definitely exceeded the limit (I would be over 32767).
            -- the values ??from 32640 to 32767 inclusive do not give problems: the bits 7 to 14 are always all 1
            if (sum(15) = '1') then
                -- in questo caso il risultato deve essere 11111111 indipendentemente dal valore di sum
                bw <= (others => '1');   
            else
                -- sono sotto il limite massimo:
                -- eseguo la "divisione per 128" cioè lo shift, mettendo il risultato nel registro di uscita
                bw <= sum(14 downto 7);
                                
            end if;  

        end if;
    end process;

end Behavioral;
