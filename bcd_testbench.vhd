
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCD_UpDown_Counter_TB is
end BCD_UpDown_Counter_TB;

architecture Behavioral of BCD_UpDown_Counter_TB is
    signal Clock     : STD_LOGIC := '0';
    signal Reset     : STD_LOGIC := '0';
    signal Load      : STD_LOGIC := '0';
    signal Direction : STD_LOGIC := '1';
    signal D         : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal Q         : STD_LOGIC_VECTOR(7 downto 0);
    

    component BCD_UpDown_Counter
        Port (
            Clock     : in  STD_LOGIC;
            Reset     : in  STD_LOGIC;
            Load      : in  STD_LOGIC;
            Direction : in  STD_LOGIC;
            D         : in  STD_LOGIC_VECTOR(7 downto 0);
            Q         : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

begin
    -- Connect signals to the BCD Up-Down counter
    UUT: BCD_UpDown_Counter
        Port map (
            Clock     => Clock,
            Reset     => Reset,
            Load      => Load,
            Direction => Direction,
            D         => D,
            Q         => Q
        );

    -- Clock process to generate clock signal
    Clock_process: process
    begin
        Clock <= '0';
        wait for 10 ns;
        Clock <= '1';
        wait for 10 ns;
    end process;

    -- Test process to apply various test cases
    Stimulus: process
    begin
        -- Apply reset
        Reset <= '1';
        wait for 20 ns;
        Reset <= '0';
        
        -- Load a value of 12 into the counter and count up
        D <= "00010010"; -- 12 in BCD
        Load <= '1';
        wait for 20 ns;
        Load <= '0';
        
        -- Count up for a few clock cycles
        Direction <= '1';
        wait for 100 ns;
        
        -- Switch to counting down
        Direction <= '0';
        wait for 100 ns;
        
        -- Load a new value (45 in BCD) and count down
        D <= "01000101"; -- 45 in BCD
        Load <= '1';
        wait for 20 ns;
        Load <= '0';
        wait for 100 ns;
        
        -- End simulation
        wait;
    end process;
end Behavioral;
