library ieee;
use ieee.std_logic_1164.all;

-- Converts 2-bit input code on C1-0 into 7-bit code that produces
-- a character on a 7-segment display. The conversion is defined by:
--     C  1 0   Char
--    ----------------
--        0 0    'd'
--        0 1    'E'
--        1 0    '1'
--        1 1    ' ' blank
--
--
entity e_7segdec is
   port ( slv_C       : in  std_logic_vector(1 downto 0);
          slv_Display : out std_logic_vector(0 to 6));
end entity e_7segdec;
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
architecture a_7segdec OF e_7segdec IS

---- Declaration Part -----------------------------------------------

begin

---- Assignment Part ------------------------------------------------

-- Concurrent Assignments:
	-- the following equations describe display functions in (inverted)
	-- cannonical SOP form
	slv_Display(0) <= not( not(slv_C(1)) and slv_C(0)); 
	slv_Display(1) <= slv_C(0); 
	slv_Display(2) <= slv_C(0); 
	slv_Display(3) <= slv_C(1); 
	slv_Display(4) <= slv_C(1);
	slv_Display(5) <= not( not(slv_C(1)) and slv_C(0)); 
	slv_Display(6) <= slv_C(1);   

end architecture a_7segdec;
