`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Leonardo Mattos Martins
// 
// Create Date: 12/11/2023 11:21:06 PM
// Design Name: 
// Module Name: checkSquare
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


module checkSquare(
    input [5:0] desiredSquare,
    input [255:0] boardInput,
    output [3:0] desiredPiece
    );
    
    genvar ii;
    wire [3:0] board[63:0];
    
    generate 
        for(ii=0; ii < 256; ii = ii + 4) begin
            assign board [(ii/4)][3:0] = boardInput[(ii + 3): ii]; 
        end
    endgenerate
    
    assign desiredPiece = board[desiredSquare];
    
    
endmodule
