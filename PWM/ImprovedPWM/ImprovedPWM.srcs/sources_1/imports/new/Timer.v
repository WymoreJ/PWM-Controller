`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/05/2025 06:24:18 PM
// Design Name: 
// Module Name: Timer
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


module Timer #(parameter TIMER_BITS = 255)(
	input iClk,
	input iReset,
	input enable,
	input [TIMER_BITS - 1:0] TIMER_LENGTH,
	//output [BITS - 1:0] Q,
	output done
    );
        
    reg [TIMER_BITS - 1:0] rQ, rNext;
    
    always @(posedge iClk, negedge iReset)
    begin
    	if (~iReset)
    		rQ <= 1'b0;
    	else if (enable)
    		rQ <= rNext;
    	else
    	rQ <= rQ;
    end
    
    assign done = rQ == TIMER_LENGTH;
    
    always @(*)
    	rNext = done? 'b0: rQ + 1;
    	
endmodule
