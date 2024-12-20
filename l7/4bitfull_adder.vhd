library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity fulladder8bit is
    Port ( x, x2, x3, x4, x5, x6, x7, x8 : in  STD_LOGIC;
           y, y2, y3, y4, y5, y6, y7, y8 : in  STD_LOGIC;
           z : in  STD_LOGIC;
           s, s2, s3, s4, s5, s6, s7, s8 : out  STD_LOGIC;
           c : out  STD_LOGIC);
end fulladder8bit;
 
architecture arch_8bitfa of fulladder8bit is
component full_adder
  port (x, y, z: in std_logic;
		  s, c: out std_logic);
end component;
signal fc, fc2, fc3, fc4, fc5, fc6, fc7, fc8: std_logic;
begin
  FA1: full_adder port map (x, y, z, s, fc);
  FA2: full_adder port map (x2, y2, fc, s2, fc2);
  FA3: full_adder port map (x3, y3, fc2, s3, fc3);
  FA4: full_adder port map (x4, y4, fc3, s4, fc4);
  FA5: full_adder port map (x5, y5, fc4, s5, fc5);
  FA6: full_adder port map (x6, y6, fc5, s6, fc6);
  FA7: full_adder port map (x7, y7, fc6, s7, fc7);
  FA8: full_adder port map (x8, y8, fc7, s8, c);
end arch_8bitfa;