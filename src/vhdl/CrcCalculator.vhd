-- ******************************************************************************
-- 
--                   /------o
--             eccelerators
--          o------/
-- 
--  This file is an Eccelerators GmbH sample project.
-- 
--  MIT License:
--  Copyright (c) 2023 Eccelerators GmbH
-- 
--  Permission is hereby granted, free of charge, to any person obtaining a copy
--  of this software and associated documentation files (the "Software"), to deal
--  in the Software without restriction, including without limitation the rights
--  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--  copies of the Software, and to permit persons to whom the Software is
--  furnished to do so, subject to the following conditions:
-- 
--  The above copyright notice and this permission notice shall be included in all
--  copies or substantial portions of the Software.
-- 
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--  SOFTWARE.
-- ******************************************************************************
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.CrcCalculatorIfcPackage.all;

entity CrcCalculator is
	port(
		Clk            : in  std_logic;
		Rst            : in  std_logic;
		Axi4LiteDown   : in  T_CrcCalculatorIfcAxi4LiteDown;
		Axi4LiteUp     : out T_CrcCalculatorIfcAxi4LiteUp;
		Axi4LiteAccess : out T_CrcCalculatorIfcAxi4LiteAccess;
		Trace          : out T_CrcCalculatorIfcTrace
	);
end;

architecture Behavioural of CrcCalculator is

	signal InitialValue       : std_logic_vector(31 downto 0);
	signal HasBeenInitialized : std_logic;
	signal CrcDataWritten     : std_logic_vector(31 downto 0);

	signal CrcCalculatorBlkDown : T_CrcCalculatorIfcCrcCalculatorBlkDown;
	signal CrcCalculatorBlkUp   : T_CrcCalculatorIfcCrcCalculatorBlkUp;
	signal CrcCalculatorResets  : T_CrcCalculatorIfcResets;

begin

	CrcCalculatorIfcAxi4Lite : entity work.CrcCalculatorIfcAxi4Lite
		port map(
			Clk                  => Clk,
			Rst                  => Rst,
			Axi4LiteDown         => Axi4LiteDown,
			Axi4LiteUp           => Axi4LiteUp,
			Axi4LiteAccess       => Axi4LiteAccess,
			Trace                => Trace,
			CrcCalculatorBlkDown => CrcCalculatorBlkDown,
			CrcCalculatorBlkUp   => CrcCalculatorBlkUp,
			Resets               => CrcCalculatorResets
		);

	CrcEngine : entity work.crc
		port map(
			crcIn  => InitialValue,
			data   => CrcDataWritten,
			crcOut => CrcCalculatorBlkUp.CrcDataToBeRead
		);

	CrcController : process(Clk, Rst) is
	begin
		if Rst = '1' then
			InitialValue                     <= (others => '0');
			HasBeenInitialized               <= '0';
			CrcCalculatorResets.CrcSoftReset <= '1';
			CrcDataWritten                   <= (others => '0');
		elsif rising_edge(Clk) then
			if (CrcCalculatorBlkDown.SwReset = '1' and CrcCalculatorBlkDown.WTransPulseCRC_CR = '1') then
				InitialValue                     <= (others => '0');
				HasBeenInitialized               <= '0';
				CrcCalculatorResets.CrcSoftReset <= '1';
				CrcDataWritten                   <= (others => '0');
			else
				CrcCalculatorResets.CrcSoftReset <= '0';
				if CrcCalculatorBlkDown.WRegPulseCRC_DR = '1' then
					CrcDataWritten <= CrcCalculatorBlkDown.CrcDataWritten;
					if HasBeenInitialized = '0' then
						InitialValue       <= CrcCalculatorBlkDown.InitialValue;
						HasBeenInitialized <= '1';
					else
						InitialValue <= CrcCalculatorBlkUp.CrcDataToBeRead;
					end if;
				end if;
			end if;
		end if;
	end process;

end;
