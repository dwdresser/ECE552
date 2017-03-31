/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc_hier_bench();

   /* BEGIN DO NOT TOUCH */
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   // End of automatics
   

   wire [15:0] PC;
   wire [15:0] Inst;           /* This should be the 15 bits of the FF that
                                  stores instructions fetched from instruction memory
                               */
   wire        RegWrite;       /* Whether register file is being written to */
   wire [2:0]  WriteRegister;  /* What register is written */
   wire [15:0] WriteData;      /* Data */
   wire        MemWrite;       /* Similar as above but for memory */
   wire        MemRead;
   wire [15:0] MemAddress;
   wire [15:0] MemData;
   wire [15:0] alu_out, mux_out, alu_in1, alu_in2, jump_in1, jump_in2, jump_add_out, imm_extended_outi, imm_in;
   wire        Halt;         /* Halt executed and in Memory or writeback stage */
        
   integer     inst_count;
   integer     trace_file;
   integer     sim_log_file;
     

   proc_hier DUT();
   

   initial begin
      $display("Hello world...simulation starting");
      $display("See verilogsim.log and verilogsim.trace for output");
      inst_count = 0;
      trace_file = $fopen("verilogsim.trace");
      sim_log_file = $fopen("verilogsim.log");
      
   end

   always @ (posedge DUT.c0.clk) begin
      if (!DUT.c0.rst) begin
         if (Halt || RegWrite || MemWrite) begin
            inst_count = inst_count + 1;
         end
         $fdisplay(sim_log_file, "SIMLOG:: Cycle %d PC: %8x I: %8x R: %d %3d %8x M: %d %d %8x %8x",
                  DUT.c0.cycle_count,
                  PC,
                  Inst,
                  RegWrite,
                  WriteRegister,
                  WriteData,
                  MemRead,
                  MemWrite,
                  MemAddress,
                  MemData);
         if (RegWrite) begin
            if (MemWrite) begin
               // stu
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x ADDR: 0x%04x VALUE: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData,
                        MemAddress,
                        MemData);
            end else if (MemRead) begin
               // ld
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x ADDR: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData,
                        MemAddress);
            end else begin
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x REG: %d VALUE: 0x%04x",
                         (inst_count-1),
                        PC,
                        WriteRegister,
                        WriteData );
            end
         end else if (Halt) begin
	    //$display("BRUH WE END THIS YET");
            $fdisplay(sim_log_file, "SIMLOG:: Processor halted\n");
            $fdisplay(sim_log_file, "SIMLOG:: sim_cycles %d\n", DUT.c0.cycle_count);
            $fdisplay(sim_log_file, "SIMLOG:: inst_count %d\n", inst_count);
            $fdisplay(trace_file, "INUM: %8d PC: 0x%04x",
                      (inst_count-1),
                      PC );

            $fclose(trace_file);
            $fclose(sim_log_file);
            
            $finish;
         end else begin // if (RegWrite)
            if (MemWrite) begin
               // st
               $fdisplay(trace_file,"INUM: %8d PC: 0x%04x ADDR: 0x%04x VALUE: 0x%04x",
                         (inst_count-1),
                        PC,
                        MemAddress,
                        MemData );
            end else begin
               // conditional branch or NOP
               // Need better checking in pipelined testbench
               inst_count = inst_count + 1;
               $fdisplay(trace_file, "INUM: %8d PC: 0x%04x",
                         (inst_count-1),
                         PC );
            end
         end 
      end
      
   end

   /* END DO NOT TOUCH */

   /* Assign internal signals to top level wires
      The internal module names and signal names will vary depending
      on your naming convention and your design */

   // Edit the example below. You must change the signal
   // names on the right hand side
    
//O: %b SIGN_OUT: %b CO: %b, BRANCH_SEL: %b JUMP_IN1: 0x%h JUMP_IN2: 0x%h JUMP_ADD_OUT: 0x%h, IMM_EXT: 0x%h, IMM_IN: %b
   assign PC = DUT.p0.pc_out;
   assign Inst = DUT.p0.instr_out;
   
   assign RegWrite = DUT.p0.register_file.write;
   // Is register being written, one bit signal (1 means yes, 0 means no)
   
   assign WriteRegister = DUT.p0.register_file.writeregsel;
   // The name of the register being written to. (3 bit signal)

   assign WriteData = DUT.p0.register_file.writedata;
   // Data being written to the register. (16 bits)
   
   assign MemRead =  DUT.p0.mem_or_alu;
   // Is memory being read, one bit signal (1 means yes, 0 means no)
   
   assign MemWrite = DUT.p0.data_mem.wr;
   // Is memory being written to (1 bit signal)
   
   assign MemAddress = DUT.p0.data_mem.addr;
   // Address to access memory with (for both reads and writes to memory, 16 bits)
   
   assign MemData = DUT.p0.data_mem.data_in;
   // Data to be written to memory for memory writes (16 bits)
   
   assign Halt = DUT.p0.halt;
   // Is processor halted (1 bit signal)
   
   /* Add anything else you want here */
   assign alu_out = DUT.p0.alu_block.Out;
   assign mux_out = DUT.p0.reg_in_sel.Out;
   assign alu_in1 = DUT.p0.alu_block.A;
   assign alu_in2 = DUT.p0.alu_block.B;
   assign zero = DUT.p0.alu_block.Z;
   assign sign_out = DUT.p0.alu_block.sign_out;
   assign co = DUT.p0.alu_block.co;
   assign branch_sel = DUT.p0.branch_logic_block.out;
   assign jump_add_out = DUT.p0.pc_plus_imm_adder.Sum;
   assign jump_in1 = DUT.p0.pc_plus_imm_adder.A;
   assign jump_in2 = DUT.p0.pc_plus_imm_adder.B;
   assign imm_extended_out = DUT.p0.extend_imm_out;
   assign imm_in = DUT.p0.instr_out[10:0];
   
endmodule

// DUMMY LINE FOR REV CONTROL :0:
