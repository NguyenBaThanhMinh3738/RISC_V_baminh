module RISCV_Single_Cycle(
    input logic clk,
    input logic rst_n,
    output logic [31:0] PC_out_top,
    output logic [31:0] Instruction_out_top
);

    // === Program Counter ===
    logic [31:0] PC_next;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            PC_out_top <= 0;
        else
            PC_out_top <= PC_next;
    end

    // === Instruction Memory (IMEM) ===
    IMEM IMEM_inst(
        .addr(PC_out_top),
        .Instruction(Instruction_out_top)
    );

    // === Decode fields from instruction ===
    logic [4:0] rs1, rs2, rd;
    logic [2:0] funct3;
    logic [6:0] opcode, funct7;

    assign opcode = Instruction_out_top[6:0];
    assign rd     = Instruction_out_top[11:7];
    assign funct3 = Instruction_out_top[14:12];
    assign rs1    = Instruction_out_top[19:15];
    assign rs2    = Instruction_out_top[24:20];
    assign funct7 = Instruction_out_top[31:25];

    // === Immediate generator ===
    logic [31:0] Imm;
    Imm_Gen imm_gen(
        .inst(Instruction_out_top),
        .imm_out(Imm)
    );

    // === Register file ===
    logic [31:0] ReadData1, ReadData2, WriteData;
    RegisterFile Reg_inst(
        .clk(clk),
        .rst_n(rst_n),
        .RegWrite(RegWrite),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // === ALU and input selection ===
    logic [31:0] ALU_in2, ALU_result;
    logic ALUZero;

    assign ALU_in2 = (ALUSrc[0]) ? Imm : ReadData2;
    ALU alu(
        .A(ReadData1),
        .B(ALU_in2),
        .ALUOp(ALUCtrl),
        .Result(ALU_result),
        .Zero(ALUZero)
    );

    // === Data Memory (DMEM) ===
    logic [31:0] MemReadData;
    DMEM DMEM_inst(
        .clk(clk),
        .rst_n(rst_n),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .addr(ALU_result),
        .WriteData(ReadData2),
        .ReadData(MemReadData)
    );

    // === Write-back mux ===
    assign WriteData = (MemToReg) ? MemReadData : ALU_result;

    // === Control unit ===
    logic [1:0] ALUSrc;
    logic [3:0] ALUCtrl;
    logic Branch, MemRead, MemWrite, MemToReg, RegWrite, PCSel;

    control_unit ctrl(
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUCtrl),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .RegWrite(RegWrite)
    );

    // === Branch comparator ===
    Branch_Comp comp(
        .A(ReadData1),
        .B(ReadData2),
        .Branch(Branch),
        .funct3(funct3),
        .BrTaken(PCSel)
    );

    // === Next PC logic ===
    assign PC_next = (PCSel) ? PC_out_top + Imm : PC_out_top + 4;

endmodule