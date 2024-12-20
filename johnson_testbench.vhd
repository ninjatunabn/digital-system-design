library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Johnson_Counter_TB is
end Johnson_Counter_TB;

architecture Behavioral of Johnson_Counter_TB is
    signal Clock : STD_LOGIC := '0';
    signal Reset : STD_LOGIC := '0';
    signal Q     : STD_LOGIC_VECTOR(7 downto 0);
    component Johnson_Counter
        Port (
            Clock : in  STD_LOGIC;
            Reset : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

begin
    UUT: Johnson_Counter
        Port map (
            Clock => Clock,
            Reset => Reset,
            Q     => Q);
    Clock_process: process
    begin
        Clock <= '0';
        wait for 10 ns;
        Clock <= '1';
        wait for 10 ns;
    end process;
    Stimulus: process
    begin
        Reset <= '1';
        wait for 20 ns;
        Reset <= '0';
        wait for 200 ns;
        wait;
    end process;
end Behavioral;

