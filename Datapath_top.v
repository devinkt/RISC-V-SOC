`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Devin Kot-Thompson
// 
// Create Date: 10/30/2024 04:31:44 PM
// Design Name: 
// Module Name: Datapath
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


module Datapath_top();
    parameter BITSIZE = 32;
    
    //Ins Memory
    wire [BITSIZE-1:0] PCAddr;
    wire [BITSIZE-1:0] Ins;
    
    //Register File
    wire [4:0] RR1;
    wire [4:0] RR2;
    assign RR1 = Ins[19:15];
    assign RR2 = Ins[24:20];
    wire [4:0] WR;
    assign WR = Ins[11:7];
    wire [BITSIZE-1:0] WD;
    wire WEn;
    reg clock;
    reg reset;
    wire [BITSIZE-1:0] RD1;
    wire [BITSIZE-1:0] RD2;
    
    //Immediate Gen
    wire [BITSIZE-1:0] Immediate;
    
    //Control Unit
    wire [6:0] Opcode;
    assign Opcode = Ins[6:0];
    wire Branch, MemRead,  MemtoReg, MemWrite, ALUSrc, RegWrite;
    wire [2:0] ALUOp;
    
    assign WEn = RegWrite;
    
    //ALUControl
    wire [2:0] Funct3;
    assign Funct3 = Ins[14:12];
    wire Funct7;
    assign Funct7 = Ins[30];
    wire [4:0] ALUCtrl;
    
    //ALU
    wire [BITSIZE-1:0] SrcA;
    wire [BITSIZE-1:0] SrcB;
    assign SrcA = RD1;
    assign SrcB = (ALUSrc)? Immediate:RD2;
    wire Ainv, Binv;
    assign Ainv = ALUCtrl[4];
    assign Binv = ALUCtrl[3];
    wire [2:0] ALUsel;
    assign ALUsel[2:0] = ALUCtrl [2:0];
    wire Zero, Overflow, Carryout;
    wire [BITSIZE-1:0] Result;
    
    //DataMemory
    wire [BITSIZE-1:0] Addr;
    assign Addr = Result;
    wire [BITSIZE-1:0] WriteData;
    assign WriteData = RD2; 
    wire [BITSIZE-1:0] ReadData;     
    
    assign WD = (MemtoReg)? ReadData:Result;
    
    //PC inc
    wire [BITSIZE-1:0] PCnext;
    wire [BITSIZE-1:0] PCp4;
    wire [BITSIZE-1:0] PCBranch;
    assign PCnext = (Branch & Zero) ? PCBranch : PCp4;
   
    PCAdder PA (PCAddr, Increment, PCp4);
    PCBranch PB (PCAddr, Immediate, PCBranch);
    PC PC1 (clock, PCnext, PCAddr);
    InstructionMemory IM(PCAddr, Ins);
    RegisterFile RF(RR1, RR2, WR, WD, WEn, clock, reset, RD1, RD2);
    ImmediateGen IG (Ins, Immediate);
    ControlUnit CU(Opcode, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
    ALUControl AC (ALUOp, Funct7, Funct3, ALUCtrl);
    RISCV_ALU ALU(SrcA, SrcB, Ainv, Binv, ALUsel, Zero, Result, Overflow, Carryout);
    DataMemory DM(clock, Addr, WriteData, MemWrite, MemRead, ReadData);
        

    initial begin
    clock = 0;
    forever #5 clock = ~clock;
    end
    
endmodule

