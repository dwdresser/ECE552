module d2_logic(q0,q1,q2,ctr_rst,out);

input q0, q1, q2, ctr_rst;

output out;

assign out = ~ctr_rst & ((~q2&q1&q0) | (q2&~q1&~q0) | (q2&~q1&q0));

endmodule
