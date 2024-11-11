`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Devin Kot-Thompson
// 
// Create Date: 10/14/2024 04:30:16 PM
// Design Name: 
// Module Name: RegisterFile
// Project Name: RISC-V single cycle
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


module RegisterFile(RR1, RR2, WR, WD, WEn, clock, reset, RD1, RD2);
    input [4:0] RR1;
    input [4:0] RR2;
    input [4:0] WR;
    input [31:0] WD;
    input WEn;
    input clock;
    input reset;
    output [31:0] RD1;
    output [31:0] RD2;
    
    reg[31:0]RF[31:0]; //Register File 32 registers of 32 bit size
    
    integer i;
    //only for testing, Register File will initially be empty
    initial begin
    $readmemh("C:/Users/devin/registerfile.hex", RF);
        
    $display("Loaded instructions:");
    for (integer i = 0; i < 10; i = i + 1) begin
    $display("RF[%0d] = %h", i, RF[i]);
    end
    end

    //Register Read inputs select the Register from the Register File
    assign RD1 = RF[RR1];                                   
    assign RD2 = RF[RR2];
    
    /*on positive edge of clock if Write is enabled the 
    register file will load the Write Data into the Write Register*/
    always begin 
    @(posedge clock or posedge reset)
        if(reset)
        begin
        for(i=0; i<32; i = i + 1)
        RF[i] <= 32'h00000000;
        end
		else begin
		if(WEn && (WR != 0)) RF[WR] <= WD;
		end
    end
    
    
    
endmodule
