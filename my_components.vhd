library ieee;
use ieee.std_logic_1164.all;

package my_components is
	
	component counter is
	generic (width: natural := 10);
	port(signal reset_n : in std_logic;
		  signal rst_sync : in std_logic;
		  signal clk : in std_logic;
		  signal en : in std_logic;
		  signal q : out std_logic_vector(width -1 downto 0));
	end component counter;
	
	
	component divisor_freq is
	generic (N         : natural := 50000000;        
           BUS_WIDTH : natural := 26);
	port (signal reset_n :  in std_logic;
			signal clk     :  in std_logic;
			signal clk_o   : out std_logic);
	end component divisor_freq;

end my_components;