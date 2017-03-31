/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */

module sc( clk, rst, ctr_rst, out, err);
  	input clk;
   	input rst;
  	input ctr_rst;
 	output [2:0] out;
  	output err;

/*
	wire q0, q1, q2;
	wire d0, d1, d2;

	dff dff0(.q(q0), .d(d0), .clk(clk), .rst(rst));
	dff dff1(.q(q1), .d(d1), .clk(clk), .rst(rst));
	dff dff2(.q(q2), .d(d2), .clk(clk), .rst(rst));

	d0_logic d0logic(.q0(q0),.q1(q1),.q2(q2),.ctr_rst(ctr_rst),.out(d0));
	d1_logic d1logic(.q0(q0),.q1(q1),.q2(q2),.ctr_rst(ctr_rst),.out(d1));
	d2_logic d2logic(.q0(q0),.q1(q1),.q2(q2),.ctr_rst(ctr_rst),.out(d2));

	assign out = {q2,q1,q0};
*/

	wire q0, q1, q2;
	wire t0, t1, t2;
	wire d0, d1, d2;

	dff dff0(.q(t0), .d(d0), .clk(clk), .rst(rst));
	dff dff1(.q(t1), .d(d1), .clk(clk), .rst(rst));
	dff dff2(.q(t2), .d(d2), .clk(clk), .rst(rst));

	assign q0 = ~ctr_rst & t0;
        assign q1 = ~ctr_rst & t1;
	assign q2 = ~ctr_rst & t2;

	assign d0 = ((~q2&~q1&~q0) | (~q2&q1&~q0) | (q2&~q1&~q0) | (q2&~q1&q0));
	assign d1 = ((~q2&~q1&q0) | (~q2&q1&~q0));
	assign d2 = ((~q2&q1&q0) | (q2&~q1&~q0) | (q2&~q1&q0));
	
	assign out = {q2, q1, q0};

endmodule

// DUMMY LINE FOR REV CONTROL :1:
