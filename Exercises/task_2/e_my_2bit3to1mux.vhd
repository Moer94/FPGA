-- Implements four 2-to-1 multiplexers.
-- inputs:
--    SW3-0 represent the 4-bit input slv_X, and SW7-4 represent slv_Y
--    SW9 selects either slv_X or slv_Y to drive the output LEDs
-- outputs: 
--    LEDR9-0 show the states of the switches
library ieee;
use ieee.std_logic_1164.all;

entity e_my_2bit3to1mux is 
   port ( SW	:	in		std_logic_vector(9 downto 0);	-- switches
          LEDR	:	out		std_logic_vector(9 downto 0));  -- red LEDs
end entity e_my_2bit3to1mux;

architecture a_my_2bit3to1mux of e_my_2bit3to1mux is

---- Declaration Part -----------------------------------------------

-- Signal Declarations:
	signal sl_S_int							:	std_logic_vector(1 downto 0);
	signal slv_U_int, slv_V_int, slv_W_int	:	std_logic_vector(5 downto 0);
	signal sl_M_int : std_logic_vector(1 downto 0);

begin

---- Assignment Part ------------------------------------------------

-- Concurrent Assignments:
	slv_U_int		<=	SW(1 downto 0);
	slv_V_int		<=	SW(3 downto 2);
	slv_W_int		<=	SW(5 downto 4);
	sl_S_int(1 downto 0)		<=	SW(9 downto 8);

-- long version:
--	slv_M(0)_int	<=	(not(sl_S_int) and slv_X_int(0)) or (sl_S_int and slv_Y_int(0));
--	slv_M(1)_int	<=	(not(sl_S_int) and slv_X_int(1)) or (sl_S_int and slv_Y_int(1));
--	slv_M(2)_int	<=	(not(sl_S_int) and slv_X_int(2)) or (sl_S_int and slv_Y_int(2));
--	slv_M(3)_int	<=	(not(sl_S_int) and slv_X_int(3)) or (sl_S_int and slv_Y_int(3));

-- short version using "generate":
	gen_slv_M: for j in 0 to 3 generate
		slv_M_int(j) <= (not(sl_S_int) and slv_X_int(j)) or (sl_S_int and slv_Y_int(j));
		slv_M_int(j) <=´(not(sl_S_int))
	end generate;

	LEDR(9)		<=	sl_S_int;
	LEDR(8 downto 4)	<=	"00000";
	LEDR(3 downto 0)	<=	slv_M_int;

end architecture a_my_2bit3to1mux;
