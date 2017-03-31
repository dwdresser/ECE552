module quadmux_256bit(InA, InB, InC, InD, S, Out);

input [255:0] InA;
input [255:0] InB;
input [255:0] InC;
input [255:0] InD;

input [1:0] S;

output [255:0] Out;

quadmux_64bit mux0(.InA(InA[63:0]), .InB(InB[63:0]), .InC(InC[63:0]), .InD(InD[63:0]), .Out(Out[63:0]), .S(S[1:0]));
quadmux_64bit mux1(.InA(InA[127:64]), .InB(InB[127:64]), .InC(InC[127:64]), .InD(InD[127:64]), .Out(Out[127:64]), .S(S[1:0]));
quadmux_64bit mux2(.InA(InA[191:128]), .InB(InB[191:128]), .InC(InC[191:128]), .InD(InD[191:128]), .Out(Out[191:128]), .S(S[1:0]));
quadmux_64bit mux3(.InA(InA[255:192]), .InB(InB[255:192]), .InC(InC[255:192]), .InD(InD[255:192]), .Out(Out[255:192]), .S(S[1:0]));

endmodule
