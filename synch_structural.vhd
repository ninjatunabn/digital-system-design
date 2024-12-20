library IEEE;
use IEEE.std_logic_1164.all;

entity synch_struct is
    port(
        clk   : in std_logic;                     
        RST_n : in std_logic;                     
        EN    : in std_logic;                     
        Q     : out std_logic_vector(3 downto 0); 
        CO    : out std_logic);
end synch_struct;

architecture structural of synch_struct is
    component z3_jkff
        port(
            clk   : in std_logic;
            RST_n : in std_logic;
            J     : in std_logic;
            K     : in std_logic;
            Q     : out std_logic;
            Qn    : out std_logic); 
    end component;

    signal Q_int  : std_logic_vector(3 downto 0);
    signal Qn_int : std_logic_vector(3 downto 0); 
begin
    FF0: z3_jkff
        port map(
            clk   => clk,     
            RST_n => RST_n,   
            J     => EN,       
            K     => EN,       
            Q     => Q_int(0), 
            Qn    => Qn_int(0));
    FF1: z3_jkff
        port map(
            clk   => Q_int(0),  
            RST_n => RST_n,     
            J     => EN,        
            K     => EN,        
            Q     => Q_int(1),  
            Qn    => Qn_int(1));
    FF2: z3_jkff
        port map(
            clk   => Q_int(1),  
            RST_n => RST_n,     
            J     => EN,      
            K     => EN,       
            Q     => Q_int(2),  
            Qn    => Qn_int(2));
    FF3: z3_jkff
        port map(
            clk   => Q_int(2), 
            RST_n => RST_n,     
            J     => EN,        
            K     => EN,        
            Q     => Q_int(3),  
            Qn    => Qn_int(3));
    Q <= Q_int; 
    CO <= Q_int(0) and Q_int(1) and Q_int(2) and Q_int(3); 
end structural;