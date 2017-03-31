module alu (A, B, Cin, Op, invA, invB, sign, Out, Ofl, Z, sign_out, co);
   
	//module inputs
        input [15:0] A;
        input [15:0] B;
        input Cin;
        input [3:0] Op;
        input invA;
        input invB;
        input sign;

	//module outputs
        output [15:0] Out;
        output Ofl;
        output Z;
	output sign_out;
	output co;

	//New A and B inputs after they were inverted or not
	wire [15:0] updated_A;
	wire [15:0] updated_B;

//	initial	$monitor("A %h, B %h, Cin %b, Op %b, invA %b, invB %b, sign %b, Out %h, Ofl %b, Z %b, sign_out %b, co %b, barrel_output %h, A_add_B %h", A, B, Cin, Op, invA, invB, sign, Out, Ofl, Z, sign_out, co, barrel_output, A_add_B);

	//Inverts A based on the invA input to the ALU
	inverter_16bit invert_A(.in(A[15:0]), .S(invA), .out(updated_A[15:0]));
	//Inverts B based on the invB input to the ALU
	inverter_16bit invert_B(.in(B[15:0]), .S(invB), .out(updated_B[15:0]));

	//btr logic result
	wire [15:0] btr_result;

	//bit flip logic
	flip btr_logic(.in(updated_A[15:0]), .out(btr_result[15:0]));

	//Otuput of the barrel shifter
	wire [15:0] barrel_output;

	//Instantiate Barrel Shifter
	shifter barrel_shifter(.In(updated_A[15:0]), .Cnt(updated_B[3:0]), .Op(Op[1:0]), .Out(barrel_output[15:0]));

	//Addition of A and B 
	wire [15:0]A_add_B;
	wire Pout;
	wire Gout;

	//16 bit carry look ahead adder module
	CLA_16bit carry_adder_16bit(.A(updated_A[15:0]), .B(updated_B[15:0]), .Cin(Cin), .Pout(Pout), .Gout(Gout), .Sum(A_add_B[15:0]));

	//sign output logic
	//assign sign_out = ((A_add_B[15])/* | (A[15] & B[15]) | (A_add_B[15] & ~A[15] & ~B[15]) | (A[15] & B[15] & ~A_add_B[15])*/ & ~(~A[15] & B[15] & A_add_B[15])); 
	assign sign_out =  ((A_add_B[15] & ~(~A[15] & B[15])) | (A[15] & ~B[15]));
	//assign sign_out = ((A_add_B[15] & ~(A[15] & B[15])) | (A[15] & ~B[15]));

	//carry out logic
	assign co = ((Pout & Cin) | Gout);

	//Other operation results of A and B
	wire [15:0]A_or_B;
	wire [15:0]A_xor_B;
	wire [15:0]A_and_B;

	//Modules for the OR, XOR, and AND operations
	or_16bit orFunction(.InA(updated_A[15:0]), .InB(updated_B[15:0]), .Out(A_or_B[15:0]));
	xor_16bit xorFunction(.InA(updated_A[15:0]), .InB(updated_B[15:0]), .Out(A_xor_B[15:0]));
	and_16bit andFunction(.InA(updated_A[15:0]), .InB(updated_B[15:0]), .Out(A_and_B[15:0]));

	//Wire holding value selected from the Opcodes where the MSB is 1 (ADD, OR, XOR, AND)
	wire [15:0] selected_output_MSB_is1;

	//select which op to output
	//mux_16bit_select first_select(.InA(A_add_B[15:0]),  .InB(A_or_B[15:0]), .InC(A_xor_B[15:0]), .InD(A_and_B[15:0]), .S(Op[1:0]), .Out(selected_output_MSB_is1[15:0]));
	//mux_16bit_select second_select(.InA(barrel_output[15:0]), .InB(selected_output_MSB_is1[15:0]), .InC(16'h0000), .InD(16'h0000), .S({1'b0,Op[2]}), .Out(Out[15:0]));

	//Output mux results
	wire [15:0] first_4_select;
	wire [15:0] second_4_select;
	wire [15:0] third_4_select;
	wire [15:0] second_level_select;
	wire [15:0] third_level_select;

	//output logic
	quadmux_16bit first_select(.InA(A_add_B[15:0]), .InB(A_add_B[15:0]), .InC(A_xor_B[15:0]), .InD(A_and_B), .S(Op[1:0]), .Out(first_4_select));
	quadmux_16bit third_select(.InA(btr_result[15:0]), .InB(updated_B[15:0]), .InC(barrel_output[15:0] | updated_B[15:0]), .InD(barrel_output[15:0] | updated_B[15:0]), .S(Op[1:0]), .Out(third_4_select));

	quadmux_16bit final_select(.InA(first_4_select[15:0]), .InB(barrel_output[15:0]), .InC(third_4_select[15:0]), .InD(third_4_select[15:0]), .S(Op[3:2]), .Out(Out[15:0]));

	//Check if the output has overflow if dealing with signed numbers
	wire sign_same, sign_changed, signed_use, signed_overflow, unsigned_overflow;
	assign sign_same = ~(updated_A[15] ^ updated_B[15]);
	assign sign_changed = (updated_A[15] ^ Out[15]);
	assign signed_overflow = (sign_same & sign_changed);

	//Total overflow detection
	assign Ofl = ((signed_overflow &sign) | (Gout & ~sign));
	
	//Check if the output is zero
	//assign Z = ~(Out[0] | Out[1] | Out[2] | Out[3] | Out[4] | Out[5] | Out[6] | Out[7] | Out[8] | Out[9] | Out[10] | Out[11] | Out[12] | Out[13] | Out[14] | Out[15]); 
	//assign Z = (Out[15:0] == 16'h0000);
    	//assign Z = (A[15:0] == B[15:0]);
	assign Z = (~(A[13] ^ B[13]) & ~(A[12] ^ B[12]) & ~(A[11] ^ B[11]) & ~(A[10] ^ B[10]) & ~(A[15] ^ B[15]) & ~(A[14] ^ B[14]) & ~(A[9] ^ B[9]) & ~(A[8] ^ B[8]) & ~(A[7] ^ B[7]) &~(A[6] ^ B[6]) & ~(A[5] ^ B[5]) & ~(A[4] ^ B[4]) & ~(A[3] ^ B[3]) & ~(A[2] ^ B[2]) & ~(A[1] ^ B[1]) & ~(A[0] ^ B[0]));
endmodule
