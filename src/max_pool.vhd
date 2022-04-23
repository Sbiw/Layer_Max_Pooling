library ieee;
use ieee.std_logic_1164.all; 
library work;
use work.prova.all;

entity max_pool is

	generic ( N    : positive := 8;
	          num1 : positive := 100;
			  num2 : positive := 25 
			  );
	port
	(
		clk         :  in  std_logic;
		d           :  in  memory_t(num1-1 downto 0)(N-1 downto 0);
		uscita      :  out  memory_t(num2-1 downto 0)(N-1 downto 0)
	);

end max_pool;

architecture arc of max_pool is

component max_4ingressi
generic (Nbit    : integer := 8);
	port(mat1    : in std_logic_vector(Nbit - 1 downto 0);
		 mat2    : in std_logic_vector(Nbit - 1 downto 0);
		 mat3    : in std_logic_vector(Nbit - 1 downto 0);
		 mat4    : in std_logic_vector(Nbit - 1 downto 0);
		 mat_max : out std_logic_vector(Nbit - 1 downto 0)
	);
end component;

component mem10
generic (depth : integer := 8;
         num   : natural := 100);
	port(clk   : in std_logic;
        d      : in memory_t(num-1 downto 0)(depth-1 downto 0);
		rst    : out std_logic;
        q1     : out std_logic_vector (depth - 1 downto 0);
        q2     : out std_logic_vector (depth - 1 downto 0);
        q3     : out std_logic_vector (depth - 1 downto 0);
        q4     : out std_logic_vector (depth - 1 downto 0)
	);
END component;

component mem5
generic (num   : natural := 25;
		 depth : integer := 8);
	port(clk   : in std_logic;
	rst        : in std_logic;
	out_max    : in std_logic_vector (depth - 1 downto 0);
	q          : out memory_t(num-1 downto 0)(depth-1 downto 0)
	);
end component;

signal	mat1_ext    :  std_logic_vector(N - 1 downto 0);
signal	mat2_ext    :  std_logic_vector(N - 1 downto 0);
signal	mat3_ext    :  std_logic_vector(N - 1 downto 0);
signal	mat4_ext    :  std_logic_vector(N - 1 downto 0);
signal	mat_max_ext :  std_logic_vector(N - 1 downto 0);
signal  rst_ext     :  std_logic;

begin

max : max_4ingressi
      	generic map(Nbit    => 8)
		  port map   (mat1    => mat1_ext,
		  mat2    => mat2_ext,
		  mat3    => mat3_ext,
		  mat4    => mat4_ext,
		  mat_max => mat_max_ext);

mem1 : mem10
generic map(depth => 8,
            num   => 100)
port map   (clk   => clk,
		    d     => d,
			rst   => rst_ext,
		    q1    => mat1_ext,
		    q2    => mat2_ext,
		    q3    => mat3_ext,
		    q4    => mat4_ext);

mem2 : mem5
generic map(depth     => 8,
            num       => 25)
port map   (clk       => clk,
            rst       => rst_ext,
		    out_max   => mat_max_ext,
		    q         => uscita);

end arc;