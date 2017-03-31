module mux4_1(InA, InB, InC, InD, Out, S);

input InA, InB, InC, InD;
input [1:0] S;
output Out;

wire out1, out2;

mux2_1 mux1(.InA(InA), .InB(InB), .Out(out1), .S(S[0]));
mux2_1 mux2(.InA(InC), .InB(InD), .Out(out2), .S(S[0]));

mux2_1 mux3(.InA(out1), .InB(out2), .S(S[1]), .Out(Out));

endmodule
