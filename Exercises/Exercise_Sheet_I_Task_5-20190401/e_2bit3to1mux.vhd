library ieee;
use ieee.std_logic_1164.all;

-- Implements a 2-bit wide 3-to-1 multiplexer
entity e_2bit3to1mux is
   port ( slv_S, slv_U : in  std_logic_vector(1 downto 0);
		  slv_V, slv_W : in  std_logic_vector(1 downto 0);
          slv_M        : out std_logic_vector(1 downto 0));
end entity e_2bit3to1mux;

architecture a_2bit3to1mux of e_2bit3to1mux is

---- Declaration Part -----------------------------------------------

-- Signal Declarations:
	signal slv_X_int: std_logic_vector(1 downto 0); -- intermediate mux

begin

---- Assignment Part ------------------------------------------------

-- Concurrent Assignments:

-- short version using "generate":
	gen_slv_X_and_M: for j in 0 to 1 generate
		slv_X_int(j) <= (not(slv_S(0)) and     slv_U(j)) or (slv_S(0) and slv_V(j));
		    slv_M(j) <= (not(slv_S(1)) and slv_X_int(j)) or (slv_S(1) and slv_W(j));
	end generate;

end architecture a_2bit3to1mux;
