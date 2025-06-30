module ALU (
    input  [31:0] A, B,
    input  [3:0] ALU_Sel,
    output reg [31:0] ALU_Out
);
    always @(*) begin
        case (ALU_Sel)
            4'b0000: ALU_Out = A + B;         // ADD
            4'b1000: ALU_Out = A - B;         // SUB
            4'b0111: ALU_Out = (A < B) ? 1 : 0; // SLT
            4'b0110: ALU_Out = (A < B) ? 1 : 0; // SLTU (giản lược, không xử lý unsigned)
            4'b0001: ALU_Out = A << B[4:0];   // SLL
            4'b0010: ALU_Out = A ^ B;         // XOR
            4'b0101: ALU_Out = A >> B[4:0];   // SRL
            4'b1101: ALU_Out = $signed(A) >>> B[4:0]; // SRA
            4'b0011: ALU_Out = A | B;         // OR
            4'b0100: ALU_Out = A & B;         // AND
            default: ALU_Out = 0;
        endcase
    end
endmodule
