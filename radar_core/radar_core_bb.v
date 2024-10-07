
module radar_core (
	clk_clk,
	pio_0_external_connection_export,
	pio_1_external_connection_export,
	pio_2_external_connection_export,
	reset_reset_n,
	pio_3_external_connection_export);	

	input		clk_clk;
	output	[7:0]	pio_0_external_connection_export;
	output	[9:0]	pio_1_external_connection_export;
	output	[9:0]	pio_2_external_connection_export;
	input		reset_reset_n;
	input	[15:0]	pio_3_external_connection_export;
endmodule
