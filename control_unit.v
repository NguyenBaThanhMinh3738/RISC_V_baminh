module control_unit(
    input [6:0] opcode,
    output reg branch, memread, memtoreg, memwrite, alusrc, regwrite,
    output reg [1:0] aluop
);
    always @(*) begin
        branch = 0; memread = 0; memtoreg = 0; memwrite = 0; alusrc = 0; regwrite = 0; aluop = 0;
        case(opcode)
            7'b0110011: begin // R-type
                regwrite = 1; aluop = 2'b10;
            end
            7'b0000011: begin // LW
                alusrc = 1; memtoreg = 1; regwrite = 1; memread = 1; aluop = 2'b00;
            end
            7'b0100011: begin // SW
                alusrc = 1; memwrite = 1; aluop = 2'b00;
            end
            7'b1100011: begin // BEQ
                branch = 1; aluop = 2'b01;
            end
            7'b0010011: begin // I-type (ADDI)
                alusrc = 1; regwrite = 1; aluop = 2'b00;
            end
            default: ;
        endcase
    end
endmodule
