library IEEE;
use IEEE.std_logic_1164.all;

entity AS_CNT_tb is
end AS_CNT_tb;
architecture behavior of AS_CNT_tb is
    signal RST_n : std_logic := '0';        
    signal a_clk : std_logic := '0';       
    signal CNTR  : std_logic_vector(3 downto 0); 
    component AS_CNT
        port (
            RST_n : in std_logic;
            a_clk : in std_logic;
            CNTR  : out std_logic_vector(3 downto 0));
    end component;
begin
    uut: AS_CNT port map (
        RST_n => RST_n,
        a_clk => a_clk,
        CNTR  => CNTR);
    clock_process : process
    begin
        a_clk <= '0';
        wait for 10 ns;
        a_clk <= '1';
        wait for 10 ns;
    end process;

    stimulus_process: process
    begin
        RST_n <= '0';
        wait for 20 ns;
        RST_n <= '1';
        wait for 100 ns;
        RST_n <= '0';
        wait for 20 ns;
        RST_n <= '1';
        wait for 100 ns;
        wait;
    end process;
end behavior;