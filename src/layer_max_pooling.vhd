library ieee;
use ieee.std_logic_1164.all; 
library work;
use work.prova.all;

entity layer_max_pooling is
	generic ( N_bit    : positive := 8;     -- profondità singolo elemento della matrice
			  N_canali : positive := 2;     -- numero di canali
			  num1     : positive := 100;
			  num2     : positive := 25);    
	port
	(
		clk         :  in  std_logic;
		entrate     :  in  memory_t(N_canali*num1-1 downto 0)(N_bit-1 downto 0);
		uscite      :  out memory_t(N_canali*num2-1 downto 0)(N_bit-1 downto 0)
	);
end layer_max_pooling;

architecture arc of layer_max_pooling is

    component max_pool
	generic (N           : positive := 8;
	         num1        : positive := 100;
	         num2        : positive := 25 );
	port    (clk         :  in  std_logic;
		     d           :  in  memory_t(num1-1 downto 0)(N-1 downto 0);
		     uscita      :  out  memory_t(num2-1 downto 0)(N-1 downto 0)
	);
    end component; 

    begin
		GEN : for i in 0 to  N_canali - 1 generate
			CANALI: max_pool
			generic map(N    => N_bit,
			            num1 => num1,
			            num2 => num2) 
			port map (
				clk          => clk,
				d            => entrate(((i + 1)*(num1) - 1) downto i*num1),
				uscita       => uscite(((i + 1)*(num2) - 1) downto i*num2)
			);
			end generate GEN;
end arc;
