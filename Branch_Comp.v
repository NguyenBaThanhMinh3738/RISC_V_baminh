module Branch_Comp (
    input  logic [31:0] A,
    input  logic [31:0] B,
    input  logic Branch,
    input  logic [2:0] funct3,
    output logic BrTaken
);
    logic compare_result;
    always @(*) begin
        compare_result = 1'b0;
        case (funct3)
            3'b000: compare_result = (A == B);                     // beq
            3'b001: compare_result = (A != B);                     // bne
            3'b100: compare_result = ($signed(A) < $signed(B));    // blt
            3'b101: compare_result = ($signed(A) >= $signed(B));   // bge
            3'b110: compare_result = (A < B);                      // bltu
            3'b111: compare_result = (A >= B);                     // bgeu
            default: compare_result = 1'b0;
        endcase
        BrTaken = Branch ? compare_result : 1'b0;
    end
endmodule