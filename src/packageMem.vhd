library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package prova is  -- package per definire array di array generici 

type memory_t is array (natural range <>) of std_logic_vector; -- ATTENZIONE!! funziona con vhdl 2008

end;