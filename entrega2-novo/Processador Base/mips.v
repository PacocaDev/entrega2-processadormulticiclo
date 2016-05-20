module mips(
input         CLOCK_50,
input  [3:0]  KEY,
output [8:0]  LEDG,
output [17:0] LEDR,
output [0:6]  HEX0,
output [0:6]  HEX1,
output [0:6]  HEX2,
output [0:6]  HEX3,
output [0:6]  HEX4,
output [0:6]  HEX5,
output [0:6]  HEX6,
output [0:6]  HEX7,
input  [17:0] SW
);


reg [3:0] fsm;
reg [3:0] fsm2;
reg [31:0] ir;
reg [15:0] pc;
reg [1:0] inst_type;

reg will_write;
reg will_write_mem;
reg halted;

wire [31:0] inst_mem_out;
wire [31:0] data_mem_out;
wire rst,clk;

wire [15:0] pc_mux_out;

//CLOCK
integer count;

//Using 22nd bit of counter.
assign clk = rdy ? count[22] : count[0]; //CLOCK_50;

always@(posedge CLOCK_50)
begin
	count <= count + 1;
end


assign rst = ~KEY[0];

assign LEDG[3:0] = fsm[3:0];

assign LEDR[15:0] = pc[15:0];
assign LEDG[8] = halted;


//Instruction Decoder
wire [5:0] opcode;
assign opcode = ir[31:26];

wire [4:0] rs;
assign rs = ir[25:21];

wire [4:0] rt;
assign rt = ir[20:16];

wire [4:0] rd;
assign rd = ir[15:11];

wire [4:0] shamt;
assign shamt = ir[10:6];

wire [5:0] funct;
assign funct = ir[5:0];

wire [15:0] immediate;
wire [31:0] imm_ext;
assign immediate = ir[15:0];
assign imm_ext = { {16{immediate[15]}}, immediate[15:0] };

wire [25:0] addr;
assign addr = ir[26:0];


//ALU
wire [31:0] op1;
wire [31:0] op2;
wire [31:0] alu_op2;
wire [2:0] alu_func;
wire [31:0] alu_out;
wire [31:0] alu_res;
wire alu_zero;
reg is_immediate;
reg tic_toc;

wire rdy;
wire rdy_i;
wire rdy_d;

assign rdy = ~rdy_i & ~rdy_d;


assign LEDR[17] = rdy;
assign LEDR[16] = tic_toc;

alucontrol alucontrol(.opcode(opcode),.funct(funct),.alu_func(alu_func));
alu alu(.op1(op1),.op2(alu_op2),.func(alu_func),.shamt(shamt),.result(alu_res),.zero(alu_zero));
mux32 alu_mux(.in0(op2),.in1(imm_ext),.sel(is_immediate),.out(alu_op2));

//Memory
reg wr_mem_enabled;

reg rst_mem = 1;

//Instruction Memory
mem32_with_rst mem32_with_rst(.address(pc),.clock(clk),.q(inst_mem_out),.rst(rst_mem),.rdy(rdy_i));

//Data Memory
mem32_with_rst_data mem32_with_rst_data(.address(alu_res),.clock(clk),.data(op2),.wren(wr_mem_enabled & will_write_mem),.q(data_mem_out),.rst(rst_mem),.rdy(rdy_d));



