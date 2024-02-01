`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/13/2023 04:03:09 AM
// Design Name: 
// Module Name: checkCheck
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


module checkCheck(
    input clk, 
    input [255:0] bigBoard,
    input [5:0] currentPosition,
    output reg inCheck
    //how do you output the number of pieces and their locations/types of all the pieces chacking the king. Maybe a large array where each bit represents check from one position on the board. then you just send that array. 
    //check for enpassant 
    );
    
    //Define the pieces and colors
    localparam WHITE = 1'b0;
    localparam BLACK = 1'b1;
    localparam EMPTY = 3'b000;
    localparam KING = 3'b001;
    localparam QUEEN = 3'b010;
    localparam BISHOP = 3'b011;
    localparam KNIGHT = 3'b100;
    localparam ROOK = 3'b101;
    localparam PAWN = 3'b110;
    
    //GENERATE 3-D Board
    genvar r;
    wire [3:0] board[63:0];
    generate for(r=0; r<256; r=r+4) begin 
        assign board[(r/4)][3:0] = bigBoard[(r+3):r];
    end
    endgenerate
    
    //SET LOCAL PARAMETERS
    wire [3:0] nearestPiece1;   wire [5:0] nearestPosition1;
    wire [3:0] nearestPiece2;   wire [5:0] nearestPosition2;
    wire [3:0] nearestPiece3;   wire [5:0] nearestPosition3;
    wire [3:0] nearestPiece4;   wire [5:0] nearestPosition4;
    wire [3:0] nearestPiece5;   wire [5:0] nearestPosition5;
    wire [3:0] nearestPiece6;   wire [5:0] nearestPosition6;
    wire [3:0] nearestPiece7;   wire [5:0] nearestPosition7;
    wire [3:0] nearestPiece8;   wire [5:0] nearestPosition8;
    wire [3:0] nearestPiece9;   wire [5:0] nearestPosition9;
    wire [3:0] nearestPiece10;  wire [5:0] nearestPosition10;
    wire [3:0] nearestPiece11;  wire [5:0] nearestPosition11;
    wire [3:0] nearestPiece12;  wire [5:0] nearestPosition12;
    wire [3:0] nearestPiece13;  wire [5:0] nearestPosition13;
    wire [3:0] nearestPiece14;  wire [5:0] nearestPosition14;
    wire [3:0] nearestPiece15;  wire [5:0] nearestPosition15;
    wire [3:0] nearestPiece16;  wire [5:0] nearestPosition16;

    wire [3:0] currentPiece;
    checkSquare current(.desiredSquare(currentPosition), .boardInput(bigBoard), .desiredPiece(currentPiece));
    wire oppositeColor = ~currentPiece[3];
    
    
    //SCAN FOR THE NEAREST PIECE IN EVERY DIRECTION
    //DIAGONALS
    scanDiagonal scan1(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(2'b00), .nearestPiece(nearestPiece1), .nearestPosition(nearestPosition1));
    scanDiagonal scan2(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(2'b01), .nearestPiece(nearestPiece2), .nearestPosition(nearestPosition2));
    scanDiagonal scan3(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(2'b10), .nearestPiece(nearestPiece3), .nearestPosition(nearestPosition3));
    scanDiagonal scan4(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(2'b11), .nearestPiece(nearestPiece4), .nearestPosition(nearestPosition4));
    //STRAIGHTS
    scanStraight scan5(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(2'b00), .nearestPiece(nearestPiece5), .nearestPosition(nearestPosition5));
    scanStraight scan6(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(2'b01), .nearestPiece(nearestPiece6), .nearestPosition(nearestPosition6));
    scanStraight scan7(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(2'b10), .nearestPiece(nearestPiece7), .nearestPosition(nearestPosition7));
    scanStraight scan8(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(2'b11), .nearestPiece(nearestPiece8), .nearestPosition(nearestPosition8));
    //Ls
    scanSpots scan9(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(3'b000), .nearestPiece(nearestPiece9), .nearestPosition(nearestPosition9));
    scanSpots scan10(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(3'b001), .nearestPiece(nearestPiece10), .nearestPosition(nearestPosition10));
    scanSpots scan11(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(3'b010), .nearestPiece(nearestPiece11), .nearestPosition(nearestPosition11));
    scanSpots scan12(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(3'b011), .nearestPiece(nearestPiece12), .nearestPosition(nearestPosition12));
    scanSpots scan13(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(3'b100), .nearestPiece(nearestPiece13), .nearestPosition(nearestPosition13));
    scanSpots scan14(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(3'b101), .nearestPiece(nearestPiece14), .nearestPosition(nearestPosition14));
    scanSpots scan15(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(3'b110), .nearestPiece(nearestPiece15), .nearestPosition(nearestPosition15));
    scanSpots scan16(.clk(clk), .bigBoard(bigBoard), .currentPosition(currentPosition), .direction(3'b111), .nearestPiece(nearestPiece16), .nearestPosition(nearestPosition16));
    
    always @(posedge clk) begin
        if(    
                                                                    
/*D1*/      (nearestPiece1 == {oppositeColor, BISHOP}) //BISHOP CHECK
         || (nearestPiece1 == {oppositeColor, QUEEN})  //QUEEN CHECK 
         || (oppositeColor == 1 && nearestPiece1 == {oppositeColor, PAWN} && (nearestPosition1 - currentPosition) == -9)  //PAWN CHECK 
         || (nearestPiece1 == {oppositeColor, KING} && (nearestPosition1 - currentPosition) == -9) //KING CHECK
     
/*D2*/   || (nearestPiece2 == {oppositeColor, BISHOP})  //BISHOP CHECK 
         || (nearestPiece2 == {oppositeColor, QUEEN}) //QUEEN CHECK  
         || (oppositeColor == 1 && nearestPiece2 == {oppositeColor, PAWN} && (nearestPosition2 - currentPosition) == 7) //PAWN CHECK
         || (nearestPiece2 == {oppositeColor, KING} && (nearestPosition2 - currentPosition) == 7) //KING CHECK        
                                                                    
/*D3*/   || (nearestPiece3 == {oppositeColor, BISHOP}) //BISHOP CHECK
         || (nearestPiece3 == {oppositeColor, QUEEN})  //QUEEN CHECK 
         || (oppositeColor == 0 && nearestPiece3 == {oppositeColor, PAWN} && (nearestPosition3 - currentPosition) == -7)  //PAWN CHECK 
         || (nearestPiece3 == {oppositeColor, KING} && (nearestPosition3 - currentPosition) == -7) //KING CHECK
     
/*D4*/   || (nearestPiece4 == {oppositeColor, BISHOP})  //BISHOP CHECK 
         || (nearestPiece4 == {oppositeColor, QUEEN}) //QUEEN CHECK  
         || (oppositeColor == 0 && nearestPiece4 == {oppositeColor, PAWN} && (nearestPosition4 - currentPosition) == 9) //PAWN CHECK
         || (nearestPiece4 == {oppositeColor, KING} && (nearestPosition4 - currentPosition) == 9) //KING CHECK             
                                                                    
/*S1*/   || (nearestPiece5 == {oppositeColor, ROOK}) //ROOK CHECK
         || (nearestPiece5 == {oppositeColor, QUEEN})  //QUEEN CHECK 
         || (nearestPiece5 == {oppositeColor, KING} && (nearestPosition5 - currentPosition) == -1) //KING CHECK
     
/*S2*/   || (nearestPiece6 == {oppositeColor, ROOK})  //ROOK CHECK 
         || (nearestPiece6 == {oppositeColor, QUEEN}) //QUEEN CHECK  
         || (nearestPiece6 == {oppositeColor, KING} && (nearestPosition6 - currentPosition) == -8) //KING CHECK        
                                                                    
/*S3*/   || (nearestPiece7 == {oppositeColor, ROOK}) //ROOK CHECK
         || (nearestPiece7 == {oppositeColor, QUEEN})  //QUEEN CHECK 
         || (nearestPiece7 == {oppositeColor, KING} && (nearestPosition7 - currentPosition) == 8) //KING CHECK
     
/*S4*/   || (nearestPiece8 == {oppositeColor, ROOK})  //ROOK CHECK 
         || (nearestPiece8 == {oppositeColor, QUEEN}) //QUEEN CHECK  
         || (nearestPiece8 == {oppositeColor, KING} && (nearestPosition8 - currentPosition) == 1) //KING CHECK           
           
/*Ls*/   || (nearestPiece9 == {oppositeColor, KNIGHT}) //KNIGHT CHECKS
         || (nearestPiece10 == {oppositeColor, KNIGHT})
         || (nearestPiece11 == {oppositeColor, KNIGHT})
         || (nearestPiece12 == {oppositeColor, KNIGHT})
         || (nearestPiece13 == {oppositeColor, KNIGHT})
         || (nearestPiece14 == {oppositeColor, KNIGHT})
         || (nearestPiece15 == {oppositeColor, KNIGHT})
         || (nearestPiece16 == {oppositeColor, KNIGHT})  
       
        )begin
            inCheck <= 1;
        end else begin
            inCheck <= 0;
        end
    end

                                 
endmodule
