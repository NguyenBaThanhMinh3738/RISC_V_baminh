module Branch_Comp(
    input [31:0] A, B,
    input [2:0] funct3,
    output reg br_out
);
    always @(*) begin
        case(funct3)
            3'b000: br_out = (A == B); // BEQ
            3'b001: br_out = (A != B); // BNE
            3'b100: br_out = ($signed(A) < $signed(B)); // BLT
            3'b101: br_out = ($signed(A) >= $signed(B)); // BGE
            3'b110: br_out = (A < B); // BLTU
            3'b111: br_out = (A >= B); // BGEU
            default: br_out = 0;
        endcase
    end
endmodule
