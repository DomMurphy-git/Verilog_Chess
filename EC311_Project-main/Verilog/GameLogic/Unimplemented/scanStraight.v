`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/13/2023 04:07:12 AM
// Design Name: 
// Module Name: scanStraight
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

module scanStraight(
    input clk, 
    input [255:0] bigBoard,
    input [5:0] currentPosition,
    input [1:0] direction, 
    output reg [5:0] nearestPosition, //Location of the closest piece in that direction
    output reg [3:0] nearestPiece //Type of piece of the closest piece 
    );
    
    //DEFINE DIRECTIONS
    localparam UP = 2'b00;
    localparam LEFT = 2'b01;
    localparam RIGHT = 2'b10;
    localparam DOWN = 2'b11;
   
    //LOCAL VARIABLES
    integer i;
    reg found;
    
    //GENERATE 3-D Board
    genvar r;
    wire [3:0] board[63:0];
    generate for(r=0; r<256; r=r+4) begin 
        assign board[(r/4)][3:0] = bigBoard[(r+3):r];
    end
    endgenerate
    
    always @(posedge clk) begin
        case(direction)
        
            UP: begin    
                i = 1;
                found = 0;
                while (i <= currentPosition%8 && !found) begin
                    if(board[(currentPosition - (i*6'b000_001))][2:0] != 3'b000) begin
                        nearestPosition <= (currentPosition - (i*6'b000_001));
                        nearestPiece <= board[(currentPosition - (i*6'b000_001))][3:0];
                        found <= 1;
                    end else begin
                        nearestPiece <= 6'b000_000;
                    end                               
                    i = i + 1;
                end
            end
            
            DOWN: begin
                i = 1;
                found = 0;
                while (i <= (7-(currentPosition%8)) && !found) begin
                    if(board[(currentPosition + (i*6'b000_001))][2:0] != 3'b000) begin
                        nearestPosition <= (currentPosition + (i*6'b000_001));
                        nearestPiece <= board[(currentPosition + (i*6'b000_001))][3:0];
                        found <= 1;
                    end else begin
                        nearestPiece <= 6'b000_000;             
                    end
                    i = i + 1;
                end
            end
            
            RIGHT: begin
                i = 1;
                found = 0;
                while (i <= (7-(currentPosition/8)) && !found) begin
                    if(board[(currentPosition + (i*6'b001_000))][2:0] != 3'b000) begin
                        nearestPosition <= (currentPosition + (i*6'b001_000));
                        nearestPiece <= board[(currentPosition + (i*6'b001_000))][3:0];
                        found <= 1;
                    end else begin 
                        nearestPiece <= 6'b000_000;
                    end
                    i = i + 1;
                end
            end
            
            LEFT: begin
                i = 1;
                found = 0;
                while (i <= currentPosition/8 && !found) begin
                    if(board[(currentPosition - (i*6'b001_000))][2:0] != 3'b000) begin
                        nearestPosition <= (currentPosition - (i*6'b001_000));
                        nearestPiece <= board[(currentPosition - (i*6'b001_000))][3:0];
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
