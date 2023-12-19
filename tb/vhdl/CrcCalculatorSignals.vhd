library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

library std;
use std.textio.all;

package tb_signals_pkg is

	type t_signals_in is
	record
		CrcDataWritten : std_logic_vector(31 downto 0);
		CrcIdrData : std_logic_vector(31 downto 0);
		CrcControl : std_logic_vector(31 downto 0);
		CrcInitialValue : std_logic_vector(31 downto 0);
		CrcPolynomial : std_logic_vector(31 downto 0);
		TimeoutAck_Detected : std_logic;
	end record;

	type t_signals_out is
	record
		CrcDataToBeRead : std_logic_vector(31 downto 0);
		TimeoutAck_Rec_Clear : std_logic;
	end record;

    -- TODO: Define here the number of interrupts you want to have
    constant number_of_interrupts : natural := 2;

    type t_interrupt_labels is array (number_of_interrupts - 1 downto 0) of line;

	function signals_in_init return t_signals_in;
	function signals_out_init return t_signals_out;

	procedure signal_write(
		signal signals : out t_signals_out;
		variable signal_number : in  integer;
		variable value : in  integer;
		variable valid : out integer
	);

	procedure signal_read(
		signal signals : in t_signals_in;
		variable signal_number : in  integer;
		variable value : out integer;
		variable valid : out integer
	);
    
    procedure get_interrupt_requests(signal signals : in t_signals_in;
                                     variable interrupt_requests : out unsigned);

    procedure resolve_interrupt_requests(variable interrupt_requests : in unsigned;
                                         variable interrupt_in_service : in unsigned;
                                         variable interrupt_number : out integer;
                                         variable branch_to_interrupt : out boolean;
                                         variable branch_to_interrupt_label_std_txt_io_line : out line);

    procedure set_interrupt_in_service(variable interrupt_in_service : inout unsigned; variable interrupt_number : in integer);

    procedure reset_interrupt_in_service(variable interrupt_in_service : inout unsigned; variable interrupt_number : in integer);

end;

package body tb_signals_pkg is

	function signals_in_init return t_signals_in is
		variable signals : t_signals_in;
	begin
		signals.CrcDataWritten := (others => 'U');
		signals.CrcIdrData := (others => 'U');
		signals.CrcControl := (others => 'U');
		signals.CrcInitialValue := (others => 'U');
		signals.CrcPolynomial := (others => 'U');
		signals.TimeoutAck_Detected := 'U';
		return signals;
	end;

	function signals_out_init return t_signals_out is
		variable signals : t_signals_out;
	begin
		signals.CrcDataToBeRead := (others => '0');
		signals.TimeoutAck_Rec_Clear := '0';
		return signals;
	end;

	procedure signal_write(
		signal signals : out t_signals_out;
		variable signal_number : in  integer;
		variable value : in  integer;
		variable valid : out integer
	) is
		variable temp_value : std_logic_vector(31 downto 0);
	begin
		valid := 1;
		temp_value := std_logic_vector(to_unsigned(value, 32));
		case signal_number is
			when 0 =>
				signals.CrcDataToBeRead <= temp_value(signals.CrcDataToBeRead'LEFT downto 0);
			when 1 =>
				signals.TimeoutAck_Rec_Clear <= temp_value(0);
			when others =>
				valid := 0;
		end case;
		
		wait for 1 ps;
	end procedure;

	procedure signal_read(
		signal signals : in  t_signals_in;
		variable signal_number : in  integer;
		variable value : out integer;
		variable valid : out integer
	) is
		variable temp_value : std_logic_vector(31 downto 0);
	begin
		valid := 1;
		temp_value := (others => '0');
		case signal_number is
			when 0 =>
				temp_value(signals.CrcDataWritten'LEFT downto 0) := signals.CrcDataWritten;
			when 1 =>
				temp_value(signals.CrcIdrData'LEFT downto 0) := signals.CrcIdrData;
			when 2 =>
				temp_value(signals.CrcControl'LEFT downto 0) := signals.CrcControl;
			when 3 =>
				temp_value(signals.CrcInitialValue'LEFT downto 0) := signals.CrcInitialValue;
			when 4 =>
				temp_value(signals.CrcPolynomial'LEFT downto 0) := signals.CrcPolynomial;
			when 5 =>
				temp_value(0) := signals.TimeoutAck_Detected;
			when others =>
				valid := 0;
		end case;
		value := to_integer(unsigned(temp_value));
	end procedure;

    -- Map interrupts to interrupt requests
    procedure get_interrupt_requests(signal signals : in t_signals_in;
                                     variable interrupt_requests : out unsigned) is
    begin
        -- TODO: Connect in_signals used as interrupt to the interrupt_vector
        -- interrupt_requests(0) := signals.in_signal_2;
        -- interrupt_requests(1) := signals.in_signal_3;
        wait for 0 ps;
    end procedure;

    procedure resolve_interrupt_requests(variable interrupt_requests : in unsigned;
                                         variable interrupt_in_service : in unsigned;
                                         variable interrupt_number : out integer;
                                         variable branch_to_interrupt : out boolean;
                                         variable branch_to_interrupt_label_std_txt_io_line : out line) is
        variable empty_label : line := new string'("");
        variable interrupt_labels : t_interrupt_labels := (
            -- TODO: Add here all your simstm interrupt entry procedure labels
            new string'("$InterruptB"),
            new string'("$InterruptA")
        );
    begin
        interrupt_number := -1;
        branch_to_interrupt := false;
        branch_to_interrupt_label_std_txt_io_line := empty_label;

        -- TODO: Adapt your interrupt priority and nesting logic

        -- Implementation for behavior:
        --   - the lower the interrupt number the higher its priority
        --   - no interrupt nesting
        if interrupt_requests > 0 then
            if interrupt_in_service = 0 then
                for i in 0 to number_of_interrupts - 1 loop
                    if interrupt_requests(i) = '1' then
                        interrupt_number := i;
                        branch_to_interrupt := true;
                        branch_to_interrupt_label_std_txt_io_line := interrupt_labels(i);
                    end if;
                end loop;
            end if;
        end if;

    end procedure;

    -- Set in service bit for a processed interrupt
    procedure set_interrupt_in_service(variable interrupt_in_service : inout unsigned; variable interrupt_number : in integer) is
    begin
        interrupt_in_service(interrupt_number) := '1';
    end procedure;

    -- Reset in service bit for a processed interrupt
    procedure reset_interrupt_in_service(variable interrupt_in_service : inout unsigned; variable interrupt_number : in integer) is
    begin
        interrupt_in_service(interrupt_number) := '0';
    end procedure;

end;
