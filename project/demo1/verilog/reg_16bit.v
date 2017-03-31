module reg_16bit(in, out, rst, clk, wr);

input [15:0] in;
input rst, clk, wr;

output [15:0] out;

dff bit0(.q(out[0]), .d((in[0] & wr) | (out[0] & ~wr)), .clk(clk), .rst(rst));
dff bit1(.q(out[1]), .d((in[1] & wr) | (out[1] & ~wr)), .clk(clk), .rst(rst));
dff bit2(.q(out[2]), .d((in[2] & wr) | (out[2] & ~wr)), .clk(clk), .rst(rst));
dff bit3(.q(out[3]), .d((in[3] & wr) | (out[3] & ~wr)), .clk(clk), .rst(rst));

dff bit4(.q(out[4]), .d((in[4] & wr) | (out[4] & ~wr)), .clk(clk), .rst(rst));
dff bit5(.q(out[5]), .d((in[5] & wr) | (out[5] & ~wr)), .clk(clk), .rst(rst));
dff bit6(.q(out[6]), .d((in[6] & wr) | (out[6] & ~wr)), .clk(clk), .rst(rst));
dff bit7(.q(out[7]), .d((in[7] & wr) | (out[7] & ~wr)), .clk(clk), .rst(rst));

dff bit8(.q(out[8]), .d((in[8] & wr) | (out[8] & ~wr)), .clk(clk), .rst(rst));
dff bit9(.q(out[9]), .d((in[9] & wr) | (out[9] & ~wr)), .clk(clk), .rst(rst));
dff bit10(.q(out[10]), .d((in[10] & wr) | (out[10] & ~wr)), .clk(clk), .rst(rst));
dff bit11(.q(out[11]), .d((in[11] & wr) | (out[11] & ~wr)), .clk(clk), .rst(rst));

dff bit12(.q(out[12]), .d((in[12] & wr) | (out[12] & ~wr)), .clk(clk), .rst(rst));
dff bit13(.q(out[13]), .d((in[13] & wr) | (out[13] & ~wr)), .clk(clk), .rst(rst));
dff bit14(.q(out[14]), .d((in[14] & wr) | (out[14] & ~wr)), .clk(clk), .rst(rst));
dff bit15(.q(out[15]), .d((in[15] & wr) | (out[15] & ~wr)), .clk(clk), .rst(rst));

endmodule
