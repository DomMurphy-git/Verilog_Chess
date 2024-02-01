`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rohan Alexander
// 
// Create Date: 12/11/2023 12:47:55 AM
// Design Name: 
// Module Name: rohans_clock_divider
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


module rohans_clock_divider(
    input in_clk, 
    output reg out_clk = 0     //25 MHz
    );
	
	reg[27:0] count = 28'd0;
	
	parameter DIVISOR = 28'd3;

	
	always @(posedge in_clk)
	begin
		count = count + 1;
		if (count >= DIVISOR-1) begin
		  count <= 0;
		  out_clk <= ~out_clk;
		end
	end
endmodule
