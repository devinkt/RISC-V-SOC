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

module DataMemory(clock, Funct3, Immediate, Addr, WriteData, MemWrite, MemRead, ReadData);
	input clock;
	input [2:0] Funct3;
	input [31:0] Immediate;
	input [31:0] Addr;
	input [31:0] WriteData;
	input MemWrite;
	input MemRead;
	output reg [31:0] ReadData;
	
	reg [31:0]RAM[1023:0];
    wire [1:0] byte_offset = Addr[1:0]; // Byte offset within the word
    wire [1:0] half_offset = Addr[1];   // Halfword offset within the word
	
    always @(*) begin
        if (MemRead) begin
            case (Funct3)
                3'b000: // LB - Load Byte (signed)
                    ReadData = $signed((RAM[Addr >> 2] >> (byte_offset * 8)) & 8'hFF);
                
                3'b100: // LBU - Load Byte Unsigned
                    ReadData = (RAM[Addr >> 2] >> (byte_offset * 8)) & 8'hFF;
                
                3'b001: // LH - Load Halfword (signed)
                    ReadData = $signed((RAM[Addr >> 2] >> (half_offset * 16)) & 16'hFFFF);
                
                3'b101: // LHU - Load Halfword Unsigned
                    ReadData = (RAM[Addr >> 2] >> (half_offset * 16)) & 16'hFFFF;

                3'b010: // LW - Load Word
                    ReadData = RAM[Addr >> 2];

                default: // Undefined
                    ReadData = 32'bx;
            endcase
        end
    end

    always @(posedge clock) begin
        if (MemWrite) begin
            case (Funct3)
                3'b000: // SB - Store Byte
                    RAM[Addr >> 2] <= (RAM[Addr >> 2] & ~(8'hFF << (byte_offset * 8))) |
                                      ((WriteData[7:0] & 8'hFF) << (byte_offset * 8));

                3'b001: // SH - Store Halfword
                    RAM[Addr >> 2] <= (RAM[Addr >> 2] & ~(16'hFFFF << (half_offset * 16))) |
                                      ((WriteData[15:0] & 16'hFFFF) << (half_offset * 16));

                3'b010: // SW - Store Word
                    RAM[Addr >> 2] <= WriteData;

                default: // Undefined
                    RAM[Addr >> 2] <= RAM[Addr >> 2]; // No operation
            endcase
        end
    end
endmodule