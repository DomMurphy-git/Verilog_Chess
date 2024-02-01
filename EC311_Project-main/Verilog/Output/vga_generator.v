`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rohan Alexander
// 
// Create Date: 12/10/2023 12:54:32 AM
// Design Name: 
// Module Name: vga_generator
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

//INTERPRETATION OF PROFESSOR'S EXAMPLE CODE
module vga_generator(
    input clk,
    input reset, 
    output horizontalVGA,
    output verticalVGA, 
    output reg [9:0] pixelX = 0,
    output reg [9:0] pixelY = 0,
    output wire de
    );
    
    localparam STARTSYNCHORIZONTAL = 640 + 16; //Sync from 16-112
    localparam ENDSYNCHORIZONTAL = 640 + 112;
    localparam STARTSYNCVERTICAL = 490; //Sync from 490-492
    localparam ENDSYNCVERTICAL = 492;
    localparam ENDPIXELSHORIZONTAL = 640; //Pixels are drawn from 160-800 (640 width)
    localparam ENDPIXELSVERTICAL = 480; //Pixels are drawn from 0-480 (480 height)
    localparam ENDLINE = 799; //complete line (pixels)
    localparam ENDSCREEN = 524; //complete screen (lines)
    
    //Keep within active pixels
    assign de = ((pixelX <= ENDPIXELSHORIZONTAL) && (pixelY <= ENDPIXELSVERTICAL));
    
    //Generate active low sync signals
    //Keep within sync area
    assign horizontalVGA = ~((pixelX >= STARTSYNCHORIZONTAL) & (pixelX < ENDSYNCHORIZONTAL));
    assign verticalVGA = ~((pixelY >= STARTSYNCVERTICAL) & (pixelY < ENDSYNCVERTICAL));
    
    wire PIXELS;
    rohans_clock_divider divider25(.in_clk(clk), .out_clk(PIXELS));                                                           //CHANGED
    
    //Increment the columns and rows
    always@(posedge PIXELS) begin                                                                                   //CHANGED
        if(reset) begin
            pixelX <= 0;
            pixelY <= 0;
        end
        if(pixelX == ENDLINE) begin //end of line
            pixelX <= 0;
            pixelY <= pixelY + 1;
        end else begin 
            pixelX <= pixelX + 1;
        end
        if(pixelY == ENDSCREEN) begin //end of screen
            pixelY <= 0;
        end
    end
        
endmodule

