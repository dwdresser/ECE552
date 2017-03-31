module fulladder16(A, B, SUM, CO);

input [15:0] A;
input [15:0] B;

output [15:0] SUM;
output CO;

wire [2:0] carry_bits;

ripple_adder adder_1(.A(A[3:0]), .B(B[3:0]), .SUM(SUM[3:0]), .CI(0), .CO(carry_bits[0]));
ripple_adder adder_2(.A(A[7:4]), .B(B[7:4]), .SUM(SUM[7:4]), .CI(carry_bits[0]), .CO(carry_bits[1]));
ripple_adder adder_3(.A(A[11:8]), .B(B[11:8]), .SUM(SUM[11:8]), .CI(carry_bits[1]), .CO(carry_bits[2]));
ripple_adder adder_4(.A(A[15:12]), .B(B[15:12]), .SUM(SUM[15:12]), .CI(carry_bits[2]), .CO(CO));

endmodule
