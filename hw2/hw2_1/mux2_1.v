module mux2_1 (InA, InB, S, Out);

input InA, InB, S;
output Out;
wire not_S, nand_output1, nand_output2;

not1 notA(.in1(S), .out(not_S));
nand2 nand_A(.in1(InA), .in2(not_S), .out(nand_output1));
nand2 nand_B(.in1(InB), .in2(S), .out(nand_output2));
nand2 nand_AB(.in1(nand_output1), .in2(nand_output2), .out(Out));

endmodule

