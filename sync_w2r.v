`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:20:06 07/10/2018 
// Design Name: 
// Module Name:    sync_w2r 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sync_w2r #(parameter ADDRSIZE = 5)
	(
    input rclk, rrst,
	 input [ADDRSIZE : 0] wptr,
	 output reg [ADDRSIZE : 0] rq2_wptr
	 );
	 
	 reg [ ADDRSIZE: 0] rq1_wptr;
	
	always @ (negedge rclk or posedge rrst)
	begin
			if(rrst) {rq2_wptr, rq1_wptr} <= 0;
	
			else
			begin
					rq1_wptr <= wptr;
					rq2_wptr <= rq1_wptr;
			end
	end
endmodule
