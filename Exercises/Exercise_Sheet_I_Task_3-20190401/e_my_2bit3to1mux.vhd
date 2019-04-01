-- Implements a 2-bit wide 3-to-1 multiplexer.
-- inputs:  SW5-0 represent data in 3 groups, slv_U-slv_W
--        SW9-8 selects one group from slv_U to slv_W
-- outputs: LEDR1-0 displays the selected group
library ieee;
use ieee.std_logic_1164.all;

entity e_my_2bit3to1mux is 
   port ( SW   : in   std_logic_vector(9 downto 0);	-- switches
          LEDR : out  std_logic_vector(9 downto 0));-- red LEDs
end entity e_my_2bit3to1mux;

architecture a_my_2bit3to1mux OF e_my_2bit3to1mux IS

---- Declaration Part -----------------------------------------------

-- Signal Declarations:
	signal slv_S_int: std_logic_vector(1 downto 0);
	signal slv_U_int, slv_V_int, slv_W_int: std_logic_vector(1 downto 0);
	signal slv_X_int, slv_M_int : std_logic_vector(1 downto 0);

begin

---- Assignment Part ------------------------------------------------

-- Concurrent Assignments:
	slv_S_int(1 downto 0) <= SW(9 downto 8);
	slv_U_int <= SW(1 downto 0);
	slv_V_int <= SW(3 downto 2);
	slv_W_int <= SW(5 downto 4);

-- long version:
--	slv_X_int(0) <= (not(slv_S_int(0)) and slv_U_int(0)) or (slv_S_int(0) and slv_V_int(0));
--	slv_X_int(1) <= (not(slv_S_int(0)) and slv_U_int(1)) or (slv_S_int(0) and slv_V_int(1));
--	slv_M_int(0) <= (not(slv_S_int(1)) and slv_X_int(0)) or (slv_S_int(1) and slv_W_int(0));
--	slv_M_int(1) <= (not(slv_S_int(1)) and slv_X_int(1)) or (slv_S_int(1) and slv_W_int(1));

-- short version using "generate":
	gen_slv_X_and_slv_M: for j in 0 to 1 generate
		slv_X_int(j) <= (not(slv_S_int(0)) and slv_U_int(j)) or (slv_S_int(0) and slv_V_int(j));
		slv_M_int(j) <= (not(slv_S_int(1)) and slv_X_int(j)) or (slv_S_int(1) and slv_W_int(j));
	end generate;

	LEDR(1 downto 0)	<=	slv_M_int;
	LEDR(9 downto 2)	<=	"00000000";

end architecture a_my_2bit3to1mux;
