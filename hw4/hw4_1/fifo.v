/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module fifo(/*AUTOARG*/
   // Outputs
   data_out, fifo_empty, fifo_full, err,
   // Inputs
   data_in, data_in_valid, pop_fifo, clk, rst
   );
   input [63:0] data_in;
   input        data_in_valid;
   input        pop_fifo;

   input        clk;
   input        rst;
   output reg [63:0] data_out;
   output reg       fifo_empty;
   output reg       fifo_full;
   output        err;

	reg [2:0] next_state;
	wire [2:0] state;
	reg inc, dec;
	wire [255:0] fifo_output, fifo_input;

	dff state_bit0(.q(state[0]), .d(next_state[0]), .clk(clk), .rst(rst));
	dff state_bit1(.q(state[1]), .d(next_state[1]), .clk(clk), .rst(rst));
	dff state_bit2(.q(state[2]), .d(next_state[2]), .clk(clk), .rst(rst));

	dff fifo[255:0] (.q(fifo_output), .d(fifo_input), .clk(clk), .rst(rst));
	
	//[0:63][64:127][128:191][192:255]
	quadmux_256bit inc_dec_logic(.InA(fifo_output), .InB({fifo_output[191:0],data_in}), .InC(fifo_output), .InD({fifo_output[191:0],data_in}), .S({dec,inc}), .Out(fifo_input));

	always @* begin

		case(state) 
			3'b000 : begin
				fifo_full = 0;
				fifo_empty = 1;
				next_state = {2'b00,((data_in_valid & ~pop_fifo) | (data_in_valid & pop_fifo))};
				inc = next_state[0] | (data_in_valid & pop_fifo);
				dec = 1'b0;
				data_out = 64'h0000000000000000;
			end
			3'b001 : begin
				fifo_full = 0;
				fifo_empty = 0;
				next_state = {1'b0,(data_in_valid & ~pop_fifo),((~pop_fifo & ~data_in_valid) | (pop_fifo & data_in_valid))};
				inc = (next_state[1] & ~next_state[0]) | (data_in_valid & pop_fifo);
				dec = (~next_state[1] & ~next_state[0]) | (data_in_valid & pop_fifo);
				data_out = fifo_output[63:0];
			end
			3'b010 : begin
				fifo_full = 0;
				fifo_empty = 0;
				next_state = {1'b0,(~(pop_fifo & ~data_in_valid)),(~((~pop_fifo & ~data_in_valid) | (pop_fifo & data_in_valid)))};
				inc = (next_state[1] & next_state[0]) | (data_in_valid & pop_fifo);
				dec = (~next_state[1] & next_state[0]) | (data_in_valid & pop_fifo);
				data_out = fifo_output[127:64];
			end
			3'b011 : begin
				fifo_full = 0;
				fifo_empty = 0;
				next_state = {(data_in_valid & ~pop_fifo),(~(data_in_valid & ~pop_fifo)),((data_in_valid & pop_fifo) | (~data_in_valid & ~pop_fifo))};
				inc = (next_state[2] | (data_in_valid & pop_fifo));
				dec = (next_state[1] & ~next_state[0]) | (data_in_valid & pop_fifo);
				data_out = fifo_output[191:128];
			end
			3'b100 : begin
				fifo_full = 1;
				fifo_empty = 0;
				next_state = {~pop_fifo,pop_fifo,pop_fifo};
				inc = 1'b0;
				dec = (next_state[1] & next_state[0]) | (data_in_valid & pop_fifo);
				data_out = fifo_output[255:192];
			end
		endcase
	end
			
			

endmodule
// DUMMY LINE FOR REV CONTROL :1:
