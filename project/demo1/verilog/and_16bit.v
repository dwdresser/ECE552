module and_16bit(InA, InB, Out);

input [15:0] InA;
input [15:0] InB;

output [15:0] Out;

assign Out[0] = InA[0] & InB[0];
assign Out[1] = InA[1] & InB[1];
assign Out[2] = InA[2] & InB[2];
assign Out[3] = InA[3] & InB[3];
assign Out[4] = InA[4] & InB[4];
assign Out[5] = InA[5] & InB[5];
assign Out[6] = InA[6] & InB[6];
assign Out[7] = InA[7] & InB[7];
assign Out[8] = InA[8] & InB[8];
assign Out[9] = InA[9] & InB[9];
assign Out[10] = InA[10] & InB[10];
assign Out[11] = InA[11] & InB[11];
assign Out[12] = InA[12] & InB[12];
assign Out[13] = InA[13] & InB[13];
assign Out[14] = InA[14] & InB[14];
assign Out[15] = InA[15] & InB[15];

endmodule
