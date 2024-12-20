library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sec is
    Port ( mclk, start, stop, rst : in  STD_LOGIC;
           anode  : out  STD_LOGIC_VECTOR (3 downto 0);
           ssg : out  STD_LOGIC_VECTOR (6 downto 0));
end sec;

architecture Behavioral of sec is
    signal digit: std_logic_vector(3 downto 0) := "0000";
    signal clkdiv: std_logic_vector(25 downto 0) := (others => '0');
    signal cclk: std_logic;
    signal button_clk: std_logic;
    signal anode_i: std_logic_vector(3 downto 0) := "1110";
    signal dig: std_logic_vector(6 downto 0) := "0000000";
    signal second: std_logic_vector(3 downto 0) := "0000";
    signal second1: std_logic_vector(3 downto 0) := "0000";
    signal minute: std_logic_vector(3 downto 0) := "0000";
    signal minute1: std_logic_vector(3 downto 0) := "0000";
    signal running: std_logic := '0';  
begin
    anode <= anode_i;
    dig <= "0111111" when digit = "0000" else 
           "0000110" when digit = "0001" else  
           "1011011" when digit = "0010" else  
           "1001111" when digit = "0011" else  
           "1100110" when digit = "0100" else 
           "1101101" when digit = "0101" else  
           "1111101" when digit = "0110" else
           "0000111" when digit = "0111" else  
           "1111111" when digit = "1000" else
           "1101111" when digit = "1001" else  
           "0001000"; 

    ssg <= not dig; 
	 
    process(mclk)
    begin
        if (mclk = '1' and mclk'Event) then
            clkdiv <= clkdiv + 1;
        end if;
    end process;

    cclk <= clkdiv(15);  
    button_clk <= clkdiv(25);  

    process(button_clk)
    begin
        if (button_clk = '1' and button_clk'Event) then
            if rst = '1' then
                second <= "0000";
                minute <= "0000";
                second1 <= "0000";
                minute1 <= "0000";
                running <= '0'; 
            elsif start = '1' then
                running <= '1';  
            elsif stop = '1' then
                running <= '0';  
            elsif running = '1' then
                if second = "1001" then  
                    second <= "0000";
                    if second1 = "0101" then  
                        second1 <= "0000";  
                        if minute = "1001" then  
                            minute <= "0000"; 
                            if minute1 = "0101" then  
                                minute1 <= "0000"; 
                            else
                                minute1 <= minute1 + 1;  
                            end if;
                        else
                            minute <= minute + 1;  
                        end if;
                    else 
                        second1 <= second1 + 1; 
                    end if;
                else 
                    second <= second + 1;  
                end if;
            end if;
        end if;
    end process;

    process(cclk, rst)
    begin
        if rst = '1' then
            anode_i <= "1110";  
            digit <= "0000"; 
        elsif (cclk = '1' and cclk'Event) then
            case anode_i is
                when "1110" =>
                    digit <= second(3 downto 0); 
                    anode_i <= "1101";
                when "1101" =>
                    digit <= second1(3 downto 0); 
                    anode_i <= "1011";
                when "1011" =>
                    digit <= minute(3 downto 0); 
                    anode_i <= "0111";
                when "0111" =>
                    digit <= minute1(3 downto 0); 
                    anode_i <= "1110";
                when others =>
                    digit <= "0000";  
                    anode_i <= "1110";
            end case;
        end if;
    end process;

end Behavioral;
