module DMEM(
    input clk,
    input [31:0] addr,
    input [31:0] din,
    input we,
    output [31:0] dout
);
    reg [31:0] mem [0:255];
    assign dout = mem[addr[9:2]]; // 32-bit word addressing

    initial begin
        $readmemh("mem/dmem_init.hex", mem);
    end

    always @(posedge clk) begin
        if (we)
            mem[addr[9:2]] <= din;
    end
endmodule
