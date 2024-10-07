library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity radar_detector is
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
		  signal adc_row : in std_logic_vector(width -1 downto 0);
		  signal radar_detection : out std_logic);
end radar_detector;

architecture structural of radar_detector is 

  signal n_rows_int : integer range 0 to 1022 := 0;
  signal n_columns_int : integer range 0 to 1022  := 0;
  signal detection_x : integer range 0 to 1022 := 0;
  signal detection_y : integer range 0 to 1022  := 0;
  signal temp : integer range 0 to 1022  := 0;
  type IntegerArrayType is array (0 to 320) of integer;
  signal my_integer_array_x : IntegerArrayType;
  signal index_x : integer range 0 to 320 := 0;

  signal my_integer_array_y : IntegerArrayType;
  signal index_y : integer range 0 to 320 := 0; 
  signal duty_final : integer range 0 to 255 := 0;
  
  
begin

  n_rows_int <= to_integer(unsigned(n_rows));
  n_columns_int <= to_integer(unsigned(n_columns));
  
  detection_x <=to_integer(unsigned(adc_column));
  detection_y <=to_integer(unsigned(adc_row));
  
  duty_final<=to_integer(unsigned(duty));
  
  
  
  process(clk, reset_n)
    begin
		if (reset_n = '0' or duty_final = 0) then
			
            for i in my_integer_array_x'range loop
                my_integer_array_x(i) <= 320;
            end loop;
				
            for i in my_integer_array_y'range loop
                my_integer_array_y(i) <= 480;
            end loop;
				
				index_x <= 0;
				index_y <= 0;
				
			elsif rising_edge(Clk) then
				if (enable= '1') then			  
					if(index_x < 320 or index_y < 320) then
						my_integer_array_x(index_x) <= detection_x;
						my_integer_array_y(index_y) <= detection_y;
						temp <= detection_x;
						if temp = detection_x  then
							index_x <= index_x;
							index_y <= index_y;
							
						else  
							index_x <= index_x + 1;
							index_y <= index_y + 1;
							temp <= detection_x;
						end if;
					end if;
				end if;
			end if;
	end process;
	
	process(n_columns_int, n_rows_int)
   begin
	 for i in my_integer_array_x'range loop
            if (my_integer_array_x(i) = n_columns_int) and (my_integer_array_y(i) = n_rows_int) then
					radar_detection <= '1';
					exit;
				else
 					radar_detection <= '0';
				end if;
    end loop;
	end process;	
	
end structural;