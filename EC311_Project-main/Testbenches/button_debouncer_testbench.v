`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/09/2023 04:25:22 PM
// Design Name: 
// Module Name: button_debouncer_testbench
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


module button_debouncer_testbench(

    );
    
    reg clk, BTN, reset;
    wire clean;
    
    button_debouncer debounce(.clk(clk), .reset(reset), .BTN(BTN), .clean(clean));
    
    initial begin
        clk = 0;
        reset = 0;
        BTN = 0;
        forever begin
            #1 clk = ~clk;
        end
    end
    
    always begin
        #20 BTN = ~BTN;
    end
    
endmodule
