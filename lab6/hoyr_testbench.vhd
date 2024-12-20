library IEEE;
use IEEE.std_logic_1164.all;

entity tb_hoyr is
end tb_hoyr;

architecture arch_tb of tb_hoyr is
    component hoyr is
        port (
            clk         : in std_logic;
            reset       : in std_logic;
            ready       : in std_logic;
            read_write  : in std_logic;
            burst       : in std_logic;
            bus_id      : in std_logic_vector(7 downto 0);
            Z           : out std_logic );end component;

    signal clk         : std_logic := '0';
    signal reset       : std_logic := '0';
    signal ready       : std_logic := '0';
    signal read_write  : std_logic := '0';
    signal burst       : std_logic := '0';
    signal bus_id      : std_logic_vector(7 downto 0) := (others => '0');
    signal Z           : std_logic;

    constant clk_period : time := 10 ns;

begin
    uut: hoyr
        port map (
            clk         => clk,
            reset       => reset,
            ready       => ready,
            read_write  => read_write,
            burst       => burst,
            bus_id      => bus_id,
            Z           => Z);
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period;
        clk <= '1';
        wait for clk_period;
    end process;

    stimulus: process
    begin
        reset <= '1';
        wait for clk_period*2;
        reset <= '0';
        wait for clk_period;

        bus_id <= "11110011"; 
        ready <= '0';          
        read_write <= '0';     
        wait for clk_period;
        ready <= '1';         
        wait for clk_period;
        
        read_write <= '1';    
        burst <= '1';          
        ready <= '0';          
        wait for clk_period;
        ready <= '1';         
        wait for clk_period;  
        wait for clk_period;  
        wait for clk_period;  
        wait for clk_period; 

        bus_id <= "00000000"; 
        ready <= '1';
        wait for clk_period;
        wait;
    end process;
end arch_tb;