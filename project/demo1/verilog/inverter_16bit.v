module inverter_16bit(in, S, out);

input [15:0] in;
input S; //1 if we want to invert, 0 if else

output [15:0] out;

//Choose to invert each bit by XOR'ing it with the select bit
xor2 bit1(.in1(in[0]),.in2(S),.out(out[0]));
xor2 bit2(.in1(in[1]),.in2(S),.out(out[1]));
xor2 bit3(.in1(in[2]),.in2(S),.out(out[2]));
xor2 bit4(.in1(in[3]),.in2(S),.out(out[3]));
xor2 bit5(.in1(in[4]),.in2(S),.out(out[4]));
xor2 bit6(.in1(in[5]),.in2(S),.out(out[5]));
xor2 bit7(.in1(in[6]),.in2(S),.out(out[6]));
xor2 bit8(.in1(in[7]),.in2(S),.out(out[7]));
xor2 bit9(.in1(in[8]),.in2(S),.out(out[8]));
xor2 bit10(.in1(in[9]),.in2(S),.out(out[9]));
xor2 bit11(.in1(in[10]),.in2(S),.out(out[10]));
xor2 bit12(.in1(in[11]),.in2(S),.out(out[11]));
xor2 bit13(.in1(in[12]),.in2(S),.out(out[12]));
xor2 bit14(.in1(in[13]),.in2(S),.out(out[13]));
xor2 bit15(.in1(in[14]),.in2(S),.out(out[14]));
xor2 bit16(.in1(in[15]),.in2(S),.out(out[15]));

endmodule
