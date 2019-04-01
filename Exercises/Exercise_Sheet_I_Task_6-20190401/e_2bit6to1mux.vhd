library ieee;
use ieee.std_logic_1164.all;

-- implements a 2-bit wide 6-to-1 multiplexer
entity e_2bit6to1mux is
   port ( slv_S : in std_logic_vector(2 downto 0);
          slv_U, slv_V, slv_W : in std_logic_vector(1 downto 0);
		  slv_X, slv_Y, slv_Z : in std_logic_vector(1 downto 0);
          slv_M : out std_logic_vector(1 downto 0));
end entity e_2bit6to1mux;

architecture a_2bit6to1mux of e_2bit6to1mux is

---- Declaration Part -----------------------------------------------

-- Signal Declarations:
	-- intermediate multiplexers
	signal slv_m_0_int, slv_m_1_int   : std_logic_vector(1 to 4);

begin

---- Assignment Part ------------------------------------------------

-- Concurrent Assignments:
   -- 6-to-1 multiplexer for bit 0
   slv_m_0_int(1) <= (not(slv_S(0)) and slv_U(0)) or (slv_S(0) and slv_V(0));
   slv_m_0_int(2) <= (not(slv_S(0)) and slv_W(0)) or (slv_S(0) and slv_X(0));
   slv_m_0_int(3) <= (not(slv_S(0)) and slv_Y(0)) or (slv_S(0) and slv_Z(0));
   slv_m_0_int(4) <= (not(slv_S(1)) and slv_m_0_int(1)) or (slv_S(1) and slv_m_0_int(2));
   
   slv_M(0) <= (not(slv_S(2)) and slv_m_0_int(4)) or (slv_S(2) and slv_m_0_int(3));

   -- 6-to-1 multiplexer for bit 1
   slv_m_1_int(1) <= (not(slv_S(0)) and slv_U(1)) or (slv_S(0) and slv_V(1));
   slv_m_1_int(2) <= (not(slv_S(0)) and slv_W(1)) or (slv_S(0) and slv_X(1));
   slv_m_1_int(3) <= (not(slv_S(0)) and slv_Y(1)) or (slv_S(0) and slv_Z(1));
   slv_m_1_int(4) <= (not(slv_S(1)) and slv_m_1_int(1)) or (slv_S(1) and slv_m_1_int(2));
   
   slv_M(1) <= (not(slv_S(2)) and slv_m_1_int(4)) or (slv_S(2) and slv_m_1_int(3));

end architecture a_2bit6to1mux;
