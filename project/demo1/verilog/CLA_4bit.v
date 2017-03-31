module CLA_4bit(A, B, Cin, Pout, Gout, Sum);

input [3:0] A;
input [3:0] B;
input Cin;

output Pout;
output Gout;
output [3:0] Sum;

wire [3:0] P;
wire [3:0] G;
wire [2:0] Cout;

//Carry logic into adder 1
assign Cout[0] = ((Cin & P[0]) | G[0]);

//Carry logic into adder 2
assign Cout[1] = ((Cin & P[0] & P[1]) | (G[0] & P[1]) | G[1]);

//Carry logic into adder 3
assign Cout[2] = ((Cin & P[0] & P[1] & P[2]) | (G[0] & P[1] & P[2]) | (G[1] & P[2]) | G[2]);

//Total generate logic
assign Gout = ((Cin & P[0] & P[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[2] & P[3]) | G[3]);

//Total propogate logic
assign Pout = (P[0] & P[1] & P[2] & P[3]);

//Full adders for each bit
full_adder_PGS adder0(.A(A[0]), .B(B[0]), .Cin(Cin), .P(P[0]), .G(G[0]), .S(Sum[0]));
full_adder_PGS adder1(.A(A[1]), .B(B[1]), .Cin(Cout[0]), .P(P[1]), .G(G[1]), .S(Sum[1]));
full_adder_PGS adder2(.A(A[2]), .B(B[2]), .Cin(Cout[1]), .P(P[2]), .G(G[2]), .S(Sum[2]));
full_adder_PGS adder3(.A(A[3]), .B(B[3]), .Cin(Cout[2]), .P(P[3]), .G(G[3]), .S(Sum[3]));

endmodule

