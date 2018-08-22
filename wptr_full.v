`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:02:55 07/10/2018 
// Design Name: 
// Module Name:    wptr_full 
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
module wptr_full #(parameter ADDRSIZE = 5)
	(
	 input wclk, wrst, winc, 
	 input [ADDRSIZE: 0] wq2_rptr,
	 output reg wfull,
	 output [ADDRSIZE - 1: 0] waddr,
	 output reg [ADDRSIZE: 0] wptr
    );
	
	reg [ADDRSIZE: 0] wbin;
	wire [ADDRSIZE: 0] wbinnext, wgraynext;
	wire wfull_val;
	
	assign wbinnext = wbin + (winc & ~wfull);
	assign wgraynext = (wbinnext >> 1) ^ wbinnext;
	assign waddr = wbin [ADDRSIZE-1 : 0] ;
	
	assign wfull_val = (wgraynext == {~wq2_rptr[ADDRSIZE: ADDRSIZE-1],wq2_rptr[ADDRSIZE-2:0]});
	
	always @ (negedge wclk or posedge wrst)
	begin
			if(wrst)
			begin
					wbin <= 0;
					wptr <= 0;
					wfull <= 0;
					
			end
			
			else
			begin
					wbin <= wbinnext;
					wptr <= wgraynext;
					wfull <= wfull_val;
			end
	end

endmodule
