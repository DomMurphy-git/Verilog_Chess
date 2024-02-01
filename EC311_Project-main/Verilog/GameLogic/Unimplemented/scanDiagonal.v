`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/13/2023 04:05:47 AM
// Design Name: 
// Module Name: scanDiagonal
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


module scanDiagonal(
    input clk, 
    input [255:0] bigBoard,
    input [5:0] currentPosition,
    input [1:0] direction, 
    output reg [5:0] nearestPosition, //Location of the closest piece in that direction
    output reg [3:0] nearestPiece //Type of piece of the closest piece 
    );
    
    //DEFINE DIRECTIONS
    localparam UPLEFT = 2'b00;
    localparam UPRIGHT = 2'b01;
    localparam DOWNLEFT = 2'b10;
    localparam DOWNRIGHT = 2'b11;
   
    //LOCAL VARIABLES
    integer i;
    reg found;
    wire edgeDistance0 = (currentPosition/8 > currentPosition%8) ? (currentPosition%8) : (currentPosition/8); 
    wire edgeDistance1 = ((7-currentPosition/8) > currentPosition%8) ? (currentPosition%8) : (7-currentPosition/8); 
    wire edgeDistance2 = (currentPosition/8 > (7-currentPosition%8)) ? (7-currentPosition%8) : (currentPosition/8); 
    wire edgeDistance3 = ((7-currentPosition/8) > (7-currentPosition%8)) ? (7-currentPosition%8) : (7-currentPosition/8); 
    
    //GENERATE 3-D Board
    genvar r;
    wire [3:0] board[63:0];
    generate for(r=0; r<256; r=r+4) begin 
        assign board[(r/4)][3:0] = bigBoard[(r+3):r];
    end
    endgenerate
    
    always @(posedge clk) begin
        case(direction)
        
            UPLEFT: begin    
                i = 1;
                found = 0;
                while (i <= edgeDistance0 && !found) begin
                    if(board[(currentPosition - (i*6'b001_001))][2:0] != 3'b000) begin
                        nearestPosition <= (currentPosition - (i*6'b001_001));
                        nearestPiece <= board[(currentPosition - (i*6'b001_001))][3:0];
                        found <= 1;
                    end else begin
                        nearestPiece <= 6'b000_000;
                    end
                    i = i + 1;
                end
            end
            
            UPRIGHT: begin
                i = 1;
                found = 0;
                while (i <= edgeDistance1 && !found) begin
                    if(board[(currentPosition + (i*6'b000_111))][2:0] != 3'b000) begin
                        nearestPosition <= (currentPosition + (i*6'b000_111));
                        nearestPiece <= board[(currentPosition + (i*6'b000_111))][3:0];
                        found <= 1;
                    end else begin 
                        nearestPiece <= 6'b000_000;
                    end
                    i = i + 1;
                end
            end
            
            DOWNLEFT: begin
                i = 1;
                found = 0;
                while (i <= edgeDistance2 && !found) begin
                    if(board[(currentPosition - (i*6'b000_111))][2:0] != 3'b000) begin
                        nearestPosition <= (currentPosition - (i*6'b000_111));
                        nearestPiece <= board[(currentPosition - (i*6'b000_111))][3:0];
                        found <= 1;
                    end else begin 
                        nearestPiece <= 6'b000_000;
                    end
                    i = i + 1;
                end
            end
            
            DOWNRIGHT: begin
                i = 1;
                found = 0;
                while (i <= edgeDistance3 && !found) begin
                    if(board[(currentPosition + (i*6'b001_001))][2:0] != 3'b000) begin
                        nearestPosition <= (currentPosition + (i*6'b001_001));
                        nearestPiece <= board[(currentPosition + (i*6'b001_001))][3:0];
                        found <= 1;
                    end else begin 
                        nearestPiece <= 6'b000_000;
                    end
                    i = i + 1;
                end
            end
            
            endcase     
    end
    
 
endmodule
