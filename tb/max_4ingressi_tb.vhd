library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity max_4ingressi_tb is
end max_4ingressi_tb;
	
architecture beh of max_4ingressi_tb is

	constant N			      : positive 	:= 8;
	
	component max_4ingressi
	generic (
		Nbit : positive := 8
		);
	port (
		mat1	: in  	std_logic_vector(Nbit-1 downto 0);
        mat2	: in  	std_logic_vector(Nbit-1 downto 0);
        mat3	: in  	std_logic_vector(Nbit-1 downto 0);
        mat4	: in  	std_logic_vector(Nbit-1 downto 0);
        mat_max	: out  	std_logic_vector(Nbit-1 downto 0)
		
		);
	end component;
	
	signal mat1_ext	: std_logic_vector(N-1 downto 0) := (others => '0');
	signal mat2_ext	: std_logic_vector(N-1 downto 0) := (others => '0');
	signal mat3_ext : std_logic_vector(N-1 downto 0) := (others => '0');
	signal mat4_ext	: std_logic_vector(N-1 downto 0) := (others => '0');
	signal mat_max_ext: std_logic_vector(N-1 downto 0) := (others => '0');
	signal testing  : boolean := true;
	
	begin

	dut: max_4ingressi 
		generic map (
			Nbit => N
			)
		port map(
			mat1	=> mat1_ext,	
			mat2	=> mat2_ext,	
			mat3	=> mat3_ext,	
			mat4	=> mat4_ext,	
			mat_max  => mat_max_ext
			);
		
		stimulus : process 
			begin
			mat1_ext <= (others => '0');
            mat2_ext <= (others => '0');
            mat3_ext <= (others => '0');
            mat4_ext <= (others => '0');
			wait for 1 ns;
            mat1_ext <= "11111111";
            mat2_ext <= "00000000";
            mat3_ext <= "00011111";
            mat4_ext <= "00000111";
			wait for 3 ns;
            mat1_ext <= "00111111";
            mat2_ext <= "11000000";
            mat3_ext <= "11111111";
            mat4_ext <= "00000111";
			wait for 5 ns;
			mat1_ext <= "10100000";
            mat2_ext <= "11100100";
            mat3_ext <= "00000110";
            mat4_ext <= "00000011";
			wait for 5 ns;
			mat1_ext <= "11100000";
            mat2_ext <= "00000100";
            mat3_ext <= "00000010";
            mat4_ext <= "00000011";
			wait for 5 ns;
			mat1_ext <= "00000000";
            mat2_ext <= "00000100";
            mat3_ext <= "00000010";
            mat4_ext <= "00010000";
			wait for 5 ns;
			testing <= false;
		end process;
end beh;
	