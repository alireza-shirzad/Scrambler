module Scrambler(clk,reset,state_out,bit_in, bit_out);
//// Input Output declarations
	input wire clk;
	input wire reset;
	input wire bit_in;
	output wire bit_out;
	output reg [6:0] state_out;
////

//// Necessary reg and wire declarations
	wire feedback;
	assign feedback =  (bit_in ^ state_out[6] ^ state_out[3]);
	assign bit_out = feedback;
////

//// Shift register Operations
	always @(posedge clk)
	begin
	
		if (reset == 1'b1) 
			state_out <=  7'b1010000; // Should be the same as the descrambler initial state
		else
			state_out <= {state_out[5], state_out[4], state_out[3],state_out[2], state_out[1], state_out[0],feedback};
	end
////
endmodule