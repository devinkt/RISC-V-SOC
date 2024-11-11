`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Devin Kot-Thompson
// Create Date: 10/14/2024 09:15:11 PM
// Design Name: 
// Module Name: ImmediateGen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ImmediateGen(Ins, Immediate);
	
	input [31:0] Ins;
	output reg [31:0] Immediate;
	
	wire[6:0] Opcode;
	
	assign Opcode = Ins[6:0];
	
	wire[6:0] Mask;
	
	assign Mask = ((Opcode[6:2]) & (5'h1F));
	
	reg [4:0] Fmt;
	//Ifmt, Sfmt, SBfmt, Ufmt, UJ
		// I fmt
	/*0000011
	  0001111
	  0010011
	  1100111
	  1110011*/
	// S fmt
	//0100011
	//SB fmt
	//1100011
	//U fmt
	//0010111
	//0110111
	//UJ
	//1101111
	
	always @(*)
	begin
		case(Mask)
		7'b00000: Fmt = 5'b10000;
		7'b00011: Fmt = 5'b10000;
		7'b00100: Fmt = 5'b10000;
		7'b11001: Fmt = 5'b10000;
		7'b11100: Fmt = 5'b10000;
		7'b01000: Fmt = 5'b01000;
		7'b11000: Fmt = 5'b00100;
		7'b00101: Fmt = 5'b00010;
		7'b01101: Fmt = 5'b00010;
		7'b11011: Fmt = 5'b00001;
		endcase
		if (Fmt & 5'h10) Immediate = {{20{Ins[31]}}, Ins[31:20]};
		else if (Fmt & 5'h08) Immediate = {{20{Ins[31]}}, Ins[31:25], Ins[11:7]};
		else if (Fmt & 5'h04) Immediate = {{20{Ins[31]}}, Ins[31], Ins[7], Ins[30:25], Ins[11:8], 1'b0};
		else if (Fmt & 5'h02) Immediate = {Ins[31:12], {12{1'b0}}};
		else if (Fmt & 5'h01) Immediate = {{11{Ins[31]}}, Ins[31], Ins[19:12], Ins[20], Ins[30:21], 1'b0};
	end
	
endmodule