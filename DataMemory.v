`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Devin Kot-Thompson
// Create Date: 10/14/2024 09:15:11 PM
// Design Name: 
// Module Name: DataMemory
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

module DataMemory(clock, Addr, WriteData, MemWrite, MemRead, ReadData);
	input clock;
	input [31:0] Addr;
	input [31:0] WriteData;
	input MemWrite;
	input MemRead;
	output [31:0] ReadData;
	
	reg [31:0]RAM[1023:0];
	
	assign ReadData = (MemRead)? RAM[Addr>>2]:32'bx;

	always @(posedge clock)
	begin 
	
	if(MemWrite)
	
	RAM[Addr>>2] <= WriteData;
	
	end
	
endmodule