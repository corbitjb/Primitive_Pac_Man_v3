--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;


ENTITY hw_image_generator IS
	GENERIC(
	
		pixels_y1	:	INTEGER := 1200;    --row that first color will persist until
		pixels_x1	:	INTEGER := 800;   --column that first color will persist until
		
		pixels_y2	:	INTEGER := 0;
		Pixels_x2	:	INTEGER := 0);
		


		
	PORT(
		disp_ena		:	IN		STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
		row			:	IN		INTEGER;		--row pixel coordinate
		column		:	IN		INTEGER;		--column pixel coordinate
		red			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
		green			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
		blue			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
		
		clock			:	IN STD_LOGIC;
		
		upButton		:  IN STD_LOGIC;
		downButton	:	IN STD_LOGIC;
		leftButton	:  IN STD_LOGIC;
		rightButton	:	IN STD_LOGIC

		); --blue magnitude output to DAC
END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS
		signal upB			:  INTEGER := 775;
		signal lowB			:  INTEGER := 875;
		signal rightB		:	INTEGER := 1010;
		signal leftB		:	INTEGER := 910;
		signal counter : std_logic_vector (24  downto 0);

BEGIN
	PROCESS(disp_ena, row, column)
	BEGIN

		IF(disp_ena = '1') THEN		--display time
			IF(row < pixels_y1 AND column < pixels_x1) THEN
				red <= (OTHERS => '0');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
				
			ELSIF(row < pixels_y2 AND column < pixels_x2) THEN
				red <= (OTHERS => '0');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
			
			ELsIF( row > 1700 AND row <2000 AND column < 1200) THEN
				red <= (OTHERS => '0');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
			
			ELsIF( column > 900 AND column <1200 AND row < 2000) THEN
				red <= (OTHERS => '0');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
			
			ELsIF( column > 350 AND column <750 AND row > 390 AND row < 1550 ) THEN
				red <= (OTHERS => '0');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
			
			ELSIF( column > upB AND column <lowB AND row > leftB AND row < rightB ) THEN
				red <= (OTHERS => '1');
				green	<= (OTHERS => '1');
				blue <= (OTHERS => '0');
--				
--			ELSIF column > 250 AND column < 300 AND row > 290  AND row < 340 THEN 
--				red <= (OTHERS => '1');
--				green	<= (OTHERS => '1');
--				blue <= (OTHERS => '1');
--				if (upB > 300 AND rightB < 370) THEN 
--					green	<= (OTHERS => '0');
--				blue <= (OTHERS => '0');
--				end if;
				
			ELSE
				red <= (OTHERS => '1');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
						END IF;
			
		ELSE								--blanking time
			red <= (OTHERS => '0');
			green <= (OTHERS => '0');
			blue <= (OTHERS => '0');
		END IF;
	
	END PROCESS;
	

	PROCESS (upButton,downButton, leftButton, rightButton, upB, lowB, leftB, rightB, clock)
	BEGIN
	
	
if clock'event and clock = '1' then
			
			
			if counter < "0000011010111100001000000" then
			counter <= counter + 1;
			
			else
				counter <= (others => '0');
	
	
	if upButton = '0' AND (rightB < 365 OR leftB > 1575) AND upB > 225 then
	upB <= upB - 5;
	lowB <= lowB - 5;
	end if;
	
	if downButton = '0' AND (rightB < 365 OR leftB > 1575) AND lowB < 875 then
	lowB <= lowB + 5;
	upB <= upB + 5;
	end if;
	
	if leftButton = '0' AND (upB > 774 OR lowB < 326) AND leftB > 260 then
	leftB <= leftB -5;
	rightB <= rightb -5;
	end if;
	
	if rightButton = '0' AND (upB > 774 OR lowB < 326) AND rightB < 1680 then
	rightB <= rightB +5;
	leftB <= leftB +5;
	end if;
	
	end if;
	end if;
	
	end process;


	
	--process
END behavior;