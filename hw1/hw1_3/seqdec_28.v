module seqdec_28(InA, Clk, Reset, Out);

input InA, Clk, Reset;

output reg Out;

wire [3:0] state;
reg [3:0] next_state;

wire not_InA;

dff flip_flop0(.q(state[0]), .d(next_state[0]), .clk(Clk), .rst(Reset));
dff flip_flop1(.q(state[1]), .d(next_state[1]), .clk(Clk), .rst(Reset));
dff flip_flop2(.q(state[2]), .d(next_state[2]), .clk(Clk), .rst(Reset));
dff flip_flop3(.q(state[3]), .d(next_state[3]), .clk(Clk), .rst(Reset));

not1 not_2(.in1(InA), .out(not_InA));

//input to reset state
always @(state or InA)
	begin
	case(state)

		//reset state
		4'b0000: 
			begin
			next_state = not_InA; //GOOD
			end


		//state 1
		4'b0001: 	
			begin			
			next_state[0] = 1'b0; //GOOD
			next_state[1] = not_InA; //GOOD
			end	

		//state 2
		4'b0010: 
			begin
			next_state[0] = InA; //GOOD
			next_state[1] = 1'b1;	
			next_state[2] = 1'b0;
			next_state[3] = 1'b0;
			end

		//state 3
		4'b0011:
			begin
			next_state[0] = 1'b0; //GOOD
			next_state[1] = 1'b0;
			next_state[2] = not_InA; //GOOD
			next_state[3] = 1'b0;
			end

		//state 4
		4'b0100:
			begin
			next_state[2] = InA; //GOOD
			next_state[0] = InA; //GOOD
			next_state[1] = not_InA; //GOOD
			next_state[3] = 1'b0;
			end

		//state 5
		4'b0101:
			begin
			next_state[0] = 1'b0; //GOOD
			next_state[1] = not_InA; //GOOD
			next_state[2] = not_InA; //GOOD
			next_state[3] = 1'b0;
			end

		//state 6
		4'b0110: 
			begin
			next_state[0] = not_InA; //GOOD
			next_state[1] = not_InA; //GOOD
			next_state[2] = not_InA; //GOOD
			next_state[3] = 1'b0;
			end
		
		//state 7
		4'b0111:
			begin
			next_state[0] = InA; //GOOD
			next_state[1] = InA; //GOOD
			next_state[2] = 1'b0; //GOOD
			next_state[3] = not_InA; //GOOD
			end

		//state 8
		4'b1000: 
			begin
			next_state[0] = InA; //GOOD
			next_state[1] = 1'b1;
			next_state[2] = 1'b0;
			next_state[3] = 1'b0;
			end

		default:
			begin
			next_state = 4'b0000;
			end
	endcase
	end

always @(state)
	begin
	case(state[3])

		1'b1: Out = 1'b1;

		1'b0: Out = 1'b0;
	endcase
	end
endmodule 
