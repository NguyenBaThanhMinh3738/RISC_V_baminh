module Program_Counter(
    input clk,
    input rst_n,                // Đúng tên cổng reset active-low
    input [31:0] next_pc,
    output reg [31:0] pc
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pc <= 0;
        else
            pc <= next_pc;
    end
endmodule