module fifo_entry_64bit(clk, rst, data_in, data_out, en);

input clk;
input rst;
input [63:0] data_in;
input en;

output [63:0] data_out;

dff_16bit bit0_15(.q(data_out[15:0]), .d(data_in[15:0]), .clk(clk), .rst(rst), .en(en));
dff_16bit bit16_31(.q(data_out[31:16]), .d(data_in[31:16]), .clk(clk), .rst(rst), .en(en));
dff_16bit bit32_47(.q(data_out[47:32]), .d(data_in[47:32]), .clk(clk), .rst(rst), .en(en));
dff_16bit bit48_64(.q(data_out[63:48]), .d(data_in[63:48]), .clk(clk), .rst(rst), .en(en));

endmodule

