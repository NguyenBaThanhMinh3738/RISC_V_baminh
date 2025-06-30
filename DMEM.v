module DMEM(
    input clk,
    input [31:0] addr,
    input [31:0] din,
    input we,
    output [31:0] dout
);
    reg [31:0] memory [0:255];
    assign dout = memory[addr[9:2]]; // 32-bit word addressing

    initial begin
        $readmemh("mem/dmem_init.hex", memory);
    end

    always @(posedge clk) begin
        if (we)
            memory[addr[9:2]] <= din;
    end
endmodule