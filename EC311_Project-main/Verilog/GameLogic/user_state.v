`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/10/2023 04:48:37 PM
// Design Name: 
// Module Name: user_state
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

//UNTESTED
module user_state(
    input clk,
    input reset,
    input allowMove,
    input [255:0] entireBoard,
    input BTNC, BTNU, BTND, BTNR, BTNL,
    output reg [10:0] changePiece, //FOR BUILD BOARD bits 0-5->Address, 6-9->Content, 10->Change Boolean 
    output reg [13:0] moveData,                                                                                                 //TODO change to 12:0
    output reg [2:0] currentState //FOR BUILD BOARD checks if game is in start state 
    );
    
    //Things needed in allowMove checker: cursorLocation, selectionLocation, board from build board, encodings, playerTurn     //TODO
    //return allowMove
    
    //initialize the state and other reg stuff                                                                                  //TODO

    //Board State Variable Declarations
    reg [5:0] cursorLocation = 6'b100110;
    reg [5:0] selectionLocation;                                                                                                //TODO Initialize all these
    reg selectionCheck; //Checks if a selection has been made
    reg playerTurn;
    
    //Create package to send to other functions
    always @(posedge clk) begin
        moveData <= {playerTurn, selectionCheck, selectionLocation, cursorLocation};
    end
    
    //Generate a 3D version of the board
    //Purpose of this is to be able to index the 64 squares
    genvar r;
    wire [3:0] board[63:0];
    generate for(r=0; r<256; r=r+4) begin 
        assign board[(r/4)][3:0] = entireBoard[(r+3):r];
    end
    endgenerate
    
    //Create User State Machine
    localparam startGame = 3'b000;
    localparam selectPiece = 3'b001;
    localparam movePiece = 3'b010;
    localparam removePiece = 3'b011;
    localparam placePiece = 3'b100;
    
    //Start State Machine
    always@(posedge clk, posedge reset) begin
        if(reset) begin
            currentState <= startGame;       
            //castleState <= writeking;
            //change to whites turn
            playerTurn <= 1'b0;
            //move cursor to start
            cursorLocation <= 6'b100110;
            //empty select address
            
            //enable 0 and other things too. 
            selectionCheck <= 1'b0;
            changePiece <= 11'b00000000000;
        end else begin
        
            case(currentState)
            
                startGame: begin
                    currentState <= selectPiece;
                end
                
                selectPiece: begin
                    if(BTNC && (board[cursorLocation][2:0] != 1'b0) && (board[cursorLocation][3] == playerTurn)) begin //if location is empty and it's the right player's turn
                        currentState <= movePiece;
                        selectionCheck <= 1;
                        selectionLocation <= cursorLocation;
                    end
                end
                
                movePiece: begin
                    if(BTNC) begin
                        if(allowMove) begin
                            currentState <= placePiece;
                            selectionCheck <= 0;
                            changePiece[5:0] <= cursorLocation;
                            changePiece[9:6] <= board[selectionLocation][3:0];
                            changePiece[10] <= 1;
                        end else begin //double check to logic of if say they click their own piece
                        currentState <= selectPiece;
                        selectionCheck <= 0;
                        //should you put the cursor back where it was so that the piece snaps back? check the logic here
                        end
                    end
                end
                
                removePiece: begin
                    currentState <= selectPiece;
                    changePiece[10] <= 0;
                    playerTurn <= ~playerTurn;
                end
                
                placePiece: begin
                    currentState <= removePiece;
                    changePiece[5:0] <= selectionLocation;
                    changePiece[9:6] <= {1'b0, 3'b000};
                end
                
            endcase 
            
            
            
            
            //Check for Cursor Movements every CLK
            if(BTNL && cursorLocation[5:3] != 3'b000) begin                                   //have hold to midigate the hold time violation or check if cursor matches with VGA
                cursorLocation <= cursorLocation - 6'b00_1000;
            end else if(BTNR && cursorLocation[5:3] != 3'b111) begin                            
                cursorLocation <= cursorLocation + 6'b00_1000;
            end else if(BTND && cursorLocation[2:0] != 3'b111) begin
                cursorLocation <= cursorLocation + 6'b00_0001;
            end else if(BTNU && cursorLocation[2:0] != 3'b000) begin 
                cursorLocation <= cursorLocation - 6'b00_0001;
            end
        end    
  end 
endmodule

