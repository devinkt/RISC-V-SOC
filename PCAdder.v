`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Devin Kot-Thompson
// Create Date: 10/14/2024 09:15:11 PM
// Design Name: 
// Module Name: PCAdder
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

module PCAdder(PC, Increment, PCnext);
    parameter BITSIZE = 32;
	
	input [BITSIZE-1:0] PC;
	input [2:0] Increment;
	output [BITSIZE-1:0] PCnext;
	
	assign Increment = 3'b100;
	assign PCnext = Increment + PC;
	
endmodule