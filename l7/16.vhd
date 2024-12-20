library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity fulladder16bit is
    Port ( x, y : in  STD_LOGIC_VECTOR(15 downto 0);
           z : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR(15 downto 0);
           c : out  STD_LOGIC);
end fulladder16bit;
 
architecture arch_16bitfa of fulladder16bit is
component full_adder
  port (x, y, z: in std_logic;
		  s, c: out std_logic);
end component;
signal fc, fc2, fc3, fc4, fc5, fc6, fc7, fc8: std_logic;
begin
  h: for i in 1 to 16 generate
    FA1: full_adder port map (x(i-1), y(i-1), z, s(i-1), c(i-1));
  end generate;
end arch_16bitfa;