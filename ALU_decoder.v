module ALU_decoder (
    input [1:0] ALUOp,
    input [2:0] funct3,
    input funct7_5,
    output reg [3:0] ALU_Ctrl
);
    always @(*) begin
        case (ALUOp)
            2'b00: ALU_Ctrl = 4'b0000; // lw/sw/addi/add
            2'b01: ALU_Ctrl = 4'b1000; // beq (sub)
            2'b10: begin
                case (funct3)
                    3'b000: ALU_Ctrl = funct7_5 ? 4'b1000 : 4'b0000; // SUB/ADD
                    3'b111: ALU_Ctrl = 4'b0100; // AND
                    3'b110: ALU_Ctrl = 4'b0011; // OR
                    3'b001: ALU_Ctrl = 4'b0001; // SLL
                    3'b010: ALU_Ctrl = 4'b0111; // SLT
                    3'b011: ALU_Ctrl = 4'b0110; // SLTU
                    3'b100: ALU_Ctrl = 4'b0010; // XOR
                    3'b101: ALU_Ctrl = funct7_5 ? 4'b1101 : 4'b0101; // SRA/SRL
                    default: ALU_Ctrl = 4'b0000;
                endcase
            end
            default: ALU_Ctrl = 4'b0000;
        endcase
    end
endmodule
