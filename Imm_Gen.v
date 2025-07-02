module Imm_Gen (
    input  logic [31:0] inst,
    output logic [31:0] imm_out
);
    wire [6:0] opcode = inst[6:0];
    wire [11:0] imm_i = inst[31:20];
    wire [6:0] imm_s_hi = inst[31:25];
    wire [4:0] imm_s_lo = inst[11:7];
    wire [19:0] imm_u = inst[31:12];

    wire [12:0] imm_b_cat = {inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
    wire [20:0] imm_j_cat = {inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};

    always @(*) begin
        case (opcode)
            7'b0000011, // I-type
            7'b0010011,
            7'b1100111: imm_out = {{20{imm_i[11]}}, imm_i};

            7'b0100011: imm_out = {{20{imm_s_hi[6]}}, imm_s_hi, imm_s_lo};

            7'b1100011: imm_out = {{19{imm_b_cat[12]}}, imm_b_cat};

            7'b0010111, // auipc
            7'b0110111: imm_out = {imm_u, 12'b0};

            7'b1101111: imm_out = {{11{imm_j_cat[20]}}, imm_j_cat};

            default: imm_out = 32'b0;
        endcase
    end
endmodule