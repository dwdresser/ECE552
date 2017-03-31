module full_adder_PGS(A, B, Cin, P, G, S);

//add A and B with a carry in Cin
input A, B, Cin;

//Propogate, Generate, Sum
output P, G, S;

//Addition logic for propogate, generate, and sum
assign P = ((Cin & A) | (Cin & B));
assign G = (A & B);
assign S = ((A ^ B) ^ Cin);

endmodule

