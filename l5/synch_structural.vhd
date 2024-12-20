library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Synchronous_Counter is
    Port (Clock, EN     : in  STD_LOGIC;
        Q         : out STD_LOGIC_VECTOR (3 downto 0);
        CO        : out STD_LOGIC);
end Synchronous_Counter;

architecture Structural of Synchronous_Counter is
    component JK_FlipFlop
        Port (J, K, Clock     : in  STD_LOGIC;
            Q, Qbar     : out STD_LOGIC);
    end component;
    signal Q_internal : STD_LOGIC_VECTOR (3 downto 0);
    signal Qbar       : STD_LOGIC_VECTOR (3 downto 0);
    signal J0, K0, J1, K1, J2, K2, J3, K3 : STD_LOGIC;
begin
    FF0: JK_FlipFlop
        Port map (J0 => EN, K0 => EN, Clock => Clock, Q => Q_internal(0), Qbar => Qbar(0));
    FF1: JK_FlipFlop
        Port map (J1 => Q_internal(0) and EN, K1 => Q_internal(0) and EN, Clock => Clock, Q => Q_internal(1), Qbar => Qbar(1));
    FF2: JK_FlipFlop
        Port map (J2 => Q_internal(1) and Q_internal(0) and EN, K2 => Q_internal(1) and Q_internal(0) and EN, Clock => Clock, Q => Q_internal(2), Qbar => Qbar(2));
    FF3: JK_FlipFlop
        Port map (J3 => Q_internal(2) and Q_internal(1) and Q_internal(0) and EN, K3 => Q_internal(2) and Q_internal(1) and Q_internal(0) and EN, Clock => Clock, Q => Q_internal(3), Qbar => Qbar(3));
    
    FF0: JK_FlipFlop
        Port map (J => J0, K => K0, Clock => Clock, Q => Q_internal(0), Qbar => Qbar(0));

    FF1: JK_FlipFlop
        Port map (J => J1, K => K1, Clock => Clock, Q => Q_internal(1), Qbar => Qbar(1));

    FF2: JK_FlipFlop
        Port map (J => J2, K => K2, Clock => Clock, Q => Q_internal(2), Qbar => Qbar(2));

    FF3: JK_FlipFlop
        Port map (J => J3, K => K3, Clock => Clock, Q => Q_internal(3), Qbar => Qbar(3));

    Q <= Q_internal;
    CO <= Q_internal(0) and Q_internal(1) and Q_internal(2) and Q_internal(3);

end Structural;

