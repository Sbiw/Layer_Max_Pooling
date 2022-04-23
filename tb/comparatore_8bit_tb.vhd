library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity comparatore_8bit_tb is
end comparatore_8bit_tb;
	
architecture beh of comparatore_8bit_tb is

	constant Nbit	: positive 	:= 8;
	
	component comparatore_8bit
	generic (N : positive := 8);
        Port ( A,B : in std_logic_vector(N - 1 downto 0);
               G   : out std_logic);
	end component;
	
	signal A_ext	: std_logic_vector(Nbit-1 downto 0) := (others => '0');
	signal B_ext	: std_logic_vector(Nbit-1 downto 0) := (others => '0');
    signal G_ext    : std_logic:= '0';
	signal testing  : boolean := true;
	
	begin

	dut: comparatore_8bit 
		generic map (N => Nbit)
		port map(
			A => A_ext,	
            B => B_ext,	
			G => G_ext);
		
		stimulus : process 
			begin
			A_ext <= (others => '0');
            B_ext <= (others => '0');
			wait for 1 ns;
            A_ext <= "10000000";
            B_ext <= "00000001";
			wait for 1 ns;
            A_ext <= "00000000";
            B_ext <= "00000001";
			wait for 1 ns;
            A_ext <= "00001000";
            B_ext <= "00000001";
			wait for 1 ns;
			testing <= false;
		end process;
end beh;