library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hagas_nemegc is
    Port ( x : in  STD_LOGIC;
           y : in  STD_LOGIC;
           s : out  STD_LOGIC;
           c : out  STD_LOGIC);
end hagas_nemegc;

architecture arch_ha of hagas_nemegc is
 begin
  s <= x xor y;
  c <= x and y;
end arch_ha;
