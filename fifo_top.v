`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:53:02 07/10/2018 
// Design Name: 
// Module Name:    fifo_top 
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
module fifo_top #(parameter DSIZE = 32, 
						parameter ASIZE = 5)
(
	input winc, wclk, wrst,
	input rinc, rclk, rrst,
	input [DSIZE-1 :0] wdata,
	output [DSIZE-1 :0] rdata,
	output wfull, rempty);
	
	wire [ASIZE-1: 0] waddr, raddr;
	wire [ASIZE: 0] wptr, rptr, rq2_wptr, wq2_rptr;
	
fifomem fifomem_inst
			(.wclken(winc), .wfull(wfull), .wclk(wclk), .wdata(wdata), .waddr(waddr),
			 .rdata(rdata), .raddr(raddr));
	
sync_w2r sync_w2r_inst
			(.rclk(rclk), .rq2_wptr(rq2_wptr), .rrst(rrst), .wptr(wptr));
			
sync_r2w sync_r2w_inst
			(.wclk(wclk), .wq2_rptr(wq2_rptr), .wrst(wrst), .rptr(rptr));

wptr_full wptr_full_inst
			(.wclk(wclk), .winc(winc), .wrst(wrst), .wptr(wptr),.wfull(wfull), 
			 .waddr(waddr), .wq2_rptr(wq2_rptr));
			 
rptr_empty rptr_empty_inst
			(.rclk(rclk), .rinc(rinc), .rrst(rrst), .rptr(rptr), .rempty(rempty),
			 .raddr(raddr), .rq2_wptr(rq2_wptr));
			 
endmodule


