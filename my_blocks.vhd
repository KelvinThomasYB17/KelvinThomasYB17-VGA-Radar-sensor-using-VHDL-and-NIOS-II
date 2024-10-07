library ieee;
use ieee.std_logic_1164.all;

package my_blocks is

	component divisor_freq is
	generic (N         : natural := 50000000;        
           BUS_WIDTH : natural := 26);
	port (signal reset_n :  in std_logic;
			signal clk     :  in std_logic;
			signal clk_o   : out std_logic);
	end component divisor_freq;

	component video_generator is
	port(signal vga_blank: in std_logic; 
		  signal	map_vga_radar : in std_logic;
		  signal pointer_radar : in std_logic;
		  signal radar_detection : in std_logic;
		  signal vga_r,vga_g,vga_b : out std_logic_vector(3 downto 0));
	end component video_generator;	
	
	component vga is
	generic (width: natural := 10);
	port(signal reset_n : in std_logic;
		  signal clk : in std_logic;
		  signal vga_hs, vga_vs : out std_logic;
		  signal vga_blank: out std_logic;
		  signal n_columns, n_rows: out std_logic_vector(width -1 downto 0));
	end component vga;
	
	component radar_screen is
	generic (width: natural := 10;
				WEIGHT_SCREEN: integer := 640;
				HEIGHT_SCREEN: integer := 480);
	port(signal n_columns: in std_logic_vector(width -1 downto 0);
		  signal n_rows: in std_logic_vector(width -1 downto 0);
		  signal map_vga_radar : out std_logic;
		  signal pointer_radar : out std_logic);
	end component radar_screen;

	component radar_detector is
	generic (width: natural := 10;
				WEIGHT_SCREEN: integer := 640;
				HEIGHT_SCREEN: integer := 480);
	port(signal clk :in std_logic;
	     signal reset_n : in std_logic;
		  signal enable : in std_logic;
		  signal duty: in std_logic_vector(7 downto 0);
		  signal n_columns: in std_logic_vector(width -1 downto 0);
		  signal n_rows: in std_logic_vector(width -1 downto 0);
		  signal adc_column: in std_logic_vector(width -1 downto 0);
		  signal adc_row : in std_logic_vector(width - 1 downto 0);
		  signal radar_detection : out std_logic);		
	end component radar_detector;	
	
	--component radar_beam is
	--generic (width: natural := 10;
	--			WEIGHT_SCREEN: integer := 640;
	--			HEIGHT_SCREEN: integer := 480);
	--port(signal clk :in std_logic;
	--     signal reset_n : in std_logic;
	--	  signal enable : in std_logic;
	--	  signal n_columns: in std_logic_vector(width -1 downto 0);
	--	  signal n_rows: in std_logic_vector(width -1 downto 0);
	--	  signal adc_column: in std_logic_vector(width -1 downto 0);
	--	  signal adc_row : in std_logic_vector(width -1 downto 0);
	--	  signal radar_beam_line : out std_logic);
	--end component radar_beam;
	
end my_blocks;