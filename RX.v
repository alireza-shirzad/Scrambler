module RX(dataIn, length, clk, reset, request, dataOut, ready);
//// Necessary parameters
parameter LENGTH_NUMOF_BIT = 12;
parameter STATE_NUMOF_BIT = 2;
parameter IDLE = 2'b00, INITIALIZE = 2'b01, SCRAMBLING = 2'b10, FINISH = 2'b11;
////

//// Input output declaration
input clk, request, dataIn, reset;
input [LENGTH_NUMOF_BIT-1:0] length;
output reg ready;
output dataOut;
////

//// FSM setup
		// Necessary reg and wire declaration
		reg [STATE_NUMOF_BIT-1:0] currentState;
		reg [STATE_NUMOF_BIT-1:0] nextState;
		wire scramblingEnd;
		reg [LENGTH_NUMOF_BIT-1:0] counter;
		// State transition
		always @(currentState,scramblingEnd,request)
		begin
		case(currentState)
		IDLE: if(request==1'b1) nextState = INITIALIZE;
		else nextState = IDLE;
		INITIALIZE: nextState = SCRAMBLING;	
		SCRAMBLING: if(scramblingEnd==1'b1)nextState = FINISH;
		else nextState = SCRAMBLING;
		FINISH: nextState = IDLE;
		endcase
		end
		// State Assignment
		always @(posedge clk)
		begin
			if(reset==1'b1) currentState = IDLE;
			else currentState = nextState;
		end
////

//// Floping the length
reg [LENGTH_NUMOF_BIT-1:0]lengthBuffer;
always @(posedge clk) begin
	if(request==1'b1)lengthBuffer <= length;
end
////

//// Counter setup
assign scramblingEnd = (counter == lengthBuffer);
always @(posedge clk) begin
	if(currentState==INITIALIZE | currentState==IDLE | currentState==FINISH) counter <= 0;
	else counter <= counter + 1;
end
////

//// ready signal assignment
reg bitToScramble;
always @(posedge clk) begin
if(currentState==SCRAMBLING)begin 
	ready=1'b1;
	bitToScramble = dataIn;
	end
else ready=1'b0;
end
////

////Scrambling Phase
wire [6:0] state_out;
wire scramblingReset;
// Instantiation
assign scramblingReset = (currentState==INITIALIZE);
Descrambler descrambler(clk, scramblingReset, state_out, bitToScramble, dataOut);
////

endmodule