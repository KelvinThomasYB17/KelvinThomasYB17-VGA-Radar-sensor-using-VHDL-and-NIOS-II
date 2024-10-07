library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_module is 
	port (
		clk : in std_logic;
		en : in std_logic;
		duty: in std_logic_vector(7 downto 0); --integer 0-255 
		pwm_led: out std_logic;
		pwm_motor: out std_logic
		);
end pwm_module;

architecture rtl of pwm_module is
	signal scount : integer range 0 to 20000;--20000
	signal pulse : integer range 0 to 4000;--2000
	signal duty_integer: integer range 0 to 255;
begin
	
	duty_integer <= to_integer(unsigned(duty));
	pulse <= (duty_integer*2000/255) + 1000;--(duty_integer*1000/255)
	
	process(Clk)
		begin
		
			if (rising_edge(Clk)) then
				if (en = '1') then
					if (scount< 20000) then
						scount <= scount +1;
					else 
						scount <=0;
					end if;
				end if;	
			end if;
	end process;
	
	process(clk)
		begin
			if rising_edge(clk) then
				if (scount< pulse) then
					pwm_led <= '1';
					pwm_motor <= '1';
				else 
					pwm_led <= '0';
					pwm_motor <= '0';
				end if;
			end if;
			
	end process;
end architecture;
