`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rohan Alexander
// 
// Create Date: 12/13/2023 06:29:13 PM
// Design Name: 
// Module Name: NumberDisplayDecoder
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


module NumberDisplayDecoder(
    input clk,
    input wire [9:0] countdownW,
    input wire [9:0] countdownB,
    output wire [99:0] minW,
    output wire [99:0] sec1W,
    output wire [99:0] sec2W,
    output wire [99:0] minB,
    output wire [99:0] sec1B,
    output wire [99:0] sec2B
    );
    
    
    localparam [99:0] number0 = 
        100'b0000000000_0000000000_0011111100_0111111110_0110000110_0110000110_0111111110_0011111100_0000000000_0000000000;
    localparam [99:0] number1 = 
        100'b0000000000_0000000000_0000000000_0110000000_0111111110_0111111110_0110001100_0000000000_0000000000_0000000000;
    localparam [99:0] number2 = 
        100'b0000000000_0000000000_0110001100_0110011110_0110010010_0110110010_0111100110_0111000100_0000000000_0000000000;
        localparam [99:0] number3 = 
        100'b0000000000_0000000000_0011111100_0111111110_0110110110_0110110110_0110000110_0110000110_0000000000_0000000000;
    localparam [99:0] number4 = 
        100'b0000000000_0000000000_0111111110_0111111110_0000110000_0000110000_0000111110_0000111110_0000000000_0000000000;
    localparam [99:0] number5 = 
        100'b0000000000_0000000000_0011100110_0111110110_0110110110_0110110110_0110110110_0110111100_0000000000_0000000000;
    localparam [99:0] number6 = 
        100'b0000000000_0000000000_0011100110_0111110110_0110110110_0110110110_0111111110_0011111100_0000000000_0000000000;
    localparam [99:0] number7 = 
        100'b0000000000_0000000000_0000001100_0000111110_0001110110_0011100110_0111001110_0110001100_0000000000_0000000000;
    localparam [99:0] number8 = 
        100'b0000000000_0000000000_0011111100_0111111110_0110110110_0110110110_0111111110_0011111100_0000000000_0000000000;
    localparam [99:0] number9 = 
        100'b0000000000_0000000000_0011111100_0111111110_0110110110_0110110110_0110111110_0010011100_0000000000_0000000000;
    
    
    wire [11:0] bcdW;
    wire [11:0] bcdB;
    reg [99:0] digit1W;
    reg [99:0] digit2W;
    reg [99:0] digit3W;
    reg [99:0] digit1B;
    reg [99:0] digit2B;
    reg [99:0] digit3B;
    
    
    always @ (posedge clk) begin
        case (countdownW[9:7])
            0: begin digit1W = number0; end
            1: begin digit1W = number1; end
            2: begin digit1W = number2; end
            3: begin digit1W = number3; end
            4: begin digit1W = number4; end
            5: begin digit1W = number5; end
        endcase
        case (countdownW[6:4])
            0: begin digit2W = number0; end
            1: begin digit2W = number1; end
            2: begin digit2W = number2; end
            3: begin digit2W = number3; end
            4: begin digit2W = number4; end
            5: begin digit2W = number5; end
        endcase
        case (countdownW[3:0])
            0: begin digit3W = number0; end
            1: begin digit3W = number1; end
            2: begin digit3W = number2; end
            3: begin digit3W = number3; end
            4: begin digit3W = number4; end
            5: begin digit3W = number5; end
            6: begin digit3W = number6; end
            7: begin digit3W = number7; end
            8: begin digit3W = number8; end
            9: begin digit3W = number9; end
        endcase
        case (countdownB[9:7])
            0: begin digit1B = number0; end
            1: begin digit1B = number1; end
            2: begin digit1B = number2; end
            3: begin digit1B = number3; end
            4: begin digit1B = number4; end
            5: begin digit1B = number5; end
        endcase
        case (countdownB[6:4])
            0: begin digit2B = number0; end
            1: begin digit2B = number1; end
            2: begin digit2B = number2; end
            3: begin digit2B = number3; end
            4: begin digit2B = number4; end
            5: begin digit2B = number5; end
        endcase
        case (countdownB[3:0])
            0: begin digit3B = number0; end
            1: begin digit3B = number1; end
            2: begin digit3B = number2; end
            3: begin digit3B = number3; end
            4: begin digit3B = number4; end
            5: begin digit3B = number5; end
            6: begin digit3B = number6; end
            7: begin digit3B = number7; end
            8: begin digit3B = number8; end
            9: begin digit3B = number9; end
        endcase
    end
        
    assign minW = digit1W;
    assign sec1W = digit2W;
    assign sec2W = digit3W;
    
    assign minB = digit1B;
    assign sec1B = digit2B;
    assign sec2B = digit3B;
   
endmodule
