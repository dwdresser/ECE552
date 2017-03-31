module control(in1, in2, reg_dst, wr_en, reg_data1, branch_type, halt, mem_wr, sign_ext, imm_sel, alu_in2, alu_op, sel_op, invA, invB, pc_sel, en, alu_cin, sign, mem_or_alu);

input [15:11] in1;
input [1:0] in2;

output reg wr_en, halt, mem_wr, sign_ext, invA, invB, en, alu_cin, sign, mem_or_alu;
output reg [3:0] alu_op;                         
output reg [2:0] branch_type;
output reg [1:0] imm_sel, pc_sel, reg_data1, alu_in2, reg_dst, sel_op;

/*
initial begin
	 //$monitor("opcode %b, reg_dst %b, wr_en %b, reg_data1 %b, branch_type %b, halt %b, mem_wr %b, sign_ext %b, imm_sel %b, alu_in2 %b, alu_op %b, sel_op %b, invA %b, invB %b, en %b, pc_sel %b, alu_cin %b, sign %b, mem_or_alu %b",in1, reg_dst, wr_en, reg_data1, branch_type, halt, mem_wr, sign_ext, imm_sel, alu_in2, alu_op, sel_op, invA, invB, en, pc_sel, alu_cin, sign, mem_or_alu); 
	en = 1'b1;
	reg_dst =       2'b00;
        wr_en =         1'b0;
        reg_data1 =     2'b00;
        branch_type =   3'b111;
        halt =          1'b0;
        mem_wr =        1'b0;
        sign_ext =      1'b0;
        imm_sel =       2'b00;
        alu_in2 =       2'b00;
        alu_op =        4'b0000;
        sel_op =        2'b00;
        invA =          1'b0;
        invB =          1'b0;
        en =            1'b1;
        pc_sel =        2'b01;
        alu_cin =       1'b0;
        sign =          1'b0;
        mem_or_alu =    1'b0;

	
end
*/
always @(in1 or in2) begin

	case(in1)
		//HALT
		5'b0000 : begin
				//Control Logic
				reg_dst = 	2'b00;
				wr_en = 	1'b0;
				reg_data1 = 	2'b00;
				branch_type = 	3'b000;
				halt = 		1'b1;
				mem_wr = 	1'b0;
				sign_ext = 	1'b0;	
				imm_sel = 	2'b00;
				alu_in2 = 	2'b00;
				alu_op = 	4'b0000;
				sel_op = 	2'b00;
				invA = 		1'b0;
				invB = 		1'b0;
				en = 		1'b0;
				pc_sel = 	2'b10;
				alu_cin = 	1'b0;
				sign = 		1'b0;
				mem_or_alu = 	1'b0;
		end
		//NOP
		5'b0001 : begin
				//Control Logic
				reg_dst = 	2'b00;
				wr_en = 	1'b0;
				reg_data1 = 	2'b00;
				branch_type = 	3'b111;
				halt = 		1'b0;
				mem_wr = 	1'b0;
				sign_ext = 	1'b0;	
				imm_sel = 	2'b00;
				alu_in2 = 	2'b00;
				alu_op = 	4'b0000;
				sel_op = 	2'b00;
				invA = 		1'b0;
				invB = 		1'b0;
				en = 		1'b0;
				pc_sel = 	2'b01;
				alu_cin = 	1'b0;
				sign = 		1'b0;
				mem_or_alu = 	1'b0;

		end
		//ADDI
		5'b01000 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b1;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//SUBI
		5'b01001 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b1;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b1;	//Carry in bit to the alu
				sign = 		1'b1;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//XORI
		5'b01010 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b0;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0010;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//ANDNI
		5'b01011 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b0;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0011;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b1;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?'
				mem_or_alu = 	1'b0;
		end
		//ROLI
		5'b10100 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b0;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0100;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//SLLI
		5'b10101 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b0;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0101;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//RORI
		5'b10110 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b0;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0110;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//SRLI
		5'b10111 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b0;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0111;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//ST
		5'b10000 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b0;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b1;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b1;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b1;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//LD
		5'b10001 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b1;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b1;	//Is the alu operation signed?
				mem_or_alu = 	1'b1;
		end
		//STU
		5'b10011 : begin
				//Control Logic
				reg_dst = 	2'b10; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b1;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b1;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b1;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//BTR
		5'b11001 : begin
				//Control Logic
				reg_dst = 	2'b01; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b0;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b00;	//Selects second input to the ALU
				alu_op = 	4'b1000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//ADD, SUB, XOR, ANDN
		5'b11011 : begin
				//Control Logic
				//$display("adding");
				reg_dst = 	2'b01; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b0;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b00;	//Selects second input to the ALU
				alu_op = 	{2'b00,in2};//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		(~in2[1] & in2[0]);	//Inverts A to ALU
				invB = 		(in2[1] & in2[0]);	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	(~in2[1] & in2[0]);	//Carry in bit to the alu
				sign = 		1'b1;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//ROL, SLL, ROR, SRL
		5'b11010 : begin
				//Control Logic
				reg_dst = 	2'b01; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b0;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b00;	//Selects second input to the ALU
				alu_op = 	{2'b01,in2};//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//SEQ
		5'b11100 : begin
				//Control Logic
				reg_dst = 	2'b01; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b10;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b00;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b11;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b1;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//SLT
		5'b11101 : begin
				//Control Logic
				reg_dst = 	2'b01; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b10;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b00;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b10;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b1;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b1;	//Carry in bit to the alu
				sign = 		1'b1;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//SLE
		5'b11110 : begin
				//Control Logic
				reg_dst = 	2'b01; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b10;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b00;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b01;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b1;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b1;	//Carry in bit to the alu
				sign = 		1'b1;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//SCO
		5'b11111 : begin
				//Control Logic
				reg_dst = 	2'b01; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b10;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b0;	//0 or sign extend
				imm_sel = 	2'b00;	//Number of bits extended
				alu_in2 = 	2'b00;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b1;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//BEQZ
		5'b01100 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b0;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b000;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b01;	//Number of bits extended
				alu_in2 = 	2'b11;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//BNEZ
		5'b01101 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b0;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b001;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b01;	//Number of bits extended
				alu_in2 = 	2'b11;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//BLTZ
		5'b01110 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b0;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b010;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b01;	//Number of bits extended
				alu_in2 = 	2'b11;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b1;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b1;	//Carry in bit to the alu
				sign = 		1'b1;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//BGEZ
		5'b01111 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b0;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b011;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b01;	//Number of bits extended
				alu_in2 = 	2'b11;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b1;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b1;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//LBI
		5'b11000 : begin
				//Control Logic
				reg_dst = 	2'b10; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b01;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b1001;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//SLBI
		5'b10010 : begin
				//Control Logic
				reg_dst = 	2'b10; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b11;	//Extra logic after ALU
				branch_type = 	3'b111;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b0;	//0 or sign extend
				imm_sel = 	2'b01;	//Number of bits extended
				alu_in2 = 	2'b10;	//Selects second input to the ALU
				alu_op = 	4'b0101;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//J
		5'b00100 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b0;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b100;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b10;	//Number of bits extended
				alu_in2 = 	2'b00;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//JR
		5'b00101 : begin
				//Control Logic
				reg_dst = 	2'b00; 	//Denotes what bits are the destination register
				wr_en = 	1'b0;	//Write to register?
				reg_data1 = 	2'b00;	//Extra logic after ALU
				branch_type = 	3'b100;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b01;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b00;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//JAL
		5'b00110 : begin
				//Control Logic
				reg_dst = 	2'b11; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b01;	//Extra logic after ALU
				branch_type = 	3'b100;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b10;	//Number of bits extended
				alu_in2 = 	2'b00;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b01;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
		//JALR
		5'b00111 : begin
				//Control Logic
				reg_dst = 	2'b11; 	//Denotes what bits are the destination register
				wr_en = 	1'b1;	//Write to register?
				reg_data1 = 	2'b01;	//Extra logic after ALU
				branch_type = 	3'b100;	//Branch logic
				halt = 		1'b0;	//Are we dumping file?
				mem_wr = 	1'b0;	//Write to memory
				sign_ext = 	1'b1;	//0 or sign extend
				imm_sel = 	2'b01;	//Number of bits extended
				alu_in2 = 	2'b01;	//Selects second input to the ALU
				alu_op = 	4'b0000;//ALU operation
				sel_op = 	2'b00;	//Controls boolean set instructions
				invA = 		1'b0;	//Inverts A to ALU
				invB = 		1'b0;	//Inverts B to ALU
				en = 		1'b0;	//enables reading from memory blocks
				pc_sel = 	2'b00;	//selects what goes into PC counter
				alu_cin = 	1'b0;	//Carry in bit to the alu
				sign = 		1'b0;	//Is the alu operation signed?
				mem_or_alu = 	1'b0;
		end
	endcase
end

endmodule
		
