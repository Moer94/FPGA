library ieee;
use ieee.std_logic_1164.all;

-- Implements a circuit that can display different 3-letter words on 
-- three 7-segment
-- displays. The character selected for each display is chosen by
-- a multiplexer, and these multiplexers are connected to the characters
-- in a way that allows a word to be rotated across the displays from
-- right-to-left as the multiplexer select lines are changed through the
-- sequence 00, 01, 10, 00, etc. Using the three characters d,
-- E, 1, the displays can scroll any 3-letter word using these letters, 
-- such as "dE1", as follows:
--
-- SW  9  8   Displayed characters
--     0  0     dE1
--     0  1     E1d
--     1  0     1dE
--
-- inputs: SW9-8 provide the multiplexer select lines
--         SW5-0 provide three 2-bit codes used to select characters
-- outputs: LEDR shows the states of the switches
--          HEX2 - HEX0 displays the characters
entity e_my_mux7seg IS 
		port(	SW		:	in		std_logic_vector(9 downto 0);
				LEDR	:	out		std_logic_vector(9 downto 0);
				HEX2, HEX1, HEX0	:	out	std_logic_vector(0 to 6));
end entity e_my_mux7seg;

architecture a_my_mux7seg of e_my_mux7seg is

---- Declaration Part -----------------------------------------------

-- Component Declarations:
	component e_2bit3to1mux
		port	(	slv_S, slv_U : in std_logic_vector(1 downto 0);
					slv_V, slv_W : in std_logic_vector(1 downto 0);
					slv_M        : out std_logic_vector(1 downto 0));
	end component;

	component e_7segdec
		port	(	slv_C	    :	in	std_logic_vector(1 downto 0);
					slv_Display	:	out	std_logic_vector(0 to 6));
	end component;

-- Signal Declarations:
	signal	slv_Ch_Sel_int : std_logic_vector(1 downto 0);
	signal	slv_Ch1_int, slv_Ch2_int, slv_Ch3_int : std_logic_vector(1 downto 0);
	signal	slv_H2_Ch_int, slv_H1_Ch_int, slv_H0_Ch_int : std_logic_vector(1 downto 0);

begin

---- Assignment Part ------------------------------------------------

-- Concurrent Assignments:

	LEDR <= SW;

	slv_Ch_Sel_int <= SW(9 downto 8);
	slv_Ch1_int <= SW(5 downto 4);
	slv_Ch2_int <= SW(3 downto 2);
	slv_Ch3_int <= SW(1 downto 0);

-- Component Instantiation:

	-- instantiate e_2bit3to1mux (slv_S, slv_U, slv_V, slv_W, slv_M);
	-- long form
	I_M2: e_2bit3to1mux port map (slv_S	=>	slv_Ch_Sel_int,
									 slv_U	=>	slv_Ch1_int,
									 slv_V	=>	slv_Ch2_int,
									 slv_W	=>	slv_Ch3_int,
									 slv_M	=>	slv_H2_Ch_int);

	I_M1: e_2bit3to1mux port map (slv_S	=>	slv_Ch_Sel_int,
									 slv_U	=>	slv_Ch2_int,
									 slv_V	=>	slv_Ch3_int,
									 slv_W	=>	slv_Ch1_int,
									 slv_M	=>	slv_H1_Ch_int);

	I_M0: e_2bit3to1mux port map (slv_S	=>	slv_Ch_Sel_int,
									 slv_U	=>	slv_Ch3_int,
									 slv_V	=>	slv_Ch1_int,
									 slv_W	=>	slv_Ch2_int,
									 slv_M	=>	slv_H0_Ch_int);

	-- instantiate e_7segdec (slv_C, slv_Display);
	-- short form
	I_H2: e_7segdec port map (slv_H2_Ch_int, HEX2);
	I_H1: e_7segdec port map (slv_H1_Ch_int, HEX1);
	I_H0: e_7segdec port map (slv_H0_Ch_int, HEX0);

end architecture a_my_mux7seg;
