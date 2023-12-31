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

entity CrcCalculatorWrapper is
    port(
        Clk                                   : in  std_logic;
        Rst                                   : in  std_logic;
        AWVALID                               : in  std_logic;
        AWADDR                                : in  std_logic_vector(15 downto 0);
        AWPROT                                : in  std_logic_vector(2 downto 0);
        WVALID                                : in  std_logic;
        WDATA                                 : in  std_logic_vector(31 downto 0);
        WSTRB                                 : in  std_logic_vector(3 downto 0);
        BREADY                                : in  std_logic;
        ARVALID                               : in  std_logic;
        ARADDR                                : in  std_logic_vector(15 downto 0);
        ARPROT                                : in  std_logic_vector(2 downto 0);
        RREADY                                : in  std_logic;
        AWREADY                               : out std_logic;
        WREADY                                : out std_logic;
        BVALID                                : out std_logic;
        BRESP                                 : out std_logic_vector(1 downto 0);
        ARREADY                               : out std_logic;
        RVALID                                : out std_logic;
        RDATA                                 : out std_logic_vector(31 downto 0);
        RRESP                                 : out std_logic_vector(1 downto 0);
        WritePrivileged                       : out std_logic;
        WriteSecure                           : out std_logic;
        WriteInstruction                      : out std_logic;
        ReadPrivileged                        : out std_logic;
        ReadSecure                            : out std_logic;
        ReadInstruction                       : out std_logic;
        Trace_Axi4LiteDown_AWVALID            : out std_logic;
        Trace_Axi4LiteDown_AWADDR             : out std_logic_vector(15 downto 0);
        Trace_Axi4LiteDown_AWPROT             : out std_logic_vector(2 downto 0);
        Trace_Axi4LiteDown_WVALID             : out std_logic;
        Trace_Axi4LiteDown_WDATA              : out std_logic_vector(31 downto 0);
        Trace_Axi4LiteDown_WSTRB              : out std_logic_vector(3 downto 0);
        Trace_Axi4LiteDown_BREADY             : out std_logic;
        Trace_Axi4LiteDown_ARVALID            : out std_logic;
        Trace_Axi4LiteDown_ARADDR             : out std_logic_vector(15 downto 0);
        Trace_Axi4LiteDown_ARPROT             : out std_logic_vector(2 downto 0);
        Trace_Axi4LiteDown_RREADY             : out std_logic;
        Trace_Axi4LiteUp_AWREADY              : out std_logic;
        Trace_Axi4LiteUp_WREADY               : out std_logic;
        Trace_Axi4LiteUp_BVALID               : out std_logic;
        Trace_Axi4LiteUp_BRESP                : out std_logic_vector(1 downto 0);
        Trace_Axi4LiteUp_ARREADY              : out std_logic;
        Trace_Axi4LiteUp_RVALID               : out std_logic;
        Trace_Axi4LiteUp_RDATA                : out std_logic_vector(31 downto 0);
        Trace_Axi4LiteUp_RRESP                : out std_logic_vector(1 downto 0);
        Trace_Axi4LiteAccess_WritePrivileged  : out std_logic;
        Trace_Axi4LiteAccess_WriteSecure      : out std_logic;
        Trace_Axi4LiteAccess_WriteInstruction : out std_logic;
        Trace_Axi4LiteAccess_ReadPrivileged   : out std_logic;
        Trace_Axi4LiteAccess_ReadSecure       : out std_logic;
        Trace_Axi4LiteAccess_ReadInstruction  : out std_logic;
        Trace_UnoccupiedAck                   : out std_logic;
        Trace_TimeoutAck                      : out std_logic
    );
end;

architecture Behavioural of CrcCalculatorWrapper is

    signal Axi4LiteDown   : T_CrcCalculatorIfcAxi4LiteDown;
    signal Axi4LiteUp     : T_CrcCalculatorIfcAxi4LiteUp;
    signal Trace          : T_CrcCalculatorIfcTrace;
    signal Axi4LiteAccess : T_CrcCalculatorIfcAxi4LiteAccess;

