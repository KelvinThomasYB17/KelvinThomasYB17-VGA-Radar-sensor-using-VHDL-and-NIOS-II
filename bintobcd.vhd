
library ieee;
use ieee.std_logic_1164.all;

entity bintobcd is
  port(signal a  :  in std_logic_vector(9 downto 0);
	   signal f  : out std_logic_vector(11 downto 0)) ;
end bintobcd;

architecture structural of bintobcd is

  constant DONT_CARE : std_logic_vector(11 downto 0):= (others => '-');
  
  signal a_int : std_logic_vector(11 downto 0);

begin

  a_int <= "00" & a;

  with a_int select
    f <= x"000" when x"000",
         x"001" when x"001",
         x"002" when x"002",
         x"003" when x"003",
         x"004" when x"004",
         x"005" when x"005",
         x"006" when x"006",
         x"007" when x"007",
         x"008" when x"008",
         x"009" when x"009",			 
         x"010" when x"00A",
         x"011" when x"00b",
         x"012" when x"00C",
         x"013" when x"00d",
         x"014" when x"00E",
         x"015" when x"00F",
         x"016" when x"010",
         x"017" when x"011",		 
         x"018" when x"012",
         x"019" when x"013",
         x"020" when x"014",	
         x"021" when x"015",
         x"022" when x"016",		 
         x"023" when x"017",
         x"024" when x"018",
         x"025" when x"019",	
         x"026" when x"01A",
         x"027" when x"01b",		 
         x"028" when x"01C",
         x"029" when x"01d",
         x"030" when x"01E",	
         x"031" when x"01F",	 
         x"032" when x"020",
         x"033" when x"021",
         x"034" when x"022",
         x"035" when x"023",
         x"036" when x"024",
         x"037" when x"025",
         x"038" when x"026",
         x"039" when x"027",
         x"040" when x"028",
         x"041" when x"029",			 
         x"042" when x"02A",
         x"043" when x"02b",
         x"044" when x"02C",
         x"045" when x"02d",
         x"046" when x"02E",
         x"047" when x"02F",
         x"048" when x"030",
         x"049" when x"031",		 
         x"050" when x"032",
         x"051" when x"033",
         x"052" when x"034",	
         x"053" when x"035",
         x"054" when x"036",		 
         x"055" when x"037",
         x"056" when x"038",
         x"057" when x"039",	
         x"058" when x"03A",
         x"059" when x"03b",		 
         x"060" when x"03C",
         x"061" when x"03D",
         x"062" when x"03E",	
         x"063" when x"03F",
         DONT_CARE when others;

end structural;
