module regfile(
	input [4:0] reg1,
	input [4:0] reg2,
	input [4:0] regDisplay,
	
	output  [31:0] out1,
	output  [31:0] out2,
	output reg [31:0] outDisplay,
	
	input [31:0] data,
	input [4:0] reg_wr,
	input wr_enable,

	input rst
	
);
integer i =0;
reg [31:0] file [31:0];



//Complete com a entrega 1 do trabalho prático
//Renomeados em relação a entrega 1 para adequação



        assign out1 = file[reg1];        
        assign out2 = file[reg2]; 
    

    always @(posedge rst or posedge wr_enable) begin
		if(rst) begin
				for(i=0;i<32;i=i+1)begin
					file[i] <= 32'b00000000000000000000000000000000;
				end
		end
		else begin
			if (wr_enable) begin
				if(reg_wr!= 5'b00000)begin
				file[reg_wr] <= data;
				end
			end
		end
	 end
	
            


//O código a seguir permite a leitura de um terceiro registrado para que seja visualizado nos displays de 7 segmentos
always@(regDisplay)
begin
		outDisplay <= file[regDisplay];
end

endmodule
