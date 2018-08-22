`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:19:58 07/10/2018 
// Design Name: 
// Module Name:    sync_r2w 
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
module sync_r2w #(parameter ADDRSIZE = 5)
	(
    input wclk, wrst,
	 input [ADDRSIZE : 0] rptr,
	 output reg [ADDRSIZE : 0] wq2_rptr
	 );
	 
	 reg [ ADDRSIZE: 0] wq1_rptr;
	
	always @ (negedge wclk or posedge wrst)
	begin
			if(wrst) {wq2_rptr, wq1_rptr} <= 0;
	
			else
			begin
					wq1_rptr <= rptr;
					wq2_rptr <= wq1_rptr;
			end
	end
endmodule
