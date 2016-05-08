module alu(
	input [31:0]	op1,
	input [31:0]	op2,
	input [2:0]		func,
    input [4:0]     shamt,
	output reg [31:0]	result,
	output zero
);


//Complete com o código da entrega 1 do trabalho prático
//Renomeados em relação a entrega 1 para adequação

assign zero = (result==0);
    
    always @(func, op1, op2) begin
        case (func)
            3'b000: result <= op1 + op2;        //Adição
            3'b001: result <= op1 - op2;        //Subtração
            3'b010: result <= op1 & op2;        //E lógico
            3'b011: result <= op1 | op2;        //Ou lógico
            3'b100: result <= op1 ^ op2;        //Ou exclusivo lópgico (XOR)
            3'b101: result <= ~(op1 | op2);     //Não Ou lógico (NOR)
            3'b110: result <= op2 << shamt;  //Shift Esquerda lógico (sll)
            3'b111: result <= op2 >> shamt;  //Shift Direita lógico (srl)
        endcase
    end

endmodule
