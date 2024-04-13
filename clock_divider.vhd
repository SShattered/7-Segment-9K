library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
 
entity clock_divider is
  port ( 
    clk       : in std_logic;
    count     : in natural;
    clock_out : out std_logic
  );
end clock_divider;
 
architecture rtl of clock_divider is
 
  signal counter  : integer := 1;
  signal tmp      : std_logic := '0';
 
begin
 
  process(clk)
  begin
    if(rising_edge(clk)) then
      counter <= counter + 1;
      if (counter = count) then
        tmp <= NOT tmp;
        counter <= 1;
      end if;
    end if;
    clock_out <= tmp;
  end process;
 
end rtl;