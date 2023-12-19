# CRC Calculator IP

This repository is part of a blog article that is available at our website.

    https://blog.eccelerators.com/#crc-calculator

## From Concept to Code: Developing a CRC Calculator for GateMate FPGA

In this blog series, we will create a simple Intellectual Property (IP) core that calculates
checksums, utilizing the HxS methodology for register interface description and the
[GateMate FPGA] from [Cologne Chip]. Our experimental playground will be the [GateMate
Evaluation Board]. The GateMate series brings us compact yet powerful FPGAs, perfect
for a range of applications. Our focus will be on the __CCGM1A1__, equipped with __20,480
programmable elements__, suitable for both combinatorial and sequential logic. This
capacity is more than adequate for the CRC calculator we aim to create and explore
in this article.

## Register Interface

In this section, we dive into the world of HxS to craft a register interface.
Taking inspiration from a practical example, we create a register interface for
a CRC (Cyclic Redundancy Check) calculator, a crucial tool used in verifying the
integrity of data in digital communications. We are basing our design on the same
register interface as described in the [ST Microelectronics] reference manual
(specifically, chapter 14 on page 336). It consists of the following registers:

* CRC data register (CRC_DR)
* CRC independent data register (CRC_IDR)
* CRC control register (CRC_CR)
* CRC initial value (CRC_INIT)
* CRC polynominal (CRC_POL)

Our HxS description begins with the specification of an interface. We aim for a
32-bit data bus width and an AXI4-Lite slave interface. Let's explore the HxS
code that lays the foundation for our calculator:

    interface CrcCalculatorIfc
    {
        Name = "CRC Calculator Interface";
        DataBusWidth = 32;
        BusType = BusType.AXI4Lite;
        Blocks = [CrcCalculatorBlk];
    }

Here, we define the CrcCalculatorIfc interface. It's important to note that the
address bus width adapts automatically to match the actual address space used by
our IP, streamlining the design process.

Next, we create a block. In HxS, blocks are instrumental in grouping registers,
bringing order and clarity to complex designs. For our CRC calculator, a single
block suffices to house the five essential registers, mirroring the structure
found in the [ST Microelectronics] reference manual:

    block CrcCalculatorBlk
    {
        Name = "CRC Calculator Block";
        Registers = [
            CRC_DR,
            CRC_IDR,
            CRC_CR,
            CRC_INIT(Offset=0x10),
            CRC_POL
        ];
    }

Each register in CrcCalculatorBlk starts at a specific offset, beginning at 0x0
and increasing sequentially. Notably, __CRC_INIT__ begins at offset 0x10, followed
by __CRC_POL__ at 0x14. HxS auto-calculates offsets and addresses, simplifying the
user's workload.

Now, let's define the registers within the CrcCalculatorBlock. The __CRC_DR__ register,
a special data register, is crucial as it receives data for CRC calculation and,
upon read, provides the calculated CRC. This dual functionality is efficiently
handled by the __ReadTransparentWriteRegisterReg32__ type.

    register CRC_DR : ReadTransparentWriteRegisterReg32
    {
        Name = "CRC Data Register";
        WriteRegisterPulse = true;
    }

Here, the extra write register pulse signals every new data input, triggering another
CRC calculation.

The __CRC_IDR__ is straightforward, functioning as a basic read/write register without
additional complexities:

    register CRC_IDR : Reg32
    {
        Name = "CRC Independent Data Register";
    }

For controlling the CRC mechanism, we use the __CRC_CR__ register. It enables control
over various aspects of the CRC calculation:

    register CRC_CR : Reg32
    {
        Name = "CRC Control Register";
        Bits = [enum CrcControl
            {
                Values = [{
                        0 : value CrcControlReset { Width = 1; },
                        3 : value CrcPolySize { Width = 2; },
                        5 : value CrcReverseInputData { Width = 2; },
                        7 : value CrcReverseOutputData { Width = 1; }
                    }];
            }];
    }

