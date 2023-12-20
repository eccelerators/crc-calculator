-- vim: ts=4 sw=4 expandtab

-- THIS IS GENERATED VHDL CODE.
-- https://bues.ch/h/crcgen
-- 
-- This code is Public Domain.
-- Permission to use, copy, modify, and/or distribute this software for any
-- purpose with or without fee is hereby granted.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
-- WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
-- MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
-- SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
-- RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
-- NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
-- USE OR PERFORMANCE OF THIS SOFTWARE.

-- CRC polynomial coefficients: x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1
--                              0xEDB88320 (hex)
-- CRC width:                   32 bits
-- CRC shift direction:         right (little endian)
-- Input word width:            32 bits

library IEEE;
use IEEE.std_logic_1164.all;

entity crc is
    port(
        crcIn  : in  std_logic_vector(31 downto 0);
        data   : in  std_logic_vector(31 downto 0);
        crcOut : out std_logic_vector(31 downto 0)
    );
end entity crc;

architecture Behavioral of crc is
begin
    crcOut(0)  <= crcIn(0) xor crcIn(1) xor crcIn(2) xor crcIn(3) xor crcIn(4) xor crcIn(6) xor crcIn(7) xor crcIn(8) xor crcIn(16) xor crcIn(20) xor crcIn(22) xor crcIn(23) xor crcIn(26) xor data(0) xor data(1) xor data(2) xor data(3) xor data(4) xor data(6) xor data(7) xor data(8) xor data(16) xor data(20) xor data(22) xor data(23) xor data(26);
    crcOut(1)  <= crcIn(1) xor crcIn(2) xor crcIn(3) xor crcIn(4) xor crcIn(5) xor crcIn(7) xor crcIn(8) xor crcIn(9) xor crcIn(17) xor crcIn(21) xor crcIn(23) xor crcIn(24) xor crcIn(27) xor data(1) xor data(2) xor data(3) xor data(4) xor data(5) xor data(7) xor data(8) xor data(9) xor data(17) xor data(21) xor data(23) xor data(24) xor data(27);
    crcOut(2)  <= crcIn(0) xor crcIn(2) xor crcIn(3) xor crcIn(4) xor crcIn(5) xor crcIn(6) xor crcIn(8) xor crcIn(9) xor crcIn(10) xor crcIn(18) xor crcIn(22) xor crcIn(24) xor crcIn(25) xor crcIn(28) xor data(0) xor data(2) xor data(3) xor data(4) xor data(5) xor data(6) xor data(8) xor data(9) xor data(10) xor data(18) xor data(22) xor data(24) xor data(25) xor data(28);
    crcOut(3)  <= crcIn(1) xor crcIn(3) xor crcIn(4) xor crcIn(5) xor crcIn(6) xor crcIn(7) xor crcIn(9) xor crcIn(10) xor crcIn(11) xor crcIn(19) xor crcIn(23) xor crcIn(25) xor crcIn(26) xor crcIn(29) xor data(1) xor data(3) xor data(4) xor data(5) xor data(6) xor data(7) xor data(9) xor data(10) xor data(11) xor data(19) xor data(23) xor data(25) xor data(26) xor data(29);
    crcOut(4)  <= crcIn(2) xor crcIn(4) xor crcIn(5) xor crcIn(6) xor crcIn(7) xor crcIn(8) xor crcIn(10) xor crcIn(11) xor crcIn(12) xor crcIn(20) xor crcIn(24) xor crcIn(26) xor crcIn(27) xor crcIn(30) xor data(2) xor data(4) xor data(5) xor data(6) xor data(7) xor data(8) xor data(10) xor data(11) xor data(12) xor data(20) xor data(24) xor data(26) xor data(27) xor data(30);
    crcOut(5)  <= crcIn(0) xor crcIn(3) xor crcIn(5) xor crcIn(6) xor crcIn(7) xor crcIn(8) xor crcIn(9) xor crcIn(11) xor crcIn(12) xor crcIn(13) xor crcIn(21) xor crcIn(25) xor crcIn(27) xor crcIn(28) xor crcIn(31) xor data(0) xor data(3) xor data(5) xor data(6) xor data(7) xor data(8) xor data(9) xor data(11) xor data(12) xor data(13) xor data(21) xor data(25) xor data(27) xor data(28) xor data(31);
    crcOut(6)  <= crcIn(0) xor crcIn(2) xor crcIn(3) xor crcIn(9) xor crcIn(10) xor crcIn(12) xor crcIn(13) xor crcIn(14) xor crcIn(16) xor crcIn(20) xor crcIn(23) xor crcIn(28) xor crcIn(29) xor data(0) xor data(2) xor data(3) xor data(9) xor data(10) xor data(12) xor data(13) xor data(14) xor data(16) xor data(20) xor data(23) xor data(28) xor data(29);
    crcOut(7)  <= crcIn(1) xor crcIn(3) xor crcIn(4) xor crcIn(10) xor crcIn(11) xor crcIn(13) xor crcIn(14) xor crcIn(15) xor crcIn(17) xor crcIn(21) xor crcIn(24) xor crcIn(29) xor crcIn(30) xor data(1) xor data(3) xor data(4) xor data(10) xor data(11) xor data(13) xor data(14) xor data(15) xor data(17) xor data(21) xor data(24) xor data(29) xor data(30);
    crcOut(8)  <= crcIn(0) xor crcIn(2) xor crcIn(4) xor crcIn(5) xor crcIn(11) xor crcIn(12) xor crcIn(14) xor crcIn(15) xor crcIn(16) xor crcIn(18) xor crcIn(22) xor crcIn(25) xor crcIn(30) xor crcIn(31) xor data(0) xor data(2) xor data(4) xor data(5) xor data(11) xor data(12) xor data(14) xor data(15) xor data(16) xor data(18) xor data(22) xor data(25) xor data(30) xor data(31);
    crcOut(9)  <= crcIn(0) xor crcIn(2) xor crcIn(4) xor crcIn(5) xor crcIn(7) xor crcIn(8) xor crcIn(12) xor crcIn(13) xor crcIn(15) xor crcIn(17) xor crcIn(19) xor crcIn(20) xor crcIn(22) xor crcIn(31) xor data(0) xor data(2) xor data(4) xor data(5) xor data(7) xor data(8) xor data(12) xor data(13) xor data(15) xor data(17) xor data(19) xor data(20) xor data(22) xor data(31);
    crcOut(10) <= crcIn(0) xor crcIn(2) xor crcIn(4) xor crcIn(5) xor crcIn(7) xor crcIn(9) xor crcIn(13) xor crcIn(14) xor crcIn(18) xor crcIn(21) xor crcIn(22) xor crcIn(26) xor data(0) xor data(2) xor data(4) xor data(5) xor data(7) xor data(9) xor data(13) xor data(14) xor data(18) xor data(21) xor data(22) xor data(26);
    crcOut(11) <= crcIn(1) xor crcIn(3) xor crcIn(5) xor crcIn(6) xor crcIn(8) xor crcIn(10) xor crcIn(14) xor crcIn(15) xor crcIn(19) xor crcIn(22) xor crcIn(23) xor crcIn(27) xor data(1) xor data(3) xor data(5) xor data(6) xor data(8) xor data(10) xor data(14) xor data(15) xor data(19) xor data(22) xor data(23) xor data(27);
    crcOut(12) <= crcIn(2) xor crcIn(4) xor crcIn(6) xor crcIn(7) xor crcIn(9) xor crcIn(11) xor crcIn(15) xor crcIn(16) xor crcIn(20) xor crcIn(23) xor crcIn(24) xor crcIn(28) xor data(2) xor data(4) xor data(6) xor data(7) xor data(9) xor data(11) xor data(15) xor data(16) xor data(20) xor data(23) xor data(24) xor data(28);
    crcOut(13) <= crcIn(0) xor crcIn(3) xor crcIn(5) xor crcIn(7) xor crcIn(8) xor crcIn(10) xor crcIn(12) xor crcIn(16) xor crcIn(17) xor crcIn(21) xor crcIn(24) xor crcIn(25) xor crcIn(29) xor data(0) xor data(3) xor data(5) xor data(7) xor data(8) xor data(10) xor data(12) xor data(16) xor data(17) xor data(21) xor data(24) xor data(25) xor data(29);
    crcOut(14) <= crcIn(0) xor crcIn(1) xor crcIn(4) xor crcIn(6) xor crcIn(8) xor crcIn(9) xor crcIn(11) xor crcIn(13) xor crcIn(17) xor crcIn(18) xor crcIn(22) xor crcIn(25) xor crcIn(26) xor crcIn(30) xor data(0) xor data(1) xor data(4) xor data(6) xor data(8) xor data(9) xor data(11) xor data(13) xor data(17) xor data(18) xor data(22) xor data(25) xor data(26) xor data(30);
    crcOut(15) <= crcIn(1) xor crcIn(2) xor crcIn(5) xor crcIn(7) xor crcIn(9) xor crcIn(10) xor crcIn(12) xor crcIn(14) xor crcIn(18) xor crcIn(19) xor crcIn(23) xor crcIn(26) xor crcIn(27) xor crcIn(31) xor data(1) xor data(2) xor data(5) xor data(7) xor data(9) xor data(10) xor data(12) xor data(14) xor data(18) xor data(19) xor data(23) xor data(26) xor data(27) xor data(31);
    crcOut(16) <= crcIn(1) xor crcIn(4) xor crcIn(7) xor crcIn(10) xor crcIn(11) xor crcIn(13) xor crcIn(15) xor crcIn(16) xor crcIn(19) xor crcIn(22) xor crcIn(23) xor crcIn(24) xor crcIn(26) xor crcIn(27) xor crcIn(28) xor data(1) xor data(4) xor data(7) xor data(10) xor data(11) xor data(13) xor data(15) xor data(16) xor data(19) xor data(22) xor data(23) xor data(24) xor data(26) xor data(27) xor data(28);
    crcOut(17) <= crcIn(2) xor crcIn(5) xor crcIn(8) xor crcIn(11) xor crcIn(12) xor crcIn(14) xor crcIn(16) xor crcIn(17) xor crcIn(20) xor crcIn(23) xor crcIn(24) xor crcIn(25) xor crcIn(27) xor crcIn(28) xor crcIn(29) xor data(2) xor data(5) xor data(8) xor data(11) xor data(12) xor data(14) xor data(16) xor data(17) xor data(20) xor data(23) xor data(24) xor data(25) xor data(27) xor data(28) xor data(29);
    crcOut(18) <= crcIn(0) xor crcIn(3) xor crcIn(6) xor crcIn(9) xor crcIn(12) xor crcIn(13) xor crcIn(15) xor crcIn(17) xor crcIn(18) xor crcIn(21) xor crcIn(24) xor crcIn(25) xor crcIn(26) xor crcIn(28) xor crcIn(29) xor crcIn(30) xor data(0) xor data(3) xor data(6) xor data(9) xor data(12) xor data(13) xor data(15) xor data(17) xor data(18) xor data(21) xor data(24) xor data(25) xor data(26) xor data(28) xor data(29) xor data(30);
    crcOut(19) <= crcIn(0) xor crcIn(1) xor crcIn(4) xor crcIn(7) xor crcIn(10) xor crcIn(13) xor crcIn(14) xor crcIn(16) xor crcIn(18) xor crcIn(19) xor crcIn(22) xor crcIn(25) xor crcIn(26) xor crcIn(27) xor crcIn(29) xor crcIn(30) xor crcIn(31) xor data(0) xor data(1) xor data(4) xor data(7) xor data(10) xor data(13) xor data(14) xor data(16) xor data(18) xor data(19) xor data(22) xor data(25) xor data(26) xor data(27) xor data(29) xor data(30) xor data(31);
    crcOut(20) <= crcIn(0) xor crcIn(3) xor crcIn(4) xor crcIn(5) xor crcIn(6) xor crcIn(7) xor crcIn(11) xor crcIn(14) xor crcIn(15) xor crcIn(16) xor crcIn(17) xor crcIn(19) xor crcIn(22) xor crcIn(27) xor crcIn(28) xor crcIn(30) xor crcIn(31) xor data(0) xor data(3) xor data(4) xor data(5) xor data(6) xor data(7) xor data(11) xor data(14) xor data(15) xor data(16) xor data(17) xor data(19) xor data(22) xor data(27) xor data(28) xor data(30) xor data(31);
    crcOut(21) <= crcIn(0) xor crcIn(2) xor crcIn(3) xor crcIn(5) xor crcIn(12) xor crcIn(15) xor crcIn(17) xor crcIn(18) xor crcIn(22) xor crcIn(26) xor crcIn(28) xor crcIn(29) xor crcIn(31) xor data(0) xor data(2) xor data(3) xor data(5) xor data(12) xor data(15) xor data(17) xor data(18) xor data(22) xor data(26) xor data(28) xor data(29) xor data(31);
    crcOut(22) <= crcIn(2) xor crcIn(7) xor crcIn(8) xor crcIn(13) xor crcIn(18) xor crcIn(19) xor crcIn(20) xor crcIn(22) xor crcIn(26) xor crcIn(27) xor crcIn(29) xor crcIn(30) xor data(2) xor data(7) xor data(8) xor data(13) xor data(18) xor data(19) xor data(20) xor data(22) xor data(26) xor data(27) xor data(29) xor data(30);
    crcOut(23) <= crcIn(0) xor crcIn(3) xor crcIn(8) xor crcIn(9) xor crcIn(14) xor crcIn(19) xor crcIn(20) xor crcIn(21) xor crcIn(23) xor crcIn(27) xor crcIn(28) xor crcIn(30) xor crcIn(31) xor data(0) xor data(3) xor data(8) xor data(9) xor data(14) xor data(19) xor data(20) xor data(21) xor data(23) xor data(27) xor data(28) xor data(30) xor data(31);
    crcOut(24) <= crcIn(2) xor crcIn(3) xor crcIn(6) xor crcIn(7) xor crcIn(8) xor crcIn(9) xor crcIn(10) xor crcIn(15) xor crcIn(16) xor crcIn(21) xor crcIn(23) xor crcIn(24) xor crcIn(26) xor crcIn(28) xor crcIn(29) xor crcIn(31) xor data(2) xor data(3) xor data(6) xor data(7) xor data(8) xor data(9) xor data(10) xor data(15) xor data(16) xor data(21) xor data(23) xor data(24) xor data(26) xor data(28) xor data(29) xor data(31);
    crcOut(25) <= crcIn(1) xor crcIn(2) xor crcIn(6) xor crcIn(9) xor crcIn(10) xor crcIn(11) xor crcIn(17) xor crcIn(20) xor crcIn(23) xor crcIn(24) xor crcIn(25) xor crcIn(26) xor crcIn(27) xor crcIn(29) xor crcIn(30) xor data(1) xor data(2) xor data(6) xor data(9) xor data(10) xor data(11) xor data(17) xor data(20) xor data(23) xor data(24) xor data(25) xor data(26) xor data(27) xor data(29) xor data(30);
    crcOut(26) <= crcIn(2) xor crcIn(3) xor crcIn(7) xor crcIn(10) xor crcIn(11) xor crcIn(12) xor crcIn(18) xor crcIn(21) xor crcIn(24) xor crcIn(25) xor crcIn(26) xor crcIn(27) xor crcIn(28) xor crcIn(30) xor crcIn(31) xor data(2) xor data(3) xor data(7) xor data(10) xor data(11) xor data(12) xor data(18) xor data(21) xor data(24) xor data(25) xor data(26) xor data(27) xor data(28) xor data(30) xor data(31);
    crcOut(27) <= crcIn(0) xor crcIn(1) xor crcIn(2) xor crcIn(6) xor crcIn(7) xor crcIn(11) xor crcIn(12) xor crcIn(13) xor crcIn(16) xor crcIn(19) xor crcIn(20) xor crcIn(23) xor crcIn(25) xor crcIn(27) xor crcIn(28) xor crcIn(29) xor crcIn(31) xor data(0) xor data(1) xor data(2) xor data(6) xor data(7) xor data(11) xor data(12) xor data(13) xor data(16) xor data(19) xor data(20) xor data(23) xor data(25) xor data(27) xor data(28) xor data(29) xor data(31);
    crcOut(28) <= crcIn(0) xor crcIn(4) xor crcIn(6) xor crcIn(12) xor crcIn(13) xor crcIn(14) xor crcIn(16) xor crcIn(17) xor crcIn(21) xor crcIn(22) xor crcIn(23) xor crcIn(24) xor crcIn(28) xor crcIn(29) xor crcIn(30) xor data(0) xor data(4) xor data(6) xor data(12) xor data(13) xor data(14) xor data(16) xor data(17) xor data(21) xor data(22) xor data(23) xor data(24) xor data(28) xor data(29) xor data(30);
    crcOut(29) <= crcIn(0) xor crcIn(1) xor crcIn(5) xor crcIn(7) xor crcIn(13) xor crcIn(14) xor crcIn(15) xor crcIn(17) xor crcIn(18) xor crcIn(22) xor crcIn(23) xor crcIn(24) xor crcIn(25) xor crcIn(29) xor crcIn(30) xor crcIn(31) xor data(0) xor data(1) xor data(5) xor data(7) xor data(13) xor data(14) xor data(15) xor data(17) xor data(18) xor data(22) xor data(23) xor data(24) xor data(25) xor data(29) xor data(30) xor data(31);
    crcOut(30) <= crcIn(3) xor crcIn(4) xor crcIn(7) xor crcIn(14) xor crcIn(15) xor crcIn(18) xor crcIn(19) xor crcIn(20) xor crcIn(22) xor crcIn(24) xor crcIn(25) xor crcIn(30) xor crcIn(31) xor data(3) xor data(4) xor data(7) xor data(14) xor data(15) xor data(18) xor data(19) xor data(20) xor data(22) xor data(24) xor data(25) xor data(30) xor data(31);
    crcOut(31) <= crcIn(0) xor crcIn(1) xor crcIn(2) xor crcIn(3) xor crcIn(5) xor crcIn(6) xor crcIn(7) xor crcIn(15) xor crcIn(19) xor crcIn(21) xor crcIn(22) xor crcIn(25) xor crcIn(31) xor data(0) xor data(1) xor data(2) xor data(3) xor data(5) xor data(6) xor data(7) xor data(15) xor data(19) xor data(21) xor data(22) xor data(25) xor data(31);
end architecture Behavioral;
