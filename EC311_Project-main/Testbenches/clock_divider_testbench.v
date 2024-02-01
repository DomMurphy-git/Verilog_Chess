`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/09/2023 09:37:53 PM
// Design Name: 
// Module Name: clock_divider_testbench
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


module clock_divider_testbench(

    );
    
    reg boardCLK, reset;
    wire vgaCLK, gameCLK;
    
    clock_divider divide(.boardCLK(boardCLK), .reset(reset), .vgaCLK(vgaCLK), .gameCLK(gameCLK));
    
    initial begin
        boardCLK = 0;
        reset = 0;
    end
    
    always begin
        #1 boardCLK = ~boardCLK;
    end
    
    always begin
        #200 reset = ~reset;
    end
  
endmodule
