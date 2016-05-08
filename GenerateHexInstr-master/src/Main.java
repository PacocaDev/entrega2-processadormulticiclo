import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Scanner;

// Universidade Federal de Minas Gerais
// Gerador arquivo .mif com instruções em hexadecima de instruções MIPs para processador multiciclo.
// Arquivo .mif utilizado pela FPGA para carregar dados na memoria de instruções e de dados.
// Created By Filipe Marcelino
// Email.
public class Main {

	private static Scanner inputData;
	private static Scanner inputString;

	public static void main(String[] args) throws IOException {
		
		ArrayList<String> binaryInstr = new ArrayList<String>();
		ArrayList<String> binaryData = new ArrayList<String>();
		String instr;
		String bin;
		inputData = new Scanner(System.in);
		inputString = new Scanner(System.in);
		String []parts = new String[5];
		String data;
		Long aux;
		
		BufferedWriter writer1 = new BufferedWriter(new OutputStreamWriter(
		          new FileOutputStream("inst.mif"), "utf-8"));
		
		BufferedWriter writer2 = new BufferedWriter(new OutputStreamWriter(
		          new FileOutputStream("inst2.mif"), "utf-8"));
		
		String stringFIle = "-- Copyright (C) 1991-2013 Altera Corporation\n"
+ "-- Your use of Altera Corporation's design tools, logic functions\n" 
+ "-- and other software and tools, and its AMPP partner logic\n"
+ "-- functions, and any output files from any of the foregoing\n"
+ "-- (including device programming or simulation files), and any\n" 
+ "-- associated documentation or information are expressly subject\n" 
+ "-- to the terms and conditions of the Altera Program License\n" 
+ "-- Subscription Agreement, Altera MegaCore Function License\n" 
+ "-- Agreement, or other applicable license agreement, including,\n" 
+ "-- without limitation, that your use is for the sole purpose of\n" 
+ "-- programming logic devices manufactured by Altera and sold by\n" 
+ "-- Altera or its authorized distributors.  Please refer to the\n"
+ "-- applicable agreement for further details.\n\n"
+ "-- Quartus II generated Memory Initialization File (.mif)\n\n"
+ "WIDTH=32;\n"
+ "DEPTH=65536;\n\n"
+ "ADDRESS_RADIX=HEX;\n"
+ "DATA_RADIX=HEX;\n\n"
+ "CONTENT BEGIN\n";
	
		// Entrada de valores de instruções em MIPs para trasnformação em hexa.
		// Conjunto de isntruções listados abaixo.
		System.out.println("Gerar arquivo de instrucoes(1) e dados(2)");
		
		while(true){
			
			instr = inputString.nextLine();
			parts = instr.split("\\s+");
			
			// Instruções
			// ADDI
			if(parts[0].equalsIgnoreCase("addi")){
				bin = "001000";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%16s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				bin += parts[2];
				bin += parts[3];
				binaryInstr.add(bin);
			// ADD
			}else if(parts[0].equalsIgnoreCase("add")){
				bin = "000000";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				bin += parts[2];
				bin += parts[3];
				bin += "00000";
				bin += "100000";
				binaryInstr.add(bin);
			// SUB
			}else if(parts[0].equalsIgnoreCase("sub")){
				bin = "000000";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				bin += parts[2];
				bin += parts[3];
				bin += "00000";
				bin += "100010";
				binaryInstr.add(bin);
			// AND
			}else if(parts[0].equalsIgnoreCase("and")){
				bin = "000000";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				bin += parts[2];
				bin += parts[3];
				bin += "00000";
				bin += "100100";
				binaryInstr.add(bin);
			// OR	
			}else if(parts[0].equalsIgnoreCase("or")){
				bin = "000000";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				bin += parts[2];
				bin += parts[3];
				bin += "00000";
				bin += "100101";
				binaryInstr.add(bin);
			// XOR
			}else if(parts[0].equalsIgnoreCase("xor")){
				bin = "000000";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				bin += parts[2];
				bin += parts[3];
				bin += "00000";
				bin += "100110";
				binaryInstr.add(bin);
			// NOR
			}else if(parts[0].equalsIgnoreCase("nor")){
				bin = "000000";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				bin += parts[2];
				bin += parts[3];
				bin += "00000";
				bin += "100111";
				binaryInstr.add(bin);
			// SLL
			}else if(parts[0].equalsIgnoreCase("sll")){
				bin = "000000";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[4]);
				parts[4] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += "00000";
				bin += parts[2];
				bin += parts[3];
				bin += parts[4];
				bin += "000000";
				binaryInstr.add(bin);
			// SRL
			}else if(parts[0].equalsIgnoreCase("srl")){
				bin = "000000";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[4]);
				parts[4] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += "00000";
				bin += parts[2];
				bin += parts[3];
				bin += parts[4];
				bin += "000010";
				binaryInstr.add(bin);
			// J
			}else if(parts[0].equalsIgnoreCase("j")){
				bin = "000010";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%26s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				binaryInstr.add(bin);
			// JR
			}else if(parts[0].equalsIgnoreCase("jr")){
				bin = "000000";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				bin += "000000000000000";
				bin += "001000";
				binaryInstr.add(bin);
			// LOAD
			}else if(parts[0].equalsIgnoreCase("lw")){
				bin = "100001";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%16s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				bin += parts[2];
				bin += parts[3];
				binaryInstr.add(bin);
			//STORE
			}else if(parts[0].equalsIgnoreCase("sw")){
				bin = "101011";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%16s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				bin += parts[2];
				bin += parts[3];
				binaryInstr.add(bin);
			// BEQ
			}else if(parts[0].equalsIgnoreCase("beq")){
				bin = "000100";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%16s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				bin += parts[2];
				bin += parts[3];
				binaryInstr.add(bin);
			// BNE
			}else if(parts[0].equalsIgnoreCase("bne")){
				bin = "000101";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[2]);
				parts[2] = String.format("%5s",Long.toBinaryString(aux)).replace(' ', '0');
				aux = Long.parseLong(parts[3]);
				parts[3] = String.format("%16s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				bin += parts[2];
				bin += parts[3];
				binaryInstr.add(bin);
			// JAL
			}else if(parts[0].equalsIgnoreCase("jal")){
				bin = "000011";
				aux = Long.parseLong(parts[1]);
				parts[1] = String.format("%26s",Long.toBinaryString(aux)).replace(' ', '0');
				bin += parts[1];
				binaryInstr.add(bin);
			// Sem instruções, adicionar instrução de halted
			}else{
				binaryInstr.add("11111111111111111111111111111111");
				break;
			}
			
			
		}
		
		// Entrada de valores numericos para a memoria de dados.
		// Até 1 MB de memoria.
		// Uma por linha.
		System.out.println("Gerar memoria dados, 'q' ou 'Q' para sair ");
		
		while(true){
			
			data = inputData.nextLine();
			
			if(data.equalsIgnoreCase("q"))break;
			else{
				aux = Long.parseLong(data);
				data = String.format("%32s",Long.toBinaryString(aux)).replace(' ', '0');
				binaryData.add(data);
			}
			
		}
		
		// geração dos arquivos .mif
		writer1.write(stringFIle);
		
		for(int i = 0; i < binaryInstr.size(); i++){
			writer1.write("	");
			aux = Long.parseLong(binaryInstr.get(i),2);
			writer1.write(String.format("%5s",Long.toHexString(i)).replace(' ', '0') + "  :   " + String.format("%8s",Long.toHexString(aux)).replace(' ', '0')+ ";\n");
		}
		
		writer1.write("	[" + String.format("%5s",Long.toHexString(binaryInstr.size())).replace(' ', '0') + ".." + "0FFFF]  :   00000000;\n" );	
		writer1.write("END;");
		writer1.close();
		
		writer2.write(stringFIle);
		
		for(int i = 0; i < binaryData.size(); i++){
			writer2.write("	");
			aux = Long.parseLong(binaryData.get(i),2);
			writer2.write(String.format("%5s",Long.toHexString(i)).replace(' ', '0') + "  :   " + String.format("%8s",Long.toHexString(aux)).replace(' ', '0')+ ";\n");
		
		}
		writer2.write("	[" + String.format("%5s",Long.toHexString(binaryData.size())).replace(' ', '0') + ".." + "0FFFF]  :   00000000;\n" );
		writer2.write("END;");
		writer2.close();
		
	}

}
