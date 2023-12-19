#!/bin/bash

set -e
set -x

ghdl -i --std=08 \
    simstm/src/tb_base_pkg.vhd \
    simstm/src/tb_bus_avalon_pkg.vhd \
    simstm/src/tb_bus_axi4lite_pkg.vhd \
    simstm/src/tb_bus_wishbone_pkg.vhd \
    simstm/src/tb_instructions_pkg.vhd \
    simstm/src/tb_interpreter_pkg.vhd \
    simstm/src/tb_base_pkg_body.vhd \
    simstm/src/tb_interpreter_pkg_body.vhd \
    simstm/src/tb_simstm.vhd \
    src-gen/vhdl/CrcCalculatorIfcPackage.vhd \
    src-gen/vhdl/CrcCalculatorIfcAxi4Lite.vhd \
    src/vhdl/Crc.vhd \
    src/vhdl/CrcCalculator.vhd \
    src/vhdl/CrcCalculatorWrapper.vhd \
    tb/vhdl/tb_bus_pkg.vhd \
    tb/vhdl/CrcCalculatorSignals.vhd \
    tb/vhdl/CrcCalculatorTestBench.vhd
ghdl -m  --std=08 CrcCalculatorTestBench
./crccalculatortestbench --stop-time=100000ns --ieee-asserts=disable

