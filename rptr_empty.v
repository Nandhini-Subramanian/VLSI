`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:24:14 07/10/2018 
// Design Name: 
// Module Name:    rptr_empty 
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
module rptr_empty #(parameter ADDRSIZE = 5)
	(
	 input rclk, rrst, rinc, 
	 input [ADDRSIZE: 0] rq2_wptr,
	 output reg rempty,
	 output [ADDRSIZE - 1: 0] raddr,
	 output reg [ADDRSIZE: 0] rptr
    );
	
	reg [ADDRSIZE: 0] rbin;
	wire [ADDRSIZE: 0] rbinnext, rgraynext;
	wire rempty_val;
	
	assign rbinnext = rbin + (rinc & ~rempty);
	assign rgraynext = (rbinnext >> 1) ^ rbinnext;
	assign raddr = rbin [ADDRSIZE-1 : 0] ;
	
	assign rempty_val = (rgraynext == {rq2_wptr[ADDRSIZE: ADDRSIZE-1], rq2_wptr[ADDRSIZE-2: 0]});
	
	always @ (negedge rclk or posedge rrst)
	begin
			if(rrst)
			begin
					rbin <= 0;
					rptr <= 0;
					//rempty <= rempty_val | rrst;
					
					
			end
			
			else 
			begin
					rbin <= rbinnext;
					rptr <= rgraynext;					
					rempty <= rempty_val | rrst;
			end
			
	end

endmodule
