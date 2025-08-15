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


module ImprovedPWM #(parameter N_BIT = 8, TIMER_SIZE = 15)(
    input iClk,
    input iReset,
    input [N_BIT:0] iDutyCycle,
    input [TIMER_SIZE - 1 : 0] TIMER_LENGTH,
    output oPWM
    );
    
    wire tick;
    
    reg [N_BIT - 1: 0] rQ, rNext;
    reg dReg, dNext;
        
    always @(posedge iClk, negedge iReset)
    begin
    	if(~iReset) 
    	begin
    		rQ <= 'b0;
    		dReg <= 1'b0; 
    	end
    	else if (tick)
    	begin 
    		rQ <= rNext;
    		dReg <= dNext; 
    	end
    	else 
    	begin
    		rQ <= rQ;
    		dReg <= dReg; 
    	end
    end
    
    always @(*)
    begin
    	rNext = rQ+1;
    	dNext = (rQ < iDutyCycle);
    end
    
    assign oPWM = dReg;
    
    
    Timer #(.TIMER_BITS(TIMER_SIZE)) timer1(
    .iClk(iClk),
    .iReset(iReset),
    .enable(1'b1),
    .TIMER_LENGTH(TIMER_LENGTH),
    .done(tick)
    );
    
endmodule

