-- Implements a circuit that can display 3-letter words on the six 
-- 7-segment displays. The character selected for each display is chosen by
-- a multiplexer, and these multiplexers are connected to the characters
-- in a way that allows a word to be rotated across the displays from
-- right-to-left as the multiplexer select lines are changed through the
-- sequence 000, 001, ..., 101, 000, etc. Using the four characters d,
-- E, 1, and "blank" the displays can show any 3-letter word using 
-- these letters, such as "dE1 ", as follows:
--
-- SW  987      Displayed characters
--     000         dE1
--     001        dE1
--     010       dE1
--     011      dE1
--     100      E1   d
--     101      1   dE
--
-- inputs:  SW9-7 provide the multiplexer select lines
--          SW5-0 provide three different codes used to select characters
-- outputs: LEDR shows the states of the switches
--          HEX5 - HEX0 displays the characters
library ieee;
use ieee.std_logic_1164.all;

entity e_my_rotword is 
   port ( SW   : in  std_logic_vector(9 downto 0);
          LEDR : out std_logic_vector(9 downto 0);
          HEX5, HEX4, HEX3 : out std_logic_vector(0 to 6);
		  HEX2, HEX1, HEX0 : out std_logic_vector(0 to 6));
end entity e_my_rotword;

architecture a_my_rotword of e_my_rotword is

---- Declaration Part -----------------------------------------------

-- Component Declarations:
   component e_2bit6to1mux
      port ( slv_S : in std_logic_vector(2 downto 0);
             slv_U, slv_V, slv_W : in std_logic_vector(1 downto 0);
			 slv_X, slv_Y, slv_Z : in std_logic_vector(1 downto 0);
             slv_M : out std_logic_vector(1 downto 0));
   end component;

   component e_7segdec
      port ( slv_C       : in  std_logic_vector(1 downto 0);
             slv_Display : out std_logic_vector(0 to 6));
   end component;
	
-- Signal Declarations:
   signal slv_Ch_Sel_int :   std_logic_vector(2 downto 0);
   signal slv_Blank_int :  std_logic_vector(1 downto 0);
   signal slv_Ch1_int, slv_Ch2_int, slv_Ch3_int :  std_logic_vector(1 downto 0);
   signal slv_H5_Ch_int, slv_H4_Ch_int, slv_H3_Ch_int : std_logic_vector(1 downto 0);
   signal slv_H2_Ch_int, slv_H1_Ch_int, slv_H0_Ch_int : std_logic_vector(1 downto 0);

begin

---- Assignment Part ------------------------------------------------

-- Concurrent Assignments:
   LEDR <= SW;
   slv_Ch_Sel_int <= SW(9 downto 7);
   slv_Ch1_int <= SW(5 downto 4);
   slv_Ch2_int <= SW(3 downto 2);
   slv_Ch3_int <= SW(1 downto 0);
   -- used to blank a 7-seg display (see module e_7segdec)
   slv_Blank_int <= "11";

-- Component Instantiation:	
   -- instantiate entity e_my2bit6to1mux (S, U, V, W, X, Y, Z, M) to
   -- create the multiplexer for each hex display
   -- long form
   I_M5: e_2bit6to1mux port map (	slv_S	=>	slv_Ch_Sel_int, 
									slv_U	=>	slv_Blank_int,
									slv_V	=>	slv_Blank_int,
									slv_W	=>	slv_Blank_int,
									slv_X	=>	slv_Ch1_int,
									slv_Y	=>	slv_Ch2_int,
									slv_Z	=>	slv_Ch3_int,
									slv_M	=>	slv_H5_Ch_int);

   I_M4: e_2bit6to1mux port map (	slv_S	=>	slv_Ch_Sel_int, 
									slv_U	=>	slv_Blank_int,
									slv_V	=>	slv_Blank_int,
									slv_W	=>	slv_Ch1_int,
									slv_X	=>	slv_Ch2_int,
									slv_Y	=>	slv_Ch3_int,
									slv_Z	=>	slv_Blank_int,
									slv_M	=>	slv_H4_Ch_int);
   
   I_M3: e_2bit6to1mux port map (	slv_S	=>	slv_Ch_Sel_int, 
									slv_U	=>	slv_Blank_int,
									slv_V	=>	slv_Ch1_int,
									slv_W	=>	slv_Ch2_int,
									slv_X	=>	slv_Ch3_int,
									slv_Y	=>	slv_Blank_int,
									slv_Z	=>	slv_Blank_int,
									slv_M	=>	slv_H3_Ch_int);
   
   I_M2: e_2bit6to1mux port map (	slv_S	=>	slv_Ch_Sel_int, 
									slv_U	=>	slv_Ch1_int,
									slv_V	=>	slv_Ch2_int,
									slv_W	=>	slv_Ch3_int,
									slv_X	=>	slv_Blank_int,
									slv_Y	=>	slv_Blank_int,
									slv_Z	=>	slv_Blank_int,
									slv_M	=>	slv_H2_Ch_int);

   I_M1: e_2bit6to1mux port map (	slv_S	=>	slv_Ch_Sel_int, 
									slv_U	=>	slv_Ch2_int,
									slv_V	=>	slv_Ch3_int,
									slv_W	=>	slv_Blank_int,
									slv_X	=>	slv_Blank_int,
									slv_Y	=>	slv_Blank_int,
									slv_Z	=>	slv_Ch1_int,
									slv_M	=>	slv_H1_Ch_int);

   I_M0: e_2bit6to1mux port map (	slv_S	=>	slv_Ch_Sel_int, 
									slv_U	=>	slv_Ch3_int,
									slv_V	=>	slv_Blank_int,
									slv_W	=>	slv_Blank_int,
									slv_X	=>	slv_Blank_int,
									slv_Y	=>	slv_Ch1_int,
									slv_Z	=>	slv_Ch2_int,
									slv_M	=>	slv_H0_Ch_int);
									
   -- instantiate module e_my7segdec (C, Display) to drive the hex displays
   -- short form
   I_H5: e_7segdec port map (slv_H5_Ch_int, HEX5);
   I_H4: e_7segdec port map (slv_H4_Ch_int, HEX4);
   I_H3: e_7segdec port map (slv_H3_Ch_int, HEX3);
   I_H2: e_7segdec port map (slv_H2_Ch_int, HEX2);
   I_H1: e_7segdec port map (slv_H1_Ch_int, HEX1);
   I_H0: e_7segdec port map (slv_H0_Ch_int, HEX0);

end architecture a_my_rotword;
