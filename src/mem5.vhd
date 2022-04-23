library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.prova.all;

entity mem5 is

    generic ( num   : natural := 25;   -- matrice 5x5(num) con elementi a depht bit
              depth : natural := 8   
			  );

    port (
        clk       : in std_logic;
        rst       : in std_logic;
        out_max   : in std_logic_vector (depth - 1 downto 0);
        q         : out memory_t(num-1 downto 0)(depth-1 downto 0)
    );

end mem5;

architecture bo of mem5 is

    signal mem_s  : memory_t(num-1 downto 0)(depth-1 downto 0):= (others=>(others=>'0'));
	signal i 	  : natural := 0;

begin

    q <= mem_s;

    process(clk,rst)
    begin

        if(rst'event and rst='0') then
            i   <= 0;
        end if;	

        if(clk'event and clk='1') then
            if (i <= 24) then 
                mem_s(i) <= out_max;
                i <= i + 1; 
            else
                i <= 0;
            end if; 
            end if;      
    end process;
        
end bo;