__CRC_INIT__ and __CRC_POL__ registers provide the initial value and polynomial for the
CRC calculation, respectively. The __CRC_POL__ is set to a constant value to support
the CRC-32 Ethernet polynomial __0x4C11DB7__.

    register CRC_INIT : Reg32
    {
        Name = "CRC Initial Value";
    }

    register CRC_POL : ReadTransparentReg32
    {
        Name = "CRC Polynomial";
    }

With this compact yet powerful HxS description, we've laid the groundwork for a
functional register interface. This approach demonstrates the ease and efficiency
of prototyping with HxS. Our interface can now be iteratively refined and enriched
with further details.

From this HxS description, we can generate the bus interface and comprehensive
documentation in formats like Word, PDF, or HTML. Additionally, C header files
facilitate embedded software integration.

## Simulation

In this article, we focussed on an individual IP component rather than a complete
FPGA design. Consequently, instead of creating a bitstream, we employ GHDL for
simulation purposes. Our IP is simulated using the SimStm framework, a tool we
developed for simulation and testing.

To begin with, we utilize the register description to generate various HxS artifacts,
including the VHDL register interface and its documentation. For this process,
we've set up a Linux environment, specifically using Ubuntu 22.04. The first step
involves installing Ant.

    ~$ sudo apt-get install ant -y

Next, we clone the actual `crc-calculator` repository from the [Eccelerators GitHub]
repository:

    ~$ git clone --recurse-submodules git@github.com:eccelerators/crc-calculator.git

Following that, we establish a Python3 virtual environment and install the necessary
dependencies:

    ~$ python3 -m venv .venv
    ~$ source .venv/bin/activate
    ~$ pip3 install -r requirements.txt

With the setup complete, we are now ready to build all the artifacts required for
simulation:

    ~$ make

The HxS files are located in the `hxs` directory. The VHDL files related to the
IP and its simulation are organized within the following directory structure:

* __src/vhdl__ This folder contains the primary VHDL source files for the IP.
* __src-gen/vhdl__ Here, you'll find generated VHDL files specific to
  the AXI4-Lite interface.
* __tb/vhdl__ This directory houses the VHDL files used for testbenching and
  simulation.

Additionally, the documentation for this IP, generated in various formats, is
located in these folders:

* __src-gen/docbook-pdf__ Contains the documentation in PDF format.
* __src-gen/docbook-html__ Holds the HTML version of the documentation (Docbook).
* __src-gen/html-sphinx__ Holds the HTML version of the documentation (Sphinx).
* __src-gen/rst__ Stores the reStructuredText (rst) files, typically used for
  more textual documentation.

The simulation is executed with the following command:

    ~$ make sim

A successful simulation will yield an output similar to this:

    + ./crccalculatortestbench --stop-time=100000ns
    simstm/src/tb_simstm.vhd:1245:21:@1000300ps:(assertion note): test finished with no errors!!

## Next Steps

In this overview, we have outlined our process of using HxS to prototype a register
description for a CRC calculator IP. We successfully created all the necessary
artifacts for VHDL simulation and synthesis. As our current scope is limited to
the IP component without a complete FPGA design, we focused exclusively on simulating
the design. This allowed us to test and validate the IP in isolation.

In a forthcoming article, we plan to delve deeper into the specifics of how we use
SimStm, our proprietary simulation framework. This exploration will provide insights
into the methodologies and advantages of using SimStm for IP simulation.

Looking ahead, another article will explore the creation of a complete FPGA design
for the [GateMate FPGA]. This will include the synthesis process and bitstream
creation for the [GateMate Evaluation Board]. This future work aims to bring our
IP from simulation to a tangible, functioning component in a real-world FPGA
environment.

[Eccelerators GitHub]: https://github.com/eccelerators
[Cologne Chip]: https://www.colognechip.com/
[GateMate FPGA]: https://www.colognechip.com/programmable-logic/gatemate/
[GateMate Evaluation Board]: https://www.colognechip.com/programmable-logic/gatemate-evaluation-board/
[ST Microelectronics]: (https://www.st.com/resource/en/reference_manual/rm0444-stm32g0x1-advanced-armbased-32bit-mcus-stmicroelectronics.pdf)
