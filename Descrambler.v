module Descrambler (clock ,reset ,state_out,bit_in,bit_out);
//// Input Output declaration
   input clock ;
   input reset ;
   input bit_in;
   output [6:0] state_out ;
   output 	bit_out;
////

//// Necessary register declarations
   reg [6:0] 	state_out ;
   reg 		bit_out;  
   assign feedback =  (bit_in ^ state_out[6] ^ state_out[3]);
////

//// Operation of the shift register
   always @ (posedge clock)
     begin
	if (reset == 1'b1) 
	begin
	   state_out <= 7'b1010000; // Should be the same as the scrambler initial state
	end
	else 
	begin
	   state_out <= {state_out[5], state_out[4], state_out[3],
			 state_out[2], state_out[1], state_out[0],
			 bit_in};
	end
     end 
////

//// Floping the output
   always @ (negedge clock)
     begin
	bit_out<=feedback;
     end
////
	  
endmodule