`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Devin Kot-Thompson
// 
// Create Date: 11/22/2024 11:24:31 AM
// Design Name: 
// Module Name: BranchUnit
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


module BranchUnit(SrcA, SrcB, Opcode, Funct3, BranchTaken);

    input [31:0] SrcA;
    input [31:0] SrcB;
    input [6:0] Opcode;
    input [2:0] Funct3;
    output reg BranchTaken;
    
    wire signed [31:0] SignedSrcA;
    wire signed [31:0] SignedSrcB;
    wire beq, bge, bgeu, blt, bltu, bne;
    
    assign SignedSrcA = SrcA;
    assign SignedSrcB = SrcB;
    
    assign beq = (SignedSrcA == SignedSrcB);
    assign bge = (SignedSrcA >= SignedSrcB);
    assign bgeu = (SrcA >= SrcB);
    assign blt = (SignedSrcA < SignedSrcB);
    assign bltu = (SrcA < SrcB);
    assign bne = (SignedSrcA != SignedSrcB);
    
    always @(*) begin
    BranchTaken = 1'b0;
    if(Opcode == 7'b1100011) begin
    case(Funct3)
    3'b000: BranchTaken = beq;
    3'b001: BranchTaken = bne;
    3'b100: BranchTaken = blt;
    3'b101: BranchTaken = bge;
    3'b110: BranchTaken = bltu;
    3'b111: BranchTaken = bgeu;
    endcase
    end
    end
endmodule