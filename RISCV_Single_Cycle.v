module RISCV_Single_Cycle(
    input clk,
    input rst_n
);
    wire [31:0] pc, Instruction_out_top, imm, rd1, rd2, alu_src2, alu_out, dmem_out, wd3, next_pc;
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire funct7_5, branch, memread, memtoreg, memwrite, alusrc, regwrite;
    wire [1:0] aluop;
    wire [3:0] alu_ctrl;
    wire br_en;

    // PC (reset âm)
    Program_Counter PC0(clk, rst_n, next_pc, pc);

    // IMEM: Instance tên IMEM_inst, xuất ra Instruction_out_top
    IMEM IMEM_inst(pc, Instruction_out_top);

    // Decode
    assign opcode   = Instruction_out_top[6:0];
    assign rd       = Instruction_out_top[11:7];
    assign funct3   = Instruction_out_top[14:12];
    assign rs1      = Instruction_out_top[19:15];
    assign rs2      = Instruction_out_top[24:20];
    assign funct7_5 = Instruction_out_top[30];

    // Regfile
    RegisterFile RF0(clk, regwrite, rs1, rs2, rd, wd3, rd1, rd2);

    // Immediate
    Imm_Gen IG0(Instruction_out_top, imm);

    // Control
    control_unit CU0(opcode, branch, memread, memtoreg, memwrite, alusrc, regwrite, aluop);

    // ALU Control
    ALU_decoder ALUDEC0(aluop, funct3, funct7_5, alu_ctrl);

    // ALU src2 mux
    assign alu_src2 = alusrc ? imm : rd2;

    // ALU
    ALU ALU0(rd1, alu_src2, alu_ctrl, alu_out);

    // Branch Comp
    Branch_Comp BC0(rd1, rd2, funct3, br_en);

    // Next PC logic
    assign next_pc = (branch && br_en) ? pc + imm : pc + 4;

    // DMEM: Instance tên DMEM_inst
    DMEM DMEM_inst(clk, alu_out, rd2, memwrite, dmem_out);

    // WB mux
    assign wd3 = memtoreg ? dmem_out : alu_out;
endmodule