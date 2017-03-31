module mux8_1(in0, in1, in2, in3, in4, in5, in6, in7, sel, out);

input in0, in1, in2, in3, in4, in5, in6, in7;
input [2:0] sel;

output out;

wire [7:0] seldec;
//wire [15:0] sel0, sel1, sel2, sel3, sel4, sel5, sel6, sel7;

decoder decode(.in(sel), .out(seldec));

/*
assign sel0 = {16{seldec[0]}};
assign sel1 = {16{seldec[1]}};
assign sel2 = {16{seldec[2]}};
assign sel3 = {16{seldec[3]}};
assign sel4 = {16{seldec[4]}};
assign sel5 = {16{seldec[5]}};
assign sel6 = {16{seldec[6]}};
assign sel7 = {16{seldec[7]}};
*/

assign out = ((in0 & seldec[0]) | (in1 & seldec[1]) | (in2 & seldec[2]) | (in3 & seldec[3]) | (in4 & seldec[4]) | (in5 & seldec[5]) | (in6 & seldec[6]) | (in7 & seldec[7]));

/*
assign out0 = reg0 & sel0;
assign out1 = reg1 & sel1;
assign out2 = reg2 & sel2;
assign out3 = reg3 & sel3;
assign out4 = reg4 & sel4;
assign out5 = reg5 & sel5;
assign out6 = reg6 & sel6;
assign out7 = reg7 & sel7;

assign out = out0 | out1 | out2 | out3 | out4 | out5 | out6 | out7;
*/

endmodule

