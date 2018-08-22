module fifomem # (parameter DATASIZE = 32, parameter ADDRSIZE = 5)
(
input wclken, wfull, wclk,
input [DATASIZE - 1: 0] wdata,
input [ADDRSIZE - 1: 0]	waddr, raddr,
output [DATASIZE - 1: 0] rdata
);

localparam DEPTH = 1 << ADDRSIZE;
reg [DATASIZE - 1: 0] mem [0 : DEPTH - 1];
integer row, column;
assign rdata = mem [raddr];

initial 
begin
		for (row = 0; row < DEPTH; row = row + 1)
		begin
				for(column = 0; column < DATASIZE; column = column + 1)
				begin
						mem[row][column] = 1'b0;
				end
		end
end
always @ (negedge wclk)

if(wclken && (!wfull))
begin
	mem[waddr] <= wdata;
end
 
endmodule 
