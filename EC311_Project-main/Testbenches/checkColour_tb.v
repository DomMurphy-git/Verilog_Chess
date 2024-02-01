`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Leonardo Mattos Martins
// 
// Create Date: 12/12/2023 12:24:26 AM
// Design Name: 
// Module Name: checkColour_tb
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


module checkColour_tb(
    );
    
    reg [3:0] currentPiece;
    reg [3:0] targetPiece;
    wire allowColour;
    
    checkColour czech(.allowColour(allowColour), .currentPiece(currentPiece), .targetPiece(targetPiece));
    
    initial begin
        currentPiece = 0;
        targetPiece = 0;
    end
    
    always #2 currentPiece = currentPiece + 1;
    always #32 targetPiece = targetPiece + 1;
    
endmodule
