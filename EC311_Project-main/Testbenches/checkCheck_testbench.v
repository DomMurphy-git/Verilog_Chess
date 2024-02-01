`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/13/2023 02:58:40 PM
// Design Name: 
// Module Name: checkCheck_testbench
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


module checkCheck_testbench(
    );
        
    reg clk;
    wire inCheck;
    reg [255:0] bigBoard;
    reg [5:0] currentPosition;
    
    checkCheck check(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .inCheck(inCheck));
    
 /* 0000R000 //black
    00000000
    00000000
    00000000
    00000000  
    00000000
    0000K000 //white
    00000000
    
    ||
    \/
    
    0000R000 //white
    00000000
    00000000
    00000000
    00000000   
    00000000
    0000K000 //white
    00000000 */
    
    initial begin 
        clk = 0;
        bigBoard = 0;
        bigBoard[131:128] = 4'b1101; //BLACK ROOK AT 32
        bigBoard[155:152] = 4'b0001; //WHITE KING AT 38
        currentPosition = 6'b100_110; //WHITE KING AT 38
    end

    always begin
        #20 clk = ~clk;
    end
    
    always begin
        #100 bigBoard[131:128] = 4'b0101; //CHANGE THE ROOK TO WHITE
    end
    
endmodule
