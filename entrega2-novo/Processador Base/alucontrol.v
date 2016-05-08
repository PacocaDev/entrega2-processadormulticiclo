module alucontrol(
input [5:0] opcode,
input [5:0] funct,
output reg [2:0] alu_func
);

//Complete e complemente o código da entrega 1 do trabalho prático
//Renomeados em relação a entrega 1 para adequação

always @(*) begin
        case (opcode)
            6'b001000: alu_func <= 3'b000; // Addi
				6'b100001: alu_func <= 3'b000; // Load
				6'b101011: alu_func <= 3'b000; // Store
				
            default: case (funct)
                6'b100000: alu_func <= 3'b000;  //Adição
                6'b100010: alu_func <= 3'b001;  //Subtração
                6'b100100: alu_func <= 3'b010;  //E lógico
                6'b100101: alu_func <= 3'b011;  //Ou lógico
                6'b100110: alu_func <= 3'b100;  //Ou exclusivo lógico
                6'b100111: alu_func <= 3'b101;  //Não Ou lógico
                6'b000000: alu_func <= 3'b110;  //Shift Esquerda lógico
                6'b000010: alu_func <= 3'b111;  //Shift Direita lógico
                default: alu_func <= 3'bzzz; // FuncInvalido
            endcase
        endcase
	end
	
	
endmodule
