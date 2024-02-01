`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rohan Alexander
// 
// Create Date: 12/10/2023 01:29:43 PM
// Design Name: 
// Module Name: vga_paint
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

module vga_paint(
    input wire [255:0] board,
    input wire clk, //100MHz
    input wire reset,
    input wire [13:0] moveData,
    output wire [3:0] redVGA, 
    output wire [3:0] blueVGA, 
    output wire [3:0] greenVGA, 
    output wire horizontalVGA, 
    output wire verticalVGA
    );
    
    //Define different colors based on how they interact with the VGA
    reg [11:0] currentColor = 0; //set this equal to the desired color constant
    
    localparam BLACKTILECOLOR = 12'b001101101000;
    localparam WHITETILECOLOR = 12'b111010101001;
    localparam CURSORTILECOLOR = 12'b0000111100011;
    localparam SELECTEDTILECOLOR = 12'b111101010110;
    localparam BLACKPIECECOLOR = 12'b000100010011;
    localparam WHITEPIECECOLOR = 12'b111011101111;
    localparam TEXTCOLOUR = 12'b001110001010;
    
    //Storing piece data and design
    localparam WHITE = 1'b0;
    localparam BLACK = 1'b1;
    localparam EMPTY = 3'b000;
    localparam KING = 3'b001;
    localparam QUEEN = 3'b010;
    localparam BISHOP = 3'b011;
    localparam KNIGHT = 3'b100;
    localparam ROOK = 3'b101;
    localparam PAWN = 3'b110;
    
    localparam [120:0] pawn = 
        121'b00000000000_00000000000_10000000000_11000000000_11011000000_11111100000_11011000000_11000000000_10000000000_00000000000_00000000000;
    
    localparam [120:0] rook = 
        121'b00000000000_00000000000_11000011100_11111111000_11111110000_11111110000_11111110000_11111111000_11000011100_00000000000_00000000000;
    
    localparam [120:0] bishop = 
        121'b00000000000_00000000000_10000000000_11000000000_11100111000_11111111100_11100110000_11000000000_10000000000_00000000000_00000000000;
    
    localparam [120:0] knight = 
        121'b00000000000_11000000000_11111111000_11111111100_11110011110_11100011110_11000111100_10000111010_00001110010_00000100000_00000000000;
    
    localparam [120:0] king = 
        121'b00000000000_00000000000_10000000000_11000010000_11110011010_11111111111_11110011010_11000010000_10000000000_00000000000_00000000000;
    
    localparam [120:0] queen = 
        121'b00000000000_00000000000_10000000000_11000001000_11110111100_11111111110_11110111100_11000001000_10000000000_00000000000_00000000000;
        
    localparam [99:0] LetterW = 
        100'b0000000000_0111111110_0111111110_0011110000_0001111100_0001111100_0011110000_0111111110_0111111110_0000000000;
    localparam [99:0] LetterH = 
        100'b0000000000_0000000000_0111111110_0111111110_0000110000_0000110000_0111111110_0111111110_0000000000_0000000000;
    localparam [99:0] LetterI = 
        100'b0000000000_0000000000_0110000110_0110000110_0111111110_0111111110_0110000110_0110000110_0000000000_0000000000;
    localparam [99:0] LetterT = 
        100'b0000000000_0000000000_0000000110_0000000110_0111111110_0111111110_0000000110_0000000110_0000000000_0000000000;
    localparam [99:0] LetterE = 
        100'b0000000000_0000000000_0110110110_0110110110_0110000110_0110110110_0111111110_0111111110_0000000000_0000000000;
    localparam [99:0] LetterU = 
        100'b0000000000_0000000000_0011111110_0111111110_0110000000_0110000000_0111111110_0011111110_0000000000_0000000000;
    localparam [99:0] LetterR = 
        100'b0000000000_0000000000_0111011100_0111111110_0001100110_0001100110_0111111110_0111111110_0000000000_0000000000;
    localparam [99:0] LetterN = 
        100'b0000000000_0111111110_0111111110_0011100000_0001110000_0000111000_0000011100_0111111110_0111111110_0000000000;
    localparam [99:0] LetterB = 
        100'b0000000000_0000000000_0111111100_0111111110_0110110110_0110110110_0111111110_0011111110_0000000000_0000000000;
    localparam [99:0] LetterL = 
        100'b0000000000_0000000000_0110000000_0110000000_0110000000_0110000000_0111111110_0111111110_0000000000_0000000000;
    localparam [99:0] LetterA = 
        100'b0000000000_0000000000_0111111000_0111111100_0001100110_0001100110_0111111100_0111111000_0000000000_0000000000;
    localparam [99:0] LetterC = 
        100'b0000000000_0000000000_0011001100_0111001110_0110000110_0110000110_0111111110_0011111100_0000000000_0000000000;
    localparam [99:0] LetterK = 
        100'b0000000000_0000000000_0110000110_0111001110_0011111100_0001111000_0111111110_0111111110_0000000000_0000000000;
    localparam [99:0] LetterM = 
        100'b0000000000_0111111110_0111111110_0000111100_0001111100_0001111100_0000111100_0111111110_0111111110_0000000000;
    localparam [99:0] LetterS = 
        100'b0000000000_0000000000_0011100110_0111110110_0110110110_0110110110_0110111110_0110011100_0000000000_0000000000;
    localparam [99:0] colon = 
        100'b0000000000_0000000000_0000000000_0000000000_0011001100_0011001100_0000000000_0000000000_0000000000_0000000000;
    
    
    //Create the 25 MHz clock                                                                   //CHANGED
    wire PIXELS;
    rohans_clock_divider test(.in_clk(clk), .out_clk(PIXELS));
    
    
    //Generate the vga cycle
    wire [9:0] x;
    wire [9:0] y;
    wire de;
    vga_generator activate(.clk(clk), .reset(reset), .horizontalVGA(horizontalVGA), .verticalVGA(verticalVGA), .pixelX(x), .pixelY(y), .de(de)); 
    
    //ROHANS CODE                                                                                   //TODO look through organize and comment
    wire [3:0] PIECES[63:0];
    genvar i;
    
    generate for (i=0; i<64; i=i+1) begin
        assign PIECES[i] = board[i*4+3:i*4];
    end
    endgenerate
    
    
    //Defining board position on screen, and defining squares of the board
    reg [2:0] let;
    reg [2:0] num;
    reg [5:0] squareX;
    reg [5:0] squareY;
    
    always @ (x) begin
        if (x<=150) begin
            let <= 0;
            squareX = x-100; end
        else if (x<=200) begin
            let <= 1;
            squareX = x-150; end
        else if (x<=250) begin
            let <= 2;
            squareX = x-200; end
        else if (x<=300) begin 
            let <= 3; 
            squareX = x-250; end
        else if (x<=350) begin
            let <= 4;
            squareX = x-300; end
        else if (x<=400) begin
            let <= 5;
            squareX = x-350; end
        else if (x<=450) begin
            let <= 6;
            squareX = x-400; end
        else begin
            let <= 7;
            squareX = x-450; end
    end
    
    always @ (y) begin
        if (y<=90) begin
            num <= 0;
            squareY = y - 40; end
        else if (y<=140) begin
            num <= 1;
            squareY = y - 90; end
        else if (y<=190) begin
            num <= 2;
            squareY = y - 140; end
        else if (y<=240) begin
            num <= 3;
            squareY = y - 190; end
        else if (y<=290) begin
            num <= 4;
            squareY = y - 240; end
        else if (y<=340) begin
            num <= 5;
            squareY = y - 290; end
        else if (y<=390) begin
            num <= 6;
            squareY = y - 340; end
        else begin
            num <= 7;
            squareY = y - 390; end
    end
    
    reg [3:0] ypiece;
    reg [3:0] xpiece;
    
    
    always @ (squareX) begin
        if (squareX <=5) xpiece <= 0;
        else if (squareX <=9) xpiece <= 1;
        else if (squareX <=13) xpiece <= 2;
        else if (squareX <=17) xpiece <= 3;
        else if (squareX <=21) xpiece <= 4;
        else if (squareX <=25) xpiece <= 5;
        else if (squareX <=29) xpiece <= 6;
        else if (squareX <=33) xpiece <= 7;
        else if (squareX <=37) xpiece <= 8;
        else if (squareX <=41) xpiece <= 9;
        else if (squareX <=45) xpiece <= 10;
    end
    
    always @ (squareY) begin
        if (squareY <=5) ypiece <= 0;
        else if (squareY <=9) ypiece <= 1;
        else if (squareY <=13) ypiece <= 2;
        else if (squareY <=17) ypiece <= 3;
        else if (squareY <=21) ypiece <= 4;
        else if (squareY <=25) ypiece <= 5;
        else if (squareY <=29) ypiece <= 6;
        else if (squareY <=33) ypiece <= 7;
        else if (squareY <=37) ypiece <= 8;
        else if (squareY <=41) ypiece <= 9;
        else if (squareY <=45) ypiece <= 10;
    end
    
    
    //Converting each square to an 11x11 array to draw designs
    reg [10:0] square[10:0];
    integer j;
    
    
    wire boardBoolean;
    wire dark;
    wire textDisplay;
    assign boardBoolean = (x>=100 && x<500) && (y>=40 && y<440);
    assign dark = let[0] ^ num[0];
    
    
    reg [3:0] SquareLetX;
    reg [3:0] LetterX;
    reg [3:0] LetterY;
    reg [9:0] TextSquare[9:0];
    integer t;
    assign textDisplay = (x>=250 && x<350) && (y>=19 && y<31);
    
    
    
    always @ (x) begin
        if (x<=260 && x>=250) begin
            SquareLetX = 0;
            LetterX = x-250; end
        else if (x<=270 && x>260) begin
            SquareLetX = 1;
            LetterX = x-260; end
        else if (x<=280 && x>270) begin
            SquareLetX = 2;
            LetterX = x-270; end
        else if (x<=290 && x>280) begin
            SquareLetX = 3;
            LetterX = x-280; end
        else if (x<=300 && x>290) begin
            SquareLetX = 4;
            LetterX = x-290; end
        else if (x<=310 && x>300) begin
            SquareLetX = 5;
            LetterX = x-300; end
        else if (x<=320 && x>310) begin
            SquareLetX = 6;
            LetterX = x-310; end
        else if (x<=330 && x>320) begin
            SquareLetX = 7;
            LetterX = x-320; end
        else if (x<=340 && x>330) begin
            SquareLetX = 8;
            LetterX = x-330; end
        else begin
            SquareLetX = 9;
            LetterX = x-340; end
    end
    
    always @ (y) begin
        if (y<=21)
            LetterY = 0; 
        else if (y<=22) 
            LetterY = 1;
        else if (y<=23) 
            LetterY = 2;
        else if (y<=24) 
            LetterY = 3;
        else if (y<=25) 
            LetterY = 4;
        else if (y<=26) 
            LetterY = 5;
        else if (y<=27) 
            LetterY = 6;
        else if (y<=28) 
            LetterY = 7;
        else if (y<=29) 
            LetterY = 8;
        else
            LetterY = 9;
    end
    
    
    reg [2:0] NumberX;
    reg [3:0] SquareNumberX;
    wire NumDisplay;
    assign NumDisplay = ((x>=100 && x<150) && (y>=19 && y<31)) ^ ((x>=450 && x<500) && (y>=19 && y<31));
    
    always @ (x) begin
        if (x<=115 && x>=105) begin NumberX = 0; SquareNumberX = x-105; end
        else if (x<=125 && x>=115) begin NumberX = 1; SquareNumberX = x-115; end
        else if (x<=135 && x>=125) begin NumberX = 2; SquareNumberX = x-125; end
        else if (x<=145 && x>=135) begin NumberX = 3; SquareNumberX = x-135; end
        else if (x<=465 && x>=455) begin NumberX = 4; SquareNumberX = x-455; end
        else if (x<=475 && x>=465) begin NumberX = 5; SquareNumberX = x-465; end
        else if (x<=485 && x>=475) begin NumberX = 6; SquareNumberX = x-475; end
        else if (x<=495 && x>=485) begin NumberX = 7; SquareNumberX = x-485; end
    end
    
    wire CLK1;
    timer_clock_divider seconds(
    .CLK100M(clk),
    .CLK1(CLK1)
    );
    
    
    wire [9:0] countdownWhite;
    wire [9:0] countdownBlack;
    
    timer CountdownGenerator(
    .moveData(moveData),
    .clk(CLK1), //1s
    .rst(reset),
    .countdownWhite(countdownWhite), .countdownBlack(countdownBlack)
    );
    
    wire [99:0] minW;
    wire [99:0] sec1W;
    wire [99:0] sec2W;
    wire [99:0] minB;
    wire [99:0] sec1B;
    wire [99:0] sec2B;
    
    NumberDisplayDecoder timeGen(
    .clk(CLK1),
    .countdownW(countdownWhite),
    .countdownB(countdownBlack),
    .minW(minW),
    .sec1W(sec1W),
    .sec2W(sec2W),
    .minB(minB),
    .sec1B(sec1B),
    .sec2B(sec2B)
    );
    
    
    
    
    always @ (posedge PIXELS) begin                                                                                     //CHANGED
        if (de == 0)
            currentColor = 12'b0;
        else if (de==1) begin
            if (boardBoolean) begin
                case (PIECES[{let, num}][2:0])
                    EMPTY: begin   
                        if (moveData[5:0] == {let,num})
                            currentColor = CURSORTILECOLOR;
                        else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                            currentColor = SELECTEDTILECOLOR;
                        else begin                         
                            if (dark)
                                currentColor = BLACKTILECOLOR;
                            else
                                currentColor = WHITETILECOLOR;
                        end
                    end
                    
                    
                    PAWN : begin

                        for (j=0; j<11; j=j+1) begin
                            square[j] = pawn[j*11 +: 11];
                            end
                            
                        if (square[xpiece][ypiece]) begin
                            if (PIECES[{let, num}][3] == 0)
                                currentColor = WHITEPIECECOLOR;
                            else
                                currentColor = BLACKPIECECOLOR;
                            end
                        else begin
                            if (moveData[5:0] == {let,num})
                                currentColor = CURSORTILECOLOR;
                            else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                                currentColor = SELECTEDTILECOLOR;
                            else begin                         
                                if (dark)
                                    currentColor = BLACKTILECOLOR;
                                else
                                    currentColor = WHITETILECOLOR;
                                end
                            end                    
                    end
                    
                    
                    ROOK : begin

                        for (j=0; j<11; j=j+1) begin
                            square[j] = rook[j*11 +: 11];
                            end
                            
                        if (square[xpiece][ypiece]) begin
                            if (PIECES[{let, num}][3] == 0)
                                currentColor = WHITEPIECECOLOR;
                            else
                                currentColor = BLACKPIECECOLOR;
                            end
                        else begin
                            if (moveData[5:0] == {let,num})
                                currentColor = CURSORTILECOLOR;
                            else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                                currentColor = SELECTEDTILECOLOR;
                            else begin                         
                                if (dark)
                                    currentColor = BLACKTILECOLOR;
                                else
                                    currentColor = WHITETILECOLOR;
                                end
                            end                    
                    end
                    
                    
                   KNIGHT : begin

                        for (j=0; j<11; j=j+1) begin
                            square[j] = knight[j*11 +: 11];
                            end
                            
                        if (square[xpiece][ypiece]) begin
                            if (PIECES[{let, num}][3] == 0)
                                currentColor = WHITEPIECECOLOR;
                            else
                                currentColor = BLACKPIECECOLOR;
                            end
                        else begin
                            if (moveData[5:0] == {let,num})
                                currentColor = CURSORTILECOLOR;
                            else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                                currentColor = SELECTEDTILECOLOR;
                            else begin                         
                                if (dark)
                                    currentColor = BLACKTILECOLOR;
                                else
                                    currentColor = WHITETILECOLOR;
                                end
                            end                    
                    end
                    
                    BISHOP : begin

                        for (j=0; j<11; j=j+1) begin
                            square[j] = bishop[j*11 +: 11];
                            end
                            
                        if (square[xpiece][ypiece]) begin
                            if (PIECES[{let, num}][3] == 0)
                                currentColor = WHITEPIECECOLOR;
                            else
                                currentColor = BLACKPIECECOLOR;
                            end
                        else begin
                            if (moveData[5:0] == {let,num})
                                currentColor = CURSORTILECOLOR;
                            else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                                currentColor = SELECTEDTILECOLOR;
                            else begin                         
                                if (dark)
                                    currentColor = BLACKTILECOLOR;
                                else
                                    currentColor = WHITETILECOLOR;
                                end
                            end                    
                    end
                    
                    
                    QUEEN : begin

                        for (j=0; j<11; j=j+1) begin
                            square[j] = queen[j*11 +: 11];
                            end
                            
                        if (square[xpiece][ypiece]) begin
                            if (PIECES[{let, num}][3] == 0)
                                currentColor = WHITEPIECECOLOR;
                            else
                                currentColor = BLACKPIECECOLOR;
                            end
                        else begin
                            if (moveData[5:0] == {let,num})
                                currentColor = CURSORTILECOLOR;
                            else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                                currentColor = SELECTEDTILECOLOR;
                            else begin                         
                                if (dark)
                                    currentColor = BLACKTILECOLOR;
                                else
                                    currentColor = WHITETILECOLOR;
                                end
                            end                    
                    end
                    
                    
                    KING : begin

                        for (j=0; j<11; j=j+1) begin
                            square[j] = king[j*11 +: 11];
                            end
                            
                        if (square[xpiece][ypiece]) begin
                            if (PIECES[{let, num}][3] == 0)
                                currentColor = WHITEPIECECOLOR;
                            else
                                currentColor = BLACKPIECECOLOR;
                            end
                        else begin
                            if (moveData[5:0] == {let,num})
                                currentColor = CURSORTILECOLOR;
                            else if ((moveData[11:6] == {let, num}) && (moveData[12] == 1))
                                currentColor = SELECTEDTILECOLOR;
                            else begin                         
                                if (dark)
                                    currentColor = BLACKTILECOLOR;
                                else
                                    currentColor = WHITETILECOLOR;
                                end
                            end                    
                    end
                
                
                
                endcase
                end
        else if (textDisplay) begin
            case (SquareLetX)
                0: begin
                    if (moveData[13]) begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterB[t*10 +: 10];
                            end
                        end
                    else if (moveData[13] == 0) begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterW[t*10 +: 10];
                            end
                        end
                        
                        
                        if (TextSquare[LetterX][LetterY])
                            currentColor = TEXTCOLOUR;
                        else
                            currentColor = 12'b0;
                    
                end
                1: begin
                    if (moveData[13]) begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterL[t*10 +: 10];
                            end
                        end
                    else if (moveData[13] == 0) begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterH[t*10 +: 10];
                            end
                        end
                        
                        
                        if (TextSquare[LetterX][LetterY])
                            currentColor = TEXTCOLOUR;
                        else
                            currentColor = 12'b0;
                end
                2: begin
                    if (moveData[13]) begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterA[t*10 +: 10];
                            end
                        end
                    else if (moveData[13] == 0) begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterI[t*10 +: 10];
                            end
                        end
                        
                        
                        if (TextSquare[LetterX][LetterY])
                            currentColor = TEXTCOLOUR;
                        else
                            currentColor = 12'b0;
                end
                3: begin
                    if (moveData[13]) begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterC[t*10 +: 10];
                            end
                        end
                    else if (moveData[13] == 0) begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterT[t*10 +: 10];
                            end
                        end
                        
                        
                        if (TextSquare[LetterX][LetterY])
                            currentColor = TEXTCOLOUR;
                        else
                            currentColor = 12'b0;
                end
                4: begin
                    if (moveData[13]) begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterK[t*10 +: 10];
                            end
                        end
                    else if (moveData[13] == 0) begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterE[t*10 +: 10];
                            end
                        end
                        
                        
                        if (TextSquare[LetterX][LetterY])
                            currentColor = TEXTCOLOUR;
                        else
                            currentColor = 12'b0;
                end
                5: begin
                    currentColor = 12'b0;
                end
                6: begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterT[t*10 +: 10];
                            end
                        
                        
                        if (TextSquare[LetterX][LetterY])
                            currentColor = TEXTCOLOUR;
                        else
                            currentColor = 12'b0;
                end
                7: begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterU[t*10 +: 10];
                            end
                        
                        
                        if (TextSquare[LetterX][LetterY])
                            currentColor = TEXTCOLOUR;
                        else
                            currentColor = 12'b0;
                
                end
                8: begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterR[t*10 +: 10];
                            end
                        
                        
                        if (TextSquare[LetterX][LetterY])
                            currentColor = TEXTCOLOUR;
                        else
                            currentColor = 12'b0;
                
                end
                9: begin
                        for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = LetterN[t*10 +: 10];
                            end
                        
                        
                        if (TextSquare[LetterX][LetterY])
                            currentColor = TEXTCOLOUR;
                        else
                            currentColor = 12'b0;
                
                
                end
            endcase
            
        
        
        end
        
        else if (NumDisplay) begin
            case (NumberX)
            0: begin
                for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = minW[t*10 +: 10];
                            end
                        if (TextSquare[SquareNumberX][LetterY])
                            currentColor = WHITEPIECECOLOR;
                        else
                            currentColor = BLACKPIECECOLOR;
                end
            1: begin
                for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = colon[t*10 +: 10];
                            end
                        if (TextSquare[SquareNumberX][LetterY])
                            currentColor = WHITEPIECECOLOR;
                        else
                            currentColor = BLACKPIECECOLOR;
            
                end
            2: begin
                for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = sec1W[t*10 +: 10];
                            end
                        if (TextSquare[SquareNumberX][LetterY])
                            currentColor = WHITEPIECECOLOR;
                        else
                            currentColor = BLACKPIECECOLOR;
                end
            3: begin
                for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = sec2W[t*10 +: 10];
                            end
                        if (TextSquare[SquareNumberX][LetterY])
                            currentColor = WHITEPIECECOLOR;
                        else
                            currentColor = BLACKPIECECOLOR;
                end
            4: begin
                for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = minB[t*10 +: 10];
                            end
                        if (TextSquare[SquareNumberX][LetterY])
                            currentColor = WHITEPIECECOLOR;
                        else
                            currentColor = BLACKPIECECOLOR;
                end
            5: begin
                for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = colon[t*10 +: 10];
                            end
                        if (TextSquare[SquareNumberX][LetterY])
                            currentColor = WHITEPIECECOLOR;
                        else
                            currentColor = BLACKPIECECOLOR;
            
                end
            6: begin
                for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = sec1B[t*10 +: 10];
                            end
                        if (TextSquare[SquareNumberX][LetterY])
                            currentColor = WHITEPIECECOLOR;
                        else
                            currentColor = BLACKPIECECOLOR;
                end
            7: begin
                for (t=0; t<10; t=t+1) begin
                            TextSquare[t] = sec2B[t*10 +: 10];
                            end
                        if (TextSquare[SquareNumberX][LetterY])
                            currentColor = WHITEPIECECOLOR;
                        else
                            currentColor = BLACKPIECECOLOR;
            
                end
            endcase
        end
        else if (~boardBoolean && ~textDisplay && ~NumDisplay)
            currentColor = 12'b0;
        end
    end                                                                                         //END OF ROHANS CODE
    
    //Assign color outputs
    assign redVGA = currentColor[11:8];
    assign greenVGA = currentColor[7:4];
    assign blueVGA = currentColor[3:0];
         
endmodule 
