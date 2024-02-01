`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2023 06:04:33 PM
// Design Name: 
// Module Name: king_states_testbench
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


module king_states_testbench(
    );
    
    reg clk;
    reg reset;
    reg [5:0] kingPositionW;
    reg [5:0] kingPositionB;
    reg [255:0] bigBoard;
    wire check;
    wire [2:0] winState;
    
    king_states_testbench state(.clk(clk), .board(bigBoard), .kingPositionW(kingPositionW), .kingPositionB(kingPositionB), .winState(winState), .check(check));
    
 /* K000R000 //black black
    00000000
    00000000
    00000000
    00000000  
    00000000
    0000K000 //white
    00000000
    
    ||
    \/
    
    K000R000 //black white
    00000000
    00000000
    00000000
    00000000   
    00000000
    0000K000 //white
    00000000 */
    
    initial begin 
        clk = 0;
        reset = 0;
        bigBoard = 0;
        bigBoard[131:128] = 4'b1101; //BLACK ROOK AT 32
        bigBoard[159:156] = 4'b0001; //WHITE KING AT 39
        bigBoard[3:0] = 4'b1001; //BLACK KING AT 0
        kingPositionW = 6'b100_111; //WHITE KING AT 39
        kingPositionB = 6'b000_000; //BLACK KING AT 0
    end

    always begin
        #20 clk = ~clk;
    end
    
    always begin
        #100 bigBoard[131:128] = 4'b0101; //CHANGE THE ROOK TO WHITE
    end
endmodule
