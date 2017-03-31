module twomux_16bit(InA, InB, S, Out);

input [15:0] InA;
input [15:0] InB;
input S;

output [15:0] Out;

mux2_1 mux0(.InA(InA[0]), .InB(InB[0]), .Out(Out[0]), .S(S));
mux2_1 mux1(.InA(InA[1]), .InB(InB[1]), .Out(Out[1]), .S(S));
mux2_1 mux2(.InA(InA[2]), .InB(InB[2]), .Out(Out[2]), .S(S));
mux2_1 mux3(.InA(InA[3]), .InB(InB[3]), .Out(Out[3]), .S(S));
mux2_1 mux4(.InA(InA[4]), .InB(InB[4]), .Out(Out[4]), .S(S));
mux2_1 mux5(.InA(InA[5]), .InB(InB[5]), .Out(Out[5]), .S(S));
mux2_1 mux6(.InA(InA[6]), .InB(InB[6]), .Out(Out[6]), .S(S));
mux2_1 mux7(.InA(InA[7]), .InB(InB[7]), .Out(Out[7]), .S(S));
mux2_1 mux8(.InA(InA[8]), .InB(InB[8]), .Out(Out[8]), .S(S));
mux2_1 mux9(.InA(InA[9]), .InB(InB[9]), .Out(Out[9]), .S(S));
mux2_1 mux10(.InA(InA[10]), .InB(InB[10]), .Out(Out[10]), .S(S));
mux2_1 mux11(.InA(InA[11]), .InB(InB[11]), .Out(Out[11]), .S(S));
mux2_1 mux12(.InA(InA[12]), .InB(InB[12]), .Out(Out[12]), .S(S));
mux2_1 mux13(.InA(InA[13]), .InB(InB[13]), .Out(Out[13]), .S(S));
mux2_1 mux14(.InA(InA[14]), .InB(InB[14]), .Out(Out[14]), .S(S));
mux2_1 mux15(.InA(InA[15]), .InB(InB[15]), .Out(Out[15]), .S(S));

endmodule
