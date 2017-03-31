module branch_logic(type, sign, zero, out);

input [2:0] type;
input sign;
input zero;

output out;

wire jump, bgez, bltz, bnez, beqz;
	 
assign jump = (type[2] & ~type[1] & ~type[0]);
assign bgez = (~sign & ~type[2] & type[1] & type[0]);
assign bltz = (sign & ~type[2] & type[1] & ~type[0]);
assign bnez = (~zero & ~type[2] & ~type[1] & type[0]);
assign beqz = (zero & ~type[2] & ~type[1] & ~type[0]);

assign out = (jump | bgez | bltz | bnez | beqz);

endmodule 