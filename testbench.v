module testbench();
//// Parameter declarations
	parameter period = 10;
	localparam cycle = period/2;
	localparam sim_duration = 36*period ;
////

//// TX module port declarations	
	reg clk, reset, request,dataIn;
	reg [11:0] length;
	wire dataOut, ready;
	reg data;
////

//// RX module port declarations
	wire recieverOut, recieverReady;
	reg recieverReset, recieverRequest;
////

//// counter initialization for sinulation duration
	reg [11:0] counter;
////

//// Initializing the TX and RX operations using reset and request lines
	initial begin
	counter = 0	;
	reset=1'b1;
	#period
	reset = 1'b0;
	request = 1'b1;
	recieverReset = 1'b1;
	#period
	recieverReset = 1'b0;
	recieverRequest = 1'b1;
	end
////	

//// Integers for file operations
	integer op, op_out, k;
////

//// Reading the input file
	always @(posedge clk) begin
		if(request==1)
		k <= $fscanf (op, "%b \n", dataIn);
	end
////

//// Initializing the files for simulation and setting the length parameter of the requset from the first line of the test file
	initial
	begin
	$dispaly("Scrambling simulation started");
	op=$fopen ("test.txt","r");
	op_out=$fopen ("test_result.txt","w");
	k <= $fscanf (op, "%b \n", length);
	end
////

////	writing the output of the reciever to a file
		always @(posedge clk)begin
		if (recieverReady==1'b1)
		$fwrite (op_out,"%b \n",recieverOut);
		end
////

//// Instantiating the TX and RX modules	
	TX tx(dataIn, length, clk, reset, request, dataOut, ready);
	RX rx(dataOut, length, clk, recieverReset, recieverRequest, recieverOut, recieverReady);
////
	
//// Counting  the number of simulation cycles	
	always @(posedge clk) begin
	if(counter==length + 4) $stop;
	else counter <= counter + 1;
	end
////	

//// clock generator
	always
	begin
		clk = 0; #cycle; clk = 1; #cycle;
	end
////
endmodule