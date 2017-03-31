module full_adder(A, B, Cin, S, Cout);

input A, B, Cin;
output S, Cout;

wire wire1, wire2, wire3, wire4;

xor2 xor_1(.in1(A), .in2(B), .out(wire1));
xor2 xor_2(.in1(wire1), .in2(Cin), .out(S));

nand2 nand_1(.in1(A), .in2(B), .out(wire2));
nand2 nand_2(.in1(Cin), .in2(wire1), .out(wire3));
nand2 nand_3(.in1(wire2), .in2(wire3), .out(Cout));

endmodule

