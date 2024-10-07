library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_components.all;

entity vga is
	generic (width: natural := 10);
	port(signal reset_n : in std_logic;
		  signal clk : in std_logic;
		  signal vga_hs, vga_vs : out std_logic;
		  signal vga_blank: out std_logic;
		  signal n_columns, n_rows: out std_logic_vector(width -1 downto 0));
end vga;

architecture structural of vga is

	signal enable : std_logic;
	signal count_columns : std_logic_vector(width -1 downto 0);
	signal count_rows : std_logic_vector(width -1 downto 0);	
	signal rst_sync1 : std_logic;
	signal rst_sync2 : std_logic;	
	signal new_enable : std_logic;
	signal vga_blank_temp1 : std_logic;	
	signal vga_blank_temp2 : std_logic;
	signal count_columns_int : unsigned(width -1 downto 0);
	signal count_rows_int: unsigned(width -1 downto 0);	
	
	begin
	

  	B1: divisor_freq 
							generic map( N => 2,
											 BUS_WIDTH => 26)
							port map   (reset_n => reset_n,
											clk => clk,
											clk_o   =>  enable);
											
  	B2: counter 
							generic map( width  =>  10)
							port map   (reset_n =>  reset_n,
											rst_sync => rst_sync1,
											clk     =>  clk,
											en      =>  enable,
										   q   =>  count_columns);		

  	B3: counter 
							generic map( width  =>  10)
							port map   (reset_n =>  reset_n,
											rst_sync => rst_sync2,
											clk     =>  clk,
											en      =>  new_enable,
										   q   =>  count_rows);
										
	n_columns <=count_columns;
	n_rows <=count_rows;
	count_columns_int <= unsigned(count_columns);
	count_rows_int <= unsigned(count_rows);
	new_enable <= rst_sync1 and enable;
	vga_blank <= vga_blank_temp1 and vga_blank_temp2;
	
									
	P1: process (count_columns_int)
	begin 
		if (count_columns_int < 752 and count_columns_int > 655) then
			vga_hs <= '0';
		else 
			vga_hs <= '1';
		end if;
		
		if (count_columns_int > 639) then
			vga_blank_temp1 <= '0';
		else 
			vga_blank_temp1 <= '1';
		end if;			

		if (count_columns_int = 799) then
			rst_sync1 <= '1';
		else 
			rst_sync1 <= '0';
		end if;	
	end process P1;							
					
	P2: process (count_rows_int)
	begin 
		if (count_rows_int < 491 and count_rows_int > 488) then
			vga_vs <= '0';
		else 
			vga_vs <= '1';
		end if;
		
		if (count_rows_int > 479) then
			vga_blank_temp2 <= '0';
		else 
			vga_blank_temp2 <= '1';
		end if;			

		if (count_rows_int = 519) then
			rst_sync2 <= '1';
		else 
			rst_sync2 <= '0';
		end if;	
	end process P2;	
		
	end structural;			
			
