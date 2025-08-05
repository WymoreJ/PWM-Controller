`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Justin Wymore
// 
// Create Date: 08/03/2025 06:09:40 PM
// Design Name: 
// Module Name: SimplePWM
// Project Name: Pulse Width Modulation Project
// Target Devices: Zybo Z7-10
// Tool Versions: Vivado
// Description: A simple PWM design that will adjust the brightness of an LED on the Zybo
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SimplePWM #(parameter N_BIT = 8)(
    input iClk,
    input iReset,
    input [N_BIT-1:0] iDutyCycle,
    output oPWM
    );
    
    reg [N_BIT - 1 : 0] rQ, rNext;
    
    always @(posedge iClk, negedge iReset)
    begin
    	if(~iReset)
    		rQ <= 'b0;
    	else
    		rQ <= rNext;
    end
    
    always @(*)
    begin
    	rNext = rQ+1;
    end
    
    assign oPWM = (rQ < iDutyCycle);
    
    
endmodule
