`timescale 1ns / 1ps                                                                              
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/12/2023 10:29:15 PM
// Design Name: 
// Module Name: king_states
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

//UNFINISHED
module king_states(
    input clk,
    input reset,
    input [5:0] kingPositionW,
    input [5:0] kingPositionB,
    input [255:0] board,                                                         //IMPLEMENT THE OUTPUT INTO CODE AND CALL FUNCTION WHERE U NEED
    output reg [2:0] winState,
    output reg check  //either player has been checked       //IF THIS IS CASE, MAKE IT SO THAT allowMove is only one when the selected piece is a King. also implement in FSM that king can't move into check
    );
    
    //LOCAL VARIABLES
    wire inCheckWHITE;
    wire inCheckBLACK;
    wire [7:0] W;
    wire [7:0] B;
    
    wire [13:0] modDataW5 = {1'b0, 1'b0, (kingPositionW - 6'b000_111), kingPositionW};                                            
    wire [13:0] modDataW6 = {1'b0, 1'b0, (kingPositionW + 6'b000_001), kingPositionW};
    wire [13:0] modDataW7 = {1'b0, 1'b0, (kingPositionW + 6'b001_001), kingPositionW};
    wire [13:0] modDataW3 = {1'b0, 1'b0, (kingPositionW - 6'b001_000), kingPositionW};
    wire [13:0] modDataW4 = {1'b0, 1'b0, (kingPositionW + 6'b001_000), kingPositionW};
    wire [13:0] modDataW0 = {1'b0, 1'b0, (kingPositionW - 6'b001_001), kingPositionW};
    wire [13:0] modDataW1 = {1'b0, 1'b0, (kingPositionW - 6'b000_001), kingPositionW};
    wire [13:0] modDataW2 = {1'b0, 1'b0, (kingPositionW + 6'b000_111), kingPositionW};
    
    wire [13:0] modDataB5 = {1'b1, 1'b0, (kingPositionB - 6'b000_111), kingPositionB};
    wire [13:0] modDataB6 = {1'b1, 1'b0, (kingPositionB + 6'b000_001), kingPositionB};    
    wire [13:0] modDataB7 = {1'b1, 1'b0, (kingPositionB + 6'b001_001), kingPositionB};    
    wire [13:0] modDataB3 = {1'b1, 1'b0, (kingPositionB - 6'b001_000), kingPositionB};    
    wire [13:0] modDataB4 = {1'b1, 1'b0, (kingPositionB + 6'b001_000), kingPositionB};    
    wire [13:0] modDataB0 = {1'b1, 1'b0, (kingPositionB - 6'b001_001), kingPositionB};    
    wire [13:0] modDataB1 = {1'b1, 1'b0, (kingPositionB - 6'b000_001), kingPositionB};    
    wire [13:0] modDataB2 = {1'b1, 1'b0, (kingPositionB + 6'b000_111), kingPositionB};
    
    wire [7:0] AW;
    wire [7:0] AB;
    reg kingStateWHITE;
    reg kingStateBLACK;
    
    //STATE DECODINGS
    localparam SAFE = 2'b00;
    localparam CHECK = 2'b01;
    localparam CHECKMATE = 2'b10;
    localparam STALEMATE = 2'b11;
    localparam CONTINUE = 2'b00;
    localparam WHITEWIN = 2'b01;
    localparam BLACKWIN = 2'b10;
    localparam DRAW = 2'b11;
    
    //INITIALIZE LOCAL VARIABLES
    checkCheck checkW(.inCheck(inCheckWHITE), .currentPosition(kingPositionW), .bigBoard(board), .clk(clk)); //white's current position                               
    checkCheck checkW0(.inCheck(W[0]), .currentPosition(modDataW0[11:6]), .bigBoard(board), .clk(clk)); //white's top left
    checkAllow allowW0(.clk(clk), .moveData(modDataW0), .boardInput(board), .allowMove(AW[0]));                                                                 //FIX LEDS FOR checkALLOW so u can do this
    checkCheck checkW1(.inCheck(W[1]), .currentPosition(modDataW1[11:6]), .bigBoard(board), .clk(clk)); //white's top middle
    checkAllow allowW1(.clk(clk), .moveData(modDataW1), .boardInput(board), .allowMove(AW[1]));
    checkCheck checkW2(.inCheck(W[2]), .currentPosition(modDataW2[11:6]), .bigBoard(board), .clk(clk)); //white's top right
    checkAllow allowW2(.clk(clk), .moveData(modDataW2), .boardInput(board), .allowMove(AW[2]));
    checkCheck checkW3(.inCheck(W[3]), .currentPosition(modDataW3[11:6]), .bigBoard(board), .clk(clk)); //white's left
    checkAllow allowW3(.clk(clk), .moveData(modDataW3), .boardInput(board), .allowMove(AW[3]));
    checkCheck checkW4(.inCheck(W[4]), .currentPosition(modDataW4[11:6]), .bigBoard(board), .clk(clk)); //white's right
    checkAllow allowW4(.clk(clk), .moveData(modDataW4), .boardInput(board), .allowMove(AW[4]));
    checkCheck checkW5(.inCheck(W[5]), .currentPosition(modDataW5[11:6]), .bigBoard(board), .clk(clk)); //white's bottom left
    checkAllow allowW5(.clk(clk), .moveData(modDataW5), .boardInput(board), .allowMove(AW[5]));
    checkCheck checkW6(.inCheck(W[6]), .currentPosition(modDataW6[11:6]), .bigBoard(board), .clk(clk)); //white's bottom middle
    checkAllow allowW6(.clk(clk), .moveData(modDataW6), .boardInput(board), .allowMove(AW[6]));
    checkCheck checkW7(.inCheck(W[7]), .currentPosition(modDataW7[11:6]), .bigBoard(board), .clk(clk)); //white's bottom right
    checkAllow allowW7(.clk(clk), .moveData(modDataW7), .boardInput(board), .allowMove(AW[7]));
    checkCheck checkB(.inCheck(inCheckBLACK), .currentPosition(kingPositionB), .bigBoard(board), .clk(clk)); //black's current position
    checkCheck checkB0(.inCheck(B[0]), .currentPosition(modDataB0[11:6]), .bigBoard(board), .clk(clk)); //black's top left
    checkAllow allowB0(.clk(clk), .moveData(modDataB0), .boardInput(board), .allowMove(AB[0]));
    checkCheck checkB1(.inCheck(B[1]), .currentPosition(modDataB1[11:6]), .bigBoard(board), .clk(clk)); //black's top middle
    checkAllow allowB1(.clk(clk), .moveData(modDataB1), .boardInput(board), .allowMove(AB[1]));
    checkCheck checkB2(.inCheck(B[2]), .currentPosition(modDataB2[11:6]), .bigBoard(board), .clk(clk)); //black's top right
    checkAllow allowB2(.clk(clk), .moveData(modDataB2), .boardInput(board), .allowMove(AB[2]));
    checkCheck checkB3(.inCheck(B[3]), .currentPosition(modDataB3[11:6]), .bigBoard(board), .clk(clk)); //black's left
    checkAllow allowB3(.clk(clk), .moveData(modDataB3), .boardInput(board), .allowMove(AB[3]));
    checkCheck checkB4(.inCheck(B[4]), .currentPosition(modDataB4[11:6]), .bigBoard(board), .clk(clk)); //black's right
    checkAllow allowB4(.clk(clk), .moveData(modDataB4), .boardInput(board), .allowMove(AB[4]));
    checkCheck checkB5(.inCheck(B[5]), .currentPosition(modDataB5[11:6]), .bigBoard(board), .clk(clk)); //black's bottom left
    checkAllow allowB5(.clk(clk), .moveData(modDataB5), .boardInput(board), .allowMove(AB[5]));
    checkCheck checkB6(.inCheck(B[6]), .currentPosition(modDataB6[11:6]), .bigBoard(board), .clk(clk)); //black's bottom middle
    checkAllow allowB6(.clk(clk), .moveData(modDataB6), .boardInput(board), .allowMove(AB[6]));
    checkCheck checkB7(.inCheck(B[7]), .currentPosition(modDataB7[11:6]), .bigBoard(board), .clk(clk)); //black's bottom right
    checkAllow allowB7(.clk(clk), .moveData(modDataB7), .boardInput(board), .allowMove(AB[7]));
 
    //STATE MACHINES
    always@(posedge clk, posedge reset) begin
    
        if(reset) begin
        
        end else begin
        
        
        
            //State Machine for WHITE KING
            case(kingStateWHITE)
                
                SAFE: begin
                    if(inCheckWHITE) begin
                        kingStateWHITE <= CHECK;
                        check <= 1;
                    end else if(                   
                   (W[0] || !AW[0])&&
                   (W[1] || !AW[1])&&                               //Does allowable move cover corners?
                   (W[2] || !AW[2])&&
                   (W[3] || !AW[3])&&
                   (W[4] || !AW[4])&&
                   (W[5] || !AW[5])&&
                   (W[6] || !AW[6])&&
                   (W[7] || !AW[7])&&
                   (1/*no moves available by other pieces i.e. no non-pawns left and scan pawns*/)) begin      //FINISH STALEMATE condition
                        kingStateWHITE <= STALEMATE;
                        winState <= DRAW;
                    end
                    winState <= CONTINUE;
                    check <= 0;
                end
                
                CHECK: begin
                   if(!inCheckWHITE) begin
                       kingStateWHITE <= SAFE;
                       check <= 0;
                   end else if(
                   (W[0] || !AW[0])&&
                   (W[1] || !AW[1])&&
                   (W[2] || !AW[2])&&
                   (W[3] || !AW[3])&&
                   (W[4] || !AW[4])&&
                   (W[5] || !AW[5])&&
                   (W[6] || !AW[6])&&
                   (W[7] || !AW[7])&&
                   (1/*attacking piece not in check*/)
                   ) begin                                                                  //FINISH
                       kingStateWHITE <= CHECKMATE;
                       winState <= BLACKWIN;
                   end
                end
                
                CHECKMATE: begin
                end
                
                STALEMATE: begin
                end
                
            endcase
            
            
            
            
            
            //State Machine for BLACK KING
            case(kingStateBLACK)
                
                SAFE: begin
                    if(inCheckBLACK) begin
                        kingStateBLACK <= CHECK;
                        check <= 1;
                    end else if(                   
                   (B[0] || !AB[0])&&
                   (B[1] || !AB[1])&&
                   (B[2] || !AB[2])&&
                   (B[3] || !AB[3])&&
                   (B[4] || !AB[4])&&
                   (B[5] || !AB[5])&&
                   (B[6] || !AB[6])&&
                   (B[7] || !AB[7])&&
                   (1/*no moves available by other pieces i.e. no non-pawns left and scan pawns*/)) begin           //FINISH STALEMATE CONDITION
                        kingStateBLACK <= STALEMATE;
                        winState <= DRAW;
                    end
                    winState <= CONTINUE;
                    check <= 0;
                end
                
                CHECK: begin
                   if(!inCheckBLACK) begin
                       kingStateBLACK <= SAFE;
                       check <= 0;
                   end else if(                   
                   (B[0] || !AB[0])&&
                   (B[1] || !AB[1])&&
                   (B[2] || !AB[2])&&
                   (B[3] || !AB[3])&&
                   (B[4] || !AB[4])&&
                   (B[5] || !AB[5])&&
                   (B[6] || !AB[6])&&
                   (B[7] || !AB[7])&&
                   (1/*attacking piece not in check*/)) begin                                              //FINISH
                       kingStateBLACK <= CHECKMATE;
                       winState <= WHITEWIN;
                   end
                   
                end
                
                CHECKMATE: begin
                                                                                                            //DISPLAY AND RESET GAME
                end
                
                STALEMATE: begin
                                                                                                            //DISPLAY AND RESET GAME
                end
                
            endcase
            
            
            
        
        end
    end
endmodule
