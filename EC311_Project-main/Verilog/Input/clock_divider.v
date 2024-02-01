`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/09/2023 09:37:18 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input reset,
    input boardCLK, //100 MHz
    output vgaCLK, //25 MHz
    output gameCLK //48.8 kHz
    );
    
    //Comment using the table drawn on ipad                                         //TODO
    reg [30:0] theCLKs = 0;
    
    always@(posedge boardCLK, posedge reset) begin
    
        if(reset) begin
            theCLKs <= 4'b0000;
        end else begin
            theCLKs <= theCLKs + 4'b0001;
        end    
         
    end
    
    assign gameCLK = theCLKs[10];
    assign vgaCLK = theCLKs[1]; 
    
endmodule
