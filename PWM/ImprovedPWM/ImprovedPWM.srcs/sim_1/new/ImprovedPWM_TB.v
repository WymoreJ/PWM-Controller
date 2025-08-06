`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2025 06:10:39 PM
// Design Name: 
// Module Name: SimplePWM_TB
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


module ImprovedPWM_TB();

	//input declarations
	reg iClk;
	reg iReset;
	reg [N_BIT:0] iDutyCycle;
	reg [TIMER_SIZE - 1 : 0] TIMER_LENGTH;
	//output declaration
	wire oPWM;
	//parameter declaration
	parameter N_BIT = 8;
	parameter TIMER_SIZE = 15;
	
	//DUT instantiation
	ImprovedPWM #(N_BIT,TIMER_SIZE) DUT(
		.iClk(iClk),
		.iReset(iReset),
		.iDutyCycle(iDutyCycle),
		.TIMER_LENGTH(TIMER_LENGTH),
		.oPWM(oPWM)
		);
		
	
	initial begin
		//clock generation
		iClk = 1'b0;
		forever #1 iClk = ~iClk;
	end
	
	initial begin
	//initialization
		iReset = 1'b0;
		iDutyCycle = 'b0;
	end
	
	initial begin
		//variation (fixed values/loops)
		#2 
		iReset = 1'b1;
		iDutyCycle = 0.25 * (2 ** N_BIT);
		
		repeat(2 * 2 ** N_BIT) @(negedge iClk);
		iDutyCycle = 0.5 * (2 ** N_BIT);
		
		repeat(2 * 2 ** N_BIT) @(negedge iClk);
		iDutyCycle = 0.75 * (2 ** N_BIT);
		

	end
	
	initial begin
		$monitor("Time: %0d, iReset: %b, Duty Cycle: %d, Output: %b",$time, iReset, iDutyCycle, oPWM);
		//#5000 $finish;
	end
endmodule


