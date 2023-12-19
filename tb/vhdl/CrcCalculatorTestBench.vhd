library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

use work.CrcCalculatorIfcPackage.all;
use work.tb_bus_pkg.all;
use work.tb_signals_pkg.all;

entity CrcCalculatorTestBench is
	generic (
		stimulus_path : string := "tb/simstm/";
		stimulus_file : string := "CrcCalculator.stm"
	);
end;

architecture Behavioural of CrcCalculatorTestBench is

	signal Clk : std_logic := '0';
	signal Rst : std_logic := '1';
	signal nRst : std_logic := '0';
	signal SimDone : std_logic := '0';
	
	signal TimeoutAck_Detected : std_logic := '0';
	signal TimeoutAck_Rec_Clear : std_logic := '0';
	
	signal signals_in : t_signals_in;
	
	signal signals_out : t_signals_out;

	signal bus_down : t_bus_down;
	signal bus_up : t_bus_up;

	signal CrcCalculatorIfcAxi4LiteDown : T_CrcCalculatorIfcAxi4LiteDown;
	signal CrcCalculatorIfcAxi4LiteUp : T_CrcCalculatorIfcAxi4LiteUp;

	signal CrcCalculatorIfcTrace : T_CrcCalculatorIfcTrace;

begin

	Rst <= transport '0' after 100 ns;
    
    Clk <= transport (not Clk) and (not SimDone) after 10 ns / 2;

	nRst <= not Rst;

	tb_FileIo_i : entity work.tb_simstm
		generic map (
			stimulus_path => stimulus_path,
			stimulus_file => stimulus_file
		)
		port map (
			Clk => Clk,
			Rst => Rst,
			SimDone => SimDone,
			signals_in => signals_in,
			signals_out => signals_out,
			bus_down => bus_down,
			bus_up => bus_up
		);

	CrcCalculatorIfcAxi4LiteDown.AWVALID <= bus_down.axi4lite.AWVALID;
	CrcCalculatorIfcAxi4LiteDown.AWADDR <= bus_down.axi4lite.AWADDR(CrcCalculatorIfcAxi4LiteDown.AWADDR'LENGTH - 1 downto 0);
	CrcCalculatorIfcAxi4LiteDown.AWPROT <= bus_down.axi4lite.AWPROT;
	CrcCalculatorIfcAxi4LiteDown.WVALID <= bus_down.axi4lite.WVALID;
	CrcCalculatorIfcAxi4LiteDown.WDATA <= bus_down.axi4lite.WDATA;
	CrcCalculatorIfcAxi4LiteDown.WSTRB <= bus_down.axi4lite.WSTRB;
	CrcCalculatorIfcAxi4LiteDown.BREADY <= bus_down.axi4lite.BREADY;
	CrcCalculatorIfcAxi4LiteDown.ARVALID <= bus_down.axi4lite.ARVALID;
	CrcCalculatorIfcAxi4LiteDown.ARADDR <= bus_down.axi4lite.ARADDR(CrcCalculatorIfcAxi4LiteDown.ARADDR'LENGTH - 1 downto 0);
	CrcCalculatorIfcAxi4LiteDown.ARPROT <= bus_down.axi4lite.ARPROT;
	CrcCalculatorIfcAxi4LiteDown.RREADY <= bus_down.axi4lite.RREADY;
	
	bus_up.axi4lite.AWREADY <= CrcCalculatorIfcAxi4LiteUp.AWREADY;
	bus_up.axi4lite.WREADY <= CrcCalculatorIfcAxi4LiteUp.WREADY;
	bus_up.axi4lite.BVALID <= CrcCalculatorIfcAxi4LiteUp.BVALID;
	bus_up.axi4lite.BRESP <= CrcCalculatorIfcAxi4LiteUp.BRESP;
	bus_up.axi4lite.ARREADY <= CrcCalculatorIfcAxi4LiteUp.ARREADY;
	bus_up.axi4lite.RVALID <= CrcCalculatorIfcAxi4LiteUp.RVALID;
	bus_up.axi4lite.RDATA <= CrcCalculatorIfcAxi4LiteUp.RDATA;
	bus_up.axi4lite.RRESP <= CrcCalculatorIfcAxi4LiteUp.RRESP;

	CrcCalculatorWrapper_i : entity work.CrcCalculatorWrapper
		port map (
			Clk => Clk,
			Rst => Rst,
			Trace_Axi4LiteDown_AWVALID => CrcCalculatorIfcTrace.Axi4LiteDown.AWVALID,
			Trace_Axi4LiteDown_AWADDR => CrcCalculatorIfcTrace.Axi4LiteDown.AWADDR,
			Trace_Axi4LiteDown_AWPROT => CrcCalculatorIfcTrace.Axi4LiteDown.AWPROT,
			Trace_Axi4LiteDown_WVALID => CrcCalculatorIfcTrace.Axi4LiteDown.WVALID,
			Trace_Axi4LiteDown_WDATA => CrcCalculatorIfcTrace.Axi4LiteDown.WDATA,
			Trace_Axi4LiteDown_WSTRB => CrcCalculatorIfcTrace.Axi4LiteDown.WSTRB,
			Trace_Axi4LiteDown_BREADY => CrcCalculatorIfcTrace.Axi4LiteDown.BREADY,
			Trace_Axi4LiteDown_ARVALID => CrcCalculatorIfcTrace.Axi4LiteDown.ARVALID,
			Trace_Axi4LiteDown_ARADDR => CrcCalculatorIfcTrace.Axi4LiteDown.ARADDR,
			Trace_Axi4LiteDown_ARPROT => CrcCalculatorIfcTrace.Axi4LiteDown.ARPROT,
			Trace_Axi4LiteDown_RREADY => CrcCalculatorIfcTrace.Axi4LiteDown.RREADY,
			Trace_Axi4LiteUp_AWREADY => CrcCalculatorIfcTrace.Axi4LiteUp.AWREADY,
			Trace_Axi4LiteUp_WREADY => CrcCalculatorIfcTrace.Axi4LiteUp.WREADY,
			Trace_Axi4LiteUp_BVALID => CrcCalculatorIfcTrace.Axi4LiteUp.BVALID,
			Trace_Axi4LiteUp_BRESP => CrcCalculatorIfcTrace.Axi4LiteUp.BRESP,
			Trace_Axi4LiteUp_ARREADY => CrcCalculatorIfcTrace.Axi4LiteUp.ARREADY,
			Trace_Axi4LiteUp_RVALID => CrcCalculatorIfcTrace.Axi4LiteUp.RVALID,
			Trace_Axi4LiteUp_RDATA => CrcCalculatorIfcTrace.Axi4LiteUp.RDATA,
			Trace_Axi4LiteUp_RRESP => CrcCalculatorIfcTrace.Axi4LiteUp.RRESP,
			Trace_UnoccupiedAck => CrcCalculatorIfcTrace.UnoccupiedAck,
			Trace_TimeoutAck => CrcCalculatorIfcTrace.TimeoutAck,
			AWVALID => CrcCalculatorIfcAxi4LiteDown.AWVALID,
			AWADDR => CrcCalculatorIfcAxi4LiteDown.AWADDR,
			AWPROT => CrcCalculatorIfcAxi4LiteDown.AWPROT,
			WVALID => CrcCalculatorIfcAxi4LiteDown.WVALID,
			WDATA => CrcCalculatorIfcAxi4LiteDown.WDATA,
			WSTRB => CrcCalculatorIfcAxi4LiteDown.WSTRB,
			BREADY => CrcCalculatorIfcAxi4LiteDown.BREADY,
			ARVALID => CrcCalculatorIfcAxi4LiteDown.ARVALID,
			ARADDR => CrcCalculatorIfcAxi4LiteDown.ARADDR,
			ARPROT => CrcCalculatorIfcAxi4LiteDown.ARPROT,
			RREADY => CrcCalculatorIfcAxi4LiteDown.RREADY,
			AWREADY => CrcCalculatorIfcAxi4LiteUp.AWREADY,
			WREADY => CrcCalculatorIfcAxi4LiteUp.WREADY,
			BVALID => CrcCalculatorIfcAxi4LiteUp.BVALID,
			BRESP => CrcCalculatorIfcAxi4LiteUp.BRESP,
			ARREADY => CrcCalculatorIfcAxi4LiteUp.ARREADY,
			RVALID => CrcCalculatorIfcAxi4LiteUp.RVALID,
			RDATA => CrcCalculatorIfcAxi4LiteUp.RDATA,
			RRESP => CrcCalculatorIfcAxi4LiteUp.RRESP
		);

	TimeoutAck_Rec_Clear <= signals_out.TimeoutAck_Rec_Clear;
	
	InputSignalDispatcher : process (Clk, Rst) is
	begin
		if Rst = '1' then
			signals_in.TimeoutAck_Detected <= '0';
		elsif rising_edge(Clk) then
			signals_in.TimeoutAck_Detected <= TimeoutAck_Detected;
		end if;
	end process;
	
	
	TimeoutAckRecorder : process(Clk, Rst)
	begin
		if (Rst = '1') then
			TimeoutAck_Detected <= '0';
		elsif rising_edge(Clk) then
			if (CrcCalculatorIfcTrace.TimeoutAck = '1') then
				TimeoutAck_Detected <= '1';
			elsif (TimeoutAck_Rec_Clear = '1') then
				TimeoutAck_Detected <= '0';
			end if;
		end if;
	end process;

end;

