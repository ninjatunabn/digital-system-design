library IEEE;
use IEEE.std_logic_1164.all;

entity tb_asynch is
end tb_asynch;

architecture arch_asynch of tb_asynch is
    component AS_CNT
        port (
            RST_n : in std_logic;
            a_clk : in std_logic;
            CNTR  : out std_logic_vector(3 downto 0)); end component;

    signal RST_n : std_logic := '1';
    signal a_clk : std_logic := '0';
    signal CNTR  : std_logic_vector(3 downto 0);
begin
    uut: AS_CNT
        port map (
            RST_n => RST_n,
            a_clk => a_clk,
            CNTR  => CNTR);

    clk_process: process
    begin
        while true loop
            a_clk <= '0';
            wait for 10ns;
            a_clk <= '1';
            wait for 10ns;
        end loop;
    end process;

    stim: process
    begin
        RST_n <= '0';
        wait for 30 ns; 
        RST_n <= '1';
        wait for 200 ns; 
        RST_n <= '0';
        wait for 30 ns;
        RST_n <= '1';
        wait for 100 ns;
        wait;
    end process;
end arch_asynch;
