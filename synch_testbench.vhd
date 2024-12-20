library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity synch_tb is
end synch_tb;

architecture arch_synch of synch_tb is
    component S_CNT
        port (clk, RST_n, EN: in std_logic;
            CNTR   : out std_logic_vector(7 downto 0));
    end component;
    signal clk    : std_logic := '0';
    signal RST_n  : std_logic := '0';
    signal EN     : std_logic := '0';
    signal CNTR   : std_logic_vector(7 downto 0);
    
begin
    uut: S_CNT port map (
        clk    => clk,
        RST_n  => RST_n,
        EN     => EN,
        CNTR   => CNTR);

    clock_process: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    stimulus_process: process
    begin
        RST_n <= '0'; 
        EN <= '0';     
        wait for 20 ns; 
        RST_n <= '1';  
        wait for 20 ns;

        EN <= '1';     
        wait for 100 ns;
        EN <= '0';   
        wait for 50 ns;

        RST_n <= '0';  
        wait for 20 ns;
        RST_n <= '1';  
        wait;
    end process;
end arch_synch;
