library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
library work;
use work.prova.all;

entity max_pool_tb is
end max_pool_tb;

architecture beh of max_pool_tb is

	constant N_bit	: positive 	:= 8;
	constant num_in	        : positive 	:= 100;
	constant num_out	    : positive 	:= 25;
    constant clk_period     : time      := 10 ns;

    component max_pool
	generic ( N        : positive := 8;         
			  num1     : positive := 100;
			  num2     : positive := 25);    
	port
	(
		clk         :  in  std_logic;
		d           :  in  memory_t(num1-1 downto 0)(N-1 downto 0);
		uscita      :  out memory_t(num2-1 downto 0)(N-1 downto 0)
	);
	end component;

    signal clk_ext      : std_logic    := '0';
    signal d_ext        : memory_t(num_in-1 downto 0)(N_bit-1 downto 0):= (others=>(others=>'0'));
    signal uscita_ext   : memory_t(num_out-1 downto 0)(N_bit-1 downto 0);
    signal testing      : boolean    := true;

    begin

        clk_ext <=  not clk_ext after clk_period/2 when testing else '0';

	dut: max_pool
		generic map (
			N       => N_bit,
			num1    => num_in,
			num2    => num_out
			)
		port map(
			clk       => clk_ext,
            d         => d_ext,
            uscita    => uscita_ext
			);
		
stimulus : process 
			begin
                d_ext <= (others => (others => '1'));   --tutti uguali
                wait for 550 ns;
                d_ext <= (others => ("00110011"));      --tutti uguali
                wait for 550 ns;
                d_ext <= (("00000001"), ("00100011"), ("01000101"), ("01100111"), ("10001001"), ("10101011"), ("11001101"), ("11101111"), ("00010010"), ("00110100"), ("01010110"), ("01111000"), others => "00000000");  --che succede se non scrivo tutta la matrice?
                wait for 550 ns;
			    testing <= false;
		   end process;
end beh;