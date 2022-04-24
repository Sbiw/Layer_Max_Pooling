library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
library work;
use work.prova.all;

entity mem10_tb is
end mem10_tb;
	
architecture beh of mem10_tb is

	constant N			: positive 	:= 8;
    constant M			: positive 	:= 100;
    constant clk_period : time := 10 ns;
	
	component mem10
	generic ( num   : natural := 100;
		      depth : positive := 8
		);
	port (
        clk       : in std_logic;
        d         : in memory_t(num - 1 downto 0)(depth - 1 downto 0);
        q1        : out std_logic_vector (depth - 1 downto 0);
        q2        : out std_logic_vector (depth - 1 downto 0);
        q3        : out std_logic_vector (depth - 1 downto 0);
        q4        : out std_logic_vector (depth - 1 downto 0)
		);
	end component;
	
    signal clk_ext        : std_logic:= '0';
    signal d_ext          : memory_t(M - 1 downto 0)(N - 1 downto 0):= (others=>(others=>'0'));
    signal q1_ext         : std_logic_vector (N - 1 downto 0):= (others => '0');
    signal q2_ext         : std_logic_vector (N - 1 downto 0):= (others => '0');
    signal q3_ext         : std_logic_vector (N - 1 downto 0):= (others => '0');
    signal q4_ext         : std_logic_vector (N - 1 downto 0):= (others => '0');
	signal testing        : boolean := true;
	
	begin

        clk_ext <=  not clk_ext after clk_period/2 when testing else '0';

	dut: mem10
		generic map (
			depth => N,
            num   => M
			)
		port map(
            clk       => clk_ext,
            d         => d_ext,
            q1        => q1_ext,
            q2        => q2_ext,      -- ho messo tale prova e va, poi aggiunta la seconda matrice per conferma
            q3        => q3_ext,      -- |88 89| = |q1 q2| = |4  2 |
            q4        => q4_ext       -- |98 99|   |q3 q4|   |1 128|
			);
		
		stimulus : process 
			begin
                d_ext <= (others=>(others=>'0'));      
                wait for 480 ns;   
                d_ext <= (("10000000"), ("00000001"), ("00000000"), ("00000000"), 
                          ("00000000"), ("00000000"), ("00000000"), ("00000000"), 
                          ("00000000"), ("00000000"),  ("00000010"), ("00000100"),
                           others => "00000000");
                wait for 500 ns;
                d_ext <= (("00000000"), ("00000000"), ("00000000"), ("00000000"), ("00000000"),
                          ("00000000"), ("00000000"), ("00000000"), ("00000000"), ("00000000"),  
                          ("00000000"), ("00000000"), ("00000000"), ("00000000"), ("00000000"), 
                          ("00000000"), ("00000000"), ("00000000"), ("00000000"), ("00000000"), 
                          ("00000000"), ("00000000"), ("00000000"), ("00000000"), ("00000000"), 
                          ("00000000"), ("00000000"), ("00000000"), ("00000000"), ("00000000"), 
                          ("00000000"), ("00000000"), ("00000000"), ("00000000"), ("00000000"), 
                          ("00000000"), ("00000000"), ("00000000"), ("00000000"), ("00000000"), 
                          ("00000000"), ("00000000"), ("00000001"), ("00000010"), ("00000000"), 
                          ("00000000"), ("00000000"), ("00000000"), ("00000000"), ("00000000"), 
                          ("00000000"), ("00000000"), ("10000000"), ("00100000"),others => "00000000");
      wait for 500 ns;
			testing <= false;
		end process;
end beh;
	