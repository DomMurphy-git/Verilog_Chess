`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Leonardo Mattos Martins
// 
// Create Date: 12/11/2023 11:29:54 PM
// Design Name: 
// Module Name: checkColour
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


module checkColour(
    input [3:0] currentPiece,
    input [3:0] targetPiece,
    output wire allowColour
    );
    
    //Dont move into your own color
    assign allowColour = (currentPiece[3] ^ targetPiece[3]) | (!targetPiece[2:0]);
    
endmodule
