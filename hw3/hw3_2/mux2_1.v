module mux2_1(in1, in2, sel, out);

input [15:0] in1, in2;
input sel;

output [15:0] out;

assign out[0] = (in1[0] & ~sel) | (in2[0] & sel);
assign out[1] = (in1[1] & ~sel) | (in2[1] & sel);
assign out[2] = (in1[2] & ~sel) | (in2[2] & sel);
assign out[3] = (in1[3] & ~sel) | (in2[3] & sel);

assign out[4] = (in1[4] & ~sel) | (in2[4] & sel);
assign out[5] = (in1[5] & ~sel) | (in2[5] & sel);
assign out[6] = (in1[6] & ~sel) | (in2[6] & sel);
assign out[7] = (in1[7] & ~sel) | (in2[7] & sel);

assign out[8] = (in1[8] & ~sel) | (in2[8] & sel);
assign out[9] = (in1[9] & ~sel) | (in2[9] & sel);
assign out[10] = (in1[10] & ~sel) | (in2[10] & sel);
assign out[11] = (in1[11] & ~sel) | (in2[11] & sel);

assign out[12] = (in1[12] & ~sel) | (in2[12] & sel);
assign out[13] = (in1[13] & ~sel) | (in2[13] & sel);
assign out[14] = (in1[14] & ~sel) | (in2[14] & sel);
assign out[15] = (in1[15] & ~sel) | (in2[15] & sel);

endmodule
