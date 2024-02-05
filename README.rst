CRC-32 Calculator
=================

.. contents::
	:depth: 3
	
Introduction
------------

The CRC-32 Calculator is one of the fundamental IP (Intellectual Property) blocks 
offered by Eccelerators. We want to help designers to get up to speed by reusing
commonly utilized components. In addition, we demonstrate our efficient approach 
to designing hardware / software interfaces using `HxS`_. We have tailored our design 
around the register interface detailed in the `ST Microelectronics`_ reference manual
(chapter 14 on page 336). While we haven't replicated the entire interface, we 
have adapted a subset that does CRC-32 computations.

Simulation
----------

In this repository we focussed on an individual IP component rather than a complete
FPGA design. Consequently, instead of creating a bitstream, we employ GHDL or ModelSim
for simulation purposes. Our IP is simulated using the `SimStm <https://eccelerators.com/simstm>`_
framework, a tool we developed for simulation and testing.

To begin with, we utilize the register description to generate various HxS artifacts,
including the VHDL register interface and its documentation. For this process,
we've set up a Linux environment, specifically using Ubuntu 22.04. The first step
involves installing Ant.

.. code-block:: BASH

	~$ sudo apt update
	~$ sudo apt install default-jre python3 python3-pip ant -y

Next, we clone the `crc-calculator <https://github.com/eccelerators/crc-calculator>`_
repository from GitHub:

.. code-block:: BASH

	~$ git clone --recurse-submodules git@github.com:eccelerators/crc-calculator.git

Following that, we establish a Python3 virtual environment and install the necessary
dependencies:

.. code-block:: BASH

	~$ python3 -m venv .venv
	~$ source .venv/bin/activate
	~$ pip3 install -r requirements.txt

In order to create the artifacts of the register interface we need to `install HxS`_.

.. code-block:: BASH
	
	~$ mkdir -p ${HOME}/.hxs && cd ${HOME}/.hxs
	~$ wget -c https://download.eccelerators.com?file=hxs-ubuntu-22.04.1-latest.tar.gz -O - | tar -xz

A trial license is sufficient for the purpose of this repository. It and can be aquired 
`here <https://eccelerators.com/GetLicense>`_.

With the setup complete, we are now ready to build all the artifacts required for
simulation.

.. code-block:: BASH

	~$ make

The HxS files are located in the *hxs* directory. The VHDL files related to the
IP and its simulation are organized within the following directory structure:

* **src/vhdl** This folder contains the primary VHDL source files for the IP.
* **src-gen/vhdl** Here, you'll find generated VHDL files specific to
  the AXI4-Lite interface.
* **tb/vhdl** This directory houses the VHDL files used for testbenching and
  simulation.

Additionally, the documentation for this IP, generated in various formats, is
located in these folders:

* **src-gen/docbook-pdf** Contains the documentation in PDF format.
* **src-gen/docbook-html** Holds the HTML version of the documentation (Docbook).
* **src-gen/html-sphinx** Holds the HTML version of the documentation (Sphinx).
* **src-gen/rst** Stores the reStructuredText (rst) files, typically used for
  more textual documentation.

The simulation is executed with the following command:

.. code-block:: BASH

	~$ make sim

A successful simulation will yield an output similar to this:

.. code-block:: BASH

	+ ./crccalculatortestbench --stop-time=100000ns
	simstm/src/tb_simstm.vhd:1245:21:@1000300ps:(assertion note): test finished with no errors!!

License
-------

Licensed under the MIT license (`LICENSE-MIT`_ or `http://opensource.org/licenses/MIT <http://opensource.org/licenses/MIT>`_).

.. _LICENSE-MIT: LICENSE
.. _HxS: https://eccelerators.com/hxs
.. _SimStm: https://eccelerators.com/simstm
.. _ST Microelectronics: https://www.st.com/resource/en/reference_manual/rm0444-stm32g0x1-advanced-armbased-32bit-mcus-stmicroelectronics.pdf
.. _install HxS: https://eccelerators.com/installation