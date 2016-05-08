module mux32(
	input [31:0] in0,
	input [31:0] in1,
	input sel,
	output reg [31:0] out
);

always@(in0,in1,sel)
	if(sel)
		out <= in1;
	else
		out <= in0;


endmodule
