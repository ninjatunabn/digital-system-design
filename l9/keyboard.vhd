library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity keyboard is
Port (clk, rst, kd, kc:std_logic;
       an: out std_logic_vector (3 downto 0);
       sseg: out std_logic_vector(6 downto 0));
end keyboard;
 
architecture Behavioral of keyboard is
    signal clkDiv: std_logic_vector(25 downto 0);
    signal sclk, pclk, bclk: std_logic;
    signal num1: std_logic_vector(3 downto 0):="0000";
    signal num2: std_logic_vector(3 downto 0):="1101";
    signal sum: std_logic_vector(3 downto 0):="0000";
    signal sum1: std_logic_vector(3 downto 0):="0000";
    signal sum2: std_logic_vector(3 downto 0):="0000";
    signal op: std_logic_vector(1 downto 0):="00";
    signal op1:std_logic_vector(1 downto 0):="00";
    signal kdi, kci: std_logic;
    signal DFF1, DFF2: std_logic;
    signal shiftRegSig1: std_logic_vector(10 downto 0);
    signal shiftRegSig2: std_logic_vector(10 downto 0);
    signal muxout: std_logic_vector(3 downto 0);
    signal waitReg: std_logic_vector(7 downto 0);
    signal scancode: std_logic_vector(7 downto 0); 
    signal keyValue: std_logic_vector(3 downto 0); 
    signal an_i: std_logic_vector(3 downto 0);
begin
     an <= an_i;
    clkdivider: Process (clk)
    begin
     if(clk = '1' and clk'Event) then
      clkDiv <= clkDiv + 1;
     end if;
    end Process;
 
    sclk <= clkDiv(12);
    pclk <= clkDiv(3);
    bclk <= clkDiv(25);
	  
    Process(pclk, rst, kc, kd)
    begin
     if(rst = '1') then
        DFF1 <= '0';
        DFF2 <= kd;
        kdi <= '0';
        kci <= '0';
     else
        if(pclk = '1' and pclk'EVENT) then
            DFF1 <= kd;
            kdi <= DFF1;
            DFF2 <= kc;
            kci <= DFF2;
        end if;
     end if;
    end process;
 
    Process(kdi, kci, rst)
    begin
        if(rst = '1') then
            shiftRegSig1 <= "00000000000";
            shiftRegSig2 <= "00000000000";
        else
            if(kci = '0' and kci'EVENT) then
                shiftRegSig1(10 downto 0) <= kdi & shiftRegSig1(10 downto 1);
                shiftRegSig2(10 downto 1) <= shiftRegSig1(0) & shiftRegSig2(10 downto 2);
            end if;
        end if;
    end process;
 
    process(shiftRegSig1, shiftRegSig2, rst, kci)
    begin
     if(rst = '1') then
        waitReg <= "00000000";
     else
        if(kci'Event and kci = '1' and shiftRegSig2(8 downto 1) = "11110000") then
            waitReg <= shiftRegSig1(8 downto 1);
        end if;
     end if;
    end process;
 
    scancode <= waitReg(7 downto 0);
 
    process(scancode, bclk, rst)
    begin
     case scancode is
        when "01101001" => keyValue <= "0001"; -- 1
        when "01110010" => keyValue <= "0010"; -- 2
        when "01111010" => keyValue <= "0011"; -- 3
        when "01101011" => keyValue <= "0100"; -- 4
        when "01110011" => keyValue <= "0101"; -- 5
        when "01110100" => keyValue <= "0110"; -- 6
        when "01101100" => keyValue <= "0111"; -- 7
        when "01110101" => keyValue <= "1000"; -- 8
        when "01111101" => keyValue <= "1001"; -- 9
	when "01111001" => op <= "01"; -- +
        when "01111011" => op <= "10"; -- -
	when others => keyValue <= "0000"; -- 0
     end case;
     if rst = '1' then
        num1 <= "0000";
        num2 <= "1101";
        op <="00";
     elsif (bclk'event and bclk = '1') then
        if num1 = "0000" then
            num1 <= keyValue; 
        elsif num2 = "1101" then
            num2 <= keyValue; 
        end if;        
     end if;
    end process;
      
    process (num1, num2, op )
	begin    
            if op="01"then 
              sum <= num1 + num2;
              if sum > "1001" then 
                  sum2 <= sum - "1010";
                  sum1 <= "0001";
              elsif sum < "1001" then 
                  sum2 <= sum;
                  sum1 <= "0000";
              end if;
            elsif op="10" then 
              sum2<= num1 - num2;
            elsif op="00" then 0
                sum2 <= "0000";
                  sum1 <= "0000";
            end if;
    end process;
 
      process(sclk, rst)
      begin
          if rst = '1' then
              an_i <= "0000";
              muxout <= "0000";
          elsif (sclk'event and sclk = '1') then
              case an_i is
                  when "1110" =>
                      muxout <= num1;
                      an_i <= "1101";
                  when "1101" =>
                      muxout <= num2;
                      an_i <= "1011";
                  when "1011" =>
                      muxout <= sum2;
                      an_i <= "0111";
					  when "0111" =>
                      muxout <= sum1;
                      an_i <= "1110";
                  when others =>
                      an_i <= "1110";
              end case;
          end if;
      end process;
      
        sseg <=         "1000000" when muxout = "0000" else
                        "1111001" when muxout = "0001" else
                        "0100100" when muxout = "0010" else
                        "0110000" when muxout = "0011" else
                        "0011001" when muxout = "0100" else
                        "0010010" when muxout = "0101" else
                        "0000010" when muxout = "0110" else
                        "1111000" when muxout = "0111" else
                        "0000000" when muxout = "1000" else
                        "0010000" when muxout = "1001" els
e
					"1111111";
end Behavioral;
