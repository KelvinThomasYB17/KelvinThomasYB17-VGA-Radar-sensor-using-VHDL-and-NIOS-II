library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_blocks.all;

entity vga_radar is
	generic (width: natural := 10;
				WEIGHT_SCREEN: integer := 640;
				HEIGHT_SCREEN: integer := 480);
	port(signal reset_n : in std_logic;
		  signal clk : in std_logic;
		  signal duty: in std_logic_vector(7 downto 0);
		  signal adc_column: in std_logic_vector(width -1 downto 0);
		  signal adc_row: in std_logic_vector(width -1 downto 0);
		  signal vga_hs, vga_vs : out std_logic;
		  signal vga_r, vga_g, vga_b : out std_logic_vector (3 downto 0));
end vga_radar;


architecture structural of vga_radar is

	signal enable : std_logic;
	signal vga_blank : std_logic;
	signal map_vga_radar : std_logic;
	signal pointer_radar : std_logic;
	signal radar_detection : std_logic;	
	--signal radar_beam_line : std_logic;
	signal n_columns : std_logic_vector(width -1 downto 0);
	signal n_rows : std_logic_vector(width -1 downto 0);	
	--signal adc_column_inside : std_logic_vector(width -1  downto 0):= "";
	--signal adc_row_iniside : std_logic_vector(width -1 downto 0):="";
	
begin 

  	B1: divisor_freq 
							generic map( N => 500000,
											 BUS_WIDTH => 26)
							port map   (reset_n => reset_n,
											clk => clk,
											clk_o   =>  enable);

  	B2: vga 
							generic map( width => width)
							port map   (reset_n => reset_n,
											clk => clk,
											vga_hs => vga_hs,
											vga_vs => vga_vs,
											vga_blank => vga_blank,
											n_columns => n_columns,
											n_rows => n_rows);
											
  	B3: radar_screen 
							generic map( width => width,
											WEIGHT_SCREEN => WEIGHT_SCREEN,
											HEIGHT_SCREEN => HEIGHT_SCREEN)
							port map   (n_columns => n_columns,
											n_rows => n_rows,
											map_vga_radar => map_vga_radar,
											pointer_radar => pointer_radar);
	B4: radar_detector
							generic map( width => width,
											WEIGHT_SCREEN => WEIGHT_SCREEN,
											HEIGHT_SCREEN => HEIGHT_SCREEN)
							port map   (clk => clk,
											reset_n => reset_n,
											enable => enable,
											duty => duty,
											n_columns => n_columns,
											n_rows => n_rows,
											adc_column => adc_column,
											adc_row => adc_row,
											radar_detection => radar_detection);

  	B5: video_generator
							port map   (vga_blank =>  vga_blank,
											map_vga_radar => map_vga_radar,
											pointer_radar => pointer_radar,
											radar_detection => radar_detection,
										   vga_r   =>  vga_r,
											vga_g   =>  vga_g,
											vga_b   =>  vga_b);	
	
  	--B6: radar_beam
	--						generic map( width => width,
	--										WEIGHT_SCREEN => WEIGHT_SCREEN,
	--										HEIGHT_SCREEN => HEIGHT_SCREEN)
	--						port map   (clk => clk,
	--										reset_n => reset_n,
	--										enable => enable,
	--										n_columns => n_columns,
	--										n_rows => n_rows,
	--										adc_column => adc_column_inside,
	--										adc_row => adc_row_iniside,
	--										radar_beam_line => radar_beam_line);
	
end structural;