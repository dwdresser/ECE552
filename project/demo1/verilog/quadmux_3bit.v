module quadmux_3bit(InA, InB, InC, InD, S, Out);

input [2:0] InA;
input [2:0] InB;
input [2:0] InC;
input [2:0] InD;
input [1:0] S;

output [2:0] Out;

mux4_1 mux0(.InA(InA[0]), .InB(InB[0]), .InC(InC[0]), .InD(InD[0]), .Out(Out[0]), .S(S[1:0]));
mux4_1 mux1(.InA(InA[1]), .InB(InB[1]), .InC(InC[1]), .InD(InD[1]), .Out(Out[1]), .S(S[1:0]));
mux4_1 mux2(.InA(InA[2]), .InB(InB[2]), .InC(InC[2]), .InD(InD[2]), .Out(Out[2]), .S(S[1:0]));

endmodule
