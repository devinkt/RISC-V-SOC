`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2024 09:05:09 AM
// Design Name: 
// Module Name: PCBranch
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


module PCBranch(PCAddr, Immediate, PCBranch);
    
    parameter BITSIZE = 32;
    
    input [BITSIZE-1:0] PCAddr;
    input [BITSIZE-1:0] Immediate;
    output [BITSIZE-1:0] PCBranch;
    
    assign PCBranch = PCAddr + (Immediate);//try removing this <<2
    
endmodule