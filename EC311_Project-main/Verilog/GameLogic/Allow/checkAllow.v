`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Leonardo Mattos Martins
// 
// Create Date: 12/11/2023 11:17:38 PM
// Design Name: 
// Module Name: checkAllow
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
/*
00 01 02 03 04 05 06 07
08 09 10 11 12 13 14 15 
16 17 18 19 20 21 22 23 
24 25 26 27 28 29 30 31
32 33 34 35 36 37 38 39 
40 41 42 43 44 45 46 47 
48 49 50 51 52 53 54 55
56 57 58 59 60 61 62 63

*/

module checkAllow(
    input  [13:0] moveData,
    input [255:0] boardInput,
    input clk,
    output wire allowMove
    );  
    
    wire [5:0] currentPosition = moveData[11:6];
    wire [5:0] targetPosition = moveData[5:0]; 
    
    wire [3:0] currentPiece;
    wire [3:0] targetPiece; 
    
    checkSquare c1(.desiredSquare(currentPosition), .boardInput(boardInput), .desiredPiece(currentPiece));
    checkSquare c2(.desiredSquare(targetPosition), .boardInput(boardInput), .desiredPiece(targetPiece));
    
    checkColour c3(.currentPiece(currentPiece), .targetPiece(targetPiece), .allowColour(allowColour));
    checkPath c4(.currentPiece(currentPiece), .targetPiece(targetPiece), .allowPath(allowPath));
    checkDistance c5(.clk(clk), .currentPosition(currentPosition), .targetPosition(targetPosition), .currentPiece(currentPiece), .targetPiece(targetPiece), .allowDistance(allowDistance));
    
    assign allowMove = (allowColour && allowPath && allowDistance);
    
endmodule
