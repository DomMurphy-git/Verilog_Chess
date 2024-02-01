`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Leonardo Mattos Martins
// 
// Create Date: 12/12/2023 12:25:24 AM
// Design Name: 
// Module Name: checkDistance_tb
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


module checkDistance_tb(
    );
    
    reg [5:0] targetPosition;
    reg [5:0] currentPosition;
    reg [3:0] currentPiece;
    reg [3:0] targetPiece;
    
    wire allowDistance;
    
    checkDistance czech(.targetPosition(targetPosition), .currentPosition(currentPosition), .currentPiece(currentPiece), .targetPiece(targetPiece), .allowDistance(allowDistance));
    
    initial begin
    targetPosition = 0;
    currentPosition = 0;
    currentPiece = 0;
    targetPiece = 0;
    end
    
    always #1 targetPosition = (targetPosition == currentPosition) ? (targetPosition + 2) : (targetPosition + 1);
    
    always #63 currentPosition = currentPosition + 1;
    
    always #4032 currentPiece = (currentPiece == 6) ? 8 : currentPiece + 1;
     
    always #24192 targetPiece = targetPiece + 1;
    
    
    
    
    
    
endmodule
