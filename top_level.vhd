library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity top_level is
  port (
    i_clock       : in  std_logic;
    i_switch_1    : in  std_logic;
    i_switch_2    : in  std_logic;
    segment       : out std_logic_vector(6 downto 0);
    anode         : out std_logic_vector(2 downto 0)
    );
end top_level;
 
architecture rtl of top_level is

  signal my_clk : std_logic;
  signal number : integer range 0 to 999 := 0;
   
begin

  u1: entity work.segment port map (
    i_clock,
    segment,
    number,
    anode
  );

  u2: entity work.clock_divider port map (
    i_clock,
    900000,
    my_clk
  );

  process (my_clk) is
  begin
    if(rising_edge(my_clk)) then
      if(number > 999) then
        number <= 0;
      elsif(i_switch_2 = '0') then
        number <= number + 1;
      elsif(i_switch_1 = '0') then
        number <= 0;
      end if;
    end if;
  end process;
 
end rtl;