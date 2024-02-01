`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Murphy
// 
// Create Date: 12/09/2023 04:24:50 PM
// Design Name: 
// Module Name: button_debouncer
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


module button_debouncer(
    input clk, //48.8 kHz clock
    input reset, 
    input BTN, 
    output reg clean 
    );
    
    //Figure out proper clocking for this device and adjust counterMAXs accordingly            //TODO
    //Comment using flowChart
    
    localparam counterMAX = 2000; //set to 5 for the testbench--set to 2000 for FPGA
    localparam counterMAX2 = 2000; //set tp 5 for the testbench--set to 2000 for FPGA            //TODO mark in README
    
    reg[13:0] counter; 
    reg[3:0] currentState = 0;                                                                  //TODO change this name and all other repeat names that arent the same thing
    
    always @(posedge clk, posedge reset)
    begin 
    
        if(reset) begin
            clean <= 0;
            currentState <= 4'b0000;
            
        end else begin
            case(currentState)
            
                4'b0000: begin
                    if(BTN) begin
                        currentState <= 4'b0001;
                    end
                    counter <= 14'b00000000000000;
                end
                
                4'b0001: begin
                    if(!BTN) begin
                        currentState <= 4'b0000;
                    end else if(counter == counterMAX) begin
                        clean <= 1; 
                        currentState <= 4'b0010;               
                    end
                    counter <= counter + 14'b00000000000001;
                end
                
                4'b0010: begin
                    currentState <= 4'b0011;
                    clean <= 0;
                    counter <= 14'b00000000000000;
                end
                
                4'b0011: begin
                    if(!BTN) begin
                        currentState <= 4'b0100;
                    end
                    counter <= 14'b00000000000000;
                end
                
                4'b0100: begin
                    if(BTN) begin
                        currentState <= 4'b0011;
                    end else if(counter == counterMAX2) begin
                        currentState <= 4'b0000;
                    end
                    counter <= counter + 14'b00000000000001;
                end
               
            endcase             
        end      
    end  
endmodule
