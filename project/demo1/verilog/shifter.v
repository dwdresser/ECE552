module shifter (In, Cnt, Op, Out);

//module inputs
input [15:0] In;
input [3:0]  Cnt;
input [1:0]  Op;

//module outputs
output [15:0] Out;

wire [15:0] shift1_output; //output of mux row that shifts by 1
wire [15:0] shift2_output; //output of mux row that shifts by 2
wire [15:0] shift4_output; //output of mux row that shifts by 4

//push inputs through shift by 1 muxes
shift1_row shift_by1(.In(In[15:0]), .Out(shift1_output[15:0]), .S(Cnt[0]), .Op(Op[1:0]));

//push inputs through shift by 2 muxes
shift2_row shift_by2(.In(shift1_output[15:0]), .Out(shift2_output[15:0]), .S(Cnt[1]), .Op(Op[1:0]));

//push inputs through shift by 4 muxes
shift4_row shift_by4(.In(shift2_output[15:0]), .Out(shift4_output[15:0]), .S(Cnt[2]), .Op(Op[1:0]));

//push inputs through shift by 8 muxes, this output is the final module output
shift8_row shift_by8(.In(shift4_output[15:0]), .Out(Out[15:0]), .S(Cnt[3]), .Op(Op[1:0]));
   
endmodule

