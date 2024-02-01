`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/09/2023 09:25:32 PM
// Design Name: 
// Module Name: top
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


module top(
    input boardCLK, 
    output [3:0] redVGA, 
    output [3:0] greenVGA, 
    output [3:0] blueVGA,
    input BTNC, BTNU, BTND, BTNR, BTNL,
    input resetSwitch,
    output horizontalVGA, 
    output verticalVGA,
    output led //off when white's turn, on when black's turn
    );
   
    //Reset
    wire reset;
    assign reset = resetSwitch;
    
    //Clock Management
    wire vgaCLK, gameCLK;
    clock_divider divide(.boardCLK(boardCLK), .vgaCLK(vgaCLK), .gameCLK(gameCLK), .reset(reset));

    //Button Management
    wire cleanBTNC, cleanBTNU, cleanBTND, cleanBTNR, cleanBTNL;
    button_debouncer debounceUp(.clk(gameCLK), .reset(reset), .BTN(BTNU), .clean(cleanBTNU));
    button_debouncer debounceDown(.clk(gameCLK), .reset(reset), .BTN(BTND), .clean(cleanBTND));
    button_debouncer debounceRight(.clk(gameCLK), .reset(reset), .BTN(BTNR), .clean(cleanBTNR));
    button_debouncer debounceLeft(.clk(gameCLK), .reset(reset), .BTN(BTNL), .clean(cleanBTNL));
    button_debouncer debounceCenter(.clk(gameCLK), .reset(reset), .BTN(BTNC), .clean(cleanBTNC));
    
    //Game Logic
    wire [255:0] board;
    wire [13:0] moveData;
    
    board create(                                                                                           //rename to ChessLogic so you can have another one called Checkers logic which you call givena switch
    .reset(reset), 
    .clk(gameCLK),
    .BTNC(cleanBTNC), .BTNU(cleanBTNU), .BTND(cleanBTND), .BTNR(cleanBTNR), .BTNL(cleanBTNL),
    .board(board), .moveData(moveData), .led(led)                                                           //CHANGED
    );
    
    //Display on the VGA
    vga_paint paint(
    .board(board), 
    .moveData(moveData),
    .clk(boardCLK),                                                     //changed vgaCLK
    .reset(reset), 
    .greenVGA(greenVGA), .blueVGA(blueVGA), .redVGA(redVGA), .horizontalVGA(horizontalVGA), .verticalVGA(verticalVGA)
    );
   
endmodule

