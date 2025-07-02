module RegisterFile (
    input logic clk,
    input logic RegWrite,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic [31:0] WriteData,
    output logic [31:0] ReadData1,
    output logic [31:0] ReadData2,
    input logic rst_n
);
    logic [31:0] registers [0:31];

    assign ReadData1 = (rs1 == 0) ? 0 : registers[rs1];
    assign ReadData2 = (rs2 == 0) ? 0 : registers[rs2];

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            for (int i = 0; i < 32; i++) registers[i] <= 0;
        else if (RegWrite && rd != 0)
            registers[rd] <= WriteData;
    end
endmodule