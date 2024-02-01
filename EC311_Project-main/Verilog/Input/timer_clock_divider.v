`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rohan Alexander
// 
// Create Date: 12/13/2023 05:41:58 PM
// Design Name: 
// Module Name: timer_clock_divider
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


module timer_clock_divider(
    input CLK100M,
    output reg CLK1 = 0
    );
    
    reg[27:0] counter = 28'd0;
	
	parameter DIVISOR = 28'd50000000;

	
	always @(posedge CLK100M)
	begin
		counter = counter + 1;
		if (counter >= DIVISOR-1) begin
		  counter <= 0;
		  CLK1 <= ~CLK1;
		end
	end
    
endmodule
