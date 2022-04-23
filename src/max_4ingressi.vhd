library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity max_4ingressi is
    generic ( Nbit : positive := 8);
    port(
        mat1,mat2,mat3,mat4     : in std_logic_vector(Nbit - 1 downto 0); 
        mat_max                 : out std_logic_vector(Nbit - 1 downto 0)
    );
end max_4ingressi;

architecture arch of max_4ingressi is
    
    component comparatore_8bit is
        generic (N : positive := 8);
        port (
            A      : in std_logic_vector(N - 1 downto 0);
            B      : in std_logic_vector(N - 1 downto 0);
            G      : out std_logic
        );  
    end component;

    signal g_comp1   : std_logic;
    signal g_comp2   : std_logic;
    signal g_compmax : std_logic;
    signal out1      : std_logic_vector(Nbit - 1 downto 0);
    signal out2      : std_logic_vector(Nbit - 1 downto 0);

    begin

        comp_1: comparatore_8bit
        generic map(N => Nbit)
            port map (
                A  => mat1,
                B  => mat2,
                G  => g_comp1 
            );
        
        comp_2: comparatore_8bit
        generic map(N => Nbit)
            port map (
                A  => mat3,
                B  => mat4,
                G  => g_comp2 
            );  
            
        comp_max: comparatore_8bit
        generic map(N => Nbit)
            port map (
                A  => out1,
                B  => out2,
                G  => g_compmax 
            ); 
            
            parte1: process(mat1,mat2,mat3,mat4,out1,out2,g_comp1,g_comp2,g_compmax) 
                begin
    
                    if (g_comp1 = '0') then
                        out1 <= mat2;
                    else
                        out1 <= mat1;
                    end if;

                    if (g_comp2 = '0') then
                        out2 <= mat4;
                    else
                        out2 <= mat3;
                    end if;

                    if (g_compmax = '0') then
                        mat_max <= out2;
                    else
                        mat_max <= out1;
                    end if;
    
                end process;         
end arch;    