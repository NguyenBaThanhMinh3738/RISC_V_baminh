module IMEM(
    input [31:0] addr,
    output [31:0] dout
);
    reg [31:0] rom [0:255];
    assign dout = rom[addr[9:2]];

    initial begin
        $readmemh("mem/imem.hex", rom);
    end
endmodule
