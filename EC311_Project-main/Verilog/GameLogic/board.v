`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy 
// 
// Create Date: 12/10/2023 12:43:45 PM
// Design Name: 
// Module Name: board
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


module board(
    input reset, 
    input clk, //48.8 kHz
    input BTNC, BTNU, BTND, BTNR, BTNL,
    output wire [255:0] board,
    output wire [13:0] moveData,
    output wire led                                         
    );
    
    //Define local parameters
    wire allowMove;
    wire [10:0] changePiece;
    wire [2:0] currentState; 
    assign led = moveData[13]; //output which player's turn it is to the LED                        
    
    //Run the State Machine
    user_state play(.clk(clk), .reset(reset), .allowMove(allowMove), .entireBoard(board), 
    .BTNC(BTNC), .BTNU(BTNU), .BTND(BTND), .BTNR(BTNR), .BTNL(BTNL), 
    .changePiece(changePiece), .moveData(moveData), .currentState(currentState));
    
    //Check if move is legal
    checkAllow check(.clk(clk), .moveData(moveData), .boardInput(board), .allowMove(allowMove));                           //IN PROGRESS                                         
    
    //Generate the board/Move the pieces
    build_board build(.clk(clk), .boardPass(board), .changePiece(changePiece), .currentState(currentState));    //TESTING try no boardPass
    
endmodule

