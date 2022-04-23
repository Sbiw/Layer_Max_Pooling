library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparatore_8bit is
    generic (N : positive := 8 );
    Port ( A,B : in std_logic_vector(N - 1 downto 0);
           G   : out std_logic);
end comparatore_8bit;

architecture arch of comparatore_8bit is
  begin
name: process(A,B)
     begin
if A>B then           -- il caso uguale non mi interessa quale prende, tanto sono uguali
           G <= '1';
       else 
           G <= '0';
      end if;
    end process;
end arch;