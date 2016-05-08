module mem32 (
	input	[15:0] address,
	input clock,
	input	[31:0] data,
	input wren,
	output [31:0] q);
	
//4-byte memory addressable on each byte.

reg [13:0] addr [3:0];
wire [7:0] mem_in [3:0];
wire [7:0] mem_out [3:0];

reg [1:0] prev_addr_end;


mem8 mem8_0(addr[0], clock, mem_in[0], wren, mem_out[0]);
mem8 mem8_1(addr[1], clock, mem_in[1], wren, mem_out[1]);
mem8 mem8_2(addr[2], clock, mem_in[2], wren, mem_out[2]);
mem8 mem8_3(addr[3], clock, mem_in[3], wren, mem_out[3]);	

mux8_4 mux_in0(.in0(data[31:24]),.in1(data[7:0]),.in2(data[15:8]),.in3(data[23:16]),.sel(address[1:0]),.out(mem_in[0]));
mux8_4 mux_in1(.in0(data[23:16]),.in1(data[31:24]),.in2(data[7:0]),.in3(data[15:8]),.sel(address[1:0]),.out(mem_in[1]));
mux8_4 mux_in2(.in0(data[15:8]),.in1(data[23:16]),.in2(data[31:24]),.in3(data[7:0]),.sel(address[1:0]),.out(mem_in[2]));
mux8_4 mux_in3(.in0(data[7:0]),.in1(data[15:8]),.in2(data[23:16]),.in3(data[31:24]),.sel(address[1:0]),.out(mem_in[3]));


mux8_4 mux_out0(.in0(mem_out[0]),.in1(mem_out[1]),.in2(mem_out[2]),.in3(mem_out[3]),.sel(prev_addr_end),.out(q[31:24]));
mux8_4 mux_out1(.in0(mem_out[1]),.in1(mem_out[2]),.in2(mem_out[3]),.in3(mem_out[0]),.sel(prev_addr_end),.out(q[23:16]));
mux8_4 mux_out2(.in0(mem_out[2]),.in1(mem_out[3]),.in2(mem_out[0]),.in3(mem_out[1]),.sel(prev_addr_end),.out(q[15:8]));
mux8_4 mux_out3(.in0(mem_out[3]),.in1(mem_out[0]),.in2(mem_out[1]),.in3(mem_out[2]),.sel(prev_addr_end),.out(q[7:0]));

always@(posedge clock)
begin
	prev_addr_end <= address[1:0];
end


always @(address)
begin
	case(address[1:0])
	2'b00:
	begin
		addr[0] <= address[15:2];
		addr[1] <= address[15:2];
		addr[2] <= address[15:2];
		addr[3] <= address[15:2];
	end
	2'b01:
	begin
		addr[0] <= address[15:2] + 1;
		addr[1] <= address[15:2];
		addr[2] <= address[15:2];
		addr[3] <= address[15:2];
	end
	2'b10:
	begin
		addr[0] <= address[15:2] + 1;
		addr[1] <= address[15:2] + 1;
		addr[2] <= address[15:2];
		addr[3] <= address[15:2];
	end
	2'b11:
		begin
		addr[0] <= address[15:2] + 1;
		addr[1] <= address[15:2] + 1;
		addr[2] <= address[15:2] + 1;
		addr[3] <= address[15:2];
	end
	endcase
end

endmodule
