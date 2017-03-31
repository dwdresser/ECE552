module quadmux_64bit(InA, InB, InC, InD, S, Out);

input [63:0] InA;
input [63:0] InB;
input [63:0] InC;
input [63:0] InD;

input [1:0] S;

output [63:0] Out;

quadmux_16bit mux0(.InA(InA[15:0]), .InB(InB[15:0]), .InC(InC[15:0]), .InD(InD[15:0]), .Out(Out[15:0]), .S(S[1:0]));
quadmux_16bit mux1(.InA(InA[31:16]), .InB(InB[31:16]), .InC(InC[31:16]), .InD(InD[31:16]), .Out(Out[31:16]), .S(S[1:0]));
quadmux_16bit mux2(.InA(InA[47:32]), .InB(InB[47:32]), .InC(InC[47:32]), .InD(InD[47:32]), .Out(Out[47:32]), .S(S[1:0]));
quadmux_16bit mux3(.InA(InA[63:48]), .InB(InB[63:48]), .InC(InC[63:48]), .InD(InD[63:48]), .Out(Out[63:48]), .S(S[1:0]));

endmodule