//Register File
reg wr_enable;
reg [15:0] jal_Aux;
wire [31:0] regData;
regfile regfile(.reg1(rs),.reg2(rt),.out1(op1),.out2(op2),.wr_enable(wr_enable & will_write),.data((opcode == 6'b000011) ? jal_Aux:(opcode == 6'b100001  ? data_mem_out : alu_res)),.reg_wr((opcode == 6'b000011)? 5'b11111 :(is_immediate ? rt : rd)),.regDisplay(SW[4:0]),.outDisplay(regData),.rst(rst)); 
//SW[4:0] defines which register should output data to regData.

//7segs

wire [31:0] decodeData;

//SW[17] defines which data should be shown on the 7segs (the last instruction decoded or the data from one of the registers)
assign decodeData = SW[17] ? regData : ir;


displayDecoder hex0(.entrada(decodeData[3:0]),.saida(HEX0));
displayDecoder hex1(.entrada(decodeData[7:4]),.saida(HEX1));
displayDecoder hex2(.entrada(decodeData[11:8]),.saida(HEX2));
displayDecoder hex3(.entrada(decodeData[15:12]),.saida(HEX3));
displayDecoder hex4(.entrada(decodeData[19:16]),.saida(HEX4));
displayDecoder hex5(.entrada(decodeData[23:20]),.saida(HEX5));
displayDecoder hex6(.entrada(decodeData[27:24]),.saida(HEX6));
displayDecoder hex7(.entrada(decodeData[31:28]),.saida(HEX7));




always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		fsm <= 4'b0000;
		halted <= 0;
		rst_mem <= 1;
	end
	else 
	begin
		tic_toc <= ~tic_toc;
		if(!halted)
		begin
			case(fsm)
			4'b0000: //Reset
			begin
				pc <= 32'd0;
				ir <= 32'd0;
				fsm <= 4'b1000;
			end
			
			4'b1000: //Memory reset signal must be on for at least one full cycle.
			begin
				rst_mem <= 0;
				fsm <= 4'b1001;
			end
			
			4'b1001: //Wait for memory fill.
			begin
				if(rdy)
					fsm <= 4'b1010;
			end
			
			4'b1010: //Delay for fetching the first instruction
			begin
					fsm <= 4'b0001;
			end
		end
	end
end
always @((posedge clk or posedge rst) && fsm == 4'b0001)
begin
			//IF
			begin
				pc <= pc + 4;
				is_immediate <= 0;
				wr_enable <= 1'b0; //Finish writing
				wr_mem_enabled <= 1'b0;
				will_write <= 1'b0;
				will_write_mem <= 1'b0;
				ir <= inst_mem_out;
			end

			//ID
			begin
				case(opcode)
					6'd0:	//R
					begin
						inst_type <= 2'b01;
					end
					6'b000010: //J (j)
					begin
						inst_type <= 2'b10;
					end
					6'b000011: //J (jal)
					begin
						inst_type <= 2'b10;
					end
					6'b111111: //HALT
					begin
						halted <= 1;
						inst_type <= 2'b000;
					end
					default: //I
					begin
						inst_type <= 2'b11;
						is_immediate <= 1;
					end
				endcase
				
				
			end
			//EX
			begin
				if(inst_type[0]) //R | I
					begin
						if(opcode == 6'b000000) begin //R
							// JR						
							if(funct == 6'b001000) begin
								pc <= op1; 
							end
							else begin
							will_write <=1;
							end
						end
						else if(opcode == 6'b001000)begin //ADDI
						will_write <= 1;
						end
						else if(opcode == 6'b100001)begin // load
						will_write <= 1;
						end
						else if(opcode == 6'b101011)begin // store
						will_write_mem <=1;
						end
						else if(opcode == 6'b000100)begin // BEQ -> branch equal
							if(op1 == op2) begin
							 pc <= pc + (4*immediate); 
							end
						end
						else if(opcode == 6'b000101)begin // BNE -> branch not equal
							if(op1 != op2) begin
							pc <= pc + (4*immediate);
							end
						end
						
					end
				else	//J
					if(opcode[0])begin
						// Jal
						will_write <= 1; 
						jal_Aux = pc;
						//escrever no 31 no parametro do regfile
						//data no parametro do regfile pc
						pc = {addr[13:0],2'b00};
						end
					else
						begin 
							// J
							pc <= {addr[13:0],2'b00};//{pc[31:28] , addr};
							will_write <= 0;
						end
			end
			//MEM
			begin	
				wr_mem_enabled <= 1'b1;	
			end
			//WB
			begin
				wr_mem_enabled <= 1'b0;
				wr_enable <= 1'b1;
			end
			endcase
		end
	end
end

//10220002
//(opcode == 6'b000011) ? jal_Aux:(
//(opcode == 6'b000011)? 5'b11111 :

endmodule
