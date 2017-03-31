/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module rf_bypass (
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

	wire [15:0] read1data_tmp, read2data_tmp;
		
   // your code
	rf register_file(
          	 // Outputs
           	.read1data(read1data_tmp), .read2data(read2data_tmp), .err(err),
           	// Inputs
          	 .clk(clk), .rst(rst), .read1regsel(read1regsel), .read2regsel(read2regsel), .writeregsel(writeregsel), .writedata(writedata), .write(write)
           	);
	mux2_1 read1mux(.in1(read1data_tmp), .in2(writedata), .sel((write & (read1regsel == writeregsel))), .out(read1data));
	mux2_1 read2mux(.in1(read2data_tmp), .in2(writedata), .sel((write & (read2regsel == writeregsel))), .out(read2data));
	
endmodule
// DUMMY LINE FOR REV CONTROL :1:
