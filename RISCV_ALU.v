`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Devin Kot-Thompson
// 
// Create Date: 10/14/2024 09:33:48 PM
// Design Name: 
// Module Name: RISCV_ALU
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


module RISCV_ALU(SrcA, SrcB, Ainv, Binv, ALUsel, Zero, Result, Overflow, Carryout, Negative);  

    input [31:0] SrcA;
    input [31:0] SrcB;
    input Ainv;
    input Binv;
    input [2:0] ALUsel;
    output Zero;
    output reg [31:0] Result;
    output reg Overflow;
    output reg Carryout;
    output reg Negative;
    
    assign Zero = (Result==0)?1:0;
    always begin
    @(*)
        //anything not negating source A or B has to have top 2 bits be 0
        case({Ainv, Binv, ALUsel})
            0: Result = (SrcA & SrcB); //00000
            1: Result = (SrcA | SrcB); //00001
            2: Result = (SrcA + SrcB); //00010
            10:Result = (SrcA - SrcB); //01010
            4: Result = (SrcA ^ SrcB); //00100
            5: Result = $signed(SrcA) >>> SrcB; //00101
            6: Result = (SrcA << SrcB); //00110
            7: Result = (SrcA >> SrcB); //00111
            11:Result = (SrcA<SrcB)?1:0; //01011
            24:Result = (~(SrcA | SrcB)); //11000
        endcase
	    if(Result[31] == 1) Negative = 1; else Negative = 0; //neg flag
	    if((Result < SrcA)|(Result < SrcB)) Carryout = 1; else Carryout = 0; //carry-out
        if(((SrcA[30] & SrcB[30]) | ((SrcA[30] | SrcB[30]) & ~(Result[30]))) ^ 
        ((SrcA[31] & SrcB[31]) | ((SrcA[31] | SrcB[31]) & ~Result[31]))) Overflow = 1; else Overflow = 0; //overflow
    end
    
	
            
endmodule