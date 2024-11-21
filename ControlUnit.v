`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Devin Kot-Thompson
// Create Date: 10/14/2024 09:15:11 PM
// Design Name: 
// Module Name: ControlUnit
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

module ControlUnit(Opcode, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);

	input [6:0] Opcode;
	output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
	output reg [2:0] ALUOp;

    wire [6:0] BranchMask;
	assign BranchMask = 7'b1100011;
	wire [6:0] SMask;
	assign SMask = 7'b0100011;
	wire [6:0] RMask;
	assign RMask = 7'b0110011;
	wire [6:0] IMask1;
	assign IMask1 = 7'b0000011;
	wire [6:0] IMask2;
	assign IMask2 = 7'b0001111;
	wire [6:0] IMask3;
	assign IMask3 = 7'b0010011;
	wire [6:0] IMask4;
	assign IMask4 = 7'b1100111;
	wire [6:0] IMask5;
	assign IMask5 = 7'b1110011;
	wire [6:0] UMask1;
	assign UMask1 = 7'b0010111;
	wire [6:0] UMask2;
	assign UMask2 = 7'b0110111;
	wire [6:0] UJMask;
	assign UJMask = 7'b0100011;
	
	always @* begin
	//handle branch instruction control lines
    if(BranchMask == Opcode) begin
    Branch = 1'b1;
	ALUSrc = 1'b0;
	RegWrite = 1'b0;
	ALUOp = 3'b001;
	MemRead = 1'b0;
	MemtoReg = 1'b0;
	MemWrite = 1'b0;
	end
	//S Fmt
	else if(SMask == Opcode) begin
    Branch = 1'b0;
	ALUSrc = 1'b1;
	RegWrite = 1'b0;
	ALUOp = 3'b000;
	MemRead = 1'b0;
	MemtoReg = 1'b0;
	MemWrite = 1'b1;
	end
	
	//R Fmt 
	else if(RMask == Opcode) begin
    Branch = 1'b0;
	ALUSrc = 1'b0;
	RegWrite = 1'b1;
	ALUOp = 3'b010;
	MemRead = 1'b0;
	MemtoReg = 1'b0;
	MemWrite = 1'b0;
	end
	
	//I Fmt 1 Load
	else if(IMask1 == Opcode) begin
    Branch = 1'b0;
	ALUSrc = 1'b1;
	RegWrite = 1'b1;
	ALUOp = 3'b000;
	MemRead = 1'b1;
	MemtoReg = 1'b1;
	MemWrite = 1'b0; 
	end
	
	//I Fmt immediate instructions
	else if((IMask2 == Opcode)|(IMask3 == Opcode)|(IMask4 == Opcode)|(IMask5 == Opcode)) begin
    Branch = 1'b0;
	ALUSrc = 1'b1;
	RegWrite = 1'b1;
	ALUOp = 3'b011;
	MemRead = 1'b0;
	MemtoReg = 1'b0;
	MemWrite = 1'b0;
	end
	
	//U Fmt immediate instructions might not use ALU directly default to addition op for now in ALUCtrl
	else if((UMask1 == Opcode)|(UMask2 == Opcode)) begin
    Branch = 1'b0;
	ALUSrc = 1'b1;
	RegWrite = 1'b1;
	ALUOp = 3'b100;
	MemRead = 1'b0;
	MemtoReg = 1'b0;
	MemWrite = 1'b0;
	end
	
	
	//UJ Fmt immediate instructions defaulting to addition may need to be changed later
	else if((UJMask == Opcode)) begin
    Branch = 1'b0;
	ALUSrc = 1'b0;
	RegWrite = 1'b1;
	ALUOp = 2'b000;
	MemRead = 1'b0;
	MemtoReg = 1'b0;
	MemWrite = 1'b0;
	end
	
    end
endmodule