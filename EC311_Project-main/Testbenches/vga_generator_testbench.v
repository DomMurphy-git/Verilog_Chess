`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/10/2023 12:58:04 AM
// Design Name: 
// Module Name: vga_generator_testbench
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

module vga_generator_testbench(
);
    
    reg clk, reset;
    wire horizontalVGA, verticalVGA;
    wire [9:0] pixelX;
    wire [9:0] pixelY;
    
    vga_generator activate(.clk(clk), .reset(reset), .horizontalVGA(horizontalVGA), .verticalVGA(verticalVGA), .pixelX(pixelX), .pixelY(pixelY));
    
    initial begin 
        clk = 0;
        reset = 0;
    end

    always begin
        #1 clk = ~clk;
    end
    
endmodule
