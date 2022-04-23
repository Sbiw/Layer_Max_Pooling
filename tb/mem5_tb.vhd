library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
library work;
use work.prova.all;

entity mem5_tb is
end mem5_tb;

architecture beh of mem5_tb is

	constant N			: positive 	:= 8;
    constant M			: positive 	:= 25;
    constant clk_period : time := 10 ns;
	
	component mem5
    generic ( num   : natural := 25;   -- matrice 5x5(num) con elementi a depht bit
              depth : natural := 8   
			  );

    port (
        clk       : in std_logic;
		rst       : in std_logic;
        out_max   : in std_logic_vector (depth - 1 downto 0);
        q         : out memory_t(num-1 downto 0)(depth-1 downto 0)
    );

end component;

signal clk_ext        : std_logic:= '0';
signal rst_ext        : std_logic:= '1';
signal out_max_ext    : std_logic_vector (N - 1 downto 0):= (others => '0');
signal q_ext 		  : memory_t(M-1 downto 0)(N-1 downto 0);
signal testing        : boolean := true;

begin

    clk_ext <=  not clk_ext after clk_period/2 when testing else '0';

	dut: mem5
		generic map (
			depth => N,
            num   => M
			)
		port map(
		 clk       => clk_ext,
		 rst       => rst_ext,
         q         => q_ext,
		out_max		=> out_max_ext
		);
        
stimulus : process 
			begin
				rst_ext     <= '1';
                out_max_ext <= (others=>'0');      
                wait for 250 ns;
                out_max_ext <= "00001111";                
                wait for 10 ns;
				out_max_ext <= "00001110";
				wait for 10 ns;
				out_max_ext <= "00001100";
				wait for 10 ns;
				rst_ext     <= '0';
				out_max_ext <= "00001000";
				wait for 10 ns;
				out_max_ext <= "00101000";
				wait for 10 ns;
				rst_ext     <= '1';
				out_max_ext <= "00000110";
				wait for 10 ns;
				out_max_ext <= "00000010";
				wait for 500 ns;
                out_max_ext <= (others=>'0'); 
                wait for 1000 ns;
			    testing <= false;
		  end process;
end beh;