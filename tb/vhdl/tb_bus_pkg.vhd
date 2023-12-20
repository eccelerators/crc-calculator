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

use work.tb_bus_avalon_pkg.all;
use work.tb_bus_axi4lite_pkg.all;
use work.tb_bus_wishbone_pkg.all;

package tb_bus_pkg is

    type t_bus_down is record
        wishbone : t_wishbone_down;
        avalonmm : t_avalonmm_down;
        axi4lite : t_axi4lite_down;
    end record;

    type t_bus_up is record
        wishbone : t_wishbone_up;
        avalonmm : t_avalonmm_up;
        axi4lite : t_axi4lite_up;
    end record;

    function bus_down_init return t_bus_down;
    function bus_up_init return t_bus_up;

    procedure bus_write(signal   clk         : in std_logic;
                        signal   bus_down    : out t_bus_down;
                        signal   bus_up      : in t_bus_up;
                        variable address     : in std_logic_vector(31 downto 0);
                        variable data        : in std_logic_vector(31 downto 0);
                        variable b_width     : in integer;
                        variable bus_number  : in integer;
                        variable valid       : out integer;
                        variable successfull : out boolean;
                        variable timeout     : in time);

    procedure bus_read(signal   clk         : in std_logic;
                       signal   bus_down    : out t_bus_down;
                       signal   bus_up      : in t_bus_up;
                       variable address     : in std_logic_vector(31 downto 0);
                       variable data        : out std_logic_vector(31 downto 0);
                       variable b_width     : in integer;
                       variable bus_number  : in integer;
                       variable valid       : out integer;
                       variable successfull : out boolean;
                       variable timeout     : in time);
end;

package body tb_bus_pkg is
    function bus_up_init return t_bus_up is
        variable init : t_bus_up;
    begin
        init.wishbone := wishbone_up_init;
        init.avalonmm := avalonmm_up_init;
        init.axi4lite := axi4lite_up_init;
        return init;
    end;

    function bus_down_init return t_bus_down is
        variable init : t_bus_down;
    begin
        init.wishbone := wishbone_down_init;
        init.avalonmm := avalonmm_down_init;
        init.axi4lite := axi4lite_down_init;
        return init;
    end;

    procedure bus_write(signal   clk         : in std_logic;
                        signal   bus_down    : out t_bus_down;
                        signal   bus_up      : in t_bus_up;
                        variable address     : in std_logic_vector(31 downto 0);
                        variable data        : in std_logic_vector(31 downto 0);
                        variable b_width     : in integer;
                        variable bus_number  : in integer;
                        variable valid       : out integer;
                        variable successfull : out boolean;
                        variable timeout     : in time) is
    begin
        valid := 1;
        case bus_number is
            when 0 =>
                write_wishbone(clk,
                               bus_down.wishbone,
                               bus_up.wishbone,
                               address,
                               data,
                               b_width,
                               successfull,
                               timeout);

            when 1 =>
                write_avalonmm(clk,
                               bus_down.avalonmm,
                               bus_up.avalonmm,
                               address,
                               data,
                               b_width,
                               successfull,
                               timeout);

            when 2 =>
                write_axi4lite(clk,
                               bus_down.axi4lite,
                               bus_up.axi4lite,
                               address,
                               data,
                               b_width,
                               successfull,
                               timeout);
            when others =>
                valid := 0;
        end case;

    end procedure;

    procedure bus_read(signal   clk         : in std_logic;
                       signal   bus_down    : out t_bus_down;
                       signal   bus_up      : in t_bus_up;
                       variable address     : in std_logic_vector(31 downto 0);
                       variable data        : out std_logic_vector(31 downto 0);
                       variable b_width     : in integer;
                       variable bus_number  : in integer;
                       variable valid       : out integer;
                       variable successfull : out boolean;
                       variable timeout     : in time) is
    begin
        valid := 1;
        case bus_number is
            when 0 =>
                read_wishbone(clk,
                              bus_down.wishbone,
                              bus_up.wishbone,
                              address,
                              data,
                              b_width,
                              successfull,
                              timeout);

            when 1 =>
                read_avalonmm(clk,
                              bus_down.avalonmm,
                              bus_up.avalonmm,
                              address,
                              data,
                              b_width,
                              successfull,
                              timeout);

            when 2 =>
                read_axi4lite(clk,
                              bus_down.axi4lite,
                              bus_up.axi4lite,
                              address,
                              data,
                              b_width,
                              successfull,
                              timeout);
            when others =>
                valid := 0;
        end case;

    end procedure;
end package body;
