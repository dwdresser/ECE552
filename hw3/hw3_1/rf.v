/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module rf (
          	 // Outputs
           	read1data, read2data, err,
           	// Inputs
          	 clk, rst, read1regsel, read2regsel, writeregsel, writedata, write
           	);
   	input clk, rst;
   	input [2:0] read1regsel;
  	input [2:0] read2regsel;
  	input [2:0] writeregsel;
   	input [15:0] writedata;
   	input        write;

   	output [15:0] read1data;
   	output [15:0] read2data;
  	output        err;

   	// your code

	wire [7:0] write_reg;

	wire [15:0] reg0_out, reg1_out, reg2_out, reg3_out, reg4_out, reg5_out, reg6_out, reg7_out;

	decoder decode1(.in(writeregsel), .out(write_reg));
	
	reg_16bit reg0(.in(writedata), .out(reg0_out), .rst(rst), .clk(clk), .wr(write_reg[0] & write));
	reg_16bit reg1(.in(writedata), .out(reg1_out), .rst(rst), .clk(clk), .wr(write_reg[1] & write));
	reg_16bit reg2(.in(writedata), .out(reg2_out), .rst(rst), .clk(clk), .wr(write_reg[2] & write));
	reg_16bit reg3(.in(writedata), .out(reg3_out), .rst(rst), .clk(clk), .wr(write_reg[3] & write));
	reg_16bit reg4(.in(writedata), .out(reg4_out), .rst(rst), .clk(clk), .wr(write_reg[4] & write));
	reg_16bit reg5(.in(writedata), .out(reg5_out), .rst(rst), .clk(clk), .wr(write_reg[5] & write));
	reg_16bit reg6(.in(writedata), .out(reg6_out), .rst(rst), .clk(clk), .wr(write_reg[6] & write));
	reg_16bit reg7(.in(writedata), .out(reg7_out), .rst(rst), .clk(clk), .wr(write_reg[7] & write));

	//assign read1data = reg5_out;
	
	regmux data1(.in0(reg0_out), .in1(reg1_out), .in2(reg2_out), .in3(reg3_out), .in4(reg4_out), .in5(reg5_out), .in6(reg6_out), .in7(reg7_out), .sel(read1regsel), .out(read1data));
	regmux data2(.in0(reg0_out), .in1(reg1_out), .in2(reg2_out), .in3(reg3_out), .in4(reg4_out), .in5(reg5_out), .in6(reg6_out), .in7(reg7_out), .sel(read2regsel), .out(read2data));


endmodule
// DUMMY LINE FOR REV CONTROL :1:
