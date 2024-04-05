library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity led_patterns is
port(reset,clk,sel: in std_logic; led_array : out std_logic_vector(7 downto 0));
end led_patterns;

architecture Behavioral of led_patterns is
type states is (idle,sel_wait,ascend,descend,expand,contract,expand_single,
                contract_single,up8bit,down8bit);
signal led_array_signal: std_logic_vector(7 downto 0):= "00000000";
signal array_part_one: std_logic_vector(3 downto 0):= "0000";
signal array_part_two: std_logic_vector(3 downto 0):= "0000";
signal current_state,next_state,next_state_after_wait:states;
signal count: integer range 0 to 2 := 0;
signal set: std_logic := '0';
begin
process(clk)  -- Clock division
begin
if rising_edge(clk) then
    if count = 2 then
        count <= 0;
        set <= '1';
    else
        count <= count + 1;
        set <= '0';
    end if;
end if;
end process;

process(clk) -- Reset handling
begin
    if reset = '1' then
        current_state <= idle;
    elsif rising_edge(clk) then
        current_state <= next_state;
    end if;
end process;

process(clk) -- State transitions
begin
    if rising_edge(clk) then
    case current_state is
        when idle => -- Idle state -> All Leds are on
            led_array_signal <= "11111111";
            if sel = '1' then
                led_array_signal <= "00000000";
                next_state <= sel_wait;
                next_state_after_wait <= ascend;
            end if;
        
        when sel_wait => -- Wait for the sel button to be released after being pressed
            if sel = '0' then
                next_state <= next_state_after_wait;
            end if;
            
        when ascend => -- Leds ascend cumulatively
            if set = '1' then 
                if led_array_signal = "11111111" then
                    led_array_signal <= "00000000";
                else
                    led_array_signal <= '1' & led_array_signal(7 downto 1);
                end if;
            end if;
            if sel = '1' then
                next_state <= sel_wait;
                next_state_after_wait <= descend;
                led_array_signal <= "00000000";
            end if;
            
        when descend => -- Leds descend cumulatively
            if set = '1' then
            if led_array_signal = "11111111" then
                led_array_signal <= "00000000";
            else
                led_array_signal <= led_array_signal(6 downto 0) & '1';
            end if;
        end if;
            if sel = '1' then
                next_state <= sel_wait;
                next_state_after_wait <= expand;
            end if;
            
        when expand => -- Leds start from the ends and expand towards the middle
            led_array_signal <= array_part_one & array_part_two;
            if set = '1' then
                if led_array_signal = "11111111" then
                    array_part_one <= "0000";
                    array_part_two <= "0000";
                else
                    array_part_one <= '1' & array_part_one(3 downto 1);
                    array_part_two <= array_part_two(2 downto 0) & '1';
                end if;
            end if;
            if sel = '1' then
                next_state <= sel_wait;
                next_state_after_wait <= contract;
                array_part_one <= "0000";
                array_part_two <= "0000";
            end if;
            
        when contract => -- Leds start from the middle and contract towards the ends
            led_array_signal <= array_part_one & array_part_two;
            if set = '1' then
                if led_array_signal = "11111111" then
                    array_part_one <= "0000";
                    array_part_two <= "0000";
                else
                    array_part_two <= '1' & array_part_two(3 downto 1);
                    array_part_one <= array_part_one(2 downto 0) & '1';
                end if;
            end if;
            if sel = '1' then
                next_state <= sel_wait;
                next_state_after_wait <= expand_single;
                array_part_one <= "0001";
                array_part_two <= "1000";
            end if;
            
            
        when expand_single => -- Leds start from the ends and expand towards the middle single at a time
            led_array_signal <= array_part_one & array_part_two;
            if set = '1' then
                if led_array_signal = "00000000" then
                    array_part_two <= "1000";
                    array_part_one <= "0001";
                else
                    array_part_two <= '0' & array_part_two(3 downto 1);
                    array_part_one <= array_part_one(2 downto 0) & '0';
                end if;
            end if;
            if sel = '1' then
                next_state <= sel_wait;
                next_state_after_wait <= contract_single;
                array_part_one <= "1000";
                array_part_two <= "0001";
            end if;
            
        when contract_single => -- Leds start from the middle and contract towards the ends single at a time
            led_array_signal <= array_part_one & array_part_two;
            if set = '1' then
                if led_array_signal = "00000000" then
                    array_part_one <= "1000";
                    array_part_two <= "0001";
                else
                    array_part_one <= '0' & array_part_one(3 downto 1);
                    array_part_two <= array_part_two(2 downto 0) & '0';
                end if;
            end if;
            if sel = '1' then
                next_state <= sel_wait;
                next_state_after_wait <= up8bit;
                led_array_signal <= "00000000";
            end if;  
            
        when up8bit => -- 8-bit up counter
            if set = '1' then
                if led_array_signal = "11111111" then
                    led_array_signal <= "00000000";
                else
                    led_array_signal <= led_array_signal + 1;
                end if;
            end if;
            if sel = '1' then
                next_state <= sel_wait;
                next_state_after_wait <= down8bit;
                led_array_signal <= "11111111";
            end if;
            
        when down8bit => -- 8-bit down counter
            if set = '1' then
                if led_array_signal = "00000000" then
                    led_array_signal <= "11111111";
                else
                    led_array_signal <= led_array_signal - 1;
                end if;
            end if;
            if sel = '1' then
                next_state <= sel_wait;
                next_state_after_wait <= idle;
            end if;
                
        when others =>
            next_state <= sel_wait;
            next_state_after_wait <= idle;
        end case;
end if;      
end process;
led_array <= led_array_signal;
end Behavioral;
