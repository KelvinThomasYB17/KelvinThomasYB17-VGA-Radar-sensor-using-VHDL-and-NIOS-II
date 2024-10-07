library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	generic (width: natural := 10);
	port(signal reset_n : in std_logic;
		  signal rst_sync : in std_logic;
		  signal clk : in std_logic;
		  signal en : in std_logic;
		  signal q : out std_logic_vector(width -1 downto 0));
end counter;

architecture structural of counter is

	signal q_reg : unsigned(width -1 downto 0);
	signal q_next: unsigned(width -1 downto 0);
	
begin

	seq: process(reset_n,clk)
	begin
		if (reset_n = '0') then
			q_reg <=(others => '0');
		elsif rising_edge(Clk) then
			if (en= '1') then
				if (rst_sync = '1') then
					q_reg <= (others => '0');
				else
					q_reg <= q_reg +1;
				end if;
			end if;
		end if;
	end process seq;
q <= std_logic_vector(q_reg);	
			
end structural;