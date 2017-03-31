module dff_16bit(d, q, clk, rst, en);

input [15:0] d;
input en;
input clk;
input rst;

output [15:0] q;

dff bit0(.q(q[0]), .d((d[0] & en) | (q[0] & ~en)), .clk(clk), .rst(rst));
dff bit1(.q(q[1]), .d((d[1] & en) | (q[1] & ~en)), .clk(clk), .rst(rst));
dff bit2(.q(q[2]), .d((d[2] & en) | (q[2] & ~en)), .clk(clk), .rst(rst));
dff bit3(.q(q[3]), .d((d[3] & en) | (q[3] & ~en)), .clk(clk), .rst(rst));
dff bit4(.q(q[4]), .d((d[4] & en) | (q[4] & ~en)), .clk(clk), .rst(rst));
dff bit5(.q(q[5]), .d((d[5] & en) | (q[5] & ~en)), .clk(clk), .rst(rst));
dff bit6(.q(q[6]), .d((d[6] & en) | (q[6] & ~en)), .clk(clk), .rst(rst));
dff bit7(.q(q[7]), .d((d[7] & en) | (q[7] & ~en)), .clk(clk), .rst(rst));
dff bit8(.q(q[8]), .d((d[8] & en) | (q[8] & ~en)), .clk(clk), .rst(rst));
dff bit9(.q(q[9]), .d((d[9] & en) | (q[9] & ~en)), .clk(clk), .rst(rst));
dff bit10(.q(q[10]), .d((d[10] & en) | (q[10] & ~en)), .clk(clk), .rst(rst));
dff bit11(.q(q[11]), .d((d[11] & en) | (q[11] & ~en)), .clk(clk), .rst(rst));
dff bit12(.q(q[12]), .d((d[12] & en) | (q[12] & ~en)), .clk(clk), .rst(rst));
dff bit13(.q(q[13]), .d((d[13] & en) | (q[13] & ~en)), .clk(clk), .rst(rst));
dff bit14(.q(q[14]), .d((d[14] & en) | (q[14] & ~en)), .clk(clk), .rst(rst));
dff bit15(.q(q[15]), .d((d[15] & en) | (q[15] & ~en)), .clk(clk), .rst(rst));

endmodule
