module quadmux_16bit(InA, InB, InC, InD, S, Out);

input [15:0] InA;
input [15:0] InB;
input [15:0] InC;
input [15:0] InD;
input [1:0] S;

output [15:0] Out;

mux4_1 mux0(.InA(InA[0]), .InB(InB[0]), .InC(InC[0]), .InD(InD[0]), .Out(Out[0]), .S(S[1:0]));
mux4_1 mux1(.InA(InA[1]), .InB(InB[1]), .InC(InC[1]), .InD(InD[1]), .Out(Out[1]), .S(S[1:0]));
mux4_1 mux2(.InA(InA[2]), .InB(InB[2]), .InC(InC[2]), .InD(InD[2]), .Out(Out[2]), .S(S[1:0]));
mux4_1 mux3(.InA(InA[3]), .InB(InB[3]), .InC(InC[3]), .InD(InD[3]), .Out(Out[3]), .S(S[1:0]));
mux4_1 mux4(.InA(InA[4]), .InB(InB[4]), .InC(InC[4]), .InD(InD[4]), .Out(Out[4]), .S(S[1:0]));
mux4_1 mux5(.InA(InA[5]), .InB(InB[5]), .InC(InC[5]), .InD(InD[5]), .Out(Out[5]), .S(S[1:0]));
mux4_1 mux6(.InA(InA[6]), .InB(InB[6]), .InC(InC[6]), .InD(InD[6]), .Out(Out[6]), .S(S[1:0]));
mux4_1 mux7(.InA(InA[7]), .InB(InB[7]), .InC(InC[7]), .InD(InD[7]), .Out(Out[7]), .S(S[1:0]));
mux4_1 mux8(.InA(InA[8]), .InB(InB[8]), .InC(InC[8]), .InD(InD[8]), .Out(Out[8]), .S(S[1:0]));
mux4_1 mux9(.InA(InA[9]), .InB(InB[9]), .InC(InC[9]), .InD(InD[9]), .Out(Out[9]), .S(S[1:0]));
mux4_1 mux10(.InA(InA[10]), .InB(InB[10]), .InC(InC[10]), .InD(InD[10]), .Out(Out[10]), .S(S[1:0]));
mux4_1 mux11(.InA(InA[11]), .InB(InB[11]), .InC(InC[11]), .InD(InD[11]), .Out(Out[11]), .S(S[1:0]));
mux4_1 mux12(.InA(InA[12]), .InB(InB[12]), .InC(InC[12]), .InD(InD[12]), .Out(Out[12]), .S(S[1:0]));
mux4_1 mux13(.InA(InA[13]), .InB(InB[13]), .InC(InC[13]), .InD(InD[13]), .Out(Out[13]), .S(S[1:0]));
mux4_1 mux14(.InA(InA[14]), .InB(InB[14]), .InC(InC[14]), .InD(InD[14]), .Out(Out[14]), .S(S[1:0]));
mux4_1 mux15(.InA(InA[15]), .InB(InB[15]), .InC(InC[15]), .InD(InD[15]), .Out(Out[15]), .S(S[1:0]));

endmodule
