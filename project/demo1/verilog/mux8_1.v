module mux8_1(in0, in1, in2, in3, in4, in5, in6, in7, sel, out);

input in0, in1, in2, in3, in4, in5, in6, in7;
input [2:0] sel;

output out;

wire [7:0] seldec;
//wire [15:0] sel0, sel1, sel2, sel3, sel4, sel5, sel6, sel7;

decoder decode(.in(sel), .out(seldec));

assign out = ((in0 & seldec[0]) | (in1 & seldec[1]) | (in2 & seldec[2]) | (in3 & seldec[3]) | (in4 & seldec[4]) | (in5 & seldec[5]) | (in6 & seldec[6]) | (in7 & seldec[7]));

endmodule

