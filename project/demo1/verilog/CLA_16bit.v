module CLA_16bit(A, B, Cin, Pout, Gout, Sum);

input [15:0] A;
input [15:0] B;
input Cin;

output Pout;
output Gout;
output [15:0] Sum;

wire [3:0] P;
wire [3:0] G;
wire [2:0] Cout;

//Carry logic into CLA 1
assign Cout[0] = ((Cin & P[0]) | G[0]);

//Carry logic into CLA 2
assign Cout[1] = ((Cin & P[0] & P[1]) | (G[0] & P[1]) | G[1]);

//Carry logic into CLA 3
assign Cout[2] = ((Cin & P[0] & P[1] & P[2]) | (G[0] & P[1] & P[2]) | (G[1] & P[2]) | G[2]);

//Total generate logic
assign Gout = ((Cin & P[0] & P[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[2] & P[3]) | G[3]);

//Total propogate logic
assign Pout = (P[0] & P[1] & P[2] & P[3]);

//4 bit carry look ahead adders for 16 bits total
CLA_4bit adder0(.A(A[3:0]), .B(B[3:0]), .Cin(Cin), .Pout(P[0]), .Gout(G[0]), .Sum(Sum[3:0]));
CLA_4bit adder1(.A(A[7:4]), .B(B[7:4]), .Cin(Cout[0]), .Pout(P[1]), .Gout(G[1]), .Sum(Sum[7:4]));
CLA_4bit adder2(.A(A[11:8]), .B(B[11:8]), .Cin(Cout[1]), .Pout(P[2]), .Gout(G[2]), .Sum(Sum[11:8]));
CLA_4bit adder3(.A(A[15:12]), .B(B[15:12]), .Cin(Cout[2]), .Pout(P[3]), .Gout(G[3]), .Sum(Sum[15:12]));

endmodule
