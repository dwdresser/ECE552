module extend_16bit_tb();

reg [10:0] in;
reg [1:0] sel;
reg sign;

wire [15:0] out;


extend_16bit DUT(.in(in), .sel(sel), .sign_ext(sign), .out(out));

initial begin

	in = 11'b11111111111;
	sel = 2'b00;
	sign = 1;

	#5;
	
	in = 11'b11111111111;
	sel = 2'b01;
	sign = 0;

	#5;

	in = 11'b11111111111;
	sel = 2'b10;
	sign = 1;

	#5;

	in = 11'b10101011011;
	sel = 2'b10;
	sign = 0;

	#5;
end

endmodule
