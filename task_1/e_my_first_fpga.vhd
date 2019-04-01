library ieee;
use ieee.std_logic_1164.all;

-- Simple entity that connects the SW switches to the LEDR lights
-- By convention we are using e_<entity_name> in this lecture
entity e_my_first_fpga is 
   port ( SW   : in   std_logic_vector(9 downto 0);   -- switches
          LEDR : out  std_logic_vector(9 downto 0));  -- red LEDs
end entity e_my_first_fpga;

-- By convention we are using a_<entity_name>[_x] in this lecture
-- [_x] is optional and used if more than one architecture will be
-- described
architecture a_my_first_fpga_1 of e_my_first_fpga is

---- Declaration Part -----------------------------------------------

-- no signal declarations needed, since the inputs can directly be
-- assigned to the outputs

begin

---- Assignment Part ------------------------------------------------

-- Concurrent Assignments:

-- Short form since it is a one-to-one mapping and
-- the range of both vectors is the same
	LEDR	<=	SW;
	
-- Long form would be:
-- LEDR(9 downto 0) <= SW(9 downto 0);

end architecture a_my_first_fpga_1;

architecture a_my_first_fpga_2 of e_my_first_fpga is

---- Declaration Part -----------------------------------------------

-- no signal declarations would needed, since the inputs can
-- directly be assigned to the outputs, however usage of
-- internal signals should be demonstrated here

-- Usage of ":=" assigns a default value to the signals

-- Signal Declarations:
	signal slv_ledr_int:	std_logic_vector(9 downto 0) := "0000000000";
	signal slv_sw_int:		std_logic_vector(9 downto 0) := "0000000000";

begin

---- Assignment Part ------------------------------------------------

-- Concurrent Assignments:

-- since all concurrent assignments will be performed simultaneously
-- the assignment of the LEDR also be made here, even if the
-- assignment of slv_ledr is done below
	slv_sw_int	<=	SW;
	LEDR		<=	slv_ledr_int;
	
-- the hard way:
--	slv_ledr_int(9)	<= slv_sw_int(0);
--	slv_ledr_int(8)	<= slv_sw_int(1);
--	slv_ledr_int(7)	<= slv_sw_int(2);
--	slv_ledr_int(6)	<= slv_sw_int(3);
--	slv_ledr_int(5)	<= slv_sw_int(4);
--	slv_ledr_int(4)	<= slv_sw_int(5);
--	slv_ledr_int(3)	<= slv_sw_int(6);
--	slv_ledr_int(2)	<= slv_sw_int(7);
--	slv_ledr_int(1)	<= slv_sw_int(8);
--	slv_ledr_int(0)	<= slv_sw_int(9);
	
-- the easy way would be to use the "generate" syntax:
	assign_reverse_order: for j in 0 to 9 generate
		slv_ledr_int(9-j) <= slv_sw_int(j);
	end generate;

end architecture a_my_first_fpga_2;

-- A block configuration is used to choose betwe+++en the architectures.
-- Configuration Declaration
configuration c_my_first_fpga of e_my_first_fpga is
-- Block Configuration
	for a_my_first_fpga_2 end for;
end configuration c_my_first_fpga;
