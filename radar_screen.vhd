library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity radar_screen is
	generic (width: natural := 10;
				WEIGHT_SCREEN: integer := 640;
				HEIGHT_SCREEN: integer := 480);
	port(signal n_columns: in std_logic_vector(width -1 downto 0);
		  signal n_rows: in std_logic_vector(width -1 downto 0);
		  signal map_vga_radar : out std_logic;
		  signal pointer_radar : out std_logic);
end radar_screen;

architecture structural of radar_screen is 

  constant radio : integer := 60; 
  signal circ_1 : boolean;
  signal circ_2 : boolean;
  signal circ_3 : boolean;  
  signal circ_4 : boolean;
  signal circ_5 : boolean;    
  signal circ_6 : boolean;
  signal circ_7 : boolean;
  signal circ_8 : boolean;
  signal circ_9 : boolean;
  signal circ_10 : boolean;
  signal circ_11 : boolean;  
  signal circ_screen : boolean;
  signal eco_1 : boolean;
  signal eco_2 : boolean; 
  signal eco_3 : boolean;
  signal eco_4 : boolean;  

  --signal n_rows_int : integer range 0 to  WEIGHT_SCREEN := 0;
  --signal n_columns_int : integer range 0 to WEIGHT_SCREEN  := 0;
  signal n_rows_int : integer range 0 to 1022 := 0;
  signal n_columns_int : integer range 0 to 1022  := 0;

  begin
  
  n_rows_int <= to_integer(unsigned(n_rows));
  n_columns_int <= to_integer(unsigned(n_columns));

  circ_1 <= (((n_columns_int-WEIGHT_SCREEN/2)*(n_columns_int-WEIGHT_SCREEN/2) + (HEIGHT_SCREEN - n_rows_int)*(HEIGHT_SCREEN - n_rows_int)) <= radio*radio);

  circ_2 <= (((n_columns_int-WEIGHT_SCREEN/2)*(n_columns_int-WEIGHT_SCREEN/2) + (HEIGHT_SCREEN - n_rows_int)*(HEIGHT_SCREEN - n_rows_int)) <= 142*142);
  circ_3 <= (((n_columns_int-WEIGHT_SCREEN/2)*(n_columns_int-WEIGHT_SCREEN/2) + (HEIGHT_SCREEN - n_rows_int)*(HEIGHT_SCREEN - n_rows_int)) >= 138*138);  
 
  circ_4 <= (((n_columns_int-WEIGHT_SCREEN/2)*(n_columns_int-WEIGHT_SCREEN/2) + (HEIGHT_SCREEN - n_rows_int)*(HEIGHT_SCREEN - n_rows_int)) <= 222*222);
  circ_5 <= (((n_columns_int-WEIGHT_SCREEN/2)*(n_columns_int-WEIGHT_SCREEN/2) + (HEIGHT_SCREEN - n_rows_int)*(HEIGHT_SCREEN - n_rows_int)) >= 218*218);  
  
  circ_6 <= (((n_columns_int-WEIGHT_SCREEN/2)*(n_columns_int-WEIGHT_SCREEN/2) + (HEIGHT_SCREEN - n_rows_int)*(HEIGHT_SCREEN - n_rows_int)) <= 302*302);
  circ_7 <= (((n_columns_int-WEIGHT_SCREEN/2)*(n_columns_int-WEIGHT_SCREEN/2) + (HEIGHT_SCREEN - n_rows_int)*(HEIGHT_SCREEN - n_rows_int)) >= 298*298);    
  
  circ_8 <= (((n_columns_int-WEIGHT_SCREEN/2)*(n_columns_int-WEIGHT_SCREEN/2) + (HEIGHT_SCREEN - n_rows_int)*(HEIGHT_SCREEN - n_rows_int)) <= 382*382);
  circ_9 <= (((n_columns_int-WEIGHT_SCREEN/2)*(n_columns_int-WEIGHT_SCREEN/2) + (HEIGHT_SCREEN - n_rows_int)*(HEIGHT_SCREEN - n_rows_int)) >= 378*378);    
  
  circ_10 <= (((n_columns_int-WEIGHT_SCREEN/2)*(n_columns_int-WEIGHT_SCREEN/2) + (HEIGHT_SCREEN - n_rows_int)*(HEIGHT_SCREEN - n_rows_int)) <= 462*462);
  circ_11 <= (((n_columns_int-WEIGHT_SCREEN/2)*(n_columns_int-WEIGHT_SCREEN/2) + (HEIGHT_SCREEN - n_rows_int)*(HEIGHT_SCREEN - n_rows_int)) >= 458*458); 
  
  
  circ_screen <= circ_1 or (circ_2 and circ_3) or (circ_4 and circ_5) or (circ_6 and circ_7) or (circ_8 and circ_9) or (circ_10 and circ_11);
  
 -- eco_1 <=  (n_columns_int - n_rows_int ) <= -161;
 -- eco_2 <=  (n_columns_int - n_rows_int ) >= -163;
  
  eco_1 <=  (n_columns_int - 2*n_rows_int ) <= -641;
  eco_2 <=  (n_columns_int - 2*n_rows_int ) >= -643;  
  eco_3 <=  (n_columns_int + n_rows_int ) <= 801;
  eco_4 <=  (n_columns_int + n_rows_int ) >= 799;

  process(n_rows_int, n_columns_int)
	begin
		if circ_screen then
				map_vga_radar <= '1';
		else
				map_vga_radar <= '0';
		end if;
   end process;
	
  process(n_rows_int, n_columns_int)
	begin
		--if (eco_1 and eco_2) or (eco_3 and eco_4) then
		if (eco_1 and eco_2) then		
		
				pointer_radar <= '1';
		else
				pointer_radar <= '0';
		end if;
   end process;  
  
end structural;