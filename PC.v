`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Devin Kot-Thompson
// Create Date: 10/14/2024 09:15:11 PM
// Design Name: 
// Module Name: PC
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


module PC(clock, PCnext, PC);
    parameter BITSIZE = 32;
    
    input clock;
    input [BITSIZE-1:0] PCnext;
    output reg [BITSIZE-1:0] PC;
    
    initial begin
    PC = 32'b0;
    end
    
    always begin
    @(posedge clock)
		PC <= PCnext;
    end
    
endmodule
