library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( x : in  STD_LOGIC;
           y : in  STD_LOGIC;
           z : in  STD_LOGIC;
           s : out  STD_LOGIC;
           c : out  STD_LOGIC);
end full_adder;

architecture arch_fulladder of full_adder is
 component hagas_nemegc
  port (x, y: in std_logic;
		  s, c: out std_logic);
 end component;
 signal hs, hc, tc: std_logic;
 begin
  HA1: hagas_nemegc port map (x, y, hs, hc);
  HA2: hagas_nemegc port map (hs, z, s, tc);
  c <= tc or hc;
end arch_fulladder;