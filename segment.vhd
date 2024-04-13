library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity segment is 
  port(
    clk       : in std_logic;
    data_out  : out std_logic_vector(6 downto 0);
    data_in   : in integer;
    anode     : out std_logic_vector(2 downto 0) := "001"
  );
end segment;

architecture rtl of segment is

  signal counter  : integer := 0;
  signal clk_out  : std_logic;

  signal d1, d2, d3, dTmp : integer;
  signal tmpData : integer;

begin

  u1: entity work.clock_divider port map(
    clk,
    270,
    clk_out
  );

  process (all) is
  begin
    if(rising_edge(clk)) then
      d3 <= data_in / 100;
      dTmp <= data_in - d3*100;
      d2 <= dTmp/10;
      d1 <= dTmp - d2*10;
    end if;
  end process;

  process (all) is
  begin
    if(rising_edge(clk)) then
      case tmpData is
        when 0 =>
          data_out <= "1000000";
        when 1 =>
          data_out <= "1111001";
        when 2 =>
          data_out <= "0100100";
        when 3 =>
          data_out <= "0110000";
        when 4 =>
          data_out <= "0011001";
        when 5 =>
          data_out <= "0010010";
        when 6 =>
          data_out <= "0000010";
        when 7 =>
          data_out <= "1111000";
        when 8 =>
          data_out <= "0000000";
        when 9 =>
          data_out <= "0010000";
      end case;
    end if;
  end process;

  process (all) is
  begin
    if(rising_edge(clk_out)) then
      if(anode = "100") then
        anode <= "001";
      else
        anode <= anode sll 1;
      end if;
    end if;
  end process;

  process (all) is
  begin
  case anode is
    when "001" =>
      tmpData <= d1;
    when "010" =>
      tmpData <= d2;
    when "100" =>
      tmpData <= d3;
  end case;
  end process;

end rtl;