library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.prova.all;

entity mem10 is

    generic ( num   : natural := 100;   -- matrice 10x10(num) con elementi a depht bit
              depth : natural := 8   
			  );

    port (
        clk       : in std_logic; 
        d         : in memory_t(num-1 downto 0)(depth-1 downto 0);
		rst       : out std_logic;
        q1        : out std_logic_vector (depth - 1 downto 0);
        q2        : out std_logic_vector (depth - 1 downto 0);
        q3        : out std_logic_vector (depth - 1 downto 0);
        q4        : out std_logic_vector (depth - 1 downto 0)
    );

end mem10;

architecture bo of mem10 is

	signal j : natural := 0;   -- scorro la finestra lungo la matrice 10x10
	signal k : natural := 0;   -- scorro la finestra lungo le righe della matrice 10x10

begin
    process(clk,d)
    begin

		rst <= '1';              -- reset che va a 0 solo quando cambia d e lo trasmette 
                               -- a mem5 per far ripartire anche li gli indici
		if(d'event) then
			j   <= 0;
			k   <= 0; 
			rst <= '0';
		end if;	

        if(clk'event and clk='1') then
				if(j <= 99) then

					q1 <= d(j);
					q2 <= d(j+1);
					q3 <= d(j+10);
					q4 <= d(j+11);

					if (k <= 3) then   -- sposto la matrice da filtrare lungo la riga
						j <= j + 2;
						k <= k + 1;
					else			   -- devo andare a capo con la matrice da filtrare
						j <= j + 12;
						k <= 0;						
					end if;
				else
					j <= 0;
					k <= 0;           				
                end if;
		end if;        
    end process;
        
end bo;