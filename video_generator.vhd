library ieee;
use ieee.std_logic_1164.all;

entity video_generator is
	port(signal vga_blank: in std_logic; 
		  signal	map_vga_radar : in std_logic;
		  signal pointer_radar : in std_logic;
		  signal radar_detection : in std_logic;
		  signal vga_r,vga_g,vga_b : out std_logic_vector(3 downto 0));
end video_generator;

architecture structural of video_generator is

begin


  vga_r <= X"0" when (vga_blank = '0') else
			  X"7" when (radar_detection = '1') else            
			  X"0" when (pointer_radar   = '1') else 
           X"7" when (map_vga_radar   = '1') else
           X"0";

  vga_g <= X"0" when (vga_blank = '0') else
			  X"0" when (radar_detection = '1') else 
			  X"0" when (pointer_radar   = '1') else 
           X"7" when (map_vga_radar   = '1') else
           X"C";

  vga_b <= X"0" when (vga_blank = '0') else
			  X"0" when (radar_detection= '1') else 
			  X"F" when (pointer_radar   = '1') else	 
           X"5" when (map_vga_radar   = '1') else
           X"0";

end structural;