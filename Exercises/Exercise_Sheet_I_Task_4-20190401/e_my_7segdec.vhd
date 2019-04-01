-- Implements a circuit that can display five characters on a 7-segment
-- display. 
-- inputs:  SW1-0 selects the letter to display. The characters are:
--    SW  1 0  Char
--    ----------------
--        0 0 'd'
--        0 1 'E'
--        1 0 '1'
--        1 1  blank
-- outputs: LEDR2-0 show the states of the switches
--          HEX0 displays the selected character
library ieee;
use ieee.std_logic_1164.all;

entity e_my_7segdec is 
   PORT ( SW    : in   std_logic_vector(1 downto 0);   -- toggle switches
          LEDR  : out  std_logic_vector(9 downto 0);   -- red LEDs
          HEX0  : out  std_logic_vector(0 to 6));      -- 7-seg display
end entity e_my_7segdec;

architecture a_my_7segdec of e_my_7segdec is

---- Declaration Part -----------------------------------------------

-- Signal Declarations:
	signal slv_C_int : std_logic_vector(1 downto 0);

begin

---- Assignment Part ------------------------------------------------

-- Concurrent Assignments:
	LEDR(1 downto 0) <= SW;
	LEDR(9 downto 2) <= "00000000";

	slv_C_int <= SW;
	--
	--       0  
	--      ---  
	--     |   |
	--    5|   |1
	--     | 6 |
	--      ---  
	--     |   |
	--    4|   |2
	--     |   |
	--      ---  
	--       3  
	--
	-- the following equations describe display functions in (inverted) 
	-- cannonical SOP form
	HEX0(0) <= not( not(slv_C_int(1)) and slv_C_int(0)); 
	HEX0(1) <= slv_C_int(0); 
	HEX0(2) <= slv_C_int(0); 
	HEX0(3) <= slv_C_int(1); 
	HEX0(4) <= slv_C_int(1);
	HEX0(5) <= not( not(slv_C_int(1)) and slv_C_int(0)); 
	HEX0(6) <= slv_C_int(1);

end a_my_7segdec;