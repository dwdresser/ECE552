module pc(in, out, clk, rst);

input clk, rst;
input [15:0] in;
output [15:0] out;

dff dff_1(.q(out[0]), .d(in[0]), .clk(clk), .rst(rst));
dff dff_2(.q(out[1]), .d(in[1]), .clk(clk), .rst(rst));
dff dff_3(.q(out[2]), .d(in[2]), .clk(clk), .rst(rst));
dff dff_4(.q(out[3]), .d(in[3]), .clk(clk), .rst(rst));
dff dff_5(.q(out[4]), .d(in[4]), .clk(clk), .rst(rst));
dff dff_6(.q(out[5]), .d(in[5]), .clk(clk), .rst(rst));
dff dff_7(.q(out[6]), .d(in[6]), .clk(clk), .rst(rst));
dff dff_8(.q(out[7]), .d(in[7]), .clk(clk), .rst(rst));
dff dff_9(.q(out[8]), .d(in[8]), .clk(clk), .rst(rst));
dff dff_10(.q(out[9]), .d(in[9]), .clk(clk), .rst(rst));
dff dff_11(.q(out[10]), .d(in[10]), .clk(clk), .rst(rst));
dff dff_12(.q(out[11]), .d(in[11]), .clk(clk), .rst(rst));
dff dff_13(.q(out[12]), .d(in[12]), .clk(clk), .rst(rst));
dff dff_14(.q(out[13]), .d(in[13]), .clk(clk), .rst(rst));
dff dff_15(.q(out[14]), .d(in[14]), .clk(clk), .rst(rst));
dff dff_16(.q(out[15]), .d(in[15]), .clk(clk), .rst(rst));

endmodule
