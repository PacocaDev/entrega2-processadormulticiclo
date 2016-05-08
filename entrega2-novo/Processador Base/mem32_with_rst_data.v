module mem32_with_rst_data (
	input	[15:0] address,
	input clock,
	input	[31:0] data,
	input wren,
	output [31:0] q,
	input rst,
	output rdy);


assign rdy = not_initialized;

always @(posedge clock)
begin
		if(rst)
			initializing <= 1;
		else
			initializing <= 0;
end

wire [31:0] init_data;
wire [13:0] init_addr;
wire init_wren;

reg initializing;
wire not_initialized;
	
mem32 mem32(
	.address(not_initialized ? {init_addr,2'b00} : address),
	.clock(clock),
	.data(not_initialized ? init_data : data),
	.wren(not_initialized ? init_wren : wren),
	.q(q));
	
ram_initializer2 ram_initializer2 (
	.clock(clock),
	.init(initializing),
	.dataout(init_data),
	.init_busy(not_initialized),
	.ram_address(init_addr),
	.ram_wren(init_wren));

endmodule
