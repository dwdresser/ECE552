module shift2_row(In, Out, S, Op);

input [15:0]In;
input S;
input [1:0]Op;

output [15:0]Out;

//wires for LSB mux logic
wire LSB_0select, LSB_1select, LSB_00input;

//wires for MSB mux logic
wire MSB_0select, MSB_1select;

//wires for bits 1-14 mux logic
wire bit1_c_wire, bit14_d_wire, test;

//mux logic for rotating and shifting that causes values to wrap around
mux2_1 bit1_inputC(.InA(In[15]), .InB(1'b0), .S(Op[0]), .Out(bit1_c_wire));
mux2_1 bit14_inputD(.InA(In[0]), .InB(1'b0), .S(Op[0]), .Out(bit14_d_wire));

//Muxes for bits 1 through 14
mux4_1 bit1(.InA(In[1]), .InB(In[1]), .InC(bit1_c_wire), .InD(In[3]), .Out(Out[1]), .S({S,Op[1]}));
mux4_1 bit2(.InA(In[2]), .InB(In[2]), .InC(In[0]), .InD(In[4]), .Out(Out[2]), .S({S,Op[1]}));
mux4_1 bit3(.InA(In[3]), .InB(In[3]), .InC(In[1]), .InD(In[5]), .Out(Out[3]), .S({S,Op[1]}));
mux4_1 bit4(.InA(In[4]), .InB(In[4]), .InC(In[2]), .InD(In[6]), .Out(Out[4]), .S({S,Op[1]}));
mux4_1 bit5(.InA(In[5]), .InB(In[5]), .InC(In[3]), .InD(In[7]), .Out(Out[5]), .S({S,Op[1]}));
mux4_1 bit6(.InA(In[6]), .InB(In[6]), .InC(In[4]), .InD(In[8]), .Out(Out[6]), .S({S,Op[1]}));
mux4_1 bit7(.InA(In[7]), .InB(In[7]), .InC(In[5]), .InD(In[9]), .Out(Out[7]), .S({S,Op[1]}));
mux4_1 bit8(.InA(In[8]), .InB(In[8]), .InC(In[6]), .InD(In[10]), .Out(Out[8]), .S({S,Op[1]}));
mux4_1 bit9(.InA(In[9]), .InB(In[9]), .InC(In[7]), .InD(In[11]), .Out(Out[9]), .S({S,Op[1]}));
mux4_1 bit10(.InA(In[10]), .InB(In[10]), .InC(In[8]), .InD(In[12]), .Out(Out[10]), .S({S,Op[1]}));
mux4_1 bit11(.InA(In[11]), .InB(In[11]), .InC(In[9]), .InD(In[13]), .Out(Out[11]), .S({S,Op[1]}));
mux4_1 bit12(.InA(In[12]), .InB(In[12]), .InC(In[10]), .InD(In[14]), .Out(Out[12]), .S({S,Op[1]}));
mux4_1 bit13(.InA(In[13]), .InB(In[13]), .InC(In[11]), .InD(In[15]), .Out(Out[13]), .S({S,Op[1]}));
mux4_1 bit14(.InA(In[14]), .InB(In[14]), .InC(In[12]), .InD(bit14_d_wire), .Out(Out[14]), .S({S,Op[1]}));

//Extra logic for most significant bit mux
and2 select0_logic_msb(.in1(S), .in2(Op[0]), .out(MSB_0select));
mux2_1 select1_logic_msb(.InA(1'b1), .InB(Op[1]), .S(S), .Out(MSB_1select));

mux2_1 select1_logic_msb_c(.InA(In[15]), .InB(In[1]), .S(S), .Out(test));

//Mux for most significant bit
mux4_1 MSB_mux(.InA(In[13]), .InB(In[13]), .InC(test), .InD(1'b0), .Out(Out[15]), .S({MSB_1select, MSB_0select}));

//Extra logic for least significant bit mux
and2 select0_logic_lsb(.in1(Op[0]), .in2(S), .out(LSB_0select));
and2 select1_logic_lsb(.in1(Op[1]), .in2(S), .out(LSB_1select));

mux2_1 LSB_00logic(.InA(In[0]), .InB(In[14]), .S(S), .Out(LSB_00input));

//Mux for least significant bit
mux4_1 LSB_mux(.InA(LSB_00input), .InB(1'b0), .InC(In[2]), .InD(In[2]), .Out(Out[0]), .S({LSB_1select,LSB_0select}));

endmodule
