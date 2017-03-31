module ripple_adder(A, B, SUM, CI, CO);

input [3:0] A;
input [3:0] B;
input CI;

output [3:0] SUM;
output CO;

wire[ 2:0] carry_bits;

full_adder adder_1(.A(A[0]), .B(B[0]), .Cin(CI), .S(SUM[0]), .Cout(carry_bits[0]));
full_adder adder_2(.A(A[1]), .B(B[1]), .Cin(carry_bits[0]), .S(SUM[1]), .Cout(carry_bits[1]));
full_adder adder_3(.A(A[2]), .B(B[2]), .Cin(carry_bits[1]), .S(SUM[2]), .Cout(carry_bits[2]));
full_adder adder_4(.A(A[3]), .B(B[3]), .Cin(carry_bits[2]), .S(SUM[3]), .Cout(CO));

endmodule
