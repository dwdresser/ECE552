module extend_16bit(in, sel, sign_ext, out);

input [10:0] in;

input [1:0] sel;

input sign_ext;

output [15:0] out;


mux2_1 bit5(.InA(sign_ext & in[4]), .InB(in[5]), .S(sel[0] | sel[1]), .Out(out[5]));
mux2_1 bit6(.InA(sign_ext & in[4]), .InB(in[6]), .S(sel[0] | sel[1]), .Out(out[6]));
mux2_1 bit7(.InA(sign_ext & in[4]), .InB(in[7]), .S(sel[0] | sel[1]), .Out(out[7]));

mux4_1 bit8(.InA(sign_ext & in[4]), .InB(sign_ext & in[7]), .InC(in[8]), .InD(in[8]), .Out(out[8]), .S(sel));
mux4_1 bit9(.InA(sign_ext & in[4]), .InB(sign_ext & in[7]), .InC(in[9]), .InD(in[9]), .Out(out[9]), .S(sel));
mux4_1 bit10(.InA(sign_ext & in[4]), .InB(sign_ext & in[7]), .InC(in[10]), .InD(in[10]), .Out(out[10]), .S(sel));

mux4_1 bit11(.InA(sign_ext & in[4]), .InB(sign_ext & in[7]), .InC(sign_ext & in[10]), .InD(sign_ext & in[10]), .Out(out[11]), .S(sel));
mux4_1 bit12(.InA(sign_ext & in[4]), .InB(sign_ext & in[7]), .InC(sign_ext & in[10]), .InD(sign_ext & in[10]), .Out(out[12]), .S(sel));
mux4_1 bit13(.InA(sign_ext & in[4]), .InB(sign_ext & in[7]), .InC(sign_ext & in[10]), .InD(sign_ext & in[10]), .Out(out[13]), .S(sel));
mux4_1 bit14(.InA(sign_ext & in[4]), .InB(sign_ext & in[7]), .InC(sign_ext & in[10]), .InD(sign_ext & in[10]), .Out(out[14]), .S(sel));
mux4_1 bit15(.InA(sign_ext & in[4]), .InB(sign_ext & in[7]), .InC(sign_ext & in[10]), .InD(sign_ext & in[10]), .Out(out[15]), .S(sel));

assign out[4:0] = in[4:0];

endmodule





















/*
module extend_16bit(in, sel, sign_ext, out);

input [10:0] in;

input [1:0] sel;

input sign_ext;

output reg [15:0] out;

reg [10:0] extended_bits;

initial assign_ext extended_bits = {11{sign_ext}};
	
always begin

	case(sel)	2'b00 : assign_ext out = {extended_bits[10:0],in[4:0]};
			2'b01 : assign_ext out = {extended_bits[7:0],in[7:0]};
			2'b10 : assign_ext out = {extended_bits[4:0],in[10:0]};
			default : assign_ext out = 16'h0000;
	endcase
end

initial #30 $stop;

endmodule
*/		
