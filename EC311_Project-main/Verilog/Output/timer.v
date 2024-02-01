`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rohan Alexander
// 
// Create Date: 12/13/2023 05:44:49 PM
// Design Name: 
// Module Name: timer
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


module timer(
    input [13:0] moveData,
    input clk, //1s
    input rst,
    output wire [9:0] countdownWhite,
    output wire [9:0] countdownBlack

    );
    
    reg [3:0] sec2Black = 4'b1001;
    reg [2:0] sec1Black = 3'b101;
    reg [2:0] minBlack = 3'b100;
    reg [3:0] sec2White = 4'b1001;
    reg [2:0] sec1White = 3'b101;
    reg [2:0] minWhite = 3'b100;
    
    
    always@(posedge clk, posedge rst) begin
        if(rst) begin
            sec2Black = 4'b1001;
            sec1Black = 3'b101;
            minBlack = 3'b100;
            sec2White = 4'b1001;
            sec1White = 3'b101;
            minWhite = 3'b100;
        end
        
        else begin
            if (moveData[13] == 0) begin
                if (sec2White>=0 && sec1White>=0 && minWhite>=0) begin
                    sec2Black = sec2Black;
                    sec1Black = sec1Black;
                    minBlack = minBlack;
                    sec2White = sec2White - 1;
                    sec1White = sec1White;
                    minWhite = minWhite;              
                end
                else if (sec2White == 0 && sec1White>=0 && minWhite>=0) begin
                    sec2Black = sec2Black;
                    sec1Black = sec1Black;
                    minBlack = minBlack;
                    sec2White = 4'b1001;
                    sec1White = sec1White - 1;
                    minWhite = minWhite;
                end
                else if (sec2White == 0 && sec1White == 0 && minWhite>=0) begin
                    sec2Black = sec2Black;
                    sec1Black = sec1Black;
                    minBlack = minBlack;
                    sec2White = 4'b1001;
                    sec1White = 3'b101;
                    minWhite = minWhite - 1;
                end
                else if (sec2White == 0 && sec1White == 0 && minWhite == 0) begin
                    sec2Black = 4'b0;
                    sec1Black = 3'b0;
                    minBlack = 3'b0;
                    sec2White = 4'b0;
                    sec1White = 3'b0;
                    minWhite = 3'b0;
                end
                else begin
                    sec2Black = 4'b1001;
                    sec1Black = 3'b101;
                    minBlack = 3'b100;
                    sec2White = 4'b1001;
                    sec1White = 3'b101;
                    minWhite = 3'b100;
                end
            end
            else if (moveData[13]) begin
                if (sec2Black >=0 && sec1Black>=0 && minBlack>0) begin
                    sec2Black = sec2Black - 1;
                    sec1Black = sec1Black;
                    minBlack = minBlack;
                    sec2White = sec2White;
                    sec1White = sec1White;
                    minWhite = minWhite;              
                end
                else if (sec2Black == 0 && sec1Black>=0 && minBlack>=0) begin
                    sec2Black = 4'b1001;
                    sec1Black = sec1Black - 1;
                    minBlack = minBlack;
                    sec2White = sec2White;
                    sec1White = sec1White;
                    minWhite = minWhite;
                end
                else if (sec2Black == 0 && sec1Black == 0 && minBlack>=0) begin
                    sec2Black = 4'b1001;
                    sec1Black = 3'b101;
                    minBlack = minBlack - 1;
                    sec2White = sec2White;
                    sec1White = sec1White;
                    minWhite = minWhite;
                end
                else if (sec2Black == 0 && sec1Black == 0 && minBlack == 0) begin
                    sec2Black = 4'b0;
                    sec1Black = 3'b0;
                    minBlack = 3'b0;
                    sec2White = 4'b0;
                    sec1White = 3'b0;
                    minWhite = 3'b0;
                end
                else begin 
                    sec2Black = 4'b1001;
                    sec1Black = 3'b101;
                    minBlack = 3'b100;
                    sec2White = 4'b1001;
                    sec1White = 3'b101;
                    minWhite = 3'b100;
                end
            end
        
        end
    end
    
    assign countdownWhite = {minWhite, sec1White, sec2White};
    assign countdownBlack = {minBlack, sec1Black, sec2Black};
    
    
endmodule
