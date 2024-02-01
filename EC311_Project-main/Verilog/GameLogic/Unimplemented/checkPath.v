`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/11/2023 11:34:36 PM
// Design Name: 
// Module Name: checkPath
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


module checkPath(
    input [3:0] currentPiece,
    input [3:0] targetPiece,
    output wire allowPath
    );
    
    assign allowPath = 1;
    
endmodule

/*Leos unfinished code
module checkPath(
    input [5:0] currentPosition,
    input [5:0] targetPosition,
    input [255:0] boardInput,
    output allowPath
    );
    
        
    localparam  WHITE_EMPTY  = 4'b0000, 
                WHITE_KING   = 4'b0001,
                WHITE_QUEEN  = 4'b0010, 
                WHITE_BISHOP = 4'b0011,
                WHITE_KNIGHT = 4'b0100,
                WHITE_ROOK   = 4'b0101,
                WHITE_PAWN   = 4'b0110,
                
                BLACK_EMPTY  = 4'b1000, 
                BLACK_KING   = 4'b1001,
                BLACK_QUEEN  = 4'b1010, 
                BLACK_BISHOP = 4'b1011,
                BLACK_KNIGHT = 4'b1100,
                BLACK_ROOK   = 4'b1101,
                BLACK_PAWN   = 4'b1110;
    
    wire [3:0] currentPiece;
    wire [3:0] targetPiece;
    
    checkSquare c1(.boardInput(boardInput), .desiredSquare(currentPosition), .desiredPiece(currentPiece));
    checkSquare c2(.boardInput(boardInput), .desiredSquare(targetPosition), .desiredPiece(targetPiece));
    
    wire signed [6:0] distance = targetPosition - currentPosition;    
    
endmodule
*/
