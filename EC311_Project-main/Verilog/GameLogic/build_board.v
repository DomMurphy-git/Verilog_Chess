`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/10/2023 10:12:14 PM
// Design Name: 
// Module Name: build_board
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


module build_board(
        input clk,
        input [2:0] currentState,
        input [10:0] changePiece,
        output wire [255:0] boardPass                               //TESTING change to reg board
    );
    
    reg [255:0] board;
    
    //Define the pieces and colors
    //EX: board[8'b00000100:8'b00000111] (addresses 4-7) = 4b'1101 means there is a black rook on A2
    localparam WHITE = 1'b0;
    localparam BLACK = 1'b1;
    localparam EMPTY = 3'b000;
    localparam KING = 3'b001;
    localparam QUEEN = 3'b010;
    localparam BISHOP = 3'b011;
    localparam KNIGHT = 3'b100;
    localparam ROOK = 3'b101;
    localparam PAWN = 3'b110;
    
    always@(posedge clk) begin
        
        //If start of game, set up the board
        if(currentState == 3'b000) begin
        
            //ROW TOP
            board[3:0] <= {BLACK, ROOK};
            board[35:32] <= {BLACK, KNIGHT};
            board[67:64] <= {BLACK, BISHOP};
            board[99:96] <= {BLACK, QUEEN};
            board[131:128] <= {BLACK, KING};
            board[163:160] <= {BLACK, BISHOP};
            board[195:192] <= {BLACK, KNIGHT};
            board[227:224] <= {BLACK, ROOK};

            //ROW 1
            board[7:4] <= {BLACK, PAWN};
            board[39:36] <= {BLACK, PAWN};
            board[71:68] <= {BLACK, PAWN};
            board[103:100] <= {BLACK, PAWN};
            board[135:132] <= {BLACK, PAWN};
            board[167:164] <= {BLACK, PAWN};
            board[199:196] <= {BLACK, PAWN};
            board[231:228] <= {BLACK, PAWN};
            
            //ROW 2
            board[11:8] <= {WHITE, EMPTY};
            board[43:40] <= {WHITE, EMPTY};
            board[75:72] <= {WHITE, EMPTY};
            board[107:104] <= {WHITE, EMPTY};
            board[139:136] <= {WHITE, EMPTY};
            board[171:168] <= {WHITE, EMPTY};
            board[203:200] <= {WHITE, EMPTY};
            board[235:232] <= {WHITE, EMPTY};
            
            //ROW 3
            board[15:12] <= {WHITE, EMPTY};
            board[47:44] <= {WHITE, EMPTY};
            board[79:76] <= {WHITE, EMPTY};
            board[111:108] <= {WHITE, EMPTY};
            board[143:140] <= {WHITE, EMPTY};
            board[175:172] <= {WHITE, EMPTY};
            board[207:204] <= {WHITE, EMPTY};
            board[239:236] <= {WHITE, EMPTY};
           
            //ROW 4
            board[19:16] <= {WHITE, EMPTY};
            board[51:48] <= {WHITE, EMPTY};
            board[83:80] <= {WHITE, EMPTY};
            board[115:112] <= {WHITE, EMPTY};
            board[147:144] <= {WHITE, EMPTY};
            board[179:176] <= {WHITE, EMPTY};
            board[211:208] <= {WHITE, EMPTY};
            board[243:240] <= {WHITE, EMPTY};
            
            //ROW 5
            board[23:20] <= {WHITE, EMPTY};
            board[55:52] <= {WHITE, EMPTY};
            board[87:84] <= {WHITE, EMPTY};
            board[119:116] <= {WHITE, EMPTY};
            board[151:148] <= {WHITE, EMPTY};
            board[183:180] <= {WHITE, EMPTY};
            board[215:212] <= {WHITE, EMPTY};
            board[247:244] <= {WHITE, EMPTY};

            //ROW 6
            board[27:24] <= {WHITE, PAWN};
            board[59:56] <= {WHITE, PAWN};
            board[91:88] <= {WHITE, PAWN};
            board[123:120] <= {WHITE, PAWN};
            board[155:152] <= {WHITE, PAWN};
            board[187:184] <= {WHITE, PAWN};
            board[219:216] <= {WHITE, PAWN};
            board[251:248] <= {WHITE, PAWN};
            
            //ROW BOTTOM
            board[31:28] <= {WHITE, ROOK};
            board[63:60] <= {WHITE, KNIGHT};
            board[95:92] <= {WHITE, BISHOP};
            board[127:124] <= {WHITE, QUEEN};
            board[159:156] <= {WHITE, KING};
            board[191:188] <= {WHITE, BISHOP};
            board[223:220] <= {WHITE, KNIGHT};
            board[255:252] <= {WHITE, ROOK};
        end
        
        
        //If Board Change the Change Board
        if(changePiece[10]) begin
            board[4*changePiece[5:0]+:4] <= changePiece[9:6];                     
        end
    end
    
    assign boardPass = board;                                                           //TESTING
    
endmodule
