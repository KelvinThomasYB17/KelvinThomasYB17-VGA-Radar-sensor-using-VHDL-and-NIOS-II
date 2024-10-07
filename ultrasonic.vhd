library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_components_ultrasonic.all;

entity ultrasonic is
	generic (width: natural := 16;
				MAX_WIDTH_PULSE: natural :=38000);
	port(signal reset_n : in std_logic;
		  signal clk : in std_logic;
		  signal echo: in std_logic;
		  signal trigger : out std_logic;
		  signal distance: out std_logic_vector(width -1 downto 0);
		  signal units_h: out std_logic_vector(6 downto 0);
		  signal tens_h: out std_logic_vector(6 downto 0);
		  signal hundreds_h: out std_logic_vector(6 downto 0));
end ultrasonic;

architecture structural of ultrasonic is 
  
  signal rst_sync_trigger : std_logic:='0';
  signal rst_sync_up : std_logic:='1';
  
  
  signal count_trigger : std_logic_vector(width -1 downto 0);
  signal count_up  : std_logic_vector(width -1 downto 0);
  signal distance_std_logic  : std_logic_vector(width -1 downto 0);
  signal distance_display_cut : std_logic_vector(9 downto 0);
  signal count_trigger_u : unsigned(width -1 downto 0);
  signal count_up_u  : unsigned(width -1 downto 0);  
  signal distance_count : unsigned(width -1 downto 0):= (others => '0');
  signal distance_hold : unsigned(width -1 downto 0):= (others => '0');
  signal distance_hold2 : unsigned(width -1 downto 0):= (others => '0');	
  signal enable: std_logic;
  signal hexa_distance : std_logic_vector(11 downto 0);
  signal enable_bcd: std_logic;
  
begin
  
  	B1: divisor_freq
							generic map( N => 5,
											 BUS_WIDTH => 26)
							port map   (reset_n => reset_n,
											clk => clk,
											clk_o   =>  enable);
											
  	B2: counter
							generic map( width  =>  16)
							port map   (reset_n =>  reset_n,
											rst_sync => rst_sync_trigger,
											clk     =>  clk,
											en      =>  enable,
										   q   =>  count_trigger);									
									
  	B3: counter
							generic map( width  =>  16)
							port map   (reset_n =>  reset_n,
											rst_sync => rst_sync_up,
											clk     =>  clk,
											en      =>  enable,
										   q   =>  count_up);		

  	B4: bintobcd 
							port map   (a       =>  distance_display_cut,
											f       =>  hexa_distance);

  	B5: hexa
							port map   (a       =>  hexa_distance(11 downto 8),
											f       =>  hundreds_h);
											
  	B6: hexa 
							port map   (a       =>  hexa_distance(7 downto 4),
											f       =>  tens_h);				
  	B7: hexa 
							port map   (a       =>  hexa_distance(3 downto 0),
											f       =>  units_h);
	

  	B8: divisor_freq
							generic map( N => 50,
											 BUS_WIDTH => 26)
							port map   (reset_n => reset_n,
											clk => clk,
											clk_o   =>  enable_bcd);	
									
  process(count_trigger_u)
    begin
			
		if (count_trigger_u > 9 and count_trigger_u <= 21) then
			trigger <= '1';						
		else 
			trigger <= '0';			
		end if;
		
		if count_trigger_u > MAX_WIDTH_PULSE then
			rst_sync_trigger <= '1';
		else 
			rst_sync_trigger <= '0';
		end if;			
	end process;


	
	process(echo, count_trigger_u, count_up_u, distance_hold)
		begin
			
   		if (echo = '1')  then --(echo = '1') 
				rst_sync_up <= '0';
				distance_count <= distance_hold;	--count_up_u
			else
					rst_sync_up <= '1';
					if count_trigger_u > 21 then
						distance_count <= count_up_u;--distance_hold
					else 
						distance_count <= distance_hold;
					end if;	
			end if;	

	
	end process;		
	
	process(reset_n, clk)
		begin
		if (reset_n = '0') then
			distance_hold <=(others => '0');
		elsif rising_edge(Clk) then
			if (enable_bcd= '1') then
				if (distance_count > 0)  then
					distance_hold <= distance_count;
				else 
					distance_hold <= distance_hold2;
				end if;	
			end if;
		end if;	
	end process;

	--distance_hold <= distance_count;
	distance_hold2 <= distance_hold;
	distance_std_logic <= std_logic_vector(distance_hold/580);  --58
	distance <= distance_std_logic;
	distance_display_cut <= distance_std_logic(9 downto 0);
	count_trigger_u <= unsigned(count_trigger);
	count_up_u <= unsigned(count_up);
	
end structural;	