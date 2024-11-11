`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2024 09:45:15 AM
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(
    input [2:0] ALUOp,
    input Funct7,
    input [2:0] Funct3,
    output reg [4:0] ALUCtrl
    );


always @(*) begin
    case(ALUOp)
    0: ALUCtrl = 5'b00010; //load make sure support for lw, lh, lb & sw, sh, sb
    1: ALUCtrl = 5'b01010;
    2: if((Funct3 == 3'b000) && (Funct7 == 1'b0)) ALUCtrl = 5'b00010; //add
       else if((Funct3 == 3'b000) && (Funct7 == 1'b1)) ALUCtrl = 5'b01010; //sub
       else if((Funct3 == 3'b001) && (Funct7 == 1'b0)) ALUCtrl = 5'b00110; //sll
       else if((Funct3 == 3'b010) && (Funct7 == 1'b0)) ALUCtrl = 5'b01011; //slt
       else if((Funct3 == 3'b011) && (Funct7 == 1'b0)) ALUCtrl = 5'b01011; //sltu might not be currently supported
       else if((Funct3 == 3'b100) && (Funct7 == 1'b0)) ALUCtrl = 5'b00100; //xor
       else if((Funct3 == 3'b101) && (Funct7 == 1'b1)) ALUCtrl = 5'b00111; //srl
       else if((Funct3 == 3'b101) && (Funct7 == 1'b1)) ALUCtrl = 5'b00101; //sra
       else if((Funct3 == 3'b110) && (Funct7 == 1'b0)) ALUCtrl = 5'b00001; //or
       else if((Funct3 == 3'b111) && (Funct7 == 1'b0)) ALUCtrl = 5'b00000; //and
    3: if(Funct3 == 3'b000) ALUCtrl = 5'b00010; //addi
       else if(Funct3 == 3'b001) ALUCtrl = 5'b00110; //slli
       else if(Funct3 == 3'b010) ALUCtrl = 5'b01011; //slti
       else if(Funct3 == 3'b011) ALUCtrl = 5'b01011; //sltiu not sure how to handle this leave same for now
       else if(Funct3 == 3'b100) ALUCtrl = 5'b00100; //xori 
       else if((Funct3 == 3'b101) && (Funct7 == 1'b0)) ALUCtrl = 5'b00111; //srli
       else if((Funct3 == 3'b101) && (Funct7 == 1'b1)) ALUCtrl = 5'b00101; //srai
       else if(Funct3 == 3'b110) ALUCtrl = 5'b00001; //ori
       else if(Funct3 == 3'b111) ALUCtrl = 5'b00000; //andi
       //lacking support for some of the I instructions 
    4: ALUCtrl = 5'b00010;
    endcase
end
endmodule