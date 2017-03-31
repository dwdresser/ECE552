/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   
   /* your code here */
wire [15:0] alu_out;
wire [15:0] reg_data1, reg_data2;
wire [2:0] reg_wr_sel_out;
wire [15:0] reg_wr_sel_out_data;
wire [15:0] alu_in2;
wire [15:0] pc_branch_out;
wire [15:0] data_sel_out;
wire [3:0]  alu_op;
wire [1:0] imm_sel, reg_dst, alu_in2_sel, pc_sel, sel_op, reg_data1_sel;
wire [2:0] branch_type;
wire halt, mem_wr, en, branch_sel;

//initial $monitor("A %h, B %h, Cin %b, Op %b, invA %b, invB %b, sign %b, Out %h, Ofl %b, Z %b, sign_out %b, co %b", reg_data1, alu_in2, cin, alu_op, invA, invB, sign, alu_out, ofl, zero, sign_out, co);
//initial $monitor("pc + 2: %h	pc + 2 + imm: %h", pc_plus2, pc_plus_imm);
//wires coming into and out of the pc block
wire [15:0] pc_in, pc_out;

//pc block for this processor
pc pc_block(.in(pc_in),.out(pc_out), .clk(clk), .rst(rst));

//output of instruction block
wire [15:0] instr_out;

//instruction memory block
memory2c instruction_mem(.data_out(instr_out), .data_in(16'h0000), .addr(pc_out), .enable(1'b1), .wr(1'b0), .createdump(halt), .clk(clk), .rst(rst));



//output of memory block
wire [15:0] mem_out;

//Data memory block
memory2c data_mem(.data_out(mem_out), .data_in(reg_data2), .addr(alu_out), .enable(en), .wr(mem_wr), .createdump(halt), .clk(clk), .rst(rst));



//Register block outputs
//wire [15:0] reg_data1, reg_data2;

//Register file block
rf register_file(.read1data(reg_data1), .read2data(reg_data2), .err(err), .clk(clk), .rst(rst), .read1regsel(instr_out[10:8]), .read2regsel(instr_out[7:5]), .writeregsel(reg_wr_sel_out), .writedata(reg_wr_sel_out_data), .write(wr_en));


//Alu output wires
//wire [15:0] alu_out;
wire ofl, zero, sign_out, co;

//Alu block
alu alu_block(.A(reg_data1), .B(alu_in2), .Cin(alu_cin), .Op(alu_op), .invA(invA), .invB(invB), .sign(sign), .Out(alu_out), .Ofl(ofl), .Z(zero), .sign_out(sign_out), .co(co));



//Extend block output
wire [15:0] extend_imm_out;

//Extend block
extend_16bit extend_imm(.in(instr_out[10:0]), .sel(imm_sel), .sign_ext(sign_ext), .out(extend_imm_out));



//reg write select wire
//wire [3:0] reg_wr_sel_out;

//reg write select mux
quadmux_3bit reg_wr_sel(.InA(instr_out[7:5]), .InB(instr_out[4:2]), .InC(instr_out[10:8]), .InD(3'b111), .Out(reg_wr_sel_out), .S(reg_dst));



//alu input 2 wire from mux
//wire [15:0] alu_in2;

quadmux_16bit alu_in2_mux(.InA(reg_data2), .InB(extend_imm_out), .InC(16'h0008), .InD(16'h0000), .Out(alu_in2), .S(alu_in2_sel

));



//pc input select mux
quadmux_16bit pc_in_mux(.InA(alu_out), .InB(pc_branch_out), .InC(pc_out), .InD(pc_out), .Out(pc_in), .S(pc_sel));



//pc + 2 wire
wire [15:0] pc_plus2;

//useless wires
wire pout_2, pout_imm, gout_2, gout_imm;

//pc + 2 adder 
CLA_16bit pc_plus2_adder(.A(pc_out), .B(16'h0002), .Cin(1'b0), .Pout(pout_2), .Gout(gout_2), .Sum(pc_plus2));



//pc and immediate adder output
wire [15:0] pc_plus_imm;

//pc plus immediate adder block
CLA_16bit pc_plus_imm_adder(.A(pc_plus2), .B(extend_imm_out), .Cin(1'b0), .Pout(pout_imm), .Gout(gout_imm), .Sum(pc_plus_imm));


//pc branch selection
//wire [15:0] pc_branch_out;

//pc or branch select mux
twomux_16bit pc_branch_sel(.InA(pc_plus2), .InB(pc_plus_imm), .S(branch_sel), .Out(pc_branch_out));



//set operation output
wire set_op_out;

//set operation mux output
mux4_1 set_ops(.InA(co), .InB(zero | sign_out), .InC(sign_out), .InD(zero), .Out(set_op_out), .S(sel_op));

//final reg data 
quadmux_16bit final_reg_wr_data(.InA(data_sel_out), .InB(pc_plus2), .InC({15'b000000000000000,set_op_out}), .InD(data_sel_out | extend_imm_out), .Out(reg_wr_sel_out_data), .S(reg_data1_sel));



//wire picking mem data or alu output
//wire [15:0] data_sel_out;

//mux choosing between memory data or alu output 
twomux_16bit reg_in_sel(.InA(alu_out), .InB(mem_out), .S(mem_or_alu), .Out(data_sel_out));



//Control block
control control_block(.in1(instr_out[15:11]), .in2(instr_out[1:0]), .reg_dst(reg_dst), .wr_en(wr_en), .reg_data1(reg_data1_sel), .branch_type(branch_type), .halt(halt), 
	.mem_wr(mem_wr), .sign_ext(sign_ext), .imm_sel(imm_sel), .alu_in2(alu_in2_sel), .alu_op(alu_op), .sel_op(sel_op), .invA(invA), .invB(invB), .pc_sel(pc_sel), .en(en), .alu_cin(alu_cin), .sign(sign), .mem_or_alu(mem_or_alu));

branch_logic branch_logic_block(.type(branch_type), .sign(sign_out), .zero(zero), .out(branch_sel));
   
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
