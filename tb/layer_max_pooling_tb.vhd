library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
library work;
use work.prova.all;


entity layer_max_pooling_tb is
end layer_max_pooling_tb;
	
architecture beh of layer_max_pooling_tb is

	constant N_layer	    : positive 	:= 2;
	constant N_layer_bit	: positive 	:= 8;
	constant num_in	        : positive 	:= 100;
	constant num_out	    : positive 	:= 25;
    constant clk_period     : time      := 10 ns;
	
	component layer_max_pooling
	generic ( N_bit    : positive := 8;     
			  N_canali : positive := 2;     
			  num1     : positive := 100;
			  num2     : positive := 25);    
	port
	(
		clk         :  in  std_logic;
		entrate     :  in  memory_t(N_canali*num1-1 downto 0)(N_bit-1 downto 0);
		uscite      :  out memory_t(N_canali*num2-1 downto 0)(N_bit-1 downto 0)
	);
	end component;
	
	signal clk_ext         : std_logic := '1';
    signal entrate_ext     : memory_t(N_layer*num_in-1 downto 0)(N_layer_bit-1 downto 0):= (others=>(others=>'0'));
    signal uscite_ext      : memory_t(N_layer*num_out-1 downto 0)(N_layer_bit-1 downto 0);
	signal testing         : boolean   := true;
	
	begin

        clk_ext <=  not clk_ext after clk_period/2 when testing else '0';

	dut: layer_max_pooling
		generic map (
			N_canali => N_layer,
			N_bit    => N_layer_bit,
			num1     => num_in,
			num2     => num_out
			)
		port map(
			clk          => clk_ext,
            entrate      => entrate_ext,
            uscite       => uscite_ext
			);
		
		stimulus : process 
			begin
                entrate_ext <=(others=>(others=>'0')); 
                wait for 500 ns;
			    testing <= false;
		end process;
end beh;
	