begin

    CrcCalculator_i : entity work.CrcCalculator
        port map(
            Clk            => Clk,
            Rst            => Rst,
            Axi4LiteDown   => Axi4LiteDown,
            Axi4LiteUp     => Axi4LiteUp,
            Axi4LiteAccess => Axi4LiteAccess,
            Trace          => Trace
        );

    Axi4LiteDown.AWVALID <= AWVALID;
    Axi4LiteDown.AWADDR  <= AWADDR;
    Axi4LiteDown.AWPROT  <= AWPROT;
    Axi4LiteDown.WVALID  <= WVALID;
    Axi4LiteDown.WDATA   <= WDATA;
    Axi4LiteDown.WSTRB   <= WSTRB;
    Axi4LiteDown.BREADY  <= BREADY;
    Axi4LiteDown.ARVALID <= ARVALID;
    Axi4LiteDown.ARADDR  <= ARADDR;
    Axi4LiteDown.ARPROT  <= ARPROT;
    Axi4LiteDown.RREADY  <= RREADY;

    AWREADY <= Axi4LiteUp.AWREADY;
    WREADY  <= Axi4LiteUp.WREADY;
    BVALID  <= Axi4LiteUp.BVALID;
    BRESP   <= Axi4LiteUp.BRESP;
    ARREADY <= Axi4LiteUp.ARREADY;
    RVALID  <= Axi4LiteUp.RVALID;
    RDATA   <= Axi4LiteUp.RDATA;
    RRESP   <= Axi4LiteUp.RRESP;

    WritePrivileged  <= Axi4LiteAccess.WritePrivileged;
    WriteSecure      <= Axi4LiteAccess.WriteSecure;
    WriteInstruction <= Axi4LiteAccess.WriteInstruction;
    ReadPrivileged   <= Axi4LiteAccess.ReadPrivileged;
    ReadSecure       <= Axi4LiteAccess.ReadPrivileged;
    ReadInstruction  <= Axi4LiteAccess.ReadInstruction;

    Trace_Axi4LiteDown_AWVALID <= Trace.Axi4LiteDown.AWVALID;
    Trace_Axi4LiteDown_AWADDR  <= Trace.Axi4LiteDown.AWADDR;
    Trace_Axi4LiteDown_AWPROT  <= Trace.Axi4LiteDown.AWPROT;
    Trace_Axi4LiteDown_WVALID  <= Trace.Axi4LiteDown.WVALID;
    Trace_Axi4LiteDown_WDATA   <= Trace.Axi4LiteDown.WDATA;
    Trace_Axi4LiteDown_WSTRB   <= Trace.Axi4LiteDown.WSTRB;
    Trace_Axi4LiteDown_BREADY  <= Trace.Axi4LiteDown.BREADY;
    Trace_Axi4LiteDown_ARVALID <= Trace.Axi4LiteDown.ARVALID;
    Trace_Axi4LiteDown_ARADDR  <= Trace.Axi4LiteDown.ARADDR;
    Trace_Axi4LiteDown_ARPROT  <= Trace.Axi4LiteDown.ARPROT;
    Trace_Axi4LiteDown_RREADY  <= Trace.Axi4LiteDown.RREADY;

    Trace_Axi4LiteUp_AWREADY <= Trace.Axi4LiteUp.AWREADY;
    Trace_Axi4LiteUp_WREADY  <= Trace.Axi4LiteUp.WREADY;
    Trace_Axi4LiteUp_BVALID  <= Trace.Axi4LiteUp.BVALID;
    Trace_Axi4LiteUp_BRESP   <= Trace.Axi4LiteUp.BRESP;
    Trace_Axi4LiteUp_ARREADY <= Trace.Axi4LiteUp.ARREADY;
    Trace_Axi4LiteUp_RVALID  <= Trace.Axi4LiteUp.RVALID;
    Trace_Axi4LiteUp_RDATA   <= Trace.Axi4LiteUp.RDATA;
    Trace_Axi4LiteUp_RRESP   <= Trace.Axi4LiteUp.RRESP;

    Trace_Axi4LiteAccess_WritePrivileged  <= Trace.Axi4LiteAccess.WritePrivileged;
    Trace_Axi4LiteAccess_WriteSecure      <= Trace.Axi4LiteAccess.WriteSecure;
    Trace_Axi4LiteAccess_WriteInstruction <= Trace.Axi4LiteAccess.WriteInstruction;
    Trace_Axi4LiteAccess_ReadPrivileged   <= Trace.Axi4LiteAccess.ReadPrivileged;
    Trace_Axi4LiteAccess_ReadSecure       <= Trace.Axi4LiteAccess.ReadPrivileged;
    Trace_Axi4LiteAccess_ReadInstruction  <= Trace.Axi4LiteAccess.ReadInstruction;
    Trace_UnoccupiedAck                   <= Trace.UnoccupiedAck;
    Trace_TimeoutAck                      <= Trace.TimeoutAck;

end;
