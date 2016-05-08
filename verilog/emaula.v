module emaula(

	input[17:0]		SW, // Switches
	input[3:0]		KEY, // Keys
	input CLOCK_50,
	output [17:0] LEDR,
	output reg [7:0] LEDG,
	output[0:6]		HEX0,
	output[0:6]		HEX7,
	output[0:6]		HEX6
	// Display de 7 segmentos 0
);

	reg[3:0] register;
	reg[31:0] counter;
	reg [1:0] fsm;
	
	reg[17:0] num1;
	reg[17:0] num2;
	
	

	displayDecoder DP0(.entrada(SW[3:0]),.saida(HEX0));
	displayDecoder DP6(.entrada(LEDG[3:0]),.saida(HEX6));
	displayDecoder DP7(.entrada(LEDG[7:4]),.saida(HEX7));
	
	initial begin
//		LEDR = 18'd0;
		LEDG = 8'd0;
		fsm = 2'd0;
	end
	
	//always@(posedge CLOCK_50)begin //quando aperta fica baixo
		//counter <= counter + 1;
		//LEDR[17:0] <= counter[31:14];
		//register <= SW[3:0];//pegando apenas os três primeiros Switches
	//end
	
//	always@(posedge LEDR[12])begin
//		LEDG <= LEDG + 1;
//	end
 assign LEDR[17:0] = num1[17:0];	
 
	always@(negedge KEY[0]) begin
		case(fsm)
			2'd0: 
			begin
				num1 <= SW;
				fsm <= 2'd1;
				LEDG[1:0] <= 2'd1;
			end
			2'd1:
			begin
				num2 <= SW;
				fsm <= 2'd2;
				LEDG[1:0] <= 2'd2;
			end
			2'd2:
			begin
				num1 <= num1 + num2;
				fsm <= 2'd0;
				LEDG[1:0] <= 2'd0;
			end
		endcase;
	end
    
endmodule