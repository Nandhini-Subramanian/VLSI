module fifo_top_tb;
	// Inputs
	reg winc;
	reg wclk;
	reg wrst;
	//reg wrst_n;
	reg rinc;
	reg rclk;
	reg rrst;
	//reg rrst_n;
	reg [31:0] wdata;
	reg [31:0] test_input[31:0];
	integer i;
	// Outputs
	wire [31:0] rdata;
	wire wfull;
	reg rempty;
	// Instantiate the Unit Under Test (UUT)
	fifo_top uut (
		.winc(winc), 
		.wclk(wclk), 
		.wrst(wrst), 
		.rinc(rinc), 
		.rclk(rclk), 
		.rrst(rrst), 
		.wdata(wdata), 
		.rdata(rdata), 
		.wfull(wfull)
	);
	initial begin
		// Initialize Inputs
		winc = 0;
		wclk = 0;
		wrst = 0;
		rinc = 0;
		rclk = 0;
		rrst = 0;
		wdata = 0;
		rempty=0;
		i=0;
	  $readmemh("fifo_top_tb.h",test_input,0,31);
		// Wait 100 ns for global reset to finish
		#100;
		wrst = 1;
		rrst = 1;
		winc = 1;
	//	#1560;
		//winc = 0;
		//rrst_n = 1;
		//#10;
		rinc = 1;
	end
 /*Case 1: Write Clock > Read Clock
	wclk = 10MHz and rclk = 7MHz
  Twclk = 100ns nd Trclk = 142.86ns. For 16 Read Clocks, the simulation time is 2288ns.*/ 
  always 
  begin
			wclk = ~wclk;
			#50; //Twclk/2: 50% Duty Cycle
  end
  always 
  begin
			rclk = ~rclk;
			#71.43; //Trclk/2: 50% Duty Cycle
  end
  always @ (negedge wclk)
  begin
			if(!wfull)
			begin
					wdata <= test_input[i];
					i=i+1;
			end
  end
endmodule
